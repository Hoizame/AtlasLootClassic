-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1, "INV_Box_01", nil, AL["Key"], nil },
		{ 2, 16309,},
		{ 3, 12344,},
		{ 4, 17191,},
		{ 5, 7146, },
		{ 6, 12382,},
		{ 7, 6893, },
		{ 8, 11000,},
		{ 9, 11140,},
		{ 10, 18249, },
		{ 11, 13704, },
		{ 12, 11197, },
		{ 13, 18266, },
		{ 14, 18268, },
		{ 15, 13873, },
		{ 16, "INV_Box_01", nil, AL["Misc"], nil },
		{ 17, 19931 },
		{ 18, 18250 },
		{ 19, 9240 },
		{ 20, 17333 },
		{ 21, 22754 },
		{ 22, 13523 },
		{ 23, 18746 },
		{ 24, 18663 },
		{ 25, 19974 },
		{ 26, 7733 },
		{ 27, 10818 },
		{ 29, 22057 },
		{ 30, 21986 },
	},
}

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]]--

data["AlteracValley"] = {
	MapID = 2597,
	AtlasMapID = "AlteracValley",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 3,
	items = {
		{ -- AVRepExalted
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1, "f730rep8" },

				{ 2,  19312 }, -- Lei of the Lifegiver
				{ 3,  19315 }, -- Therazane's Touch
				{ 4,  19308 }, -- Tome of Arcane Domination
				{ 5,  19311 }, -- Tome of Fiery Arcana
				{ 6,  19309 }, -- Tome of Shadow Force
				{ 7, 19310 }, -- Tome of the Ice Lord
				{ 8, 19325 }, -- Don Julio's Band
				{ 9, 21563 }, -- Don Rodrigo's Band
				{ 10, 19321 }, -- The Immovable Object
				{ 11, 19324 }, -- The Lobotomizer
				{ 12, 19323 }, -- The Unstoppable Force

				{ 17,  19030 }, -- Stormpike Battle Charger
			},
			[HORDE_DIFF] = {
				{ 1, "f729rep8" },

				{ 2, 19312 }, -- Lei of the Lifegiver
				{ 3, 19315 }, -- Therazane's Touch
				{ 4, 19308 }, -- Tome of Arcane Domination
				{ 5, 19311 }, -- Tome of Fiery Arcana
				{ 6, 19309 }, -- Tome of Shadow Force
				{ 7, 19310 }, -- Tome of the Ice Lord
				{ 8, 19325 }, -- Don Julio's Band
				{ 9, 21563 }, -- Don Rodrigo's Band
				{ 10, 19321 }, -- The Immovable Object
				{ 11, 19324 }, -- The Lobotomizer
				{ 12, 19323 }, -- The Unstoppable Force

				{ 17, 19029 }, -- Horn of the Frostwolf Howler
			},
		},
		{ -- AVRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1, "f730rep7" },
				{ 2,  19045 }, -- Stormpike Battle Standard
				{ 3,  19320 }, -- Gnoll Skin Bandolier
				{ 4,  19319 }, -- Harpy Hide Quiver
				{ 5,  19100 }, -- Electrified Dagger
				{ 6,  19104 }, -- Stormstrike Hammer
				{ 7,  19102 }, -- Crackling Staff
			},
			[HORDE_DIFF] = {
				{ 1, "f729rep7" },
				{ 2, 19046 }, -- Frostwolf Battle Standard
				{ 3, 19320 }, -- Gnoll Skin Bandolier
				{ 4, 19319 }, -- Harpy Hide Quiver
				{ 5, 19099 }, -- Glacial Blade
				{ 6, 19103 }, -- Frostbite
				{ 7, 19101 }, -- Whiteout Staff
			},
		},
		{ -- AVRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1, "f730rep6" },
				{ 2,  19098 }, -- Stormpike Sage's Pendant
				{ 3,  19097 }, -- Stormpike Soldier's Pendant
				{ 4,  19086 }, -- Stormpike Sage's Cloak
				{ 5,  19084 }, -- Stormpike Soldier's Cloak
				{ 6,  19094 }, -- Stormpike Cloth Girdle
				{ 7,  19093 }, -- Stormpike Leather Girdle
				{ 8,  19092 }, -- Stormpike Mail Girdle
				{ 9, 19091 }, -- Stormpike Plate Girdle
				{ 17, 19316 }, -- Ice Threaded Arrow
				{ 18, 19317 }, -- Ice Threaded Bullet
				{ 19, 19301 }, -- Alterac Manna Biscuit
				{ 20, 17348 }, -- Major Healing Draught
				{ 21, 17351 }, -- Major Mana Draught
			},
			[HORDE_DIFF] = {
				{ 1, "f729rep6" },
				{ 2, 19096 }, -- Frostwolf Advisor's Pendant
				{ 3, 19095 }, -- Frostwolf Legionnaire's Pendant
				{ 4, 19085 }, -- Frostwolf Advisor's Cloak
				{ 5, 19083 }, -- Frostwolf Legionnaire's Cloak
				{ 6, 19090 }, -- Frostwolf Cloth Belt
				{ 7, 19089 }, -- Frostwolf Leather Belt
				{ 8, 19088 }, -- Frostwolf Mail Belt
				{ 9, 19087 }, -- Frostwolf Plate Belt
				{ 17, 19316 }, -- Ice Threaded Arrow
				{ 18, 19317 }, -- Ice Threaded Bullet
				{ 19, 19301 }, -- Alterac Manna Biscuit
				{ 20, 17348 }, -- Major Healing Draught
				{ 21, 17351 }, -- Major Mana Draught
			},
		},
		{ -- AVRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1, "f730rep5" },
				{ 2,  19318 }, -- Bottled Alterac Spring Water
				{ 3,  19307 }, -- Alterac Heavy Runecloth Bandage
				{ 4,  17349 }, -- Superior Healing Draught
				{ 5,  17352 }, -- Superior Mana Draught
				{ 17,  19032 }, -- Stormpike Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1, "f729rep5" },
				{ 2, 19318 }, --  Spring Water
				{ 3, 19307 }, -- Alterac Heavy Runecloth Bandage
				{ 4, 17349 }, -- Superior Healing Draught
				{ 5, 17352 }, -- Superior Mana Draught
				{ 17, 19031 }, -- Frostwolf Battle Tabard
			},
		},
	},
}

data["WarsongGulch"] = {
	MapID = 3277,
	AtlasMapID = "WarsongGulch",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 3,
	items = {
		{ -- WSGRepExalted
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1, "f890rep8" },
				{ 2, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepExalted4049
				{ 3,  19597 }, -- Dryad's Wrist Bindings
				{ 4,  19590 }, -- Forest Stalker's Bracers
				{ 5,  19584 }, -- Windtalker's Wristguards
				{ 6,  19581 }, -- Berserker Bracers
				{ 8, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepExalted5059
				{ 9,  19596 }, -- Dryad's Wrist Bindings
				{ 10,  19589 }, -- Forest Stalker's Bracers
				{ 11,  19583 }, -- Windtalker's Wristguards
				{ 12,  19580 }, -- Berserker Bracers
				{ 17, "INV_Box_01", nil, "60", nil }, -- WSGRepExalted60
				{ 18,  19595 }, -- Dryad's Wrist Bindings
				{ 19,  19587 }, -- Forest Stalker's Bracers
				{ 20,  19582 }, -- Windtalker's Wristguards
				{ 21,  19578 }, -- Berserker Bracers
				{ 22,  22752 }, -- Sentinel's Silk Leggings
				{ 23,  22749 }, -- Sentinel's Leather Pants
				{ 24, 22750 }, -- Sentinel's Lizardhide Pants
				{ 25, 22748 }, -- Sentinel's Chain Leggings
				{ 26, 22753 }, -- Sentinel's Lamellar Legguards
				{ 27, 22672 }, -- Sentinel's Plate Legguards
				{ 28, 19506 }, -- Silverwing Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1, "f889rep8" },
				{ 2, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepExalted4049
				{ 3, 19597 }, -- Dryad's Wrist Bindings
				{ 4, 19590 }, -- Forest Stalker's Bracers
				{ 5, 19584 }, -- Windtalker's Wristguards
				{ 6, 19581 }, -- Berserker Bracers
				{ 8, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepExalted5059
				{ 9, 19596 }, -- Dryad's Wrist Bindings
				{ 10, 19589 }, -- Forest Stalker's Bracers
				{ 11, 19583 }, -- Windtalker's Wristguards
				{ 12, 19580 }, -- Berserker Bracers
				{ 17, "INV_Box_01", nil, "60", nil }, -- WSGRepExalted60
				{ 18, 19595 }, -- Dryad's Wrist Bindings
				{ 19, 19587 }, -- Forest Stalker's Bracers
				{ 20, 19582 }, -- Windtalker's Wristguards
				{ 21, 19578 }, -- Berserker Bracers
				{ 22, 22747 }, -- Outrider's Silk Leggings
				{ 23, 22740 }, -- Outrider's Leather Pants
				{ 24, 22741 }, -- Outrider's Lizardhide Pants
				{ 25, 22673 }, -- Outrider's Chain Leggings
				{ 26, 22676 }, -- Outrider's Mail Leggings
				{ 27, 22651 }, -- Outrider's Plate Legguards
				{ 28, 19505 }, -- Warsong Battle Tabard
			},
		},
		{ -- WSGRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1, "f890rep7" },
				{ 2, "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepRevered1019
				{ 3, 20438 }, -- Outrunner's Bow
				{ 4, 20443 }, -- Sentinel's Blade
				{ 5, 20440 }, -- Protector's Sword
				{ 6, 20434 }, -- Lorekeeper's Staff
				{ 8, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepRevered2029
				{ 9, 19565 }, -- Outrunner's Bow
				{ 10, 19549 }, -- Sentinel's Blade
				{ 11, 19557 }, -- Protector's Sword
				{ 12, 19573 }, -- Lorekeeper's Staff
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepRevered3039
				{ 18, 19564 }, -- Outrunner's Bow
				{ 19, 19548 }, -- Sentinel's Blade
				{ 20, 19556 }, -- Protector's Sword
				{ 21, 19572 }, -- Lorekeeper's Staff
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepRevered4049
				{ 24, 19563 }, -- Outrunner's Bow
				{ 25, 19547 }, -- Sentinel's Blade
				{ 26, 19555 }, -- Protector's Sword
				{ 27, 19571 }, -- Lorekeeper's Staff
				{ 101, "f890rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepRevered5059
				{ 103, 19562 }, -- Outrunner's Bow
				{ 104, 19546 }, -- Sentinel's Blade
				{ 105, 19554 }, -- Protector's Sword
				{ 106, 19570 }, -- Lorekeeper's Staff
			},
			[HORDE_DIFF] = {
				{ 1, "f889rep7" },
				{ 2, "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepRevered1019
				{ 3, 20437 }, -- Outrider's Bow
				{ 4, 20441 }, -- Scout's Blade
				{ 5, 20430 }, -- Legionnaire's Sword
				{ 6, 20425 }, -- Advisor's Gnarled Staff
				{ 8, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepRevered2029
				{ 9, 19561 }, -- Outrider's Bow
				{ 10, 19545 }, -- Scout's Blade
				{ 11, 19553 }, -- Legionnaire's Sword
				{ 12, 19569 }, -- Advisor's Gnarled Staff
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepRevered3039
				{ 18, 19560 }, -- Outrider's Bow
				{ 19, 19544 }, -- Scout's Blade
				{ 20, 19552 }, -- Legionnaire's Sword
				{ 21, 19568 }, -- Advisor's Gnarled Staff
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepRevered4049
				{ 24, 19559 }, -- Outrider's Bow
				{ 25, 19543 }, -- Scout's Blade
				{ 26, 19551 }, -- Legionnaire's Sword
				{ 27, 19567 }, -- Advisor's Gnarled Staff
				{ 101, "f889rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepRevered5059
				{ 103, 19558 }, -- Outrider's Bow
				{ 104, 19542 }, -- Scout's Blade
				{ 105, 19550 }, -- Legionnaire's Sword
				{ 106, 19566 }, -- Advisor's Gnarled Staff
			},
		},
		{ -- WSGRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1, "f890rep6" },
				{ 2, "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepHonored1019
				{ 3, 20444 }, -- Sentinel's Medallion
				{ 4, 20428 }, -- Caretaker's Cape
				{ 5, 20431 }, -- Lorekeeper's Ring
				{ 6, 20439 }, -- Protector's Band
				{ 8, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepHonored2029
				{ 9, 19541 }, -- Sentinel's Medallion
				{ 10, 19533 }, -- Caretaker's Cape
				{ 11, 19525 }, -- Lorekeeper's Ring
				{ 12, 19517 }, -- Protector's Band
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepHonored3039
				{ 18, 19540 }, -- Sentinel's Medallion
				{ 19, 19532 }, -- Caretaker's Cape
				{ 20, 19524 }, -- Lorekeeper's Ring
				{ 21, 19515 }, -- Protector's Band
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepHonored4049
				{ 24, 19539 }, -- Sentinel's Medallion
				{ 25, 19531 }, -- Caretaker's Cape
				{ 26, 19523 }, -- Lorekeeper's Ring
				{ 27, 19516 }, -- Protector's Band
				{ 28, 17348 }, -- Major Healing Draught
				{ 29, 17351 }, -- Major Mana Draught
				{ 101, "f890rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepHonored5059
				{ 103, 19538 }, -- Sentinel's Medallion
				{ 104, 19530 }, -- Caretaker's Cape
				{ 105, 19522 }, -- Lorekeeper's Ring
				{ 106, 19514 }, -- Protector's Band
			},
			[HORDE_DIFF] = {
				{ 1, "f889rep6" },
				{ 2, "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepHonored1019
				{ 3, 20444 }, -- Sentinel's Medallion
				{ 4, 20428 }, -- Caretaker's Cape
				{ 5, 20431 }, -- Lorekeeper's Ring
				{ 6, 20439 }, -- Protector's Band
				{ 8, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepHonored2029
				{ 9, 19541 }, -- Sentinel's Medallion
				{ 10, 19533 }, -- Caretaker's Cape
				{ 11, 19525 }, -- Lorekeeper's Ring
				{ 12, 19517 }, -- Protector's Band
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepHonored3039
				{ 18, 19540 }, -- Sentinel's Medallion
				{ 19, 19532 }, -- Caretaker's Cape
				{ 20, 19524 }, -- Lorekeeper's Ring
				{ 21, 19515 }, -- Protector's Band
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepHonored4049
				{ 24, 19539 }, -- Sentinel's Medallion
				{ 25, 19531 }, -- Caretaker's Cape
				{ 26, 19523 }, -- Lorekeeper's Ring
				{ 27, 19516 }, -- Protector's Band
				{ 28, 17348 }, -- Major Healing Draught
				{ 29, 17351 }, -- Major Mana Draught
				{ 101, "f889rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepHonored5059
				{ 103, 19538 }, -- Sentinel's Medallion
				{ 104, 19530 }, -- Caretaker's Cape
				{ 105, 19522 }, -- Lorekeeper's Ring
				{ 106, 19514 }, -- Protector's Band
			},
		},
		{ -- WSGRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1, "f890rep5" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepFriendly2029
				{ 3,  21568 }, -- Rune of Duty
				{ 4,  21566 }, -- Rune of Perfection
				{ 5,  19062 }, -- Warsong Gulch Field Ration
				{ 6,  19068 }, -- Warsong Gulch Silk Bandage
				{ 8, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepFriendly3039
				{ 9,  19061 }, -- Warsong Gulch Iron Ration
				{ 10,  19067 }, -- Warsong Gulch Mageweave Bandage
				{ 11,  17349 }, -- Superior Healing Draught
				{ 12, 17352 }, -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepFriendly4049
				{ 18,  21567 }, -- Rune of Duty
				{ 19,  21565 }, -- Rune of Perfection
				{ 20,  19060 }, -- Warsong Gulch Enriched Ration
				{ 21,  19066 }, -- Warsong Gulch Runecloth Bandage
			},
			[HORDE_DIFF] = {
				{ 1, "f889rep5" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepFriendly2029
				{ 3, 21568 }, -- Rune of Duty
				{ 4, 21566 }, -- Rune of Perfection
				{ 5, 19062 }, -- Warsong Gulch Field Ration
				{ 6, 19068 }, -- Warsong Gulch Silk Bandage
				{ 8, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepFriendly3039
				{ 9, 19061 }, -- Warsong Gulch Iron Ration
				{ 10, 19067 }, -- Warsong Gulch Mageweave Bandage
				{ 11, 17349 }, -- Superior Healing Draught
				{ 12, 17352 }, -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepFriendly4049
				{ 18, 21567 }, -- Rune of Duty
				{ 19, 21565 }, -- Rune of Perfection
				{ 20, 19060 }, -- Warsong Gulch Enriched Ration
				{ 21, 19066 }, -- Warsong Gulch Runecloth Bandage
			},
		},
	},
}

data["ArathiBasin"] = {
	MapID = 3358,
	AtlasMapID = "ArathiBasin",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 4,
	items = {
		{ -- ABRepRevered
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1, "f509rep8" },
				{ 2,  20061 }, -- Highlander's Epaulets
				{ 3,  20060 }, -- Highlander's Lizardhide Shoulders
				{ 4,  20059 }, -- Highlander's Leather Shoulders
				{ 5,  20055 }, -- Highlander's Chain Pauldrons
				{ 6,  20058 }, -- Highlander's Lamellar Spaulders
				{ 7,  20057 }, -- Highlander's Plate Spaulders
				{ 8, 20073 }, -- Cloak of the Honor Guard
				{ 9, 20070 }, -- Sageclaw
				{ 10, 20069 }, -- Ironbark Staff
				{ 17, 20132 }, -- Arathor Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1, "f510rep8" },
				{ 2, 20176 }, -- Defiler's Epaulets
				{ 3, 20175 }, -- Defiler's Lizardhide Shoulders
				{ 4, 20194 }, -- Defiler's Leather Shoulders
				{ 5, 20158 }, -- Defiler's Chain Pauldrons
				{ 6, 20203 }, -- Defiler's Mail Pauldrons
				{ 7, 20212 }, -- Defiler's Plate Spaulders
				{ 8, 20068 }, -- Deathguard's Cloak
				{ 9, 20214 }, -- Mindfang
				{ 10, 20220 }, -- Ironbark Staff
				{ 17, 20131 }, -- Battle Tabard of the Defilers
			},
		},
		{ -- ABRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1, "f509rep7" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepRevered2029
				{ 3,  20096 }, -- Highlander's Cloth Boots
				{ 4,  20114 }, -- Highlander's Leather Boots
				{ 5,  20102 }, -- Highlander's Lizardhide Boots
				{ 6,  20093 }, -- Highlander's Chain Greaves
				{ 7,  20111 }, -- Highlander's Lamellar Greaves
				{ 8,  20129 }, -- Highlander's Plate Greaves
				{ 10, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepRevered3039
				{ 11,  20095 }, -- Highlander's Cloth Boots
				{ 12,  20113 }, -- Highlander's Leather Boots
				{ 13,  20101 }, -- Highlander's Lizardhide Boots
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepRevered4049
				{ 18,  20094 }, -- Highlander's Cloth Boots
				{ 19,  20112 }, -- Highlander's Leather Boots
				{ 20,  20100 }, -- Highlander's Lizardhide Boots
				{ 21,  20091 }, -- Highlander's Chain Greaves
				{ 22,  20109 }, -- Highlander's Lamellar Greaves
				{ 23,  20127 }, -- Highlander's Plate Greaves
				{ 24, 20092 }, -- Highlander's Chain Greaves
				{ 25, 20110 }, -- Highlander's Lamellar Greaves
				{ 26, 20128 }, -- Highlander's Plate Greaves
				{ 101, "f509rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepRevered5059
				{ 103,  20054 }, -- Highlander's Cloth Boots
				{ 104,  20052 }, -- Highlander's Leather Boots
				{ 105,  20053 }, -- Highlander's Lizardhide Boots
				{ 106,  20050 }, -- Highlander's Chain Greaves
				{ 107,  20049 }, -- Highlander's Lamellar Greaves
				{ 108,  20048 }, -- Highlander's Plate Greaves
			},
			[HORDE_DIFF] = {
				{ 1, "f510rep7" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepRevered2029
				{ 3, 20162 }, -- Defiler's Cloth Boots
				{ 4, 20188 }, -- Defiler's Leather Boots
				{ 5, 20169 }, -- Defiler's Lizardhide Boots
				{ 6, 20157 }, -- Defiler's Chain Greaves
				{ 7, 20201 }, -- Defiler's Mail Greaves
				{ 8, 20210 }, -- Defiler's Plate Greaves
				{ 10, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepRevered3039
				{ 11, 20161 }, -- Defiler's Cloth Boots
				{ 12, 20187 }, -- Defiler's Leather Boots
				{ 13, 20168 }, -- Defiler's Lizardhide Boots
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepRevered4049
				{ 18, 20160 }, -- Defiler's Cloth Boots
				{ 19, 20189 }, -- Defiler's Leather Boots
				{ 20, 20170 }, -- Defiler's Lizardhide Boots
				{ 21, 20155 }, -- Defiler's Chain Greaves
				{ 22, 20202 }, -- Defiler's Mail Greaves
				{ 23, 20211 }, -- Defiler's Plate Greaves
				{ 24, 20156 }, -- Defiler's Chain Greaves
				{ 25, 20200 }, -- Defiler's Mail Greaves
				{ 26, 20209 }, -- Defiler's Plate Greaves
				{ 101, "f510rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepRevered5059
				{ 103, 20159 }, -- Defiler's Cloth Boots
				{ 104, 20186 }, -- Defiler's Leather Boots
				{ 105, 20167 }, -- Defiler's Lizardhide Boots
				{ 106, 20154 }, -- Defiler's Chain Greaves
				{ 107, 20199 }, -- Defiler's Mail Greaves
				{ 108, 20208 }, -- Defiler's Plate Greaves
			},
		},
		{ -- ABRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1, "f509rep6" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepHonored2029
				{ 3,  20099 }, -- Highlander's Cloth Girdle
				{ 4,  20117 }, -- Highlander's Leather Girdle
				{ 5,  20105 }, -- Highlander's Lizardhide Girdle
				{ 6,  20090 }, -- Highlander's Chain Girdle
				{ 7,  20108 }, -- Highlander's Lamellar Girdle
				{ 8,  20126 }, -- Highlander's Plate Girdle
				{ 10, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepHonored3039
				{ 11,  20098 }, -- Highlander's Cloth Girdle
				{ 12,  20116 }, -- Highlander's Leather Girdle
				{ 13,  20104 }, -- Highlander's Lizardhide Girdle
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepHonored4049
				{ 18,  20097 }, -- Highlander's Cloth Girdle
				{ 19,  20115 }, -- Highlander's Leather Girdle
				{ 20,  20103 }, -- Highlander's Lizardhide Girdle
				{ 21,  20088 }, -- Highlander's Chain Girdle
				{ 22,  20106 }, -- Highlander's Lamellar Girdle
				{ 23,  20124 }, -- Highlander's Plate Girdle
				{ 24, 20089 }, -- Highlander's Chain Girdle
				{ 25, 20107 }, -- Highlander's Lamellar Girdle
				{ 26, 20125 }, -- Highlander's Plate Girdle
				{ 101, "f509rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepHonored5059
				{ 103,  20047 }, -- Highlander's Cloth Girdle
				{ 104,  20045 }, -- Highlander's Leather Girdle
				{ 105,  20046 }, -- Highlander's Lizardhide Girdle
				{ 106,  20043 }, -- Highlander's Chain Girdle
				{ 107,  20042 }, -- Highlander's Lamellar Girdle
				{ 108,  20041 }, -- Highlander's Plate Girdle
			},
			[HORDE_DIFF] = {
				{ 1, "f510rep6" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepHonored2029
				{ 3, 20164 }, -- Defiler's Cloth Girdle
				{ 4, 20191 }, -- Defiler's Leather Girdle
				{ 5, 20172 }, -- Defiler's Lizardhide Girdle
				{ 6, 20152 }, -- Defiler's Chain Girdle
				{ 7, 20197 }, -- Defiler's Mail Girdle
				{ 8, 20207 }, -- Defiler's Plate Girdle
				{ 10, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepHonored3039
				{ 11, 20166 }, -- Defiler's Cloth Girdle
				{ 12, 20192 }, -- Defiler's Leather Girdle
				{ 13, 20173 }, -- Defiler's Lizardhide Girdle
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepHonored4049
				{ 18, 20165 }, -- Defiler's Cloth Girdle
				{ 19, 20193 }, -- Defiler's Leather Girdle
				{ 20, 20174 }, -- Defiler's Lizardhide Girdle
				{ 21, 20151 }, -- Defiler's Chain Girdle
				{ 22, 20196 }, -- Defiler's Mail Girdle
				{ 23, 20205 }, -- Defiler's Plate Girdle
				{ 24, 20153 }, -- Defiler's Chain Girdle
				{ 25, 20198 }, -- Defiler's Mail Girdle
				{ 26, 20206 }, -- Defiler's Plate Girdle
				{ 101, "f510rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepHonored5059
				{ 103, 20163 }, -- Defiler's Cloth Girdle
				{ 104, 20190 }, -- Defiler's Leather Girdle
				{ 105, 20171 }, -- Defiler's Lizardhide Girdle
				{ 106, 20150 }, -- Defiler's Chain Girdle
				{ 107, 20195 }, -- Defiler's Mail Girdle
				{ 108, 20204 }, -- Defiler's Plate Girdle
			},
		},
		{ -- ABRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1, "f509rep5" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepFriendly2029
				{ 3,  21119 }, -- Talisman of Arathor
				{ 4,  20226 }, -- Highlander's Field Ration
				{ 5,  20244 }, -- Highlander's Silk Bandage
				{ 7, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepFriendly3039
				{ 8,  21118 }, -- Talisman of Arathor
				{ 9,  20227 }, -- Highlander's Iron Ration
				{ 10,  20237 }, -- Highlander's Mageweave Bandage
				{ 11,  17349 }, -- Superior Healing Draught
				{ 12,  17352 }, -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepFriendly4049
				{ 18,  21117 }, -- Talisman of Arathor
				{ 19,  20225 }, -- Highlander's Enriched Ration
				{ 20,  20243 }, -- Highlander's Runecloth Bandage
				{ 22, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepFriendly5059
				{ 23,  20071 }, -- Talisman of Arathor
			},
			[HORDE_DIFF] = {
				{ 1, "f510rep5" },
				{ 2, "INV_Box_01", nil, "20 - 29", nil }, -- ABRepFriendly2029
				{ 3, 21120 }, -- Defiler's Talisman
				{ 4, 20223 }, -- Defiler's Field Ration
				{ 5, 20235 }, -- Defiler's Silk Bandage
				{ 7, "INV_Box_01", nil, "30 - 39", nil }, -- ABRepFriendly3039
				{ 8, 21116 }, -- Defiler's Talisman
				{ 9, 20224 }, -- Defiler's Iron Ration
				{ 10, 20232 }, -- Defiler's Mageweave Bandage
				{ 11, 17349 }, -- Superior Healing Draught
				{ 12, 17352 }, -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepFriendly4049
				{ 18, 21115 }, -- Defiler's Talisman
				{ 19, 20222 }, -- Defiler's Enriched Ration
				{ 20, 20234 }, -- Defiler's Runecloth Bandage
				{ 22, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepFriendly5059
				{ 23, 20072 }, -- Defiler's Talisman
			},
		},
	},
}

data["ClassSets"] = {
	name = AL["Class Sets"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 2,
	items = {
		{ -- Epic
			name = ALIL["Epic"],
			ContentPhase = 2,
			[ALLIANCE_DIFF] = {
				{ 1, 392 }, -- Warlock
				{ 3, 389 }, -- Priest
				{ 16, 388 }, -- Mage
				{ 5, 394 }, -- Rogue
				{ 20, 397 }, -- Druid
				{ 7, 395 }, -- Hunter
				{ 9, 384 }, -- Warrior
				{ 24, 402 }, -- Paladin
			},

			[HORDE_DIFF] = {
				{ 1, 391 }, -- Warlock
				{ 3, 390 }, -- Priest
				{ 16, 387 }, -- Mage
				{ 5, 393 }, -- Rogue
				{ 20, 398 }, -- Druid
				{ 7, 396 }, -- Hunter
				{ 9, 383 }, -- Warrior
				{ 22, 386 }, -- Shaman
			},
		},
		{ -- Rare
			name = ALIL["Rare"],
			ContentPhase = 6,
			[ALLIANCE_DIFF] = {
				{ 1, 547 }, -- Warlock
				{ 3, 549 }, -- Priest
				{ 16, 546 }, -- Mage
				{ 5, 548 }, -- Rogue
				{ 20, 539 }, -- Druid
				{ 7, 550 }, -- Hunter
				{ 9, 545 }, -- Warrior
				{ 24, 544 }, -- Paladin
			},

			[HORDE_DIFF] = {
				{ 1, 541 }, -- Warlock
				{ 3, 540 }, -- Priest
				{ 16, 542 }, -- Mage
				{ 5, 522 }, -- Rogue
				{ 20, 539 }, -- Druid
				{ 7, 543 }, -- Hunter
				{ 9, 537 }, -- Warrior
				{ 22, 538 }, -- Shaman
			},
		},
	},
}

data["Weapons"] = {
	name = AL["Weapons"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2,
	items = {
		{ -- PVPWeapons
			name = AL["Weapons"],
			[ALLIANCE_DIFF] = {
				{ 1,  18827 }, -- Grand Marshal's Handaxe
				{ 2,  18830 }, -- Grand Marshal's Sunderer
				{ 3,  18838 }, -- Grand Marshal's Dirk
				{ 4,  23451 }, -- Grand Marshal's Mageblade
				{ 5,  18843 }, -- Grand Marshal's Right Hand Blade
				{ 6,  18847 }, -- Grand Marshal's Left Hand Blade
				{ 7,  18865 }, -- Grand Marshal's Punisher
				{ 8, 23454 }, -- Grand Marshal's Warhammer
				{ 9, 23455 }, -- Grand Marshal's Demolisher
				{ 10, 18867 }, -- Grand Marshal's Battle Hammer
				{ 11, 12584 }, -- Grand Marshal's Longsword
				{ 12, 23456 }, -- Grand Marshal's Swiftblade
				{ 13, 18876 }, -- Grand Marshal's Claymore
				{ 16,  18869 }, -- Grand Marshal's Glaive
				{ 17,  18873 }, -- Grand Marshal's Stave
				{ 18,  18833 }, -- Grand Marshal's Bullseye
				{ 19,  18836 }, -- Grand Marshal's Repeater
				{ 20,  18855 }, -- Grand Marshal's Hand Cannon
				{ 21,  18825 }, -- Grand Marshal's Aegis
				{ 22,  23452 }, -- Grand Marshal's Tome of Power
				{ 23, 23453 }, -- Grand Marshal's Tome of Restoration
			},
			[HORDE_DIFF] = {
				{ 1, 18828 }, -- High Warlord's Cleaver
				{ 2, 18831 }, -- High Warlord's Battle Axe
				{ 3, 18840 }, -- High Warlord's Razor
				{ 4, 23466 }, -- High Warlord's Spellblade
				{ 5, 18844 }, -- High Warlord's Right Claw
				{ 6, 18848 }, -- High Warlord's Left Claw
				{ 7, 18866 }, -- High Warlord's Bludgeon
				{ 8, 23464 }, -- High Warlord's Battle Mace
				{ 9, 23465 }, -- High Warlord's Destroyer
				{ 10, 18868 }, -- High Warlord's Pulverizer
				{ 11, 16345 }, -- High Warlord's Blade
				{ 12, 23467 }, -- High Warlord's Quickblade
				{ 13, 18877 }, -- High Warlord's Greatsword
				{ 16, 18871 }, -- High Warlord's Pig Sticker
				{ 17, 18874 }, -- High Warlord's War Staff
				{ 18, 18835 }, -- High Warlord's Recurve
				{ 19, 18837 }, -- High Warlord's Crossbow
				{ 20, 18860 }, -- High Warlord's Street Sweeper
				{ 21, 18826 }, -- High Warlord's Shield Wall
				{ 22, 23468 }, -- High Warlord's Tome of Destruction
				{ 23, 23469 }, -- High Warlord's Tome of Mending
			},
		},
	},
}

data["Mounts"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2,
	items = {
		{ -- PvPMountsPvP
			name = ALIL["Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,  19030 }, -- Stormpike Battle Charger
				{ 2,  18244 }, -- Black War Ram
				{ 3,  18243 }, -- Black Battlestrider
				{ 4,  18241 }, -- Black War Steed Bridle
				{ 5,  18242 }, -- Reins of the Black War Tiger
			},
			[HORDE_DIFF] = {
				{ 1, 19029 }, -- Horn of the Frostwolf Howler
				{ 2, 18245 }, -- Horn of the Black War Wolf
				{ 3, 18247 }, -- Black War Kodo
				{ 4, 18246 }, -- Whistle of the Black War Raptor
				{ 5, 18248 }, -- Red Skeletal Warhorse
			},
		},
	}
}

data["Insignia"] = {
	name = AL["Insignia"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2,
	items = {
		{
			name = AL["Insignia"],
			[ALLIANCE_DIFF] = {
				{ 1,  18854 }, -- Warrior
				{ 2,  18856 }, -- Hunter
				{ 3,  18857 }, -- Rogue
				{ 4,  18858 }, -- Warlock
				{ 5,  18862 }, -- Priest
				{ 6,  18863 }, -- Druid
				{ 7,  18864 }, -- Paladin
				{ 8,  18859 }, -- Mage

			},
			[HORDE_DIFF] = {
				{ 1,  18834 }, -- Warrior
				{ 2,  18846 }, -- Hunter
				{ 3,  18849 }, -- Rogue
				{ 4,  18852 }, -- Warlock
				{ 5,  18851 }, -- Priest
				{ 6,  18853 }, -- Druid
				{ 7,  18845 }, -- Shaman
				{ 8,  18850 }, -- Mage
			},
		},
	}
}
