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

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1)
local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF 
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

local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)



data["TierSets"] = {
	name = AL["Tier Sets"],
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	items = {
		{ -- T1
			name = "T1",
			[ALLIANCE_DIFF] = {
				{ 1, "SetID:203:n" }, -- Warlock
				{ 3, "SetID:202:n" }, -- Priest
				{ 16, "SetID:201:n" }, -- Mage
				{ 5, "SetID:204:n" }, -- Rogue
				{ 20, "SetID:205:n" }, -- Druid
				{ 7, "SetID:206:n" }, -- Hunter
				{ 9, "SetID:209:n" }, -- Warrior
				{ 24, "SetID:208:n" }, -- Paladin
			},
			
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, "SetID:207:n" }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
		{ -- T2
			name = "T2",
			[ALLIANCE_DIFF] = {
				{ 1, "SetID:212:n" }, -- Warlock
				{ 3, "SetID:211:n" }, -- Priest
				{ 16, "SetID:210:n" }, -- Mage
				{ 5, "SetID:213:n" }, -- Rogue
				{ 20, "SetID:214:n" }, -- Druid
				{ 7, "SetID:215:n" }, -- Hunter
				{ 9, "SetID:218:n" }, -- Warrior
				{ 24, "SetID:217:n" }, -- Paladin
			},
			
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, "SetID:216:n" }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
		{ -- T3
			name = "T3",
			[ALLIANCE_DIFF] = {
				{ 1, "SetID:529:n" }, -- Warlock
				{ 3, "SetID:525:n" }, -- Priest
				{ 16, "SetID:526:n" }, -- Mage
				{ 5, "SetID:524:n" }, -- Rogue
				{ 20, "SetID:521:n" }, -- Druid
				{ 7, "SetID:530:n" }, -- Hunter
				{ 9, "SetID:523:n" }, -- Warrior
				{ 24, "SetID:528:n" }, -- Paladin
			},
			
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, "SetID:527:n" }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
	},
	
}