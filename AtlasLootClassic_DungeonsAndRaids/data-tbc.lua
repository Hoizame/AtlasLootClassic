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
if AtlasLoot:GetGameVersion() < 2 then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, 2)

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
		{ 7, 30622 }, -- Flamewrought Key
		{ 8, 30637 }, -- Flamewrought Key
		{ 9, 30623 }, -- Reservoir Key
		{ 10, 30633 }, -- Auchenai Key
		{ 11, 30635 }, -- Key of Time
		{ 12, 30634 }, -- Warpforged Key
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

data["AuchenaiCrypts"] = {
	MapID = 3790,
	InstanceID = 558,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {62, 64, 70},
	items = {
        { -- AuchCryptsShirrak
            name = AL["Shirrak the Dead Watcher"],
            npcID = {18371, 20318},
            Level = 66,
            DisplayIDs = {{18916}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
                { 20, 27870 }, -- Doomplate Legguards
            }
        },
        { -- AuchCryptsAvatar
            name = AL["Avatar of the Martyred"],
            npcID = 18478,
            Level = 72,
            DisplayIDs = {{18142}},
            -- AtlasMapBossID = 0,
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

data["Mana-Tombs"] = {
	MapID = 3792,
	InstanceID = 557,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {61, 63, 70},
	items = {
        { -- AuchManaPandemonius
            name = AL["Pandemonius"],
            npcID = {18341, 20267},
            Level = 66,
            DisplayIDs = {{19338}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 25957 }, -- Ethereal Boots of the Skystrider
                { 2, 25955 }, -- Mask of the Howling Storm
                { 3, 25956 }, -- Nexus-Bracers of Vigor
                { 4, 25954 }, -- Sigil of Shaffar
                { 5, 25962 }, -- Longstrider's Loop
                { 6, 25953 }, -- Ethereal Warp-Bow
                { 8, 22921 }, -- Recipe: Major Frost Protection Potion
                { 10, 28490 }, -- Shaffar's Wrappings
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
                { 20, 27837 }, -- Wastewalker Leggings
                { 22, 27828 }, -- Warp-Scarab Brooch
                { 23, 28400 }, -- Warp-Storm Warblade
                { 24, 27829 }, -- Axe of the Nexus-Kings
                { 25, 27840 }, -- Scepter of Sha'tar
                { 26, 27842 }, -- Grand Scepter of the Nexus-Kings
                { 28, 22921 }, -- Recipe: Major Frost Protection Potion
            }
        },
        { -- AuchManaYor
            name = AL["Yor <Void Hound of Shaffar>"],
            npcID = 22930,
            Level = 70,
            DisplayIDs = {{14173}},
            -- AtlasMapBossID = 0,
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

data["SethekkHalls"] = {
	MapID = 3791,
	InstanceID = 556,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {63, 66, 70},
	items = {
        { -- AuchSethekkDarkweaver
            name = AL["Darkweaver Syth"],
            npcID = {18472, 20690},
            Level = 69,
            DisplayIDs = {{20599}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
                { 20, 27948 }, -- Trousers of Oblivion
                { 21, 27838 }, -- Incanter's Trousers
                { 22, 27875 }, -- Hallowed Trousers
                { 23, 27776 }, -- Shoulderpads of Assassination
                { 24, 27936 }, -- Greaves of Desolation
                { 26, 27632 }, -- Terokk's Quill
                { 27, 33834 }, -- The Headfeathers of Ikiss
            }
        },
        { -- AuchSethekkRavenGod
            name = AL["Anzu"],
            npcID = 23035,
            Level = 72,
            DisplayIDs = {{21492}},
            -- AtlasMapBossID = 0,
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
	MapID = 3789,
	InstanceID = 555,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- AuchShadowHellmaw
            name = AL["Ambassador Hellmaw"],
            npcID = {18731, 20636},
            Level = 72,
            DisplayIDs = {{18821}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
                { 16, 27468 }, -- Moonglade Handwraps
            }
        },
        { -- AuchShadowGrandmaster
            name = AL["Grandmaster Vorpil"],
            npcID = {18732, 20653},
            Level = 72,
            DisplayIDs = {{18535}},
            -- AtlasMapBossID = 0,
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
                { 16, 27775 }, -- Hallowed Pauldrons
            }
        },
        { -- AuchShadowMurmur
            name = AL["Murmur"],
            npcID = {18708, 20657},
            Level = 72,
            DisplayIDs = {{18839}},
            -- AtlasMapBossID = 0,
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
                { 19, 24309 }, -- Pattern: Spellstrike Pants
                { 21, 27778 }, -- Spaulders of Oblivion
                { 22, 28232 }, -- Robe of Oblivion
                { 23, 28230 }, -- Hallowed Garments
                { 24, 27908 }, -- Leggings of Assassination
                { 25, 27909 }, -- Tidefury Kilt
                { 26, 27803 }, -- Shoulderguards of the Bold
                { 28, 33840 }, -- Murmur's Whisper
            }
        },
        { -- AuchShadowFirstFragmentGuardian
            name = AL["First Fragment Guardian"],
            npcID = 22890,
            Level = 70,
            DisplayIDs = {{19113}},
            -- AtlasMapBossID = 0,
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

data["MagistersTerrace"] = {
	MapID = 4131,
	InstanceID = 585,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- SMTFireheart
            name = AL["Selin Fireheart"],
            npcID = {24723, 25562},
            Level = 71,
            DisplayIDs = {{22642}},
            -- AtlasMapBossID = 0,
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
                { 7, 35275 }, -- Orb of the Sin'dorei
            }
        },
        { -- SMTVexallus
            name = AL["Vexallus"],
            npcID = {24744, 25573},
            Level = 71,
            DisplayIDs = {{22731}},
            -- AtlasMapBossID = 0,
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
                { 7, 35275 }, -- Orb of the Sin'dorei
            }
        },
        { -- SMTDelrissa
            name = AL["Priestess Delrissa"],
            npcID = {24560, 25560},
            Level = 70,
            DisplayIDs = {{22596},{22540},{22542},{22539},{20986},{22598},{2007},{22541},{17457}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 34792 }, -- Cloak of the Betrayed
                { 2, 34788 }, -- Duskhallow Mantle
                { 3, 34791 }, -- Gauntlets of the Tranquil Waves
                { 4, 34789 }, -- Bracers of Slaughter
                { 5, 34790 }, -- Battle-mace of the High Priestess
                { 6, 34783 }, -- Nightstrike
                { 8, 35756 }, -- Formula: Enchant Cloak - Steelweave
            },
            [HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 34473 }, -- Commendation of Kael'thas
                { 3, 34471 }, -- Vial of the Sunwell
                { 4, 34470 }, -- Timbal's Focusing Crystal
                { 5, 34472 }, -- Shard of Contempt
                { 7, 35756 }, -- Formula: Enchant Cloak - Steelweave
                { 8, 35275 }, -- Orb of the Sin'dorei
            }
        },
        { -- SMTKaelthas
            name = AL["Kael'thas Sunstrider"],
            npcID = {24664,24857},
            Level = 72,
            DisplayIDs = {{22906}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 34810 }, -- Cloak of Blade Turning
                { 2, 34808 }, -- Gloves of Arcane Acuity
                { 3, 34809 }, -- Sunrage Treads
                { 4, 34799 }, -- Hauberk of the War Bringer
                { 5, 34807 }, -- Sunstrider Warboots
                { 6, 34625 }, -- Kharmaa's Ring of Fate
                { 8, 35311 }, -- Schematic: Mana Potion Injector
                { 9, 35304 }, -- Design: Solid Star of Elune
                { 11, 34157 }, -- Head of Kael'thas
                { 16, 34793 }, -- Cord of Reconstruction
                { 17, 34796 }, -- Robes of Summer Flame
                { 18, 34795 }, -- Helm of Sanctification
                { 19, 34798 }, -- Band of Celerity
                { 20, 34794 }, -- Axe of Shattered Dreams
                { 21, 34797 }, -- Sun-infused Focus Staff
                { 22, 35504 }, -- Phoenix Hatchling
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

data["TheSlavePens"] = {
	MapID = 3717,
	InstanceID = 547,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {59, 61, 69},
	items = {
        { -- CFRSlaveMennu
            name = AL["Mennu the Betrayer"],
            npcID = {17941, 19893},
            Level = 64,
            DisplayIDs = {{17728}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            }
        },
        { -- CFRSlaveQuagmirran
            name = AL["Quagmirran"],
            npcID = {17942, 19894},
            Level = 64,
            DisplayIDs = {{18224}},
            -- AtlasMapBossID = 0,
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
                { 20, 27796 }, -- Mana-Etched Spaulders
                { 21, 27713 }, -- Pauldrons of Desolation
                { 23, 27740 }, -- Band of Ursol
                { 24, 27683 }, -- Quagmirran's Eye
                { 25, 27714 }, -- Swamplight Lantern
                { 26, 27673 }, -- Phosphorescent Blade
                { 27, 27741 }, -- Bleeding Hollow Warhammer
            }
        },
        KEYS
    }
}

data["TheSteamvault"] = {
	MapID = 3715,
	InstanceID = 545,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {65, 69, 70},
	items = {
        { -- CFRSteamThespia
            name = AL["Hydromancer Thespia"],
            npcID = {17797, 20629},
            Level = 72,
            DisplayIDs = {{11268}},
            -- AtlasMapBossID = 0,
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
                { 16, 27508 }, -- Incanter's Gloves
            }
        },
        { -- CFRSteamSteamrigger
            name = AL["Mekgineer Steamrigger"],
            npcID = {17796, 20630},
            Level = 72,
            DisplayIDs = {{18638}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        }
    }
}

data["TheUnderbog"] = {
	MapID = 3716,
	InstanceID = 546,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {60, 62, 70},
	items = {
        { -- CFRUnderHungarfen
            name = AL["Hungarfen"],
            npcID = {17770,20169},
            Level = 65,
            DisplayIDs = {{17228}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
                { 20, 27907 }, -- Mana-Etched Pantaloons
                { 21, 27771 }, -- Doomplate Shoulderguards
                { 23, 27769 }, -- Endbringer
                { 24, 27772 }, -- Stormshield of Renewal
                { 26, 24248 }, -- Brain of the Black Stalker
                { 27, 33826 }, -- Black Stalker Egg
            }
        }
    }
}

data["OldHillsbradFoothills"] = {
	MapID = 2367,
	InstanceID = 560,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = DUNGEON_CONTENT,
	--LoadDifficulty = NORMAL_DIFF,
	LevelRange = {63, 66, 70},
	items = {
        { -- CoTHillsbradDrake
            name = AL["Lieutenant Drake"],
            npcID = {17848,20535},
            Level = 68,
            DisplayIDs = {{17386}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
                { 4, 29357 }, -- Master Thief's Gloves
                { 5, 30534 }, -- Wyrmscale Greaves
                { 6, 30536 }, -- Greaves of the Martyr
                { 8, 27911 }, -- Epoch's Whispering Cinch
                { 9, 28344 }, -- Wyrmfury Pauldrons
                { 10, 28233 }, -- Necklace of Resplendent Hope
                { 11, 27904 }, -- Resounding Ring of Glory
                { 12, 28227 }, -- Sparking Arcanite Ring
                { 13, 28223 }, -- Arcanist's Stone
                { 14, 28226 }, -- Timeslicer
                { 15, 28222 }, -- Reaver of the Infinites
                { 16, 30589 }, -- Dazzling Chrysoprase
                { 17, 30591 }, -- Empowered Fire Opal
                { 18, 30590 }, -- Enduring Chrysoprase
                { 19, 24173 }, -- Design: Circlet of Arcane Might
                { 21, 28191 }, -- Mana-Etched Vestments
                { 22, 28224 }, -- Wastewalker Helm
                { 23, 28401 }, -- Hauberk of Desolation
                { 24, 28225 }, -- Doomplate Warhelm
                { 26, 33847 }, -- Epoch Hunter's Head
            }
        },
        { -- CoTHillsbradDonCarlos
            name = AL["Don Carlos"],
            npcID = {28132,28171},
            Level = 68,
            DisplayIDs = {{25124}},
            ExtraList = true,
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        }
    }
}










data["SerpentshrineCavern"] = {
	MapID = 3607,
	InstanceID = 548,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = RAID25_CONTENT,
	items = {
        { -- CFRSerpentHydross
            name = AL["Hydross the Unstable"],
            npcID = 21216,
            Level = 999,
            DisplayIDs = {{20162}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        }
    }
}

data["BlackTemple"] = {
	MapID = 3959,
	InstanceID = 564,
	--AtlasMapID = "",
	--AtlasMapFile = "",
	ContentType = RAID25_CONTENT,
	items = {
        { -- BTNajentus
            name = AL["High Warlord Naj'entus"],
            npcID = 22887,
            Level = 999,
            DisplayIDs = {{21174}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        { -- BTGorefiend
            name = AL["Teron Gorefiend"],
            npcID = 22871,
            Level = 999,
            DisplayIDs = {{21254}},
            -- AtlasMapBossID = 0,
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
        { -- BTBloodboil
            name = AL["Gurtogg Bloodboil"],
            npcID = 22948,
            Level = 999,
            DisplayIDs = {{21443}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        { -- BTShahraz
            name = AL["Mother Shahraz"],
            npcID = 22947,
            Level = 999,
            DisplayIDs = {{21252}},
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
            -- AtlasMapBossID = 0,
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
        }
    }
}
