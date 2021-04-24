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
local data = AtlasLoot.ItemDB:Add(addonname, 1, 2)

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
local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]

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

data["AlteracValleyBC"] = {
	MapID = 2597,
	AtlasMapID = "AlteracValley",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2.5,
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
