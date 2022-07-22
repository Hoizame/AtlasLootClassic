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
if AtlasLoot:GetGameVersion() < AtlasLoot.WRATH_VERSION_NUM then return end
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

data["StratholmeEpoch"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	--MapID = 2367,
	--InstanceID = 560,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	--LevelRange = {63, 66, 70},
	items = {
        { -- CoTStratholmeSalramm
            name = AL["CoTStratholmeSalramm"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
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
            name = AL["CoTStratholmeMeathook"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
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
            name = AL["CoTStratholmeEpoch"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            --AtlasMapBossID = 1,
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
            name = AL["CoTStratholmeMalGanis"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
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
            name = AL["CoTStratholmeInfiniteCorruptorHEROIC"],
            --npcID = 17848,
            --Level = 68,
            --DisplayIDs = {{17386}},
            --AtlasMapBossID = 1,
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
	--MapID = 2367,
	--InstanceID = 560,
	AtlasModule = ATLAS_MODULE_NAME,
	--AtlasMapID = "CL_CoTOldHillsbrad",
	--AtlasMapFile = {"CoTOldHillsbrad", "CavernsOfTimeEnt"},
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	--LevelRange = {63, 66, 70},
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