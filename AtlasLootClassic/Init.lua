-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local tonumber = _G.tonumber
local ipairs = _G.ipairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...

local addonVersion = GetAddOnMetadata(addonname, "Version")
if addonVersion == string.format("@%s@", "project-version") then addonVersion = "v99.99.9999-dev" end
local versionT = { string.match(addonVersion, "v(%d+)%.(%d+)%.(%d+)%-?(%a*)(%d*)") }
local addonRevision = ""
for k,v in ipairs(versionT) do
	if k < 4 then
		local it = k == 3 and (4 - #v) or (2 - #v)
		for i = 1, it do
			versionT[k] = "0"..versionT[k]
		end
		addonRevision = addonRevision..versionT[k]
	end
end

_G.AtlasLoot = {
	__addonrevision = tonumber(addonRevision),
	__addonversion = versionT[4] == "dev" and "dev-"..(GetServerTime() or 0) or addonVersion,
	IsDevVersion = versionT[4] == "dev" and true or nil,
	IsTestVersion = (versionT[4] == "beta" or versionT[4] == "alpha") and true or nil,
}

local AddonNameVersion = string.format("%s-%d", addonname, _G.AtlasLoot.__addonrevision)
local MainMT = {
	__tostring = function(self)
		return AddonNameVersion
	end,
}
setmetatable(_G.AtlasLoot, MainMT)

-- DB
AtlasLootClassicDB = {}

-- Translations
_G.AtlasLoot.Locale = {}

-- Init functions
_G.AtlasLoot.Init = {}

-- Data table
_G.AtlasLoot.Data = {}

-- Version
local WOW_PROJECT_ID = _G.WOW_PROJECT_ID or 99
local WOW_PROJECT_MAINLINE = _G.WOW_PROJECT_MAINLINE or 99
local WOW_PROJECT_CLASSIC = _G.WOW_PROJECT_CLASSIC or 1
local WOW_PROJECT_BURNING_CRUSADE_CLASSIC = _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 2
local WOW_PROJECT_WRATH_CLASSIC = _G.WOW_PROJECT_WRATH_CLASSIC or 11

AtlasLoot.RETAIL_VERSION_NUM 	= 99
AtlasLoot.CLASSIC_VERSION_NUM 	= 1
AtlasLoot.BC_VERSION_NUM 		= 2
AtlasLoot.WRATH_VERSION_NUM 	= 3

AtlasLoot.GAME_VERSION_TEXTURES = {
	[AtlasLoot.CLASSIC_VERSION_NUM] = 538639,
	[AtlasLoot.BC_VERSION_NUM] = 131194,
	[AtlasLoot.WRATH_VERSION_NUM] = 235509,
}

AtlasLoot.IS_CLASSIC = false
AtlasLoot.IS_BC = false
AtlasLoot.IS_WRATH = false
AtlasLoot.IS_RETAIL = false

local CurrentGameVersion = AtlasLoot.RETAIL_VERSION_NUM
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	CurrentGameVersion = AtlasLoot.RETAIL_VERSION_NUM
	AtlasLoot.IS_RETAIL = true
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	if LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING then
		CurrentGameVersion = AtlasLoot.WRATH_VERSION_NUM
		AtlasLoot.IS_WRATH = true
	elseif LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE then
		CurrentGameVersion = AtlasLoot.BC_VERSION_NUM
		AtlasLoot.IS_BC = true
	end
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
	CurrentGameVersion = AtlasLoot.WRATH_VERSION_NUM
	AtlasLoot.IS_WRATH = true
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	CurrentGameVersion = AtlasLoot.CLASSIC_VERSION_NUM
	AtlasLoot.IS_CLASSIC = true
end

AtlasLoot.CURRENT_VERSION_NUM = CurrentGameVersion

function AtlasLoot:GetGameVersion()
	return CurrentGameVersion
end

-- equal
function AtlasLoot:GameVersion_EQ(gameVersion, ret, retFalse)
	if CurrentGameVersion == gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not equal
function AtlasLoot:GameVersion_NE(gameVersion, ret, retFalse)
	if CurrentGameVersion ~= gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not greater then
function AtlasLoot:GameVersion_GT(gameVersion, ret, retFalse)
	if CurrentGameVersion > gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not lesser then
function AtlasLoot:GameVersion_LT(gameVersion, ret, retFalse)
	if CurrentGameVersion < gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not greater equal
function AtlasLoot:GameVersion_GE(gameVersion, ret, retFalse)
	if CurrentGameVersion >= gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not lesser equal
function AtlasLoot:GameVersion_LE(gameVersion, ret, retFalse)
	if CurrentGameVersion <= gameVersion then
		return ret or true
	else
		return retFalse
	end
end