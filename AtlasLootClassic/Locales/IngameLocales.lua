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
local GetItemSubClassInfo = GetItemSubClassInfo

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
	-- Armor Classes
	-- ######################################################################
	["Cloth"] = GetItemSubClassInfo(4,1),
	["Leather"] = GetItemSubClassInfo(4,2),
	["Mail"] = GetItemSubClassInfo(4,3),
	["Plate"] = GetItemSubClassInfo(4,4),
	["Bucklers"] = GetItemSubClassInfo(4,5),
	["Shields"] = GetItemSubClassInfo(4,6),
	["Librams"] = GetItemSubClassInfo(4,7),
	["Idols"] = GetItemSubClassInfo(4,8),
	["Totems"] = GetItemSubClassInfo(4,9),


	-- ######################################################################
	-- Slots
	-- ######################################################################
	["Weapon"] = _G["ENCHSLOT_WEAPON"],
	["2H Weapon"] = _G["ENCHSLOT_2HWEAPON"],
	["Weapons"] = _G["WEAPONS"],
	["Armor"] = _G["ARMOR"],
	["Shield"] = _G["SHIELDSLOT"],
	["Wrist"] = _G["INVTYPE_WRIST"],
	["Trinket"]	= _G["INVTYPE_TRINKET"],
	["Robe"] = _G["INVTYPE_ROBE"],
	["Cloak"] = _G["INVTYPE_CLOAK"],
	["Head"] = _G["INVTYPE_HEAD"],
	["Holdable"] = _G["INVTYPE_HOLDABLE"],
	["Chest"] = _G["INVTYPE_CHEST"],
	["Neck"] = _G["INVTYPE_NECK"],
	["Tabard"] = _G["INVTYPE_TABARD"],
	["Legs"] = _G["INVTYPE_LEGS"],
	["Hand"] = _G["INVTYPE_HAND"],
	["Waist"] = _G["INVTYPE_WAIST"],
	["Feet"] = _G["INVTYPE_FEET"],
	["Shoulder"] = _G["INVTYPE_SHOULDER"],
	["Finger"] = _G["INVTYPE_FINGER"],
	["Bag"] = _G["INVTYPE_BAG"],
	["Ammo"] = _G["INVTYPE_AMMO"],
	["Body"] = _G["INVTYPE_BODY"], -- Shirt
	["Quiver"] = _G["INVTYPE_QUIVER"],
	["Relic"] = _G["INVTYPE_RELIC"],
	["Thrown"] = _G["INVTYPE_THROWN"],
	["Main Hand"] = _G["INVTYPE_WEAPONMAINHAND"],
	["Main Attack"]	= _G["INVTYPE_WEAPONMAINHAND_PET"],	-- "Main Attack"
	["Off Hand"] = _G["INVTYPE_WEAPONOFFHAND"],
	-- GetItemSubClassInfo(iC,isC)
	["Two-Handed Axes"] = GetItemSubClassInfo(2,1),
	["Bows"] = GetItemSubClassInfo(2,2),
	["Guns"] = GetItemSubClassInfo(2,3),
	["One-Handed Maces"] = GetItemSubClassInfo(2,4),
	["Two-Handed Maces"] = GetItemSubClassInfo(2,5),
	["Polearms"] = GetItemSubClassInfo(2,6),
	["One-Handed Swords"] = GetItemSubClassInfo(2,7),
	["Two-Handed Swords"] = GetItemSubClassInfo(2,8),
	--["Obsolete"] = GetItemSubClassInfo(2,9),
	["Staves"] = GetItemSubClassInfo(2,10),
	["One-Handed Exotics"] = GetItemSubClassInfo(2,11),
	["Two-Handed Exotics"] = GetItemSubClassInfo(2,12),
	["Fist Weapons"] = GetItemSubClassInfo(2,13),
	--["Miscellaneous"] = GetItemSubClassInfo(2,14),
	["Daggers"] = GetItemSubClassInfo(2,15),
	--["Thrown"] = GetItemSubClassInfo(2,16),
	["Spears"] = GetItemSubClassInfo(2,17),
	["Crossbows"] = GetItemSubClassInfo(2,18),
	["Wands"] = GetItemSubClassInfo(2,19),
	["Fishing Pole"] = GetItemSubClassInfo(2,20),


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
