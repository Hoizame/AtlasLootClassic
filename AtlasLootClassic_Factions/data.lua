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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)

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

local AD_INSIGNIA_FORMAT_BLUE, AD_INSIGNIA_FORMAT_EPIC = "|cff0070dd%d|r",  "|cffa335ee%d|r" -- format(AD_INSIGNIA_FORMAT, 30)
data["ArgentDawn"] = {
	FactionID = 529,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = _G["FACTION_STANDING_LABEL8"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep7" },
				{ 2, 18182 }, -- Chromatic Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 27), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 27) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 6), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 6) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Revered
			name = _G["FACTION_STANDING_LABEL7"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep7" },
				{ 2, 13810 }, -- Blessed Sunfruit
				{ 3, 13813 }, -- Blessed Sunfruit Juice
				{ 5,  19217 }, -- Pattern: Argent Shoulders
				{ 6,  19329 }, -- Pattern: Golden Mantle of the Dawn
				{ 7,  19205 }, -- Plans: Gloves of the Dawn
				{ 8,  19447 }, -- Formula: Enchant Bracer - Healing
				{ 10,  18171 }, -- Arcane Mantle of the Dawn
				{ 11,  18169 }, -- Flame Mantle of the Dawn
				{ 12,  18170 }, -- Frost Mantle of the Dawn
				{ 13,  18172 }, -- Nature Mantle of the Dawn
				{ 14, 18173 }, -- Shadow Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 45), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 45) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 7), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 7) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Honored
			name = _G["FACTION_STANDING_LABEL6"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep6" },
				{ 2,  19216 }, -- Pattern: Argent Boots
				{ 3,  19328 }, -- Pattern: Dawn Treaders
				{ 4,  19203 }, -- Plans: Girdle of the Dawn
				{ 5,  19442 }, -- Formula: Powerful Anti-Venom
				{ 6,  19446 }, -- Formula: Enchant Bracer - Mana Regeneration
				{ 7, 13482 }, -- Recipe: Transmute Air to Fire
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 75), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 75) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 20), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 20) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Friendly
			name = _G["FACTION_STANDING_LABEL5"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep5" },
				{ 2,  13724 }, -- Enriched Manna Biscuit
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 110), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 110) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 30), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 30) }, -- Insignia of the Dawn / Crusade
			},
		},
	},
}