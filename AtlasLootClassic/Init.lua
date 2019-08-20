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
