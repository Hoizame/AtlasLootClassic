local _G = getfenv(0)
local LibStub = _G.LibStub

local ALDB_MAJOR, ALDB_MINOR = "ALDB-1.0", 1
local ALDB, oldminor = LibStub:NewLibrary(ALDB_MAJOR, ALDB_MINOR)
-- I only use this in AtlasLoot at this time. The overload with newer version isnt tested..
if not ALDB then return end -- No upgrade needed

ALDB.register = ALDB.register or {}
ALDB.frame = ALDB.frame or CreateFrame("FRAME")

local EMPTY_TABLE = {}

local DbDefaultsFunctions = {
	-- true is default
	UseBase = function(defaults, val)
	
	end,
}
local DbDefaults_mt = { __index = DbDefaultsFunctions }

local function mergeBaseAndSec(db, savedBase, savedSec)
	savedBase = savedBase or EMPTY_TABLE
	savedSec = savedSec or EMPTY_TABLE
	for k,v in pairs(savedBase) do
		if type(v) == "table" then
			db[k] = {}
			mergeBaseAndSec(db[k], v, savedSec[k])
		else
			if savedBase.__useSec then
				rawset(db, k, savedSec[k] or v)
			else
				rawset(db, k, v)
			end
		end
	end
end

local function copyDefaultsWithSec(db, savedBase, savedSec, defaults)
	savedBase = savedBase or EMPTY_TABLE
	savedSec = savedSec or EMPTY_TABLE
	db.__useSec = savedBase.__useSec
	db.__defaults = setmetatable(defaults, DbDefaults_mt)
	for k,v in pairs(defaults) do
		if k == "*" then
			if type(v) == "table" then
				local mt = {
					__index = function(t, key)
						if key == nil then return end
						local tab = {__template = v}
						copyDefaultsWithSec(tab, nil, nil, v)
						rawset(t, key, tab)
						return tab
					end,
				}
				setmetatable(db, mt)
				-- existing tables...
				for k2, v2 in pairs(savedBase) do
					if not rawget(defaults, k2) and type(v2) == "table" then
						if not rawget(db, k2) then rawset(db, k2, {}) end
						copyDefaultsWithSec(db[k2], v2, savedSec[k2], v)
					end
				end
			else
				local mt = { __index = function(t,k) return k~=nil and v or nil end }
				setmetatable(db, mt)
			end
		elseif type(v) == "table" then
			if not rawget(db, k) then rawset(db, k, {}) end
			copyDefaultsWithSec(db[k], savedBase[k], savedSec[k], v)
		else
			if rawget(db, k) == nil then
				if savedBase.__useSec then
					rawset(db, k, savedSec[k] or v)
				else
					rawset(db, k, savedBase[k] or v)
				end
			end
		end
	end
end

local function writeDefaults(db, savedBase, savedSec, defaults)
	savedBase = savedBase or EMPTY_TABLE
	savedSec = savedSec or EMPTY_TABLE
	setmetatable(db, nil)
	defaults = ( db.__defaults or defaults ) or EMPTY_TABLE
	for k,v in pairs(db) do
		if k ~= "__defaults" then
			if type(v) == "table" then
				savedBase[k] = {}
				savedSec[k] = {}
				writeDefaults(v, savedBase[k], savedSec[k], defaults[k])
				-- remove empty tables from saved variables
				if next(savedBase[k]) == nil then
					savedBase[k] = nil
				end
				if next(savedSec[k]) == nil then
					savedSec[k] = nil
				end
			else
				local setTab = db.__useSec and savedSec or savedBase
				if defaults[k] ~= v then
					setTab[k] = v
				end
			end
		end
	end
end

local function Frame_OnEvent(self, event)
	if event == "PLAYER_LOGOUT" then
		for k,v in pairs(ALDB.register) do
			ALDB:SetDefaults(k, nil)
		end
	end
end

ALDB.frame:RegisterEvent("PLAYER_LOGOUT")
ALDB.frame:SetScript("OnEvent", Frame_OnEvent)

function ALDB:SetDefaults(db, defaults)
	local register = ALDB.register[db]
	if not register then return end
	if register.defaults then
		wipe(register.savedVariablesBase)
		wipe(register.savedVariablesSec)
		writeDefaults(db, register.savedVariablesBase, register.savedVariablesSec, register.defaults)
		wipe(db)
	end
	
	register.defaults = defaults
	
	if defaults then
		mergeBaseAndSec(db, register.savedVariablesBase, register.savedVariablesSec)
		copyDefaultsWithSec(db, register.savedVariablesBase, register.savedVariablesSec, defaults)
	end
end

-- example
-- savedVariablesBase		=	## SavedVariablesPerCharacter: AtlasLootCharDB
-- savedVariablesSec		=	## SavedVariables: AtlasLootDB
-- defaults					=	{}
function ALDB:Register(savedVariablesBase, savedVariablesSec, defaults)
	local db = {}

	ALDB.register[db] = {
		savedVariablesBase = savedVariablesBase,
		savedVariablesSec = savedVariablesSec,
	}
	
	ALDB:SetDefaults(db, defaults)
	
	return db
end

-- update existing
for k,v in pairs(ALDB.register) do
	if k then
		ALDB:SetDefaults(k, v.defaults)
	end
end
