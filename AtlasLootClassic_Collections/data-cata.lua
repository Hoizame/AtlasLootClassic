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

local RAIDFINDER_DIFF = data:AddDifficulty("Raid Finder", nil, nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)

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

data["JusticePoints P1"] = {
    name = format(AL["'%s' Vendor"], AL["Justice Points P1"]),
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

data["ValorPoints T11"] = {
    name = format(AL["'%s' Vendor"], AL["Valor Points T11"]),
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
data["ValorPoints T12"] = {
    name = format(AL["'%s' Vendor"], AL["Valor Points T12"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [NORMAL_DIFF] = { -- Mage
        {1, 71289}, -- Firehawk Robes
        {2, 71286}, -- Firehawk Gloves
        {3, 71288}, -- Firehawk Leggings
        -- Warlock
        {5, 71284}, -- Balespider's Robes
        {6, 71281}, -- Balespider's Handwraps
        {7, 71283}, -- Balespider's Leggings
        -- Priest
        {16, 71274}, -- Robes of the Cleansing Flame
        {17, 71271}, -- Handwraps of the Cleansing Flame
        {18, 71273}, -- Legwraps of the Cleansing Flame
        {20, 71279}, -- Vestment of the Cleansing Flame
        {21, 71276}, -- Gloves of the Cleansing Flame
        {22, 71278}, -- Leggings of the Cleansing Flame
        -- Misc
        {9, 71265}, -- Emberflame Bracers
        {10, 71266} -- Firesoul Wristguards
    }
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
    [NORMAL_DIFF] = { -- Druid
    {1, 71105}, -- Obsidian Arborweave Tunic
    {2, 71102}, -- Obsidian Arborweave Handwraps
    {3, 71104}, -- Obsidian Arborweave Legwraps
    {5, 71100}, -- Obsidian Arborweave Raiment
    {6, 71097}, -- Obsidian Arborweave Grips
    {7, 71099}, -- Obsidian Arborweave Legguards
    {9, 71110}, -- Obsidian Arborweave Vestment
    {10, 71107}, -- Obsidian Arborweave Gloves
    {11, 71109}, -- Obsidian Arborweave Leggings
    -- Rouge
    {16, 71045}, -- Dark Phoenix Tunic
    {17, 71046}, -- Dark Phoenix Gloves
    {18, 71048}, -- Dark Phoenix Legguards
    -- Misc
    {13, 71262}, -- Smolderskull Bindings
    {14, 71130} -- Flamebinder Bracers
}
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
    [NORMAL_DIFF] = { -- Shaman
    {1, 71294}, -- Erupting Volcanic Hauberk
    {2, 71292}, -- Erupting Volcanic Gloves
    {3, 71291}, -- Erupting Volcanic Kilt
    {5, 71296}, -- Erupting Volcanic Tunic
    {6, 71297}, -- Erupting Volcanic Handwraps
    {7, 71299}, -- Erupting Volcanic Legwraps
    {9, 71301}, -- Erupting Volcanic Cuirass
    {10, 71302}, -- Erupting Volcanic Grips
    {11, 71304}, -- Erupting Volcanic Legguards
    -- Rouge
    {16, 71054}, -- Flamewalker's Tunic
    {17, 71050}, -- Flamewalker's Gloves
    {18, 71052}, -- Flamewalker's Legguards
    -- Misc
    {13, 71263}, -- Bracers of Misting Ash
    {14, 71264} -- Bracers of Forked Lightning
}
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
    [NORMAL_DIFF] = { -- Paladin
    {1, 71091}, -- Immolation Breastplate
    {2, 71092}, -- Immolation Sapphirium Gloves
    {3, 71094}, -- Immolation Sapphirium Greaves
    {4, 71063}, -- Immolation Sapphirium Battleplate
    {5, 71064}, -- Immolation Sapphirium Gauntlets
    {6, 71066}, -- Immolation Sapphirium Legplates
    {7, 70950}, -- Immolation Sapphirium Chestguard
    {8, 70949}, -- Immolation Sapphirium Handguards
    {9, 70947}, -- Immolation Sapphirium Legguards
    -- DK
    {11, 71058}, -- Elementium Deathplate Breastplate
    {12, 71059}, -- Elementium Deathplate Gauntlets
    {13, 71061}, -- Elementium Deathplate Greaves
    {16, 70955}, -- Elementium Deathplate Chestguard
    {17, 70953}, -- Elementium Deathplate Handguards
    {18, 70952}, -- Elementium Deathplate Legguards
    -- Warrior
    {20, 71068}, -- Battleplate of the Molten Giant
    {21, 71069}, -- Gauntlets of the Molten Giant
    {22, 71071}, -- Legplates of the Molten Giant
    {24, 70945}, -- Chestguard of the Molten Giant
    {25, 70943}, -- Handguards of the Molten Giant
    {26, 70942}, -- Legguards of the Molten Giant
    -- Misc
    {28, 71260}, -- Bracers of Imperious Truths
    {29, 70937}, -- Bracers of Regal Force
    {30, 71261} -- Gigantform Bracers
}
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Accessories"],
    [NORMAL_DIFF] = { -- Misc
    {1, 71213}, -- Amulet of Burning Brilliance
    {2, 71214}, -- Firemind Pendant
    {3, 71129}, -- Necklace of Smoke Signals
    {4, 71212}, -- Stoneheart Choker
    {5, 70935}, -- Stoneheart Necklace
    {7, 71210}, -- Crystalline Brimstone Ring
    {8, 70940}, -- Deflecting Brimstone Band
    {9, 71208}, -- Serrated Brimstone Signet
    {10, 71211}, -- Soothing Brimstone Circle
    {11, 71209}, -- Splintered Brimstone Seal
    {16, 70939}, -- Deathclutch Figurine
    {17, 71147}, -- Relic of the Elemental Lords
    {18, 71149}, -- Singed Plume of Aviana
    {19, 71146}, -- Covenant of the Flame
    {20, 71148}, -- Soulflame Vial
    {22, 71150}, -- Scorchvine Wand
    {23, 71151}, -- Trail of Embers
    {25, 71152}, -- Morningstar Shard
    {26, 71154}, -- Giantslicer
    {27, 71218}, -- Deflecting Star
}
}}
}
data["ValorPoints T13"] = {
    name = format(AL["'%s' Vendor"], AL["Valor Points T13"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth / Leather"],
        [NORMAL_DIFF] = { -- Cloth
        {1, 77147}, -- Hood of Hidden Flesh
        {2, 77122}, -- Robes of Searing Shadow
        {3, 77324}, -- Chronoboost Bracers
        {4, 77159}, -- Clockwinder's Immaculate Gloves
        {5, 77179}, -- Tentacular Belt
        {6, 77176}, -- Kavan's Forsaken Treads
        {8, 77146}, -- Soulgaze Cowl
        {9, 77121}, -- Lightwarper Vestments
        {10, 77323}, -- Bracers of the Black Dream
        {11, 77157}, -- The Hands of Gilly
        {12, 77187}, -- Vestal's Irrepressible Girdle
        {13, 77177}, -- Splinterfoot Sandals
        -- Leather
        {16, 77149}, -- Helmet of Perpetual Rebirth
        {17, 77127}, -- Decaying Herbalist's Robes
        {18, 77320}, -- Luminescent Bracers
        {19, 77160}, -- Fungus-Born Gloves
        {20, 77181}, -- Belt of Universal Curing
        {21, 77172}, -- Boots of Fungoid Growth
        {23, 77148}, -- Nocturnal Gaze
        {24, 77126}, -- Shadowbinder Chestguard
        {25, 77322}, -- Bracers of Manifold Pockets
        {26, 77161}, -- Lightfinger Handwraps
        {27, 77180}, -- Belt of Hidden Keys
        {28, 77173}, -- Rooftop Griptoes
    }
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
    [NORMAL_DIFF] = { -- Mail
    {1, 77151}, -- Wolfdream Circlet
    {2, 77125}, -- Ghostworld Chestguard
    {3, 77319}, -- Bracers of the Spectral Wolf
    {4, 77163}, -- Gloves of Ghostly Dreams
    {5, 77183}, -- Girdle of Shamanic Fury
    {6, 77174}, -- Sabatons of the Graceful Spirit
    {8, 77150}, -- Zeherah's Dragonskull Crown
    {9, 77124}, -- Dragonflayer Vest
    {10, 77321}, -- Dragonbelly Bracers
    {11, 77162}, -- Arrowflick Gauntlets
    {12, 77182}, -- Cord of Dragon Sinew
    {13, 77175}, -- Boneshard Boots
}
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
    [NORMAL_DIFF] = { -- Plate
    {1, 77153}, -- Glowing Wings of Hope
    {2, 77123}, -- Shining Carapace of Glory
    {3, 77316}, -- Flashing Bracers of Warmth
    {4, 77164}, -- Gleaming Grips of Mending
    {5, 77184}, -- Blinding Girdle of Truth
    {6, 77169}, -- Silver Sabatons of Fury
    {8, 77155}, -- Visage of Petrification
    {9, 77119}, -- Bones of the Damned
    {10, 77317}, -- Heartcrusher Wristplates
    {11, 77165}, -- Grimfist Crushers
    {12, 77185}, -- Demonbone Waistguard
    {13, 77170}, -- Kneebreaker Boots
    {16, 77156}, -- Jaw of Repudiation
    {17, 77120}, -- Chestplate of the Unshakable Titan
    {18, 77318}, -- Bracers of Unrelenting Excellence
    {19, 77166}, -- Gauntlets of Feathery Blows
    {20, 77186}, -- Forgesmelter Waistplate
    {21, 77171}, -- Bladeshatter Treads
}
}, {
    name = ALIL["Armor"] .. " - " .. ALIL["Accessories"],
    [NORMAL_DIFF] = { -- Plate
    { 1, 77095}, -- Batwing Cloak
    { 2, 77097}, -- Dreamcrusher Drape
    { 3, 77099}, -- Indefatigable Greatcloak
    { 4, 77098}, -- Nanoprecise Cape
    { 5, 77096}, -- Woundlicker Cover
    { 7, 77091}, -- Cameo of Terrible Memories
    { 8, 77092}, -- Guardspike Choker
    { 9, 77090}, -- Necklace of Black Dragon's Teeth
    { 10, 77088}, -- Opal of the Secret Order
    { 11, 77089}, -- Threadlinked Chain
    { 13, 77081}, -- Gutripper Shard
    { 14, 77083}, -- Lightning Spirit in a Bottle
    { 15, 77082}, -- Mindbender Lens
    { 16, 77109}, -- Band of Reconstruction
    { 17, 77111}, -- Emergency Descent Loop
    { 18, 77110}, -- Ring of Torn Flesh
    { 19, 77108}, -- Seal of the Grand Architect
    { 20, 77112}, -- Signet of the Resolute
    { 22, 77114}, -- Bottled Wishes
    { 23, 77117}, -- Fire of the Deep
    { 24, 77113}, -- Kiroptyric Sigil
    { 25, 77115}, -- Reflection of the Light
    { 26, 77116}, -- Rotting Skull
    { 28, 77080}, -- Ripfang Relic
    { 29, 77084}, -- Stoutheart Talisman
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

data["Weapon Sets"] = {
    name = format(AL["%s Sets"], AL["Weapons"]),
    ContentType = SET_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = SET_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {
        { -- Misc
        name = AL["Weapons"],
        [NORMAL_DIFF] = {
            { 1,  951 }, -- Agony and Torment / 359
            { 2,  1089 }, -- Jaws of Retribution / 397
            { 3, 1088 }, -- Maw of Oblivion / 406
            { 4,  1087 }, -- Fangs of the Father / 416
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
        [NORMAL_DIFF] ={{ 1, [ATLASLOOT_IT_ALLIANCE] = 70909, [ATLASLOOT_IT_HORDE] = 70910 }, -- Vicious War Steed / Vicious War Wolf
        {2, 71339}, -- Vicious Gladiator's Twilight Drake
        {3, 71954}, -- Ruthless Gladiator's Twilight Drake
    }
}, { -- Drops
name = AL["Drops"],
[NORMAL_DIFF] = {{1, 63043}, -- Reins of the Vitreous Stone Drake
{2, 63042}, -- Reins of the Phosphorescent Stone Drake
{4, 63040}, -- Reins of the Drake of the North Wind
{5, 63041}, -- Reins of the Drake of the South Wind
{7, 69224}, -- Smoldering Egg of Millagazor
{8, 71665}, -- Flametalon of Alysrazor
{10, 77067}, -- Reins of the Blazing Drake
{11, 77069}, -- Life-Binder's Handmaiden
{12, 78919}, -- Experiment 12-B
{14, 68823}, -- Armored Razzashi Raptor
{15, 68824}, -- Swift Zulian Panther
{16, 69747}, -- Amani Battle Bear
{18, 67151}, -- Reins of Poseidus
}
}, {
    name = AL["Crafting"],
    [NORMAL_DIFF] = {{1, 65891}, -- Vial of the Sands
    {3, 60954}, -- Fossilized Raptor
    {5, 64883}, -- Scepter of Azj'Aqir
}
}, {
    name = AL["Factions"],
    [NORMAL_DIFF] = {
        {1, [ATLASLOOT_IT_ALLIANCE] = 63039, [ATLASLOOT_IT_HORDE] = 65356},
        {2, [ATLASLOOT_IT_ALLIANCE] = 64998, [ATLASLOOT_IT_HORDE] = 64999},
    }
}, {
    name = AL["Darkmoon Faire"],
    [NORMAL_DIFF] = {{1, 73766}, -- Darkmoon Dancing Bear
    {2, 72140}, -- Swift Forest Strider
}
}, {
    name = ALIL["Achievements"],
    TableType = AC_ITTYPE,
    [NORMAL_DIFF] = {{1, 62900, 4845}, -- Reins of the Volcanic Stone Drake
    {2, 62901, 4853}, -- Reins of the Drake of the East Wind
    {3, 69230, 5828}, -- Corrupted Egg of Millagazor
    {4, 77068, 6169}, -- Reins of the Twilight Harbinger
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
        [NORMAL_DIFF] = {
         {1, 64403}, -- Fox Kit
         {2, 64494}, -- Tiny Shale Spider
         {3, 68673}, -- Smolderweb Egg
         {16, 61387}, -- Grubs bag
         {17, 66076}, -- Mr Grubbs
        }
    }, {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {
         {1, 70140}, -- Hyjal Bear Cub
         {2, 70160}, -- Crimson Lasher
         {3, 73905}, -- Darkmoon Zep
         {4, [ATLASLOOT_IT_ALLIANCE] = 63355, [ATLASLOOT_IT_HORDE] = 64996}, -- Rustberg Gull
         {5, 69239}, -- Winterspring Cub
         {6, 73903}, -- Darkmoon Tonk
         {7, 74981}, -- Darkmoon Cub
         {8, 75042}, -- Flimsy Yellow Ballon
         {9, 75040}, -- Flimsy Darkmoon Ballon
         {10, 75041}, -- Flimsy Green Balloon
         {11, 73762}, -- Darkmoon Balloon
         {12, 73764}, -- Darkmoon Monkey
         {13, 73764}, -- Darkmoon Turtle
        }
    }, {
        name = AL["World Events"],
        [NORMAL_DIFF] = {
         {1, 71076}, -- Creepy Crate
         {2, 70908}, -- Feline Familiar
         {4, 73797}, -- Lump of Coal
         {6, 74611}, -- Festival Lantern
        }
    }, {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
         {1, 63398, "ac5144"}, -- Armadillo Pup
         {2, 65361, "ac5031"}, -- Guild Page Ally
         {3, 65362, "ac5179"}, -- Guild Page Horde
         {4, 65363, "ac5201"}, -- Guild Herald Ally
         {5, 65364, "ac5201"}, -- Guild Herald Horde
         {16, 71387, "ac5877"}, -- Brilliant Kaliri
         {6, 60869, "ac5449"}, -- Pebbles
         {7, 63138}, -- Dark Phoenix Hatchling
         {8, 71033, "ac5840"}, -- Lil Tarecgosa
         {17, 71140, "ac5876"}, -- Nuts'
        }
    }, {
        name = ALIL["Quests"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
         {1, 69251}, -- Lashtail Hatchling
         {2, 66080}, -- Tiny Flamefly
         {3, 69648}, -- Legs
         {4, 68833}, -- Panther Cub
         {5, 66067}, -- Sunflower
         {6, 46325}, -- Withers
         {7, 66073}, -- Snail
         {8, [ATLASLOOT_IT_ALLIANCE] = 72042, [ATLASLOOT_IT_HORDE] = 72045}, -- A/H Balloons
         {9, 65661}, -- Blue mini jouster
         {10, 65661}, -- Gold mini jouster
        }
    }, {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {
         {1, 73953}, -- Sea pony
        }
    }, {
        name = ALIL["Crafting"],
        [NORMAL_DIFF] = {
         {1, 67274}, -- Enchanted Lantern
         {2, 67275}, -- Magic Lamp
         {3, 60847}, -- Crawling Claw
         {4, 67282}, -- Elementium Geode
         {5, 59597}, -- Personal World Destroyer
         {6, 60216}, -- De-Weaponized Mechanical Companion
         {7, 69821}, -- Pterrordax Hatchling
         {8, 60955}, -- Fossilized Hatchling
         {9, 69824}, -- Voodoo Figurine
         {10, 64372}, -- Clockwork Gnome
        }
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
            {1, 65904}, -- Tabard of the Ramkahen
            {2, 65905}, -- Tabard of the Earthen Ring
            {3, 65906}, -- Tabard of the Guardians of Hyjal
            {4, 65907}, -- Tabard of Therazane
            {5, 65909}, -- Tabard of the Dragonmaw Clan
        }
    }, {
        name = AL["PvP"],
        CoinTexture = "PvP",
        [NORMAL_DIFF] = {
            { 1, [ATLASLOOT_IT_ALLIANCE] = { 63379 }, [ATLASLOOT_IT_HORDE] = { 63378 } }, -- Baradin's Wardens Tabard / Hellscream's Reach Tabard
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

data["LegendarysCata"] = {
    name = AL["Legendarys"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.LEGENDARYS,
    items = {{
        name = AL["Legendarys"],
        [NORMAL_DIFF] = {
            {1, 71086, "ac5839"}, -- Dragonwrath, Tarecgosa's Rest
            {16, 77949, "ac6181"}, -- Golad, Twilight of Aspects
            {17, 77950, "ac6181"} -- Tiriosh, Nightmare of Ages
        }
    }}
}

data["HeirloomCata"] = {
    name = ALIL["Heirloom"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"],
        [NORMAL_DIFF] = {
            -- Cloak
            {1, 62039}, -- Inherited Cape of the Black Baron
            {2, 62038}, -- Worn Stoneskin Gargoyle Cape
            {3, 62040}, -- Ancient Bloodmoon Cloak
            {4, 69892}, -- Ripped Sandstorm Cloak
            -- Head
            {16, 69887}, -- Burnished Helm of Might
            {17, 61931}, -- Polished Helm of Valor
            {18, 61936}, -- Mystical Coif of Elements
            {19, 61935}, -- Tarnished Raging Berserker's Helm
            {20, 61942}, -- Preened Tribal War Feathers
            {21, 61937}, -- Stained Shadowcraft Cap
            {22, 61958} -- Tattered Dreadmist Mask
        }
    }}
}

data["LunarFestivalCata"] = {
    name = AL["Lunar Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.LUNAR_FESTIVAL,
    items = {
        { -- LunarFestival1
        name = AL["Lunar Festival"],
        [NORMAL_DIFF] = {
            { 1,  21100 }, -- Coin of Ancestry
            { 2,  74610 }, -- Lunar Lantern
            { 3,  74611 }, -- Festival Lantern
            { 6,  21157 }, -- Festive Green Dress
            { 7,  21538 }, -- Festive Pink Dress
            { 8,  21539 }, -- Festive Purple Dress
            { 9,  21541 }, -- Festive Black Pant Suit
            { 10,  21544 }, -- Festive Blue Pant Suit
            { 11,  21543 }, -- Festive Teal Pant Suit
        },
    },
    {
        name = AL["Lunar Festival Fireworks Pack"],
        [NORMAL_DIFF] = {
            { 1, 21558 }, -- Small Blue Rocket
            { 2, 21559 }, -- Small Green Rocket
            { 3, 21557 }, -- Small Red Rocket
            { 4, 21561 }, -- Small White Rocket
            { 5, 21562 }, -- Small Yellow Rocket
            { 7, 21537 }, -- Festival Dumplings
            { 8, 21713 }, -- Elune's Candle
            { 16, 21589 }, -- Large Blue Rocket
            { 17, 21590 }, -- Large Green Rocket
            { 18, 21592 }, -- Large Red Rocket
            { 19, 21593 }, -- Large White Rocket
            { 20, 21595 }, -- Large Yellow Rocket
        }
    },
    {
        name = AL["Lucky Red Envelope"],
        [NORMAL_DIFF] = {
            { 1, 21540 }, -- Elune's Lantern
            { 2, 21536 }, -- Elune Stone
            { 16, 21744 }, -- Lucky Rocket Cluster
            { 17, 21745 }, -- Elder's Moonstone
        }
    },
    { -- LunarFestival2
    name = AL["Plans"],
    [NORMAL_DIFF] = {
        { 1,  21722 }, -- Pattern: Festival Dress
        { 3,  21738 }, -- Schematic: Firework Launcher
        { 5,  21724 }, -- Schematic: Small Blue Rocket
        { 6,  21725 }, -- Schematic: Small Green Rocket
        { 7,  21726 }, -- Schematic: Small Red Rocket
        { 9, 21727 }, -- Schematic: Large Blue Rocket
        { 10, 21728 }, -- Schematic: Large Green Rocket
        { 11, 21729 }, -- Schematic: Large Red Rocket
        { 16, 21723 }, -- Pattern: Festive Red Pant Suit
        { 18, 21737 }, -- Schematic: Cluster Launcher
        { 20, 21730 }, -- Schematic: Blue Rocket Cluster
        { 21, 21731 }, -- Schematic: Green Rocket Cluster
        { 22, 21732 }, -- Schematic: Red Rocket Cluster
        { 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
        { 25, 21734 }, -- Schematic: Large Green Rocket Cluster
        { 26, 21735 }, -- Schematic: Large Red Rocket Cluster
    },
},
},
}

data["ValentinesdayCata"] = {
    name = AL["Love is in the Air"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.VALENTINES_DAY,
    items = {{ -- Valentineday
    name = AL["Love is in the Air"],
    [NORMAL_DIFF] = {{1, 22206}, -- Bouquet of Red Roses
    {3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"]}, {4, 22279}, -- Lovely Black Dress
    {5, 22235}, -- Truesilver Shafted Arrow
    {6, 22200}, -- Silver Shafted Arrow
    {7, 22261}, -- Love Fool
    {8, 22218}, -- Handful of Rose Petals
    {9, 21813}, -- Bag of Candies
    {11, "INV_Box_02", nil, AL["Box of Chocolates"]}, {12, 22237}, -- Dark Desire
    {13, 22238}, -- Very Berry Cream
    {14, 22236}, -- Buttermilk Delight
    {15, 22239}, -- Sweet Surprise
    {16, 22276}, -- Lovely Red Dress
    {17, 22278}, -- Lovely Blue Dress
    {18, 22280}, -- Lovely Purple Dress
    {19, 22277}, -- Red Dinner Suit
    {20, 22281}, -- Blue Dinner Suit
    {21, 22282} -- Purple Dinner Suit
}
}, { -- SFKApothecaryH
name = C_Map_GetAreaInfo(209) .. " - " .. AL["Apothecary Hummel"],
[NORMAL_DIFF] = {{1,  68175}, -- Winking Eye of Love
{2, 68176} , -- Heartbreak Charm
{3, 68172}, -- Shard of Pirouetting Happiness
{4, 68174}, -- Sweet Perfume Broach
{5, 68173}, -- Choker of the Pure Heart
{7, 49641}, -- Faded Lovely Greeting Card
{8, 49715}, -- Forever-Lovely Rose
{9, 50250}, -- X-45 Heartbreaker
{10, 50446}, -- Toxic Wasteling
{11, 50471}, -- The Heartbreaker
{12, 50741} -- Vile Fumigator's Mask
}
}}
}

data["MidsummerFestivalCata"] = {
    name = AL["Midsummer Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.MIDSUMMER_FESTIVAL,
    items = {{
        name = AL["Midsummer Festival"],
        [NORMAL_DIFF] = {
            {1, 23083}, -- Captured Flame
            {2, 34686}, -- Brazier of Dancing Flames
            {4, 23324}, -- Mantle of the Fire Festival
            {5, 23323}, -- Crown of the Fire Festival
            {6, 34683}, -- Sandals of Summer
            {7, 34685}, -- Vestment of Summer
            {9, 23247}, -- Burning Blossom
            {10, 34599}, -- Juggling Torch
            {11, 34684}, -- Handful of Summer Petals
            {12, 23246}, -- Fiery Festival Brew
            {16, 23215}, -- Bag of Smorc Ingredients
            {17, 23211}, -- Toasted Smorc
            {18, 23435}, -- Elderberry Pie
            {19, 23327}, -- Fire-toasted Bun
            {20, 23326} -- Midsummer Sausage
        }
    }, {
        name = C_Map_GetAreaInfo(3717) .. " - " .. AL["Ahune"],
        [NORMAL_DIFF] = {
            { 1, 54536 }, -- Satchel of Chilled Goods
            { 2, 69771 }, -- Frostscythe of Lord Ahune
            { 4, 69768 }, -- Shroud of Winter's Chill
            { 5, 69766 }, -- The Frost Lord's War Cloak
            { 6, 69770 }, -- Icebound Cloak
            { 7, 69769 }, -- Cloak of the Frigid Winds
            { 8, 69767 }, -- The Frost Lord's Battle Shroud
            { 10, 35723 }, -- Shards of Ahune
            { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
            { 18, 53641 }, -- Ice Chip
            { 20, 35557 }, -- Huge Snowball
        }
    }}
}

data["BrewfestCata"] = {
    name = AL["Brewfest"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.BREWFEST,
    items = {{ -- Brewfest
    name = AL["Brewfest"],
    [NORMAL_DIFF] = {{1, 33968}, -- Blue Brewfest Hat
    {2, 33864}, -- Brown Brewfest Hat
    {3, 33967}, -- Green Brewfest Hat
    {4, 33969}, -- Purple Brewfest Hat
    {5, 33863}, -- Brewfest Dress
    {6, 33862}, -- Brewfest Regalia
    {7, 33966}, -- Brewfest Slippers
    {8, 33868}, -- Brewfest Boots
    {10, 33047}, -- Belbi's Eyesight Enhancing Romance Goggles (Alliance)
    {11, 34008}, -- Blix's Eyesight Enhancing Romance Goggles (Horde)
    {13, 33927}, -- Brewfest Pony Keg
    {15, 37829}, -- Brewfest Prize Token
    {16, 32233}, -- Wolpertinger's Tankard
    {18, 37599}, -- "Brew of the Month" Club Membership Form
    {20, 37750}, -- Fresh Brewfest Hops
    {21, 39477}, -- Fresh Dwarven Brewfest Hops
    {22, 39476}, -- Fresh Goblin Brewfest Hops
    {23, 37816} -- Preserved Brewfest Hops
}
}, {
    name = AL["Food"],
    [NORMAL_DIFF] = {{1, 33043}, -- The Essential Brewfest Pretzel
    {3, 34017}, -- Small Step Brew
    {4, 34018}, -- long Stride Brew
    {5, 34019}, -- Path of Brew
    {6, 34020}, -- Jungle River Water
    {7, 34021}, -- Brewdoo Magic
    {8, 34022}, -- Stout Shrunken Head
    {9, 33034}, -- Gordok Grog
    {10, 33035}, -- Ogre Mead
    {11, 33036} -- Mudder's Milk
}
}, {
    name = C_Map_GetAreaInfo(1584) .. " - " .. AL["Coren Direbrew"],
    [NORMAL_DIFF] = {{1, 232017}, -- Bitter Balebrew Charm
    {2, 232016}, -- Bubbling Brightbrew Charm
    {3, 232012}, -- Coren's Chromium Coaster
    {4, 232013}, -- Mithril Pocketwatch
    {5, 232014}, -- Ancient Pickled Egg
    {6, 232015}, -- Brawler's Souvenir
    {8, 232030}, -- Direbrew's Bloody Shanker
    {9, 232031}, -- Tankard O' Terror
    {16, 33977}, -- Swift Brewfest Ram
    {17, 37828}, -- Great Brewfest Kodo
    {19, 37863}, -- Direbrew's Remote
    {21, 38280} -- Direbrew's Dire Brew
}
}}
}

data["HalloweenCata"] = {
    name = AL["Hallow's End"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.HALLOWEEN,
    items = {{ -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Misc"],
        [NORMAL_DIFF] = {{1, 20400}, -- Pumpkin Bag
    {3, 18633}, -- Styleen's Sour Suckerpop
    {4, 18632}, -- Moonbrook Riot Taffy
    {5, 18635}, -- Bellara's Nutterbar
    {6, 20557}, -- Hallow's End Pumpkin Treat
    {8, 20389}, -- Candy Corn
    {9, 20388}, -- Lollipop
    {10, 20390}, -- Candy Bar
    {12, 71076}, -- Creepy Crate
    {13, 70908}, -- Feline Familiar
    {14, 70722}, -- Little Wickerman
        }
    }, { -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Wands"],
        [NORMAL_DIFF] = {{1, 20410}, -- Hallowed Wand - Bat
    {2, 20409}, -- Hallowed Wand - Ghost
    {3, 20399}, -- Hallowed Wand - Leper Gnome
    {4, 20398}, -- Hallowed Wand - Ninja
    {5, 20397}, -- Hallowed Wand - Pirate
    {6, 20413}, -- Hallowed Wand - Random
    {7, 20411}, -- Hallowed Wand - Skeleton
    {8, 20414} -- Hallowed Wand - Wisp
        }
    }, { -- Halloween3
        name = AL["Hallow's End"] .. " - " .. AL["Masks"],
        [NORMAL_DIFF] = {{1, 20561}, -- Flimsy Male Dwarf Mask
    {2, 20391}, -- Flimsy Male Gnome Mask
    {3, 20566}, -- Flimsy Male Human Mask
    {4, 20564}, -- Flimsy Male Nightelf Mask
    {5, 20570}, -- Flimsy Male Orc Mask
    {6, 20572}, -- Flimsy Male Tauren Mask
    {7, 20568}, -- Flimsy Male Troll Mask
    {8, 20573}, -- Flimsy Male Undead Mask
    {10, 69188}, -- Murloc Male Mask
    {11, 69190}, -- Naga Male Mask
    {12, 69193}, -- Ogre Male Mask
    {13, 69195}, -- Vrykul Male Mask
    {16, 20562}, -- Flimsy Female Dwarf Mask
    {17, 20392}, -- Flimsy Female Gnome Mask
    {18, 20565}, -- Flimsy Female Human Mask
    {19, 20563}, -- Flimsy Female Nightelf Mask
    {20, 20569}, -- Flimsy Female Orc Mask
    {21, 20571}, -- Flimsy Female Tauren Mask
    {22, 20567}, -- Flimsy Female Troll Mask
    {23, 20574}, -- Flimsy Female Undead Mask
    {25, 69187}, -- Murloc Female Mask
    {26, 69189}, -- Naga Female Mask
    {27, 69192}, -- Ogre Female Mask
    {28, 69194}, -- Vrykul Female Mask
        }
    }, { -- SMHeadlessHorseman
        name = C_Map_GetAreaInfo(796) .. " - " .. AL["Headless Horseman"],
        [NORMAL_DIFF] = {{1, 71327}, -- Band of Ghoulish Glee
    {2, 71330}, -- The Horseman's Seal
    {3, 71328}, -- Wicked Witch's Band
    {5, 71326}, -- The Horseman's Horrific Helm
    {6, 71325}, -- The Horseman's Baleful Blade
    {8, 33292}, -- Hallowed Helm
    {10, 34068}, -- Weighted Jack-o'-Lantern
    {12, 33277}, -- Tome of Thomas Thomson
    {16, 37012}, -- The Horseman's Reins
    {18, 33182}, -- Swift Flying Broom        280% flying
    {19, 33176}, -- Flying Broom              60% flying
    {21, 33184}, -- Swift Magic Broom         100% ground
    {22, 37011}, -- Magic Broom               60% ground
    {24, 33154} -- Sinister Squashling
}, { -- SMHeadlessHorseman
name = C_Map_GetAreaInfo(796) .. " - " .. AL["Headless Horseman"],
[NORMAL_DIFF] = {
    {1, 71327}, -- Band of Ghoulish Glee
    {2, 71328}, -- The Horseman's Signet
    {3, 71329}, -- Wicked Witch's Ring
    {4, 71330}, -- Seal of the Petrified Pumpkin
    {5, 71326}, -- The Horseman's Horrific Helmet
    {6, 71325}, -- The Horseman's Sinister Saber
    {8, 33292}, -- Hallowed Helm
    {10, 34068}, -- Weighted Jack-o'-Lantern
    {12, 33277}, -- Tome of Thomas Thomson
    {16, 37012}, -- The Horseman's Reins
    {18, 33182}, -- Swift Flying Broom        280% flying
    {19, 33176}, -- Flying Broom              60% flying
    {21, 33184}, -- Swift Magic Broom         100% ground
    {22, 37011}, -- Magic Broom               60% ground
    {24, 33154} -- Sinister Squashling
}
}}
}

data["WinterVeilCata"] = {
    name = AL["Feast of Winter Veil"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.WINTER_VEIL,
    items = {
        { -- Winterviel1
        name = AL["Misc"],
        [NORMAL_DIFF] = {
            { 1,  66540 }, -- Miniature Winter Veil Tree
            { 2,  34425 }, -- Clockwork Rocket Bot
            { 3,  54436 }, -- Blue Clockwork Rocket Bot
            { 4,  73797 }, -- Lump of Coal
            { 5,  46709 }, -- MiniZep Controller
            { 6,  44606 }, -- Toy Train Set
            { 7,  37710 }, -- Crashin' Thrashin' Racer Controller
            { 8,  46725 }, -- Red Rider Air Rifle
            { 9,  54437 }, -- Tiny Green Ragdoll
            { 10,  54438 }, -- Tiny Blue Ragdoll
            { 11,  34498 }, -- Paper Zeppelin Kit
            { 12,  44599 }, -- Zippy Copper Racer
            { 13,  44601 }, -- Heavy Copper Racer
            { 14,  44481 }, -- Grindgear Toy Gorilla
            { 15,  44482 }, -- Trusty Copper Racer
            { 16,  21525 }, -- Green Winter Hat
            { 17,  21524 }, -- Red Winter Hat
            { 18,  17712 }, -- Winter Veil Disguise Kit
            { 19,  17202 }, -- Snowball
            { 20,  21212 }, -- Fresh Holly
            { 21,  21519 }, -- Mistletoe
        },
    },
    {
        name = AL["Gaily Wrapped Present"],
        [NORMAL_DIFF] = {
            { 1, 21301 }, -- Green Helper Box
            { 2, 21308 }, -- Jingling Bell
            { 3, 21305 }, -- Red Helper Box
            { 4, 21309 }, -- Snowman Kit
        },
    },
    {
        name = AL["Festive Gift"],
        [NORMAL_DIFF] = {
            { 1, 21328 }, -- Wand of Holiday Cheer
        },
    },
    {
        name = AL["Smokywood Pastures Special Gift"],
        [NORMAL_DIFF] = {
            { 1, 17706 }, -- Plans: Edge of Winter
            { 2, 17725 }, -- Formula: Enchant Weapon - Winter's Might
            { 3, 17720 }, -- Schematic: Snowmaster 9000
            { 4, 17722 }, -- Pattern: Gloves of the Greatfather
            { 5, 17709 }, -- Recipe: Elixir of Frost Power
            { 6, 17724 }, -- Pattern: Green Holiday Shirt
            { 16, 21325 }, -- Mechanical Greench
            { 17, 21213 }, -- Preserved Holly
        },
    },
    {
        name = AL["Gently Shaken Gift"],
        [NORMAL_DIFF] = {
            { 1, 21235 }, -- Winter Veil Roast
            { 2, 21241 }, -- Winter Veil Eggnog
        },
    },
    {
        name = AL["Smokywood Pastures"],
        [NORMAL_DIFF] = {
            { 1,  17201 }, -- Recipe: Egg Nog
            { 2,  17200 }, -- Recipe: Gingerbread Cookie
            { 3,  17344 }, -- Candy Cane
            { 4,  17406 }, -- Holiday Cheesewheel
            { 5,  17407 }, -- Graccu's Homemade Meat Pie
            { 6,  17408 }, -- Spicy Beefstick
            { 7,  17404 }, -- Blended Bean Brew
            { 8,  17405 }, -- Green Garden Tea
            { 9, 17196 }, -- Holiday Spirits
            { 10, 17403 }, -- Steamwheedle Fizzy Spirits
            { 11, 17402 }, -- Greatfather's Winter Ale
            { 12, 17194 }, -- Holiday Spices
            { 16, 17303 }, -- Blue Ribboned Wrapping Paper
            { 17, 17304 }, -- Green Ribboned Wrapping Paper
            { 18, 17307 }, -- Purple Ribboned Wrapping Paper
        },
    },
},
}

data["MoltenFront"] = {
    name = AL["Molten Front"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {
        { -- Additional Armaments
        name = AL["Additional Armaments"],
        [NORMAL_DIFF] = {
            { 1,  70177 }, -- Schematic: Flintlocke's Woodchucker
            { 2,  71078 }, -- Schematic: Extreme-Impact Hole Puncher
            { 3,  70166 }, -- Plans: Brainsplinter
            { 4,  70167 }, -- Plans: Masterwork Elementium Spellblade
            { 5,  70168 }, -- Plans: Lightforged Elementium Hammer
            { 6,  70169 }, -- Plans: Elementium-Edged Scalper
            { 7,  70170 }, -- Plans: Pyrium Spellward
            { 8,  70171 }, -- Plans: Unbreakable Guardian
            { 9,  70172 }, -- Plans: Masterwork Elementium Deathblade
            { 10, 70173 }, -- Plans: Witch-Hunter's Harvester
            { 12, 70118 }, -- Widow's Clutches
            { 13, 70114 }, -- Fireplume Girdle
            { 14, 70115 }, -- Fiery Treads
            { 15, 70116 }, -- Gauntlets of Living Obsidium
            { 16, 70119 }, -- Meteorite Ring
            { 17, 70120 }, -- Rickety Belt
            { 18, 70121 }, -- Ricket's Gun Show
            { 19, 70117 }, -- Belt of Living Obsidium
            { 20, 70144 }, -- Ricket's Magnetic Fireball
        }
    },
    { -- Filling the Moonwell
    name = AL["Filling the Moonwell"],
    [NORMAL_DIFF] = {
        { 1,  70174 }, -- Pattern: Royal Scribe's Satchel
        { 2,  70175 }, -- Pattern: Triple-Reinforced Mining Bag
        { 3,  70176 }, -- Pattern: Luxurious Silk Gem Bag
        { 5,  70110 }, -- Band of Glittering Lights
        { 6,  70112 }, -- Globe of Moonlight
        { 7,  70113 }, -- Moon Blessed Band
        { 8,  70142 }, -- Moonwell Chalice
        { 9,  70143 }, -- Moonwell Phial
        { 11, 70160 }, -- Crimson Lasher
        { 12, 70161 }, -- Mushroom Chair
    }
},
{ -- Calling the Ancients
name = AL["Calling the Ancients"],
[NORMAL_DIFF] = {
    { 1,  70122 }, -- Aviana's Grips
    { 2,  70123 }, -- Lancer's Greaves
    { 3,  70124 }, -- Spirit Fragment Band
    { 4,  70126 }, -- Nemesis Shell Band
    { 5,  70127 }, -- Lylagar Horn Ring
    { 6,  70141 }, -- Dwyer's Caber
    { 8,  70140 }, -- Hyjal Bear Cub
    { 9,  70159 }, -- Mylune's Call
}
},
{ -- Favors of the World Tree
name = AL["Favors of the World Tree"],
[NORMAL_DIFF] = {
    { 1,  70105 }, -- Matoclaw's Band
    { 2,  70106 }, -- Nightweaver's Amulet
    { 3,  70107 }, -- Fireheart Necklace
    { 4,  70108 }, -- Pyrelord Greaves
    { 6,  70145 }, -- Darnassus Writ of Commendation
    { 7,  70146 }, -- Exodar Writ of Commendation
    { 8,  70147 }, -- Gnomeregan Writ of Commendation
    { 9,  70148 }, -- Ironforge Writ of Commendation
    { 13, 70149 }, -- Orgrimmar Writ of Commendation
    { 14, 70150 }, -- Sen'jin Writ of Commendation
    { 15, 70151 }, -- Silvermoon Writ of Commendation
    { 10, 70152 }, -- Stormwind Writ of Commendation
    { 16, 70153 }, -- Thunder Bluff Writ of Commendation
    { 17, 70154 }, -- Undercity Writ of Commendation
    { 11, 71087 }, -- Gilneas Writ of Commendation
    { 18, 71088 }, -- Bilgewater Writ of Commendation
    { 20, 71631 }, -- Zen'Vorka's Cache
    { 21, 34955 }, -- Scorched Stone
}
},
{ -- Misc
name = AL["Misc"],
[NORMAL_DIFF] = {
    { 1,  69213 }, -- Flameward Hippogryph
    { 2,  71259 }, -- Leyara's Locket
    { 4, "ac5866" },
    { 5, "ac5879" },
    { 6, "ac5859" },
},
},
},
}
