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

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID25_DIFF = data:AddDifficulty("25RAID")

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID20_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID25_CONTENT = data:AddContentType(AL["25 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_WrathOfTheLichKing"

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time
local NAME_NEXUS = NAME_COLOR..AL["Nexus"]..":|r %s" -- The Nexus
local NAME_AZJOL = NAME_COLOR..AL["Azjol"]..":|r %s" -- Azjol
local NAME_ULDUAR = NAME_COLOR..AL["Ulduar"]..":|r %s" -- Ulduar
local NAME_UTGARDE = NAME_COLOR..AL["Utgarde"]..":|r %s" -- Utgarde
local NAME_ICC = NAME_COLOR..AL["ICC"]..":|r %s" -- ICC
local NAME_AT = NAME_COLOR..AL["AT"]..":|r %s" -- Argent Tournament

-- colors
local BLUE = "|cff6666ff"
local GREY = "|cff999999"
local GREN = "|cff66cc33"
local _RED = "|cffcc6666"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"

-- format
local BONUS_LOOT_SPLIT = "%s - %s"


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

data["AzjolNerub"] = {
    nameFormat = NAME_AZJOL,
	MapID = 4277,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {67, 72, 74},
	items = {
        { -- AzjolNerubKrikthir / 11
            name = AL["Krik'thir the Gatewatcher"],
            npcID = 28684,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35657 }, -- Exquisite Spider-Silk Footwraps
                { 2, 35656 }, -- Aura Focused Gauntlets
                { 3, 35655 }, -- Cobweb Machete
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37218 }, -- Stone-Worn Footwraps
                { 4, 37219 }, -- Custodian's Chestpiece
                { 5, 37217 }, -- Golden Limb Bands
                { 6, 37216 }, -- Facade Shield of Glyphs
            }
        },
        { -- AzjolNerubHadronox / 12
            name = AL["Hadronox"],
            npcID = 28921,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35660 }, -- Spinneret Epaulets
                { 2, 35659 }, -- Treads of Aspiring Heights
                { 3, 35658 }, -- Life-Staff of the Web Lair
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37222 }, -- Egg Sac Robes
                { 4, 37230 }, -- Grotto Mist Gloves
                { 5, 37221 }, -- Hollowed Mandible Legplates
                { 6, 37220 }, -- Essence of Gossamer
            }
        },
        { -- AzjolNerubAnubarak / 13
            name = AL["Anub'arak"],
            npcID = 29120,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35663 }, -- Charmed Silken Cord
                { 2, 35662 }, -- Wing Cover Girdle
                { 3, 35661 }, -- Signet of Arachnathid Command
                { 16, 43411 }, -- Anub'arak's Broken Husk
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37242 }, -- Sash of the Servant
                { 4, 37240 }, -- Flamebeard's Bracers
                { 5, 37241 }, -- Ancient Aligned Girdle
                { 6, 37238 }, -- Rod of the Fallen Monarch
                { 7, 37236 }, -- Insect Vestments
                { 8, 37237 }, -- Chitin Shell Greathelm
                { 9, 37232 }, -- Ring of the Traitor King
                { 10, 37235 }, -- Crypt Lord's Deft Blade
                { 16, 43102 }, -- Frozen Orb
                { 18, 41796 }, -- Design: Infused Twilight Opal
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [HEROIC_DIFF] = {
                { 1, 37243 }, -- Treasure Seeker's Belt
                { 2, 37625 }, -- Web Winder Gloves
                { 3, 37624 }, -- Stained-Glass Shard Ring
            }
        },
        KEYS
    }
}

data["AhnKahet"] = {
    nameFormat = NAME_AZJOL,
	MapID = 4494,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {68, 73, 75},
	items = {
        { -- AhnkahetNadox / 15
            name = AL["Elder Nadox"],
            npcID = 29309,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35607 }, -- Ahn'kahar Handwraps
                { 2, 35608 }, -- Crawler-Emblem Belt
                { 3, 35606 }, -- Blade of Nadox
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37594 }, -- Elder Headpiece
                { 4, 37593 }, -- Sprinting Shoulderpads
                { 5, 37592 }, -- Brood Plague Helmet
                { 6, 37591 }, -- Nerubian Shield Ring
            }
        },
        { -- AhnkahetTaldaram / 16
            name = AL["Prince Taldaram"],
            npcID = 29308,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35611 }, -- Gloves of the Blood Prince
                { 2, 35610 }, -- Slasher's Amulet
                { 3, 35609 }, -- Talisman of Scourge Command
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37613 }, -- Flame Sphere Bindings
                { 4, 37614 }, -- Gauntlets of the Plundering Geist
                { 5, 37612 }, -- Bonegrinder Breastplate
                { 6, 37595 }, -- Necklace of Taldaram
            }
        },
        { -- AhnkahetAmanitarHEROIC / 17
            name = AL["Amanitar"],
            npcID = 30258,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 2, 43287 }, -- Silken Bridge Handwraps
                { 3, 43286 }, -- Legguards of Swarming Attacks
                { 4, 43285 }, -- Amulet of the Spell Flinger
                { 5, 43284 }, -- Amanitar Skullbow
            }
        },
        { -- AhnkahetJedoga / 18
            name = AL["Jedoga Shadowseeker"],
            npcID = 29310,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 43278 }, -- Cloak of the Darkcaster
                { 2, 43279 }, -- Battlechest of the Twilight Cult
                { 3, 43277 }, -- Jedoga's Greatring
                { 16, 21524 }, -- Red Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43283 }, -- Subterranean Waterfall Shroud
                { 4, 43280 }, -- Faceguard of the Hammer Clan
                { 5, 43282 }, -- Shadowseeker's Pendant
                { 6, 43281 }, -- Edge of Oblivion
                { 16, 21524 }, -- Red Winter Hat
            }
        },
        { -- AhnkahetVolazj / 19
            name = AL["Herald Volazj"],
            npcID = 29311,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 35612 }, -- Mantle of Echoing Bats
                { 2, 35613 }, -- Pyramid Embossed Belt
                { 3, 35614 }, -- Volazj's Sabatons
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37622 }, -- Skirt of the Old Kingdom
                { 4, 37623 }, -- Fiery Obelisk Handguards
                { 5, 37620 }, -- Bracers of the Herald
                { 6, 37619 }, -- Wand of Ahnkahet
                { 7, 37616 }, -- Kilt of the Forgotten One
                { 8, 37618 }, -- Greaves of Ancient Evil
                { 9, 37617 }, -- Staff of Sinister Claws
                { 10, 37615 }, -- Titanium Compound Bow
                { 16, 43102 }, -- Frozen Orb
                { 18, 41790 }, -- Design: Precise Scarlet Ruby
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35616 }, -- Spored Tendrils Spaulders
		        { 2, 35615 }, -- Glowworm Cavern Bindings
            },
            [HEROIC_DIFF] = {
                { 1, 37625 }, -- Web Winder Gloves
		        { 2, 37624 }, -- Stained-Glass Shard Ring
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

data["DrakTharonKeep"] = {
	MapID = 4196,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {69, 74, 76},
	items = {
        { -- DrakTharonKeepTrollgore / 21
            name = AL["Trollgore"],
            npcID = 26630,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35620 }, -- Berserker's Horns
                { 2, 35619 }, -- Infection Resistant Legguards
                { 3, 35618 }, -- Troll Butcherer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37715 }, -- Cowl of the Dire Troll
                { 4, 37714 }, -- Batrider's Cord
                { 5, 37717 }, -- Legs of Physical Regeneration
                { 6, 37712 }, -- Terrace Defence Boots
            }
        },
        { -- DrakTharonKeepNovos / 22
            name = AL["Novos the Summoner"],
            npcID = 26631,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35632 }, -- Robes of Novos
                { 2, 35631 }, -- Crystal Pendant of Warding
                { 3, 35630 }, -- Summoner's Stone Gavel
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37722 }, -- Breastplate of Undeath
                { 4, 37718 }, -- Temple Crystal Fragment
                { 5, 37721 }, -- Cursed Lich Blade
            }
        },
        { -- DrakTharonKeepKingDred / 23
            name = AL["King Dred"],
            npcID = 27483,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35635 }, -- Stable Master's Breeches
                { 2, 35634 }, -- Scabrous-Hide Helm
                { 3, 35633 }, -- Staff of the Great Reptile
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37725 }, -- Savage Wound Wrap
                { 4, 37724 }, -- Handler's Arm Strap
                { 5, 37726 }, -- King Dred's Helm
                { 6, 37723 }, -- Incisor Fragment
            }
        },
        { -- DrakTharonKeepTharonja / 24
            name = AL["The Prophet Tharon'ja"],
            npcID = 26632,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35638 }, -- Helmet of Living Flesh
                { 2, 35637 }, -- Muradin's Lost Greaves
                { 3, 35636 }, -- Tharon'ja's Aegis
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37798 }, -- Overlook Handguards
                { 4, 37791 }, -- Leggings of the Winged Serpent
                { 5, 37788 }, -- Limb Regeneration Bracers
                { 6, 37784 }, -- Keystone Great-Ring
                { 7, 37735 }, -- Ziggurat Imprinted Chestguard
                { 8, 37732 }, -- Spectral Seal of the Prophet
                { 9, 37734 }, -- Talisman of Troll Divinity
                { 10, 37733 }, -- Mojo Masked Crusher
                { 16, 43102 }, -- Frozen Orb
                { 18, 41795 }, -- Design: Timeless Forest Emerald
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35641 }, -- Scytheclaw Boots
                { 2, 35640 }, -- Darkweb Bindings
                { 3, 35639 }, -- Brighthelm of Guarding
            },
            [HEROIC_DIFF] = {
                { 1, 37799 }, -- Reanimator's Cloak
                { 2, 37800 }, -- Aviary Guardsman's Hauberk
                { 3, 37801 }, -- Waistguard of the Risen Knight
            },
        },
        KEYS
    }
}

data["Gundrak"] = {
	MapID = 4416,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- GundrakSladran / 34
            name = AL["Slad'ran"],
            npcID = 29304,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35584 }, -- Embroidered Gown of Zul'drak
                { 2, 35585 }, -- Cannibal's Legguards
                { 3, 35583 }, -- Witch Doctor's Wildstaff
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37629 }, -- Slithering Slippers
                { 4, 37628 }, -- Slad'ran's Coiled Cord
                { 5, 37627 }, -- Snake Den Spaulders
                { 6, 37626 }, -- Wand of Sseratus
            }
        },
        { -- GundrakColossus / 35
            name = AL["Drakkari Colossus"],
            npcID = 29307,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35591 }, -- Shoulderguards of the Ice Troll
                { 2, 35592 }, -- Hauberk of Totemic Mastery
                { 3, 35590 }, -- Drakkari Hunting Bow
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37637 }, -- Living Mojo Belt
                { 4, 37636 }, -- Helm of Cheated Fate
                { 5, 37634 }, -- Bracers of the Divine Elemental
                { 6, 37635 }, -- Pauldrons of the Colossus
            }
        },
        { -- GundrakMoorabi / 36
            name = AL["Moorabi"],
            npcID = 29305,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35588 }, -- Forlorn Breastplate of War
                { 2, 35589 }, -- Arcane Focal Signet
                { 3, 35587 }, -- Frozen Scepter of Necromancy
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37630 }, -- Shroud of Moorabi
                { 4, 37633 }, -- Ground Tremor Helm
                { 5, 37632 }, -- Mojo Frenzy Greaves
                { 6, 37631 }, -- Fist of the Deity
            }
        },
        { -- GundrakEckHEROIC / 37
            name = AL["Eck the Ferocious"],
            npcID = 29932,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43313 }, -- Leggings of the Ruins Dweller
                { 4, 43312 }, -- Gorloc Muddy Footwraps
                { 5, 43311 }, -- Helmet of the Shrine
                { 6, 43310 }, -- Engraved Chestplate of Eck
            }
        },
        { -- GundrakGaldarah / 38
            name = AL["Gal'darah"],
            npcID = 29306,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 43305 }, -- Shroud of Akali
                { 2, 43309 }, -- Amulet of the Stampede
                { 3, 43306 }, -- Gal'darah's Signet
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37643 }, -- Sash of Blood Removal
                { 4, 37644 }, -- Gored Hide Legguards
                { 5, 37645 }, -- Horn-Tipped Gauntlets
                { 6, 37642 }, -- Hemorrhaging Circle
                { 7, 37641 }, -- Arcane Flame Altar-Garb
                { 8, 37640 }, -- Boots of Transformation
                { 9, 37639 }, -- Grips of the Beast God
                { 10, 37638 }, -- Offering of Sacrifice
                { 16, 43102 }, -- Frozen Orb
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35594 }, -- Snowmelt Silken Cinch
		        { 2, 35593 }, -- Steel Bear Trap Bracers
            },
            [HEROIC_DIFF] = {
                { 1, 37647 }, -- Cloak of Bloodied Waters
                { 2, 37648 }, -- Belt of Tasseled Lanterns
                { 3, 37646 }, -- Burning Skull Pendant
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

data["UtgardeKeep"] = {
    nameFormat = NAME_UTGARDE,
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

data["UtgardePinnacle"] = {
    nameFormat = NAME_UTGARDE,
	MapID = 1196,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- UPSorrowgrave / 58
            name = AL["Svala Sorrowgrave"],
            npcID = 26668,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 37043 }, -- Tear-Linked Gauntlets
                { 2, 37040 }, -- Svala's Bloodied Shackles
                { 3, 37037 }, -- Ritualistic Athame
                { 4, 37038 }, -- Brazier Igniter
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37370 }, -- Cuffs of the Trussed Hall
                { 4, 37369 }, -- Sorrowgrave's Breeches
                { 5, 37368 }, -- Silent Spectator Shoulderpads
                { 6, 37367 }, -- Echoing Stompers
            }
        },
        { -- UPPalehoof / 59
            name = AL["Gortok Palehoof"],
            npcID = 26687,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 37048 }, -- Shroud of Resurrection
                { 2, 37052 }, -- Reanimated Armor
                { 3, 37051 }, -- Seal of Valgarde
                { 4, 37050 }, -- Trophy Gatherer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37374 }, -- Ravenous Leggings of the Furbolg
                { 4, 37373 }, -- Massive Spaulders of the Jormungar
                { 5, 37376 }, -- Ferocious Pauldrons of the Rhino
                { 6, 37371 }, -- Ring of the Frenzied Wolvar
            }
        },
        { -- UPSkadi / 56
            name = AL["Skadi the Ruthless"],
            npcID = 26693,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 37055 }, -- Silken Amice of the Ymirjar
                { 2, 37057 }, -- Drake Rider's Tunic
                { 3, 37056 }, -- Harpooner's Striders
                { 4, 37053 }, -- Amulet of Deflected Blows
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 44151 }, -- Reins of the Blue Proto-Drake
                { 4, 37389 }, -- Crenelation Leggings
                { 5, 37379 }, -- Skadi's Iron Belt
                { 6, 37377 }, -- Netherbreath Spellblade
                { 7, 37384 }, -- Staff of Wayward Principles
            }
        },
        { -- UPYmiron / 57
            name = AL["King Ymiron"],
            npcID = 26861,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 37067 }, -- Ceremonial Pyre Mantle
                { 2, 37062 }, -- Crown of Forgotten Kings
                { 3, 37066 }, -- Ancient Royal Legguards
                { 4, 37058 }, -- Signet of Ranulf
                { 5, 37064 }, -- Vestige of Haldor
                { 6, 37060 }, -- Jeweled Coronation Sword
                { 7, 37065 }, -- Ymiron's Blade
                { 8, 37061 }, -- Tor's Crest
                { 16, 41797 }, -- Design: Austere Earthsiege Diamond
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37408 }, -- Girdle of Bane
                { 4, 37409 }, -- Gilt-Edged Leather Gauntlets
                { 5, 37407 }, -- Sovereign's Belt
                { 6, 37401 }, -- Red Sword of Courage
                { 7, 37398 }, -- Mantle of Discarded Ways
                { 8, 37395 }, -- Ornamented Plate Regalia
                { 9, 37397 }, -- Gold Amulet of Kings
                { 10, 37390 }, -- Meteorite Whetstone
                { 16, 43102 }, -- Frozen Orb
                { 18, 41797 }, -- Design: Austere Earthsiege Diamond
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 37070 }, -- Tundra Wolf Boots
                { 2, 37069 }, -- Dragonflayer Seer's Bindings
                { 3, 37068 }, -- Berserker's Sabatons
            },
            [HEROIC_DIFF] = {
                { 1, 37587 }, -- Ymirjar Physician's Robe
                { 2, 37590 }, -- Bands of Fading Light
                { 3, 37410 }, -- Tracker's Balanced Knives
            },
        },
        KEYS
    }
}

data["HallsofStone"] = {
    nameFormat = NAME_ULDUAR,
	MapID = 4264,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {72, 77, 79},
	items = {
        { -- HallsofStoneMaiden / 40
            name = AL["Maiden of Grief"],
            npcID = 27975,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 38614 }, -- Embrace of Sorrow
                { 2, 38613 }, -- Chain of Fiery Orbs
                { 3, 38611 }, -- Ringlet of Repose
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 38616 }, -- Maiden's Girdle
                { 4, 38615 }, -- Lightning-Charged Gloves
                { 5, 38617 }, -- Woeful Band
                { 6, 38618 }, -- Hammer of Grief
            }
        },
        { -- HallsofStoneKrystallus / 41
            name = AL["Krystallus"],
            npcID = 27977,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35673 }, -- Leggings of Burning Gleam
                { 2, 35672 }, -- Hollow Geode Helm
                { 3, 35670 }, -- Brann's Lost Mining Helmet
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37652 }, -- Spaulders of Krystallus
                { 4, 37650 }, -- Shardling Legguards
                { 5, 37651 }, -- The Prospector's Prize
            }
        },
        { -- HallsofStoneTribunal / 42
            name = AL["The Tribunal of Ages"],
            npcID = 28234,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35677 }, -- Cosmos Vestments
                { 2, 35676 }, -- Constellation Leggings
                { 3, 35675 }, -- Linked Armor of the Sphere
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37655 }, -- Mantle of the Tribunal
                { 4, 37656 }, -- Raging Construct Bands
                { 5, 37654 }, -- Sabatons of the Ages
                { 6, 37653 }, -- Sword of Justice
            }
        },
        { -- HallsofStoneSjonnir / 43
            name = AL["Sjonnir The Ironshaper"],
            npcID = 27978,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35679 }, -- Static Cowl
                { 2, 35678 }, -- Ironshaper's Legplates
                { 3, 35680 }, -- Amulet of Wills
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37669 }, -- Leggings of the Stone Halls
                { 4, 37668 }, -- Bands of the Stoneforge
                { 5, 37670 }, -- Sjonnir's Girdle
                { 6, 37667 }, -- The Fleshshaper
                { 7, 37666 }, -- Boots of the Whirling Mist
                { 8, 37658 }, -- Sun-Emblazoned Chestplate
                { 9, 37657 }, -- Spark of Life
                { 10, 37660 }, -- Forge Ember
                { 16, 43102 }, -- Frozen Orb
                { 18, 41792 }, -- Design: Deft Monarch Topaz
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35682 }, -- Rune Giant Bindings
                { 2, 35683 }, -- Palladium Ring
                { 3, 35681 }, -- Unrelenting Blade
            },
            [HEROIC_DIFF] = {
                { 1, 37673 }, -- Dark Runic Mantle
                { 2, 37672 }, -- Patina-Coated Breastplate
                { 3, 37671 }, -- Refined Ore Gloves
            },
        },
        KEYS
    }
}

data["HallsofLightning"] = {
    nameFormat = NAME_ULDUAR,
	MapID = 4272,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {75, 79, 80},
	items = {
        { -- HallsofLightningBjarngrim / 45
            name = AL["General Bjarngrim"],
            npcID = 28586,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 36982 }, -- Mantle of Electrical Charges
                { 2, 36979 }, -- Bjarngrim Family Signet
                { 3, 36980 }, -- Hewn Sparring Quarterstaff
                { 4, 36981 }, -- Hardened Vrykul Throwing Axe
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37825 }, -- Traditionally Dyed Handguards
                { 4, 37818 }, -- Patroller's War-Kilt
                { 5, 37814 }, -- Iron Dwarf Smith Pauldrons
                { 6, 37826 }, -- The General's Steel Girdle
            }
        },
        { -- HallsofLightningVolkhan / 46
            name = AL["Volkhan"],
            npcID = 28587,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 36983 }, -- Cape of Seething Steam
                { 2, 36985 }, -- Volkhan's Hood
                { 3, 36986 }, -- Kilt of Molten Golems
                { 4, 36984 }, -- Eternally Folded Blade
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37840 }, -- Shroud of Reverberation
                { 4, 37843 }, -- Giant-Hair Woven Gloves
                { 5, 37842 }, -- Belt of Vivacity
                { 6, 37841 }, -- Slag Footguards
            }
        },
        { -- HallsofLightningIonar / 47
            name = AL["Ionar"],
            npcID = 28546,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 39536 }, -- Thundercloud Grasps
                { 2, 39657 }, -- Tornado Cuffs
                { 3, 39534 }, -- Pauldrons of the Lightning Revenant
                { 4, 39535 }, -- Ionar's Girdle
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37846 }, -- Charged-Bolt Grips
                { 4, 37845 }, -- Cord of Swirling Winds
                { 5, 37826 }, -- The General's Steel Girdle
                { 6, 37844 }, -- Winged Talisman
            }
        },
        { -- HallsofLightningLoken / 48
            name = AL["Loken"],
            npcID = 28923,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 36991 }, -- Raiments of the Titans
                { 2, 36996 }, -- Hood of the Furtive Assassin
                { 3, 36992 }, -- Leather-Braced Chain Leggings
                { 4, 36995 }, -- Fists of Loken
                { 5, 36988 }, -- Chaotic Spiral Amulet
                { 6, 36993 }, -- Seal of the Pantheon
                { 7, 36994 }, -- Projectile Activator
                { 8, 36989 }, -- Ancient Measuring Rod
                { 16, 41799 }, -- Design: Eternal Earthsiege Diamond
                { 18, 43151 }, -- Loken's Tongue
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37854 }, -- Woven Bracae Leggings
                { 4, 37853 }, -- Advanced Tooled-Leather Bands
                { 5, 37855 }, -- Mail Girdle of the Audient Earth
                { 6, 37852 }, -- Colossal Skull-Clad Cleaver
                { 7, 37851 }, -- Ornate Woolen Stola
                { 8, 37850 }, -- Flowing Sash of Order
                { 9, 37849 }, -- Planetary Helm
                { 10, 37848 }, -- Lightning Giant Staff
                { 16, 43102 }, -- Frozen Orb
                { 18, 41799 }, -- Design: Eternal Earthsiege Diamond
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 36997 }, -- Sash of the Hardened Watcher
                { 2, 37000 }, -- Storming Vortex Bracers
                { 3, 36999 }, -- Boots of the Terrestrial Guardian
            },
            [HEROIC_DIFF] = {
                { 1, 37858 }, -- Awakened Handguards
                { 2, 37857 }, -- Helm of the Lightning Halls
                { 3, 37856 }, -- Librarian's Paper Cutter
            },
        },
        KEYS
    }
}

data["VioletHold"] = {
	MapID = 4415,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {70, 75, 77},
	items = {
        { -- VioletHoldErekem / 26
            name = AL["Erekem"],
            npcID = 29315,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 43363 }, -- Screeching Cape
                { 2, 43375 }, -- Trousers of the Arakkoa
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43406 }, -- Cloak of the Gushing Wound
                { 4, 43405 }, -- Sabatons of Erekem
                { 5, 43407 }, -- Stormstrike Mace
            }
        },
        { -- VioletHoldZuramat / 27
            name = AL["Zuramat the Obliterator"],
            npcID = 29314,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 43353 }, -- Void Sentry Legplates
                { 2, 43358 }, -- Pendant of Shadow Beams
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43403 }, -- Shroud of Darkness
                { 4, 43402 }, -- The Obliterator Greaves
                { 5, 43404 }, -- Zuramat's Necklace
            }
        },
        { -- VioletHoldXevozz / 28
            name = AL["Xevozz"],
            npcID = 29266,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35644 }, -- Xevozz's Belt
                { 2, 35642 }, -- Riot Shield
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37867 }, -- Footwraps of Teleportation
                { 4, 37868 }, -- Girdle of the Ethereal
                { 5, 37861 }, -- Necklace of Arcane Spheres
            }
        },
        { -- VioletHoldIchoron / 29
            name = AL["Ichoron"],
            npcID = 29313,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35647 }, -- Handguards of Rapid Pursuit
                { 2, 35643 }, -- Spaulders of Ichoron
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43401 }, -- Water-Drenched Robe
                { 4, 37862 }, -- Gauntlets of the Water Revenant
                { 5, 37869 }, -- Globule Signet
            }
        },
        { -- VioletHoldMoragg / 30
            name = AL["Moragg"],
            npcID = 29316,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 43387 }, -- Shoulderplates of the Beholder
                { 2, 43382 }, -- Band of Eyes
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43410 }, -- Moragg's Chestguard
                { 4, 43408 }, -- Solitare of Reflecting Beams
                { 5, 43409 }, -- Saliva Corroded Pike
            }
        },
        { -- VioletHoldLavanthor / 31
            name = AL["Lavanthor"],
            npcID = 29312,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 35646 }, -- Lava Burn Gloves
                { 2, 35645 }, -- Prison Warden's Shotgun
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37870 }, -- Twin-Headed Boots
                { 4, 37872 }, -- Lavanthor's Talisman
                { 5, 37871 }, -- The Key
            }
        },
        { -- VioletHoldCyanigosa / 32
            name = AL["Cyanigosa"],
            npcID = 31134,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 7,
            [NORMAL_DIFF] = {
                { 1, 35650 }, -- Boots of the Portal Guardian
                { 2, 35651 }, -- Plate Claws of the Dragon
                { 3, 35649 }, -- Jailer's Baton
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37884 }, -- Azure Cloth Bindings
                { 4, 37886 }, -- Handgrips of the Savage Emissary
                { 5, 43500 }, -- Bolstered Legplates
                { 6, 37883 }, -- Staff of Trickery
                { 7, 37876 }, -- Cyanigosa's Leggings
                { 8, 37875 }, -- Spaulders of the Violet Hold
                { 9, 37874 }, -- Gauntlets of Capture
                { 10, 37873 }, -- Mark of the War Prisoner
                { 16, 43102 }, -- Frozen Orb
                { 18, 41791 }, -- Design: Thick Autumn's Glow
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35654 }, -- Bindings of the Bastille
                { 2, 35653 }, -- Dungeon Girdle
                { 3, 35652 }, -- Incessant Torch
            },
            [HEROIC_DIFF] = {
                { 1, 35654 }, -- Bindings of the Bastille
                { 2, 37890 }, -- Chain Gang Legguards
                { 3, 37891 }, -- Cast Iron Shackles
                { 4, 35653 }, -- Dungeon Girdle
                { 5, 37889 }, -- Prison Manifest
                { 6, 35652 }, -- Incessant Torch
            },
        },
        KEYS
    }
}

data["TrialoftheChampion"] = {
    nameFormat = NAME_AT,
	MapID = 4100,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- TrialoftheChampionChampions / 213
            name = AL["Grand Champions"],
            npcID = {34705,34702,34701,34657,34703, 35572,35569,35571,35570,35617},
            ObjectID = 195709,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 47173 }, -- Bindings of the Wicked
                { 2, 47170 }, -- Belt of Fierce Competition
                { 3, 47174 }, -- Binding of the Tranquil Glade
                { 4, 47175 }, -- Scale Boots of the Outlander
                { 5, 47172 }, -- Helm of the Bested Gallant
                { 6, 47171 }, -- Legguards of Abandoned Fealty
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47249 }, -- Leggings of the Snowy Bramble
                { 4, 47248 }, -- Treads of Dismal Fortune
                { 5, 47250 }, -- Pauldrons of the Deafening Gale
                { 6, 47244 }, -- Chestguard of the Ravenous Fiend
                { 7, 47243 }, -- Mark of the Relentless
                { 8, 47493 }, -- Edge of Ruin
                { 16, 44990 }, -- Champion's Seal
            }
        },
        { -- TrialoftheChampionConfessorPaletress / 214
            name = AL["Argent Confessor Paletress"],
            npcID = 34928,
            Level = 80,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 47181 }, -- Belt of the Churning Blaze
                { 2, 47218 }, -- The Confessor's Binding
                { 3, 47185 }, -- Leggings of the Haggard Apprentice
                { 4, 47217 }, -- Gaze of the Somber Keeper
                { 5, 47177 }, -- Gloves of the Argent Fanatic
                { 6, 47178 }, -- Carapace of Grim Visions
                { 7, 47211 }, -- Wristguards of Ceaseless Regret
                { 8, 47176 }, -- Breastplate of the Imperial Joust
                { 9, 47212 }, -- Mercy's Hold
                { 10, 47219 }, -- Brilliant Hailstone Amulet
                { 11, 47213 }, -- Abyssal Rune
                { 12, 47214 }, -- Banner of Victory
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47498 }, -- Gloves of Dismal Fortune
                { 4, 47496 }, -- Armbands of the Wary Lookout
                { 5, 47245 }, -- Pauldrons of Concealed Loathing
                { 6, 47497 }, -- Helm of the Crestfallen Challenger
                { 7, 47514 }, -- Regal Aurous Shoulderplates
                { 8, 47510 }, -- Trueheart Girdle
                { 9, 47495 }, -- Legplates of Relentless Onslaught
                { 10, 47511 }, -- Plated Greaves of Providence
                { 11, 47494 }, -- Ancient Pendant of Arathor
                { 12, 47512 }, -- Sinner's Confession
                { 13, 47500 }, -- Peacekeeper Blade
                { 14, 47522 }, -- Marrowstrike
                { 16, 44990 }, -- Champion's Seal
            }
        },
        { -- TrialoftheChampionEadricthePure / 215
            name = AL["Eadric the Pure"],
            npcID = 35119,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 47181 }, -- Belt of the Churning Blaze
                { 2, 47185 }, -- Leggings of the Haggard Apprentice
                { 3, 47210 }, -- Mantle of Gnarled Overgrowth
                { 4, 47177 }, -- Gloves of the Argent Fanatic
                { 5, 47202 }, -- Leggings of Brazen Trespass
                { 6, 47178 }, -- Carapace of Grim Visions
                { 7, 47176 }, -- Breastplate of the Imperial Joust
                { 8, 47197 }, -- Gauntlets of the Stouthearted Crusader
                { 9, 47201 }, -- Boots of Heartfelt Repentance
                { 10, 47199 }, -- Greaves of the Grand Paladin
                { 11, 47200 }, -- Signet of Purity
                { 12, 47213 }, -- Abyssal Rune
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47501 }, -- Kurisu's Indecision
                { 4, 47496 }, -- Armbands of the Wary Lookout
                { 5, 47498 }, -- Gloves of Dismal Fortune
                { 6, 47504 }, -- Barkhide Treads
                { 7, 47497 }, -- Helm of the Crestfallen Challenger
                { 8, 47502 }, -- Majestic Silversmith Shoulderplates
                { 9, 47495 }, -- Legplates of Relentless Onslaught
                { 10, 47503 }, -- Legplates of the Argent Armistice
                { 11, 47494 }, -- Ancient Pendant of Arathor
                { 12, 47500 }, -- Peacekeeper Blade
                { 13, 47509 }, -- Mariel's Sorrow
                { 14, 47508 }, -- Aledar's Battlestar
                { 16, 44990 }, -- Champion's Seal
            }
        },
        { -- TrialoftheChampionBlackKnight / 216
            name = AL["The Black Knight"],
            npcID = 35451,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 47232 }, -- Drape of the Undefeated
                { 2, 47226 }, -- Mantle of Inconsolable Fear
                { 3, 47230 }, -- Handwraps of Surrendered Hope
                { 4, 47221 }, -- Shoulderpads of the Infamous Knave
                { 5, 47231 }, -- Belt of Merciless Cruelty
                { 6, 47228 }, -- Leggings of the Bloodless Knight
                { 7, 47220 }, -- Helm of the Violent Fray
                { 8, 47229 }, -- Girdle of Arrogant Downfall
                { 9, 47227 }, -- Girdle of the Pallid Knight
                { 10, 47222 }, -- Uruka's Band of Zeal
                { 11, 47215 }, -- Tears of the Vanquished
                { 12, 47216 }, -- The Black Heart
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47564 }, -- Gaze of the Unknown
                { 4, 47527 }, -- Embrace of Madness
                { 5, 47560 }, -- Boots of the Crackling Flame
                { 6, 47529 }, -- Mask of Distant Memory
                { 7, 47561 }, -- Gloves of the Dark Exile
                { 8, 47563 }, -- Girdle of the Dauntless Conqueror
                { 9, 47565 }, -- Vambraces of Unholy Command
                { 10, 47567 }, -- Gauntlets of Revelation
                { 11, 47562 }, -- Symbol of Redemption
                { 12, 47566 }, -- The Warlord's Depravity
                { 13, 47569 }, -- Spectral Kris
                { 14, 49682 }, -- Black Knight's Rondel
                { 15, 47568 }, -- True-aim Long Rifle
                { 16, 43102 }, -- Frozen Orb
                { 18, 44990 }, -- Champion's Seal
            }
        },
        KEYS
    }
}

local ICC_DUNGEONS_TRASH = { -- Trash
    name = AL["Trash"],
    ExtraList = true,
    [NORMAL_DIFF] = {
        { 1, 49854 }, -- Mantle of Tattered Feathers
		{ 2, 49855 }, -- Plated Grips of Korth'azz
		{ 3, 49853 }, -- Titanium Links of Lore
		{ 4, 49852 }, -- Coffin Nail
    },
    [HEROIC_DIFF] = {
        { 1, 50318 }, -- Ghostly Wristwraps
		{ 2, 50315 }, -- Seven-Fingered Claws
		{ 3, 50319 }, -- Unsharpened Ice Razor
        { 4, 50051 }, -- Hammer of Purified Flame
		{ 5, 50050 }, -- Cudgel of Furious Justice
		{ 6, 50052 }, -- Lightborn Spire
        { 16, AtlasLoot:GetRetByFaction(50380, 50379) }, -- Battered Hilt
    },
}

data["ForgeOfSouls"] = {
    nameFormat = NAME_ICC,
	MapID = 4809,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- FoSBronjahm / 268
            name = AL["Bronjahm"],
            npcID = 36497,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49788 }, -- Cold Sweat Grips
                { 2, 49785 }, -- Bewildering Shoulderpads
                { 3, 49786 }, -- Robes of the Cheating Heart
                { 4, 49787 }, -- Seven Stormy Mornings
                { 5, 49784 }, -- Minister's Number One Legplates
                { 6, 49783 }, -- Lucky Old Sun
                { 16, 50317 }, -- Papa's New Bag
                { 17, 50316 }, -- Papa's Brand New Bag
            },
            [HEROIC_DIFF] = {
                { 1, 50193 }, -- Very Fashionable Shoulders
                { 2, 50197 }, -- Eyes of Bewilderment
                { 3, 50194 }, -- Weeping Gauntlets
                { 4, 50196 }, -- Love's Prisoner
                { 5, 50191 }, -- Nighttime
                { 6, 50169 }, -- Papa's Brand New Knife
                { 16, 50317 }, -- Papa's New Bag
                { 17, 50316 }, -- Papa's Brand New Bag
            }
        },
        { -- FoSDevourer / 269
            name = AL["Devourer of Souls"],
            npcID = 36502,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49792 }, -- Accursed Crawling Cape
                { 2, 49796 }, -- Essence of Anger
                { 3, 49798 }, -- Soul Screaming Boots
                { 4, 49791 }, -- Lost Reliquary Chestguard
                { 5, 49797 }, -- Brace Guards of the Starless Night
                { 6, 49794 }, -- Legplates of Frozen Granite
                { 7, 49795 }, -- Sollerets of Suffering
                { 8, 49799 }, -- Coil of Missing Gems
                { 9, 49800 }, -- Spiteful Signet
                { 10, 49789 }, -- Heartshiver
                { 11, 49790 }, -- Blood Boil Lancet
                { 12, 49793 }, -- Tower of the Mouldering Corpse
            },
            [HEROIC_DIFF] = {
                { 1, 50213 }, -- Mord'rethar Robes
                { 2, 50206 }, -- Frayed Scoundrel's Cap
                { 3, 50212 }, -- Essence of Desire
                { 4, 50214 }, -- Helm of the Spirit Shock
                { 5, 50209 }, -- Essence of Suffering
                { 6, 50208 }, -- Pauldrons of the Devourer
                { 7, 50207 }, -- Black Spire Sabatons
                { 8, 50215 }, -- Recovered Reliquary Boots
                { 9, 50211 }, -- Arcane Loops of Anger
                { 10, 50198 }, -- Needle-Encrusted Scorpion
                { 11, 50203 }, -- Blood Weeper
                { 12, 50210 }, -- Seethe
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

data["PitOfSaron"] = {
    nameFormat = NAME_ICC,
	MapID = 4813,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- PoSGarfrost / 271
            name = AL["Forgemaster Garfrost"],
            npcID = 36494,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49805 }, -- Ice-Steeped Sandals
                { 2, 49806 }, -- Flayer's Black Belt
                { 3, 49804 }, -- Polished Mirror Helm
                { 4, 49803 }, -- Ring of Carnelian and Bone
                { 5, 49802 }, -- Garfrost's Two-Ton Hammer
                { 6, 49801 }, -- Unspeakable Secret
            },
            [HEROIC_DIFF] = {
                { 1, 50233 }, -- Spurned Val'kyr Shoulderguards
                { 2, 50234 }, -- Shoulderplates of Frozen Blood
                { 3, 50230 }, -- Malykriss Vambraces
                { 4, 50229 }, -- Legguards of the Frosty Depths
                { 5, 50228 }, -- Barbed Ymirheim Choker
                { 6, 50227 }, -- Surgeon's Needle
            }
        },
        { -- PoSKrickIck / 272
            name = AL["Ick & Krick"],
            npcID = {36476,36477},
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49809 }, -- Wristguards of Subterranean Moss
                { 2, 49810 }, -- Scabrous Zombie Leather Belt
                { 3, 49811 }, -- Black Dragonskin Breeches
                { 4, 49808 }, -- Bent Gold Belt
                { 5, 49812 }, -- Purloined Wedding Ring
                { 6, 49807 }, -- Krick's Beetle Stabber
            },
            [HEROIC_DIFF] = {
                { 1, 50266 }, -- Ancient Polar Bear Hide
                { 2, 50263 }, -- Braid of Salt and Fire
                { 3, 50264 }, -- Chewed Leather Wristguards
                { 4, 50265 }, -- Blackened Ghoul Skin Leggings
                { 5, 50235 }, -- Ick's Rotting Thumb
                { 6, 50262 }, -- Felglacier Bolter
            }
        },
        { -- PoSTyrannus / 273
            name = AL["Scourgelord Tyrannus"],
            npcID = 36658,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 49823 }, -- Cloak of the Fallen Cardinal
                { 2, 49825 }, -- Palebone Robes
                { 3, 49822 }, -- Rimewoven Silks
                { 4, 49817 }, -- Shaggy Wyrmleather Leggings
                { 5, 49824 }, -- Horns of the Spurned Val'kyr
                { 6, 49826 }, -- Shroud of Rime
                { 7, 49820 }, -- Gondria's Spectral Bracer
                { 8, 49819 }, -- Skeleton Lord's Cranium
                { 9, 49816 }, -- Scourgelord's Frigid Chestplate
                { 10, 49818 }, -- Painfully Sharp Choker
                { 11, 49821 }, -- Protector of Frigid Souls
                { 12, 49813 }, -- Rimebane Rifle
            },
            [HEROIC_DIFF] = {
                { 1, 50286 }, -- Prelate's Snowshoes
                { 2, 50269 }, -- Fleshwerk Leggings
                { 3, 50270 }, -- Belt of Rotted Fingernails
                { 4, 50283 }, -- Mudslide Boots
                { 5, 50272 }, -- Frost Wyrm Ribcage
                { 6, 50285 }, -- Icebound Bronze Cuirass
                { 7, 50284 }, -- Rusty Frozen Fingerguards
                { 8, 50271 }, -- Band of Stained Souls
                { 9, 50259 }, -- Nevermelting Ice Crystal
                { 10, 50268 }, -- Rimefang's Claw
                { 11, 50267 }, -- Tyrannical Beheader
                { 12, 50273 }, -- Engraved Gargoyle Femur
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

data["HallsOfReflection"] = {
    nameFormat = NAME_ICC,
	MapID = 4820,
	--InstanceID = 560,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- HoRFalric / 275
            name = AL["Falric"],
            npcID = 38112,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49832 }, -- Eerie Runeblade Polisher
                { 2, 49828 }, -- Marwyn's Macabre Fingertips
                { 3, 49830 }, -- Fallen Sentry's Hood
                { 4, 49831 }, -- Muddied Boots of Brill
                { 5, 49829 }, -- Valonforth's Tarnished Pauldrons
                { 6, 49827 }, -- Ghoulslicer
            },
            [HEROIC_DIFF] = {
                { 1, 50292 }, -- Bracer of Worn Molars
                { 2, 50293 }, -- Spaulders of Black Betrayal
                { 3, 50295 }, -- Spiked Toestompers
                { 4, 50294 }, -- Chestpiece of High Treason
                { 5, 50290 }, -- Falric's Wrist-Chopper
                { 6, 50291 }, -- Soulsplinter
            }
        },
        { -- HoRMarwyn / 276
            name = AL["Marwyn"],
            npcID = 38113,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49834 }, -- Frayed Abomination Stitching Shoulders
                { 2, 49838 }, -- Carpal Tunnelers
                { 3, 49837 }, -- Mitts of Burning Hail
                { 4, 49836 }, -- Frostsworn Bone Leggings
                { 5, 49833 }, -- Splintered Icecrown Parapet
                { 6, 49835 }, -- Splintered Door of the Citadel
            },
            [HEROIC_DIFF] = {
                { 1, 50298 }, -- Sightless Crown of Ulmaas
                { 2, 50299 }, -- Suspiciously Soft Gloves
                { 3, 50300 }, -- Choking Hauberk
                { 4, 50297 }, -- Frostsworn Bone Chestpiece
                { 5, 50260 }, -- Ephemeral Snowflake
                { 6, 50296 }, -- Orca-Hunter's Harpoon
            }
        },
        { -- HoRLichKing / 277
            name = AL["Wrath of the Lich King"],
            npcID = 36954,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 49842 }, -- Tapestry of the Frozen Throne
                { 2, 49849 }, -- Tattered Glacial-Woven Hood
                { 3, 49848 }, -- Grim Lasher Shoulderguards
                { 4, 49841 }, -- Blackened Geist Ribs
                { 5, 49847 }, -- Legguards of Untimely Demise
                { 6, 49851 }, -- Greathelm of the Silver Hand
                { 7, 49843 }, -- Crystalline Citadel Gauntlets
                { 8, 49846 }, -- Chilled Heart of the Glacier
                { 9, 49839 }, -- Mourning Malice
                { 10, 49840 }, -- Hate-Forged Cleaver
                { 11, 49845 }, -- Bone Golem Scapula
                { 12, 49844 }, -- Crypt Fiend Slayer
            },
            [HEROIC_DIFF] = {
                { 1, 50314 }, -- Strip of Remorse
                { 2, 50312 }, -- Chestguard of Broken Branches
                { 3, 50308 }, -- Blighted Leather Footpads
                { 4, 50304 }, -- Hoarfrost Gauntlets
                { 5, 50311 }, -- Second Helm of the Executioner
                { 6, 50305 }, -- Grinning Skull Boots
                { 7, 50310 }, -- Fossilized Ammonite Choker
                { 8, 50313 }, -- Oath of Empress Zoe
                { 9, 50306 }, -- The Lady's Promise
                { 10, 50309 }, -- Shriveled Heart
                { 11, 50302 }, -- Liar's Tongue
                { 12, 50303 }, -- Black Icicle
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

-- ## RAIDS

data["TheEyeOfEternity"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4500,
	--InstanceID = 560,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- Malygos / 180
	        name = AL["Malygos"],
            npcID = 28859,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, 40526 }, -- Gown of the Spell-Weaver
                { 2, 40519 }, -- Footsteps of Malygos
                { 3, 40511 }, -- Focusing Energy Epaulets
                { 4, 40486 }, -- Necklace of the Glittering Chamber
                { 5, 40474 }, -- Surge Needle Ring
                { 6, 40491 }, -- Hailstorm
                { 7, 40488 }, -- Ice Spire Scepter
                { 8, 40489 }, -- Greatstaff of the Nexus
                { 9, 40497 }, -- Black Ice
                { 10, 40475 }, -- Barricade of Eternity
                { 16, 43952 }, -- Reins of the Azure Drake
                { 18, 44569 }, -- Key to the Focusing Iris
                { 19, 44650 }, -- Heart of Magic
            },
            [RAID25_DIFF] = {
                { 1, 40562 }, -- Hood of Rationality
                { 2, 40555 }, -- Mantle of Dissemination
                { 3, 40194 }, -- Blanketing Robes of Snow
                { 4, 40561 }, -- Leash of Heedless Magic
                { 5, 40560 }, -- Leggings of the Wanton Spellcaster
                { 6, 40558 }, -- Arcanic Tramplers
                { 7, 40594 }, -- Spaulders of Catatonia
                { 8, 40539 }, -- Chestguard of the Recluse
                { 9, 40541 }, -- Frosted Adroit Handguards
                { 10, 40566 }, -- Unravelling Strands of Sanity
                { 11, 40543 }, -- Blue Aspect Helm
                { 12, 40588 }, -- Tunic of the Artifact Guardian
                { 13, 40564 }, -- Winter Spectacle Gloves
                { 14, 40549 }, -- Boots of the Renewed Flight
                { 15, 40590 }, -- Elevated Lair Pauldrons
                { 16, 40589 }, -- Legplates of Sovereignty
                { 17, 40592 }, -- Boots of Healing Energies
                { 18, 40591 }, -- Melancholy Sabatons
                { 19, 40532 }, -- Living Ice Crystals
                { 20, 40531 }, -- Mark of Norgannon
                { 22, 43952 }, -- Reins of the Azure Drake
                { 24, 44577 }, -- Heroic Key to the Focusing Iris
                { 25, 44651 }, -- Heart of Magic
            }
        },
        KEYS
    }
}

data["NaxxramasWrath"] = {
	MapID = 3456,
	InstanceID = 533,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "Naxxramas",
	--AtlasMapFile = "CL_Naxxramas",
	--AtlasMapFile_AL = "Naxxramas",
	ContentType = RAID_CONTENT,
	--LoadDifficulty = RAID40_DIFF,
	--ContentPhase = 6,
    LevelRange = {80, 80, 80},
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
			Level = 999,
			DisplayIDs = {{15931}},
			AtlasMapBossID = BLUE.."1",
			[RAID10_DIFF] = {
                { 1, 39192 }, -- Gloves of Dark Gestures
                { 2, 39190 }, -- Agonal Sash
                { 3, 39191 }, -- Splint-Bound Leggings
                { 4, 39189 }, -- Boots of Persistence
                { 5, 39188 }, -- Chivalric Chestguard
                { 6, 39139 }, -- Ravaging Sabatons
                { 7, 39146 }, -- Collar of Dissolution
                { 8, 39193 }, -- Band of Neglected Pleas
                { 9, 39141 }, -- Deflection Band
                { 10, 39140 }, -- Knife of Incision
            },
            [RAID25_DIFF] = {
                { 1, 39719 }, -- Mantle of the Locusts
                { 2, 39721 }, -- Sash of the Parlor
                { 3, 39720 }, -- Leggings of Atrophy
                { 4, 39722 }, -- Swarm Bindings
                { 5, 39701 }, -- Dawnwalkers
                { 6, 39702 }, -- Arachnoid Gold Band
                { 7, 39718 }, -- Corpse Scarab Handguards
                { 8, 39704 }, -- Pauldrons of Unnatural Death
                { 9, 39703 }, -- Rescinding Grips
                { 10, 39717 }, -- Inexorable Sabatons
                { 11, 39706 }, -- Sabatons of Sudden Reprisal
                { 12, 40071 }, -- Chains of Adoration
                { 13, 40065 }, -- Fool's Trial
                { 14, 40069 }, -- Heritage
                { 15, 40064 }, -- Thunderstorm Amulet
                { 16, 40080 }, -- Lost Jewel
                { 17, 40075 }, -- Ruthlessness
                { 18, 40107 }, -- Sand-Worn Band
                { 19, 40074 }, -- Strong-Handed Ring
                { 20, 39714 }, -- Webbed Death
                { 21, 40208 }, -- Cryptfiend's Bite
                { 22, 39716 }, -- Shield of Assimilation
                { 23, 39712 }, -- Gemmed Wand of the Nerubians
            },
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
			Level = 999,
			DisplayIDs = {{15940}},
			AtlasMapBossID = BLUE.."2",
			[RAID10_DIFF] = {
                { 1, 39216 }, -- Sash of Mortal Desire
                { 2, 39215 }, -- Boots of the Follower
                { 3, 39196 }, -- Boots of the Worshiper
                { 4, 39217 }, -- Avenging Combat Leggings
                { 5, 39194 }, -- Rusted-Link Spiked Gauntlets
                { 6, 39198 }, -- Frostblight Pauldrons
                { 7, 39195 }, -- Bracers of Lost Sentiments
                { 8, 39197 }, -- Gauntlets of the Master
                { 9, 39199 }, -- Watchful Eye
                { 10, 39200 }, -- Grieving Spellblade
            },
            [RAID25_DIFF] = {
                { 1, 39732 }, -- Faerlina's Madness
                { 2, 39731 }, -- Punctilious Bindings
                { 3, 39733 }, -- Gloves of Token Respect
                { 4, 39735 }, -- Belt of False Dignity
                { 5, 39756 }, -- Tunic of Prejudice
                { 6, 39727 }, -- Dislocating Handguards
                { 7, 39724 }, -- Cult's Chestguard
                { 8, 39734 }, -- Atonement Greaves
                { 9, 39723 }, -- Fire-Scorched Greathelm
                { 10, 39725 }, -- Epaulets of the Grieving Servant
                { 11, 39729 }, -- Bracers of the Tyrant
                { 12, 39726 }, -- Callous-Hearted Gauntlets
                { 13, 40071 }, -- Chains of Adoration
                { 14, 40065 }, -- Fool's Trial
                { 15, 40069 }, -- Heritage
                { 16, 40064 }, -- Thunderstorm Amulet
                { 17, 40080 }, -- Lost Jewel
                { 18, 40075 }, -- Ruthlessness
                { 19, 40107 }, -- Sand-Worn Band
                { 20, 40108 }, -- Seized Beauty
                { 21, 40074 }, -- Strong-Handed Ring
                { 22, 39757 }, -- Idol of Worship
                { 23, 39728 }, -- Totem of Misery
                { 24, 39730 }, -- Widow's Fury
            },
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
			Level = 999,
			DisplayIDs = {{15928}},
			AtlasMapBossID = BLUE.."3",
			[RAID10_DIFF] = {
                { 1, 39225 }, -- Cloak of Armed Strife
                { 2, 39230 }, -- Spaulders of the Monstrosity
                { 3, 39224 }, -- Leggings of Discord
                { 4, 39228 }, -- Web Cocoon Grips
                { 5, 39232 }, -- Pendant of Lost Vocations
                { 6, 39231 }, -- Timeworn Silken Band
                { 7, 39229 }, -- Embrace of the Spider
                { 8, 39226 }, -- Maexxna's Femur
                { 9, 39221 }, -- Wraith Spear
                { 10, 39233 }, -- Aegis of Damnation
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40062 }, -- Digested Silken Robes
                { 7, 40060 }, -- Distorted Limbs
                { 8, 39768 }, -- Cowl of the Perished
                { 9, 40063 }, -- Mantle of Shattered Kinship
                { 10, 39765 }, -- Sinner's Bindings
                { 11, 39761 }, -- Infectious Skitterer Leggings
                { 12, 40061 }, -- Quivering Tunic
                { 13, 39762 }, -- Torn Web Wrapping
                { 14, 39760 }, -- Helm of Diminished Pride
                { 15, 39767 }, -- Undiminished Battleplate
                { 16, 39764 }, -- Bindings of the Hapless Prey
                { 17, 39759 }, -- Ablative Chitin Girdle
                { 18, 40257 }, -- Defender's Code
                { 19, 40255 }, -- Dying Curse
                { 20, 40258 }, -- Forethought Talisman
                { 21, 40256 }, -- Grim Toll
                { 22, 39766 }, -- Matriarch's Spawn
                { 23, 39763 }, -- Wraith Strike
                { 24, 39758 }, -- The Jawbone
            },
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
			Level = 999,
			DisplayIDs = {{16590}},
			AtlasMapBossID = PURP.."1",
			[RAID10_DIFF] = {
                { 1, 39241 }, -- Dark Shroud of the Scourge
                { 2, 39242 }, -- Robes of Hoarse Breaths
                { 3, 39240 }, -- Noth's Curse
                { 4, 39237 }, -- Spaulders of Resumed Battle
                { 5, 39243 }, -- Handgrips of the Foredoomed
                { 6, 39236 }, -- Trespasser's Boots
                { 7, 39239 }, -- Chestplate of the Risen Soldier
                { 8, 39235 }, -- Bone-Framed Bracers
                { 9, 39234 }, -- Plague-Impervious Boots
                { 10, 39244 }, -- Ring of the Fated
            },
            [RAID25_DIFF] = {
                { 1, 40602 }, -- Robes of Mutation
                { 2, 40198 }, -- Bands of Impurity
                { 3, 40197 }, -- Gloves of the Fallen Wizard
                { 4, 40186 }, -- Thrusting Bands
                { 5, 40200 }, -- Belt of Potent Chanting
                { 6, 40193 }, -- Tunic of Masked Suffering
                { 7, 40196 }, -- Legguards of the Undisturbed
                { 8, 40184 }, -- Crippled Treads
                { 9, 40185 }, -- Shoulderguards of Opportunity
                { 10, 40188 }, -- Gauntlets of the Disobediant
                { 11, 40187 }, -- Poignant Sabatons
                { 12, 40071 }, -- Chains of Adoration
                { 13, 40065 }, -- Fool's Trial
                { 14, 40069 }, -- Heritage
                { 15, 40064 }, -- Thunderstorm Amulet
                { 16, 40080 }, -- Lost Jewel
                { 17, 40075 }, -- Ruthlessness
                { 18, 40107 }, -- Sand-Worn Band
                { 19, 40074 }, -- Strong-Handed Ring
                { 20, 40192 }, -- Accursed Spine
                { 21, 40191 }, -- Libram of Radiance
                { 22, 40189 }, -- Angry Dread
                { 23, 40190 }, -- Spinning Fate
            },
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
			Level = 999,
			DisplayIDs = {{16309}},
			AtlasMapBossID = PURP.."2",
			[RAID10_DIFF] = {
                { 1, 39252 }, -- Preceptor's Bindings
                { 2, 39254 }, -- Saltarello Shoes
                { 3, 39247 }, -- Cuffs of Dark Shadows
                { 4, 39248 }, -- Tunic of the Lost Pack
                { 5, 39251 }, -- Necrogenic Belt
                { 6, 39249 }, -- Shoulderplates of Bloodshed
                { 7, 39246 }, -- Amulet of Autopsy
                { 8, 39250 }, -- Ring of Holy Cleansing
                { 9, 39245 }, -- Demise
                { 10, 39255 }, -- Staff of the Plague Beast
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40234 }, -- Heigan's Putrid Vestments
                { 7, 40236 }, -- Serene Echoes
                { 8, 40238 }, -- Gloves of the Dancing Bear
                { 9, 40205 }, -- Stalk-Skin Belt
                { 10, 40235 }, -- Helm of Pilgrimage
                { 11, 40209 }, -- Bindings of the Decrepit
                { 12, 40201 }, -- Leggings of Colossal Strides
                { 13, 40237 }, -- Eruption-Scared Boots
                { 14, 40203 }, -- Breastplate of Tormented Rage
                { 15, 40210 }, -- Chestguard of Bitter Charms
                { 16, 40204 }, -- Legguards of the Apostle
                { 17, 40206 }, -- Iron-Spring Jumpers
                { 18, 40257 }, -- Defender's Code
                { 19, 40255 }, -- Dying Curse
                { 20, 40258 }, -- Forethought Talisman
                { 21, 40256 }, -- Grim Toll
                { 22, 40207 }, -- Sigil of Awareness
                { 23, 40208 }, -- Cryptfiend's Bite
                { 24, 40233 }, -- The Undeath Carrier
            },
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
			Level = 999,
			DisplayIDs = {{16110}},
			AtlasMapBossID = PURP.."3",
			[RAID10_DIFF] = {
                { 1, 39259 }, -- Fungi-Stained Coverings
                { 2, 39260 }, -- Helm of the Corrupted Mind
                { 3, 39258 }, -- Legplates of Inescapable Death
                { 4, 39257 }, -- Loatheb's Shadow
                { 5, 39256 }, -- Sulfur Stave
                { 16, 40622 }, -- Spaulders of the Lost Conqueror
                { 17, 40623 }, -- Spaulders of the Lost Protector
                { 18, 40624 }, -- Spaulders of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40247 }, -- Cowl of Innocent Delight
                { 2, 40246 }, -- Boots of Impetuous Ideals
                { 3, 40249 }, -- Vest of Vitality
                { 4, 40243 }, -- Footwraps of Vile Deceit
                { 5, 40242 }, -- Grotesque Handgrips
                { 6, 40241 }, -- Girdle of Unity
                { 7, 40240 }, -- Greaves of Turbulence
                { 8, 40244 }, -- The Impossible Dream
                { 9, 40239 }, -- The Hand of Nerub
                { 10, 40245 }, -- Fading Glow
                { 16, 40637 }, -- Mantle of the Lost Conqueror
                { 17, 40638 }, -- Mantle of the Lost Protector
                { 18, 40639 }, -- Mantle of the Lost Vanquisher
            },
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
			Level = 999,
			DisplayIDs = {{16582}},
			AtlasMapBossID = _RED.."1",
			[RAID10_DIFF] = {
                { 1, 39297 }, -- Cloak of Darkening
                { 2, 39310 }, -- Mantle of the Extensive Mind
                { 3, 39309 }, -- Leggings of the Instructor
                { 4, 39299 }, -- Rapid Attack Gloves
                { 5, 39308 }, -- Girdle of Lenience
                { 6, 39307 }, -- Iron Rings of Endurance
                { 7, 39306 }, -- Plated Gloves of Relief
                { 8, 39298 }, -- Waistguard of the Tutor
                { 9, 39311 }, -- Scepter of Murmuring Spirits
                { 10, 39296 }, -- Accursed Bow of the Elite
            },
            [RAID25_DIFF] = {
                { 1, 40325 }, -- Bindings of the Expansive Mind
                { 2, 40326 }, -- Boots of Forlorn Wishes
                { 3, 40305 }, -- Spaulders of Egotism
                { 4, 40319 }, -- Chestpiece of Suspicion
                { 5, 40323 }, -- Esteemed Bindings
                { 6, 40315 }, -- Shoulderpads of Secret Arts
                { 7, 40324 }, -- Bands of Mutual Respect
                { 8, 40327 }, -- Girdle of Recuperation
                { 9, 40306 }, -- Bracers of the Unholy Knight
                { 10, 40316 }, -- Gauntlets of Guiding Touch
                { 11, 40317 }, -- Girdle of Razuvious
                { 12, 40318 }, -- Legplates of Double Strikes
                { 13, 40320 }, -- Faithful Steel Sabatons
                { 14, 40071 }, -- Chains of Adoration
                { 15, 40065 }, -- Fool's Trial
                { 16, 40069 }, -- Heritage
                { 17, 40064 }, -- Thunderstorm Amulet
                { 18, 40080 }, -- Lost Jewel
                { 19, 40075 }, -- Ruthlessness
                { 20, 40107 }, -- Sand-Worn Band
                { 21, 40074 }, -- Strong-Handed Ring
                { 22, 40321 }, -- Idol of the Shooting Star
                { 23, 40322 }, -- Totem of Dueling
            },
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
			Level = 999,
			DisplayIDs = {{16279}},
			AtlasMapBossID = _RED.."2",
			[RAID10_DIFF] = {
                { 1, 39390 }, -- Resurgent Phantom Bindings
                { 2, 39386 }, -- Tunic of Dislocation
                { 3, 39391 }, -- Heinous Mail Chestguard
                { 4, 39379 }, -- Spectral Rider's Girdle
                { 5, 39345 }, -- Girdle of the Ascended Phantom
                { 6, 39369 }, -- Sabatons of Deathlike Gloom
                { 7, 39392 }, -- Veiled Amulet of Life
                { 8, 39389 }, -- Signet of the Malevolent
                { 9, 39388 }, -- Spirit-World Glass
                { 10, 39344 }, -- Slayer of the Lifeless
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40339 }, -- Gothik's Cowl
                { 7, 40338 }, -- Bindings of Yearning
                { 8, 40329 }, -- Hood of the Exodus
                { 9, 40341 }, -- Shackled Cinch
                { 10, 40333 }, -- Leggings of Fleeting Moments
                { 11, 40340 }, -- Helm of Unleashed Energy
                { 12, 40331 }, -- Leggings of Failed Escape
                { 13, 40328 }, -- Helm of Vital Protection
                { 14, 40334 }, -- Burdened Shoulderplates
                { 15, 40332 }, -- Abetment Bracers
                { 16, 40330 }, -- Bracers of Unrelenting Attack
                { 17, 40257 }, -- Defender's Code
                { 18, 40255 }, -- Dying Curse
                { 19, 40258 }, -- Forethought Talisman
                { 20, 40256 }, -- Grim Toll
                { 21, 40342 }, -- Idol of Awakening
                { 22, 40337 }, -- Libram of Resurgence
                { 23, 40336 }, -- Life and Death
                { 24, 40335 }, -- Touch of Horror
            },
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = {16064, 16065, 16062, 16063},
			Level = 999,
			DisplayIDs = {{16155},{16153},{16139},{16154}},
			AtlasMapBossID = _RED.."3",
			[RAID10_DIFF] = {
                { 1, 39396 }, -- Gown of Blaumeux
                { 2, 39397 }, -- Pauldrons of Havoc
                { 3, 39395 }, -- Thane's Tainted Greathelm
                { 4, 39393 }, -- Claymore of Ancient Power
                { 5, 39394 }, -- Charmed Cierge
                { 16, 40610 }, -- Chestguard of the Lost Conqueror
                { 17, 40611 }, -- Chestguard of the Lost Protector
                { 18, 40612 }, -- Chestguard of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40349 }, -- Gloves of Peaceful Death
                { 2, 40344 }, -- Helm of the Grave
                { 3, 40352 }, -- Leggings of Voracious Shadows
                { 4, 40347 }, -- Zeliek's Gauntlets
                { 5, 40350 }, -- Urn of Lost Memories
                { 6, 40345 }, -- Broken Promise
                { 7, 40343 }, -- Armageddon
                { 8, 40348 }, -- Damnation
                { 9, 40346 }, -- Final Voyage
                { 16, 40625 }, -- Breastplate of the Lost Conqueror
                { 17, 40626 }, -- Breastplate of the Lost Protector
                { 18, 40627 }, -- Breastplate of the Lost Vanquisher
            },
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
			Level = 999,
			DisplayIDs = {{16174}},
			AtlasMapBossID = 1,
			[RAID10_DIFF] = {
                { 1, 39272 }, -- Drape of Surgery
                { 2, 39273 }, -- Sullen Cloth Boots
                { 3, 39275 }, -- Contagion Gloves
                { 4, 39274 }, -- Retcher's Shoulderpads
                { 5, 39267 }, -- Abomination Shoulderblades
                { 6, 39262 }, -- Gauntlets of Combined Strength
                { 7, 39261 }, -- Tainted Girdle of Mending
                { 8, 39271 }, -- Blade of Dormant Memories
                { 9, 39270 }, -- Hatestrike
            },
            [RAID25_DIFF] = {
                { 1, 40271 }, -- Sash of Solitude
                { 2, 40269 }, -- Boots of Persuasion
                { 3, 40260 }, -- Belt of the Tortured
                { 4, 40270 }, -- Boots of Septic Wounds
                { 5, 40262 }, -- Gloves of Calculated Risk
                { 6, 40272 }, -- Girdle of the Gambit
                { 7, 40261 }, -- Crude Discolored Battlegrips
                { 8, 40263 }, -- Fleshless Girdle
                { 9, 40259 }, -- Waistguard of Divine Grace
                { 10, 40071 }, -- Chains of Adoration
                { 11, 40065 }, -- Fool's Trial
                { 12, 40069 }, -- Heritage
                { 13, 40064 }, -- Thunderstorm Amulet
                { 14, 40080 }, -- Lost Jewel
                { 15, 40075 }, -- Ruthlessness
                { 16, 40107 }, -- Sand-Worn Band
                { 17, 40074 }, -- Strong-Handed Ring
                { 18, 40273 }, -- Surplus Limb
                { 19, 40267 }, -- Totem of Hex
                { 20, 40268 }, -- Libram of Tolerance
                { 21, 40264 }, -- Split Greathammer
                { 22, 40266 }, -- Hero's Surrender
                { 23, 40265 }, -- Arrowsong
            },
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
			Level = 999,
			DisplayIDs = {{16035}},
			AtlasMapBossID = 2,
			[RAID10_DIFF] = {
                { 1, 39284 }, -- Miasma Mantle
                { 2, 39285 }, -- Handgrips of Turmoil
                { 3, 39283 }, -- Putrescent Bands
                { 4, 39279 }, -- Blistered Belt of Decay
                { 5, 39278 }, -- Bands of Anxiety
                { 6, 39280 }, -- Leggings of Innumerable Barbs
                { 7, 39282 }, -- Bone-Linked Amulet
                { 8, 39277 }, -- Sealing Ring of Grobbulus
                { 9, 39281 }, -- Infection Repulser
                { 10, 39276 }, -- The Skull of Ruin
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40287 }, -- Cowl of Vanity
                { 7, 40286 }, -- Mantle of the Corrupted
                { 8, 40351 }, -- Mantle of the Fatigued Sage
                { 9, 40289 }, -- Sympathetic Amice
                { 10, 40277 }, -- Tunic of Indulgence
                { 11, 40285 }, -- Desecrated Past
                { 12, 40288 }, -- Spaulders of Incoherence
                { 13, 40283 }, -- Fallout Impervious Tunic
                { 14, 40282 }, -- Slime Stream Bands
                { 15, 40275 }, -- Depraved Linked Belt
                { 16, 40279 }, -- Chestguard of the Exhausted
                { 17, 40274 }, -- Bracers of Liberation
                { 18, 40278 }, -- Girdle of Chivalry
                { 19, 40257 }, -- Defender's Code
                { 20, 40255 }, -- Dying Curse
                { 21, 40258 }, -- Forethought Talisman
                { 22, 40256 }, -- Grim Toll
                { 23, 40281 }, -- Twilight Mist
                { 24, 40280 }, -- Origin of Nightmares
                { 25, 40284 }, -- Plague Igniter
            },
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
			Level = 999,
			DisplayIDs = {{16064}},
			AtlasMapBossID = 3,
			[RAID10_DIFF] = {
                { 1, 39272 }, -- Drape of Surgery
                { 2, 39284 }, -- Miasma Mantle
                { 3, 39396 }, -- Gown of Blaumeux
                { 4, 39309 }, -- Leggings of the Instructor
                { 5, 39237 }, -- Spaulders of Resumed Battle
                { 6, 39279 }, -- Blistered Belt of Decay
                { 7, 39191 }, -- Splint-Bound Leggings
                { 8, 39215 }, -- Boots of the Follower
                { 9, 39294 }, -- Arc-Scorched Helmet
                { 10, 39248 }, -- Tunic of the Lost Pack
                { 11, 39194 }, -- Rusted-Link Spiked Gauntlets
                { 12, 39251 }, -- Necrogenic Belt
                { 13, 39379 }, -- Spectral Rider's Girdle
                { 14, 39188 }, -- Chivalric Chestguard
                { 15, 39345 }, -- Girdle of the Ascended Phantom
                { 16, 39146 }, -- Collar of Dissolution
                { 17, 39232 }, -- Pendant of Lost Vocations
                { 18, 39193 }, -- Band of Neglected Pleas
                { 19, 39388 }, -- Spirit-World Glass
                { 20, 39200 }, -- Grieving Spellblade
                { 21, 39344 }, -- Slayer of the Lifeless
                { 22, 39281 }, -- Infection Repulser
                { 23, 39394 }, -- Charmed Cierge

                { 101, 40622 }, -- Spaulders of the Lost Conqueror
                { 102, 40623 }, -- Spaulders of the Lost Protector
                { 103, 40624 }, -- Spaulders of the Lost Vanquisher
                { 105, 40610 }, -- Chestguard of the Lost Conqueror
                { 106, 40611 }, -- Chestguard of the Lost Protector
                { 107, 40612 }, -- Chestguard of the Lost Vanquisher
                { 116, 40619 }, -- Leggings of the Lost Conqueror
                { 117, 40620 }, -- Leggings of the Lost Protector
                { 118, 40621 }, -- Leggings of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40247 }, -- Cowl of Innocent Delight
                { 2, 40289 }, -- Sympathetic Amice
                { 3, 40602 }, -- Robes of Mutation
                { 4, 39733 }, -- Gloves of Token Respect
                { 5, 40303 }, -- Wraps of the Persecuted
                { 6, 40326 }, -- Boots of Forlorn Wishes
                { 7, 40296 }, -- Cover of Silence
                { 8, 39768 }, -- Cowl of the Perished
                { 9, 40319 }, -- Chestpiece of Suspicion
                { 10, 40260 }, -- Belt of the Tortured
                { 11, 40205 }, -- Stalk-Skin Belt
                { 12, 40270 }, -- Boots of Septic Wounds
                { 13, 40193 }, -- Tunic of Masked Suffering
                { 14, 40209 }, -- Bindings of the Decrepit
                { 15, 40302 }, -- Benefactor's Gauntlets
                { 16, 39718 }, -- Corpse Scarab Handguards
                { 17, 40242 }, -- Grotesque Handgrips
                { 18, 39760 }, -- Helm of Diminished Pride
                { 19, 40185 }, -- Shoulderguards of Opportunity
                { 20, 40203 }, -- Breastplate of Tormented Rage
                { 21, 40332 }, -- Abetment Bracers
                { 22, 40188 }, -- Gauntlets of the Disobediant
                { 23, 40259 }, -- Waistguard of Divine Grace
                { 24, 40204 }, -- Legguards of the Apostle
                { 25, 39717 }, -- Inexorable Sabatons
                { 26, 40206 }, -- Iron-Spring Jumpers
                { 27, 40297 }, -- Sabatons of Endurance
                { 28, 40350 }, -- Urn of Lost Memories
                { 29, 40191 }, -- Libram of Radiance

                { 101, 40281 }, -- Twilight Mist
                { 102, 39714 }, -- Webbed Death
                { 103, 39730 }, -- Widow's Fury
                { 104, 40343 }, -- Armageddon
                { 105, 40239 }, -- The Hand of Nerub
                { 106, 40280 }, -- Origin of Nightmares
                { 107, 39716 }, -- Shield of Assimilation
                { 108, 40265 }, -- Arrowsong
                { 109, 40346 }, -- Final Voyage
                { 111, 40637 }, -- Mantle of the Lost Conqueror
                { 112, 40638 }, -- Mantle of the Lost Protector
                { 113, 40639 }, -- Mantle of the Lost Vanquisher
                { 116, 40625 }, -- Breastplate of the Lost Conqueror
                { 117, 40626 }, -- Breastplate of the Lost Protector
                { 118, 40627 }, -- Breastplate of the Lost Vanquisher
                { 120, 40634 }, -- Legplates of the Lost Conqueror
                { 121, 40635 }, -- Legplates of the Lost Protector
                { 122, 40636 }, -- Legplates of the Lost Vanquisher
            },
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
			Level = 999,
			DisplayIDs = {{16137}},
			AtlasMapBossID = 4,
			[RAID10_DIFF] = {
                { 1, 39295 }, -- Cowl of Sheet Lightning
                { 2, 39294 }, -- Arc-Scorched Helmet
                { 3, 39293 }, -- Blackened Legplates of Feugen
                { 4, 39292 }, -- Repelling Charge
                { 5, 39291 }, -- Torment of the Banished
                { 16, 40619 }, -- Leggings of the Lost Conqueror
                { 17, 40620 }, -- Leggings of the Lost Protector
                { 18, 40621 }, -- Leggings of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40303 }, -- Wraps of the Persecuted
                { 2, 40301 }, -- Cincture of Polarity
                { 3, 40296 }, -- Cover of Silence
                { 4, 40304 }, -- Headpiece of Fungal Bloom
                { 5, 40299 }, -- Pauldrons of the Abandoned
                { 6, 40302 }, -- Benefactor's Gauntlets
                { 7, 40298 }, -- Faceguard of the Succumbed
                { 8, 40294 }, -- Riveted Abomination Leggings
                { 9, 40297 }, -- Sabatons of Endurance
                { 10, 40300 }, -- Spire of Sunset
                { 16, 40634 }, -- Legplates of the Lost Conqueror
                { 17, 40635 }, -- Legplates of the Lost Protector
                { 18, 40636 }, -- Legplates of the Lost Vanquisher
            },
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
			Level = 999,
			DisplayIDs = {{16033}},
			AtlasMapBossID = GREN.."1",
			[RAID10_DIFF] = {
                { 1, 39415 }, -- Shroud of the Citadel
                { 2, 39404 }, -- Cloak of Mastery
                { 3, 39409 }, -- Cowl of Winged Fear
                { 4, 39408 }, -- Leggings of Sapphiron
                { 5, 39399 }, -- Helm of the Vast Legions
                { 6, 39405 }, -- Helmet of the Inner Sanctum
                { 7, 39403 }, -- Helm of the Unsubmissive
                { 8, 39398 }, -- Massive Skeletal Ribcage
                { 9, 39401 }, -- Circle of Death
                { 10, 39407 }, -- Circle of Life
                { 16, 44569 }, -- Key to the Focusing Iris
            },
            [RAID25_DIFF] = {
                { 1, 40381 }, -- Sympathy
                { 2, 40380 }, -- Gloves of Grandeur
                { 3, 40376 }, -- Legwraps of the Defeated Dragon
                { 4, 40362 }, -- Gloves of Fast Reactions
                { 5, 40379 }, -- Legguards of the Boneyard
                { 6, 40367 }, -- Boots of the Great Construct
                { 7, 40366 }, -- Platehelm of the Great Wyrm
                { 8, 40377 }, -- Noble Birthright Pauldrons
                { 9, 40365 }, -- Breastplate of Frozen Pain
                { 10, 40363 }, --  Bone-Inlaid Legguards
                { 11, 40378 }, -- Ceaseless Pity
                { 12, 40374 }, -- Cosmic Lights
                { 13, 40369 }, -- Icy Blast Amulet
                { 14, 40370 }, -- Gatekeeper
                { 15, 40375 }, -- Ring of Decaying Beauty
                { 16, 40371 }, -- Bandit's Insignia
                { 17, 40373 }, -- Extract of Necromatic Power
                { 18, 40372 }, -- Rune of Repulsion
                { 19, 40382 }, -- Soul of the Dead
                { 20, 40368 }, -- Murder
                { 22, 44577 }, -- Heroic Key to the Focusing Iris
            },
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
			Level = 999,
			DisplayIDs = {{15945}},
			AtlasMapBossID = GREN.."2",
			[RAID10_DIFF] = {
                { 1, 39425 }, -- Cloak of the Dying
                { 2, 39421 }, -- Gem of Imprisoned Vassals
                { 3, 39416 }, -- Kel'Thuzad's Reach
                { 4, 39424 }, -- The Soulblade
                { 5, 39420 }, -- Anarchy
                { 6, 39417 }, -- Death's Bite
                { 7, 39423 }, -- Hammer of the Astral Plane
                { 8, 39422 }, -- Staff of the Plaguehound
                { 9, 39426 }, -- Wand of the Archlich
                { 10, 39419 }, -- Nerubian Conquerer
                { 16, 40616 }, -- Helm of the Lost Conqueror
                { 17, 40617 }, -- Helm of the Lost Protector
                { 18, 40618 }, -- Helm of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40405 }, -- Cape of the Unworthy Wizard
                { 2, 40403 }, -- Drape of the Deadly Foe
                { 3, 40398 }, -- Leggings of Mortal Arrogance
                { 4, 40387 }, -- Boundless Ambition
                { 5, 40399 }, -- Signet of Manifested Pain
                { 6, 40383 }, -- Calamity's Grasp
                { 7, 40386 }, -- Sinister Revenge
                { 8, 40396 }, -- The Turning Tide
                { 9, 40402 }, -- Last Laugh
                { 10, 40384 }, -- Betrayer of Humanity
                { 11, 40395 }, -- Torch of Holy Fire
                { 12, 40388 }, -- Journey's End
                { 13, 40401 }, -- Voice of Reason
                { 14, 40400 }, -- Wall of Terror
                { 15, 40385 }, -- Envoy of Mortality
                { 16, 40631 }, -- Crown of the Lost Conqueror
                { 17, 40632 }, -- Crown of the Lost Protector
                { 18, 40633 }, -- Crown of the Lost Vanquisher
            },
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[RAID10_DIFF] = {
                { 1, 39467 }, -- Minion Bracers
                { 2, 39472 }, -- Chain of Latent Energies
                { 3, 39470 }, -- Medallion of the Disgraced
                { 4, 39427 }, -- Omen of Ruin
                { 5, 39468 }, -- The Stray
                { 6, 39473 }, -- Contortion
            },
            [RAID25_DIFF] = {
                { 1, 40410 }, -- Shadow of the Ghoul
                { 2, 40409 }, -- Boots of the Escaped Captive
                { 3, 40414 }, -- Shoulderguards of the Undaunted
                { 4, 40412 }, -- Ousted Bead Necklace
                { 5, 40408 }, -- Haunting Call
                { 6, 40407 }, -- Silent Crusader
                { 7, 40406 }, -- Inevitable Defeat
            },
		},
	},
}


data["Sartharion"] = {
	MapID = 4493,
	--InstanceID = 560,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {80, 80, 80},
	items = {
        { -- CoTHillsbradDrake
            name = AL["Sartharion"],
            npcID = 28860,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, 40428 }, -- Titan's Outlook
                { 2, 40427 }, -- Circle of Arcane Streams
                { 3, 40426 }, -- Signet of the Accord
                { 4, 40433 }, -- Wyrmrest Band
                { 5, 40430 }, -- Majestic Dragon Figurine
                { 6, 40429 }, -- Crimson Steel
                { 16, 40613 }, -- Gloves of the Lost Conqueror
                { 17, 40614 }, -- Gloves of the Lost Protector
                { 18, 40615 }, -- Gloves of the Lost Vanquisher
                { 20, 43345 }, -- Dragon Hide Bag
                { 21, 43347 }, -- Satchel of Spoils
            },
            [RAID25_DIFF] = {
                { 1, 40437 }, -- Concealment Shoulderpads
                { 2, 40439 }, -- Mantle of the Eternal Sentinel
                { 3, 40451 }, -- Hyaline Helm of the Sniper
                { 4, 40438 }, -- Council Chamber Epaulets
                { 5, 40453 }, -- Chestplate of the Great Aspects
                { 6, 40446 }, -- Dragon Brood Legguards
                { 7, 40433 }, -- Wyrmrest Band
                { 8, 40431 }, -- Fury of the Five Flights
                { 9, 40432 }, -- Illustration of the Dragon Soul
                { 10, 40455 }, -- Staff of Restraint
                { 16, 40628 }, -- Gauntlets of the Lost Conqueror
                { 17, 40629 }, -- Gauntlets of the Lost Protector
                { 18, 40630 }, -- Gauntlets of the Lost Vanquisher
                { 20, 43345 }, -- Dragon Hide Bag
                { 21, 43346 }, -- Large Satchel of Spoils
            }
        },
        { -- CoTHillsbradDrake
            name = format(BONUS_LOOT_SPLIT, AL["Sartharion"], AL["Bonus Loot"]),
            npcID = 28860,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, "INV_Box_01", nil, AL["One Drake Left"] },
                { 2, 43988 }, -- Gale-Proof Cloak
                { 3, 43990 }, -- Blade-Scarred Tunic
                { 4, 43991 }, -- Legguards of Composure
                { 5, 43989 }, -- Remembrance Girdle
                { 6, 43992 }, -- Volitant Amulet
                { 8, "INV_Box_01", nil, AL["Two Drakes Left"] },
                { 9, 43995 }, -- Enamored Cowl
                { 10, 43998 }, -- Chestguard of Flagrant Prowess
                { 11, 43996 }, -- Sabatons of Firmament
                { 12, 43994 }, -- Belabored Legplates
                { 13, 43993 }, -- Greatring of Collision
                { 16, "INV_Box_01", nil, AL["Three Drakes Left"] },
                { 17, 43986 }, -- Reins of the Black Drake
            },
            [RAID25_DIFF] = {
                { 1, "INV_Box_01", nil, AL["One Drake Left"] },
                { 2, 44002 }, -- The Sanctum's Flowing Vestments
                { 3, 44003 }, -- Upstanding Spaulders
                { 4, 44004 }, -- Bountiful Gauntlets
                { 5, 44000 }, -- Dragonstorm Breastplate
                { 7, "INV_Box_01", nil, AL["Two Drakes Left"] },
                { 8, 44005 }, -- Pennant Cloak
                { 9, 44008 }, -- Unsullied Cuffs
                { 10, 44007 }, -- Headpiece of Reconciliation
                { 11, 44011 }, -- Leggings of the Honored
                { 12, 44006 }, -- Obsidian Greathelm
                { 16, "INV_Box_01", nil, AL["Three Drakes Left"] },
                { 17, 43954 }, -- Reins of the Twilight Drake
            }
        },
        KEYS
    }
}


--[[
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

            },
            [HEROIC_DIFF] = {

            },
        },
        KEYS
    }
}
]]