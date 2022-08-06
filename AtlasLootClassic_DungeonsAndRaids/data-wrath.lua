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
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 3, AtlasLoot.WRATH_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", 2, nil, true)
local RAID10_DIFF = data:AddDifficulty(AL["10 Raid"], "r10", 3)
local RAID25_DIFF = data:AddDifficulty(AL["25 Raid"], "r25", 4)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID25_CONTENT = data:AddContentType(AL["25 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_WrathOfTheLichKing"

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time
local NAME_NEXUS = NAME_COLOR..AL["Nexus"]..":|r %s" -- The Nexus


local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
        { 1, "INV_Box_01", nil, AL["Normal"], nil },
		{ 2, 44582 }, -- Key to the Focusing Iris
        { 3, 45796 }, -- Celestial Planetarium Key
        { 4, 42482 }, -- The Violet Hold Key
		{ 16, "INV_Box_01", nil, AL["Heroic"], nil },
		{ 17, 44581 }, -- Heroic Key to the Focusing Iris
        { 18, 45798 }, -- Heroic Celestial Planetarium Key
    }
}


data["UtgardeKeep"] = {
	MapID = 206,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 72},
	items = {
        { -- UtgardeKeepKeleseth / 2
            name = AL["Prince Keleseth"],
            npcID = 23953,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35572 }, -- Reinforced Velvet Helm
                { 2, 35571 }, -- Dragon Stabler's Gauntlets
                { 3, 35570 }, -- Keleseth's Blade of Evocation
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37180 }, -- Battlemap Hide Helm
                { 4, 37178 }, -- Strategist's Belt
                { 5, 37179 }, -- Infantry Assault Blade
                { 6, 37177 }, -- Wand of the San'layn
            }
        },
        { -- UtgardeKeepSkarvald / 3
            name = AL["Skarvald the Constructor & Dalronn the Controller"],
            npcID = {24200, 24201},
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35575 }, -- Skarvald's Dragonskin Habergeon
                { 2, 35574 }, -- Chestplate of the Northern Lights
                { 3, 35573 }, -- Arm Blade of Augelmir
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37183 }, -- Bindings of the Tunneler
                { 4, 37184 }, -- Dalronn's Jerkin
                { 5, 37182 }, -- Helmet of the Constructor
                { 6, 37181 }, -- Dagger of Betrayal
            }
        },
        { -- UtgardeKeepIngvar / 4
            name = AL["Ingvar the Plunderer"],
            npcID = 23954,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35577 }, -- Holistic Patchwork Breeches
                { 2, 35578 }, -- Overlaid Chain Spaulders
                { 3, 35576 }, -- Ingvar's Monolithic Cleaver
                { 16, 33330 }, -- Ingvar's Head
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37194 }, -- Sharp-Barbed Leather Belt
                { 4, 37193 }, -- Staggering Legplates
                { 5, 37192 }, -- Annhylde's Ring
                { 6, 37191 }, -- Drake-Mounted Crossbow
                { 7, 37189 }, -- Breeches of the Caller
                { 8, 37188 }, -- Plunderer's Helmet
                { 9, 37186 }, -- Unsmashable Heavy Band
                { 10, 37190 }, -- Enraged Feral Staff
                { 16, 43102 }, -- Frozen Orb
                { 18, 41793 }, -- Design: Fierce Monarch Topaz
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35580 }, -- Skein Woven Mantle
		        { 2, 35579 }, -- Vrykul Shackles
            },
            [HEROIC_DIFF] = {
                { 1, 37197 }, -- Tattered Castle Drape
		        { 2, 37196 }, -- Runecaster's Mantle
            },
        },
        KEYS
    }
}

data["TheNexus"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4265,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {66, 71, 73},
	items = {
        { -- TheNexusTelestra / 6
            name = AL["Grand Magus Telestra"],
            npcID = 26731,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35605 }, -- Belt of Draconic Runes
                { 2, 35604 }, -- Insulating Bindings
                { 3, 35617 }, -- Wand of Shimmering Scales
                { 16, 21524 }, -- Red Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37139 }, -- Spaulders of the Careless Thief
                { 4, 37138 }, -- Bands of Channeled Energy
                { 5, 37135 }, -- Arcane-Shielded Helm
                { 6, 37134 }, -- Telestra's Journal
                { 16, 21524 }, -- Red Winter Hat
            }
        },
        { -- TheNexusAnomalus / 7
            name = AL["Anomalus"],
            npcID = 26763,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35599 }, -- Gauntlets of Serpent Scales
                { 2, 35600 }, -- Cleated Ice Boots
                { 3, 35598 }, -- Tome of the Lore Keepers
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 2, 37149 }, -- Helm of Anomalus
                { 3, 37144 }, -- Hauberk of the Arcane Wraith
                { 4, 37150 }, -- Rift Striders
                { 5, 37141 }, -- Amulet of Dazzling Light
            }
        },
        { -- TheNexusOrmorok / 8
            name = AL["Ormorok the Tree-Shaper"],
            npcID = 26794,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35602 }, -- Chiseled Stalagmite Pauldrons
                { 2, 35603 }, -- Greaves of the Blue Flight
                { 3, 35601 }, -- Drakonid Arm Blade
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37153 }, -- Gloves of the Crystal Gardener
                { 4, 37155 }, -- Frozen Forest Kilt
                { 5, 37152 }, -- Girdle of Ice
                { 6, 37151 }, -- Band of Frosted Thorns
            }
        },
        { -- TheNexusKolurgStoutbeardHEROIC / 9
            name = AtlasLoot:GetRetByFaction(AL["Commander Kolurg"], AL["Commander Stoutbeard"]),
            npcID = AtlasLoot:GetRetByFaction(26798, 26796),
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37728 }, -- Cloak of the Enemy
                { 4, 37731 }, -- Opposed Stasis Leggings
                { 5, 37730 }, -- Cleric's Linen Shoes
                { 6, 37729 }, -- Grips of Sculptured Icicles
            }
        },
        { -- TheNexusKeristrasza / 10
            name = AL["Keristrasza"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 35596 }, -- Attuned Crystalline Boots
                { 2, 35595 }, -- Glacier Sharpened Vileblade
                { 3, 35597 }, -- Band of Glittering Permafrost
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37172 }, -- Gloves of Glistening Runes
                { 4, 37170 }, -- Interwoven Scale Bracers
                { 5, 37171 }, -- Flame-Bathed Steel Girdle
                { 6, 37169 }, -- War Mace of Unrequited Love
                { 7, 37165 }, -- Crystal-Infused Tunic
                { 8, 37167 }, -- Dragon Slayer's Sabatons
                { 9, 37166 }, -- Sphere of Red Dragon's Blood
                { 10, 37162 }, -- Bulwark of the Noble Protector
                { 16, 43102 }, -- Frozen Orb
                { 18, 41794 }, -- Design: Deadly Monarch Topaz
            }
        },
        KEYS
    }
}

data["TheOculus"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4228,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- OcuDrakos / 61
            name = AL["Drakos the Interrogator"],
            npcID = 27654,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 36945 }, -- Verdisa's Cuffs of Dreaming
                { 2, 36946 }, -- Runic Cage Chestpiece
                { 3, 36943 }, -- Timeless Beads of Eternos
                { 4, 36944 }, -- Lifeblade of Belgaristrasz
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37258 }, -- Drakewing Raiments
                { 4, 37256 }, -- Scaled Armor of Drakos
                { 5, 37257 }, -- Band of Torture
                { 6, 37255 }, -- The Interrogator
            }
        },
        { -- OcuUrom / 62
            name = AL["Mage-Lord Urom"],
            npcID = 27655,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 36954 }, -- The Conjurer's Slippers
                { 2, 36951 }, -- Sidestepping Handguards
                { 3, 36953 }, -- Spaulders of Skillful Maneuvers
                { 4, 36952 }, -- Girdle of Obscuring
                { 16, 21525 }, -- Green Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37289 }, -- Sash of Phantasmal Images
                { 4, 37288 }, -- Catalytic Bands
                { 5, 37195 }, -- Band of Enchanted Growth
                { 6, 37264 }, -- Pendulum of Telluric Currents
                { 16, 21525 }, -- Green Winter Hat
            }
        },
        { -- OcuCloudstrider / 63
            name = AL["Varos Cloudstrider"],
            npcID = 27447,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 36947 }, -- Centrifuge Core Cloak
                { 2, 36949 }, -- Gloves of the Azure-Lord
                { 3, 36948 }, -- Horned Helm of Varos
                { 4, 36950 }, -- Wing Commander's Breastplate
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37261 }, -- Gloves of Radiant Light
                { 4, 37262 }, -- Azure Ringmail Leggings
                { 5, 37263 }, -- Legplates of the Oculus Guardian
                { 6, 37260 }, -- Cloudstrider's Waraxe
            }
        },
        { -- OcuEregos / 64
            name = AL["Ley-Guardian Eregos"],
            npcID = 27656,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 36973 }, -- Vestments of the Scholar
                { 2, 36971 }, -- Headguard of Westrift
                { 3, 36969 }, -- Helm of the Ley-Guardian
                { 4, 36974 }, -- Eredormu's Ornamented Chestguard
                { 5, 36961 }, -- Dragonflight Great-Ring
                { 6, 36972 }, -- Tome of Arcane Phenomena
                { 7, 36962 }, -- Wyrmclaw Battleaxe
                { 8, 36975 }, -- Malygos's Favor
                { 16, 41798 }, -- Design: Bracing Earthsiege Diamond
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37361 }, -- Cuffs of Winged Levitation
                { 4, 37363 }, -- Gauntlets of Dragon Wrath
                { 5, 37362 }, -- Leggings of Protective Auras
                { 6, 37360 }, -- Staff of Draconic Combat
                { 7, 37291 }, -- Ancient Dragon Spirit Cape
                { 8, 37294 }, -- Crown of Unbridled Magic
                { 9, 37293 }, -- Mask of the Watcher
                { 10, 37292 }, -- Ley-Guardian's Legguards
                { 16, 43102 }, -- Frozen Orb
                { 18, 52676 }, -- Cache of the Ley-Guardian
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 36978 }, -- Ley-Whelphide Belt
                { 2, 36977 }, -- Bindings of the Construct
                { 3, 36976 }, -- Ring-Lord's Leggings
            },
            [HEROIC_DIFF] = {
                { 1, 37366 }, -- Drake-Champion's Bracers
                { 2, 37365 }, -- Bands of the Sky Ring
                { 3, 37290 }, -- Dragon Prow Amulet
                { 4, 37364 }, -- Frostbridge Orb
            }
        },
        KEYS
    }
}


data["TheCullingOfStratholme"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 4100,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- CoTStratholmeSalramm
            name = AL["Salramm the Fleshcrafter"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37084 }, -- Flowing Cloak of Command
                { 2, 37095 }, -- Waistband of the Thuzadin
                { 3, 37088 }, -- Spiked Metal Cilice
                { 4, 37086 }, -- Tome of Salramm
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37684 }, -- Forgotten Shadow Hood
                { 4, 37682 }, -- Bindings of Dark Will
                { 5, 37683 }, -- Necromancer's Amulet
                { 6, 37681 }, -- Gavel of the Fleshcrafter
            }
        },
        { -- CoTStratholmeMeathook
            name = AL["Meathook"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37083 }, -- Kilt of Sewn Flesh
                { 2, 37082 }, -- Slaughterhouse Sabatons
                { 3, 37079 }, -- Enchanted Wire Stitching
                { 4, 37081 }, -- Meathook's Slicer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37680 }, -- Belt of Unified Souls
                { 4, 37678 }, -- Bile-Cured Gloves
                { 5, 37679 }, -- Spaulders of the Abomination
                { 6, 37675 }, -- Legplates of Steel Implants
            }
        },
        { -- CoTStratholmeEpoch
            name = AL["Chrono-Lord Epoch"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37106 }, -- Ouroboros Belt
                { 2, 37105 }, -- Treads of Altered History
                { 3, 37096 }, -- Necklace of the Chrono-Lord
                { 4, 37099 }, -- Sempiternal Staff
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37687 }, -- Gloves of Distorted Time
                { 4, 37686 }, -- Cracked Epoch Grasps
                { 5, 37688 }, -- Legplates of the Infinite Drakonid
                { 6, 37685 }, -- Mobius Band
            }
        },
        { -- CoTStratholmeMalGanis
            name = AL["Mal'Ganis"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37113 }, -- Demonic Fabric Bands
                { 2, 37114 }, -- Gloves of Northern Lordaeron
                { 3, 37110 }, -- Gauntlets of Dark Conversion
                { 4, 37109 }, -- Discarded Silver Hand Spaulders
                { 5, 37111 }, -- Soul Preserver
                { 6, 37108 }, -- Dreadlord's Blade
                { 7, 37112 }, -- Beguiling Scepter
                { 8, 37107 }, -- Leeka's Shield
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37696 }, -- Plague-Infected Bracers
                { 4, 37695 }, -- Legguards of Nature's Power
                { 5, 37694 }, -- Band of Guile
                { 6, 37693 }, -- Greed
                { 7, 43085 }, -- Royal Crest of Lordaeron
                { 8, 37691 }, -- Mantle of Deceit
                { 9, 37690 }, -- Pauldrons of Destiny
                { 10, 37689 }, -- Pendant of the Nathrezim
                { 11, 37692 }, -- Pierce's Pistol
                { 16, 43102 }, -- Frozen Orb
            }
        },
        { -- CoTStratholmeInfiniteCorruptorHEROIC
            name = AL["Infinite Corruptor"],
            -- npcID = 0,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
		        { 16, 43951 }, -- Reins of the Bronze Drake
            }
        },
        { -- CoTHillsbradTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 37117 }, -- King's Square Bracers
                { 2, 37116 }, -- Epaulets of Market Row
                { 3, 37115 }, -- Crusader's Square Pauldrons
            }
        },
        KEYS
    }
}



data["TStratholmeEpoch222"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 4100,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- CoTHillsbradDrake
            name = AL["Lieutenant Drake"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {

            },
            [HEROIC_DIFF] = {

            }
        },

        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 37117 }, -- King's Square Bracers
                { 2, 37116 }, -- Epaulets of Market Row
                { 3, 37115 }, -- Crusader's Square Pauldrons
            }
        },
        KEYS
    }
}