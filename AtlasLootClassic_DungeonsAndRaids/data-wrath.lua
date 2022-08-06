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
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID20_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID25_CONTENT = data:AddContentType(AL["25 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_WrathOfTheLichKing"

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time
local NAME_NEXUS = NAME_COLOR..AL["Nexus"]..":|r %s" -- The Nexus
local NAME_AZJOL = NAME_COLOR..AL["Azjol"]..":|r %s" -- The Nexus


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
            },
            [HEROIC_DIFF] = {

            },
        },
        KEYS
    }
}



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
                { 11, 44658 }, -- Chain of the Ancient Wyrm
                { 12, 44660 }, -- Drakescale Collar
                { 13, 44659 }, -- Pendant of the Dragonsworn
                { 14, 44657 }, -- Torque of the Red Dragonflight
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
                { 21, 44664 }, -- Favor of the Dragon Queen
                { 22, 44662 }, -- Life-Binder's Locket
                { 23, 44665 }, -- Nexus War Champion Beads
                { 24, 44661 }, -- Wyrmrest Necklace of Power
                { 26, 43952 }, -- Reins of the Azure Drake
                { 28, 44577 }, -- Heroic Key to the Focusing Iris
                { 29, 44650 }, -- Heart of Magic
            }
        },
        KEYS
    }
}