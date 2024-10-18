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
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

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

--local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
--local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
--local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
--local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], {0.1, 0.3, 0.1, 1})

local FACTIONS_HORDE_CONTENT, FACTIONS_ALLI_CONTENT
if UnitFactionGroup("player") == "Horde" then
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
else
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
end

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

data["AvengersOfHyjal"] = {
    FactionID = 1204,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1204rep8"},
                {2, 71237}, -- Quicksilver Signet of the Avengers
                {3, 71215}, -- Obsidian Signet of the Avengers
                {4, 70934}, -- Adamantine Signet of the Avengers
                {5, 71216}, -- Viridian Signet of the Avengers
                {6, 71217}, -- Infernal Signet of the Avengers
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1204rep7"},
                {2, 69001}, -- Ancient Petrified Seed
                {3, 68998}, -- Rune of Zeth
                {4, 69000}, -- Fiery Quintessence
                {5, 68996}, -- Stay of Execution
                {6, 69002}, -- Essence of the Eternal Flame
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1204rep6"},
                {2, 71258}, -- Embereye Belt
                {3, 71249}, -- Firescar Sash
                {4, 71131}, -- Flamebinding Girdle
                {5, 71254}, -- Firemend Cinch
                {6, 71255}, -- Firearrow Belt
                {7, 71250}, -- Cinch of the Flaming Ember
                {8, 70933}, -- Girdle of the Indomitable Flame
                {9, 71253}, -- Belt of the Seven Seals
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1204rep5"},
                {2, 71229}, -- Flowing Flamewrath Cape
                {3, 71227}, -- Bladed Flamewrath Cover
                {4, 70930}, -- Durable Flamewrath Greatcloak
                {5, 71228}, -- Sleek Flamewrath Cloak
                {6, 71230}, -- Rippling Flamewrath Drape
            },
        },
    },
}data["BaradinsWardens"] = {
    FactionID = 1177,
    ContentType = FACTIONS_ALLI_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [ALLIANCE_DIFF] = {
                {1, "f1177rep8"},
                {2, 63039}, -- Reins of the Drake of the West Wind
                {3, 64998}, -- Reins of the Spectral Steed
                {5, 62468}, -- Unsolvable Riddle
                {6, 62469}, -- Impatience of Youth
                {7, 62470}, -- Stump of Time
                {8, 62471}, -- Mirror of Broken Images
                {9, 62472}, -- Mandala of Stirring Patterns
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [ALLIANCE_DIFF] = {
                {1, "f1177rep7"},
                {2, 62473}, -- Blade of the Fearless
                {3, 62474}, -- Spear of Trailing Shadows
                {4, 62478}, -- Shimmering Morningstar
                {5, 62479}, -- Sky Piercer
                {6, 62477}, -- Insidious Staff
                {7, 68739}, -- Darkheart Hacker
                {8, 62475}, -- Dagger of Restless Nights
                {9, 62476}, -- Ravening Slicer
                {10, 63377}, -- Baradin's Wardens Battle Standard
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [ALLIANCE_DIFF] = {
                {1, "f1177rep6"},
                {2, 63355}, -- Rustberg Gull
                {4, 63141}, -- Tol Barad Searchlight
                {5, 63379}, -- Baradin's Wardens Tabard
                {6, 65175}, -- Baradin Footman's Tags
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [ALLIANCE_DIFF] = {
                {1, "f1177rep5"},
                {2, 63517}, -- Baradin's Wardens Commendation
                {3, 63391}, -- Baradin's Wardens Bandage
                {4, 63144}, -- Baradin's Wardens Healing Potion
                {5, 63145}, -- Baradin's Wardens Mana Potion
            },
        },
    },
}data["DragonmawClan"] = {
    FactionID = 1172,
    ContentType = FACTIONS_HORDE_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [HORDE_DIFF] = {
                {1, "f1172rep8"},
                {2, 62416}, -- Yellow Smoke Pendant
                {3, 62418}, -- Boots of Sullen Rock
                {4, 62417}, -- Liar's Handwraps
                {5, 62420}, -- Withered Dream Belt
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [HORDE_DIFF] = {
                {1, "f1172rep7"},
                {2, 62368}, -- Arcanum of the Dragonmaw
                {3, 62415}, -- Band of Lamentation
                {4, 62408}, -- Gauntlets of Rattling Bones
                {5, 62410}, -- Grinning Fang Helm
                {6, 62409}, -- Snarling Helm
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [HORDE_DIFF] = {
                {1, "f1172rep6"},
                {2, 62404}, -- Spaulders of the Endless Plains
                {3, 62405}, -- Leggings of the Impenitent
                {4, 62407}, -- Helm of the Brown Lands
                {5, 62406}, -- Bone Fever Gloves
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [HORDE_DIFF] = {
                {1, "f1172rep5"},
                {2, 65909}, -- Tabard of the Dragonmaw Clan
            },
        },
    },
}data["GuardiansOfHyjal"] = {
    FactionID = 1158,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1158rep8"},
                {2, 62384}, -- Belt of the Ferocious Wolf
                {3, 62385}, -- Treads of Malorne
                {4, 62383}, -- Wrap of the Great Turtle
                {5, 62386}, -- Cord of the Raven Queen
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1158rep7"},
                {2, 62367}, -- Arcanum of Hyjal
                {3, 62378}, -- Acorn of the Daughter Tree
                {4, 62382}, -- Waywatcher's Boots
                {5, 62380}, -- Wilderness Legguards
                {6, 62381}, -- Aessina-Blessed Gloves
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1158rep6"},
                {2, 62377}, -- Cloak of the Dryads
                {3, 62374}, -- Sly Fox Jerkin
                {4, 62375}, -- Galrond's Band
                {5, 62376}, -- Mountain's Mouth
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1158rep5"},
                {2, 65906}, -- Tabard of the Guardians of Hyjal
            },
        },
    },
}data["HellscreamsReach"] = {
    FactionID = 1178,
    ContentType = FACTIONS_HORDE_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [HORDE_DIFF] = {
                {1, "f1178rep8"},
                {2, 62463}, -- Unsolvable Riddle
                {3, 62464}, -- Impatience of Youth
                {4, 62465}, -- Stump of Time
                {5, 62466}, -- Mirror of Broken Images
                {6, 62467}, -- Mandala of Stirring Patterns
                {16, 65356}, -- Reins of the Drake of the West Wind
                {17, 64999}, -- Reins of the Spectral Wolf
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [HORDE_DIFF] = {
                {1, "f1178rep7"},
                {2, 62460}, -- Sky Piercer
                {3, 62454}, -- Blade of the Fearless
                {4, 62455}, -- Spear of Trailing Shadows
                {5, 62456}, -- Dagger of Restless Nights
                {6, 62458}, -- Insidious Staff
                {7, 62457}, -- Ravening Slicer
                {8, 62459}, -- Shimmering Morningstar
                {9, 68740}, -- Darkheart Hacker
                {16, 63376}, -- Hellscream's Reach Battle Standard
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [HORDE_DIFF] = {
                {1, "f1178rep6"},
                {2, 65176}, -- Baradin Grunt's Talisman
                {4, 64996}, -- Rustberg Gull
                {16, 63378}, -- Hellscream's Reach Tabard
                {18, 64997}, -- Tol Barad Searchlight
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [HORDE_DIFF] = {
                {1, "f1178rep5"},
                {2, 63518}, -- Hellscream's Reach Commendation
                {3, 64995}, -- Hellscream's Reach Bandage
                {4, 64994}, -- Hellscream's Reach Healing Potion
                {5, 64993}, -- Hellscream's Reach Mana Potion
            },
        },
    },
}data["Ramkahen"] = {
    FactionID = 1173,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1173rep8"},
                {2, 62450}, -- Desert Walker Sandals
                {3, 62448}, -- Sun King's Girdle
                {4, 62449}, -- Sandguard Bracers
                {5, 62447}, -- Gift of Nadun
                {16, 63044}, -- Reins of the Brown Riding Camel
                {17, 63045}, -- Reins of the Tan Riding Camel
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1173rep7"},
                {2, 62369}, -- Arcanum of the Ramkahen
                {3, 62440}, -- Red Rock Band
                {4, 62441}, -- Robes of Orsis
                {5, 62446}, -- Quicksand Belt
                {6, 62445}, -- Sash of Prophecy
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1173rep6"},
                {2, 62436}, -- Ammunae's Blessing
                {3, 62439}, -- Belt of the Stargazer
                {4, 62438}, -- Drystone Greaves
                {5, 62437}, -- Shroud of the Dead
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1173rep5"},
                {2, 65904}, -- Tabard of Ramkahen
            },
        },
    },
}data["TheEarthenRing"] = {
    FactionID = 1135,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1135rep8"},
                {2, 62362}, -- Signet of the Elder Council
                {3, 62364}, -- Flamebloom Gloves
                {4, 62365}, -- World Keeper's Gauntlets
                {5, 62363}, -- Earthmender's Boots
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1135rep7"},
                {2, 62357}, -- Cloak of Ancient Wisdom
                {3, 62366}, -- Arcanum of the Earthen Ring
                {4, 62361}, -- Softwind Cape
                {5, 62359}, -- Peacemaker's Breastplate
                {6, 62358}, -- Leggings of Clutching Roots
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1135rep6"},
                {2, 62354}, -- Pendant of Elemental Balance
                {3, 62356}, -- Helm of Temperance
                {4, 62353}, -- Mantle of Moss
                {5, 62355}, -- Stone-Wrapped Greaves
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1135rep5"},
                {2, 65905}, -- Tabard of the Earthen Ring
            },
        },
    },
}data["Therazane"] = {
    FactionID = 1171,
    ContentType = FACTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [NORMAL_DIFF] = {
                {1, "f1171rep8"},
                {2, 62343}, -- Greater Inscription of Charged Lodestone
                {3, 62345}, -- Greater Inscription of Jagged Stone
                {4, 62346}, -- Greater Inscription of Shattered Crystal
                {5, 62333}, -- Greater Inscription of Unbreakable Quartz
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [NORMAL_DIFF] = {
                {1, "f1171rep7"},
                {2, 62351}, -- Felsen's Ring of Resolve
                {3, 62352}, -- Diamant's Ring of Temperance
                {4, 62350}, -- Gorsik's Band of Shattering
                {5, 62348}, -- Terrath's Signet of Balance
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [NORMAL_DIFF] = {
                {1, "f1171rep6"},
                {2, 62347}, -- Lesser Inscription of Shattered Crystal
                {3, 62321}, -- Lesser Inscription of Unbreakable Quartz
                {4, 62342}, -- Lesser Inscription of Charged Lodestone
                {5, 62344}, -- Lesser Inscription of Jagged Stone
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [NORMAL_DIFF] = {
                {1, "f1171rep5"},
                {2, 65907}, -- Tabard of Therazane
            },
        },
    },
}data["WildhammerClan"] = {
    FactionID = 1174,
    ContentType = FACTIONS_ALLI_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    items = {
        { -- Exalted 8
            name = ALIL["Exalted"],
            [ALLIANCE_DIFF] = {
                {1, "f1174rep8"},
                {2, 62434}, -- Lightning Flash Pendant
                {3, 62433}, -- Stormbolt Gloves
                {4, 62432}, -- Gryphon Rider's Boots
                {5, 62431}, -- Belt of the Untamed
            },
        },
        { -- Revered 7
            name = ALIL["Revered"],
            [ALLIANCE_DIFF] = {
                {1, "f1174rep7"},
                {2, 62429}, -- Windhome Helm
                {3, 62422}, -- Arcanum of the Wildhammer
                {4, 62428}, -- Crown of Wings
                {5, 62427}, -- Band of Singing Grass
                {6, 62430}, -- Gryphon Talon Gauntlets
            },
        },
        { -- Honored 6
            name = ALIL["Honored"],
            [ALLIANCE_DIFF] = {
                {1, "f1174rep6"},
                {2, 62425}, -- Swiftflight Leggings
                {3, 62423}, -- Helm of the Skyborne
                {4, 62424}, -- Gloves of Aetherial Rumors
                {5, 62426}, -- Mantle of Wild Feathers
            },
        },
        { -- Friendly 5
            name = ALIL["Friendly"],
            [ALLIANCE_DIFF] = {
                {1, "f1174rep5"},
                {2, 65908}, -- Tabard of the Wildhammer Clan
            },
        },
    },
}