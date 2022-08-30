local ALName, ALPrivate = ...

-- ##############################
-- Global
-- ##############################

-- PreSet ID's for special itemtable options

--- Ignore this item while filter is enabled
-- ATLASLOOT_IT_FILTERIGNORE = true
ATLASLOOT_IT_FILTERIGNORE = 900

--- Setup the item for a faction
-- ATLASLOOT_IT_HORDE = true		<- this is a Horde only item (shown in lootpage but with horde background you can hide the item if you set ATLASLOOT_IT_ALLIANCE = false( example { 1, 1234, [ATLASLOOT_IT_HORDE] = true } )
-- ATLASLOOT_IT_HORDE = 1234		<- the Horde version of this item is 1234 ( example { 1, [ATLASLOOT_IT_HORDE] = 1234, [ATLASLOOT_IT_ALLIANCE] = 5678 }
ATLASLOOT_IT_HORDE = 901
ATLASLOOT_IT_ALLIANCE = 902

--- Ads a item amount
ATLASLOOT_IT_AMOUNT1 = 903		-- item1
ATLASLOOT_IT_AMOUNT2 = 904		-- item2

-- Colors
ATLASLOOT_COLLECTION_COLOR 		= {0.3, 0.3, 0, 1}
ATLASLOOT_DUNGEON_COLOR 		= {0, 0, 0.3, 1}
ATLASLOOT_FACTION_COLOR 		= {0, 0.3, 0, 1}
ATLASLOOT_PERMRECEVENTS_COLOR 	= {0.2, 0, 0.4, 1}
ATLASLOOT_PRIMPROFESSION_COLOR 	= {0.35, 0.15, 0.2, 1}
ATLASLOOT_PVP_COLOR 			= {0, 0.36, 0.24, 1}
ATLASLOOT_RAID_COLOR			= {0.3, 0, 0, 1}
ATLASLOOT_RAID40_COLOR			= {0.3, 0, 0, 1}
ATLASLOOT_RAID20_COLOR			= {0.5, 0.1, 0, 1}
ATLASLOOT_REMOVED_COLOR 		= {0.4, 0.2, 0, 1}
ATLASLOOT_SEASONALEVENTS_COLOR 	= {0.36, 0, 0.24, 1}
ATLASLOOT_SECPROFESSION_COLOR 	= {0.5, 0.1, 0, 1}
ATLASLOOT_WORLD_BOSS_COLOR 		= {0.74, 0.0, 0.28, 1}
ATLASLOOT_COLLECTIONS_COLOR		= {0.64, 0.21, 0.93, 1}
ATLASLOOT_CLASSPROFESSION_COLOR = ATLASLOOT_FACTION_COLOR
ATLASLOOT_UNKNOWN_COLOR 		= {0, 0, 0, 1}
ATLASLOOT_HORDE_COLOR			= {1, 0, 0, 0.8}
ATLASLOOT_ALLIANCE_COLOR		= {0, 0, 1, 0.8}

ATLASLOOT_ITEM_BACKGROUND_ALPHA = 0.9

-- ##############################
-- AtlasLoot Private things
-- ##############################

-- GameVersion
ALPrivate.IS_CLASSIC 	= AtlasLoot:GetGameVersion() == AtlasLoot.CLASSIC_VERSION_NUM
ALPrivate.IS_BC 		= AtlasLoot:GetGameVersion() == AtlasLoot.BC_VERSION_NUM
ALPrivate.IS_WOTLK 		= AtlasLoot:GetGameVersion() == AtlasLoot.WRATH_VERSION_NUM

-- Account specific
ALPrivate.ACCOUNT_LOCALE = GetLocale()
ALPrivate.PLAYER_NAME = UnitName("player")

-- Image path
ALPrivate.IMAGE_PATH = "Interface\\AddOns\\"..ALName.."\\Images\\"
local ICONS_PATH = ALPrivate.IMAGE_PATH.."Icons\\"
ALPrivate.ICONS_PATH = ICONS_PATH

-- Mostly used in selection template
ALPrivate.COIN_TEXTURE = {
	GOLD 		= {	texture = "Interface\\MoneyFrame\\UI-GoldIcon" },
	SILVER 		= {	texture = "Interface\\MoneyFrame\\UI-SilverIcon" },
	COPPER		= {	texture = "Interface\\MoneyFrame\\UI-CopperIcon" },
	AC 			= {	texture = "Interface\\AchievementFrame\\UI-Achievement-TinyShield", texCoord = {0, 0.625, 0, 0.625} },
	REPUTATION 	= {	texture = "Interface\\Icons\\Achievement_Reputation_08" },

	CLASSIC 	= {	texture = AtlasLoot.GAME_VERSION_TEXTURES[AtlasLoot.CLASSIC_VERSION_NUM], width = 2.0 },
	BC		 	= {	texture = AtlasLoot.GAME_VERSION_TEXTURES[AtlasLoot.BC_VERSION_NUM], width = 2.0 },
	WRATH	 	= {	texture = AtlasLoot.GAME_VERSION_TEXTURES[AtlasLoot.WRATH_VERSION_NUM], width = 2.0 },
}

-- Simple backdrop for SetBackdrop
ALPrivate.BOX_BACKDROP = { bgFile = "Interface/Tooltips/UI-Tooltip-Background" }
-- backdrop with border
ALPrivate.BOX_BORDER_BACKDROP = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },
}

ALPrivate.CLASS_ICON_PATH = {
	-- class icons
	WARRIOR 	= 	ICONS_PATH.."classicon_warrior",
	PALADIN 	= 	ICONS_PATH.."classicon_paladin",
	HUNTER 		= 	ICONS_PATH.."classicon_hunter",
	ROGUE 		= 	ICONS_PATH.."classicon_rogue",
	PRIEST 		= 	ICONS_PATH.."classicon_priest",
	SHAMAN 		= 	ICONS_PATH.."classicon_shaman",
	MAGE 		= 	ICONS_PATH.."classicon_mage",
	WARLOCK 	= 	ICONS_PATH.."classicon_warlock",
	DRUID 		= 	ICONS_PATH.."classicon_druid",
	DEATHKNIGHT	= 	ICONS_PATH.."classicon_deathknight",
}
-- CLASS_WARRIOR
ALPrivate.CLASS_ICON_PATH_ITEM_DB = {}
for k,v in pairs(ALPrivate.CLASS_ICON_PATH) do ALPrivate.CLASS_ICON_PATH_ITEM_DB[k] = "CLASS_"..k end

ALPrivate.PRICE_ICON_REPLACE = {
	["honor"] = UnitFactionGroup("player") == "Horde" and 136782 or 136781,
	["honorH"] = 136782,
	["honorA"] = 136781,
}

ALPrivate.CLASS_BITS = {
    --NONE 			= 0,
    WARRIOR 		= 1,
    PALADIN 		= 2,
    HUNTER 			= 4,
    ROGUE 			= 8,
    PRIEST 			= 16,
    DEATHKNIGHT 	= 32,
    SHAMAN 			= 64,
    MAGE 			= 128,
    WARLOCK 		= 256,
    --MONK	 		= 512,
    DRUID 			= 1024,
    --DEMONHUNTER 	= 2048,
}
ALPrivate.CLASS_BIT_TO_CLASS = {}
for k,v in pairs(ALPrivate.CLASS_BITS) do ALPrivate.CLASS_BIT_TO_CLASS[v] = k end

if AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM) then
	ALPrivate.CLASS_SORT = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
else
	ALPrivate.CLASS_SORT = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
end

ALPrivate.CLASS_NAME_TO_ID = {}
for classID = 1, #ALPrivate.CLASS_SORT do ALPrivate.CLASS_NAME_TO_ID[ALPrivate.CLASS_SORT[classID]] = classID end

ALPrivate.LOC_CLASSES = {}
FillLocalizedClassList(ALPrivate.LOC_CLASSES)

ALPrivate.ADDON_MSG_PREFIX = "ATLASLOOT_MSG"