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
if AtlasLoot:GameVersion_LT(AtlasLoot.BC_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 2, AtlasLoot.BC_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH") -- just for sorting here :)
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH") -- just for sorting here :)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID25_CONTENT = data:AddContentType(AL["25 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_BurningCrusade"

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_TEMPEST_KEEP = NAME_COLOR..AL["TK"]..":|r %s" -- Tempest Keep
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time
local NAME_AUCHINDOUN = NAME_COLOR..AL["Auch"]..":|r %s" -- Auchindoun
local NAME_COILFANG_RESERVOIR = NAME_COLOR..AL["CR"]..":|r %s"-- Coilfang Reservoir
local NAME_HELLFIRE_CITADEL = NAME_COLOR..AL["HC"]..":|r %s"-- Hellfire Citadel
local NAME_KARA_QUARTERS = NAME_COLOR_BOSS..AL["Servant Quarters"]..":|r %s" -- Servant Quarters
local NAME_KARA_OPERA = NAME_COLOR_BOSS..AL["The Opera Event"]..":|r %s" -- The Opera Even


local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
        { 1, "INV_Box_01", nil, AL["Normal"], nil },
		{ 2, 27991 }, -- Shadow Labyrinth Key
		{ 3, 28395 }, -- Shattered Halls Key
		{ 4, 31084 }, -- Key to the Arcatraz
		{ 6, "INV_Box_01", nil, AL["Heroic"], nil },
		{ 7, 30637, [ATLASLOOT_IT_ALLIANCE] = 30622 }, -- Flamewrought Key
		{ 8, 30623 }, -- Reservoir Key
		{ 9, 30633 }, -- Auchenai Key
		{ 10, 30635 }, -- Key of Time
		{ 11, 30634 }, -- Warpforged Key
		{ 16, "INV_Box_01", nil, AL["Raid"], nil },
		{ 17, 32649 }, -- Medallion of Karabor
		{ 18, 31704 }, -- The Tempest Key
		{ 19, 24490 }, -- The Master's Key
		{ 21, "INV_Box_01", nil, AL["Misc"], nil },
		{ 22, 32092 }, -- The Eye of Haramad
		{ 23, 24140 }, -- Blackened Urn
		{ 24, 32449 }, -- Essence-Infused Moonstone
    }
}

local T4_SET = {
	name = format(AL["Tier %s Sets"], "4"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,    645 }, -- Warlock
		{ 3,    663 }, -- Priest / Heal
        { 4,    664 }, -- Priest / Shadow
        { 6,    621 }, -- Rogue
		{ 8,    651 }, -- Hunter
		{ 10,    654 }, -- Warrior / Prot
        { 11,    655 }, -- Warrior / DD
		{ 16,   648 }, -- Mage
		{ 18,   638 }, -- Druid / Heal
        { 19,   639 }, -- Druid / Owl
        { 20,   640 }, -- Druid / Feral
        { 22,   631 }, -- Shaman / Heal
        { 23,   632 }, -- Shaman / Ele
        { 24,   633 }, -- Shaman / Enh
		{ 26,   624 }, -- Paladin / Heal
        { 27,   625 }, -- Paladin / Prot
        { 28,   626 }, -- Paladin / DD
	},
}

local T5_SET = {
	name = format(AL["Tier %s Sets"], "5"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,    646 }, -- Warlock
		{ 3,    665 }, -- Priest / Heal
        { 4,    666 }, -- Priest / Shadow
        { 6,    622 }, -- Rogue
		{ 8,    652 }, -- Hunter
		{ 10,    656 }, -- Warrior / Prot
        { 11,    657 }, -- Warrior / DD
		{ 16,   649 }, -- Mage
		{ 18,   642 }, -- Druid / Heal
        { 19,   643 }, -- Druid / Owl
        { 20,   641 }, -- Druid / Feral
        { 22,   634 }, -- Shaman / Heal
        { 23,   635 }, -- Shaman / Ele
        { 24,   636 }, -- Shaman / Enh
		{ 26,   627 }, -- Paladin / Heal
        { 27,   628 }, -- Paladin / Prot
        { 28,   629 }, -- Paladin / DD
	},
}

local T6_SET = {
	name = format(AL["Tier %s Sets"], "6"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,    670 }, -- Warlock
		{ 3,    675 }, -- Priest / Heal
        { 4,    674 }, -- Priest / Shadow
        { 6,    668 }, -- Rogue
		{ 8,    669 }, -- Hunter
		{ 10,    673 }, -- Warrior / Prot
        { 11,    672 }, -- Warrior / DD
		{ 16,   671 }, -- Mage
		{ 18,   678 }, -- Druid / Heal
        { 19,   677 }, -- Druid / Owl
        { 20,   676 }, -- Druid / Feral
        { 22,   683 }, -- Shaman / Heal
        { 23,   684 }, -- Shaman / Ele
        { 24,   682 }, -- Shaman / Enh
		{ 26,   681 }, -- Paladin / Heal
        { 27,   679 }, -- Paladin / Prot
        { 28,   680 }, -- Paladin / DD
	},
}


data["HellfireRamparts"] = {
    nameFormat = NAME_HELLFIRE_CITADEL,
	MapID = 3562,
	InstanceID = 543,
    AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_HCHellfireRamparts",
	AtlasMapFile = {"CL_HCHellfireRamparts", "HellfireCitadelEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {57, 59, 67},
	items = {
        { -- HCRampWatchkeeper
            name = AL["Watchkeeper Gargolmar"],
            npcID = {17306,18436},
            Level = 62,
            DisplayIDs = {{18236}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 24024 }, -- Pauldrons of Arcane Rage
                { 2, 24023 }, -- Bracers of Finesse
                { 3, 24022 }, -- Scale Leggings of the Skirmisher
                { 4, 24021 }, -- Light-Touched Breastplate
                { 5, 24020 }, -- Shadowrend Longblade
                { 7, 23881 }, -- Gargolmar's Hand
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30593 }, -- Iridescent Fire Opal
                { 3, 30594 }, -- Effulgent Chrysoprase
                { 4, 30592 }, -- Steady Chrysoprase
                { 6, 27448 }, -- Cloak of the Everliving
                { 7, 27451 }, -- Boots of the Darkwalker
                { 8, 27450 }, -- Wild Stalker Boots
                { 9, 27447 }, -- Bracers of Just Rewards
                { 10, 27449 }, -- Blood Knight Defender
                { 12, 23881 }, -- Gargolmar's Hand
            }
        },
        { -- HCRampOmor
            name = AL["Omor the Unscarred"],
            npcID = {17308,18433},
            Level = 62,
            DisplayIDs = {{18237}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 24090 }, -- Bloodstained Ravager Gauntlets
                { 2, 24091 }, -- Tenacious Defender
                { 3, 24073 }, -- Garrote-String Necklace
                { 4, 24096 }, -- Heartblood Prayer Beads
                { 5, 24094 }, -- Heart Fire Warhammer
                { 6, 24069 }, -- Crystalfire Staff
                { 8, 23886 }, -- Omor's Hoof
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 3, 27466 }, -- Headdress of Alacrity
                { 4, 27462 }, -- Crimson Bracers of Gloom
                { 5, 27467 }, -- Silent-Strider Kneeboots
                { 6, 27478 }, -- Girdle of the Blasted Reaches
                { 7, 27539 }, -- Justice Bearer's Pauldrons
                { 8, 27906 }, -- Crimsonforge Breastplate
                { 9, 27464 }, -- Omor's Unyielding Will
                { 10, 27895 }, -- Band of Many Prisms
                { 11, 27477 }, -- Faol's Signet of Cleansing
                { 12, 27463 }, -- Terror Flame Dagger
                { 13, 27476 }, -- Truncheon of Five Hells
                { 15, 23886 }, -- Omor's Hoof
                { 16, 30593 }, -- Iridescent Fire Opal
                { 17, 30594 }, -- Effulgent Chrysoprase
                { 18, 30592 }, -- Steady Chrysoprase
                { 20, 27465 }, -- Mana-Etched Gloves
            }
        },
        { -- HCRampFelIronChest
            name = AL["Nazan & Vazruden"],
            npcID = {17537,18434,17536,18432},
            ObjectID = 185168,
            Level = 62,
            DisplayIDs = {{18812},{18407}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24150 }, -- Mok'Nathal Wildercloak
                { 2, 24083 }, -- Lifegiver Britches
                { 3, 24063 }, -- Shifting Sash of Midnight
                { 4, 24046 }, -- Kilt of Rolling Thunders
                { 5, 24064 }, -- Ironsole Clompers
                { 6, 24045 }, -- Band of Renewal
                { 7, 24154 }, -- Witching Band
                { 8, 24151 }, -- Mok'Nathal Clan Ring
                { 9, 24044 }, -- Hellreaver
                { 10, 24155 }, -- Ursol's Claw
                { 16, 23891 }, -- Ominous Letter
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29264 }, -- Tree-Mender's Belt
                { 3, 32077 }, -- Wrath Infused Gauntlets
                { 4, 29238 }, -- Lion's Heart Girdle
                { 5, 29346 }, -- Feltooth Eviscerator
                { 7, 27452 }, -- Light Scribe Bands
                { 8, 27461 }, -- Chestguard of the Prowler
                { 9, 27456 }, -- Raiments of Nature's Breath
                { 10, 27454 }, -- Volcanic Pauldrons
                { 11, 27458 }, -- Oceansong Kilt
                { 12, 27455 }, -- Irondrake Faceguard
                { 13, 27459 }, -- Vambraces of Daring
                { 14, 27457 }, -- Life Bearer's Gauntlets
                { 16, 30593 }, -- Iridescent Fire Opal
                { 17, 30594 }, -- Effulgent Chrysoprase
                { 18, 30592 }, -- Steady Chrysoprase
                { 22, 27453 }, -- Averinn's Ring of Slaying
                { 23, 27460 }, -- Reavers' Ring
                { 25, 23891 }, -- Ominous Letter
            }
        },
        KEYS
    }
}

data["TheBloodFurnace"] = {
    nameFormat = NAME_HELLFIRE_CITADEL,
	MapID = 3713,
	InstanceID = 542,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_HCBloodFurnace",
	AtlasMapFile = {"CL_HCBloodFurnace", "HellfireCitadelEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {58, 60, 68},
	items = {
        { -- HCFurnaceMaker
            name = AL["The Maker"],
            npcID = {17381,18621},
            Level = 62,
            DisplayIDs = {{18369}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 24388 }, -- Girdle of the Gale Storm
                { 2, 24387 }, -- Ironblade Gauntlets
                { 3, 24385 }, -- Pendant of Battle-Lust
                { 4, 24386 }, -- Libram of Saints Departed
                { 5, 24384 }, -- Diamond-Core Sledgemace
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30601 }, -- Beaming Fire Opal
                { 3, 30600 }, -- Fluorescent Tanzanite
                { 4, 30602 }, -- Jagged Chrysoprase
                { 6, 27485 }, -- Embroidered Cape of Mysteries
                { 7, 27488 }, -- Mage-Collar of the Firestorm
                { 8, 27483 }, -- Moon-Touched Bands
                { 9, 27487 }, -- Bloodlord Legplates
                { 10, 27484 }, -- Libram of Avengement
            }
        },
        { -- HCFurnaceBroggok
            name = AL["Broggok"],
            npcID = {17380,18601},
            Level = 63,
            DisplayIDs = {{19372}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 24392 }, -- Arcing Bracers
                { 2, 24393 }, -- Bloody Surgeon's Mitts
                { 3, 24391 }, -- Kilt of the Night Strider
                { 4, 24390 }, -- Auslese's Light Channeler
                { 5, 24389 }, -- Legion Blunderbuss
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30601 }, -- Beaming Fire Opal
                { 3, 30600 }, -- Fluorescent Tanzanite
                { 4, 30602 }, -- Jagged Chrysoprase
                { 6, 27848 }, -- Embroidered Spellpyre Boots
                { 7, 27492 }, -- Moonchild Leggings
                { 8, 27489 }, -- Virtue Bearer's Vambraces
                { 9, 27491 }, -- Signet of Repose
                { 10, 27490 }, -- Firebrand Battleaxe
            }
        },
        { -- HCFurnaceBreaker
            name = AL["Keli'dan the Breaker"],
            npcID = {17377,18607},
            Level = 63,
            DisplayIDs = {{17153}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24397 }, -- Raiments of Divine Authority
                { 2, 24395 }, -- Mindfire Waistband
                { 3, 24398 }, -- Mantle of the Dusk-Dweller
                { 4, 24396 }, -- Vest of Vengeance
                { 5, 24394 }, -- Warsong Howling Axe
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 32080 }, -- Mantle of Shadowy Embrace
                { 3, 29245 }, -- Wave-Crest Striders
                { 4, 29239 }, -- Eaglecrest Warboots
                { 5, 29347 }, -- Talisman of the Breaker
                { 7, 27506 }, -- Robe of Effervescent Light
                { 8, 27514 }, -- Leggings of the Unrepentant
                { 9, 27522 }, -- World's End Bracers
                { 10, 27494 }, -- Emerald Eye Bracer
                { 11, 27505 }, -- Ruby Helm of the Just
                { 12, 27788 }, -- Bloodsworn Warboots
                { 13, 27495 }, -- Soldier's Dog Tags
                { 14, 28121 }, -- Icon of Unyielding Courage
                { 16, 30601 }, -- Beaming Fire Opal
                { 17, 30600 }, -- Fluorescent Tanzanite
                { 18, 30602 }, -- Jagged Chrysoprase
                { 22, 28264 }, -- Wastewalker Tunic
                { 23, 27497 }, -- Doomplate Gauntlets
                { 25, 27512 }, -- The Willbreaker
                { 26, 27507 }, -- Adamantine Repeater
                { 28, 33814 }, -- Keli'dan's Feathered Stave
            }
        },
        KEYS
    }
}

data["TheShatteredHalls"] = {
    nameFormat = NAME_HELLFIRE_CITADEL,
	MapID = 3714,
	InstanceID = 540,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_",
	AtlasMapFile = {"CL_HCTheShatteredHalls", "HellfireCitadelEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- HCHallsNethekurse
        name = AL["Grand Warlock Nethekurse"],
            npcID = {16807,20568},
            Level = 71,
            DisplayIDs = {{16628}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 24312 }, -- Pattern: Spellstrike Hood
                { 3, 27519 }, -- Cloak of Malice
                { 4, 27517 }, -- Bands of Nethekurse
                { 5, 27521 }, -- Telaari Hunting Girdle
                { 6, 27520 }, -- Greathelm of the Unbreakable
                { 7, 27518 }, -- Ivory Idol of the Moongoddess
                { 9, 21525 }, -- Green Winter Hat
                { 11, 23735 }, -- Grand Warlock's Amulet
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 24312 }, -- Pattern: Spellstrike Hood
                { 3, 30548 }, -- Polished Chrysoprase
                { 4, 30547 }, -- Luminous Fire Opal
                { 5, 30546 }, -- Sovereign Tanzanite
                { 7, 27519 }, -- Cloak of Malice
                { 8, 27517 }, -- Bands of Nethekurse
                { 9, 27521 }, -- Telaari Hunting Girdle
                { 10, 27520 }, -- Greathelm of the Unbreakable
                { 11, 27518 }, -- Ivory Idol of the Moongoddess
                { 13, 23735 }, -- Grand Warlock's Amulet
                { 14, 25462 }, -- Tome of Dusk
                { 16, 21525 }, -- Green Winter Hat
            }
        },
        { -- HCHallsPorung
            name = AL["Blood Guard Porung"],
            npcID = 20923,
            Level = 72,
            DisplayIDs = {{17725}},
            AtlasMapBossID = 2,
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30548 }, -- Polished Chrysoprase
                { 3, 30547 }, -- Luminous Fire Opal
                { 4, 30546 }, -- Sovereign Tanzanite
                { 6, 30709 }, -- Pantaloons of Flaming Wrath
                { 7, 30707 }, -- Nimble-foot Treads
                { 8, 30708 }, -- Belt of Flowing Thought
                { 9, 30705 }, -- Spaulders of Slaughter
                { 10, 30710 }, -- Blood Guard's Necklace of Ferocity
            }
        },
        { -- HCHallsOmrogg
            name = AL["Warbringer O'mrogg"],
            npcID = {16809,20596},
            Level = 72,
            DisplayIDs = {{18031}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 27525 }, -- Jeweled Boots of Sanctification
                { 2, 27868 }, -- Runesong Dagger
                { 3, 27524 }, -- Firemaul of Destruction
                { 4, 27526 }, -- Skyfire Hawk-Bow
                { 6, 30829 }, -- Tear of the Earthmother
                { 16, 27802 }, -- Tidefury Shoulderguards
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30548 }, -- Polished Chrysoprase
                { 3, 30547 }, -- Luminous Fire Opal
                { 4, 30546 }, -- Sovereign Tanzanite
                { 6, 27525 }, -- Jeweled Boots of Sanctification
                { 7, 27868 }, -- Runesong Dagger
                { 8, 27524 }, -- Firemaul of Destruction
                { 9, 27526 }, -- Skyfire Hawk-Bow
                { 11, 30829 }, -- Tear of the Earthmother
                { 21, 27802 }, -- Tidefury Shoulderguards
            }
        },
        { -- HCHallsKargath
            name = AL["Warchief Kargath Bladefist"],
            npcID = {16808,20597},
            Level = 72,
            DisplayIDs = {{19799}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 27527 }, -- Greaves of the Shatterer
                { 2, 27529 }, -- Figurine of the Colossus
                { 3, 27534 }, -- Hortus' Seal of Brilliance
                { 4, 27533 }, -- Demonblood Eviscerator
                { 5, 27538 }, -- Lightsworn Hammer
                { 6, 27540 }, -- Nexus Torch
                { 8, 23723 }, -- Warchief Kargath's Fist
                { 16, 27536 }, -- Hallowed Handwraps
                { 17, 27537 }, -- Gloves of Oblivion
                { 18, 27531 }, -- Wastewalker Gloves
                { 19, 27474 }, -- Beast Lord Handguards
                { 20, 27528 }, -- Gauntlets of Desolation
                { 21, 27535 }, -- Gauntlets of the Righteous
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29255 }, -- Bands of Rarefied Magic
                { 3, 29263 }, -- Forestheart Bracers
                { 4, 29254 }, -- Boots of the Righteous Path
                { 5, 29348 }, -- The Bladefist
                { 7, 27527 }, -- Greaves of the Shatterer
                { 8, 27529 }, -- Figurine of the Colossus
                { 9, 27534 }, -- Hortus' Seal of Brilliance
                { 10, 27533 }, -- Demonblood Eviscerator
                { 11, 27538 }, -- Lightsworn Hammer
                { 12, 27540 }, -- Nexus Torch
                { 14, 23723 }, -- Warchief Kargath's Fist
                { 15, 33815 }, -- Bladefist's Seal
                { 16, 30548 }, -- Polished Chrysoprase
                { 17, 30547 }, -- Luminous Fire Opal
                { 18, 30546 }, -- Sovereign Tanzanite
                { 22, 27536 }, -- Hallowed Handwraps
                { 23, 27537 }, -- Gloves of Oblivion
                { 24, 27531 }, -- Wastewalker Gloves
                { 25, 27474 }, -- Beast Lord Handguards
                { 26, 27528 }, -- Gauntlets of Desolation
                { 27, 27535 }, -- Gauntlets of the Righteous
            }
        },
        { -- HCHallsExecutioner
            name = AL["Shattered Hand Executioner"],
            npcID = {17301,20585},
            Level = 70,
            DisplayIDs = {{16969}},
            ExtraList = true,
            AtlasMapBossID = "A",
            [HEROIC_DIFF] = {
                { 1, 31716 }, -- Unused Axe of the Executioner
            }
        },
        { -- HCHallsTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 22554 }, -- Formula: Enchant 2H Weapon - Savagery
            }
        },
        KEYS
    }
}

data["Mana-Tombs"] = {
    nameFormat = NAME_AUCHINDOUN,
	MapID = 3792,
	InstanceID = 557,
    AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_AuchManaTombs",
	AtlasMapFile = {"CL_AuchManaTombs", "CL_AuchindounEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {61, 63, 70},
	items = {
        { -- AuchManaPandemonius
            name = AL["Pandemonius"],
            npcID = {18341, 20267},
            Level = 66,
            DisplayIDs = {{19338}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 25941 }, -- Boots of the Outlander
                { 2, 25942 }, -- Faith Bearer's Gauntlets
                { 3, 25940 }, -- Idol of the Claw
                { 4, 25943 }, -- Creepjacker
                { 5, 28166 }, -- Shield of the Void
                { 6, 25939 }, -- Voidfire Wand
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30584 }, -- Enscribed Fire Opal
                { 3, 30585 }, -- Glistening Fire Opal
                { 4, 30583 }, -- Timeless Chrysoprase
                { 6, 27816 }, -- Mindrage Pauldrons
                { 7, 27818 }, -- Starry Robes of the Crescent
                { 8, 27813 }, -- Boots of the Colossus
                { 9, 27815 }, -- Totem of the Astral Winds
                { 10, 27814 }, -- Twinblade of Mastery
                { 11, 27817 }, -- Starbolt Longbow
            }
        },
        { -- AuchManaTavarok
            name = AL["Tavarok"],
            npcID = {18343, 20268},
            Level = 66,
            DisplayIDs = {{19332}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 25945 }, -- Cloak of Revival
                { 2, 25946 }, -- Nethershade Boots
                { 3, 25947 }, -- Lightning-Rod Pauldrons
                { 4, 25952 }, -- Scimitar of the Nexus-Stalkers
                { 5, 25944 }, -- Shaarde the Greater
                { 6, 25950 }, -- Staff of Polarities
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30584 }, -- Enscribed Fire Opal
                { 3, 30585 }, -- Glistening Fire Opal
                { 4, 30583 }, -- Timeless Chrysoprase
                { 6, 27824 }, -- Robe of the Great Dark Beyond
                { 7, 27821 }, -- Extravagant Boots of Malice
                { 8, 27825 }, -- Predatory Gloves
                { 9, 27826 }, -- Mantle of the Sea Wolf
                { 10, 27823 }, -- Shard Encrusted Breastplate
                { 11, 27822 }, -- Crystal Band of Valor
            }
        },
        { -- AuchManaNexusPrince
            name = AL["Nexus-Prince Shaffar"],
            npcID = {18344, 20266},
            Level = 66,
            DisplayIDs = {{19780}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 25957 }, -- Ethereal Boots of the Skystrider
                { 2, 25955 }, -- Mask of the Howling Storm
                { 3, 25956 }, -- Nexus-Bracers of Vigor
                { 4, 25954 }, -- Sigil of Shaffar
                { 5, 25962 }, -- Longstrider's Loop
                { 6, 25953 }, -- Ethereal Warp-Bow
                { 16, 22921 }, -- Recipe: Major Frost Protection Potion
                { 18, 28490 }, -- Shaffar's Wrappings
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29240 }, -- Bands of Negation
                { 3, 30535 }, -- Forestwalker Kilt
                { 4, 29352 }, -- Cobalt Band of Tyrigosa
                { 5, 32082 }, -- The Fel Barrier
                { 7, 27831 }, -- Mantle of the Unforgiven
                { 8, 27843 }, -- Glyph-Lined Sash
                { 9, 27827 }, -- Lucid Dream Bracers
                { 10, 27835 }, -- Stillwater Girdle
                { 11, 27844 }, -- Pauldrons of Swift Retribution
                { 12, 27798 }, -- Gauntlets of Vindication
                { 14, 33835 }, -- Shaffar's Wondrous Amulet
                { 15, 28490 }, -- Shaffar's Wrappings
                { 16, 30584 }, -- Enscribed Fire Opal
                { 17, 30585 }, -- Glistening Fire Opal
                { 18, 30583 }, -- Timeless Chrysoprase
                { 22, 27837 }, -- Wastewalker Leggings
                { 23, 27828 }, -- Warp-Scarab Brooch
                { 24, 28400 }, -- Warp-Storm Warblade
                { 25, 27829 }, -- Axe of the Nexus-Kings
                { 26, 27840 }, -- Scepter of Sha'tar
                { 27, 27842 }, -- Grand Scepter of the Nexus-Kings
                { 29, 22921 }, -- Recipe: Major Frost Protection Potion
            }
        },
        { -- AuchManaYor
            name = AL["Yor <Void Hound of Shaffar>"],
            npcID = 22930,
            Level = 70,
            DisplayIDs = {{14173}},
            AtlasMapBossID = 4,
            ExtraList = true,
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 31919 }, -- Nexus-Prince's Ring of Balance
                { 3, 31920 }, -- Shaffar's Band of Brutality
                { 4, 31921 }, -- Yor's Collapsing Band
                { 5, 31922 }, -- Ring of Conflict Survival
                { 6, 31923 }, -- Band of the Crystalline Void
                { 7, 31924 }, -- Yor's Revenge
                { 9, 31554 }, -- Windchanneller's Tunic
                { 10, 31562 }, -- Skystalker's Tunic
                { 11, 31570 }, -- Mistshroud Tunic
                { 12, 31578 }, -- Slatesteel Breastplate
                { 16, 30584 }, -- Enscribed Fire Opal
                { 17, 30585 }, -- Glistening Fire Opal
                { 18, 30583 }, -- Timeless Chrysoprase
            }
        },
        { -- AuchManaTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 23615 }, -- Plans: Swiftsteel Gloves
                { 3, 22543 }, -- Formula: Enchant Boots - Fortitude
            }
        },
        KEYS
    }
}

data["AuchenaiCrypts"] = {
    nameFormat = NAME_AUCHINDOUN,
	MapID = 3790,
	InstanceID = 558,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_AuchAuchenaiCrypts",
	AtlasMapFile = {"CL_AuchAuchenaiCrypts", "CL_AuchindounEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {62, 64, 70},
	items = {
        { -- AuchCryptsShirrak
            name = AL["Shirrak the Dead Watcher"],
            npcID = {18371, 20318},
            Level = 66,
            DisplayIDs = {{18916}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 27410 }, -- Collar of Command
                { 2, 27409 }, -- Raven-Heart Headdress
                { 3, 27408 }, -- Hope Bearer Helm
                { 4, 26055 }, -- Oculus of the Hidden Eye
                { 5, 25964 }, -- Shaarde the Lesser
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30587 }, -- Champion's Fire Opal
                { 3, 30588 }, -- Potent Fire Opal
                { 4, 30586 }, -- Seer's Chrysoprase
                { 6, 27866 }, -- Scintillating Headdress of Second Sight
                { 7, 27493 }, -- Gloves of the Deadwatcher
                { 8, 27865 }, -- Bracers of Shirrak
                { 9, 27845 }, -- Magma Plume Boots
                { 10, 27847 }, -- Fanblade Pauldrons
                { 11, 27846 }, -- Claw of the Watcher
            }
        },
        { -- AuchCryptsExarch
            name = AL["Exarch Maladaar"],
            npcID = {18373, 20306},
            Level = 67,
            DisplayIDs = {{17715}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 27411 }, -- Slippers of Serenity
                { 2, 27415 }, -- Darkguard Face Mask
                { 3, 27414 }, -- Mok'Nathal Beast-Mask
                { 4, 27413 }, -- Ring of the Exarchs
                { 5, 27416 }, -- Fetish of the Fallen
                { 6, 27412 }, -- Ironstaff of Regeneration
                { 8, 21525 }, -- Green Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29354 }, -- Light-Touched Stole of Altruism
                { 3, 29257 }, -- Sash of Arcane Visions
                { 4, 29244 }, -- Wave-Song Girdle
                { 6, 27867 }, -- Boots of the Unjust
                { 7, 27871 }, -- Maladaar's Blessed Chaplet
                { 8, 27869 }, -- Soulpriest's Ring of Resolve
                { 9, 27523 }, -- Exarch's Diamond Band
                { 10, 27872 }, -- The Harvester of Souls
                { 12, 21525 }, -- Green Winter Hat
                { 14, 33836 }, -- The Exarch's Soul Gem
                { 16, 30587 }, -- Champion's Fire Opal
                { 17, 30588 }, -- Potent Fire Opal
                { 18, 30586 }, -- Seer's Chrysoprase
                { 21, 27870 }, -- Doomplate Legguards
            }
        },
        { -- AuchCryptsAvatar
            name = AL["Avatar of the Martyred"],
            npcID = 18478,
            Level = 72,
            DisplayIDs = {{18142}},
            AtlasMapBossID = 2,
            ExtraList = true,
            [HEROIC_DIFF] = {
                { 1, 27878 }, -- Auchenai Death Shroud
                { 2, 28268 }, -- Natural Mender's Wraps
                { 3, 27876 }, -- Will of the Fallen Exarch
                { 4, 27937 }, -- Sky Breaker
                { 5, 27877 }, -- Draenic Wildstaff
                { 7, 27797 }, -- Wastewalker Shoulderpads
            }
        },
        { -- AuchCryptsTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 23605 }, -- Plans: Felsteel Gloves
                { 3, 22544 }, -- Formula: Enchant Boots - Dexterity
            }
        },
        KEYS
	},
}

data["SethekkHalls"] = {
    nameFormat = NAME_AUCHINDOUN,
	MapID = 3791,
	InstanceID = 556,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_AuchSethekkHalls",
	AtlasMapFile = {"CL_AuchSethekkHalls", "CL_AuchindounEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {63, 66, 70},
	items = {
        { -- AuchSethekkDarkweaver
            name = AL["Darkweaver Syth"],
            npcID = {18472, 20690},
            Level = 69,
            DisplayIDs = {{20599}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 27919 }, -- Light-Woven Slippers
                { 2, 27914 }, -- Moonstrider Boots
                { 3, 27915 }, -- Sky-Hunter Swift Boots
                { 4, 27918 }, -- Bands of Syth
                { 5, 27917 }, -- Libram of the Eternal Rest
                { 6, 27916 }, -- Sethekk Feather-Darts
                { 8, 24160 }, -- Design: Khorium Inferno Band
                { 10, 27633 }, -- Terokk's Mask
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30553 }, -- Pristine Fire Opal
                { 3, 30554 }, -- Stalwart Fire Opal
                { 4, 30552 }, -- Blessed Tanzanite
                { 6, 27919 }, -- Light-Woven Slippers
                { 7, 27914 }, -- Moonstrider Boots
                { 8, 27915 }, -- Sky-Hunter Swift Boots
                { 9, 27918 }, -- Bands of Syth
                { 10, 27917 }, -- Libram of the Eternal Rest
                { 11, 27916 }, -- Sethekk Feather-Darts
                { 16, 24160 }, -- Design: Khorium Inferno Band
                { 18, 27633 }, -- Terokk's Mask
                { 19, 25461 }, -- Book of Forgotten Names
            }
        },
        { -- AuchSethekkTalonKing
            name = AL["Talon King Ikiss"],
            npcID = {18473, 20706},
            Level = 69,
            DisplayIDs = {{18636}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 27946 }, -- Avian Cloak of Feathers
                { 2, 27981 }, -- Sethekk Oracle Cloak
                { 3, 27985 }, -- Deathforge Girdle
                { 4, 27925 }, -- Ravenclaw Band
                { 5, 27980 }, -- Terokk's Nightmace
                { 6, 27986 }, -- Crow Wing Reaper
                { 8, 27632 }, -- Terokk's Quill
                { 10, "INV_Box_01", nil, AL["The Talon King's Coffer"], nil },
                { 11, 27991 }, -- Shadow Labyrinth Key
                { 16, 27948 }, -- Trousers of Oblivion
                { 17, 27838 }, -- Incanter's Trousers
                { 18, 27875 }, -- Hallowed Trousers
                { 19, 27776 }, -- Shoulderpads of Assassination
                { 20, 27936 }, -- Greaves of Desolation
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29249 }, -- Bands of the Benevolent
                { 3, 29259 }, -- Bracers of the Hunt
                { 4, 32073 }, -- Spaulders of Dementia
                { 5, 29355 }, -- Terokk's Shadowstaff
                { 7, 27946 }, -- Avian Cloak of Feathers
                { 8, 27981 }, -- Sethekk Oracle Cloak
                { 9, 27985 }, -- Deathforge Girdle
                { 10, 27925 }, -- Ravenclaw Band
                { 11, 27980 }, -- Terokk's Nightmace
                { 12, 27986 }, -- Crow Wing Reaper
                { 14, "INV_Box_01", nil, AL["The Talon King's Coffer"], nil },
                { 15, 27991 }, -- Shadow Labyrinth Key
                { 16, 30553 }, -- Pristine Fire Opal
                { 17, 30554 }, -- Stalwart Fire Opal
                { 18, 30552 }, -- Blessed Tanzanite
                { 22, 27948 }, -- Trousers of Oblivion
                { 23, 27838 }, -- Incanter's Trousers
                { 24, 27875 }, -- Hallowed Trousers
                { 25, 27776 }, -- Shoulderpads of Assassination
                { 26, 27936 }, -- Greaves of Desolation
                { 29, 27632 }, -- Terokk's Quill
                { 30, 33834 }, -- The Headfeathers of Ikiss
            }
        },
        { -- AuchSethekkRavenGod
            name = AL["Anzu"],
            npcID = 23035,
            Level = 72,
            DisplayIDs = {{21492}},
            AtlasMapBossID = 2,
            ExtraList = true,
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 32768 }, -- Reins of the Raven Lord
                { 3, 30553 }, -- Pristine Fire Opal
                { 4, 30554 }, -- Stalwart Fire Opal
                { 5, 30552 }, -- Blessed Tanzanite
                { 7, 32769 }, -- Belt of the Raven Lord
                { 8, 32778 }, -- Boots of Righteous Fortitude
                { 9, 32779 }, -- Band of Frigid Elements
                { 10, 32781 }, -- Talon of Anzu
                { 11, 32780 }, -- The Boomstick
            },
        },
        { -- AuchSethekkTheSagaofTerokk
            name = AL["The Saga of Terokk"],
            ObjectID = 183050,
            AtlasMapBossID = 2,
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 27634 }, -- The Saga of Terokk
            }
        },
        { -- AuchSethekkTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 25731 }, -- Pattern: Stylin' Crimson Hat
                { 3, 29669 }, -- Pattern: Shadow Armor Kit
            }
        },
        KEYS
    }
}

data["ShadowLabyrinth"] = {
    nameFormat = NAME_AUCHINDOUN,
	MapID = 3789,
	InstanceID = 555,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_AuchShadowLabyrinth",
	AtlasMapFile = {"CL_AuchShadowLabyrinth", "CL_AuchindounEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- AuchShadowHellmaw
            name = AL["Ambassador Hellmaw"],
            npcID = {18731, 20636},
            Level = 72,
            DisplayIDs = {{18821}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 27889 }, -- Jaedenfire Gloves of Annihilation
                { 2, 27888 }, -- Dream-Wing Helm
                { 3, 27884 }, -- Ornate Boots of the Sanctified
                { 4, 27886 }, -- Idol of the Emerald Queen
                { 5, 27887 }, -- Platinum Shield of the Valorous
                { 6, 27885 }, -- Soul-Wand of the Aldor
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30563 }, -- Regal Tanzanite
                { 3, 30559 }, -- Etched Fire Opal
                { 4, 30560 }, -- Rune Covered Chrysoprase
                { 6, 27889 }, -- Jaedenfire Gloves of Annihilation
                { 7, 27888 }, -- Dream-Wing Helm
                { 8, 27884 }, -- Ornate Boots of the Sanctified
                { 9, 27886 }, -- Idol of the Emerald Queen
                { 10, 27887 }, -- Platinum Shield of the Valorous
                { 11, 27885 }, -- Soul-Wand of the Aldor
            }
        },
        { -- AuchShadowBlackheart
            name = AL["Blackheart the Inciter"],
            npcID = {18667, 20637},
            Level = 72,
            DisplayIDs = {{18058}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 27892 }, -- Cloak of the Inciter
                { 2, 27893 }, -- Ornate Leggings of the Venerated
                { 3, 28134 }, -- Brooch of Heightened Potential
                { 4, 27891 }, -- Adamantine Figurine
                { 5, 27890 }, -- Wand of the Netherwing
                { 7, 25728 }, -- Pattern: Stylin' Purple Hat
                { 9, 30808 }, -- Book of Fel Names
                { 16, 27468 }, -- Moonglade Handwraps
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30563 }, -- Regal Tanzanite
                { 3, 30559 }, -- Etched Fire Opal
                { 4, 30560 }, -- Rune Covered Chrysoprase
                { 6, 27892 }, -- Cloak of the Inciter
                { 7, 27893 }, -- Ornate Leggings of the Venerated
                { 8, 28134 }, -- Brooch of Heightened Potential
                { 9, 27891 }, -- Adamantine Figurine
                { 10, 27890 }, -- Wand of the Netherwing
                { 12, 25728 }, -- Pattern: Stylin' Purple Hat
                { 14, 30808 }, -- Book of Fel Names
                { 21, 27468 }, -- Moonglade Handwraps
            }
        },
        { -- AuchShadowGrandmaster
            name = AL["Grandmaster Vorpil"],
            npcID = {18732, 20653},
            Level = 72,
            DisplayIDs = {{18535}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 27897 }, -- Breastplate of Many Graces
                { 2, 27900 }, -- Jewel of Charismatic Mystique
                { 3, 27901 }, -- Blackout Truncheon
                { 4, 27898 }, -- Wrathfire Hand-Cannon
                { 6, 21525 }, -- Green Winter Hat
                { 8, 30827 }, -- Lexicon Demonica
                { 16, 27775 }, -- Hallowed Pauldrons
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30563 }, -- Regal Tanzanite
                { 3, 30559 }, -- Etched Fire Opal
                { 4, 30560 }, -- Rune Covered Chrysoprase
                { 6, 27897 }, -- Breastplate of Many Graces
                { 7, 27900 }, -- Jewel of Charismatic Mystique
                { 8, 27901 }, -- Blackout Truncheon
                { 9, 27898 }, -- Wrathfire Hand-Cannon
                { 11, 21525 }, -- Green Winter Hat
                { 13, 30827 }, -- Lexicon Demonica
                { 21, 27775 }, -- Hallowed Pauldrons
            }
        },
        { -- AuchShadowMurmur
            name = AL["Murmur"],
            npcID = {18708, 20657},
            Level = 72,
            DisplayIDs = {{18839}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 24309 }, -- Pattern: Spellstrike Pants
                { 3, 27902 }, -- Silent Slippers of Meditation
                { 4, 27912 }, -- Harness of the Deep Currents
                { 5, 27913 }, -- Whispering Blade of Slaying
                { 6, 27905 }, -- Greatsword of Horrid Dreams
                { 7, 27903 }, -- Sonic Spear
                { 8, 27910 }, -- Silvermoon Crest Shield
                { 16, 27778 }, -- Spaulders of Oblivion
                { 17, 28232 }, -- Robe of Oblivion
                { 18, 28230 }, -- Hallowed Garments
                { 19, 27908 }, -- Leggings of Assassination
                { 20, 27909 }, -- Tidefury Kilt
                { 21, 27803 }, -- Shoulderguards of the Bold
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30532 }, -- Kirin Tor Master's Trousers
                { 3, 29357 }, -- Master Thief's Gloves
                { 4, 29261 }, -- Girdle of Ferocity
                { 5, 29353 }, -- Shockwave Truncheon
                { 7, 27902 }, -- Silent Slippers of Meditation
                { 8, 27912 }, -- Harness of the Deep Currents
                { 9, 27913 }, -- Whispering Blade of Slaying
                { 10, 27905 }, -- Greatsword of Horrid Dreams
                { 11, 27903 }, -- Sonic Spear
                { 12, 27910 }, -- Silvermoon Crest Shield
                { 14, 31722 }, -- Murmur's Essence
                { 16, 30563 }, -- Regal Tanzanite
                { 17, 30559 }, -- Etched Fire Opal
                { 18, 30560 }, -- Rune Covered Chrysoprase
                { 20, 24309 }, -- Pattern: Spellstrike Pants
                { 22, 27778 }, -- Spaulders of Oblivion
                { 23, 28232 }, -- Robe of Oblivion
                { 24, 28230 }, -- Hallowed Garments
                { 25, 27908 }, -- Leggings of Assassination
                { 26, 27909 }, -- Tidefury Kilt
                { 27, 27803 }, -- Shoulderguards of the Bold
                { 29, 33840 }, -- Murmur's Whisper
            }
        },
        { -- AuchShadowFirstFragmentGuardian
            name = AL["First Fragment Guardian"],
            npcID = 22890,
            Level = 70,
            DisplayIDs = {{19113}},
            AtlasMapBossID = 1,
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 24514 }, -- First Key Fragment
            }
        },
        { -- AuchShadowTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 23607 }, -- Plans: Felsteel Helm
            }
        },
        KEYS
    }
}

data["TheSlavePens"] = {
    nameFormat = NAME_COILFANG_RESERVOIR,
	MapID = 3717,
	InstanceID = 547,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CFRTheSlavePens",
	AtlasMapFile = {"CL_CFRTheSlavePens", "CL_CoilfangReservoirEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {59, 61, 69},
	items = {
        { -- CFRSlaveMennu
            name = AL["Mennu the Betrayer"],
            npcID = {17941, 19893},
            Level = 64,
            DisplayIDs = {{17728}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 24359 }, -- Princely Reign Leggings
                { 2, 24357 }, -- Vest of Living Lightning
                { 3, 24360 }, -- Tracker's Belt
                { 4, 24356 }, -- Wastewalker Shiv
                { 5, 24361 }, -- Spellfire Longsword
                { 16, 29674 }, -- Pattern: Nature Armor Kit
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30604 }, -- Resplendent Fire Opal
                { 3, 30605 }, -- Vivid Chrysoprase
                { 4, 30603 }, -- Royal Tanzanite
                { 6, 27542 }, -- Cord of Belief
                { 7, 27545 }, -- Mennu's Scaled Leggings
                { 8, 27541 }, -- Archery Belt of the Broken
                { 9, 27546 }, -- Traitor's Noose
                { 10, 27544 }, -- Totem of Spontaneous Regrowth
                { 11, 27543 }, -- Starlight Dagger
                { 16, 29674 }, -- Pattern: Nature Armor Kit
            }
        },
        { -- CFRSlaveRokmar
            name = AL["Rokmar the Crackler"],
            npcID = {17991, 19895},
            Level = 64,
            DisplayIDs = {{17729}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 24379 }, -- Bogstrok Scale Cloak
                { 2, 24376 }, -- Runed Fungalcap
                { 3, 24378 }, -- Coilfang Hammer of Renewal
                { 4, 24380 }, -- Calming Spore Reed
                { 5, 24381 }, -- Coilfang Needler
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30604 }, -- Resplendent Fire Opal
                { 3, 30605 }, -- Vivid Chrysoprase
                { 4, 30603 }, -- Royal Tanzanite
                { 6, 27550 }, -- Ironscale War Cloak
                { 7, 27547 }, -- Coldwhisper Cord
                { 8, 28124 }, -- Liar's Cord
                { 9, 27549 }, -- Wavefury Boots
                { 10, 27548 }, -- Girdle of Many Blessings
                { 11, 27551 }, -- Skeletal Necklace of Battlerage
            },
        },
        { -- CFRSlaveQuagmirran
            name = AL["Quagmirran"],
            npcID = {17942, 19894},
            Level = 64,
            DisplayIDs = {{18224}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24362 }, -- Spore-Soaked Vaneer
                { 2, 24365 }, -- Deft Handguards
                { 3, 24366 }, -- Scorpid-Sting Mantle
                { 4, 24363 }, -- Unscarred Breastplate
                { 5, 24364 }, -- Azureplate Greaves
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29242 }, -- Boots of Blasphemy
                { 3, 30538 }, -- Midnight Legguards
                { 4, 32078 }, -- Pauldrons of Wild Magic
                { 5, 29349 }, -- Adamantine Chain of the Unbroken
                { 7, 27712 }, -- Shackles of Quagmirran
                { 8, 27800 }, -- Earthsoul Britches
                { 9, 28337 }, -- Breastplate of Righteous Fury
                { 10, 27672 }, -- Girdle of the Immovable
                { 11, 27742 }, -- Mage-Fury Girdle
                { 13, 33821 }, -- The Heart of Quagmirran
                { 16, 30604 }, -- Resplendent Fire Opal
                { 17, 30605 }, -- Vivid Chrysoprase
                { 18, 30603 }, -- Royal Tanzanite
                { 22, 27796 }, -- Mana-Etched Spaulders
                { 23, 27713 }, -- Pauldrons of Desolation
                { 24, 27740 }, -- Band of Ursol
                { 25, 27683 }, -- Quagmirran's Eye
                { 26, 27714 }, -- Swamplight Lantern
                { 27, 27673 }, -- Phosphorescent Blade
                { 28, 27741 }, -- Bleeding Hollow Warhammer
            }
        },
        AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- CFRSlaveAhune
            name = AL["Ahune <The Frost Lord>"],
            npcID = 25740,
            Level = 83,
            DisplayIDs = {{23344}},
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 54806 }, -- Frostscythe of Lord Ahune
                { 2, 54804 }, -- Shroud of Winter's Chill
                { 3, 54802 }, -- The Frost Lord's War Cloak
                { 4, 54801 }, -- Icebound Cloak
                { 5, 54805 }, -- Cloak of the Frigid Winds
                { 6, 54803 }, -- The Frost Lord's Battle Shroud
                { 8, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 34955 }, -- Scorched Stone
                { 19, 35557 }, -- Huge Snowball
            },
        }),
        AtlasLoot:GameVersion_EQ(AtlasLoot.WRATH_VERSION_NUM, { -- CFRSlaveAhune
            name = AL["Ahune <The Frost Lord>"],
            npcID = 25740,
            Level = 73,
            DisplayIDs = {{23344}},
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35514 }, -- Frostscythe of Lord Ahune
                { 2, 35494 }, -- Shroud of Winter's Chill
                { 3, 35495 }, -- The Frost Lord's War Cloak
                { 4, 35496 }, -- Icebound Cloak
                { 5, 35497 }, -- Cloak of the Frigid Winds
                { 7, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 34955 }, -- Scorched Stone
                { 19, 35557 }, -- Huge Snowball
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 35507 }, -- Amulet of Bitter Hatred
                { 3, 35508 }, -- Choker of the Arctic Flow
                { 4, 35509 }, -- Amulet of Glacial Tranquility
                { 5, 35511 }, -- Hailstone Pendant
                { 7, 35514 }, -- Frostscythe of Lord Ahune
                { 8, 35494 }, -- Shroud of Winter's Chill
                { 9, 35495 }, -- The Frost Lord's War Cloak
                { 10, 35496 }, -- Icebound Cloak
                { 11, 35497 }, -- Cloak of the Frigid Winds
                { 13, 35723 }, -- Shards of Ahune
                { 22, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 24, 34955 }, -- Scorched Stone
                { 25, 35557 }, -- Huge Snowball
            }
        }),
        KEYS
    }
}

data["TheUnderbog"] = {
    nameFormat = NAME_COILFANG_RESERVOIR,
	MapID = 3716,
	InstanceID = 546,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CFRTheUnderbog",
	AtlasMapFile = {"CL_CFRTheUnderbog", "CL_CoilfangReservoirEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {60, 62, 70},
	items = {
        { -- CFRUnderHungarfen
            name = AL["Hungarfen"],
            npcID = {17770,20169},
            Level = 65,
            DisplayIDs = {{17228}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 24450 }, -- Manaspark Gloves
                { 2, 24452 }, -- Starlight Gauntlets
                { 3, 24451 }, -- Lykul Bloodbands
                { 4, 24413 }, -- Totem of the Thunderhead
                { 5, 27631 }, -- Needle Shrike
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30606 }, -- Lambent Chrysoprase
                { 3, 30607 }, -- Splendid Fire Opal
                { 4, 30608 }, -- Radiant Chrysoprase
                { 6, 27746 }, -- Arcanium Signet Bands
                { 7, 27745 }, -- Hungarhide Gauntlets
                { 8, 27743 }, -- Girdle of Living Flame
                { 9, 27748 }, -- Cassock of the Loyal
                { 10, 27744 }, -- Idol of Ursoc
                { 11, 27747 }, -- Boggspine Knuckles
            }
        },
        { -- CFRUnderGhazan
            name = AL["Ghaz'an"],
            npcID = {18105,20168},
            Level = 65,
            DisplayIDs = {{17528}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 24459 }, -- Cloak of Healing Rays
                { 2, 24458 }, -- Studded Girdle of Virtue
                { 3, 24460 }, -- Talisman of Tenacity
                { 4, 24462 }, -- Luminous Pearls of Insight
                { 5, 24461 }, -- Hatebringer
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30606 }, -- Lambent Chrysoprase
                { 3, 30607 }, -- Splendid Fire Opal
                { 4, 30608 }, -- Radiant Chrysoprase
                { 6, 27760 }, -- Dunewind Sash
                { 7, 27759 }, -- Headdress of the Tides
                { 8, 27755 }, -- Girdle of Gallantry
                { 9, 27758 }, -- Hydra-fang Necklace
                { 10, 27761 }, -- Ring of the Shadow Deeps
                { 11, 27757 }, -- Greatstaff of the Leviathan
            }
        },
        { -- CFRUnderSwamplord
            name = AL["Swamplord Musel'ek"],
            npcID = {17826,20183},
            Level = 65,
            DisplayIDs = {{18570}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24454 }, -- Cloak of Enduring Swiftness
                { 2, 24455 }, -- Tunic of the Nightwatcher
                { 3, 24457 }, -- Truth Bearer Shoulderguards
                { 4, 24456 }, -- Greaves of the Iron Guardian
                { 5, 24453 }, -- Zangartooth Shortblade
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30606 }, -- Lambent Chrysoprase
                { 3, 30607 }, -- Splendid Fire Opal
                { 4, 30608 }, -- Radiant Chrysoprase
                { 6, 27764 }, -- Hands of the Sun
                { 7, 27763 }, -- Crown of the Forest Lord
                { 8, 27765 }, -- Armwraps of Disdain
                { 9, 27766 }, -- Swampstone Necklace
                { 10, 27762 }, -- Weathered Band of the Swamplord
                { 11, 27767 }, -- Bogreaver
            }
        },
        { -- CFRUnderStalker
            name = AL["The Black Stalker"],
            npcID = {17882,20184},
            Level = 65,
            DisplayIDs = {{18194}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 24481 }, -- Robes of the Augurer
                { 2, 24466 }, -- Skulldugger's Leggings
                { 3, 24465 }, -- Shamblehide Chestguard
                { 4, 24463 }, -- Pauldrons of Brute Force
                { 5, 24464 }, -- The Stalker's Fangs
                { 7, 24248 }, -- Brain of the Black Stalker
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29265 }, -- Barkchip Boots
                { 3, 30541 }, -- Stormsong Kilt
                { 4, 32081 }, -- Eye of the Stalker
                { 5, 29350 }, -- The Black Stalk
                { 7, 27781 }, -- Demonfang Ritual Helm
                { 8, 27768 }, -- Oracle Belt of Timeless Mystery
                { 9, 27938 }, -- Savage Mask of the Lynx Lord
                { 10, 27773 }, -- Barbaric Legstraps
                { 11, 27779 }, -- Bone Chain Necklace
                { 12, 27780 }, -- Ring of Fabled Hope
                { 13, 27896 }, -- Alembic of Infernal Power
                { 14, 27770 }, -- Argussian Compass
                { 16, 30606 }, -- Lambent Chrysoprase
                { 17, 30607 }, -- Splendid Fire Opal
                { 18, 30608 }, -- Radiant Chrysoprase
                { 22, 27907 }, -- Mana-Etched Pantaloons
                { 23, 27771 }, -- Doomplate Shoulderguards
                { 24, 27769 }, -- Endbringer
                { 25, 27772 }, -- Stormshield of Renewal
                { 26, 24248 }, -- Brain of the Black Stalker
                { 28, 33826 }, -- Black Stalker Egg
            }
        },
        KEYS
    }
}

data["TheSteamvault"] = {
    nameFormat = NAME_COILFANG_RESERVOIR,
	MapID = 3715,
	InstanceID = 545,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CFRTheSteamvault",
	AtlasMapFile = {"CL_CFRTheSteamvault", "CL_CoilfangReservoirEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- CFRSteamThespia
            name = AL["Hydromancer Thespia"],
            npcID = {17797, 20629},
            Level = 72,
            DisplayIDs = {{11268}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 27789 }, -- Cloak of Whispering Shells
                { 2, 27787 }, -- Chestguard of No Remorse
                { 3, 27783 }, -- Moonrage Girdle
                { 4, 27784 }, -- Scintillating Coral Band
                { 6, 29673 }, -- Pattern: Frost Armor Kit
                { 8, 30828 }, -- Vial of Underworld Loam
                { 16, 27508 }, -- Incanter's Gloves
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30550 }, -- Sundered Chrysoprase
                { 3, 30551 }, -- Infused Fire Opal
                { 4, 30549 }, -- Shifting Tanzanite
                { 6, 27789 }, -- Cloak of Whispering Shells
                { 7, 27787 }, -- Chestguard of No Remorse
                { 8, 27783 }, -- Moonrage Girdle
                { 9, 27784 }, -- Scintillating Coral Band
                { 11, 29673 }, -- Pattern: Frost Armor Kit
                { 13, 30828 }, -- Vial of Underworld Loam
                { 21, 27508 }, -- Incanter's Gloves
            }
        },
        { -- CFRSteamSteamrigger
            name = AL["Mekgineer Steamrigger"],
            npcID = {17796, 20630},
            Level = 72,
            DisplayIDs = {{18638}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 27793 }, -- Earth Mantle Handwraps
                { 2, 27790 }, -- Mask of Penance
                { 3, 27792 }, -- Steam-Hinge Chain of Valor
                { 4, 27791 }, -- Serpentcrest Life-Staff
                { 5, 27794 }, -- Recoilless Rocket Ripper X-54
                { 7, 23887 }, -- Schematic: Rocket Boots Xtreme
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30550 }, -- Sundered Chrysoprase
                { 3, 30551 }, -- Infused Fire Opal
                { 4, 30549 }, -- Shifting Tanzanite
                { 6, 27793 }, -- Earth Mantle Handwraps
                { 7, 27790 }, -- Mask of Penance
                { 8, 27792 }, -- Steam-Hinge Chain of Valor
                { 9, 27791 }, -- Serpentcrest Life-Staff
                { 10, 27794 }, -- Recoilless Rocket Ripper X-54
                { 12, 23887 }, -- Schematic: Rocket Boots Xtreme
            }
        },
        { -- CFRSteamWarlord
            name = AL["Warlord Kalithresh"],
            npcID = {17798, 20633},
            Level = 72,
            DisplayIDs = {{20235}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24313 }, -- Pattern: Battlecast Hood
                { 3, 27804 }, -- Devilshark Cape
                { 4, 27799 }, -- Vermillion Robes of the Dominant
                { 5, 27795 }, -- Sash of Serpentra
                { 6, 27806 }, -- Fathomheart Gauntlets
                { 7, 27805 }, -- Ring of the Silver Hand
                { 16, 27738 }, -- Incanter's Pauldrons
                { 17, 27737 }, -- Moonglade Shoulders
                { 18, 27801 }, -- Beast Lord Mantle
                { 19, 27510 }, -- Tidefury Gauntlets
                { 20, 27874 }, -- Beast Lord Leggings
                { 21, 28203 }, -- Breastplate of the Righteous
                { 22, 27475 }, -- Gauntlets of the Bold
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30543 }, -- Pontifex Kilt
                { 3, 29243 }, -- Wave-Fury Vambraces
                { 4, 29463 }, -- Amber Bands of the Aggressor
                { 5, 29351 }, -- Wrathtide Longbow
                { 7, 27804 }, -- Devilshark Cape
                { 8, 27799 }, -- Vermillion Robes of the Dominant
                { 9, 27795 }, -- Sash of Serpentra
                { 10, 27806 }, -- Fathomheart Gauntlets
                { 11, 27805 }, -- Ring of the Silver Hand
                { 13, 31721 }, -- Kalithresh's Trident
                { 14, 33827 }, -- The Warlord's Treatise
                { 16, 24313 }, -- Pattern: Battlecast Hood
                { 17, 30550 }, -- Sundered Chrysoprase
                { 18, 30551 }, -- Infused Fire Opal
                { 19, 30549 }, -- Shifting Tanzanite
                { 22, 27738 }, -- Incanter's Pauldrons
                { 23, 27737 }, -- Moonglade Shoulders
                { 24, 27801 }, -- Beast Lord Mantle
                { 25, 27510 }, -- Tidefury Gauntlets
                { 26, 27874 }, -- Beast Lord Leggings
                { 27, 28203 }, -- Breastplate of the Righteous
                { 28, 27475 }, -- Gauntlets of the Bold
            }
        },
        { -- CFRSteamTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 24159 }, -- Design: Khorium Band of Frost
                { 3, 22533 }, -- Formula: Enchant Bracer - Fortitude
                { 5, 24367 }, -- Orders from Lady Vashj
                { 6, 24368 }, -- Coilfang Armaments
            }
        },
        KEYS
    }
}

data["OldHillsbradFoothills"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 2367,
	InstanceID = 560,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CoTOldHillsbrad",
	AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {63, 66, 70},
	items = {
        { -- CoTHillsbradDrake
            name = AL["Lieutenant Drake"],
            npcID = {17848,20535},
            Level = 68,
            DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 27423 }, -- Cloak of Impulsiveness
                { 2, 27418 }, -- Stormreaver Shadow-Kilt
                { 3, 27417 }, -- Ravenwing Pauldrons
                { 4, 27420 }, -- Uther's Ceremonial Warboots
                { 5, 27436 }, -- Iron Band of the Unbreakable
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30589 }, -- Dazzling Chrysoprase
                { 3, 30591 }, -- Empowered Fire Opal
                { 4, 30590 }, -- Enduring Chrysoprase
                { 6, 28212 }, -- Aran's Sorcerous Slacks
                { 7, 28214 }, -- Grips of the Lunar Eclipse
                { 8, 28215 }, -- Mok'Nathal Mask of Battle
                { 9, 28211 }, -- Lieutenant's Signet of Lordaeron
                { 10, 28213 }, -- Lordaeron Medical Guide
                { 11, 28210 }, -- Bloodskull Destroyer
            }
        },
        { -- CoTHillsbradSkarloc
            name = AL["Captain Skarloc"],
            npcID = {17862,20521},
            Level = 68,
            DisplayIDs = {{17387}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 27428 }, -- Stormfront Gauntlets
                { 2, 27430 }, -- Scaled Greaves of Patience
                { 3, 27427 }, -- Durotan's Battle Harness
                { 4, 27424 }, -- Amani Venom-Axe
                { 5, 27426 }, -- Northshire Battlemace
                { 7, 21524 }, -- Red Winter Hat
                { 9, 22927 }, -- Recipe: Ironshield Potion
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30589 }, -- Dazzling Chrysoprase
                { 3, 30591 }, -- Empowered Fire Opal
                { 4, 30590 }, -- Enduring Chrysoprase
                { 6, 28218 }, -- Pontiff's Pantaloons of Prophecy
                { 7, 28220 }, -- Moon-Crown Antlers
                { 8, 28219 }, -- Emerald-Scale Greaves
                { 9, 28221 }, -- Boots of the Watchful Heart
                { 10, 28217 }, -- Tarren Mill Vitality Locket
                { 11, 28216 }, -- Dathrohan's Ceremonial Hammer
                { 13, 21524 }, -- Red Winter Hat
                { 15, 22927 }, -- Recipe: Ironshield Potion
            }
        },
        { -- CoTHillsbradHunter
            name = AL["Epoch Hunter"],
            npcID = {18096,20531},
            Level = 68,
            DisplayIDs = {{19135}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24173 }, -- Design: Circlet of Arcane Might
                { 3, 27433 }, -- Pauldrons of Sufferance
                { 4, 27434 }, -- Mantle of Perenolde
                { 5, 27440 }, -- Diamond Prism of Recurrence
                { 6, 27432 }, -- Broxigar's Ring of Valor
                { 7, 27431 }, -- Time-Shifted Dagger
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29250 }, -- Cord of Sanctification
                { 3, 29246 }, -- Nightfall Wristguards
                { 4, 30534 }, -- Wyrmscale Greaves
                { 5, 30536 }, -- Greaves of the Martyr
                { 6, 27911 }, -- Epoch's Whispering Cinch
                { 7, 28344 }, -- Wyrmfury Pauldrons
                { 10, 28233 }, -- Necklace of Resplendent Hope
                { 11, 27904 }, -- Resounding Ring of Glory
                { 12, 28227 }, -- Sparking Arcanite Ring
                { 13, 28223 }, -- Arcanist's Stone
                { 14, 28226 }, -- Timeslicer
                { 15, 28222 }, -- Reaver of the Infinites
                { 16, 30589 }, -- Dazzling Chrysoprase
                { 17, 30591 }, -- Empowered Fire Opal
                { 18, 30590 }, -- Enduring Chrysoprase
                { 20, 24173 }, -- Design: Circlet of Arcane Might
                { 23, 28191 }, -- Mana-Etched Vestments
                { 24, 28224 }, -- Wastewalker Helm
                { 25, 28401 }, -- Hauberk of Desolation
                { 26, 28225 }, -- Doomplate Warhelm
                { 28, 33847 }, -- Epoch Hunter's Head
            }
        },
        { -- CoTHillsbradDonCarlos
            name = AL["Don Carlos"],
            npcID = {28132,28171},
            Level = 68,
            DisplayIDs = {{25124}},
            ExtraList = true,
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 38276 }, -- Haliscan Brimmed Hat
                { 16, 38329 }, -- Don Carlos' Hat
            },
            [HEROIC_DIFF] = {
                { 1, 38506 }, -- Don Carlos' Famous Hat
                { 3, 38276 }, -- Haliscan Brimmed Hat
                { 16, 38329 }, -- Don Carlos' Hat
            }
        },
        { -- CoTHillsbradAgedDalaranWizard
            name = AL["Aged Dalaran Wizard"],
            npcID = 18664,
            DisplayIDs = {{18}},
            ExtraList = true,
            specialType = "vendor",
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 22539, [PRICE_EXTRA_ITTYPE] = "money:60000" }, -- Formula: Enchant Shield - Intellect
            }
        },
        { -- CoTHillsbradThomasYance
            name = AL["Thomas Yance"],
            npcID = 18672,
            DisplayIDs = {{18064}},
            ExtraList = true,
            specialType = "vendor",
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 25725, [PRICE_EXTRA_ITTYPE] = "money:50000" }, -- Pattern: Riding Crop
            }
        },
        { -- CoTHillsbradTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 25729 }, -- Pattern: Stylin' Adventure Hat
            }
        },
        KEYS
    }
}

data["TheBlackMorass"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 2366,
	InstanceID = 269,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CoTBlackMorass",
	AtlasMapFile = {"CoTBlackMorass", "CavernsOfTimeEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 68, 70},
	items = {
        { -- CoTMorassDeja
            name = AL["Chrono Lord Deja"],
            npcID = {17879,20738},
            Level = 72,
            DisplayIDs = {{20513}},
            -- AtlasMapBossID = "Wave 6",
            [NORMAL_DIFF] = {
                { 1, 27988 }, -- Burnoose of Shifting Ages
                { 2, 27994 }, -- Mantle of Three Terrors
                { 3, 27995 }, -- Sun-Gilded Shouldercaps
                { 4, 27993 }, -- Mask of Inner Fire
                { 5, 27996 }, -- Ring of Spiritual Precision
                { 6, 27987 }, -- Melmorta's Twilight Longbow
                { 8, 29675 }, -- Pattern: Arcane Armor Kit
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30558 }, -- Glimmering Fire Opal
                { 3, 30556 }, -- Glinting Fire Opal
                { 4, 30555 }, -- Glowing Tanzanite
                { 6, 27988 }, -- Burnoose of Shifting Ages
                { 7, 27994 }, -- Mantle of Three Terrors
                { 8, 27995 }, -- Sun-Gilded Shouldercaps
                { 9, 27993 }, -- Mask of Inner Fire
                { 10, 27996 }, -- Ring of Spiritual Precision
                { 11, 27987 }, -- Melmorta's Twilight Longbow
                { 13, 29675 }, -- Pattern: Arcane Armor Kit
            }
        },
        { -- CoTMorassTemporus
            name = AL["Temporus"],
            npcID = {17880,20745},
            Level = 72,
            DisplayIDs = {{19066}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 28185 }, -- Khadgar's Kilt of Abjuration
                { 2, 28186 }, -- Laughing Skull Battle-Harness
                { 3, 28034 }, -- Hourglass of the Unraveller
                { 4, 28187 }, -- Star-Heart Lamp
                { 5, 28184 }, -- Millennium Blade
                { 6, 28033 }, -- Epoch-Mender
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30558 }, -- Glimmering Fire Opal
                { 3, 30556 }, -- Glinting Fire Opal
                { 4, 30555 }, -- Glowing Tanzanite
                { 6, 28185 }, -- Khadgar's Kilt of Abjuration
                { 7, 28186 }, -- Laughing Skull Battle-Harness
                { 8, 28034 }, -- Hourglass of the Unraveller
                { 9, 28187 }, -- Star-Heart Lamp
                { 10, 28184 }, -- Millennium Blade
                { 11, 28033 }, -- Epoch-Mender
            }
        },
        { -- CoTMorassAeonus
            name = AL["Aeonus"],
            npcID = {17881,20737},
            Level = 72,
            DisplayIDs = {{20510}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 28206 }, -- Cowl of the Guiltless
                { 2, 28194 }, -- Primal Surge Bracers
                { 3, 28207 }, -- Pauldrons of the Crimson Flight
                { 4, 28190 }, -- Scarab of the Infinite Cycle
                { 5, 28189 }, -- Latro's Shifting Sword
                { 6, 28188 }, -- Bloodfire Greatstaff
                { 16, 28193 }, -- Mana-Etched Crown
                { 17, 27509 }, -- Handgrips of Assassination
                { 18, 27873 }, -- Moonglade Pants
                { 19, 28192 }, -- Helm of Desolation
                { 20, 27977 }, -- Legplates of the Bold
                { 21, 27839 }, -- Legplates of the Righteous
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30531 }, -- Breeches of the Occultist
                { 3, 29247 }, -- Girdle of the Deathdealer
                { 4, 29253 }, -- Girdle of Valorous Deeds
                { 5, 29356 }, -- Quantum Blade
                { 7, 28206 }, -- Cowl of the Guiltless
                { 8, 28194 }, -- Primal Surge Bracers
                { 9, 28207 }, -- Pauldrons of the Crimson Flight
                { 10, 28190 }, -- Scarab of the Infinite Cycle
                { 11, 28189 }, -- Latro's Shifting Sword
                { 12, 28188 }, -- Bloodfire Greatstaff
                { 14, 33858 }, -- Aeonus's Hourglass
                { 16, 30558 }, -- Glimmering Fire Opal
                { 17, 30556 }, -- Glinting Fire Opal
                { 18, 30555 }, -- Glowing Tanzanite
                { 22, 28193 }, -- Mana-Etched Crown
                { 23, 27509 }, -- Handgrips of Assassination
                { 24, 27873 }, -- Moonglade Pants
                { 25, 28192 }, -- Helm of Desolation
                { 26, 27977 }, -- Legplates of the Bold
                { 27, 27839 }, -- Legplates of the Righteous
            }
        },
        { -- CoTMorassTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 25730 }, -- Pattern: Stylin' Jungle Hat
            }
        },
        KEYS
    }
}

data["TheArcatraz"] = {
    nameFormat = NAME_TEMPEST_KEEP,
	MapID = 3848,
	InstanceID = 552,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_TempestKeepArcatraz",
	AtlasMapFile = {"CL_TempestKeepArcatraz", "TempestKeepEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- TKArcUnbound
            name = AL["Zereketh the Unbound"],
            npcID = {20870,21626},
            Level = 72,
            DisplayIDs = {{19882}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 28373 }, -- Cloak of Scintillating Auras
                { 2, 28374 }, -- Mana-Sphere Shoulderguards
                { 3, 28384 }, -- Outland Striders
                { 4, 28375 }, -- Rubium War-Girdle
                { 5, 28372 }, -- Idol of Feral Shadows
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30582 }, -- Deadly Fire Opal
                { 3, 30575 }, -- Nimble Fire Opal
                { 4, 30581 }, -- Durable Fire Opal
                { 6, 28373 }, -- Cloak of Scintillating Auras
                { 7, 28374 }, -- Mana-Sphere Shoulderguards
                { 8, 28384 }, -- Outland Striders
                { 9, 28375 }, -- Rubium War-Girdle
                { 10, 28372 }, -- Idol of Feral Shadows
            }
        },
        { -- TKArcDalliah
            name = AL["Dalliah the Doomsayer"],
            npcID = {20885,21590},
            Level = 72,
            DisplayIDs = {{19888}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24308 }, -- Pattern: Whitemend Pants
                { 3, 28391 }, -- Worldfire Chestguard
                { 4, 28390 }, -- Thatia's Self-Correcting Gauntlets
                { 5, 28387 }, -- Lamp of Peaceful Repose
                { 6, 28392 }, -- Reflex Blades
                { 7, 28386 }, -- Nether Core's Control Rod
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30582 }, -- Deadly Fire Opal
                { 3, 30575 }, -- Nimble Fire Opal
                { 4, 30581 }, -- Durable Fire Opal
                { 6, 28391 }, -- Worldfire Chestguard
                { 7, 28390 }, -- Thatia's Self-Correcting Gauntlets
                { 8, 28387 }, -- Lamp of Peaceful Repose
                { 9, 28392 }, -- Reflex Blades
                { 10, 28386 }, -- Nether Core's Control Rod
                { 16, 24308 }, -- Pattern: Whitemend Pants
            }
        },
        { -- TKArcScryer
            name = AL["Wrath-Scryer Soccothrates"],
            npcID = {20886,21624},
            Level = 72,
            DisplayIDs = {{19977}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 28396 }, -- Gloves of the Unbound
                { 2, 28398 }, -- The Sleeper's Cord
                { 3, 28394 }, -- Ryngo's Band of Ingenuity
                { 4, 28393 }, -- Warmaul of Infused Light
                { 5, 28397 }, -- Emberhawk Crossbow
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30582 }, -- Deadly Fire Opal
                { 3, 30575 }, -- Nimble Fire Opal
                { 4, 30581 }, -- Durable Fire Opal
                { 6, 28396 }, -- Gloves of the Unbound
                { 7, 28398 }, -- The Sleeper's Cord
                { 8, 28394 }, -- Ryngo's Band of Ingenuity
                { 9, 28393 }, -- Warmaul of Infused Light
                { 10, 28397 }, -- Emberhawk Crossbow
            }
        },
        { -- TKArcHarbinger
            name = AL["Harbinger Skyriss"],
            npcID = {20912,21599},
            Level = 72,
            DisplayIDs = {{19943}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 28406 }, -- Sigil-Laced Boots
                { 2, 28419 }, -- Choker of Fluid Thought
                { 3, 28407 }, -- Elementium Band of the Sentry
                { 4, 28418 }, -- Shiffar's Nexus-Horn
                { 5, 28412 }, -- Lamp of Peaceful Radiance
                { 6, 28416 }, -- Hungering Spineripper
                { 16, 28415 }, -- Hood of Oblivion
                { 17, 28413 }, -- Hallowed Crown
                { 18, 28414 }, -- Helm of Assassination
                { 19, 28231 }, -- Tidefury Chestpiece
                { 20, 28403 }, -- Doomplate Chestguard
                { 21, 28205 }, -- Breastplate of the Bold
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29241 }, -- Belt of Depravity
                { 3, 29248 }, -- Shadowstep Striders
                { 4, 29252 }, -- Bracers of Dignity
                { 5, 29360 }, -- Vileblade of the Betrayer
                { 7, 28406 }, -- Sigil-Laced Boots
                { 8, 28419 }, -- Choker of Fluid Thought
                { 9, 28407 }, -- Elementium Band of the Sentry
                { 10, 28418 }, -- Shiffar's Nexus-Horn
                { 11, 28412 }, -- Lamp of Peaceful Radiance
                { 12, 28416 }, -- Hungering Spineripper
                { 14, 33861 }, -- The Scroll of Skyriss
                { 16, 30582 }, -- Deadly Fire Opal
                { 17, 30575 }, -- Nimble Fire Opal
                { 18, 30581 }, -- Durable Fire Opal
                { 22, 28415 }, -- Hood of Oblivion
                { 23, 28413 }, -- Hallowed Crown
                { 24, 28414 }, -- Helm of Assassination
                { 25, 28231 }, -- Tidefury Chestpiece
                { 26, 28403 }, -- Doomplate Chestguard
                { 27, 28205 }, -- Breastplate of the Bold
            }
        },
        { -- TKArcThirdFragmentGuardian
            name = AL["Third Fragment Guardian"],
            npcID = 22892,
            Level = 70,
            DisplayIDs = {{19113}},
            ExtraList = true,
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 24488 }, -- Third Key Fragment
            }
        },
        { -- TKArcTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 23606 }, -- Plans: Felsteel Leggings
                { 3, 22556 }, -- Formula: Enchant 2H Weapon - Major Agility
                { 4, 29672 }, -- Pattern: Flame Armor Kit
                { 5, 21905 }, -- Pattern: Arcanoweave Bracers
            }
        },
        KEYS
    }
}

data["TheBotanica"] = {
    nameFormat = NAME_TEMPEST_KEEP,
	MapID = 3847,
	InstanceID = 553,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_TempestKeepBotanica",
	AtlasMapFile = {"CL_TempestKeepBotanica", "TempestKeepEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- TKBotSarannis
            name = AL["Commander Sarannis"],
            npcID = {17976,21551},
            Level = 72,
            DisplayIDs = {{18929}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 28301 }, -- Syrannis' Mystic Sheen
                { 2, 28304 }, -- Prismatic Mittens of Mending
                { 3, 28306 }, -- Towering Mantle of the Hunt
                { 4, 28296 }, -- Libram of the Lightbringer
                { 5, 28311 }, -- Revenger
                { 7, 28769 }, -- The Keystone
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30574 }, -- Brutal Tanzanite
                { 3, 30572 }, -- Imperial Tanzanite
                { 4, 30573 }, -- Mysterious Fire Opal
                { 6, 28301 }, -- Syrannis' Mystic Sheen
                { 7, 28304 }, -- Prismatic Mittens of Mending
                { 8, 28306 }, -- Towering Mantle of the Hunt
                { 9, 28296 }, -- Libram of the Lightbringer
                { 10, 28311 }, -- Revenger
            }
        },
        { -- TKBotFreywinn
            name = AL["High Botanist Freywinn"],
            npcID = {17975,21558},
            Level = 72,
            DisplayIDs = {{19045}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 28317 }, -- Energis Armwraps
                { 2, 28318 }, -- Obsidian Clodstompers
                { 3, 28321 }, -- Enchanted Thorium Torque
                { 4, 28315 }, -- Stormreaver Warblades
                { 5, 28316 }, -- Aegis of the Sunbird
                { 7, 23617 }, -- Plans: Earthpeace Breastplate
                { 9, 21524 }, -- Red Winter Hat
                { 11, 31744 }, -- Botanist's Field Guide
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30574 }, -- Brutal Tanzanite
                { 3, 30572 }, -- Imperial Tanzanite
                { 4, 30573 }, -- Mysterious Fire Opal
                { 6, 28317 }, -- Energis Armwraps
                { 7, 28318 }, -- Obsidian Clodstompers
                { 8, 28321 }, -- Enchanted Thorium Torque
                { 9, 28315 }, -- Stormreaver Warblades
                { 10, 28316 }, -- Aegis of the Sunbird
                { 12, 21524 }, -- Red Winter Hat
                { 16, 23617 }, -- Plans: Earthpeace Breastplate
                { 18, 31744 }, -- Botanist's Field Guide
            }
        },
        { -- TKBotThorngrin
            name = AL["Thorngrin the Tender"],
            npcID = {17978,21581},
            Level = 72,
            DisplayIDs = {{14416}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 24310 }, -- Pattern: Battlecast Pants
                { 3, 28324 }, -- Gauntlets of Cruel Intention
                { 4, 28327 }, -- Arcane Netherband
                { 5, 28323 }, -- Ring of Umbral Doom
                { 6, 28322 }, -- Runed Dagger of Solace
                { 7, 28325 }, -- Dreamer's Dragonstaff
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30574 }, -- Brutal Tanzanite
                { 3, 30572 }, -- Imperial Tanzanite
                { 4, 30573 }, -- Mysterious Fire Opal
                { 5, 24310 }, -- Pattern: Battlecast Pants
                { 7, 28324 }, -- Gauntlets of Cruel Intention
                { 8, 28327 }, -- Arcane Netherband
                { 9, 28323 }, -- Ring of Umbral Doom
                { 10, 28322 }, -- Runed Dagger of Solace
                { 11, 28325 }, -- Dreamer's Dragonstaff
            }
        },
        { -- TKBotLaj
            name = AL["Laj"],
            npcID = {17980,21559},
            Level = 72,
            DisplayIDs = {{13109}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 28328 }, -- Mithril-Bark Cloak
                { 2, 28338 }, -- Devil-Stitched Leggings
                { 3, 28340 }, -- Mantle of Autumn
                { 4, 28339 }, -- Boots of the Shifting Sands
                { 16, 27739 }, -- Spaulders of the Righteous
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30574 }, -- Brutal Tanzanite
                { 3, 30572 }, -- Imperial Tanzanite
                { 4, 30573 }, -- Mysterious Fire Opal
                { 6, 28328 }, -- Mithril-Bark Cloak
                { 7, 28338 }, -- Devil-Stitched Leggings
                { 8, 28340 }, -- Mantle of Autumn
                { 9, 28339 }, -- Boots of the Shifting Sands
                { 21, 27739 }, -- Spaulders of the Righteous
            }
        },
        { -- TKBotSplinter
            name = AL["Warp Splinter"],
            npcID = {17977,21582},
            Level = 72,
            DisplayIDs = {{19438}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 24311 }, -- Pattern: Whitemend Hood
                { 3, 28371 }, -- Netherfury Cape
                { 4, 28342 }, -- Warp Infused Drape
                { 5, 28347 }, -- Warpscale Leggings
                { 6, 28343 }, -- Jagged Bark Pendant
                { 7, 28370 }, -- Bangle of Endless Blessings
                { 8, 28345 }, -- Warp Splinter's Thorn
                { 9, 28367 }, -- Greatsword of Forlorn Visions
                { 10, 28341 }, -- Warpstaff of Arcanum
                { 12, 31085 }, -- Top Shard of the Arcatraz Key
                { 16, 28229 }, -- Incanter's Robe
                { 17, 28348 }, -- Moonglade Cowl
                { 18, 28349 }, -- Tidefury Helm
                { 19, 28228 }, -- Beast Lord Cuirass
                { 20, 28350 }, -- Warhelm of the Bold
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29258 }, -- Boots of Ethereal Manipulation
                { 3, 29262 }, -- Boots of the Endless Hunt
                { 4, 32072 }, -- Gauntlets of Dissension
                { 5, 29359 }, -- Feral Staff of Lashing
                { 7, 28371 }, -- Netherfury Cape
                { 8, 28342 }, -- Warp Infused Drape
                { 9, 28347 }, -- Warpscale Leggings
                { 10, 28343 }, -- Jagged Bark Pendant
                { 11, 28370 }, -- Bangle of Endless Blessings
                { 12, 28345 }, -- Warp Splinter's Thorn
                { 13, 28367 }, -- Greatsword of Forlorn Visions
                { 14, 28341 }, -- Warpstaff of Arcanum
                { 16, 30574 }, -- Brutal Tanzanite
                { 17, 30572 }, -- Imperial Tanzanite
                { 18, 30573 }, -- Mysterious Fire Opal
                { 20, 24311 }, -- Pattern: Whitemend Hood
                { 22, 28229 }, -- Incanter's Robe
                { 23, 28348 }, -- Moonglade Cowl
                { 24, 28349 }, -- Tidefury Helm
                { 25, 28228 }, -- Beast Lord Cuirass
                { 26, 28350 }, -- Warhelm of the Bold
                { 28, 31085 }, -- Top Shard of the Arcatraz Key
                { 29, 33859 }, -- Warp Splinter Clipping
            }
        },
        { -- TKBotTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 24172 }, -- Design: Coronet of Verdant Flame
            }
        },
        KEYS
    }
}

data["TheMechanar"] = {
    nameFormat = NAME_TEMPEST_KEEP,
	MapID = 3849,
	InstanceID = 554,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_TempestKeepMechanar",
	AtlasMapFile = {"CL_TempestKeepMechanar", "TempestKeepEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 68, 70},
	items = {
        { -- TKMechCapacitus
            name = AL["Mechano-Lord Capacitus"],
            npcID = {19219,21533},
            Level = 72,
            DisplayIDs = {{19162}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 28256 }, -- Thoriumweave Cloak
                { 2, 28255 }, -- Lunar-Claw Pauldrons
                { 3, 28254 }, -- Warp Engineer's Prismatic Chain
                { 4, 28257 }, -- Hammer of the Penitent
                { 5, 28253 }, -- Plasma Rat's Hyper-Scythe
                { 16, 35582 }, -- Schematic: Rocket Boots Xtreme Lite
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30565 }, -- Assassin's Fire Opal
                { 3, 30566 }, -- Defender's Tanzanite
                { 4, 30564 }, -- Shining Fire Opal
                { 6, 28256 }, -- Thoriumweave Cloak
                { 7, 28255 }, -- Lunar-Claw Pauldrons
                { 8, 28254 }, -- Warp Engineer's Prismatic Chain
                { 9, 28257 }, -- Hammer of the Penitent
                { 10, 28253 }, -- Plasma Rat's Hyper-Scythe
                { 16, 35582 }, -- Schematic: Rocket Boots Xtreme Lite
            }
        },
        { -- TKMechSepethrea
            name = AL["Nethermancer Sepethrea"],
            npcID = {19221,21536},
            Level = 72,
            DisplayIDs = {{19166}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 28262 }, -- Jade-Skull Breastplate
                { 2, 28259 }, -- Cosmic Lifeband
                { 3, 28260 }, -- Manual of the Nethermancer
                { 4, 28263 }, -- Stellaris
                { 5, 28258 }, -- Nethershrike
                { 7, 21524 }, -- Red Winter Hat
                { 16, 22920 }, -- Recipe: Major Fire Protection Potion
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 30565 }, -- Assassin's Fire Opal
                { 3, 30566 }, -- Defender's Tanzanite
                { 4, 30564 }, -- Shining Fire Opal
                { 6, 28262 }, -- Jade-Skull Breastplate
                { 7, 28259 }, -- Cosmic Lifeband
                { 8, 28260 }, -- Manual of the Nethermancer
                { 9, 28263 }, -- Stellaris
                { 10, 28258 }, -- Nethershrike
                { 12, 21524 }, -- Red Winter Hat
                { 16, 22920 }, -- Recipe: Major Fire Protection Potion
            }
        },
        { -- TKMechCalc
            name = AL["Pathaleon the Calculator"],
            npcID = {19220,21537},
            Level = 72,
            DisplayIDs = {{20033}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 28269 }, -- Baba's Cloak of Arcanistry
                { 2, 28266 }, -- Molten Earth Kilt
                { 3, 28265 }, -- Dath'Remar's Ring of Defense
                { 4, 28288 }, -- Abacus of Violent Odds
                { 5, 27899 }, -- Mana Wrath
                { 6, 28267 }, -- Edge of the Cosmos
                { 7, 28286 }, -- Telescopic Sharprifle
                { 9, 21907 }, -- Pattern: Arcanoweave Robe
                { 11, 31086 }, -- Bottom Shard of the Arcatraz Key
                { 16, 28278 }, -- Incanter's Cowl
                { 17, 28202 }, -- Moonglade Robe
                { 18, 28204 }, -- Tunic of Assassination
                { 19, 28275 }, -- Beast Lord Helm
                { 20, 28285 }, -- Helm of the Righteous
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 29251 }, -- Boots of the Pious
                { 3, 32076 }, -- Handguards of the Steady
                { 4, 30533 }, -- Vanquisher's Legplates
                { 5, 29362 }, -- The Sun Eater
                { 7, 28269 }, -- Baba's Cloak of Arcanistry
                { 8, 28266 }, -- Molten Earth Kilt
                { 9, 28265 }, -- Dath'Remar's Ring of Defense
                { 10, 28288 }, -- Abacus of Violent Odds
                { 11, 27899 }, -- Mana Wrath
                { 12, 28267 }, -- Edge of the Cosmos
                { 13, 28286 }, -- Telescopic Sharprifle
                { 15, 21907 }, -- Pattern: Arcanoweave Robe
                { 16, 30565 }, -- Assassin's Fire Opal
                { 17, 30566 }, -- Defender's Tanzanite
                { 18, 30564 }, -- Shining Fire Opal
                { 22, 28278 }, -- Incanter's Cowl
                { 23, 28202 }, -- Moonglade Robe
                { 24, 28204 }, -- Tunic of Assassination
                { 25, 28275 }, -- Beast Lord Helm
                { 26, 28285 }, -- Helm of the Righteous
                { 28, 33860 }, -- Pathaleon's Projector
                { 29, 31086 }, -- Bottom Shard of the Arcatraz Key
            }
        },
        { -- TKMechCacheoftheLegion
            name = AL["Cache of the Legion"],
            ObjectID = 184465,
            ExtraList = true,
            AtlasMapBossID = 2,
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 3, 28249 }, -- Capacitus' Cloak of Calibration
                { 4, 28250 }, -- Vestia's Pauldrons of Inner Grace
                { 5, 28252 }, -- Bloodfyre Robes of Annihilation
                { 6, 28251 }, -- Boots of the Glade-Keeper
                { 7, 28248 }, -- Totem of the Void
            }
        },
        { -- TKMechGyro
            name = AL["Gatewatcher Gyro-Kill"],
            npcID = {19218,21525},
            Level = 72,
            DisplayIDs = {{18816}},
            ExtraList = true,
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 30436 }, -- Jagged Blue Crystal
            }
        },
        { -- TKMechIron
            name = AL["Gatewatcher Iron-Hand"],
            npcID = {19710,21526},
            Level = 72,
            DisplayIDs = {{21191}},
            ExtraList = true,
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30437 }, -- Jagged Red Crystal
            }
        },
        { -- TKMechOverchargedManacell
            name = AL["Overcharged Manacell"],
            ObjectID = 185015,
            ExtraList = true,
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 30824 }, -- Overcharged Manacell
            }
        },
        { -- TKMechTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 22920 }, -- Recipe: Major Fire Protection Potion
                { 2, 21906 }, -- Pattern: Arcanoweave Boots
            }
        },
    }
}

data["MagistersTerrace"] = {
	MapID = 4131,
	InstanceID = 585,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_MagistersTerrace",
	AtlasMapFile = "CL_MagistersTerrace",
	ContentType = DUNGEON_CONTENT,
    ContentPhaseBC = 5,
	LevelRange = {65, 69, 70},
	items = {
        { -- SMTFireheart
            name = AL["Selin Fireheart"],
            npcID = {24723, 25562},
            Level = 71,
            DisplayIDs = {{22642}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 34702 }, -- Cloak of Swift Mending
                { 2, 34697 }, -- Bindings of Raging Fire
                { 3, 34701 }, -- Leggings of the Betrayed
                { 4, 34698 }, -- Bracers of the Forest Stalker
                { 5, 34700 }, -- Gauntlets of Divine Blessings
                { 6, 34699 }, -- Sun-forged Cleaver
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 34602 }, -- Eversong Cuffs
                { 3, 34601 }, -- Shoulderplates of Everlasting Pain
                { 4, 34604 }, -- Jaded Crystal Dagger
                { 5, 34603 }, -- Distracting Blades
                { 16, 35275 }, -- Orb of the Sin'dorei
            }
        },
        { -- SMTVexallus
            name = AL["Vexallus"],
            npcID = {24744, 25573},
            Level = 71,
            DisplayIDs = {{22731}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 34708 }, -- Cloak of the Coming Night
                { 2, 34705 }, -- Bracers of Divine Infusion
                { 3, 34707 }, -- Boots of Resuscitation
                { 4, 34704 }, -- Band of Arcane Alacrity
                { 5, 34706 }, -- Band of Determination
                { 6, 34703 }, -- Latro's Dancing Blade
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 34607 }, -- Fel-tinged Mantle
                { 3, 34605 }, -- Breastplate of Fierce Survival
                { 4, 34606 }, -- Edge of Oppression
                { 5, 34608 }, -- Rod of the Blazing Light
                { 16, 35275 }, -- Orb of the Sin'dorei
            }
        },
        { -- SMTDelrissa
            name = AL["Priestess Delrissa"],
            npcID = {24560, 25560},
            Level = 70,
            DisplayIDs = {{22596},{22540},{22542},{22539},{20986},{22598},{2007},{22541},{17457}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 34792 }, -- Cloak of the Betrayed
                { 2, 34788 }, -- Duskhallow Mantle
                { 3, 34791 }, -- Gauntlets of the Tranquil Waves
                { 4, 34789 }, -- Bracers of Slaughter
                { 5, 34790 }, -- Battle-mace of the High Priestess
                { 6, 34783 }, -- Nightstrike
                { 16, 35756 }, -- Formula: Enchant Cloak - Steelweave
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 34473 }, -- Commendation of Kael'thas
                { 3, 34471 }, -- Vial of the Sunwell
                { 4, 34470 }, -- Timbal's Focusing Crystal
                { 5, 34472 }, -- Shard of Contempt
                { 16, 35275 }, -- Orb of the Sin'dorei
                { 18, 35756 }, -- Formula: Enchant Cloak - Steelweave
            }
        },
        { -- SMTKaelthas
            name = AL["Kael'thas Sunstrider"],
            npcID = {24664,24857},
            Level = 72,
            DisplayIDs = {{22906}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 34810 }, -- Cloak of Blade Turning
                { 2, 34808 }, -- Gloves of Arcane Acuity
                { 3, 34809 }, -- Sunrage Treads
                { 4, 34799 }, -- Hauberk of the War Bringer
                { 5, 34807 }, -- Sunstrider Warboots
                { 6, 34625 }, -- Kharmaa's Ring of Fate
                { 8, 34793 }, -- Cord of Reconstruction
                { 9, 34796 }, -- Robes of Summer Flame
                { 10, 34795 }, -- Helm of Sanctification
                { 11, 34798 }, -- Band of Celerity
                { 12, 34794 }, -- Axe of Shattered Dreams
                { 13, 34797 }, -- Sun-infused Focus Staff
                { 16, 35504 }, -- Phoenix Hatchling
                { 18, 35311 }, -- Schematic: Mana Potion Injector
                { 19, 35304 }, -- Design: Solid Star of Elune
                { 20, 35294 }, -- Recipe: Elixir of Empowerment
                { 22, 34157 }, -- Head of Kael'thas
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 34610 }, -- Scarlet Sin'dorei Robes
                { 3, 34613 }, -- Shoulderpads of the Silvermoon Retainer
                { 4, 34614 }, -- Tunic of the Ranger Lord
                { 5, 34615 }, -- Netherforce Chestplate
                { 6, 34612 }, -- Greaves of the Penitent Knight
                { 7, 34611 }, -- Cudgel of Consecration
                { 8, 34609 }, -- Quickening Blade of the Prince
                { 9, 34616 }, -- Breeching Comet
                { 16, 35513 }, -- Swift White Hawkstrider
                { 18, 35504 }, -- Phoenix Hatchling
                { 20, 35311 }, -- Schematic: Mana Potion Injector
                { 21, 35304 }, -- Design: Solid Star of Elune
                { 22, 35294 }, -- Recipe: Elixir of Empowerment
            }
        },
        { -- SMTTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35516 }, -- Sun Touched Satchel
            }
        },
        KEYS
    }
}

local KARA_MAPDATA_END = {"CL_KarazhanEnd", "CL_KarazhanEnt"}
data["Karazhan"] = {
	MapID = 3457,
	InstanceID = 532,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_KarazhanStart",
	AtlasMapFile = {"CL_KarazhanStart", "CL_KarazhanEnt"},
	ContentType = RAID10_CONTENT,
	items = {
        { -- KaraAttumen
            name = AL["Attumen the Huntsman"],
            npcID = 16152,
            Level = 999,
            DisplayIDs = {{16040}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 28477 }, -- Harbinger Bands
                { 2, 28507 }, -- Handwraps of Flowing Thought
                { 3, 28508 }, -- Gloves of Saintly Blessings
                { 4, 28453 }, -- Bracers of the White Stag
                { 5, 28506 }, -- Gloves of Dexterous Manipulation
                { 6, 28503 }, -- Whirlwind Bracers
                { 7, 28454 }, -- Stalker's War Bands
                { 8, 28502 }, -- Vambraces of Courage
                { 9, 28505 }, -- Gauntlets of Renewed Hope
                --{ 11, 29434 }, -- Badge of Justice
                { 16, 28509 }, -- Worgen Claw Necklace
                { 17, 28510 }, -- Spectral Band of Innervation
                { 18, 28504 }, -- Steelhawk Crossbow
                { 20, 30480 }, -- Fiery Warhorse's Reins
                { 22, 23809 }, -- Schematic: Stabilized Eternium Scope
            }
        },
        { -- KaraNamed
            name = AL["Rokad the Ravager"],
            nameFormat = NAME_KARA_QUARTERS,
            npcID = 16181,
            Level = 999,
            DisplayIDs = {{16054}},
            specialType = "rare",
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30684 }, -- Ravager's Cuffs
                { 2, 30685 }, -- Ravager's Wrist-Wraps
                { 3, 30686 }, -- Ravager's Bands
                { 4, 30687 }, -- Ravager's Bracers
            }
        },
        { -- KaraNamed
            name = AL["Shadikith the Glider"],
            nameFormat = NAME_KARA_QUARTERS,
            npcID = 16180,
            Level = 999,
            DisplayIDs = {{16053}},
            specialType = "rare",
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30680 }, -- Glider's Foot-Wraps
                { 2, 30681 }, -- Glider's Boots
                { 3, 30682 }, -- Glider's Sabatons
                { 4, 30683 }, -- Glider's Greaves
            }
        },
        { -- KaraNamed
            name = AL["Hyakiss the Lurker"],
            nameFormat = NAME_KARA_QUARTERS,
            npcID = 16179,
            Level = 999,
            DisplayIDs = {{15938}},
            specialType = "rare",
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30675 }, -- Lurker's Cord
                { 2, 30676 }, -- Lurker's Grasp
                { 3, 30677 }, -- Lurker's Belt
                { 4, 30678 }, -- Lurker's Girdle
            }
        },
        { -- KaraMoroes
            name = AL["Moroes"],
            npcID = 15687,
            Level = 999,
            DisplayIDs = {{16540},{19327},{16637},{16640},{16639},{19328},{16638}},
            AtlasMapBossID = 7,
            [NORMAL_DIFF] = {
                { 1, 28529 }, -- Royal Cloak of Arathi Kings
                { 2, 28570 }, -- Shadow-Cloak of Dalaran
                { 3, 28565 }, -- Nethershard Girdle
                { 4, 28545 }, -- Edgewalker Longboots
                { 5, 28567 }, -- Belt of Gale Force
                { 6, 28566 }, -- Crimson Girdle of the Indomitable
                { 7, 28569 }, -- Boots of Valiance
                --{ 9, 29434 }, -- Badge of Justice
                { 16, 28530 }, -- Brooch of Unquenchable Fury
                { 17, 28528 }, -- Moroes' Lucky Pocket Watch
                { 18, 28525 }, -- Signet of Unshakable Faith
                { 19, 28568 }, -- Idol of the Avian Heart
                { 20, 28524 }, -- Emerald Ripper
                { 22, 22559 }, -- Formula: Enchant Weapon - Mongoose
            }
        },
        { -- KaraMaiden
            name = AL["Maiden of Virtue"],
            npcID = 16457,
            Level = 999,
            DisplayIDs = {{16198}},
            AtlasMapBossID = 11,
            [NORMAL_DIFF] = {
                { 1, 28511 }, -- Bands of Indwelling
                { 2, 28515 }, -- Bands of Nefarious Deeds
                { 3, 28517 }, -- Boots of Foretelling
                { 4, 28514 }, -- Bracers of Maliciousness
                { 5, 28521 }, -- Mitts of the Treemender
                { 6, 28520 }, -- Gloves of Centering
                { 7, 28519 }, -- Gloves of Quickening
                { 8, 28512 }, -- Bracers of Justice
                { 9, 28518 }, -- Iron Gauntlets of the Maiden
                --{ 11, 29434 }, -- Badge of Justice
                { 16, 28516 }, -- Barbed Choker of Discipline
                { 17, 28523 }, -- Totem of Healing Rains
                { 18, 28522 }, -- Shard of the Virtuous
            }
        },
        { -- KaraOperaEvent
            name = AL["The Wizard of Oz"],
            nameFormat = NAME_KARA_OPERA,
            npcID = {18168,17535,17548,17543,17547,17546},
            Level = 999,
            DisplayIDs = {{18168},{17069},{17079},{17076},{17187},{18261}},
            AtlasMapBossID = 14,
            [NORMAL_DIFF] = {
                { 1, 28586 }, -- Wicked Witch's Hat
                { 2, 28585 }, -- Ruby Slippers
                { 3, 28587 }, -- Legacy
                { 4, 28588 }, -- Blue Diamond Witchwand
                --{ 6, 29434 }, -- Badge of Justice
                { 16, 28594 }, -- Trial-Fire Trousers
                { 17, 28591 }, -- Earthsoul Leggings
                { 18, 28589 }, -- Beastmaw Pauldrons
                { 19, 28593 }, -- Eternium Greathelm
                { 20, 28590 }, -- Ribbon of Sacrifice
                { 21, 28592 }, -- Libram of Souls Redeemed
            }
        },
        { -- KaraOperaEvent
            name = AL["The Big Bad Wolf"],
            nameFormat = NAME_KARA_OPERA,
            npcID = 17521,
            Level = 999,
            DisplayIDs = {{17121},{17053}},
            AtlasMapBossID = 14,
            [NORMAL_DIFF] = {
                { 1, 28582 }, -- Red Riding Hood's Cloak
                { 2, 28583 }, -- Big Bad Wolf's Head
                { 3, 28584 }, -- Big Bad Wolf's Paw
                { 4, 28581 }, -- Wolfslayer Sniper Rifle
                --{ 6, 29434 }, -- Badge of Justice
                { 16, 28594 }, -- Trial-Fire Trousers
                { 17, 28591 }, -- Earthsoul Leggings
                { 18, 28589 }, -- Beastmaw Pauldrons
                { 19, 28593 }, -- Eternium Greathelm
                { 20, 28590 }, -- Ribbon of Sacrifice
                { 21, 28592 }, -- Libram of Souls Redeemed
            }
        },
        { -- KaraOperaEvent
            name = AL["Romulo and Julianne"],
            nameFormat = NAME_KARA_OPERA,
            npcID = {17533,17534},
            Level = 999,
            DisplayIDs = {{17067},{17068}},
            AtlasMapBossID = 14,
            [NORMAL_DIFF] = {
                { 1, 28578 }, -- Masquerade Gown
                { 2, 28579 }, -- Romulo's Poison Vial
                { 3, 28572 }, -- Blade of the Unrequited
                { 4, 28573 }, -- Despair
                --{ 6, 29434 }, -- Badge of Justice
                { 16, 28594 }, -- Trial-Fire Trousers
                { 17, 28591 }, -- Earthsoul Leggings
                { 18, 28589 }, -- Beastmaw Pauldrons
                { 19, 28593 }, -- Eternium Greathelm
                { 20, 28590 }, -- Ribbon of Sacrifice
                { 21, 28592 }, -- Libram of Souls Redeemed
            }
        },
        { -- KaraCurator
            name = AL["The Curator"],
            npcID = 15691,
            Level = 999,
            DisplayIDs = {{16958}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 16,
            [NORMAL_DIFF] = {
                { 1, 28612 }, -- Pauldrons of the Solace-Giver
                { 2, 28647 }, -- Forest Wind Shoulderpads
                { 3, 28631 }, -- Dragon-Quake Shoulderguards
                { 4, 28621 }, -- Wrynn Dynasty Greaves
                { 5, 28649 }, -- Garona's Signet Ring
                { 6, 28633 }, -- Staff of Infinite Mysteries
                --{ 8, 29434 }, -- Badge of Justice
                { 16, 29757 }, -- Gloves of the Fallen Champion
                { 17, 29758 }, -- Gloves of the Fallen Defender
                { 18, 29756 }, -- Gloves of the Fallen Hero
            }
        },
        { -- KaraIllhoof
            name = AL["Terestian Illhoof"],
            npcID = 15688,
            Level = 999,
            DisplayIDs = {{11343}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 20,
            [NORMAL_DIFF] = {
                { 1, 28660 }, -- Gilded Thorium Cloak
                { 2, 28653 }, -- Shadowvine Cloak of Infusion
                { 3, 28652 }, -- Cincture of Will
                { 4, 28654 }, -- Malefic Girdle
                { 5, 28655 }, -- Cord of Nature's Sustenance
                { 6, 28656 }, -- Girdle of the Prowler
                { 7, 28662 }, -- Breastplate of the Lightbinder
                --{ 9, 29434 }, -- Badge of Justice
                { 16, 28661 }, -- Mender's Heart-Ring
                { 17, 28785 }, -- The Lightning Capacitor
                { 18, 28657 }, -- Fool's Bane
                { 19, 28658 }, -- Terestian's Stranglestaff
                { 20, 28659 }, -- Xavian Stiletto
                { 22, 22561 }, -- Formula: Enchant Weapon - Soulfrost
            }
        },
        { -- KaraAran
            name = AL["Shade of Aran"],
            npcID = 16524,
            Level = 999,
            DisplayIDs = {{16621}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 21,
            [NORMAL_DIFF] = {
                { 1, 28672 }, -- Drape of the Dark Reavers
                { 2, 28726 }, -- Mantle of the Mind Flayer
                { 3, 28670 }, -- Boots of the Infernal Coven
                { 4, 28663 }, -- Boots of the Incorrupt
                { 5, 28669 }, -- Rapscallion Boots
                { 6, 28671 }, -- Steelspine Faceguard
                { 7, 28666 }, -- Pauldrons of the Justice-Seeker
                --{ 9, 29434 }, -- Badge of Justice
                { 9, 23933 }, -- Medivh's Journal
                { 16, 28674 }, -- Saberclaw Talisman
                { 17, 28675 }, -- Shermanar Great-Ring
                { 18, 28727 }, -- Pendant of the Violet Eye
                { 19, 28728 }, -- Aran's Soothing Sapphire
                { 20, 28673 }, -- Tirisfal Wand of Ascendancy
                { 22, 22560 }, -- Formula: Enchant Weapon - Sunfire
            }
        },
        { -- KaraNetherspite
            name = AL["Netherspite"],
            npcID = 15689,
            Level = 999,
            DisplayIDs = {{15363}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 22,
            [NORMAL_DIFF] = {
                { 1, 28744 }, -- Uni-Mind Headdress
                { 2, 28742 }, -- Pantaloons of Repentance
                { 3, 28732 }, -- Cowl of Defiance
                { 4, 28741 }, -- Skulker's Greaves
                { 5, 28735 }, -- Earthblood Chestguard
                { 6, 28740 }, -- Rip-Flayer Leggings
                { 7, 28743 }, -- Mantle of Abrahmis
                { 8, 28733 }, -- Girdle of Truth
                --{ 10, 29434 }, -- Badge of Justice
                { 16, 28731 }, -- Shining Chain of the Afterworld
                { 17, 28730 }, -- Mithril Band of the Unscarred
                { 18, 28734 }, -- Jewel of Infinite Possibilities
                { 19, 28729 }, -- Spiteblade
            }
        },
        { -- KaraChess
            name = AL["Chess Event"],
            ObjectID = 185119,
            Level = 999,
            DisplayIDs = {{51}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 25,
            [NORMAL_DIFF] = {
                { 1, 28756 }, -- Headdress of the High Potentate
                { 2, 28755 }, -- Bladed Shoulderpads of the Merciless
                { 3, 28750 }, -- Girdle of Treachery
                { 4, 28752 }, -- Forestlord Striders
                { 5, 28751 }, -- Heart-Flame Leggings
                { 6, 28746 }, -- Fiend Slayer Boots
                { 7, 28748 }, -- Legplates of the Innocent
                { 8, 28747 }, -- Battlescar Boots
                --{ 10, 29434 }, -- Badge of Justice
                { 16, 28745 }, -- Mithril Chain of Heroism
                { 17, 28753 }, -- Ring of Recurrence
                { 18, 28749 }, -- King's Defender
                { 19, 28754 }, -- Triptych Shield of the Ancients
            }
        },
        { -- KaraPrince
            name = AL["Prince Malchezaar"],
            npcID = 15690,
            Level = 999,
            DisplayIDs = {{19274}},
            AtlasMapFile = KARA_MAPDATA_END,
            AtlasMapBossID = 26,
            [NORMAL_DIFF] = {
                { 1, 28765 }, -- Stainless Cloak of the Pure Hearted
                { 2, 28766 }, -- Ruby Drape of the Mysticant
                { 3, 28764 }, -- Farstrider Wildercloak
                { 4, 28762 }, -- Adornment of Stolen Souls
                { 5, 28763 }, -- Jade Ring of the Everliving
                { 6, 28757 }, -- Ring of a Thousand Marks
                { 8, 28770 }, -- Nathrezim Mindblade
                { 9, 28768 }, -- Malchazeen
                { 10, 28767 }, -- The Decapitator
                { 11, 28773 }, -- Gorehowl
                { 12, 28771 }, -- Light's Justice
                { 13, 28772 }, -- Sunfury Bow of the Phoenix
                --{ 15, 29434 }, -- Badge of Justice
                { 16, 29760 }, -- Helm of the Fallen Champion
                { 17, 29761 }, -- Helm of the Fallen Defender
                { 18, 29759 }, -- Helm of the Fallen Hero
            }
        },
        { -- KaraNightbane
            name = AL["Nightbane"],
            npcID = 17225,
            Level = 999,
            DisplayIDs = {{18062}},
            specialType = "summon",
            AtlasMapBossID = 15,
            [NORMAL_DIFF] = {
                { 1, 28602 }, -- Robe of the Elder Scribes
                { 2, 28600 }, -- Stonebough Jerkin
                { 3, 28601 }, -- Chestguard of the Conniver
                { 4, 28599 }, -- Scaled Breastplate of Carnage
                { 5, 28610 }, -- Ferocious Swift-Kickers
                { 6, 28597 }, -- Panzar'Thar Breastplate
                { 7, 28608 }, -- Ironstriders of Urgency
                --{ 9, 29434 }, -- Badge of Justice
                { 9, 31751 }, -- Blazing Signet
                { 10, 24139 }, -- Faint Arcane Essence
                { 16, 28609 }, -- Emberspur Talisman
                { 17, 28603 }, -- Talisman of Nightbane
                { 18, 28604 }, -- Nightstaff of the Everliving
                { 19, 28611 }, -- Dragonheart Flameshield
                { 20, 28606 }, -- Shield of Impenetrable Darkness
            }
        },
        { -- KaraTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 30642 }, -- Drape of the Righteous
                { 2, 30668 }, -- Grasp of the Dead
                { 3, 30673 }, -- Inferno Waist Cord
                { 4, 30644 }, -- Grips of Deftness
                { 5, 30674 }, -- Zierhut's Lost Treads
                { 6, 30643 }, -- Belt of the Tracker
                { 7, 30641 }, -- Boots of Elusion
                { 9, 23857 }, -- Legacy of the Mountain King
                { 10, 23864 }, -- Torment of the Worgen
                { 11, 23862 }, -- Redemption of the Fallen
                { 12, 23865 }, -- Wrath of the Titans
                { 14, 21882 }, -- Soul Essence
                { 16, 30666 }, -- Ritssyn's Lost Pendant
                { 17, 30667 }, -- Ring of Unrelenting Storms
                { 19, 21903 }, -- Pattern: Soulcloth Shoulders
                { 20, 21904 }, -- Pattern: Soulcloth Vest
                { 21, 22545 }, -- Formula: Enchant Boots - Surefooted
            }
        },
        AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, { -- KaraPrinceT
			name = AL["Prince Tenris Mirkblood"],
			npcID = 28194,
			Level = 999,
			DisplayIDs = {{25541}},
			AtlasMapBossID = 5,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  38658 }, -- Vampiric Batling
				{ 2,  39769 }, -- Arcanite Ripper
			},
		}),
        T4_SET
    }
}

data["ZulAman"] = {
	MapID = 3805,
	InstanceID = 568,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ZulAman",
	AtlasMapFile = "ZulAman",
	ContentType = RAID10_CONTENT,
    ContentPhaseBC = 4,
	items = {
        { -- ZAAkilZon
            name = AL["Akil'zon"],
            npcID = 23574,
            Level = 999,
            DisplayIDs = {{21630}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33286 }, -- Mojo-mender's Mask
                { 3, 33215 }, -- Bloodstained Elven Battlevest
                { 4, 33216 }, -- Chestguard of Hidden Purpose
                { 5, 33281 }, -- Brooch of Nature's Mercy
                { 6, 33293 }, -- Signet of Ancient Magics
                { 7, 33214 }, -- Akil'zon's Talonblade
                { 8, 33283 }, -- Amani Punisher
                { 16, 33307 }, -- Formula: Enchant Weapon - Executioner
            }
        },
        { -- ZANalorakk
            name = AL["Nalorakk"],
            npcID = 23576,
            Level = 999,
            DisplayIDs = {{21631}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33203 }, -- Robes of Heavenly Purpose
                { 3, 33285 }, -- Fury of the Ursine
                { 4, 33211 }, -- Bladeangel's Money Belt
                { 5, 33206 }, -- Pauldrons of Primal Fury
                { 6, 33327 }, -- Mask of Introspection
                { 7, 33191 }, -- Jungle Stompers
                { 8, 33640 }, -- Fury
                { 10, 33307 }, -- Formula: Enchant Weapon - Executioner
            }
        },
        { -- ZAJanAlai
            name = AL["Jan'alai"],
            npcID = 23578,
            Level = 999,
            DisplayIDs = {{21633}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33357 }, -- Footpads of Madness
                { 3, 33356 }, -- Helm of Natural Regeneration
                { 4, 33329 }, -- Shadowtooth Trollskin Cuirass
                { 5, 33328 }, -- Arrow-fall Chestguard
                { 6, 33354 }, -- Wub's Cursed Hexblade
                { 7, 33326 }, -- Bulwark of the Amani Empire
                { 8, 33332 }, -- Enamelled Disc of Mojo
                { 10, 33307 }, -- Formula: Enchant Weapon - Executioner
            }
        },
        { -- ZAHalazzi
            name = AL["Halazzi"],
            npcID = 23577,
            Level = 999,
            DisplayIDs = {{21632}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33317 }, -- Robe of Departed Spirits
                { 3, 33300 }, -- Shoulderpads of Dancing Blades
                { 4, 33322 }, -- Shimmer-pelt Vest
                { 5, 33533 }, -- Avalanche Leggings
                { 6, 33299 }, -- Spaulders of the Advocate
                { 7, 33303 }, -- Skullshatter Warboots
                { 8, 33297 }, -- The Savage's Choker
                { 10, 33307 }, -- Formula: Enchant Weapon - Executioner
            }
        },
        { -- ZAMalacrass
            name = AL["Hex Lord Malacrass"],
            npcID = 24239,
            Level = 999,
            DisplayIDs = {{22332}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33592 }, -- Cloak of Ancient Rituals
                { 3, 33453 }, -- Hood of Hexing
                { 4, 33463 }, -- Hood of the Third Eye
                { 5, 33432 }, -- Coif of the Jungle Stalker
                { 6, 33464 }, -- Hex Lord's Voodoo Pauldrons
                { 7, 33421 }, -- Battleworn Tuskguard
                { 8, 33446 }, -- Girdle of Stromgarde's Hope
                { 10, 33307 }, -- Formula: Enchant Weapon - Executioner
                { 16, 33829 }, -- Hex Shrunken Head
                { 17, 34029 }, -- Tiny Voodoo Mask
                { 18, 33828 }, -- Tome of Diabolic Remedy
                { 19, 33389 }, -- Dagger of Bad Mojo
                { 20, 33298 }, -- Prowler's Strikeblade
                { 21, 33388 }, -- Heartless
                { 22, 33465 }, -- Staff of Primal Fury
            }
        },
        { -- ZAZuljin
            name = AL["Zul'jin"],
            npcID = 23863,
            Level = 999,
            DisplayIDs = {{21899}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 33471 }, -- Two-toed Sandals
                { 3, 33479 }, -- Grimgrin Faceguard
                { 4, 33469 }, -- Hauberk of the Empire's Champion
                { 5, 33473 }, -- Chestguard of the Warlord
                { 6, 33466 }, -- Loop of Cursed Bones
                { 7, 33830 }, -- Ancient Aqir Artifact
                { 8, 33831 }, -- Berserker's Call
                { 10, 33307 }, -- Formula: Enchant Weapon - Executioner
                { 16, 33467 }, -- Blade of Twisted Visions
                { 17, 33478 }, -- Jin'rohk, The Great Apocalypse
                { 18, 33476 }, -- Cleaver of the Unforgiving
                { 19, 33468 }, -- Dark Blessing
                { 20, 33474 }, -- Ancient Amani Longbow
                { 22, 33102 }, -- Blood of Zul'jin
            }
        },
        { -- ZATimedChest
            name = AL["Timed Chest"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, "INV_Box_01", nil, format(AL["Timed Reward Chest %d"], 1), nil },
                { 2, 33590 }, -- Cloak of Fiends
                { 3, 33591 }, -- Shadowcaster's Drape
                { 4, 33489 }, -- Mantle of Ill Intent
                { 5, 33480 }, -- Cord of Braided Troll Hair
                { 6, 33483 }, -- Life-step Belt
                { 7, 33971 }, -- Elunite Imbued Leggings
                { 8, 33805 }, -- Shadowhunter's Treads
                { 9, 33481 }, -- Pauldrons of Stone Resolve
                { 10, "INV_Box_01", nil, format(AL["Timed Reward Chest %d"], 3), nil },
                { 11, 33497 }, -- Mana Attuned Band
                { 12, 33500 }, -- Signet of Eternal Life
                { 13, 33496 }, -- Signet of Primal Wrath
                { 14, 33499 }, -- Signet of the Last Defender
                { 15, 33498 }, -- Signet of the Quiet Forest
                { 16, "INV_Box_01", nil, format(AL["Timed Reward Chest %d"], 2), nil },
                { 17, 33495 }, -- Rage
                { 18, 33493 }, -- Umbral Shiv
                { 19, 33492 }, -- Trollbane
                { 20, 33490 }, -- Staff of Dark Mending
                { 21, 33494 }, -- Amani Divining Staff
                { 22, 33491 }, -- Tuskbreaker
                { 25, "INV_Box_01", nil, format(AL["Timed Reward Chest %d"], 4), nil },
                { 26, 33809 }, -- Amani War Bear
            }
        },
        { -- ZATrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 33993 }, -- Mojo
                { 3, 33865 }, -- Amani Hex Stick
                { 4, 33930 }, -- Amani Charm of the Bloodletter
                { 5, 33932 }, -- Amani Charm of the Witch Doctor
                { 6, 33931 }, -- Amani Charm of Mighty Mojo
                { 7, 33933 }, -- Amani Charm of the Raging Defender
            }
        },
    }
}


data["WorldBossesBC"] = {
	name = AL["World Bosses"],
	ContentType = RAID25_CONTENT,
	items = {
        { -- DDoomwalker
            name = AL["Doomwalker"],
            npcID = 17711,
            Level = 999,
            DisplayIDs = {{21435}},
            [NORMAL_DIFF] = {
                { 1, 30729 }, -- Black-Iron Battlecloak
                { 2, 30725 }, -- Anger-Spark Gloves
                { 3, 30727 }, -- Gilded Trousers of Benediction
                { 4, 30730 }, -- Terrorweave Tunic
                { 5, 30728 }, -- Fathom-Helm of the Deeps
                { 6, 30731 }, -- Faceguard of the Endless Watch
                { 7, 30726 }, -- Archaic Charm of Presence
                { 8, 30723 }, -- Talon of the Tempest
                { 9, 30722 }, -- Ethereum Nexus-Reaver
                { 10, 30724 }, -- Barrel-Blade Longrifle
            }
        },
        { -- KKruul
            name = AL["Doom Lord Kazzak"],
            npcID = 18728,
            Level = 999,
            DisplayIDs = {{17887}},
            [NORMAL_DIFF] = {
                { 1, 30735 }, -- Ancient Spellcloak of the Highborne
                { 2, 30734 }, -- Leggings of the Seventh Circle
                { 3, 30737 }, -- Gold-Leaf Wildboots
                { 4, 30739 }, -- Scaled Greaves of the Marksman
                { 5, 30740 }, -- Ripfiend Shoulderplates
                { 6, 30741 }, -- Topaz-Studded Battlegrips
                { 7, 30736 }, -- Ring of Flowing Light
                { 8, 30738 }, -- Ring of Reciprocity
                { 9, 30733 }, -- Hope Ender
                { 10, 30732 }, -- Exodar Life-Staff
            }
        }
	}
}

data["MagtheridonsLair"] = {
	MapID = 3836,
	InstanceID = 544,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_HCMagtheridonsLair",
	AtlasMapFile = {"CL_HCMagtheridonsLair", "HellfireCitadelEnt"},
	ContentType = RAID25_CONTENT,
	items = {
        { -- HCMagtheridon
            name = AL["Magtheridon"],
            npcID = 17257,
            Level = 999,
            DisplayIDs = {{18527}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 28777 }, -- Cloak of the Pit Stalker
                { 2, 28780 }, -- Soul-Eater's Handwraps
                { 3, 28776 }, -- Liar's Tongue Gloves
                { 4, 28778 }, -- Terror Pit Girdle
                { 5, 28775 }, -- Thundering Greathelm
                { 6, 28779 }, -- Girdle of the Endless Pit
                { 7, 28789 }, -- Eye of Magtheridon
                { 8, 28781 }, -- Karaborian Talisman
                { 10, 28774 }, -- Glaive of the Pit
                { 11, 28782 }, -- Crystalheart Pulse-Staff
                { 12, 29458 }, -- Aegis of the Vindicator
                { 13, 28783 }, -- Eredar Wand of Obliteration
                { 16, 29754 }, -- Chestguard of the Fallen Champion
                { 17, 29753 }, -- Chestguard of the Fallen Defender
                { 18, 29755 }, -- Chestguard of the Fallen Hero
                { 20, 32385 }, -- Magtheridon's Head
                { 22, 34845 }, -- Pit Lord's Satchel
                { 24, 34846 }, -- Black Sack of Gems
            }
        },
        T4_SET
    }
}

data["GruulsLair"] = {
	MapID = 3923,
	InstanceID = 565,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_GruulsLair",
	AtlasMapFile = "CL_GruulsLair",
	ContentType = RAID25_CONTENT,
	items = {
        { -- GruulsLairHighKingMaulgar
            name = AL["High King Maulgar"],
            npcID = 18831,
            Level = 999,
            DisplayIDs = {{18649},{12472},{11585},{20195},{20194}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 28797 }, -- Brute Cloak of the Ogre-Magi
                { 2, 28799 }, -- Belt of Divine Inspiration
                { 3, 28796 }, -- Malefic Mask of the Shadows
                { 4, 28801 }, -- Maulgar's Warhelm
                { 5, 28795 }, -- Bladespire Warbands
                { 6, 28800 }, -- Hammer of the Naaru
                { 16, 29763 }, -- Pauldrons of the Fallen Champion
                { 17, 29764 }, -- Pauldrons of the Fallen Defender
                { 18, 29762 }, -- Pauldrons of the Fallen Hero
            }
        },
        { -- GruulGruul
            name = AL["Gruul the Dragonkiller"],
            npcID = 19044,
            Level = 999,
            DisplayIDs = {{18698}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 28804 }, -- Collar of Cho'gall
                { 2, 28803 }, -- Cowl of Nature's Breath
                { 3, 28828 }, -- Gronn-Stitched Girdle
                { 4, 28827 }, -- Gauntlets of the Dragonslayer
                { 5, 28810 }, -- Windshear Boots
                { 6, 28824 }, -- Gauntlets of Martial Perfection
                { 7, 28822 }, -- Teeth of Gruul
                { 8, 28823 }, -- Eye of Gruul
                { 9, 28830 }, -- Dragonspine Trophy
                { 11, 31750 }, -- Earthen Signet
                { 16, 29766 }, -- Leggings of the Fallen Champion
                { 17, 29767 }, -- Leggings of the Fallen Defender
                { 18, 29765 }, -- Leggings of the Fallen Hero
                { 20, 28802 }, -- Bloodmaw Magus-Blade
                { 21, 28794 }, -- Axe of the Gronn Lords
                { 22, 28825 }, -- Aldori Legacy Defender
                { 23, 28826 }, -- Shuriken of Negation
            }
        },
        T4_SET
    }
}

data["SerpentshrineCavern"] = {
	MapID = 3607,
	InstanceID = 548,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_CFRSerpentshrineCavern",
	AtlasMapFile = {"CL_CFRSerpentshrineCavern", "CL_CoilfangReservoirEnt"},
	ContentType = RAID25_CONTENT,
    ContentPhaseBC = 2,
	items = {
        { -- CFRSerpentHydross
            name = AL["Hydross the Unstable"],
            npcID = 21216,
            Level = 999,
            DisplayIDs = {{20162}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 30056 }, -- Robe of Hateful Echoes
                { 2, 32516 }, -- Wraps of Purification
                { 3, 30050 }, -- Boots of the Shifting Nightmare
                { 4, 30055 }, -- Shoulderpads of the Stranger
                { 5, 30047 }, -- Blackfathom Warbands
                { 6, 30054 }, -- Ranger-General's Chestguard
                { 7, 30048 }, -- Brighthelm of Justice
                { 8, 30053 }, -- Pauldrons of the Wardancer
                { 16, 30052 }, -- Ring of Lethality
                { 17, 33055 }, -- Band of Vile Aggression
                { 18, 30664 }, -- Living Root of the Wildheart
                { 19, 30629 }, -- Scarab of Displacement
                { 20, 30049 }, -- Fathomstone
                { 21, 30051 }, -- Idol of the Crescent Goddess
            }
        },
        { -- CFRSerpentLurker
            name = AL["The Lurker Below"],
            npcID = 21217,
            Level = 999,
            DisplayIDs = {{20216}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30064 }, -- Cord of Screaming Terrors
                { 2, 30067 }, -- Velvet Boots of the Guardian
                { 3, 30062 }, -- Grove-Bands of Remulos
                { 4, 30060 }, -- Boots of Effortless Striking
                { 5, 30066 }, -- Tempest-Strider Boots
                { 6, 30065 }, -- Glowing Breastplate of Truth
                { 7, 30057 }, -- Bracers of Eradication
                { 16, 30059 }, -- Choker of Animalistic Fury
                { 17, 30061 }, -- Ancestral Ring of Conquest
                { 18, 33054 }, -- The Seal of Danzalar
                { 19, 30665 }, -- Earring of Soulful Meditation
                { 20, 30063 }, -- Libram of Absolute Truth
                { 21, 30058 }, -- Mallet of the Tides
            }
        },
        { -- CFRSerpentLeotheras
            name = AL["Leotheras the Blind"],
            npcID = 21215,
            Level = 999,
            DisplayIDs = {{20514}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 30092 }, -- Orca-Hide Boots
                { 2, 30097 }, -- Coral-Barbed Shoulderpads
                { 3, 30091 }, -- True-Aim Stalker Bands
                { 4, 30096 }, -- Girdle of the Invulnerable
                { 5, 30627 }, -- Tsunami Talisman
                { 6, 30095 }, -- Fang of the Leviathan
                { 16, 30239 }, -- Gloves of the Vanquished Champion
                { 17, 30240 }, -- Gloves of the Vanquished Defender
                { 18, 30241 }, -- Gloves of the Vanquished Hero
            }
        },
        { -- CFRSerpentKarathress
            name = AL["Fathom-Lord Karathress"],
            npcID = 21214,
            Level = 999,
            DisplayIDs = {{20662},{20671},{20670},{20672}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 30100 }, -- Soul-Strider Boots
                { 2, 30101 }, -- Bloodsea Brigand's Vest
                { 3, 30099 }, -- Frayed Tether of the Drowned
                { 4, 30663 }, -- Fathom-Brooch of the Tidewalker
                { 5, 30626 }, -- Sextant of Unstable Currents
                { 6, 30090 }, -- World Breaker
                { 16, 30245 }, -- Leggings of the Vanquished Champion
                { 17, 30246 }, -- Leggings of the Vanquished Defender
                { 18, 30247 }, -- Leggings of the Vanquished Hero
            }
        },
        { -- CFRSerpentMorogrim
            name = AL["Morogrim Tidewalker"],
            npcID = 21213,
            Level = 999,
            DisplayIDs = {{20739}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 30098 }, -- Razor-Scale Battlecloak
                { 2, 30079 }, -- Illidari Shoulderpads
                { 3, 30075 }, -- Gnarled Chestpiece of the Ancients
                { 4, 30085 }, -- Mantle of the Tireless Tracker
                { 5, 30068 }, -- Girdle of the Tidal Call
                { 6, 30084 }, -- Pauldrons of the Argent Sentinel
                { 7, 30081 }, -- Warboots of Obliteration
                { 16, 30008 }, -- Pendant of the Lost Ages
                { 17, 30083 }, -- Ring of Sundered Souls
                { 18, 33058 }, -- Band of the Vigilant
                { 19, 30720 }, -- Serpent-Coil Braid
                { 20, 30082 }, -- Talon of Azshara
                { 21, 30080 }, -- Luminescent Rod of the Naaru
            }
        },
        { -- CFRSerpentVashj
            name = AL["Lady Vashj"],
            npcID = 21212,
            Level = 999,
            DisplayIDs = {{20748}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 30107 }, -- Vestments of the Sea-Witch
                { 2, 30111 }, -- Runetotem's Mantle
                { 3, 30106 }, -- Belt of One-Hundred Deaths
                { 4, 30104 }, -- Cobra-Lash Boots
                { 5, 30102 }, -- Krakken-Heart Breastplate
                { 6, 30112 }, -- Glorious Gauntlets of Crestfall
                { 7, 30109 }, -- Ring of Endless Coils
                { 8, 30110 }, -- Coral Band of the Revived
                { 9, 30621 }, -- Prism of Inner Calm
                { 10, 30103 }, -- Fang of Vashj
                { 11, 30108 }, -- Lightfathom Scepter
                { 12, 30105 }, -- Serpent Spine Longbow
                { 16, 30242 }, -- Helm of the Vanquished Champion
                { 17, 30243 }, -- Helm of the Vanquished Defender
                { 18, 30244 }, -- Helm of the Vanquished Hero
                { 20, 29906 }, -- Vashj's Vial Remnant
            }
        },
        { -- CFRSerpentTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 30027 }, -- Boots of Courage Unending
                { 2, 30022 }, -- Pendant of the Perilous
                { 3, 30620 }, -- Spyglass of the Hidden Fleet
                { 4, 30023 }, -- Totem of the Maelstrom
                { 5, 30021 }, -- Wildfury Greatstaff
                { 6, 30025 }, -- Serpentshrine Shuriken
                { 8, 30324 }, -- Plans: Red Havoc Boots
                { 9, 30322 }, -- Plans: Red Belt of Battle
                { 10, 30323 }, -- Plans: Boots of the Protector
                { 11, 30321 }, -- Plans: Belt of the Guardian
                { 12, 30280 }, -- Pattern: Belt of Blasting
                { 13, 30282 }, -- Pattern: Boots of Blasting
                { 14, 30283 }, -- Pattern: Boots of the Long Road
                { 15, 30281 }, -- Pattern: Belt of the Long Road
                { 16, 30308 }, -- Pattern: Hurricane Boots
                { 17, 30304 }, -- Pattern: Monsoon Belt
                { 18, 30305 }, -- Pattern: Boots of Natural Grace
                { 19, 30307 }, -- Pattern: Boots of the Crimson Hawk
                { 20, 30306 }, -- Pattern: Boots of Utter Darkness
                { 21, 30301 }, -- Pattern: Belt of Natural Power
                { 22, 30303 }, -- Pattern: Belt of the Black Eagle
                { 23, 30302 }, -- Pattern: Belt of Deep Shadow
                { 25, 30183 }, -- Nether Vortex
                { 27, 32897 }, -- Mark of the Illidari
            }
        },
        T5_SET
    }
}

data["TempestKeep"] = {
	MapID = 3845,
	InstanceID = 550,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_TempestKeepTheEye",
	AtlasMapFile = {"CL_TempestKeepTheEye", "TempestKeepEnt"},
	ContentType = RAID25_CONTENT,
    ContentPhaseBC = 2,
	items = {
        { -- TKEyeAlar
            name = AL["Al'ar"],
            npcID = 19514,
            Level = 999,
            DisplayIDs = {{18945}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 29925 }, -- Phoenix-Wing Cloak
                { 2, 29918 }, -- Mindstorm Wristbands
                { 3, 29947 }, -- Gloves of the Searing Grip
                { 4, 29921 }, -- Fire Crest Breastplate
                { 5, 29922 }, -- Band of Al'ar
                { 6, 29920 }, -- Phoenix-Ring of Rebirth
                { 7, 30448 }, -- Talon of Al'ar
                { 8, 30447 }, -- Tome of Fiery Redemption
                { 9, 29923 }, -- Talisman of the Sun King
                { 16, 32944 }, -- Talon of the Phoenix
                { 17, 29948 }, -- Claw of the Phoenix
                { 18, 29924 }, -- Netherbane
                { 19, 29949 }, -- Arcanite Steam-Pistol
            }
        },
        { -- TKEyeVoidReaver
            name = AL["Void Reaver"],
            npcID = 19516,
            Level = 999,
            DisplayIDs = {{18951}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 29986 }, -- Cowl of the Grand Engineer
                { 2, 29984 }, -- Girdle of Zaetar
                { 3, 29985 }, -- Void Reaver Greaves
                { 4, 29983 }, -- Fel-Steel Warhelm
                { 5, 32515 }, -- Wristguards of Determination
                { 6, 30619 }, -- Fel Reaver's Piston
                { 7, 30450 }, -- Warp-Spring Coil
                { 16, 30248 }, -- Pauldrons of the Vanquished Champion
                { 17, 30249 }, -- Pauldrons of the Vanquished Defender
                { 18, 30250 }, -- Pauldrons of the Vanquished Hero
            }
        },
        { -- TKEyeSolarian
            name = AL["High Astromancer Solarian"],
            npcID = 18805,
            Level = 999,
            DisplayIDs = {{18239}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 29977 }, -- Star-Soul Breeches
                { 2, 29972 }, -- Trousers of the Astromancer
                { 3, 29966 }, -- Vambraces of Ending
                { 4, 29976 }, -- Worldstorm Gauntlets
                { 5, 29951 }, -- Star-Strider Boots
                { 6, 29965 }, -- Girdle of the Righteous Path
                { 7, 29950 }, -- Greaves of the Bloodwarder
                { 8, 32267 }, -- Boots of the Resilient
                { 16, 30446 }, -- Solarian's Sapphire
                { 17, 30449 }, -- Void Star Talisman
                { 18, 29962 }, -- Heartrazor
                { 19, 29981 }, -- Ethereum Life-Staff
                { 20, 29982 }, -- Wand of the Forgotten Star
            }
        },
        { -- TKEyeKaelthas
            name = AL["Kael'thas Sunstrider"],
            npcID = 19622,
            Level = 999,
            DisplayIDs = {{20023}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 29992 }, -- Royal Cloak of the Sunstriders
                { 2, 29989 }, -- Sunshower Light Cloak
                { 3, 29994 }, -- Thalassian Wildercloak
                { 4, 29990 }, -- Crown of the Sun
                { 5, 29987 }, -- Gauntlets of the Sun King
                { 6, 29995 }, -- Leggings of Murderous Intent
                { 7, 29991 }, -- Sunhawk Leggings
                { 8, 29998 }, -- Royal Gauntlets of Silvermoon
                { 9, 29997 }, -- Band of the Ranger-General
                { 10, 29993 }, -- Twinblade of the Phoenix
                { 11, 29996 }, -- Rod of the Sun King
                { 12, 29988 }, -- The Nexus Key
                { 16, 30236 }, -- Chestguard of the Vanquished Champion
                { 17, 30237 }, -- Chestguard of the Vanquished Defender
                { 18, 30238 }, -- Chestguard of the Vanquished Hero
                { 20, 32458 }, -- Ashes of Al'ar
                { 22, 32405 }, -- Verdant Sphere
                { 24, 29905 }, -- Kael's Vial Remnant
            }
        },
        { -- TKEyeLegendaries
            name = AL["Legendaries"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 30312 }, -- Infinity Blade
                { 2, 30311 }, -- Warp Slicer
                { 3, 30317 }, -- Cosmic Infuser
                { 4, 30316 }, -- Devastation
                { 5, 30313 }, -- Staff of Disintegration
                { 6, 30314 }, -- Phaseshift Bulwark
                { 7, 30318 }, -- Netherstrand Longbow
                { 8, 30319 }, -- Nether Spike
            }
        },
        { -- TKEyeTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 30024 }, -- Mantle of the Elven Kings
                { 2, 30020 }, -- Fire-Cord of the Magus
                { 3, 30029 }, -- Bark-Gloves of Ancient Wisdom
                { 4, 30026 }, -- Bands of the Celestial Archer
                { 5, 30030 }, -- Girdle of Fallen Stars
                { 6, 30028 }, -- Seventh Ring of the Tirisfalen
                { 8, 30324 }, -- Plans: Red Havoc Boots
                { 9, 30322 }, -- Plans: Red Belt of Battle
                { 10, 30323 }, -- Plans: Boots of the Protector
                { 11, 30321 }, -- Plans: Belt of the Guardian
                { 12, 30280 }, -- Pattern: Belt of Blasting
                { 13, 30282 }, -- Pattern: Boots of Blasting
                { 14, 30283 }, -- Pattern: Boots of the Long Road
                { 15, 30281 }, -- Pattern: Belt of the Long Road
                { 16, 30308 }, -- Pattern: Hurricane Boots
                { 17, 30304 }, -- Pattern: Monsoon Belt
                { 18, 30305 }, -- Pattern: Boots of Natural Grace
                { 19, 30307 }, -- Pattern: Boots of the Crimson Hawk
                { 20, 30306 }, -- Pattern: Boots of Utter Darkness
                { 21, 30301 }, -- Pattern: Belt of Natural Power
                { 22, 30303 }, -- Pattern: Belt of the Black Eagle
                { 23, 30302 }, -- Pattern: Belt of Deep Shadow
                { 25, 30183 }, -- Nether Vortex
                { 27, 32897 }, -- Mark of the Illidari
            }
        },
        T5_SET
    }
}

data["HyjalSummit"] = {
	MapID = 3606,
	InstanceID = 534,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CoTHyjal",
	AtlasMapFile = {"CoTHyjal", "CL_CoTHyjalEnt"},
	ContentType = RAID25_CONTENT,
    ContentPhaseBC = 3,
	items = {
        { -- MountHyjalWinterchill
            name = AL["Rage Winterchill"],
            npcID = 17767,
            Level = 999,
            DisplayIDs = {{17444}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 30871 }, -- Bracers of Martyrdom
                { 2, 30870 }, -- Cuffs of Devastation
                { 3, 30863 }, -- Deadly Cuffs
                { 4, 30868 }, -- Rejuvenating Bracers
                { 5, 30864 }, -- Bracers of the Pathfinder
                { 6, 30869 }, -- Howling Wind Bracers
                { 7, 30873 }, -- Stillwater Boots
                { 8, 30866 }, -- Blood-stained Pauldrons
                { 9, 30862 }, -- Blessed Adamantite Bracers
                { 10, 30861 }, -- Furious Shackles
                { 16, 30865 }, -- Tracker's Blade
                { 17, 30872 }, -- Chronicle of Dark Secrets
                { 19, 32459 }, -- Time-Phased Phylactery
            }
        },
        { -- MountHyjalAnetheron
            name = AL["Anetheron"],
            npcID = 17808,
            Level = 999,
            DisplayIDs = {{21069}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 30884 }, -- Hatefury Mantle
                { 2, 30888 }, -- Anetheron's Noose
                { 3, 30885 }, -- Archbishop's Slippers
                { 4, 30879 }, -- Don Alejandro's Money Belt
                { 5, 30886 }, -- Enchanted Leather Sandals
                { 6, 30887 }, -- Golden Links of Restoration
                { 7, 30880 }, -- Quickstrider Moccasins
                { 8, 30878 }, -- Glimmering Steel Mantle
                { 16, 30874 }, -- The Unbreakable Will
                { 17, 30881 }, -- Blade of Infamy
                { 18, 30883 }, -- Pillar of Ferocity
                { 19, 30882 }, -- Bastion of Light
            }
        },
        { -- MountHyjalKazrogal
            name = AL["Kaz'rogal"],
            npcID = 17888,
            Level = 999,
            DisplayIDs = {{17886}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 30895 }, -- Angelista's Sash
                { 2, 30916 }, -- Leggings of Channeled Elements
                { 3, 30894 }, -- Blue Suede Shoes
                { 4, 30917 }, -- Razorfury Mantle
                { 5, 30914 }, -- Belt of the Crescent Moon
                { 6, 30891 }, -- Black Featherlight Boots
                { 7, 30892 }, -- Beast-tamer's Shoulders
                { 8, 30919 }, -- Valestalker Girdle
                { 9, 30893 }, -- Sun-touched Chain Leggings
                { 10, 30915 }, -- Belt of Seething Fury
                { 16, 30918 }, -- Hammer of Atonement
                { 17, 30889 }, -- Kaz'rogal's Hardened Heart
            }
        },
        { -- MountHyjalAzgalor
            name = AL["Azgalor"],
            npcID = 17842,
            Level = 999,
            DisplayIDs = {{18526}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 30899 }, -- Don Rodrigo's Poncho
                { 2, 30898 }, -- Shady Dealer's Pantaloons
                { 3, 30900 }, -- Bow-stitched Leggings
                { 4, 30896 }, -- Glory of the Defender
                { 5, 30897 }, -- Girdle of Hope
                { 6, 30901 }, -- Boundless Agony
                { 16, 31092 }, -- Gloves of the Forgotten Conqueror
                { 17, 31094 }, -- Gloves of the Forgotten Protector
                { 18, 31093 }, -- Gloves of the Forgotten Vanquisher
            }
        },
        { -- MountHyjalArchimonde
            name = AL["Archimonde"],
            npcID = 17968,
            Level = 999,
            DisplayIDs = {{20939}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 30913 }, -- Robes of Rhonin
                { 2, 30912 }, -- Leggings of Eternity
                { 3, 30905 }, -- Midnight Chestguard
                { 4, 30907 }, -- Mail of Fevered Pursuit
                { 5, 30904 }, -- Savior's Grasp
                { 6, 30903 }, -- Legguards of Endless Rage
                { 7, 30911 }, -- Scepter of Purification
                { 9, 30910 }, -- Tempest of Chaos
                { 10, 30902 }, -- Cataclysm's Edge
                { 11, 30908 }, -- Apostle of Argus
                { 12, 30909 }, -- Antonidas's Aegis of Rapt Concentration
                { 13, 30906 }, -- Bristleblitz Striker
                { 16, 31097 }, -- Helm of the Forgotten Conqueror
                { 17, 31095 }, -- Helm of the Forgotten Protector
                { 18, 31096 }, -- Helm of the Forgotten Vanquisher
            }
        },
        { -- MountHyjalTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 32590 }, -- Nethervoid Cloak
                { 2, 34010 }, -- Pepe's Shroud of Pacification
                { 3, 32609 }, -- Boots of the Divine Light
                { 4, 32592 }, -- Chestguard of Relentless Storms
                { 5, 32591 }, -- Choker of Serrated Blades
                { 6, 32589 }, -- Hellfire-Encased Pendant
                { 7, 34009 }, -- Hammer of Judgement
                { 8, 32946 }, -- Claw of Molten Fury
                { 9, 32945 }, -- Fist of Molten Fury
                { 11, 32428 }, -- Heart of Darkness
                { 12, 32897 }, -- Mark of the Illidari
                { 16, 32285 }, -- Design: Flashing Crimson Spinel
                { 17, 32296 }, -- Design: Great Lionseye
                { 18, 32303 }, -- Design: Inscribed Pyrestone
                { 19, 32295 }, -- Design: Mystic Lionseye
                { 20, 32298 }, -- Design: Shifting Shadowsong Amethyst
                { 21, 32297 }, -- Design: Sovereign Shadowsong Amethyst
                { 22, 32289 }, -- Design: Stormy Empyrean Sapphire
                { 23, 32307 }, -- Design: Veiled Pyrestone
            }
        },
        T6_SET
    }
}

data["BlackTemple"] = {
	MapID = 3959,
	InstanceID = 564,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_BlackTempleStart",
	AtlasMapFile = "CL_BlackTempleStart",
	ContentType = RAID25_CONTENT,
    ContentPhaseBC = 3,
	items = {
        { -- BTNajentus
            name = AL["High Warlord Naj'entus"],
            npcID = 22887,
            Level = 999,
            DisplayIDs = {{21174}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 32239 }, -- Slippers of the Seacaller
                { 2, 32240 }, -- Guise of the Tidal Lurker
                { 3, 32377 }, -- Mantle of Darkness
                { 4, 32241 }, -- Helm of Soothing Currents
                { 5, 32234 }, -- Fists of Mukoa
                { 6, 32242 }, -- Boots of Oceanic Fury
                { 7, 32232 }, -- Eternium Shell Bracers
                { 8, 32243 }, -- Pearl Inlaid Boots
                { 9, 32245 }, -- Tide-stomper's Greaves
                { 16, 32238 }, -- Ring of Calming Waves
                { 17, 32247 }, -- Ring of Captured Storms
                { 18, 32237 }, -- The Maelstrom's Fury
                { 19, 32236 }, -- Rising Tide
                { 20, 32248 }, -- Halberd of Desolation
            }
        },
        { -- BTSupremus
            name = AL["Supremus"],
            npcID = 22898,
            Level = 999,
            DisplayIDs = {{21145}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 32256 }, -- Waistwrap of Infinity
                { 2, 32252 }, -- Nether Shadow Tunic
                { 3, 32259 }, -- Bands of the Coming Storm
                { 4, 32251 }, -- Wraps of Precise Flight
                { 5, 32258 }, -- Naturalist's Preserving Cinch
                { 6, 32250 }, -- Pauldrons of Abyssal Fury
                { 16, 32260 }, -- Choker of Endless Nightmares
                { 17, 32261 }, -- Band of the Abyssal Lord
                { 18, 32257 }, -- Idol of the White Stag
                { 19, 32254 }, -- The Brutalizer
                { 20, 32262 }, -- Syphon of the Nathrezim
                { 21, 32255 }, -- Felstone Bulwark
                { 22, 32253 }, -- Legionkiller
            }
        },
        { -- BTAkama
            name = AL["Shade of Akama"],
            npcID = 22841,
            Level = 999,
            DisplayIDs = {{21357}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 32273 }, -- Amice of Brilliant Light
                { 2, 32270 }, -- Focused Mana Bindings
                { 3, 32513 }, -- Wristbands of Divine Influence
                { 4, 32265 }, -- Shadow-walker's Cord
                { 5, 32271 }, -- Kilt of Immortal Nature
                { 6, 32264 }, -- Shoulders of the Hidden Predator
                { 7, 32275 }, -- Spiritwalker Gauntlets
                { 8, 32276 }, -- Flashfire Girdle
                { 9, 32279 }, -- The Seeker's Wristguards
                { 10, 32278 }, -- Grips of Silent Justice
                { 11, 32263 }, -- Praetorian's Legguards
                { 12, 32268 }, -- Myrmidon's Treads
                { 16, 32266 }, -- Ring of Deceitful Intent
                { 17, 32361 }, -- Blind-Seers Icon
            }
        },
        { -- BTBloodboil
            name = AL["Gurtogg Bloodboil"],
            npcID = 22948,
            Level = 999,
            DisplayIDs = {{21443}},
            AtlasMapFile = "CL_BlackTempleBasement",
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 32337 }, -- Shroud of Forgiveness
                { 2, 32338 }, -- Blood-cursed Shoulderpads
                { 3, 32340 }, -- Garments of Temperance
                { 4, 32339 }, -- Belt of Primal Majesty
                { 5, 32334 }, -- Vest of Mounting Assault
                { 6, 32342 }, -- Girdle of Mighty Resolve
                { 7, 32333 }, -- Girdle of Stability
                { 8, 32341 }, -- Leggings of Divine Retribution
                { 16, 32335 }, -- Unstoppable Aggressor's Ring
                { 17, 32501 }, -- Shadowmoon Insignia
                { 18, 32269 }, -- Messenger of Fate
                { 19, 32344 }, -- Staff of Immaculate Recovery
                { 20, 32343 }, -- Wand of Prismatic Focus
            }
        },
        { -- BTEssencofSouls
            name = AL["Reliquary of the Lost"],
            npcID = 22856,
            Level = 999,
            DisplayIDs = {{21146}},
            AtlasMapFile = "CL_BlackTempleBasement",
            AtlasMapBossID = 7,
            [NORMAL_DIFF] = {
                { 1, 32353 }, -- Gloves of Unfailing Faith
                { 2, 32351 }, -- Elunite Empowered Bracers
                { 3, 32347 }, -- Grips of Damnation
                { 4, 32352 }, -- Naturewarden's Treads
                { 5, 32517 }, -- The Wavemender's Mantle
                { 6, 32346 }, -- Boneweave Girdle
                { 7, 32354 }, -- Crown of Empowered Fate
                { 8, 32345 }, -- Dreadboots of the Legion
                { 16, 32349 }, -- Translucent Spellthread Necklace
                { 17, 32362 }, -- Pendant of Titans
                { 18, 32350 }, -- Touch of Inspiration
                { 19, 32332 }, -- Torch of the Damned
                { 20, 32363 }, -- Naaru-Blessed Life Rod
            }
        },
        { -- BTGorefiend
            name = AL["Teron Gorefiend"],
            npcID = 22871,
            Level = 999,
            DisplayIDs = {{21254}},
            AtlasMapFile = "CL_BlackTempleBasement",
            AtlasMapBossID = 8,
            [NORMAL_DIFF] = {
                { 1, 32323 }, -- Shadowmoon Destroyer's Drape
                { 2, 32329 }, -- Cowl of Benevolence
                { 3, 32327 }, -- Robe of the Shadow Council
                { 4, 32324 }, -- Insidious Bands
                { 5, 32328 }, -- Botanist's Gloves of Growth
                { 6, 32510 }, -- Softstep Boots of Tracking
                { 7, 32280 }, -- Gauntlets of Enforcement
                { 8, 32512 }, -- Girdle of Lordaeron's Fallen
                { 16, 32330 }, -- Totem of Ancestral Guidance
                { 17, 32348 }, -- Soul Cleaver
                { 18, 32326 }, -- Twisted Blades of Zarak
                { 19, 32325 }, -- Rifle of the Stoic Guardian
            }
        },
        { -- BTShahraz
            name = AL["Mother Shahraz"],
            npcID = 22947,
            Level = 999,
            DisplayIDs = {{21252}},
            AtlasMapFile = "CL_BlackTempleTop",
            AtlasMapBossID = 9,
            [NORMAL_DIFF] = {
                { 1, 32367 }, -- Leggings of Devastation
                { 2, 32366 }, -- Shadowmaster's Boots
                { 3, 32365 }, -- Heartshatter Breastplate
                { 4, 32370 }, -- Nadina's Pendant of Purity
                { 5, 32368 }, -- Tome of the Lightbringer
                { 6, 32369 }, -- Blade of Savagery
                { 16, 31101 }, -- Pauldrons of the Forgotten Conqueror
                { 17, 31103 }, -- Pauldrons of the Forgotten Protector
                { 18, 31102 }, -- Pauldrons of the Forgotten Vanquisher
            }
        },
        { -- BTCouncil
            name = AL["The Illidari Council"],
            npcID = {23426, 22949, 22950, 22951, 22952},
            Level = 999,
            DisplayIDs = {{21416},{21417},{21419},{21418}},
            AtlasMapFile = "CL_BlackTempleTop",
            AtlasMapBossID = 10,
            [NORMAL_DIFF] = {
                { 1, 32331 }, -- Cloak of the Illidari Council
                { 2, 32519 }, -- Belt of Divine Guidance
                { 3, 32518 }, -- Veil of Turning Leaves
                { 4, 32376 }, -- Forest Prowler's Helm
                { 5, 32373 }, -- Helm of the Illidari Shatterer
                { 6, 32505 }, -- Madness of the Betrayer
                { 16, 31098 }, -- Leggings of the Forgotten Conqueror
                { 17, 31100 }, -- Leggings of the Forgotten Protector
                { 18, 31099 }, -- Leggings of the Forgotten Vanquisher
            }
        },
        { -- BTIllidanStormrage
            name = AL["Illidan Stormrage"],
            npcID = 22917,
            Level = 999,
            DisplayIDs = {{21135}},
            AtlasMapFile = "CL_BlackTempleTop",
            AtlasMapBossID = 11,
            [NORMAL_DIFF] = {
                { 1, 32524 }, -- Shroud of the Highborne
                { 2, 32525 }, -- Cowl of the Illidari High Lord
                { 3, 32235 }, -- Cursed Vision of Sargeras
                { 4, 32521 }, -- Faceplate of the Impenetrable
                { 5, 32497 }, -- Stormrage Signet Ring
                { 6, 32483 }, -- The Skull of Gul'dan
                { 7, 32496 }, -- Memento of Tyrande
                { 9, 32837 }, -- Warglaive of Azzinoth
                { 10, 32838 }, -- Warglaive of Azzinoth
                { 16, 31089 }, -- Chestguard of the Forgotten Conqueror
                { 17, 31091 }, -- Chestguard of the Forgotten Protector
                { 18, 31090 }, -- Chestguard of the Forgotten Vanquisher
                { 20, 32471 }, -- Shard of Azzinoth
                { 21, 32500 }, -- Crystal Spire of Karabor
                { 22, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
                { 23, 32375 }, -- Bulwark of Azzinoth
                { 24, 32336 }, -- Black Bow of the Betrayer
            }
        },
        { -- BTTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 32590 }, -- Nethervoid Cloak
                { 2, 34012 }, -- Shroud of the Final Stand
                { 3, 32609 }, -- Boots of the Divine Light
                { 4, 32593 }, -- Treads of the Den Mother
                { 5, 32592 }, -- Chestguard of Relentless Storms
                { 6, 32608 }, -- Pillager's Gauntlets
                { 7, 32606 }, -- Girdle of the Lightbearer
                { 8, 32591 }, -- Choker of Serrated Blades
                { 9, 32589 }, -- Hellfire-Encased Pendant
                { 10, 32526 }, -- Band of Devastation
                { 11, 32528 }, -- Blessed Band of Karabor
                { 12, 32527 }, -- Ring of Ancient Knowledge
                { 16, 34009 }, -- Hammer of Judgement
                { 17, 32943 }, -- Swiftsteel Bludgeon
                { 18, 34011 }, -- Illidari Runeshield
                { 20, 32228 }, -- Empyrean Sapphire
                { 21, 32231 }, -- Pyrestone
                { 22, 32229 }, -- Lionseye
                { 23, 32249 }, -- Seaspray Emerald
                { 24, 32230 }, -- Shadowsong Amethyst
                { 25, 32227 }, -- Crimson Spinel
                { 27, 32428 }, -- Heart of Darkness
                { 28, 32897 }, -- Mark of the Illidari
            }
        },
        { -- BTPatterns
            name = AL["Patterns"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 32738 }, -- Plans: Dawnsteel Bracers
                { 2, 32739 }, -- Plans: Dawnsteel Shoulders
                { 3, 32736 }, -- Plans: Swiftsteel Bracers
                { 4, 32737 }, -- Plans: Swiftsteel Shoulders
                { 5, 32748 }, -- Pattern: Bindings of Lightning Reflexes
                { 6, 32744 }, -- Pattern: Bracers of Renewed Life
                { 7, 32750 }, -- Pattern: Living Earth Bindings
                { 8, 32751 }, -- Pattern: Living Earth Shoulders
                { 9, 32749 }, -- Pattern: Shoulders of Lightning Reflexes
                { 10, 32745 }, -- Pattern: Shoulderpads of Renewed Life
                { 11, 32746 }, -- Pattern: Swiftstrike Bracers
                { 12, 32747 }, -- Pattern: Swiftstrike Shoulders
                { 16, 32754 }, -- Pattern: Bracers of Nimble Thought
                { 17, 32755 }, -- Pattern: Mantle of Nimble Thought
                { 18, 32753 }, -- Pattern: Swiftheal Mantle
                { 19, 32752 }, -- Pattern: Swiftheal Wraps
            }
        },
        T6_SET
    }
}

data["SunwellPlateau"] = {
	MapID = 4075,
	InstanceID = 580,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CL_SunwellPlateau",
	AtlasMapFile = "CL_SunwellPlateau",
	ContentType = RAID25_CONTENT,
    ContentPhaseBC = 5,
	items = {
        { -- SPKalecgos
            name = AL["Kalecgos"],
            npcID = {24850,24892},
            Level = 999,
            DisplayIDs = {{23345},{6686}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 34170 }, -- Pantaloons of Calming Strife
                --{ 2, 34386 }, -- Pantaloons of Growing Strife
                { 2, 34169 }, -- Breeches of Natural Aggression
                --{ 4, 34384 }, -- Breeches of Natural Splendor
                { 3, 34168 }, -- Starstalker Legguards
                { 4, 34167 }, -- Legplates of the Holy Juggernaut
                --{ 7, 34382 }, -- Judicator's Legguards
                { 5, 34166 }, -- Band of Lucent Beams
                { 16, 34848 }, -- Bracers of the Forgotten Conqueror
                { 17, 34851 }, -- Bracers of the Forgotten Protector
                { 18, 34852 }, -- Bracers of the Forgotten Vanquisher
                { 20, 34165 }, -- Fang of Kalecgos
                { 21, 34164 }, -- Dragonscale-Encrusted Longblade
            }
        },
        { -- SPBrutallus
            name = AL["Brutallus"],
            npcID = 24882,
            Level = 999,
            DisplayIDs = {{22711}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 34181 }, -- Leggings of Calamity
                { 2, 34180 }, -- Felfury Legplates
                --{ 3, 34381 }, -- Felstrength Legplates
                { 3, 34178 }, -- Collar of the Pit Lord
                { 4, 34177 }, -- Clutch of Demise
                { 16, 34853 }, -- Belt of the Forgotten Conqueror
                { 17, 34854 }, -- Belt of the Forgotten Protector
                { 18, 34855 }, -- Belt of the Forgotten Vanquisher
                { 20, 34176 }, -- Reign of Misery
                { 21, 34179 }, -- Heart of the Pit
            }
        },
        { -- SPFelmyst
            name = AL["Felmyst"],
            npcID = 25038,
            Level = 999,
            DisplayIDs = {{22838}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 34352 }, -- Borderland Fortress Grips
                { 2, 34188 }, -- Leggings of the Immortal Night
                --{ 3, 34385 }, -- Leggings of the Immortal Beast
                { 3, 34186 }, -- Chain Links of the Tumultuous Storm
                --{ 5, 34383 }, -- Kilt of Spiritual Reconstruction
                { 4, 34184 }, -- Brooch of the Highborne
                { 16, 34856 }, -- Boots of the Forgotten Conqueror
                { 17, 34857 }, -- Boots of the Forgotten Protector
                { 18, 34858 }, -- Boots of the Forgotten Vanquisher
                { 20, 34182 }, -- Grand Magister's Staff of Torrents
                { 21, 34185 }, -- Sword Breaker's Bulwark
            }
        },
        { -- SPEredarTwins
            name = AL["Eredar Twins"],
            npcID = {25166,25165},
            Level = 999,
            DisplayIDs = {{23334},{23177}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 34205 }, -- Shroud of Redeemed Souls
                { 2, 34190 }, -- Crimson Paragon's Cover
                { 3, 34210 }, -- Amice of the Convoker
                { 4, 34202 }, -- Shawl of Wonderment
                --{ 5, 34393 }, -- Shoulderpads of Knowledge's Pursuit
                { 5, 34209 }, -- Spaulders of Reclamation
                --{ 7, 34391 }, -- Spaulders of Devastation
                { 6, 34195 }, -- Shoulderpads of Vehemence
                --{ 9, 34392 }, -- Demontooth Shoulderpads
                { 7, 34194 }, -- Mantle of the Golden Forest
                { 8, 34208 }, -- Equilibrium Epaulets
                --{ 12, 34390 }, -- Erupting Epaulets
                { 9, 34192 }, -- Pauldrons of Perseverance
                --{ 14, 34388 }, -- Pauldrons of Berserking
                { 10, 34193 }, -- Spaulders of the Thalassian Savior
                --{ 17, 34389 }, -- Spaulders of the Thalassian Defender
                { 16, 35290 }, -- Sin'dorei Pendant of Conquest
                { 17, 35291 }, -- Sin'dorei Pendant of Salvation
                { 18, 35292 }, -- Sin'dorei Pendant of Triumph
                { 19, 34204 }, -- Amulet of Unfettered Magics
                { 21, 34189 }, -- Band of Ruinous Delight
                { 23, 34206 }, -- Book of Highborne Hymns
                { 25, 34197 }, -- Shiv of Exsanguination
                { 26, 34199 }, -- Archon's Gavel
                { 27, 34203 }, -- Grip of Mannoroth
                { 28, 34198 }, -- Stanchion of Primal Instinct
                { 29, 34196 }, -- Golden Bow of Quel'Thalas
            }
        },
        { -- SPMuru
            name = AL["M'uru"],
            npcID = {25741,25840},
            Level = 999,
            DisplayIDs = {{23404},{23428}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 34232 }, -- Fel Conquerer Raiments
                { 2, 34233 }, -- Robes of Faltered Light
                --{ 3, 34399 }, -- Robes of Ghostly Hatred
                { 3, 34212 }, -- Sunglow Vest
                --{ 5, 34398 }, -- Utopian Tunic of Elune
                { 4, 34211 }, -- Harness of Carnal Instinct
                --{ 7, 34397 }, -- Bladed Chaos Tunic
                { 5, 34234 }, -- Shadowed Gauntlets of Paroxysm
                --{ 9, 34408 }, -- Gloves of the Forest Drifter
                { 6, 34229 }, -- Garments of Serene Shores
                --{ 11, 34396 }, -- Garments of Crashing Shores
                { 7, 34228 }, -- Vicious Hawkstrider Hauberk
                { 8, 34215 }, -- Warharness of Reckless Fury
                --{ 14, 34394 }, -- Breastplate of Agony's Aversion
                { 9, 34240 }, -- Gauntlets of the Soothed Soul
                { 10, 34216 }, -- Heroic Judicator's Chestguard
                --{ 17, 34395 }, -- Noble Judicator's Chestguard
                { 16, 34213 }, -- Ring of Hardened Resolve
                { 17, 34230 }, -- Ring of Omnipotence
                { 18, 35282 }, -- Sin'dorei Band of Dominance
                { 19, 35283 }, -- Sin'dorei Band of Salvation
                { 20, 35284 }, -- Sin'dorei Band of Triumph
                { 22, 34427 }, -- Blackened Naaru Sliver
                { 23, 34430 }, -- Glimmering Naaru Sliver
                { 24, 34429 }, -- Shifting Naaru Sliver
                { 25, 34428 }, -- Steely Naaru Sliver
                { 27, 34214 }, -- Muramasa
                { 28, 34231 }, -- Aegis of Angelic Fortune
            }
        },
        { -- SPKiljaeden
            name = AL["Kil'jaeden"],
            npcID = 25315,
            Level = 999,
            DisplayIDs = {{23200}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 34241 }, -- Cloak of Unforgivable Sin
                { 2, 34242 }, -- Tattered Cape of Antonidas
                { 3, 34339 }, -- Cowl of Light's Purity
                --{ 4, 34405 }, -- Helm of Arcane Purity
                { 4, 34340 }, -- Dark Conjuror's Collar
                { 5, 34342 }, -- Handguards of the Dawn
                --{ 7, 34406 }, -- Gloves of Tyri's Power
                { 6, 34344 }, -- Handguards of Defiled Worlds
                { 7, 34244 }, -- Duplicitous Guise
                --{ 10, 34404 }, -- Mask of the Fury Hunter
                { 8, 34245 }, -- Cover of Ursol the Wise
                --{ 12, 34403 }, -- Cover of Ursoc the Mighty
                { 9, 34333 }, -- Coif of Alleria
                { 10, 34332 }, -- Cowl of Gul'dan
                --{ 15, 34402 }, -- Shroud of Chieftain Ner'zhul
                { 11, 34343 }, -- Thalassian Ranger Gauntlets
                { 12, 34243 }, -- Helm of Burning Righteousness
                --{ 18, 34401 }, -- Helm of Uther's Resolve
                { 13, 34345 }, -- Crown of Anasterian
                --{ 20, 34400 }, -- Crown of Dath'Remar
                { 14, 34341 }, -- Borderland Paingrips
                { 16, 34334 }, -- Thori'dal, the Stars' Fury
                { 18, 34329 }, -- Crux of the Apocalypse
                { 19, 34247 }, -- Apolyon, the Soul-Render
                { 20, 34335 }, -- Hammer of Sanctification
                { 21, 34331 }, -- Hand of the Deceiver
                { 22, 34336 }, -- Sunflare
                { 23, 34337 }, -- Golden Staff of the Sin'dorei
            }
        },
        { -- SPPatterns
            name = AL["Patterns"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35212 }, -- Pattern: Leather Gauntlets of the Sun
                { 2, 35216 }, -- Pattern: Leather Chestguard of the Sun
                { 3, 35213 }, -- Pattern: Fletcher's Gloves of the Phoenix
                { 4, 35217 }, -- Pattern: Embrace of the Phoenix
                { 5, 35214 }, -- Pattern: Gloves of Immortal Dusk
                { 6, 35218 }, -- Pattern: Carapace of Sun and Shadow
                { 7, 35215 }, -- Pattern: Sun-Drenched Scale Gloves
                { 8, 35219 }, -- Pattern: Sun-Drenched Scale Chestguard
                { 9, 35204 }, -- Pattern: Sunfire Handwraps
                { 10, 35206 }, -- Pattern: Sunfire Robe
                { 11, 35205 }, -- Pattern: Hands of Eternal Light
                { 12, 35207 }, -- Pattern: Robe of Eternal Light
                { 13, 35198 }, -- Design: Loop of Forged Power
                { 14, 35201 }, -- Design: Pendant of Sunfire
                { 15, 35199 }, -- Design: Ring of Flowing Life
                { 16, 35202 }, -- Design: Amulet of Flowing Life
                { 17, 35200 }, -- Design: Hard Khorium Band
                { 18, 35203 }, -- Design: Hard Khorium Choker
                { 19, 35186 }, -- Schematic: Annihilator Holo-Gogs
                { 20, 35187 }, -- Schematic: Justicebringer 3000 Specs
                { 21, 35189 }, -- Schematic: Powerheal 9000 Lens
                { 22, 35190 }, -- Schematic: Hyper-Magnified Moon Specs
                { 23, 35191 }, -- Schematic: Wonderheal XT68 Shades
                { 24, 35192 }, -- Schematic: Primal-Attuned Goggles
                { 25, 35193 }, -- Schematic: Lightning Etched Specs
                { 26, 35194 }, -- Schematic: Surestrike Goggles v3.0
                { 27, 35195 }, -- Schematic: Mayhem Projection Goggles
                { 28, 35196 }, -- Schematic: Hard Khorium Goggles
                { 29, 35197 }, -- Schematic: Quad Deathblow X44 Goggles
            }
        },
        { -- SPTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 34351 }, -- Tranquil Majesty Wraps
                --{ 2, 34407 }, -- Tranquil Moonlight Wraps
                { 2, 34350 }, -- Gauntlets of the Ancient Shadowmoon
                --{ 4, 34409 }, -- Gauntlets of the Ancient Frostwolf
                { 3, 35733 }, -- Ring of Harmonic Beauty
                { 4, 34183 }, -- Shivering Felspine
                { 5, 34346 }, -- Mounting Vengeance
                { 6, 34349 }, -- Blade of Life's Inevitability
                { 7, 34348 }, -- Wand of Cleansing Light
                { 8, 34347 }, -- Wand of the Demonsoul
                { 10, 35273 }, -- Study of Advanced Smelting
                { 12, 34664 }, -- Sunmote
                { 16, 32228 }, -- Empyrean Sapphire
                { 17, 32231 }, -- Pyrestone
                { 18, 32229 }, -- Lionseye
                { 19, 32249 }, -- Seaspray Emerald
                { 20, 32230 }, -- Shadowsong Amethyst
                { 21, 32227 }, -- Crimson Spinel
                { 23, 35208 }, -- Plans: Sunblessed Gauntlets
                { 24, 35210 }, -- Plans: Sunblessed Breastplate
                { 25, 35209 }, -- Plans: Hard Khorium Battlefists
                { 26, 35211 }, -- Plans: Hard Khorium Battleplate
            }
        },
        T6_SET
    }
}
