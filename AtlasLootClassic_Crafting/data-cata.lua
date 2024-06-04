-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 4, AtlasLoot.CATA_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local PRIME_GLYPHS_DIFF = data:AddDifficulty(ALIL["Prime Glyphs"], "primeglyphs", 0)
local MAJOR_GLYPHS_DIFF = data:AddDifficulty(ALIL["Major Glyphs"], "majorglyphs", 0)
local MINOR_GLYPHS_DIFF = data:AddDifficulty(ALIL["Minor Glyphs"], "minorglyphs", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)

local GEM_FORMAT1 = ALIL["Gems"].." - %s"
local GEM_FORMAT2 = ALIL["Gems"].." - %s & %s"

data["AlchemyCata"] = {
    name = ALIL["Alchemy"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ALCHEMY_LINK,
    items = {
        {
            name = AL["Flasks"],
            [NORMAL_DIFF] = {
                { 1, 80721 },	-- Flask of the Winds
                { 2, 80723 },	-- Flask of the Frost Wyrm
                { 3, 80720 },	-- Flask of the Draconic Mind
                { 4, 94162 },	-- Flask of Flowing Water
                { 5, 80719 },	-- Flask of Steelskin
                { 16, 80724 }, -- Flask of Enhancement
                { 18, 92688 }, -- Big Cauldron of Battle
                { 19, 92643 }, -- Cauldron of Battle

            },
        },
        {
            name = AL["Transmutes"],
            [NORMAL_DIFF] = {
                { 1, 80245 }, -- Transmute: Inferno Ruby
                { 2, 80247 }, -- Transmute: Amberjewel
                { 3, 80246 }, -- Transmute: Ocean Sapphire
                { 4, 80248 }, -- Transmute: Demonseye
                { 5, 80250 }, -- Transmute: Ember Topaz
                { 6, 80251 }, -- Transmute: Dream Emerald
                { 8, 80237 }, -- Transmute: Shadowspirit Diamond
                { 16, 80243 }, -- Transmute: Truegold
                { 17, 80244 }, -- Transmute: Pyrium Bar
                { 19, 78866 }, -- Transmute: Living Elements
            },
        },
        {
            name = AL["Healing/Mana Potions"],
            [NORMAL_DIFF] = {
                { 1, 80498 }, -- Mythical Healing Potion
                { 2, 80494 }, -- Mythical Mana Potion
                { 4, 80490 }, -- Mighty Rejuvenation Potion
                { 16, 80487 }, -- Mysterious Potion
                { 18, 80482 }, -- Potion of Concentration
                { 20, 93935 }, -- Draught of War
            },
        },
        {
            name = AL["Util Potions"],
            [NORMAL_DIFF] = {
                { 1, 80496 }, -- Golemblood Potion
                { 2, 80495 }, -- Potion of the Tol'vir
                { 3, 80481 }, -- Volcanic Potion
                { 4, 80478 }, -- Earthen Potion
            },
        },
        {
            name = AL["Elixirs"],
            [NORMAL_DIFF] = {
                { 1, 80497 }, -- Elixir of the Master
                { 2, 80493 }, -- Elixir of Mighty Speed
                { 3, 80491 }, -- Elixir of Impossible Accuracy
                { 4, 80484 }, -- Elixir of the Cobra
                { 5, 80480 }, -- Elixir of the Naga
                { 6, 80477 }, -- Ghost Elixir
                { 16, 80492 }, -- Prismatic Elixir
                { 17, 80488 }, -- Elixir of Deep Earth
                { 19, 80479 }, -- Deathblood Venom
            },
        },
        {
            name = AL["Stones"],
            [NORMAL_DIFF] = {
                { 1, 80508 }, -- Lifebound Alchemist Stone
                { 2, 96253 }, -- Quicksilver Alchemist Stone
                { 3, 96254 }, -- Vibrant Alchemist Stone
                { 4, 96252 }, -- Volatile Alchemist Stone
            },
        },
        {
            name = AL["Mount"],
            [NORMAL_DIFF] = {
                { 1, 93328 }, -- Vial of the Sands
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 80725 }, -- Potion of Deepholm
                { 2, 80726 }, -- Potion of Treasure Finding
                { 3, 80269 }, -- Potion of Illusion
                { 16, 80486 }, -- Deepstone Oil
            },
        }
    },
}

data["BlacksmithingCata"] = {
    name = ALIL["Blacksmithing"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.BLACKSMITHING_LINK,
    items = {
        { -- Daggers
            name = AL["Weapons"].." - "..ALIL["Daggers"],
            [NORMAL_DIFF] = {
                { 1, 99652 }, -- Brainsplinter
                { 2, 76453 }, -- Elementium Shank
                { 3, 76434 }, -- Cold Forged Shank
            }
        },
        { -- Axes
            name = AL["Weapons"].." - "..AL["Axes"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
                { 2, 99655 },   -- Elementium-Edged Scalper
                { 3, 76452 },	-- Elementium Bonesplitter
                { 4, 94718 },	-- Elementium Gutslicer
                { 5, 76433 },	-- Decapitator's Razor
            }
        },
        { -- Maces
            name = AL["Weapons"].." - "..AL["Maces"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
                { 2, 99654 }, -- Lightforged Elementium Hammer
                { 3, 76450 }, -- Elementium Hammer
                { 4, 76436 }, -- Lifeforce Hammer
                { 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
                { 17, 94732 }, -- Forged Elementium Mindcrusher
            }
        },
        { -- Swords
            name = AL["Weapons"].." - "..AL["Swords"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
                { 2, 99657 }, -- Unbreakable Guardian
                { 3, 99656 }, -- Pyrium Spellward
                { 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
                { 17, 99658 }, -- Masterwork Elementium Deathblade
                { 18, 76437 }, -- Obsidian Executioner
            }
        },
        { -- Polearms
            name = AL["Weapons"].." - "..AL["Polearms"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_06", nil, ALIL["Polearms"] },
                { 2, 99660 }, -- Witch Hunter's Harvester
                { 3, 76451 }, -- Elementium Poleaxe
                { 4, 76474 }, -- Obsidium Bladespear
            }
        },
        { -- Shield
            name = AL["Weapons"].." - "..ALIL["Shield"],
            [NORMAL_DIFF] = {
                { 1, 76454 }, -- Elementium Earthguard
                { 2, 76455 }, -- Elementium Stormshield
                { 3, 76293 }, -- Stormforged Shield
                { 4, 76291 }, -- Hardened Obsidium Shield
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [PLATE_DIFF] = {
                { 1, 76463 },	-- Bloodied Pyrium Helm
                { 2, 76471 },	-- Ornate Pyrium Helm
                { 3, 76288 },	-- Stormforged Helm
                { 4, 76260 },	-- Hardened Obsidium Helm
                { 5, 76269 },	-- Redsteel Helm
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [PLATE_DIFF] = {
                { 1, 76461 },	-- Bloodied Pyrium Shoulders
                { 2, 76469 },	-- Ornate Pyrium Shoulders
                { 3, 76286 },	-- Stormforged Shoulders
                { 4, 76258 },	-- Hardened Obsidium Shoulders
                { 5, 76266 },	-- Redsteel Shoulders
            },
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [PLATE_DIFF] = {
                { 1, 76443 },	-- Hardened Elementium Hauberk
                { 2, 76445 },	-- Elementium Deathplate
                { 3, 76447 },	-- Light Elementium Chestguard
                { 4, 76472 },	-- Ornate Pyrium Breastplate
                { 5, 76464 },	-- Bloodied Pyrium Breastplate
                { 6, 76270 },	-- Redsteel Breastplate
                { 7, 76289 },	-- Stormforged Breastplate
                { 8, 76261 },	-- Hardened Obsidium Breastplate
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [PLATE_DIFF] = {
                { 1, 99452 }, -- Warboots of Mighty Lords
                { 2, 99453 }, -- Mirrored Boots
                { 3, 99454 }, -- Emberforged Elementium Boots
                { 4, 76459 }, -- Bloodied Pyrium Boots
                { 5, 76468 }, -- Ornate Pyrium Boots
                { 6, 76265 }, -- Redsteel Boots
                { 7, 76285 }, -- Stormforged Boots
                { 8, 76182 }, -- Hardened Obsidium Boots
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [PLATE_DIFF] = {
                { 1, 99439 }, -- Fists of Fury
                { 2, 99440 }, -- Eternal Elementium Handguards
                { 3, 99441 }, -- Holy Flame Gauntlets
                { 4, 76466 }, -- Ornate Pyrium Gauntlets
                { 5, 76457 }, -- Bloodied Pyrium Gauntlets
                { 6, 76281 }, -- Stormforged Gauntlets
                { 7, 76180 }, -- Hardened Obsidium Gauntlets
                { 8, 76263 }, -- Redsteel Gauntlets
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [PLATE_DIFF] = {
                { 1, 101924 }, -- Pyrium Legplates of Purified Evil
                { 2, 101925 }, -- Unstoppable Destroyer's Legplates
                { 3, 101928 }, -- Foundations of Courage
                { 4, 76470 },  -- Ornate Pyrium Legguards
                { 5,76462 },   -- Bloodied Pyrium Legguards
                { 6, 76287 },  -- Stormforged Legguards
                { 7, 76267 },  -- Redsteel Legguards
                { 8, 76259 },  -- Hardened Obsidium Legguards
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [PLATE_DIFF] = {
                { 1, 76444 }, -- Hardened Elementium Girdle
                { 2, 76446 }, -- Elementium Girdle of Pain
                { 3, 76448 }, -- Light Elementium Belt
                { 4, 76467 }, -- Ornate Pyrium Belt
                { 5, 76458 }, -- Bloodied Pyrium Belt
                { 6, 76264 }, -- Redsteel Belt
                { 7, 76283 }, -- Stormforged Belt
                { 8, 76181 }, -- Hardened Obsidium Belt
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [PLATE_DIFF] = {
                { 1, 101929 }, -- Soul Redeemer Bracers
                { 2, 101931 }, -- Bracers off DEstructive Strength
                { 3, 101932 }, -- Titanguard Wristplates
                { 4, 76456 }, -- Bloodied Pyrium Bracers
                { 5, 76465 }, -- Ornate Pyrium Bracers
                { 6, 76179 }, -- Hardened Obsidium Bracers
                { 7, 76262 }, -- Redsteel Bracers
                { 8, 76280 }, -- Stormforged Bracers
            },
        },
        { -- Enhancements
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 76439 }, -- Ebonsteel Belt Buckle
                { 5, 55641 }, -- Socket Gloves
                { 16, 76440 }, -- Pyrium Shield Spike
                { 18, 76442 }, -- Pyrium Weapon Chain
                { 20, 55628 }, -- Socket Bracer
            }
        },
        { -- Misc
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 76438 }, -- Obsidium Skeleton Key
                { 3, 92375 }, -- Elementium Rod
                { 16, 76178 }, -- Folded Obsidium
            }
        },
    }
}

data["EnchantingCata"] = {
    name = ALIL["Enchanting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENCHANTING_LINK,
    items = {
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74246 }, -- Enchant Weapon - Landslide
                { 2, 74242 }, -- Enchant Weapon - Power Torrent
                { 3, 74244 }, -- Enchant Weapon - Windwalk
                { 4, 74225 }, -- Enchant Weapon - Heartsong
                { 5, 74223 }, -- Enchant Weapon - Hurricane
                { 6, 74211 }, -- Enchant Weapon - Elemental Slayer
                { 7, 74195 }, -- Enchant Weapon - Mending
                { 8, 74197 }, -- Enchant Weapon - Avalanche
            }
        },
        {
            name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 95471 }, -- Enchant 2H Weapon - Mighty Agility
            }
        },
        {
            name = ALIL["Cloak"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74247 }, -- Enchant Cloak - Greater Critical Strike
                { 2, 74240 }, -- Enchant Cloak - Greater Intellect
                { 3, 74234 }, -- Enchant Cloak - Protection
                { 4, 74230 }, -- Enchant Cloak - Critical Strike
                { 5, 74202 }, -- Enchant Cloak - Intellect
                { 6, 74192 }, -- Enchant Cloak - Greater Spell Piercing
            }
        },
        {
            name = ALIL["Chest"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74251 }, -- Enchant Chest - Greater Stamina
                { 2, 74250 }, -- Enchant Chest - Peerless Stats
                { 3, 74231 }, -- Enchant Chest - Exceptional Spirit
                { 4, 74214 }, -- Enchant Chest - Mighty Resilience
                { 5, 74200 }, -- Enchant Chest - Stamina
                { 6, 74191 }, -- Enchant Chest - Mighty Stats
            }
        },
        {
            name = ALIL["Feet"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74252 }, -- Enchant Boots - Assassin's Step
                { 2, 74253 }, -- Enchant Boots - Lavawalker
                { 3, 74238 }, -- Enchant Boots - Mastery
                { 4, 74236 }, -- Enchant Boots - Precision
                { 5, 74213 }, -- Enchant Boots - Major Agility
                { 6, 74199 }, -- Enchant Boots - Haste
                { 7, 74189 }, -- Enchant Boots - Earthen Vitality
            }
        },
        {
            name = ALIL["Hand"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74255 }, -- Enchant Gloves - Greater Mastery
                { 2, 74254 }, -- Enchant Gloves - Mighty Strength
                { 3, 74220 }, -- Enchant Gloves - Greater Expertise
                { 4, 74212 }, -- Enchant Gloves - Exceptional Strength
                { 5, 74198 }, -- Enchant Gloves - Haste
                { 6, 74132 }, -- Enchant Gloves - Mastery
            }
        },
        {
            name = ALIL["Off-Hand/Shield"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74235 }, -- Enchant Off-Hand - Superior Intellect
                { 16, 74226 }, -- Enchant Shield - Mastery
                { 17, 74207 }, -- Enchant Shield - Protection
            }
        },
        {
            name = ALIL["Wrist"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74248 }, -- Enchant Bracer - Greater Critical Strike
                { 2, 74256 }, -- Enchant Bracer - Greater Speed
                { 3, 96264 }, -- Enchant Bracer - Agility
                { 4, 96261 }, -- Enchant Bracer - Major Strength
                { 5, 96262 }, -- Enchant Bracer - Mighty Intellect
                { 6, 74239 }, -- Enchant Bracer - Greater Expertise
                { 7, 74237 }, -- Enchant Bracer - Exceptional Spirit
                { 8, 74232 }, -- Enchant Bracer - Precision
                { 9, 74229 }, -- Enchant Bracer - Superior Dodge
                { 10, 74201 }, -- Enchant Bracer - Critical Strike
                { 11, 74193 }, -- Enchant Bracer - Speed
            }
        },
        {
            name = AL["Ring"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 74216 }, -- Enchant Ring - Agility
                { 2, 74218 }, -- Enchant Ring - Greater Stamina
                { 3, 74217 }, -- Enchant Ring - Intellect
                { 4, 74215 }, -- Enchant Ring - Strength
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 92370 }, -- Runed Elementium Rod
                { 3, 104698 }, -- Maelstrom Shatter
                { 16, [ATLASLOOT_IT_ALLIANCE] = 93843, [ATLASLOOT_IT_HORDE] = 93841 }, -- Magic Lamp/Enchanted Lantern
            }
        },
    }
}

data["EngineeringCata"] = {
    name = ALIL["Engineering"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENGINEERING_LINK,
    items = {
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Cloth"],
            [NORMAL_DIFF] = {
                { 1, 81725 }, -- Lightweight Bio-Optic Killshades
                { 16, 84406 }, -- Authentic Jr. Engineer Goggles
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
            [NORMAL_DIFF] = {
                { 1, 81724 },	-- Camouflage Bio-Optic Killshades
                { 2, 81722 },	-- Agile Bio-Optic Killshades
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
            [NORMAL_DIFF] = {
                { 1, 81720 },	-- Energized Bio-Optic Killshades
                { 2, 81716 },	-- Deadly Bio-Optic Killshades
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
            [NORMAL_DIFF] = {
                { 1, 81715 },	-- Specialized Bio-Optic Killshades
                { 2, 81714 },	-- Reinforced Bio-Optic Killshades
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 84418 },	-- Elementium Dragonling
            }
        },
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 84428 },	-- Gnomish X-Ray Scope
                { 2, 100587 },	-- Flintlocke's Woodchucker
                { 3, 84408 },	-- R19 Threatfinder
                { 4, 84410 },	-- Safety Catch Removal Kit
            }
        },
        {
            name = AL["Weapons"],
            [NORMAL_DIFF] = {
                { 1, 100687 },	-- Extreme-Impact Hole Puncher
                { 2, 84432 },	-- Kickback 5000
                { 3, 84431 },	-- Overpowered Chicken Splitter
                { 4, 84420 },	-- Finely-Tuned Throat Needler
                { 16, 84411 },	-- High-Powered Bolt Gun
            }
        },
        {
            name = ALIL["Parts"],
            [NORMAL_DIFF] = {
                { 1, 94748 },	-- Electrified Ether
                { 2, 84403 },	-- Handful of Obsidium Bolts
            }
        },
        {
            name = ALIL["Explosives"],
            [NORMAL_DIFF] = {
                { 1, 95707 },	-- Big Daddy
                { 2, 84409 },	-- Volatile Seaforium Blastpack
            }
        },
        {
            name = ALIL["Engineering"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 82175 },	-- Synapse Springs
                { 2, 82177 },	-- Quickflip Deflection Plates
                { 3, 82180 },	-- Tazik Shocker
                { 4, 82200 },	-- Spinal Healing Injector
                { 5, 82201 },	-- Z50 Mana Gulper
                { 16, 84424 },	-- Invisibility Field
                { 17, 84425 },	-- Cardboard Assassin
                { 18, 84427 },	-- Grounded Plasma Shield
                { 20, 84430 },	-- Heat-Treated Spinning Lure
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 84412 },   -- Personal World Destroyer
                { 2, 84413 },	-- De-Weaponized Mechanical Companion
                { 4, 95705 },	-- Gnomish Gravity Well
                { 5, 84421 },	-- Loot-a-Rang
                { 16, 84416 },	-- Elementium Toolbox
                { 17, 84415 },	-- Lure Master Tackle Box\
                { 19, 84429 },	-- Goblin Barbecue
                { 21, 95703 },	-- Electrostatic Condenser
            }
        },
    }
}

data["InscriptionCata"] = {
    name = ALIL["Inscription"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.INSCRIPTION_LINK,
    items = {
        {
            name = AL["Armor"].." - "..ALIL["Off Hand"],
            [NORMAL_DIFF] = {
                { 1, 86640 }, -- Lord Rottington's Pressed Wisp Book
                { 2, 86616 }, -- Book of Blood
                { 16, 86643 }, -- Battle Tome
                { 17, 86642 }, -- Divine Companion
                { 18, 86641 }, -- Dungeoneering Guide
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Relic"],
            [NORMAL_DIFF] = {
                { 1, 86647 }, -- Etched Horn
                { 2, 86648 }, -- Manual of the Planes
                { 3, 86649 }, -- Runed Dragonscale
                { 5, 99547 }, -- Vicious Charm of Triumph
                { 6, 99548 }, -- Vicious Eyeball of Dominance
                { 7, 99549 }, -- Vicious Jawbone of Conquest
                { 16, 86650 }, -- Notched Jawbone
                { 17, 86653 }, -- Silver Inlaid Leaf
                { 18, 86652 }, -- Tattooed Eyeball
            }
        },
        {
            name = AL["Glyphs"].." - "..ALIL["DEATHKNIGHT"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57214 }, -- Glyph of Death and Decay
                { 2, 64266 }, -- Glyph of Death Coil
                { 3, 59340 }, -- Glyph of Death Strike
                { 4, 57216 }, -- Glyph of Frost Strike
                { 5, 57219 }, -- Glyph of Icy Touch
                { 6, 57208 }, -- Glyph of Heart Strike
                { 16, 64300 }, -- Glyph of Howling Blast
                { 17, 57220 }, -- Glyph of Obliterate
                { 18, 57222 }, -- Glyph of Raise Dead
                { 19, 57223 }, -- Glyph of Rune Strike
                { 20, 57224 }, -- Glyph of Scourge Strike
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57207 }, -- Glyph of Anti-Magic Shell
                { 2, 59339 }, -- Glyph of Blood Boil
                { 3, 57210 }, -- Glyph of Bone Shield
                { 4, 57211 }, -- Glyph of Chains of Ice
                { 5, 64297 }, -- Glyph of Dancing Rune Weapon
                { 6, 96284 }, -- Glyph of Dark Succor
                { 7, 57213 }, -- Glyph of Death Grip
                { 16, 64298 }, -- Glyph of Hungering Cold
                { 17, 57221 }, -- Glyph of Pestilence
                { 18, 57226 }, -- Glyph of Pillar of Frost
                { 19, 59338 }, -- Glyph of Rune Tap
                { 20, 57225 }, -- Glyph of Strangulate
                { 21, 57227 }, -- Glyph of Vampiric Blood
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 57209 }, -- Glyph of Blood Tap
                { 2, 57228 }, -- Glyph of Death Gate
                { 3, 57215 }, -- Glyph of Death's Embrace
                { 4, 57217 }, -- Glyph of Horn of Winter
                { 5, 57229 }, -- Glyph of Path of Frost
                { 6, 57230 }, -- Glyph of Resilient Grip
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["DRUID"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64268 }, -- Glyph of Berserk
                { 2, 56957 }, -- Glyph of Bloodletting
                { 3, 56948 }, -- Glyph of Insect Swarm
                { 4, 94402 }, -- Glyph of Lacerate
                { 5, 56949 }, -- Glyph of Lifebloom
                { 6, 56950 }, -- Glyph of Mangle
                { 7, 56951 }, -- Glyph of Moonfire
                { 8, 56954 }, -- Glyph of Regrowth
                { 16, 56955 }, -- Glyph of Rejuvenation
                { 17, 56956 }, -- Glyph of Rip
                { 18, 64307 }, -- Glyph of Savage Roar
                { 19, 64313 }, -- Glyph of Starsurge
                { 20, 56959 }, -- Glyph of Starfire
                { 21, 56960 }, -- Glyph of Swiftmend
                { 22, 94401 }, -- Glyph of Tiger's Fury
                { 23, 56963 }, -- Glyph of Wrath
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 64256 }, -- Glyph of Barkskin
                { 2, 48121 }, -- Glyph of Entangling Roots
                { 3, 94403 }, -- Glyph of Faerie Fire
                { 4, 94404 }, -- Glyph of Feral Charge
                { 5, 67600 }, -- Glyph of Ferocious Bite
                { 6, 62162 }, -- Glyph of Focus
                { 7, 56943 }, -- Glyph of Frenzied Regeneration
                { 8, 56945 }, -- Glyph of Healing Touch
                { 9, 56946 }, -- Glyph of Hurricane
                { 16, 56947 }, -- Glyph of Innervate
                { 17, 56961 }, -- Glyph of Maul
                { 18, 64258 }, -- Glyph of Monsoon
                { 19, 56952 }, -- Glyph of Pounce
                { 20, 56953 }, -- Glyph of Rebirth
                { 21, 56944 }, -- Glyph of Solar Beam
                { 22, 56958 }, -- Glyph of Starfall
                { 23, 58289 }, -- Glyph of Thorns
                { 24, 64270 }, -- Glyph of Wild Growth
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58286 }, -- Glyph of Aquatic Form
                { 2, 58287 }, -- Glyph of Challenging Roar
                { 3, 59315 }, -- Glyph of Dash
                { 4, 58296 }, -- Glyph of Mark of the Wild
                { 5, 95215 }, -- Glyph of the Treant
                { 6, 56965 }, -- Glyph of Typhoon
                { 7, 58288 }, -- Glyph of Unburdened Rebirth
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["HUNTER"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 56994 }, -- Glyph of Aimed Shot
                { 2, 56995 }, -- Glyph of Arcane Shot
                { 3, 64271 }, -- Glyph of Chimera Shot
                { 4, 64273 }, -- Glyph of Explosive Shot
                { 5, 57012 }, -- Glyph of Kill Command
                { 16, 64304 }, -- Glyph of Kill Shot
                { 17, 57008 }, -- Glyph of Rapid Fire
                { 18, 57009 }, -- Glyph of Serpent Sting
                { 19, 57011 }, -- Glyph of Steady Shot
                { 20, 57006 }, -- Glyph of the Dazzled Prey
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 56999 }, -- Glyph of Bestial Wrath
                { 2, 56998 }, -- Glyph of Concussive Shot
                { 3, 57000 }, -- Glyph of Deterrence
                { 4, 57001 }, -- Glyph of Disengage
                { 5, 57002 }, -- Glyph of Freezing Trap
                { 6, 57003 }, -- Glyph of Ice Trap
                { 7, 57005 }, -- Glyph of Immolation Trap
                { 8, 64253 }, -- Glyph of Master's Call
                { 16, 56997 }, -- Glyph of Mending
                { 17, 57004 }, -- Glyph of Misdirection
                { 18, 64246 }, -- Glyph of Raptor Strike
                { 19, 64249 }, -- Glyph of Scatter Shot
                { 20, 57007 }, -- Glyph of Silencing Shot
                { 21, 57010 }, -- Glyph of Snake Trap
                { 22, 56996 }, -- Glyph of Trap Launcher
                { 22, 57014 }, -- Glyph of Wyvern Sting
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58297 }, -- Glyph of Aspect of the Pack
                { 2, 58302 }, -- Glyph of Feign Death
                { 3, 58301 }, -- Glyph of Lesser Proportion
                { 4, 58299 }, -- Glyph of Revive Pet
                { 5, 58298 }, -- Glyph of Scare Beast
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["MAGE"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64276 }, -- Glyph of Arcane Barrage
                { 2, 56991 }, -- Glyph of Arcane Blast
                { 3, 56971 }, -- Glyph of Arcane Missiles
                { 4, 56988 }, -- Glyph of Cone of Cold
                { 5, 64274 }, -- Glyph of Deep Freeze
                { 6, 56975 }, -- Glyph of Fireball
                { 7, 56977 }, -- Glyph of Frostbolt
                { 16, 61677 }, -- Glyph of Frostfire
                { 17, 56980 }, -- Glyph of Ice Lance
                { 18, 94000 }, -- Glyph of Living Bomb
                { 19, 56984 }, -- Glyph of Mage Armor
                { 20, 56986 }, -- Glyph of Molten Armor
                { 21, 56978 }, -- Glyph of Pyroblast
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 56972 }, -- Glyph of Arcane Power
                { 2, 56990 }, -- Glyph of Blast Wave
                { 3, 56973 }, -- Glyph of Blink
                { 4, 56989 }, -- Glyph of Dragon's Breath
                { 5, 56974 }, -- Glyph of Evocation
                { 6, 56976 }, -- Glyph of Frost Nova
                { 7, 98398 }, -- Glyph of Frost Armor
                { 16, 64257 }, -- Glyph of Ice Barrier
                { 17, 56979 }, -- Glyph of Ice Block
                { 18, 56981 }, -- Glyph of Icy Veins
                { 19, 56983 }, -- Glyph of Invisibility
                { 20, 71101 }, -- Glyph of Mana Shield
                { 21, 56987 }, -- Glyph of Polymorph
                { 22, 64275 }, -- Glyph of Slow
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58303 }, -- Glyph of Arcane Brilliance
                { 2, 95710 }, -- Glyph of Armors
                { 3, 58306 }, -- Glyph of Conjuring
                { 4, 64314 }, -- Glyph of Mirror Image
                { 5, 58308 }, -- Glyph of Slow Fall
                { 6, 58307 }, -- Glyph of the Monkey
                { 7, 58310 }, -- Glyph of the Penguin
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["PALADIN"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57024 }, -- Glyph of Crusader Strike
                { 2, 57029 }, -- Glyph of Divine Favor
                { 3, 57025 }, -- Glyph of Exorcism
                { 4, 64278 }, -- Glyph of Hammer of the Righteous
                { 5, 64254 }, -- Glyph of Holy Shock
                { 6, 57030 }, -- Glyph of Judgement
                { 16, 57034 }, -- Glyph of Seal of Insight
                { 17, 59561 }, -- Glyph of Seal of Truth
                { 18, 64308 }, -- Glyph of Shield of the Righteous
                { 19, 64279 }, -- Glyph of Templar's Verdict
                { 20, 57026 }, -- Glyph of Word of Glory
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 64277 }, -- Glyph of Beacon of Light
                { 2, 57020 }, -- Glyph of Cleansing
                { 3, 57023 }, -- Glyph of Consecration
                { 4, 59560 }, -- Glyph of Dazing Shield
                { 5, 64305 }, -- Glyph of Divine Plea
                { 6, 57022 }, -- Glyph of Divine Protection
                { 7, 57031 }, -- Glyph of Divinity
                { 8, 57019 }, -- Glyph of Focused Shield
                { 9, 57027 }, -- Glyph of Hammer of Justice
                { 16, 57028 }, -- Glyph of Hammer of Wrath
                { 17, 59559 }, -- Glyph of Holy Wrath
                { 18, 57035 }, -- Glyph of Light of Dawn
                { 19, 57033 }, -- Glyph of Rebuke
                { 20, 57032 }, -- Glyph of Righteousness
                { 21, 64251 }, -- Glyph of Salvation
                { 22, 57021 }, -- Glyph of the Ascetic Crusader
                { 23, 95825 }, -- Glyph of the Long Word
                { 24, 57036 }, -- Glyph of Turn Evil
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58311 }, -- Glyph of Blessing of Kings
                { 2, 58314 }, -- Glyph of Blessing of Might
                { 3, 58312 }, -- Glyph of Insight
                { 4, 58316 }, -- Glyph of Justice
                { 5, 58313 }, -- Glyph of Lay on Hands
                { 6, 58315 }, -- Glyph of Truth
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["PRIEST"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64280 }, -- Glyph of Dispersion
                { 2, 57186 }, -- Glyph of Flash Heal
                { 3, 64281 }, -- Glyph of Guardian Spirit
                { 4, 57189 }, -- Glyph of Lightwell
                { 5, 57200 }, -- Glyph of Mind Flay
                { 6, 64282 }, -- Glyph of Penance
                { 16, 57193 }, -- Glyph of Power Word: Barrier
                { 17, 57194 }, -- Glyph of Power Word: Shield
                { 18, 57195 }, -- Glyph of Prayer of Healing
                { 19, 57197 }, -- Glyph of Renew
                { 20, 57199 }, -- Glyph of Shadow Word: Death
                { 21, 57192 }, -- Glyph of Shadow Word: Pain
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57181 }, -- Glyph of Circle of Healing
                { 2, 64259 }, -- Glyph of Desperation
                { 3, 57183 }, -- Glyph of Dispel Magic
                { 4, 64283 }, -- Glyph of Divine Accuracy
                { 5, 57184 }, -- Glyph of Fade
                { 6, 57185 }, -- Glyph of Fear Ward
                { 7, 57187 }, -- Glyph of Holy Nova
                { 8, 57188 }, -- Glyph of Inner Fire
                { 16, 57190 }, -- Glyph of Mass Dispel
                { 17, 57202 }, -- Glyph of Prayer of Mending
                { 18, 57191 }, -- Glyph of Psychic Horror
                { 19, 57196 }, -- Glyph of Psychic Scream
                { 20, 57198 }, -- Glyph of Scourge Imprisonment
                { 21, 57201 }, -- Glyph of Smite
                { 22, 64309 }, -- Glyph of Spirit Tap
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58317 }, -- Glyph of Fading
                { 2, 58318 }, -- Glyph of Fortitude
                { 3, 58319 }, -- Glyph of Levitate
                { 4, 107907 }, -- Glyph of Shadow
                { 5, 58320 }, -- Glyph of Shackle Undead
                { 6, 58321 }, -- Glyph of Shadow Protection
                { 7, 58322 }, -- Glyph of Shadowfiend
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["ROGUE"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57112 }, -- Glyph of Adrenaline Rush
                { 2, 57114 }, -- Glyph of Backstab
                { 3, 57120 }, -- Glyph of Eviscerate
                { 4, 57126 }, -- Glyph of Hemorrhage
                { 5, 64285 }, -- Glyph of Killing Spree
                { 6, 64260 }, -- Glyph of Mutilate
                { 16, 57124 }, -- Glyph of Revealing Strike
                { 17, 57128 }, -- Glyph of Rupture
                { 18, 64286 }, -- Glyph of Shadow Dance
                { 19, 57131 }, -- Glyph of Sinister Strike
                { 20, 57132 }, -- Glyph of Slice and Dice
                { 21, 64284 }, -- Glyph of Vendetta
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57113 }, -- Glyph of Ambush
                { 2, 57115 }, -- Glyph of Blade Flurry
                { 3, 92579 }, -- Glyph of Blind
                { 4, 64303 }, -- Glyph of Cloak of Shadows
                { 5, 57116 }, -- Glyph of Crippling Poison
                { 6, 57117 }, -- Glyph of Deadly Throw
                { 7, 57119 }, -- Glyph of Evasion
                { 8, 57121 }, -- Glyph of Expose Armor
                { 9, 64315 }, -- Glyph of Fan of Knives
                { 16, 57122 }, -- Glyph of Feint
                { 17, 57123 }, -- Glyph of Garrote
                { 18, 57125 }, -- Glyph of Gouge
                { 19, 57130 }, -- Glyph of Kick
                { 20, 57127 }, -- Glyph of Preparation
                { 21, 57129 }, -- Glyph of Sap
                { 22, 57133 }, -- Glyph of Sprint
                { 23, 64310 }, -- Glyph of Tricks of the Trade
                { 24, 94711 }, -- Glyph of Vanish
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58323 }, -- Glyph of Blurred Speed
                { 2, 58324 }, -- Glyph of Distract
                { 3, 58325 }, -- Glyph of Pick Lock
                { 4, 58326 }, -- Glyph of Pick Pocket
                { 5, 58328 }, -- Glyph of Poisons
                { 6, 58327 }, -- Glyph of Safe Fall
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["SHAMAN"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64261 }, -- Glyph of Earth Shield
                { 2, 57236 }, -- Glyph of Earthliving Weapon
                { 3, 64288 }, -- Glyph of Feral Spirit
                { 4, 57237 }, -- Glyph of Fire Elemental Totem
                { 5, 57239 }, -- Glyph of Flame Shock
                { 6, 57240 }, -- Glyph of Flametongue Weapon
                { 7, 57234 }, -- Glyph of Lava Burst
                { 8, 57249 }, -- Glyph of Lava Lash
                { 16, 57245 }, -- Glyph of Lightning Bolt
                { 17, 64289 }, -- Glyph of Riptide
                { 18, 57235 }, -- Glyph of Shocking
                { 19, 57248 }, -- Glyph of Stormstrike
                { 20, 101057 }, -- Glyph of Unleashed Lightning
                { 21, 57251 }, -- Glyph of Water Shield
                { 22, 57252 }, -- Glyph of Windfury Weapon
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57232 }, -- Glyph of Chain Heal
                { 2, 57233 }, -- Glyph of Chain Lightning
                { 3, 57250 }, -- Glyph of Elemental Mastery
                { 4, 57238 }, -- Glyph of Fire Nova
                { 5, 57241 }, -- Glyph of Frost Shock
                { 6, 59326 }, -- Glyph of Ghost Wolf
                { 7, 57247 }, -- Glyph of Grounding Totem
                { 8, 57242 }, -- Glyph of Healing Stream Totem
                { 16, 57243 }, -- Glyph of Healing Wave
                { 17, 64316 }, -- Glyph of Hex
                { 18, 57246 }, -- Glyph of Lightning Shield
                { 19, 64262 }, -- Glyph of Shamanistic Rage
                { 20, 64247 }, -- Glyph of Stoneclaw Totem
                { 21, 64287 }, -- Glyph of Thunder
                { 22, 57244 }, -- Glyph of Totemic Recall
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58329 }, -- Glyph of Astral Recall
                { 2, 58330 }, -- Glyph of Renewed Life
                { 3, 58332 }, -- Glyph of the Arctic Wolf
                { 4, 57253 }, -- Glyph of Thunderstorm
                { 5, 58331 }, -- Glyph of Water Breathing
                { 6, 58333 }, -- Glyph of Water Walking
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["WARLOCK"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57260 }, -- Glyph of Bane of Agony
                { 2, 64294 }, -- Glyph of Chaos Bolt
                { 3, 57258 }, -- Glyph of Conflagrate
                { 4, 57259 }, -- Glyph of Corruption
                { 5, 57263 }, -- Glyph of Felguard
                { 6, 64291 }, -- Glyph of Haunt
                { 7, 57268 }, -- Glyph of Immolate
                { 16, 57269 }, -- Glyph of Imp
                { 17, 57257 }, -- Glyph of Incinerate
                { 18, 71102 }, -- Glyph of Lash of Pain
                { 19, 64318 }, -- Glyph of Metamorphosis
                { 20, 57272 }, -- Glyph of Shadowburn
                { 21, 57276 }, -- Glyph of Unstable Affliction
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57261 }, -- Glyph of Death Coil
                { 2, 64317 }, -- Glyph of Demonic Circle
                { 3, 57262 }, -- Glyph of Fear
                { 4, 57264 }, -- Glyph of Felhunter
                { 5, 57266 }, -- Glyph of Healthstone
                { 6, 57267 }, -- Glyph of Howl of Terror
                { 7, 64248 }, -- Glyph of Life Tap
                { 16, 57275 }, -- Glyph of Seduction
                { 17, 57271 }, -- Glyph of Shadow Bolt
                { 18, 64311 }, -- Glyph of Shadowflame
                { 19, 64250 }, -- Glyph of Soul Link
                { 20, 57270 }, -- Glyph of Soul Swap
                { 21, 57274 }, -- Glyph of Soulstone
                { 22, 57277 }, -- Glyph of Voidwalker
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58338 }, -- Glyph of Curse of Exhaustion
                { 2, 58337 }, -- Glyph of Drain Soul
                { 3, 58340 }, -- Glyph of Eye of Kilrogg
                { 4, 57265 }, -- Glyph of Health Funnel
                { 5, 58341 }, -- Glyph of Ritual of Souls
                { 6, 58339 }, -- Glyph of Subjugate Demon
                { 7, 58336 }, -- Glyph of Unending Breath
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["WARRIOR"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64295 }, -- Glyph of Bladestorm
                { 2, 57156 }, -- Glyph of Bloodthirst
                { 3, 57155 }, -- Glyph of Devastate
                { 4, 57160 }, -- Glyph of Mortal Strike
                { 5, 57161 }, -- Glyph of Overpower
                { 16, 57172 }, -- Glyph of Raging Blow
                { 17, 57165 }, -- Glyph of Revenge
                { 18, 57152 }, -- Glyph of Shield Slam
                { 19, 57163 }, -- Glyph of Slam
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57154 }, -- Glyph of Cleaving
                { 2, 89815 }, -- Glyph of Colossus Smash
                { 3, 94405 }, -- Glyph of Death Wish
                { 4, 57158 }, -- Glyph of Heroic Throw
                { 5, 94406 }, -- Glyph of Intercept
                { 6, 57159 }, -- Glyph of Intervene
                { 7, 57157 }, -- Glyph of Piercing Howl
                { 8, 57162 }, -- Glyph of Rapid Charge
                { 16, 57164 }, -- Glyph of Resonating Power
                { 17, 64252 }, -- Glyph of Shield Wall
                { 18, 64296 }, -- Glyph of Shockwave
                { 19, 64302 }, -- Glyph of Spell Reflection
                { 20, 57167 }, -- Glyph of Sunder Armor
                { 21, 57168 }, -- Glyph of Sweeping Strikes
                { 22, 57170 }, -- Glyph of Victory Rush
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58342 }, -- Glyph of Battle
                { 2, 58343 }, -- Glyph of Berserker Rage
                { 3, 57153 }, -- Glyph of Bloody Healing
                { 4, 68166 }, -- Glyph of Command
                { 5, 58345 }, -- Glyph of Demoralizing Shout
                { 6, 58347 }, -- Glyph of Enduring Victory
                { 7, 64255 }, -- Glyph of Furious Sundering
                { 8, 64312 }, -- Glyph of Intimidating Shout
                { 9, 58344 }, -- Glyph of Long Charge
                { 10, 58346 }, -- Glyph of Thunder Clap
            },
        },
        {
            name = AL["Cards"],
            [NORMAL_DIFF] = {
                { 1, 86615 }, -- Darkmoon Card of Destruction
                { 16, 86609 }, -- Mysterious Fortune Card
            }
        },
        {
            name = AL["Ink"],
            [NORMAL_DIFF] = {
                { 1, 86005 }, -- Inferno Ink
                { 2, 86004 }, -- Blackfallow Ink
            }
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 86403 }, -- Felfire Inscription
                { 2, 86402 }, -- Inscription of the Earth Prince
                { 3, 86401 }, -- Lionsmane Inscription
                { 4, 86375 }, -- Swiftsteel Inscription
            },
        },
        {
            name = AL["Scrolls"],
            [NORMAL_DIFF] = {
                { 1, 85785 }, -- Runescroll of Fortitude II
                { 16, 89370 }, -- Scroll of Agility IX
                { 17, 89369 }, -- Scroll of Strength IX
                { 18, 89372 }, -- Scroll of Stamina IX
                { 19, 89371 }, -- Scroll of Spirit IX
                { 20, 89373 }, -- Scroll of Protection IX
                { 21, 89368 }, -- Scroll of Intellect IX
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 89367 }, -- Adventurer's Journal
                { 3, 92027 }, -- Dust of Disappearance
                { 4, 92026 }, -- Vanishing Powder
                { 16, [ATLASLOOT_IT_ALLIANCE] = 89244, [ATLASLOOT_IT_HORDE] = 86654 }, -- Forged Documents
                { 18, 86646 }, -- Origami Beetle
                { 19, 86645 }, -- Origami Rock
                { 20, 86644 }, -- Origami Slime
            }
        },
    }
}

data["JewelcraftingCata"] = {
    name = ALIL["Jewelcrafting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.JEWELCRAFTING_LINK,
    items = {
        {
            name = ALIL["Jewelcrafting"].." - "..ALIL["Gems"],
            [NORMAL_DIFF] = {
                { 1, 73396 }, -- Bold Chimera's Eye
                { 2, 73399 }, -- Brilliant Chimera's Eye
                { 3, 73397 }, -- Delicate Chimera's Eye
                { 4, 73398 }, -- Flashing Chimera's Eye
                { 5, 73400 }, -- Precise Chimera's Eye
                { 7, 73409 }, -- Fractured Chimera's Eye
                { 8, 73407 }, -- Mystic Chimera's Eye
                { 9, 73408 }, -- Quick Chimera's Eye
                { 10, 73406 }, -- Smooth Chimera's Eye
                { 11, 73405 }, -- Subtle Chimera's Eye
                { 16, 73404 }, -- Rigid Chimera's Eye
                { 17, 73401 }, -- Solid Chimera's Eye
                { 18, 73402 }, -- Sparkling Chimera's Eye
                { 19, 73403 }, -- Stormy Chimera's Eye
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Neck"],
            [NORMAL_DIFF] = {
                { 1, 73521 }, -- Brazen Elementium Medallion
                { 2, 73506 }, -- Elementium Guardian
                { 3, 73504 }, -- Entwined Elementium Choker
                { 4, 73505 }, -- Eye of Many Deaths
                { 5, 99543 }, -- Vicious Amberjewel Pendant
                { 6, 99544 }, -- Vicious Ruby Choker
                { 7, 99542 }, -- Vicious Sapphire Necklace
                { 8, 73497 }, -- Nightstone Choker
            }
        },
        {
            name = AL["Armor"].." - "..AL["Ring"],
            [NORMAL_DIFF] = {
                { 1, 73498 }, -- Band of Blades
                { 2, 73520 }, -- Elementium Destroyer's Ring
                { 3, 73503 }, -- Elementium Moebius Band
                { 4, 98921 }, -- Punisher's Band
                { 5, 73502 }, -- Ring of Warring Elements
                { 6, 99540 }, -- Vicious Amberjewel Band
                { 7, 99541 }, -- Vicious Ruby Signet
                { 8, 99539 }, -- Vicious Sapphire Ring
                { 9, 73495 }, -- Hessonite Band
                { 10, 73494 }, -- Jasper Ring
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 73640 }, -- Figurine - Demon Panther
                { 2, 73643 }, -- Figurine - Dream Owl
                { 3, 73641 }, -- Figurine - Earthen Guardian
                { 4, 73642 }, -- Figurine - Jeweled Serpent
                { 5, 73639 }, -- Figurine - King of Boars
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Meta"]),
            [NORMAL_DIFF] = {
                { 1, 96255 }, -- Agile Shadowspirit Diamond
                { 2, 73468 }, -- Austere Shadowspirit Diamond
                { 3, 73466 }, -- Bracing Shadowspirit Diamond
                { 4, 96257 }, -- Burning Shadowspirit Diamond
                { 5, 73465 }, -- Chaotic Shadowspirit Diamond
                { 6, 73472 }, -- Destructive Shadowspirit Diamond
                { 7, 73469 }, -- Efullgent Shadowspirit Diamond
                { 8, 73470 }, -- Ember Shadowspirit Diamond
                { 16, 73474 }, -- Enigmatic Shadowspirit Diamond
                { 17, 73467 }, -- Eternal Shadowspirit Diamond
                { 18, 73464 }, -- Fleet Shadowspirit Diamond
                { 19, 73476 }, -- Forlorn Shadowspirit Diamond
                { 20, 73475 }, -- Impassive Shadowspirit Diamond
                { 21, 73473 }, -- Powerful Shadowspirit Diamond
                { 22, 96256 }, -- Reverberating Shadowspirit Diamond
                { 23, 73471 }, -- Revitalizing Shadowspirit Diamond
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Red"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73335 }, -- Bold Inferno Ruby
                { 2, 73338 }, -- Brilliant Inferno Ruby
                { 3, 73336 }, -- Delicate Inferno Ruby
                { 4, 73337 }, -- Flashing Inferno Ruby
                { 5, 73339 }, -- Precise Inferno Ruby
                -- Uncommon
                { 16, 73222 }, -- Bold Carnelian
                { 17, 73225 }, -- Brilliant Carnelian
                { 18, 73223 }, -- Delicate Carnelian
                { 19, 73224 }, -- Flashing Carnelian
                { 20, 73226 }, -- Precise Carnelian
                -- Epic (move to top after P2)
                { 7, 101799 }, -- Bold Queen's Garnet
                { 8, 101797 }, -- Brilliant Queen's Garnet
                { 9, 101795 }, -- Delicate Queen's Garnet
                { 10, 101798 }, -- Flashing Queen's Garnet
                { 11, 101796 }, -- Precise Queen's Garnet
                -- Perfect Uncommon
                { 22, "i52176" }, -- Perfect Bold Carnelian
                { 23, "i52173" }, -- Perfect Brilliant Carnelian
                { 24, "i52175" }, -- Perfect Delicate Carnelian
                { 25, "i52174" }, -- Perfect Flashing Carnelian
                { 26, "i52172" }, -- Perfect Precise Carnelian
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Yellow"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73349 }, -- Fractured Amberjewel
                { 2, 73347 }, -- Mystic Amberjewel
                { 3, 73348 }, -- Quick Amberjewel
                { 4, 73346 }, -- Smooth Amberjewel
                { 5, 73345 }, -- Subtle Amberjewel
                -- Epic (move to top after P2)
                { 7, 101803 }, -- Fractured Lightstone
                { 8, 101804 },	-- Mystic Lightstone
                { 9, 101802 },	-- Quick Lightstone
                { 10, 101800 },	-- Smooth Lightstone
                { 11, 101801 },	-- Subtle Lightstone
                -- Uncommon
                { 16, 73239 }, -- Fractured Alicite
                { 17, 73233}, -- Mystic Alicite
                { 18, 73234 }, -- Quick Alicite
                { 19, 73232 }, -- Smooth Alicite
                { 20, 73231 }, -- Subtle Alicite
                -- Perfect Uncommon
                { 22, "i52163" }, -- Perfect Fractured Alicite
                { 23, "i52165" }, --  Perfect Mystic Alicite
                { 24, "i52164" }, -- Perfect Quick Alicite
                { 25, "i52166" }, -- Perfect Smooth Alicite
                { 26, "i52167" }, -- Perfect Subtle Alicite
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Blue"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73344 }, -- Rigid Ocean Sapphire
                { 2, 73340 }, -- Solid Ocean Sapphire
                { 3, 73341 }, -- Sparkling Ocean Sapphire
                { 4, 73343 }, -- Stormy Ocean Sapphire
                -- Epic (move to top after P2)
                { 6, 101735 }, -- Rigid Deepholm Iolite
                { 7, 101742 }, -- Solid Deepholm Iolite
                { 8, 101741 }, -- Sparkling Deepholm Iolite
                { 9, 101740 }, -- Stormy Deepholm Iolite
                -- Uncommon
                { 16, 73230 }, -- Rigid Zephyrite
                { 17, 73227 }, -- Solid Zephyrite
                { 18, 73228 }, -- Sparkling Zephyrite
                { 19, 73229 }, -- Stormy Zephyrite
                -- Perfect Uncommon
                { 21, "i52168" }, -- Perfect Rigid Zephyrite
                { 22, "i52171" }, -- Perfect Solid Zephyrite
                { 23, "i52170" }, -- Perfect Sparkling Zephyrite
                { 24, "i52169" }, -- Perfect Stormy Zephyrite
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Orange"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73371 }, -- Adept Ember Topaz
                { 2, 73373 }, -- Artful Ember Topaz
                { 3, 73365 }, -- Deadly Ember Topaz
                { 4, 73368 }, -- Deft Ember Topaz
                { 5, 73367 }, -- Fierce Ember Topaz
                { 6, 73372 }, -- Fine Ember Topaz
                { 7, 73364 }, -- Inscribed Ember Topaz
                { 8, 73374 }, -- Keen Ember Topaz
                { 16, 73361 }, -- Polished Ember Topaz
                { 17, 73366 }, -- Potent Ember Topaz
                { 18, 73369 }, -- Reckless Ember Topaz
                { 19, 73370 }, -- Skillful Ember Topaz
                { 20, 73362 }, -- Resolute Ember Topaz
                { 21, 95756 }, -- Resplendent Ember Topaz
                { 22, 95754 }, -- Willful Ember Topaz
                { 23, 95755 }, -- Lucent Ember Topaz
                -- Uncommon
                { 101, 73268 },	-- Adept Hessonite
                { 102, 73270 },	-- Artful Hessonite
                { 103, 73262 },	-- Deadly Hessonite
                { 104, 73265 },	-- Deft Hessonite
                { 105, 73264 },	-- Fierce Hessonite
                { 106, 73269 },	-- Fine Hessonite
                { 107, 73260 }, -- Inscribed Hessonite
                { 108, 73271 }, -- Keen Hessonite
                { 109, 73258 }, -- Polished Hessonite
                { 110, 73263 }, -- Potent Hessonite
                { 111, 73266 }, -- Reckless Hessonite
                { 112, 73259 }, -- Resolute Hessonite
                { 113, 73267 }, -- Skillful Hessonite
                -- Perfect Uncommon
                { 116, "i52142" },	-- Perfect Adept Hessonite
                { 117, "i52140" },	-- Perfect Artful Hessonite
                { 118, "i52148" },	-- Perfect Deadly Hessonite
                { 119, "i52145" },	-- Perfect Deft Hessonite
                { 120, "i52146" },	-- Perfect Fierce Hessonite
                { 121, "i52141" },	-- Perfect Fine Hessonite
                { 122, "i52149" }, -- Perfect Inscribed Hessonite
                { 123, "i52139" }, -- Perfect Keen Hessonite
                { 124, "i52151" }, -- Perfect Polished Hessonite
                { 125, "i52147" }, -- Perfect Potent Hessonite
                { 126, "i52144" }, -- Perfect Reckless Hessonite
                { 127, "i52140" }, -- Perfect Resolute Hessonite
                { 128, "i52143" }, -- Perfect Skillful Hessonite
                -- Epic (move to top after P2)
                { 201, 101773 }, -- Adept Lava Coral
                { 202, 101775 }, -- Artful Lava Coral
                { 203, 101761 }, -- Deadly Lava Coral
                { 204, 101769 }, -- Deft Lava Coral
                { 205, 101772 }, -- Fierce Lava Coral
                { 206, 101776 }, -- Fine Lava Coral
                { 207, 101764 }, -- Inscribed Lava Coral
                { 208, 101774 }, -- Keen Lava Coral
                { 209, 101765 }, -- Polished Lava Coral
                { 210, 101763 }, -- Potent Lava Coral
                { 211, 101771 }, -- Reckless Lava Coral
                { 216, 101777 }, -- Skillful Lava Coral
                { 217, 101766 }, -- Resolute Lava Coral
                { 218, 101782 }, -- Resplendent Lava Coral!
                { 219, 101780 }, -- Willful Lava Coral
                { 220, 101778 }, -- Lucent Lava Coral
                { 221, 101768 }, -- Champion's Lava Coral
                { 222, 101762 }, -- Crafty Lava Coral
                { 223, 101781 }, -- Splendid Lava Coral
                { 224, 101767 }, -- Stalwart Lava Coral
                { 225, 101779 }, -- Tenuous Lava Coral
                { 226, 101770 }, -- Wicked Lava Coral
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Green"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73380 },	-- Forceful Dream Emerald
                { 2, 73377 },	-- Jagged Dream Emerald
                { 3, 73381 },	-- Lightning Dream Emerald
                { 4, 73376 },	-- Nimble Dream Emerald
                { 5, 73378 },	-- Piercing Dream Emerald
                { 6, 73382 },	-- Puissant Dream Emerald
                { 16, 73375 },	-- Regal Dream Emerald
                { 17, 73384 },	-- Sensei's Dream Emerald
                { 18, 73379 },	-- Steady Dream Emerald
                { 19, 73383 },	-- Zen Dream Emerald
                { 20, 96226 },	-- Vivid Dream Emerald
                -- Uncommon
                { 101, 73277 },	-- Forceful Jasper
                { 102, 73274 },	-- Jagged Jasper
                { 103, 73278 },	-- Lightning Jasper
                { 104, 73273 },	-- Nimble Jasper
                { 105, 73275 },	-- Piercing Jasper
                { 106, 73279 },	-- Puissant Jasper
                { 107, 73272 },	-- Regal Jasper
                { 108, 73281 },	-- Sensei's Jasper
                { 109, 73276 },	-- Steady Jasper
                { 110, 73280 },	-- Zen Jasper
                -- Perfect Uncommon
                { 116, "i52133" },	-- Perfect Forceful Jasper
                { 117, "i52136" },	-- Perfect Jagged Jasper
                { 118, "i52132" },	-- Perfect Lightning Jasper
                { 119, "i52137" },	-- Perfect Nimble Jasper
                { 120, "i52135" },	-- Perfect Piercing Jasper
                { 121, "i52131" },	-- Perfect Puissant Jasper
                { 122, "i52138" },	-- Perfect Regal Jasper
                { 123, "i52129" },	-- Perfect Sensei's Jasper
                { 124, "i52134" },	-- Perfect Steady Jasper
                { 125, "i52130" },	-- Perfect Zen Jasper
                -- Epic (move to top after P2)
                { 201, 101757 }, -- Forceful Elven Peridot
                { 202, 101755 }, -- Jagged Elven Peridot
                { 203, 101745 }, -- Lightning Elven Peridot
                { 204, 101758 }, -- Nimble Elven Peridot
                { 205, 101744 }, -- Piercing Elven Peridot
                { 206, 101759 }, -- Puissant Elven Peridot
                { 207, 101756 }, -- Regal Elven Peridot
                { 208, 101746 }, -- Sensei's Elven Peridot
                { 209, 101760 }, -- Steady Elven Peridot
                { 216, 101748 }, -- Zen Elven Peridot
                { 217, 101750 }, -- Vivid Elven Peridot
                { 218, 101749 }, -- Balanced Elven Peridot
                { 219, 101754 }, -- Energized Elven Peridot
                { 220, 101747 }, -- Infused Elven Peridot
                { 221, 101743 }, -- Misty Elven Peridot
                { 222, 101752 }, -- Radiant Elven Peridot
                { 223, 101753 }, -- Shattered Elven Peridot
                { 224, 101751 }, -- Turbid Elven Peridot
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Purple"]),
            [NORMAL_DIFF] = {
                -- Rare
                { 1, 73360 }, -- Accurate Demonseye
                { 2, 73352 }, -- Defender's Demonseye
                { 3, 73356 }, -- Etched Demonseye
                { 4, 73357 }, -- Glinting Demonseye
                { 5, 73354 }, -- Guardian's Demonseye
                { 6, 73355 }, -- Purified Demonseye
                { 16, 73358 }, -- Retaliating Demonseye
                { 17, 73351 }, -- Shifting Demonseye
                { 18, 73350 }, -- Souvereign Demonseye
                { 19, 73353 }, -- Timeless Demonseye
                { 20, 73359 }, -- Veiled Demonseye
                -- Uncommon
                { 101, 73250 }, -- Accurate Nightstone
                { 102, 73242 }, -- Defender's Nightstone
                { 103, 73246 }, -- Etched Nightstone
                { 104, 73247 }, -- Glinting Nightstone
                { 105, 73244 }, -- Guardian's Nightstone
                { 106, 73245 }, -- Purified Nightstone
                { 107, 73248 }, -- Retaliating Nightstone
                { 108, 73241 }, -- Shifting Nightstone
                { 109, 73240 }, -- Souvereign Nightstone
                { 110, 73243 }, -- Timeless Nightstone
                { 111, 73249 }, -- Veiled Nightstone
                -- Perfect Uncommon
                { 116, "i52152" }, -- Perfect Accurate Nightstone
                { 117, "i52160" }, -- Perfect Defender's Nightstone
                { 118, "i52156" }, -- Perfect Etched Nightstone
                { 119, "i52155" }, -- Perfect Glinting Nightstone
                { 120, "i52158" }, -- Perfect Guardian's Nightstone
                { 121, "i52157" }, -- Perfect Purified Nightstone
                { 122, "i52154" }, -- Perfect Retaliating Nightstone
                { 123, "i52161" }, -- Perfect Shifting Nightstone
                { 124, "i52162" }, -- Perfect Souvereign Nightstone
                { 125, "i52159" }, -- Perfect Timeless Nightstone
                { 126, "i52153" }, -- Perfect Veiled Nightstone
                -- Epic (move to top after P2)
                { 201, 101784 }, -- Accurate Shadow Spinel
                { 202, 101793 }, -- Defender's Shadow Spinel
                { 203, 101787 }, -- Etched Shadow Spinel
                { 204, 101783 }, -- Glinting Shadow Spinel
                { 205, 101791 }, -- Guardian's Shadow Spinel
                { 206, 101789 }, -- Purified Shadow Spinel
                { 216, 101786 }, -- Retaliating Shadow Spinel
                { 217, 101790 }, -- Shifting Shadow Spinel
                { 218, 101794 }, -- Sovereign Shadow Spinel
                { 219, 101792 }, -- Timeless Shadow Spinel
                { 220, 101785 }, -- Veiled Shadow Spinel
                { 221, 101788 }, -- Mysterious Shadow Spinel
            }
        },
        {
            name = AL["Raw Gems"],
            TableType = NORMAL_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 52303 }, --  Shadowspirit Diamond
                { 3, 71809 }, --  Shadow Spinel
                { 4, 52194 }, --  Demonseye
                { 5, 52180 }, --  Nightstone
                { 7, 71810 }, --  Elven Peridot
                { 8, 52192 }, --  Dream Emerald
                { 9, 52182 }, --  Jasper
                { 11, 71808 }, --  Lava Coral
                { 12, 52193 }, --  Ember Topaz
                { 13, 52181 }, --  Hessonite
                { 16, "i52196" }, -- Chimera's Eye
                { 18, 71807 }, --  Deepholm Iolite
                { 19, 52191 }, -- Ocean Sapphire
                { 20, 52178 }, --  Zephyrite
                { 22, 71805 }, --  Queen's Garnet
                { 23, 52190 }, --  Inferno Ruby
                { 24, 52177 }, --  Carnelian
                { 26, 71806 }, --  Lightstone
                { 27, 52195 }, --  Amberjewel
                { 28, 52179 }, --  Alicite
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 73478 }, -- Fire Prism
                { 3, 73621 }, -- The Perforator
                { 4, 73620 }, -- Carnelian Spikes
                { 6, 73622 }, -- Stardust
                { 16, 73623 }, -- Rhinestone Sunglasses
                { 18, 73627 }, -- Jeweler's Amber Monocle
                { 19, 73626 }, -- Jeweler's Sapphire Monocle
                { 20, 73625 }, -- Jeweler's Ruby Monocle
            }
        },
    }
}

data["LeatherworkingCata"] = {
    name = ALIL["Leatherworking"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.LEATHERWORKING_LINK,
    items = {
        { -- Cloak
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 78475 },	-- Razor-Edged Cloak
                { 2, 78476 },	-- Twilight Dragonscale Cloak
                { 3, 99536 },   -- Vicious Fur Cloak
                { 4, 99535 },	-- Vicious Hide Cloak
                { 5, 78439 },	-- Cloak of War
                { 6, 78438 },	-- Cloak of Beasts
                { 7, 78405 },	-- Hardened Scale Cloak
                { 8, 78380 },	-- Savage Cloak
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [LEATHER_DIFF] = {
                { 1, 78480 },	-- Bloodied Wyrmhide Helm
                { 2, 78469 },	-- Bloodied Leather Helm
                { 3, 78424 },	-- Darkbrand Helm
            },
            [MAIL_DIFF] = {
                { 1, 78484 },	-- Bloodied Scale Helm
                { 2, 78474 },	-- Bloodied Dragonscale Helm
                { 3, 78432 },	-- Tsunami Helm
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [LEATHER_DIFF] = {
                { 1, 78464 },	-- Bloodied Wyrmhide Shoulders
                { 2, 78455 },	-- Bloodied Leather Shoulders
                { 3, 78411 },	-- Darkbrand Shoulders
            },
            [MAIL_DIFF] = {
                { 1, 78470 },	-- Bloodied Scale Shoulders
                { 2, 78451 },	-- Bloodied Dragonscale Shoulders
                { 3, 78415 },	-- Tsunami Shoulders
            },
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [LEATHER_DIFF] = {
                { 1, 78487 },	-- Chestguard of Nature's Fury
                { 2, 78488 },	-- Assassin's Chestplate
                { 3, 78481 },	-- Bloodied Leather Chest
                { 4, 78467 },	-- Bloodied Wyrmhide Chest
                { 5, 78428 },	-- Darkbrand Chestguard
            },
            [MAIL_DIFF] = {
                { 1, 78489 },	-- Twilight Scale Chestguard
                { 2, 78490 },	-- Dragonkiller Tunic
                { 3, 78486 },	-- Bloodied Dragonscale Chest
                { 4, 78483 },	-- Bloodied Scale Chest
                { 5, 78423 },	-- Tsunami Chestguard
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [LEATHER_DIFF] = {
                { 1, 101940 },	-- Bladeshadow Wristguards
                { 2, 101937 },	-- Bracers of Flowing Serenity
                { 3, 78444 },	-- Bloodied Wyrmhide Bracers
                { 4, 78446 },	-- Bloodied Leather Bracers
                { 5, 78398 },	-- Darkbrand Bracers
            },
            [MAIL_DIFF] = {
                { 1, 101939 },	-- Thundering Deathscale Wristguards
                { 2, 101941 },	-- Bracers of the Hunter-Killer
                { 3, 78448 },	-- Bloodied Scale Bracers
                { 4, 78450 },	-- Bloodied Dragonscale Bracers
                { 5, 78388 },	-- Tsunami Bracers
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [LEATHER_DIFF] = {
                { 1, 99446 },	-- Clutches of Evil
                { 2, 99447 },	-- Heavenly Gloves of the Moon
                { 3, 78452 },	-- Bloodied Wyrmhide Gloves
                { 4, 78447 },	-- Bloodied Leather Gloves
                { 5, 78399 },	-- Darkbrand Gloves
            },
            [MAIL_DIFF] = {
                { 1, 99445 },	-- Gloves of Unforgiving Flame
                { 2, 99443 },	-- Dragonfire Gloves
                { 3, 78459 },	-- Bloodied Dragonscale Gloves
                { 4, 78449 },	-- Bloodied Scale Gloves
                { 5, 78406 },	-- Tsunami Gloves
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [LEATHER_DIFF] = {
                { 1, 78460 },	-- Lightning Lash
                { 2, 78461 },	-- Belt of Nefarious Whispers
                { 3, 78468 },	-- Bloodied Leather Belt
                { 4, 78445 },	-- Bloodied Wyrmhide Belt
                { 5, 78416 },	-- Darkbrand Belt
            },
            [MAIL_DIFF] = {
                { 1, 78462 },	-- Stormleather Sash
                { 2, 78463 },	-- Corded Viper Belt
                { 3, 78473 },	-- Bloodied Dragonscale Belt
                { 4, 78457 },	-- Bloodied Scale Belt
                { 5, 78396 },	-- Tsunami Belt
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [LEATHER_DIFF] = {
                { 1, 101933 },	-- Leggings of Nature's Champion
                { 2, 101935 },	-- Bladeshadow Leggings
                { 3, 78482 },	-- Bloodied Leather Legs
                { 4, 78479 },	-- Bloodied Wyrmhide Legs
                { 5, 78433 },	-- Darkbrand Leggings
            },
            [MAIL_DIFF] = {
                { 1, 101936 },	-- Rended Earth Leggings
                { 2, 101934 },	-- Deathscale Leggings
                { 3, 78485 },	-- Bloodied Dragonscale Legs
                { 4, 78471 },	-- Bloodied Scale Legs
                { 5, 78427 },	-- Tsunami Leggings
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [LEATHER_DIFF] = {
                { 1, 99457 },	-- Treads of the Craft
                { 2, 99458 },	-- Ethereal Footfalls
                { 3, 78454 },	-- Bloodied Leather Boots
                { 4, 78453 },	-- Bloodied Wyrmhide Boots
                { 5, 78407 },	-- Darkbrand Boots
            },
            [MAIL_DIFF] = {
                { 1, 99455 },	-- Earthen Scale Sabatons
                { 2, 99456 },	-- Footwraps of Quenched Fire
                { 3, 78456 },	-- Bloodied Scale Boots
                { 4, 78458 },	-- Bloodied Dragonscale Boots
                { 5, 78410 },	-- Tsunami Boots
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 85068 },	-- Charscale Leg Reinforcements
                { 2, 78478 },	-- Charscale Leg Armor
                { 3, 78420 },	-- Twilight Leg Armor
                { 5, 85067 },	-- Dragonbone Leg Reinforcements
                { 6, 78477 },	-- Dragonscale Leg Armor
                { 7, 78419 },	-- Scorched Leg Armor
                { 9, 101600 },	-- Drakehide Leg Reinforcements
                { 10, 101599 },	-- Drakehide Leg Armor
                { 16, 85007 },	-- Draconic Embossment - Stamina
                { 17, 85008 },	-- Draconic Embossment - Agility
                { 18, 85009 },	-- Draconic Embossment - Strength
                { 19, 85010 },	-- Draconic Embossment - Intellect
                { 21, 78437 },	-- Heavy Savage Armor Kit
                { 22, 78379 },	-- Savage Armor Kit
            },
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 100583 },	-- Royal Scribe's Satchel
                { 3, 100586 },	-- Triple-Reinforced Mining Bag
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 78436 },	-- Heavy Savage Leather
                { 2, 84950 },	-- Savage Leather
            },
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 949 }, -- The Dark Brand
                { 2, 950 }, -- The Big Wave
            },
        }
    }
}

data["TailoringCata"] = {
    name = ALIL["Tailoring"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.TAILORING_LINK,
    items = {
        { -- Cloak
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 99537 },	-- Vicious Embersilk Cape
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [NORMAL_DIFF] = {
                { 1, 75304 },	-- Fireweave Cowl
                { 2, 75306 },	-- Embersilk Cowl
                { 3, 75266 },	-- Spiritmend Cowl
                { 4, 75256 },	-- Deathsilk Cowl
                { 16, 75289 },	-- High Society Top Hat
            }
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [NORMAL_DIFF] = {
                { 1, 75292 },	-- Fireweave Shoulders
                { 2, 75291 },	-- Embersilk Shoulders
                { 3, 75260 },	-- Spiritmend Shoulders
                { 4, 75251 },	-- Deathsilk Shoulders
            }
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [NORMAL_DIFF] = {
                { 1, 75305 },	-- Embersilk Robe
                { 2, 75303 },	-- Fireweave Robe
                { 3, 75257 },	-- Deathsilk Robe
                { 4, 75267 },	-- Spiritmend Robe
                { 16, 75288 },	-- Black Embersilk Gown
                { 18, 102171 },	-- Black Silk Vest
            }
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [NORMAL_DIFF] = {
                { 1, 101922 },	-- Dreamwraps of the Light
                { 2, 101923 },	-- Bracers of Unconquered Power
                { 3, 75270 },	-- Embersilk Bracers
                { 4, 75290 },	-- Fireweave Bracers
                { 5, 75259 },	-- Spiritmend Bracers
                { 6, 75249 },	-- Deathsilk Bracers
            }
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [NORMAL_DIFF] = {
                { 1, 99448 },	-- Grips of Altered Reality
                { 2, 99449 },	-- Don Tayo's Inferno Mittens
                { 3, 75296 },	-- Fireweave Gloves
                { 4, 75295 },	-- Embersilk Gloves
                { 5, 75253 },	-- Deathsilk Gloves
                { 6, 75262 },	-- Spiritmend Gloves
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [NORMAL_DIFF] = {
                { 1, 75298 },	-- Belt of the Depths
                { 2, 75299 },	-- Dreamless Belt
                { 3, 75269 },	-- Fireweave Belt
                { 4, 75293 },	-- Embersilk Belt
                { 5, 75258 },	-- Spiritmend Belt
                { 6, 75248 },	-- Deathsilk Belt
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [NORMAL_DIFF] = {
                { 1, 101920 },	-- World Mender's Pants
                { 2, 101921 },	-- Lavaquake Legwraps
                { 3, 75301 },	-- Flame-Ascended Pantaloons
                { 4, 75300 },	-- Breeches of Mended Nightmares
                { 5, 75302 },	-- Fireweave Pants
                { 6, 75307 },	-- Embersilk Pants
                { 7, 75263 },	-- Spiritmend Leggings
                { 8, 75254 },	-- Deathsilk Leggings
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [NORMAL_DIFF] = {
                { 1, 99459 },	-- Endless Dream Walkers
                { 2, 99460 },	-- Boots of the Black Flame
                { 3, 75297 },	-- Embersilk Boots
                { 4, 75294 },	-- Fireweave Boots
                { 5, 75261 },	-- Spiritmend Boots
                { 6, 75252 },	-- Deathsilk Boots
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 75154 },	-- Master's Spellthread
                { 2, 75309 },	-- Powerful Enchanted Spellthread
                { 3, 75250 },	-- Enchanted Spellthread
                { 5, 75178 },	-- Swordguard Embroidery
                { 6, 75172 },	-- Lightweave Embroidery
                { 7, 75175 },	-- Darkglow Embroidery
                { 16, 75155 },	-- Sanctified Spellthread
                { 17, 75310 },	-- Powerful Ghostly Spellthread
                { 18, 75255 },	-- Ghostly Spellthread
            },
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 75308 },	-- Illusionary Bag
                { 2, 75264 },	-- Embersilk Bag
                { 16, 100585 },	-- Luxurious Silk Gem Bag
                { 18, 75268 },	-- Hyjal Expedition Bag
                { 20, 75265 },	-- Otherworldly Bag
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 75247 },	-- Embersilk Net
                { 3, 74964 },	-- Bolt of Embersilk Cloth
                { 16, 94743 },	-- Dream of Destruction
                { 17, 75141 },	-- Dream of Skywall
                { 18, 75145 },	-- Dream of Ragnaros
                { 19, 75142 },	-- Dream of Deepholm
                { 20, 75144 },	-- Dream of Hyjal
                { 21, 75146 },	-- Dream of Azshara
            },
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 944 }, -- Spiritmender
                { 2, 945 }, -- Deathspeaker
            },
        }
    }
}

data["MiningCata"] = {
    name = ALIL["Mining"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.MINING_LINK,
    items = {
        {
            name = AL["Smelting"],
            [NORMAL_DIFF] = {
                { 1, 74529 }, -- Smelt Pyrite
                { 2, 74537 }, -- Smelt Hardened Elementium
                { 3, 74530 }, -- Smelt Elementium
                { 4, 84038 }, -- Smelt Obsidium
            }
        },
    }
}

data["SkinningCata"] = {
    name = ALIL["Skinning"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.SKINNING_LINK,
    items = {
        {
            name = AL["Illustrious Grand Master"],
            [NORMAL_DIFF] = {
                { 1, 52976 }, -- Savage Leather
                { 2, 52977 }, -- Savage Leather Scraps
                { 16, 52982 }, -- Deepsea Scale
                { 17, 52979 }, -- Blackened Dragonscale
                { 19, 52980 }, -- Pristine Hide
            }
        },
    }
}

data["HerbalismCata"] = {
    name = ALIL["Herbalism"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.HERBALISM_LINK,
    items = {
        {
            name = AL["Illustrious Grand Master"],
            [NORMAL_DIFF] = {
                { 1,  52987 }, -- Twilight Jasmine
                { 2,  52988 }, -- Whiptail
                { 3,  52986 }, -- Heartblossom
                { 4,  52984 }, -- Stormvine
                { 5,  52985 }, -- Azshara's Veil
                { 6,  52983 }, -- Cinderbloom
                { 16,  52989 }, -- Deathspore Pod
                { 18,  52329 }, -- Volatile Life
            }
        },
    }
}

data["ArchaeologyCata"] = {
    name = ALIL["Archaeology"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ARCHAEOLOGY_LINK,
    items = {
        {
            name = AL["Endgame Gear"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Troll"] },
                { 2, 90608 }, -- Zin'rokh, Destroyer of Worlds
                { 4, "INV_sword_04", nil, ALIL["Night Elf"] },
                { 5, 91757 }, -- Tyrande's Favorite Doll
                { 7, "INV_sword_04", nil, ALIL["Tol'vir"] },
                { 8, 92163 }, -- Scimitar of the Sirocco
                { 9, 92139 }, -- Staff of Ammunae
                { 10, 92168 }, -- Ring of the Boy Emperor
                { 16, "INV_sword_04", nil, ALIL["Dwarf"] },
                { 17, 91227 }, -- Staff of Sorcerer-Thane Thaurissan
                { 19, "INV_sword_04", nil, ALIL["Fossil"] },
                { 20, 98533 }, -- Extinct Turtle Shell
            },
        },
        {
            name = AL["Leveling Gear"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Vrykul"] },
                { 2, 90997 }, -- Nifflevar Bearded Axe
                { 4, "INV_sword_04", nil, ALIL["Orc"] },
                { 5, 90843 }, -- Headdress of the First Shaman
                { 16, "INV_sword_04", nil, ALIL["Night Elf"] },
                { 17, 90616 }, -- Queen Azshara's Dressing Gown
            },
        },
        {
            name = AL["Toys"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Night Elf"] },
                { 2, 91761 }, -- Bones of Transformation
                { 3, 91773 }, -- Wisp Amulet
                { 4, 90464 }, -- Highborne Soul Mirror
                { 5, 90614 }, -- Kaldorei Wind Chimes
                { 6, 90493 }, -- Druid and Priest Statue Set
                { 8, "INV_sword_04", nil, ALIL["Troll"] },
                { 9, 98556 }, -- Haunted War Drum
                { 11, "INV_sword_04", nil, ALIL["Vrykul"] },
                { 12, 98569 }, -- Vrykul Drinking Horn
                { 14, "INV_sword_04", nil, ALIL["Fossil"] },
                { 15, 98560 }, -- Ancient Amber
                { 16, "INV_sword_04", nil, ALIL["Tol'vir"] },
                { 17, 92145 }, -- Pendant of the Scarab Storm
                { 19, "INV_sword_04", nil, ALIL["Nerubian"] },
                { 20, 91214 }, -- Blessing of the Old God
                { 21, 91215 }, -- Puzzle Box of Yogg-Saron
                { 23, "INV_sword_04", nil, ALIL["Draenei"] },
                { 24, 90984 }, -- The Last Relic of Argus
                { 25, 90983 }, -- Arrival of the Naaru
                { 27, "INV_sword_04", nil, ALIL["Dwarf"] },
                { 28, 91226 }, -- The Innkeeper's Daughter
                { 29, 90553 }, -- Chalice of the Mountain Kings
            },
        },
        {
            name = AL["Mounts"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Tol'vir"] },
                { 2, 92148 }, -- Scepter of Azj'Aqir
                { 16, "INV_sword_04", nil, ALIL["Fossil"] },
                { 17, 90619 }, -- Fossilized Raptor
            },
        },
        {
            name = AL["Pets"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Tol'vir"] },
                { 2, 92137 }, -- Crawling Claw
                { 4, "INV_sword_04", nil, ALIL["Troll"] },
                { 5, 98588 }, -- Voodoo Figurine
                { 16, "INV_sword_04", nil, ALIL["Dwarf"] },
                { 17, 90521 }, -- Clockwork Gnome
                { 19, "INV_sword_04", nil, ALIL["Fossil"] },
                { 20, 98582 }, -- Pterrordax Hatchling
                { 21, 89693 }, -- Fossilized Hatchling
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["Tol'vir"] },
                { 2, 91790 }, -- Canopic Jar
            }
        },
    }
}

data["CookingCata"] = {
    name = ALIL["Cooking"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.COOKING_LINK,
    items = {
        {
            name = ALIL["Feast"],
            [NORMAL_DIFF] = {
                { 1, 88036 }, -- Seafood Magnifique Feast
                { 2, 88011 }, -- Broiled Dragon Feast
            },
        },
        {
            name = AL["Useful Stat"],
            [NORMAL_DIFF] = {
                { 1, 88019 }, -- Fortune Cookie
            },
        },
        {
            name = ALIL["Strength"],
            [NORMAL_DIFF] = {
                { 1, 88005 }, -- Beer-Basted Crocolisk
                { 2, 88021 }, -- Hearty Seafood Soup
            },
        },
        {
            name = ALIL["Agility"],
            [NORMAL_DIFF] = {
                { 1, 88042 }, -- Skewered Eel
                { 2, 88046 }, -- Tender Baked Turtle
            },
        },
        {
            name = ALIL["Intellect"],
            [NORMAL_DIFF] = {
                { 1, 88039 }, -- Severed Sagefish Head
                { 2, 88033 }, -- Pickled Guppy
            },
        },
        {
            name = ALIL["Spirit"],
            [NORMAL_DIFF] = {
                { 1, 88016 }, -- Delicious Sagefish Tail
                { 2, 88047 }, -- Whitecrest Gumbo
            },
        },
        {
            name = ALIL["Mastery"],
            [NORMAL_DIFF] = {
                { 1, 88025 }, -- Lavascale Minestrone
                { 2, 88035 }, -- Salted Eye
            },
        },
        {
            name = ALIL["Critical Strike"],
            [NORMAL_DIFF] = {
                { 1, 88003 }, -- Baked Rockfish
                { 2, 88028 }, -- Lightly Fried Lurker
            },
        },
        {
            name = ALIL["Haste"],
            [NORMAL_DIFF] = {
                { 1, 88004 }, -- Basilisk Liverdog
                { 2, 88012 }, -- Broiled Mountain Trout
            },
        },
        {
            name = ALIL["Hit"],
            [NORMAL_DIFF] = {
                { 1, 88020 }, -- Grilled Dragon
                { 2, 88037 }, -- Seasoned Crab
            },
        },
        {
            name = ALIL["Expertise"],
            [NORMAL_DIFF] = {
                { 1, 88014 }, -- Crocolisk Au Gratin
                { 2, 88024 }, -- Lavascale Fillet
            },
        },
        {
            name = ALIL["Dodge"],
            [NORMAL_DIFF] = {
                { 1, 88031 }, -- Mushroom Sauce Mudfish
                { 2, 88030 }, -- Lurker Lunch
            },
        },
        {
            name = ALIL["Parry"],
            [NORMAL_DIFF] = {
                { 1, 88034 }, -- Blackbelly Sushi
            },
        },
        {
            name = ALIL["Food"],
            [NORMAL_DIFF] = {
                { 1, 96133 }, -- Scalding Murglesnout
                { 2, 88018 }, -- Fish Fry
                { 3, 88006 }, -- Blackened Surprise
                { 5, 93741 }, -- Venison Jerky
                { 16, 88044 }, -- South Island Iced Tea
                { 17, 88045 }, -- Starfire Espresso
            },
        },
        {
            name = AL["Special"],
            [NORMAL_DIFF] = {
                { 1, 88013 }, -- Chocolate Cookie
                { 3, 88017 }, -- Feathered Lure
                { 16, 88022 }, -- Highland Spirits
                { 17, 88015 }, -- Darkbrew Lager
            },
        },
    }
}

data["FirstAidCata"] = {
    name = ALIL["First Aid"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.FIRSTAID_LINK,
    items = {
        {
            name = ALIL["First Aid"],
            [NORMAL_DIFF] = {
                { 1, 74558 },	-- Field Bandage: Dense Embersilk
                { 2, 88893 },	-- Dense Embersilk Bandage
                { 3, 74557 },	-- Heavy Embersilk Bandage
                { 4, 74556 },	-- Embersilk Bandage
            }
        },
    }
}

data["FishingCata"] = {
    name = ALIL["Fishing"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.FISHING_LINK,
    items = {
        {
            name = AL["Fish"],
            [NORMAL_DIFF] = {
                { 1, 53071 }, -- Algaefin Rockfish
                { 2, 53066 }, -- Blackbelly Mudfish
                { 3, 53072 }, -- Deepsea Sagefish
                { 4, 53070 }, -- Fathom Eel
                { 5, 53064 }, -- Highland Guppy
                { 6, 53068 }, -- Lavascale Catfish
                { 7, 53063 }, -- Mountain Trout
                { 8, 53067 }, -- Striped Lurker
                { 9, 53065 }, -- Albino Cavefish
            }
        },
    }
}
