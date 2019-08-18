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

ATLASLOOT_ITEM_BACKGROUND_ALPHA = 0.9

-- ##############################
-- AtlasLoot Private things
-- ##############################

-- Account specific
ALPrivate.ACCOUNT_LOCALE = GetLocale()

-- Image path
ALPrivate.IMAGE_PATH = "Interface\\AddOns\\"..ALName.."\\Images\\"
ALPrivate.ICONS_PATH = ALPrivate.IMAGE_PATH.."Icons\\"

-- Mostly used in selection template
ALPrivate.COIN_TEXTURE = {
	GOLD 		= "Interface\\MoneyFrame\\UI-GoldIcon",
	SILVER 		= "Interface\\MoneyFrame\\UI-SilverIcon",
	COPPER		= "Interface\\MoneyFrame\\UI-CopperIcon",
	AC 		= "Interface\\AchievementFrame\\UI-Achievement-TinyShield",
	REPUTATION 	= "Interface\\Icons\\Achievement_Reputation_08",
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
