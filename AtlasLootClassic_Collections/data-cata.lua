-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
    local d = C_Map.GetAreaInfo(id)
    return d or "GetAreaInfo" .. id
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then
    return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
-- local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
-- local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

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
local AC_ITTYPE = data:AddItemTableType("Item", "Achievement")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
-- local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local BLUE = "|cff6666ff%s|r"
-- local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
-- local WHIT = "|cffffffff%s|r"

data["CookingCata"] = {
    name = format(AL["'%s' Recipes"], ALIL["Cooking"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = AL["Misc"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["Recipe"],
        [NORMAL_DIFF] = {}
    }}
}

data["JusticePoints"] = {
    name = format(AL["'%s' Vendor"], AL["Justice Points"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [NORMAL_DIFF] = { -- Head
        {1, 58155}, -- Cowl of Pleasant Gloom
        {16, 58161}, -- Mask of New Snow
        -- Shoulder
        {3, 58157}, -- Meadow Mantle
        {18, 58162}, -- Summer Song Shoulderwraps
        -- Chest
        {5, 58153}, -- Robes of Embalmed Darkness
        {20, 58159}, -- Musk Rose Robes
        -- Hands
        {7, 58158}, -- Gloves of the Painless Midnight
        {22, 58163}, -- Gloves of Purification
        -- Waist
        {9, 57921}, -- Incense Infused Cummerbund
        {24, 57922}, -- Belt of the Falling Rain
        -- Legs
        {11, 58154}, -- Pensive Legwraps
        {26, 58160} -- Leggings of Charity
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [NORMAL_DIFF] = { -- Head
        {1, 58150}, -- Cluster of Stars
        {16, 58133}, -- Mask of Vines
        -- Shoulder
        {3, 58151}, -- Somber Shawl
        {18, 58134}, -- Embrace of the Night
        -- Chest
        {5, 58139}, -- Chestguard of Forgetfulness
        {20, 58131}, -- Tunic of Sinking Envy
        -- Hands
        {7, 58152}, -- Blessed Hands of Elune
        {22, 58138}, -- Sticky Fingers
        -- Waist
        {9, 57919}, -- Thatch Eave Vines
        {24, 57918}, -- Sash of Musing
        -- Legs
        {11, 58140}, -- Leggings of Late Blooms
        {26, 58132} -- Leggings of the Burrowing Mole
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [NORMAL_DIFF] = { -- Head
        {1, 58128}, -- Helm of the Inward Eye
        {16, 58123}, -- Willow Mask
        -- Shoulder
        {3, 58129}, -- Seafoam Mantle
        {18, 58124}, -- Wrap of the Valley Glades
        -- Chest
        {5, 58126}, -- Vest of the Waking Dream
        {20, 58121}, -- Vest of the True Companion
        -- Hands
        {7, 58130}, -- Gleaning Gloves
        {22, 58125}, -- Gloves of the Passing Night
        -- Waist
        {9, 57917}, -- Belt of the Still Stream
        {24, 57916}, -- Belt of the Dim Forest
        -- Legs
        {11, 58127}, -- Leggings of Soothing Silence
        {26, 58122} -- Hillside Striders
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [NORMAL_DIFF] = { -- Head
        {1, 58103}, -- Helm of the Proud
        {2, 58098}, -- Helm of Easeful Death
        {3, 58108}, -- Crown of the Blazing Sun
        -- Shoulder
        {5, 58104}, -- Sunburnt Pauldrons
        {6, 58100}, -- Pauldrons of the High Requiem
        {7, 58109}, -- Pauldrons of the Forlorn
        -- Chest
        {9, 58101}, -- Chestplate of the Steadfast
        {10, 58096}, -- Breastplate of Raging Fury
        {11, 58106}, -- Chestguard of Dancing Waves
        -- Hands
        {16, 58105}, -- Numbing Handguards
        {17, 58099}, -- Reaping Gauntlets
        {18, 58110}, -- Gloves of Curious Conscience
        -- Waist
        {20, 57914}, -- Girdle of the Mountains
        {21, 57913}, -- Beech Green Belt
        {22, 57915}, -- Belt of Barred Clouds
        -- Legs
        {24, 58102}, -- Greaves of Splendor
        {25, 58097}, -- Greaves of Gallantry
        {26, 58107} -- Legguards of the Gentle
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Neck"],
        [NORMAL_DIFF] = { -- Head
        {1, 57932}, -- The Lustrous Eye
        {2, 57934}, -- Celadon Pendant
        {3, 57933}, -- String of Beaded Bubbles
        {4, 57931}, -- Amulet of Dull Dreaming
        {5, 57930} -- Pendant of Quiet Breath
        }
    }, {
        name = ALIL["Off-Hand/Shield"],
        [NORMAL_DIFF] = { -- Head
        {1, 57927}, -- Throat Slasher
        {2, 57928}, -- Windslicer
        {3, 57929}, -- Dawnblaze Blade
        {5, 57926}, -- Shield of the Four Grey Towers
        {6, 57925}, -- Shield of the Mists
        {8, 57924}, -- Apple-Bent Bough
        {9, 57923} -- Hermit's Lamp
        }
    }, {
        name = ALIL["Misc"],
        [NORMAL_DIFF] = { -- Head
        {1, 52185}, -- Elementium Ore
        {2, 53010}, -- Embersilk Cloth
        {3, 52976}, -- Savage Leather
        {4, 52721}, -- Heavenly Shard
        {5, 52555}, -- Hypnotic Dust
        {6, 68813}, -- Satchel of Freshly-Picked Herbs
        {7, 52719} -- Greater Celestial Essence
        }
    }}
}

data["ValorPoints"] = {
    name = format(AL["'%s' Vendor"], AL["ValorPoints"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Cloak"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Finger"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Relic"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["Token"],
        [NORMAL_DIFF] = {}
    }}
}

-- shared!
data["WorldEpicsCata"] = {
    name = AL["World Epics"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.WORLD_EPICS,
    items = {{
        name = AL["World Epics"],
        [NORMAL_ITTYPE] = {}
    }}
}

data["MountsCata"] = {
    name = ALIL["Mounts"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.MOUNTS,
    items = {{
        name = AL["PvP"],
        [NORMAL_DIFF] = {}
    }, { -- Drops
        name = AL["Drops"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["Crafting"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["Quest"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {}
    }}
}

data["CompanionsCata"] = {
    name = ALIL["Companions"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.COMPANIONS,
    items = {{
        name = AL["Drops"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {}
    }, {
        name = AL["World Events"],
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {}
    }, {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {}
    }, { -- Misc
        name = AL["Misc"],
        [NORMAL_DIFF] = {}
    }}
}

data["TabardsCata"] = {
    name = ALIL["Tabard"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.TABARDS,
    items = {{
        name = AL["Factions"],
        CoinTexture = "Reputation",
        [ALLIANCE_DIFF] = {{1, 43155}, -- Tabard of the Ebon Blade
        {2, 43157}, -- Tabard of the Kirin Tor
        {3, 43156} -- Tabard of the Wyrmrest Accord
        }
    }}
}

data["LegendariesCata"] = {
    name = AL["Legendaries"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.LEGENDARYS,
    items = {{
        name = AL["Lengendaries"],
        [NORMAL_ITTYPE] = {{1, 71086, "ac5839"}, -- Dragonwrath, Tarecgosa's Rest
        {16, 77949, "ac6181"}, -- Golad, Twilight of Aspects
        {17, 77950, "ac6181"} -- 	Tiriosh, Nightmare of Ages
        }
    }}
}

data["HeirloomCata"] = {
    name = AL["Heirloom"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"],
        [NORMAL_ITTYPE] = {}
    }, {
        name = ALIL["Weapon"],
        [NORMAL_ITTYPE] = {}
    }, {
        name = ALIL["Trinket"],
        [NORMAL_ITTYPE] = {}
    }, {
        name = ALIL["Finger"],
        [NORMAL_ITTYPE] = {}
    }, {
        name = AL["Misc"],
        [NORMAL_ITTYPE] = {}
    }}
}
