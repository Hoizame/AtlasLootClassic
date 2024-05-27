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
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [NORMAL_DIFF] = { -- Mage
        {1, 60244}, -- Firelord's Robes
        {2, 60247}, -- Firelord's Gloves
        {3, 60245}, -- Firelord's Leggings
        -- Warlock
        {5, 60251}, -- Shadowflame Robes
        {6, 60248}, -- Shadowflame Handwraps
        {7, 60250}, -- Shadowflame Leggings
        -- Priest
        {16, 60259}, -- Mercurial Robes
        {17, 60275}, -- Mercurial Handwraps
        {18, 60261}, -- Mercurial Legwraps
        {20, 60254}, -- Mercurial Vestment
        {21, 60257}, -- Mercurial Gloves
        {22, 60255}, -- Mercurial Leggings
        -- Misc
        {9, 58485}, -- Melodious Slippers
        {10, 58486} -- Slippers of Moving Waters
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [NORMAL_DIFF] = { -- Druid
        {1, 60276}, -- Stormrider's Robes
        {2, 60280}, -- Stormrider's Handwraps
        {3, 60278}, -- Stormrider's Legwraps
        {5, 60287}, -- Stormrider's Raiment
        {6, 60290}, -- Stormrider's Grips
        {7, 60288}, -- Stormrider's Legguards
        {9, 60281}, -- Stormrider's Vestment
        {10, 60285}, -- Stormrider's Gloves
        {11, 60283}, -- Stormrider's Leggings
        -- Rouge
        {16, 60301}, -- Wind Dancer's Tunic
        {17, 60298}, -- Wind Dancer's Gloves
        {18, 60300}, -- Wind Dancer's Legguards
        -- Misc
        {13, 58482}, -- Treads of Fleeting Joy
        {14, 58484} -- Fading Violet Sandals
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [NORMAL_DIFF] = { -- Shaman
        {1, 60313}, -- Hauberk of the Raging Elements
        {2, 60314}, -- Gloves of the Raging Elements
        {3, 60316}, -- Kilt of the Raging Elements
        {5, 60309}, -- Tunic of the Raging Elements
        {6, 60312}, -- Handwraps of the Raging Elements
        {7, 60310}, -- Legwraps of the Raging Elements
        {9, 60318}, -- Cuirass of the Raging Elements
        {10, 60319}, -- Grips of the Raging Elements
        {11, 60321}, -- Legguards of the Raging Elements
        -- Rouge
        {16, 60304}, -- Lightning-Charged Tunic
        {17, 60307}, -- Lightning-Charged Gloves
        {18, 60305}, -- Lightning-Charged Legguards
        -- Misc
        {13, 58199}, -- Moccasins of Verdurous Glooms
        {14, 58481} -- Boots of the Perilous Seas
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [NORMAL_DIFF] = { -- Paladin
        {1, 60360}, -- Reinforced Sapphirium Breastplate
        {2, 60363}, -- Reinforced Sapphirium Gloves
        {3, 60361}, -- Reinforced Sapphirium Greaves
        {4, 60344}, -- Reinforced Sapphirium Battleplate
        {5, 60345}, -- Reinforced Sapphirium Gauntlets
        {6, 60347}, -- Reinforced Sapphirium Legplates
        {7, 60354}, -- Reinforced Sapphirium Chestguard
        {8, 60355}, -- Reinforced Sapphirium Handguards
        {9, 60357}, -- Reinforced Sapphirium Legguards
        -- Warrior
        {11, 60323}, -- Earthen Battleplate
        {12, 60326}, -- Earthen Gauntlets
        {13, 60324}, -- Earthen Legplates
        {16, 60329}, -- Earthen Chestguard
        {17, 60332}, -- Earthen Handguards
        {18, 60330}, -- Earthen Legguards
        -- DK
        {20, 60339}, -- Magma Plated Battleplate
        {21, 60340}, -- Magma Plated Gauntlets
        {22, 60342}, -- Magma Plated Legplates
        {24, 60349}, -- Magma Plated Chestguard
        {25, 60350}, -- Magma Plated Handguards
        {26, 60352}, -- Magma Plated Legguards
        -- Misc
        {28, 58197}, -- Rock Furrow Boots
        {29, 58198}, -- Eternal Pathfinders
        {30, 58195} -- Woe Breeder's Boots
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Back"],
        [NORMAL_DIFF] = { -- Head
        {1, 58191}, -- Viewless Wings
        {2, 58194}, -- Heavenly Breeze
        {3, 58193}, -- Haunt of Flies
        {4, 58190}, -- Floating Web
        {5, 58192} -- Gray Hair Cloak
        }
    }, {
        name = ALIL["Armor"] .. " - " .. ALIL["Ring"],
        [NORMAL_DIFF] = { -- Head
        {1, 58189}, -- Twined Band of Flowers
        {2, 58188}, -- Band of Secret Names
        {3, 58185}, -- Band of Bees
        {4, 68812}, -- Hornet-Sting Band
        {5, 58187} -- Ring of the Battle Anthem
        }
    }, {
        name = ALIL["Relic"],
        [NORMAL_DIFF] = { -- Head
        {1, 64673}, -- Throat Slasher
        {2, 64674}, -- Windslicer
        {3, 64671}, -- Dawnblaze Blade
        {4, 64676}, -- Shield of the Four Grey Towers
        {5, 64672} -- Shield of the Mists
        }
    }, {
        name = ALIL["Trinket"],
        [NORMAL_DIFF] = { -- Head
        {1, 58180}, -- License to Slay
        {2, 58181}, -- Fluid Death
        {3, 58183}, -- Soul Casket
        {4, 58184}, -- Core of Ripeness
        {5, 58182} -- Bedrock Talisman
        }
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
        [NORMAL_ITTYPE] = {
            {1, 67131}, -- Ritssyn's Ruminous Drape
            {2, 67141}, -- Corefire Legplates
            {3, 67130}, -- Dorian's Lost Necklace
            {4, 67140}, -- Drape of Inimitable Fate
            {5, 67134}, -- Dory's Finery
            {6, 67137}, -- Don Rodrigo's Fabulous Necklace
            {7, 67139}, -- Blauvelt's Family Crest
            {8, 67136}, -- Gilnean Ring of Ruination
            {9, 67144}, -- Pauldrons of Edward the Odd
            {10, 67148}, -- Kilt of Trollish Dreams
            {11, 67129}, -- Signet of High Arcanist Savor
            {12, 67135}, -- Morrie's Waywalker Wrap
            {13, 67133}, -- Dizze's Whirling Robe
            {14, 67138}, -- Buc-Zakai Choker
            {15, 67150}, -- Arrowsinger Legguards
            {16, 67149}, -- Heartbound Tome
            {17, 67145}, -- Blockade's Lost Shield
            {18, 67143}, -- Icebone Hauberk
            {19, 67147}, -- Je'Tze's Sparkling Tiara
            {20, 67146}, -- Woundsplicer Handwraps
            {21, 67132}, -- Grips of the Failed Immortal
            {22, 67142}, -- Zom's Electrostatic Cloak
        }
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
        [NORMAL_DIFF] = {{1, 72140}, -- Vicious War Wolf
                        {2, 71339}, -- Vicious Gladiator's Twilight Drake
                        {3, 70910}, -- Ruthless Gladiator's Twilight Drake
        }
    }, { -- Drops
        name = AL["Drops"],
        [NORMAL_DIFF] = {{1, 63043}, -- Reins of the Vitreous Stone Drake
                        {2, 63039}, -- Reins of the Drake of the West Wind
                        {3, 63040}, -- Reins of the Drake of the North Wind
                        {4, 44168}, -- Reins of the Time-Lost Proto-Drake
                        {5, 45693}, -- Mimiron's Head
                        {6, 50818}, -- Invincible's Reins
                        {7, 77069}, -- Smoldering Egg of Millagazor
                        {8, 78924}, -- Flametalon of Alysrazor
                        {9, 77068}, -- Life-Binder's Handmaiden
                        {10, 69747}, -- Amani Battle Bear
        }
    }, {
        name = AL["Crafting"],
        [NORMAL_DIFF] = {{1, 65891}, -- Vial of the Sands
                        {2, 41508}, -- Mechano-Hog
                        {3, 34061}, -- Turbo-Charged Flying Machine
                        {4, 44558}, -- Magnificent Flying Carpet
                        {5, 54797}, -- Frosty Flying Carpet
        }
    }, {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {{1, 46109}, -- Sea Turtle
        }
    }, {
        name = AL["Quest"],
        [NORMAL_DIFF] = {{1, 63041}, -- Reins of the Drake of the South Wind
                        {2, 44151}, -- Reins of the Blue Proto-Drake
                        {3, 44178}, -- Reins of the Albino Drake
        }
    }, {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {{1, 44177}, -- Reins of the Violet Proto-Drake
                        {2, 44160}, -- Reins of the Red Proto-Drake
                        {3, 45801}, -- Reins of the Ironbound Proto-Drake
                        {4, 45802}, -- Reins of the Rusted Proto-Drake
                        {5, 51954}, -- Reins of the Bloodbathed Frostbrood Vanquisher
                        {6, 51955}, -- Reins of the Icebound Frostbrood Vanquisher
        }
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
        [ALLIANCE_DIFF] = {
            {1, 65904}, -- Tabard of the Ramkahen
            {2, 65905}, -- Tabard of the Earthen Ring
            {3, 65906}, -- Tabard of the Guardians of Hyjal
            {4, 65907}, -- Tabard of Therazane
            {5, 65908}, -- Tabard of the Wildhammer Clan
        },
        [HORDE_DIFF] = {
            {1, 65909}, -- Tabard of the Dragonmaw Clan
            {2, 65910}, -- Tabard of the Earthen Ring
            {3, 65911}, -- Tabard of the Guardians of Hyjal
            {4, 65912}, -- Tabard of Therazane
            {5, 65913}, -- Tabard of the Ramkahen
        }
    }, {
        name = AL["PvP"],
        CoinTexture = "PvP",
        [NORMAL_DIFF] = {
            {1, 63379}, -- Baradin's Wardens Tabard (Alliance)
            {2, 63378}, -- Hellscream's Reach Tabard (Horde)
        }
    }, {
        name = AL["Achievements"],
        CoinTexture = "Achievement",
        [NORMAL_DIFF] = {
            {1, 43349}, -- Tabard of Brute Force
            {2, 43348}, -- Tabard of the Achiever
            {3, 40643}, -- Tabard of the Explorer
        }
    }, {
        name = AL["Misc"],
        CoinTexture = "Misc",
        [NORMAL_DIFF] = {
            {1, 35280}, -- Tabard of Summer Flames
            {2, 35279}, -- Tabard of Summer Skies
            {3, 89196}, -- Theramore Tabard
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
