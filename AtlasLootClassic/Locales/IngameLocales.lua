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

local GLOBAL = setmetatable({}, {__index = function(t,k) return _G[k] or k end})
local GetMapNameByID = GetMapNameByID


local function AtlasLootGLOBALetClassName(class)
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
		return UnitSex("player")==3 and GLOBAL["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or GLOBAL["FACTION_STANDING_LABEL"..(id or 4)]
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
	["Professions"] = GLOBAL["TRADE_SKILLS"],
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
	["Jewelcrafting"] = GetSpellInfo(353970) or UNKNOWN,
	["Inscription"] = GetSpellInfo(45357) or UNKNOWN,

	-- sub Professions
	["Armorsmith"] = GetSpellInfo(9788),
	["Weaponsmith"] = GetSpellInfo(9787),
	["Hammersmith"] = GetSpellInfo(17041),
	["Axesmith"] = GetSpellInfo(17041),
	["Swordsmith"] = GetSpellInfo(17039),
	["Gnomish Engineer"] = GetSpellInfo(20220),

	-- glyphs
	["Minor Glyph"] = GLOBAL["MINOR_GLYPH"],
	["Minor Glyphs"] = GLOBAL["MINOR_GLYPHS"],
	["Major Glyph"] = GLOBAL["MAJOR_GLYPH"],
	["Major Glyphs"] = GLOBAL["MAJOR_GLYPHS"],


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
	["Mana"] = GLOBAL["ITEM_MOD_MANA_SHORT"],
	["Health"] = GLOBAL["ITEM_MOD_HEALTH_SHORT"],
	["Agility"] = GLOBAL["ITEM_MOD_AGILITY_SHORT"],
	["Strength"] = GLOBAL["ITEM_MOD_STRENGTH_SHORT"],
	["Intellect"] = GLOBAL["ITEM_MOD_INTELLECT_SHORT"],
	["Spirit"] = GLOBAL["ITEM_MOD_SPIRIT_SHORT"],
	["Stamina"] = GLOBAL["ITEM_MOD_STAMINA_SHORT"],
	["Happiness Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN4_SHORT"],
	["Hit"] = GLOBAL["ITEM_MOD_HIT_RATING_SHORT"],
	["PvP Resilience"] = GLOBAL["ITEM_MOD_RESILIENCE_RATING_SHORT"],
	["Bonus Healing"] = GLOBAL["ITEM_MOD_SPELL_HEALING_DONE_SHORT"],
	["Critical Strike"] = GLOBAL["ITEM_MOD_CRIT_RATING_SHORT"],
	["Armor Penetration"] = GLOBAL["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"],
	["Critical Strike (Spell)"] = GLOBAL["ITEM_MOD_CRIT_SPELL_RATING_SHORT"],
	["Critical Strike (Melee)"] = GLOBAL["ITEM_MOD_CRIT_MELEE_RATING_SHORT"],
	["Runic Power Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN6_SHORT"],
	["Hit Avoidance (Spell)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT"],
	["Energy Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN3_SHORT"],
	["Health Per 5 Sec."] = GLOBAL["ITEM_MOD_HEALTH_REGEN_SHORT"],
	["Expertise"] = GLOBAL["ITEM_MOD_EXPERTISE_RATING_SHORT"],
	["Parry"] = GLOBAL["ITEM_MOD_PARRY_RATING_SHORT"],
	["Critical Strike Avoidance"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_RATING_SHORT"],
	["Hit (Spell)"] = GLOBAL["ITEM_MOD_HIT_SPELL_RATING_SHORT"],
	["Block"] = GLOBAL["ITEM_MOD_BLOCK_RATING_SHORT"],
	["Defense"] = GLOBAL["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"],
	["Damage Per Second"] = GLOBAL["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"],
	["Hit Avoidance (Melee)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT"],
	["Rage Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN1_SHORT"],
	["Hit (Ranged)"] = GLOBAL["ITEM_MOD_HIT_RANGED_RATING_SHORT"],
	["Critical Strike Avoidance (Spell)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_SPELL_RATING_SHORT"],
	["Mana Regeneration"] = GLOBAL["ITEM_MOD_MANA_REGENERATION_SHORT"],
	["Melee Attack Power"] = GLOBAL["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"],
	["Hit Avoidance (Ranged)"] = GLOBAL["ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT"],
	["Focus Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN2_SHORT"],
	["Mana Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN0_SHORT"],
	["PvP Power"] = GLOBAL["ITEM_MOD_PVP_POWER_SHORT"],
	["Critical Strike Avoidance (Ranged)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_RANGED_RATING_SHORT"],
	["Block Value"] = GLOBAL["ITEM_MOD_BLOCK_VALUE_SHORT"],
	["Haste"] = GLOBAL["ITEM_MOD_HASTE_RATING_SHORT"],
	["Critical Strike (Ranged)"] = GLOBAL["ITEM_MOD_CRIT_RANGED_RATING_SHORT"],
	["Bonus Damage"] = GLOBAL["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"],
	["Ranged Attack Power"] = GLOBAL["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"],
	["Attack Power In Forms"] = GLOBAL["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"],
	["Spell Power"] = GLOBAL["ITEM_MOD_SPELL_POWER_SHORT"],
	["Hit Avoidance"] = GLOBAL["ITEM_MOD_HIT_TAKEN_RATING_SHORT"],
	["Critical Strike Avoidance (Melee)"] = GLOBAL["ITEM_MOD_CRIT_TAKEN_MELEE_RATING_SHORT"],
	["Runes Per 5 Sec."] = GLOBAL["ITEM_MOD_POWER_REGEN5_SHORT"],
	["Hit (Melee)"] = GLOBAL["ITEM_MOD_HIT_MELEE_RATING_SHORT"],
	["Dodge"] = GLOBAL["ITEM_MOD_DODGE_RATING_SHORT"],
	["Attack Power"] = GLOBAL["ITEM_MOD_ATTACK_POWER_SHORT"],
	["Armor Penetration Rating"] = GLOBAL["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"],

	-- ######################################################################
	-- Slots
	-- ######################################################################
	["Weapon"] = GLOBAL["ENCHSLOT_WEAPON"],
	["2H Weapon"] = GLOBAL["ENCHSLOT_2HWEAPON"],
	["Weapons"] = GLOBAL["WEAPONS"],
	["Armor"] = GLOBAL["ARMOR"],
	["Shield"] = GLOBAL["SHIELDSLOT"],
	["Wrist"] = GLOBAL["INVTYPE_WRIST"],
	["Trinket"]	= GLOBAL["INVTYPE_TRINKET"],
	["Robe"] = GLOBAL["INVTYPE_ROBE"],
	["Cloak"] = GLOBAL["INVTYPE_CLOAK"],
	["Head"] = GLOBAL["INVTYPE_HEAD"],
	["Holdable"] = GLOBAL["INVTYPE_HOLDABLE"],
	["Chest"] = GLOBAL["INVTYPE_CHEST"],
	["Neck"] = GLOBAL["INVTYPE_NECK"],
	["Tabard"] = GLOBAL["INVTYPE_TABARD"],
	["Legs"] = GLOBAL["INVTYPE_LEGS"],
	["Hand"] = GLOBAL["INVTYPE_HAND"],
	["Waist"] = GLOBAL["INVTYPE_WAIST"],
	["Feet"] = GLOBAL["INVTYPE_FEET"],
	["Shoulder"] = GLOBAL["INVTYPE_SHOULDER"],
	["Finger"] = GLOBAL["INVTYPE_FINGER"],
	["Bag"] = GLOBAL["INVTYPE_BAG"],
	["Ammo"] = GLOBAL["INVTYPE_AMMO"],
	["Body"] = GLOBAL["INVTYPE_BODY"], -- Shirt
	["Quiver"] = GLOBAL["INVTYPE_QUIVER"],
	["Relic"] = GLOBAL["INVTYPE_RELIC"],
	["Thrown"] = GLOBAL["INVTYPE_THROWN"],
	["Main Hand"] = GLOBAL["INVTYPE_WEAPONMAINHAND"],
	["Main Attack"]	= GLOBAL["INVTYPE_WEAPONMAINHAND_PET"],	-- "Main Attack"
	["Off Hand"] = GLOBAL["INVTYPE_WEAPONOFFHAND"],
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
	-- Gems
	-- ######################################################################
	["Socket Gems"]	 	= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["SOCKET_GEMS"], GLOBAL["SOCKETGLOBALEMS"]),
	["Gems"]			= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["AUCTION_CATEGORY_GEMS"], GLOBAL["AUCTION_CATEGORYGLOBALEMS"]),
	["Meta"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["META_GEM"], GLOBAL["METAGLOBALEM"]),
	["Red"]	 			= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["RED_GEM"], GLOBAL["REDGLOBALEM"]),
	["Yellow"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["YELLOW_GEM"], GLOBAL["YELLOWGLOBALEM"]),
	["Blue"]	 		= AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, GLOBAL["BLUE_GEM"], GLOBAL["BLUEGLOBALEM"]),
	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic

	-- ######################################################################
	-- Class
	-- ######################################################################
	["DRUID"] 		= AtlasLootGLOBALetClassName("DRUID"),
	["HUNTER"] 		= AtlasLootGLOBALetClassName("HUNTER"),
	["MAGE"] 		= AtlasLootGLOBALetClassName("MAGE"),
	["PALADIN"] 	= AtlasLootGLOBALetClassName("PALADIN"),
	["PRIEST"] 		= AtlasLootGLOBALetClassName("PRIEST"),
	["ROGUE"] 		= AtlasLootGLOBALetClassName("ROGUE"),
	["SHAMAN"] 		= AtlasLootGLOBALetClassName("SHAMAN"),
	["WARLOCK"] 	= AtlasLootGLOBALetClassName("WARLOCK"),
	["WARRIOR"] 	= AtlasLootGLOBALetClassName("WARRIOR"),
	["DEATHKNIGHT"] = AtlasLootGLOBALetClassName("DEATHKNIGHT"),


	-- ######################################################################
	-- Item Quality
	-- ######################################################################
	["Poor"]	 	= GLOBAL["ITEM_QUALITY0_DESC"],
	["Common"] 		= GLOBAL["ITEM_QUALITY1_DESC"],
	["Uncommon"] 	= GLOBAL["ITEM_QUALITY2_DESC"],
	["Rare"] 		= GLOBAL["ITEM_QUALITY3_DESC"],
	["Epic"]		= GLOBAL["ITEM_QUALITY4_DESC"],
	["Legendary"] 	= GLOBAL["ITEM_QUALITY5_DESC"],
	["Artifact"] 	= GLOBAL["ITEM_QUALITY6_DESC"],
	["Heirloom"] 	= GLOBAL["ITEM_QUALITY7_DESC"],

	-- ######################################################################
	-- Misc
	-- ######################################################################
	["Food"] = GLOBAL["POWER_TYPE_FOOD"],
	["Special"] = GLOBAL["SPECIAL"],
	["Mounts"] = GLOBAL["MOUNTS"],
	["Mount"] = GLOBAL["MOUNT"],
	["Pet"] = GLOBAL["PET"],
	["Pets"] = GLOBAL["PETS"],
	["Default"] = GLOBAL["DEFAULT"],
	["Settings"] = GLOBAL["SETTINGS"],
	["Dressing Room"] = GLOBAL["DRESSUP_FRAME"],
	["Quest Item"] = GLOBAL["ITEM_BIND_QUEST"],
	["Collected"] = GLOBAL["COLLECTED"],
	["Not Collected"] = GLOBAL["NOT_COLLECTED"],
	["Achievements"] = GLOBAL["ACHIEVEMENTS"],
	["Companions"] = GLOBAL["COMPANIONS"],
	["Currency"] = GLOBAL["CURRENCY"],
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )
