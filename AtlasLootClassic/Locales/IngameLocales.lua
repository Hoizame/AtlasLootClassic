-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format
local rawget = _G.rawget

-- WoW
local GetSpellInfo = GetSpellInfo
local GetItemClassInfo, GetItemSubClassInfo = GetItemClassInfo, GetItemSubClassInfo

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

local function GetLocRepStanding(id)
	if (id > 10) then
		return FACTION_STANDING_LABEL4_FEMALE
	else
		return UnitSex("player")==3 and _G["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or _G["FACTION_STANDING_LABEL"..(id or 4)]
	end
end

local IngameLocales = {
	-- ######################################################################
	-- Faction standing
	-- ######################################################################
	["Hated"] = GetLocRepStanding(1),
	["Hostile"] = GetLocRepStanding(2),
	["Unfriendly"] = GetLocRepStanding(3),
	["Neutral"] = GetLocRepStanding(4),
	["Friendly"] = GetLocRepStanding(5),
	["Honored"] = GetLocRepStanding(6),
	["Revered"] = GetLocRepStanding(7),
	["Exalted"] = GetLocRepStanding(8),

	-- ######################################################################
	-- Professions
	-- ######################################################################
	["Professions"] = _G["TRADE_SKILLS"],
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
	["Poisons"] = GetSpellInfo(2842),

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
	-- Stats
	-- ######################################################################
	["Mana"] = _G["ITEM_MOD_MANA_SHORT"],
	["Health"] = _G["ITEM_MOD_HEALTH_SHORT"],
	["Agility"] = _G["ITEM_MOD_AGILITY_SHORT"],
	["Strength"] = _G["ITEM_MOD_STRENGTH_SHORT"],
	["Intellect"] = _G["ITEM_MOD_INTELLECT_SHORT"],
	["Spirit"] = _G["ITEM_MOD_SPIRIT_SHORT"],
	["Stamina"] = _G["ITEM_MOD_STAMINA_SHORT"],
	["Happiness Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN4_SHORT"],
	["Hit"] = _G["ITEM_MOD_HIT_RATING_SHORT"],
	["PvP Resilience"] = _G["ITEM_MOD_RESILIENCE_RATING_SHORT"],
	["Bonus Healing"] = _G["ITEM_MOD_SPELL_HEALING_DONE_SHORT"],
	["Critical Strike"] = _G["ITEM_MOD_CRIT_RATING_SHORT"],
	["Armor Penetration"] = _G["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"],
	["Critical Strike (Spell)"] = _G["ITEM_MOD_CRIT_SPELL_RATING_SHORT"],
	["Critical Strike (Melee)"] = _G["ITEM_MOD_CRIT_MELEE_RATING_SHORT"],
	["Runic Power Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN6_SHORT"],
	["Hit Avoidance (Spell)"] = _G["ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT"],
	["Energy Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN3_SHORT"],
	["Health Per 5 Sec."] = _G["ITEM_MOD_HEALTH_REGEN_SHORT"],
	["Expertise"] = _G["ITEM_MOD_EXPERTISE_RATING_SHORT"],
	["Parry"] = _G["ITEM_MOD_PARRY_RATING_SHORT"],
	["Critical Strike Avoidance"] = _G["ITEM_MOD_CRIT_TAKEN_RATING_SHORT"],
	["Hit (Spell)"] = _G["ITEM_MOD_HIT_SPELL_RATING_SHORT"],
	["Block"] = _G["ITEM_MOD_BLOCK_RATING_SHORT"],
	["Defense"] = _G["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"],
	["Damage Per Second"] = _G["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"],
	["Hit Avoidance (Melee)"] = _G["ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT"],
	["Rage Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN1_SHORT"],
	["Hit (Ranged)"] = _G["ITEM_MOD_HIT_RANGED_RATING_SHORT"],
	["Critical Strike Avoidance (Spell)"] = _G["ITEM_MOD_CRIT_TAKEN_SPELL_RATING_SHORT"],
	["Mana Regeneration"] = _G["ITEM_MOD_MANA_REGENERATION_SHORT"],
	["Melee Attack Power"] = _G["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"],
	["Hit Avoidance (Ranged)"] = _G["ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT"],
	["Focus Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN2_SHORT"],
	["Mana Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN0_SHORT"],
	["PvP Power"] = _G["ITEM_MOD_PVP_POWER_SHORT"],
	["Critical Strike Avoidance (Ranged)"] = _G["ITEM_MOD_CRIT_TAKEN_RANGED_RATING_SHORT"],
	["Block Value"] = _G["ITEM_MOD_BLOCK_VALUE_SHORT"],
	["Haste"] = _G["ITEM_MOD_HASTE_RATING_SHORT"],
	["Critical Strike (Ranged)"] = _G["ITEM_MOD_CRIT_RANGED_RATING_SHORT"],
	["Bonus Damage"] = _G["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"],
	["Ranged Attack Power"] = _G["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"],
	["Attack Power In Forms"] = _G["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"],
	["Spell Power"] = _G["ITEM_MOD_SPELL_POWER_SHORT"],
	["Hit Avoidance"] = _G["ITEM_MOD_HIT_TAKEN_RATING_SHORT"],
	["Critical Strike Avoidance (Melee)"] = _G["ITEM_MOD_CRIT_TAKEN_MELEE_RATING_SHORT"],
	["Runes Per 5 Sec."] = _G["ITEM_MOD_POWER_REGEN5_SHORT"],
	["Hit (Melee)"] = _G["ITEM_MOD_HIT_MELEE_RATING_SHORT"],
	["Dodge"] = _G["ITEM_MOD_DODGE_RATING_SHORT"],

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
	["One-Handed Axes"] = GetItemSubClassInfo(2,0),
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
	["Parts"] = GetItemSubClassInfo(7,1),
	["Projectile"] = GetItemClassInfo(6),
	["Bullet"] = GetItemSubClassInfo(6,3),
	["Explosives"] = GetItemSubClassInfo(7,2),


	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic

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


	-- ######################################################################
	-- Item Quality
	-- ######################################################################
	["Poor"]	 	= _G["ITEM_QUALITY0_DESC"],
	["Common"] 		= _G["ITEM_QUALITY1_DESC"],
	["Uncommon"] 	= _G["ITEM_QUALITY2_DESC"],
	["Rare"] 		= _G["ITEM_QUALITY3_DESC"],
	["Epic"]		= _G["ITEM_QUALITY4_DESC"],
	["Legendary"] 	= _G["ITEM_QUALITY5_DESC"],
	["Artifact"] 	= _G["ITEM_QUALITY6_DESC"],
	["Heirloom"] 	= _G["ITEM_QUALITY7_DESC"],

	-- ######################################################################
	-- Misc
	-- ######################################################################
	["Food"] = _G["POWER_TYPE_FOOD"],
	["Special"] = _G["SPECIAL"],
	["Mounts"] = _G["MOUNTS"],
	["Mount"] = _G["MOUNT"],
	["Default"] = _G["DEFAULT"],
	["Settings"] = _G["SETTINGS"],
	["Dressing Room"] = _G["DRESSUP_FRAME"],
	["Quest Item"] = _G["ITEM_BIND_QUEST"],
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )
