-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format
local rawget = rawget

-- WoW
local GetSpellInfo = GetSpellInfo

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot

local _, tmp1
local months = {
	MONTH_JANUARY,
	MONTH_FEBRUARY,
	MONTH_MARCH,
	MONTH_APRIL,
	MONTH_MAY,
	MONTH_JUNE,
	MONTH_JULY,
	MONTH_AUGUST,
	MONTH_SEPTEMBER,
	MONTH_OCTOBER,
	MONTH_NOVEMBER,
	MONTH_DECEMBER,
}


local GetMapNameByID = GetMapNameByID


local function AtlasLoot_GetClassName(class)
	if (not LOCALIZED_CLASS_NAMES_MALE[class]) then
		return nil;
	end
	if (UnitSex("player") == "3") then
		return LOCALIZED_CLASS_NAMES_FEMALE[class];
	else
		return LOCALIZED_CLASS_NAMES_MALE[class];
	end
end

local IngameLocales = {
	-- ######################################################################
	-- Professions
	-- ######################################################################
	["First Aid"] = GetSpellInfo(3273),
	["Blacksmithing"] = GetSpellInfo(2018),
	["Leatherworking"] = GetSpellInfo(2108),
	["Alchemy"] = GetSpellInfo(2259),
	["Herbalism"] = GetSpellInfo(2366),
	["Cooking"] = GetSpellInfo(2550),
	["Mining"] = GetSpellInfo(2575),
	["Tailoring"] = GetSpellInfo(3908),
	["Engineering"] = GetSpellInfo(4036),
	["Enchanting"] = GetSpellInfo(7411),
	["Fishing"] = GetSpellInfo(7732),
	["Skinning"] = GetSpellInfo(8618),

	-- ######################################################################
	-- Months
	-- ######################################################################
	["January"] = months[1],
	["February"] = months[2],
	["March"] = months[3],
	["April"] = months[4],
	["May"] = months[5],
	["June"] = months[6],
	["July"] = months[7],
	["August"] = months[8],
	["September"] = months[9],
	["October"] = months[10],
	["November"] = months[11],
	["December"] = months[12],

	-- ######################################################################
	-- Class Specs
	-- ######################################################################


	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic
	--["Ahn'Qiraj"] = GetMapInfo(319).name,
	--["Blackrock Depths"] = GetMapInfo(242).name,
	--["Blackwing Lair"] = GetMapInfo(287).name,
	--["Lower Blackrock Spire"] = GetAchievementName(643),
	--["Molten Core"] = GetMapInfo(232).name,
	--["Orgrimmar"] = GetMapInfo(85).name,
	--["Ruins of Ahn'Qiraj"] = GetMapInfo(247).name,
	--["Shadowfang Keep"] = GetMapInfo(310).name,
	--["Stormwind City"] = GetMapInfo(84).name,
	--["Upper Blackrock Spire"] = GetAchievementName(1307),


	-- data from Core/ItemInfo.lua is generated after loading

	-- ######################################################################
	-- Class
	-- ######################################################################
	["DRUID"] 	= AtlasLoot_GetClassName("DRUID"),
	["HUNTER"] 	= AtlasLoot_GetClassName("HUNTER"),
	["MAGE"] 	= AtlasLoot_GetClassName("MAGE"),
	["PALADIN"] 	= AtlasLoot_GetClassName("PALADIN"),
	["PRIEST"] 	= AtlasLoot_GetClassName("PRIEST"),
	["ROGUE"] 	= AtlasLoot_GetClassName("ROGUE"),
	["SHAMAN"] 	= AtlasLoot_GetClassName("SHAMAN"),
	["WARLOCK"] 	= AtlasLoot_GetClassName("WARLOCK"),
	["WARRIOR"] 	= AtlasLoot_GetClassName("WARRIOR"),
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )
