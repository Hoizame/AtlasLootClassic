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
local data = AtlasLoot.ItemDB:Add(addonname, 4, AtlasLoot.CATA_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local LFR_DIFF = data:AddDifficulty("LFR", nil, nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID40_COLOR)

--local ATLAS_MODULE_NAME = "Atlas_Cataclysm"

-- extra
local CLASS_NAME = AtlasLoot:GetColoredClassNames()

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

-- format
local BONUS_LOOT_SPLIT = "%s - %s"

--Achievements
local CATA_DUNGEON_HERO_AC_TABLE = {	--[Cataclysm Dungeon Hero]
	name = select(2, GetAchievementInfo(4844)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 4844 },
		{ 2, 5060 },			{ 17, 5061 },
		{ 3, 5063 },			{ 18, 5064 },
		{ 4, 5062 },			{ 19, 5065 },
		{ 5, 5066 },			{ 20, 5083 },
		{ 6, 5093 }
	},
}

local CATA_GLORY_OF_THE_HERO_AC_TABLE = {	--[Glory of the Cataclysm Hero]
	AchievementID = 4845,
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 4845 },
		{ 2, 4844 },			{ 17, 5281 },
		{ 3, 5282 },			{ 18, 5283 },
		{ 4, 5284 },			{ 19, 5285 },
		{ 5, 5286 },			{ 20, 5287 },
		{ 6, 5288 },			{ 21, 5289 },
		{ 7, 5290 },			{ 22, 5291 },
		{ 8, 5292 },			{ 23, 5293 },
		{ 9, 5294 },			{ 24, 5295 },
		{ 10, 5296 },			{ 25, 5297 },
		{ 11, 5366 },			{ 26, 5367 },
		{ 12, 5368 },			{ 27, 5369 },
		{ 13, 5370 },			{ 28, 5371 },
		{ 14, 5503 },			{ 29, 5504 },
		{ 15, 5505 },			{ 30, 5298 },
	},
}

local CATA_DEFENDER_AC_TABLE = {	--[Defender of a Shattered World]
	AchievementID = 5506,
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 5506 },
		{ 2, 4842 },			{ 17, 4851 },
		{ 3, 4850 },
	},
	[HEROIC_DIFF] = {
		{ 1, 5506 },
		{ 2, 5060 },			{ 17, 5061 },
		{ 3, 5063 },			{ 18, 5064 },
		{ 4, 5062 },			{ 19, 5065 },
		{ 5, 5066 },			{ 20, 5083 },
		{ 6, 5093 }
	}
}

local CATA_RAID1_AC_TABLE = {	--[Glory of the Cataclysm Raider]
	AchievementID = 4853,
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 4853 },
		{ 2, 5306 },			{ 17, 5307 },
		{ 3, 5308 },			{ 18, 5309 },
		{ 4, 5310 },			{ 19, 4849 },
		{ 5, 5300 },			{ 20, 4852 },
		{ 6, 5311 },			{ 21, 5312 },
		{ 7, 5304 },			{ 22, 5305 },
	},
	[HEROIC_DIFF] = {
		{ 1, 4853 },
		{ 2, 5094 },			{ 17, 5109 },
		{ 3, 5108 },			{ 18, 5116 },
		{ 4, 5115 },			{ 19, 5117 },
		{ 5, 5118 },			{ 20, 5120 },
		{ 6, 5119 },			{ 21, 5123 },
		{ 7, 5107 },   			
	},
}

local CATA_RAID2_AC_TABLE = {	--[Glory of the Firelands Raider]
	AchievementID = 5828,
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 5828 },
		{ 2, 5821 },			{ 17, 5810 },
		{ 3, 5813 },			{ 18, 5829 },
		{ 4, 5830 },			{ 19, 5799 },
	},
	[HEROIC_DIFF] = {
		{ 1, 5828, "mount97560" },
		{ 2, 5807 },			{ 17, 5808 },
		{ 3, 5806 },			{ 18, 5809 },
		{ 4, 5805 },			{ 19, 5804 },
	},
}

local CATA_RAID3_AC_TABLE = {	--[Glory of the Dragon Soul Raider]
	AchievementID = 6169,
	TableType = AC_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 6169 },
		{ 2, 6174 },			{ 17, 6129 },
		{ 3, 6128 },			{ 18, 6175 },
		{ 4, 6084 },			{ 19, 6105 },
		{ 5, 6133 },			{ 20, 6180 },
	},
	[HEROIC_DIFF] = {
		{ 1, 6169 },
		{ 2, 6109 },			{ 17, 6110 },
		{ 3, 6111 },			{ 18, 6112 },
		{ 4, 6113 },			{ 19, 6114 },
	},
}

local T11_SET = {
	name = format(AL["Tier %s Sets"], "11"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{1, 4000925}, -- Death Knight Normal DPS Set
		{2, 4000926}, -- Death Knight Normal Tank Set
		{4, 4000927}, -- Druid Normal Melee Set
		{5, 4000928}, -- Druid Normal Resto Set
		{6, 4000929}, -- Druid Normal Balance Set
		{8, 4000930}, -- Hunter Normal
		{10, 4000931}, -- Mage Normal
		{12, 4000932}, -- Paladin DPS
		{13, 4000933}, -- Paladin Holy
		{14, 4000934}, -- Paladin Prot
		{16, 4000935}, -- Priest Holy
		{17, 4000936}, -- Priest Shadow
		{19, 4000937}, -- Rogue
		{21, 4000938}, -- Shaman Resto
		{22, 4000939}, -- Shaman Enhance
		{23, 4000940}, -- Shaman Elemental
		{25, 4000941}, -- Warlock
		{27, 4000942}, -- Warrior
		{28, 4000943}, -- Warrior
	},
	[HEROIC_DIFF] = {
		{1, 4001925}, -- Death Knight Heroic DPS Set
		{2, 4001926}, -- Death Knight Heroic Tank Set
		{4, 4001927}, -- Druid Normal Melee Set
		{5, 4001928}, -- Druid Normal Resto Set
		{6, 4001929}, -- Druid Normal Balance Set
		{8, 4001930}, -- Hunter Heroic
		{10, 4001931}, -- Mage Heroic
		{12, 4001932}, -- Paladin DPS
		{13, 4001933}, -- Paladin Holy
		{14, 4001934}, -- Paladin Prot
		{16, 4001935}, -- Priest Holy
		{17, 4001936}, -- Priest Shadow
		{19, 4001937}, -- Rogue
		{21, 4001938}, -- Shaman Resto
		{22, 4001939}, -- Shaman Enhance
		{23, 4001940}, -- Shaman Elemental
		{25, 4001941}, -- Warlock
		{27, 4001942}, -- Warrior
		{28, 4001943}, -- Warrior
	},
}

local T12_SET = {
	name = format(AL["Tier %s Sets"], "12"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{1, 4000944}, -- Death Knight Normal DPS Set
		{2, 4000945}, -- Death Knight Normal Tank Set
		{4, 4000946}, -- Druid Normal Melee Set
		{5, 4000947}, -- Druid Normal Resto Set
		{6, 4000948}, -- Druid Normal Balance Set
		{8, 4000949}, -- Hunter Normal
		{10, 4000950}, -- Mage Normal
		{12, 4000951}, -- Paladin DPS
		{13, 4000952}, -- Paladin Holy
		{14, 4000953}, -- Paladin Prot
		{16, 4000954}, -- Priest
		{17, 4000955}, -- Priest
		{19, 4000956}, -- Rogue
		{21, 4000957}, -- Shaman
		{22, 4000958}, -- Shaman
		{23, 4000959}, -- Shaman
		{25, 4000960}, -- Warlock
		{27, 4000961}, -- Warrior
		{28, 4000962}, -- Warrior
	},
	[HEROIC_DIFF] = {
		{1, 4001944}, -- Death Knight Normal DPS Set
		{2, 4001945}, -- Death Knight Normal Tank Set
		{4, 4001946}, -- Druid Normal Melee Set
		{5, 4001947}, -- Druid Normal Resto Set
		{6, 4001948}, -- Druid Normal Balance Set
		{8, 4001949}, -- Hunter Normal
		{10, 4001950}, -- Mage Normal
		{12, 4001951}, -- Paladin DPS
		{13, 4001952}, -- Paladin Holy
		{14, 4001953}, -- Paladin Prot
		{16, 4001954}, -- Priest
		{17, 4001955}, -- Priest
		{19, 4001956}, -- Rogue
		{21, 4001957}, -- Shaman
		{22, 4001958}, -- Shaman
		{23, 4001959}, -- Shaman
		{25, 4001960}, -- Warlock
		{27, 4001961}, -- Warrior
		{28, 4001962}, -- Warrior
	},
}

local T13_SET = {
	name = format(AL["Tier %s Sets"], "13"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[LFR_DIFF] = {
		{1, 4000963}, -- Death Knight Normal DPS Set
		{2, 4000964}, -- Death Knight Normal Tank Set
		{4, 4000965}, -- Druid Normal Melee Set
		{5, 4000966}, -- Druid Normal Resto Set
		{6, 4000967}, -- Druid Normal Balance Set
		{8, 4000968}, -- Hunter Normal
		{10, 4000969}, -- Mage Normal
		{12, 4000970}, -- Paladin DPS
		{13, 4000971}, -- Paladin Holy
		{14, 4000972}, -- Paladin Prot
		{16, 4000973}, -- Priest
		{17, 4000974}, -- Priest
		{19, 4000975}, -- Rogue
		{21, 4000976}, -- Shaman
		{22, 4000977}, -- Shaman
		{23, 4000978}, -- Shaman
		{25, 4000979}, -- Warlock
		{27, 4000980}, -- Warrior
		{28, 4000981}, -- Warrior
	},
	[NORMAL_DIFF] = {
		{1, 4001963}, -- Death Knight Normal DPS Set
        {2, 4001964}, -- Death Knight Normal Tank Set
        {4, 4001965}, -- Druid Normal Melee Set
        {5, 4001966}, -- Druid Normal Resto Set
        {6, 4001967}, -- Druid Normal Balance Set
        {8, 4001968}, -- Hunter Normal
        {10, 4001969}, -- Mage Normal
        {12, 4001970}, -- Paladin DPS
        {13, 4001971}, -- Paladin Holy
        {14, 4001972}, -- Paladin Prot
        {16, 4001973}, -- Priest
        {17, 4001974}, -- Priest
        {19, 4001975}, -- Rogue
        {21, 4001976}, -- Shaman
        {22, 4001977}, -- Shaman
        {23, 4001978}, -- Shaman
        {25, 4001979}, -- Warlock
        {27, 4001980}, -- Warrior
        {28, 4001981}, -- Warrior
	},
	[HEROIC_DIFF] = {
		{1, 4002963}, -- Death Knight Normal DPS Set
        {2, 4002964}, -- Death Knight Normal Tank Set
        {4, 4002965}, -- Druid Normal Melee Set
        {5, 4002966}, -- Druid Normal Resto Set
        {6, 4002967}, -- Druid Normal Balance Set
        {8, 4002968}, -- Hunter Normal
        {10, 4002969}, -- Mage Normal
        {12, 4002970}, -- Paladin DPS
        {13, 4002971}, -- Paladin Holy
        {14, 4002972}, -- Paladin Prot
        {16, 4002973}, -- Priest
        {17, 4002974}, -- Priest
        {19, 4002975}, -- Rogue
        {21, 4002976}, -- Shaman
        {22, 4002977}, -- Shaman
        {23, 4002978}, -- Shaman
        {25, 4002979}, -- Warlock
        {27, 4002980}, -- Warrior
        {28, 4002981}, -- Warrior
	},
}

data["BlackrockCaverns"] = {
	MapID = 4926,
	--EncounterJournalID = 66,
	InstanceID = 66,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {77, 80, 83},
	items = {
		{ -- Rom'ogg Bonecrusher
			name = AL["Rom'ogg Bonecrusher"],
			EncounterJournalID = 105,
			[NORMAL_DIFF] = {
				{ 1, 55278 },	-- Inquisition Robes
				{ 2, 55279 },	-- Manacles of Pain
				{ 3, 55776 },	-- Skullcracker Ring
				{ 4, 55777 },	-- Torturer's Mercy
				{ 5, 55778 },	-- Shield of the Iron Maiden
			},
			[HEROIC_DIFF] = {
				{ 1, 56311 },	-- Inquisition Robes
				{ 2, 56313 },	-- Manacles of Pain
				{ 3, 56310 },	-- Skullcracker Ring
				{ 4, 56312 },	-- Torturer's Mercy
				{ 5, 56314 },	-- Shield of the Iron Maiden
				{ 16, "ac5281" },
			},
		},
		{ -- Corla, Herald of Twilight
			name = AL["Corla, Herald of Twilight"],
			EncounterJournalID = 106,
			[NORMAL_DIFF] = {
				{ 1, 55264 },	-- Armbands of Change
				{ 2, 55263 },	-- Renouncer's Cowl
				{ 3, 55265 },	-- Signet of Transformation
				{ 4, 55266 },	-- Grace of the Herald
				{ 5, 55267 },	-- Corla's Baton
			},
			[HEROIC_DIFF] = {
				{ 1, 56297 },	-- Armbands of Change
				{ 2, 56298 },	-- Renouncer's Cowl
				{ 3, 56299 },	-- Signet of Transformation
				{ 4, 56295 },	-- Grace of the Herald
				{ 5, 56296 },	-- Corla's Baton
				{ 16, "ac5282" },
			},
		},
		{ -- Karsh Steelbender
			name = AL["Karsh Steelbender"],
			EncounterJournalID = 107,
			[NORMAL_DIFF] = {
				{ 1, 55270 },	-- Burned Gatherings
				{ 2, 55269 },	-- Heat Wave Leggings
				{ 3, 55268 },	-- Bracers of Cooled Anger
				{ 4, 55271 },	-- Quicksilver Amulet
				{ 5, 55272 },	-- Steelbender's Masterpiece
			},
			[HEROIC_DIFF] = {
				{ 1, 56304 },	-- Burned Gatherings
				{ 2, 56303 },	-- Heat Wave Leggings
				{ 3, 56301 },	-- Bracers of Cooled Anger
				{ 4, 56300 },	-- Quicksilver Amulet
				{ 5, 56302 },	-- Steelbender's Masterpiece
				{ 16, "ac5283" },
			},
		},
		{ -- Beauty
			name = AL["Beauty"],
			EncounterJournalID = 108,
			[NORMAL_DIFF] = {
				{ 1, 55275 },	-- Beauty's Silken Ribbon
				{ 2, 55273 },	-- Beauty's Chew Toy
				{ 3, 55274 },	-- Beauty's Plate
				{ 4, 55276 },	-- Kibble
				{ 5, 55277 },	-- Beauty's Favorite Bone
			},
			[HEROIC_DIFF] = {
				{ 1, 56305 },	-- Beauty's Silken Ribbon
				{ 2, 56309 },	-- Beauty's Chew Toy
				{ 3, 56308 },	-- Beauty's Plate
				{ 4, 56307 },	-- Kibble
				{ 5, 56306 },	-- Beauty's Favorite Bone
			},
		},
		{ -- Ascendant Lord Obsidius
			name = AL["Ascendant Lord Obsidius"],
			EncounterJournalID = 109,
			[NORMAL_DIFF] = {
				{ 1, 55780 },	-- Twitching Shadows
				{ 2, 55786 },	-- Kyrstel Mantle
				{ 3, 55785 },	-- Willowy Crown
				{ 4, 55779 },	-- Raz's Pauldrons
				{ 5, 55784 },	-- Clutches of Dying Light
				{ 6, 55781 },	-- Carrier Wave Pendant
				{ 7, 55787 },	-- Witching Hourglass
				{ 8, 55782 },	-- Amber Messenger
				{ 9, 55788 },	-- Crepuscular Shield
				{ 16, "ac4833" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56315 },	-- Twitching Shadows
				{ 2, 56324 },	-- Kyrstel Mantle
				{ 3, 56321 },	-- Willowy Crown
				{ 4, 56318 },	-- Raz's Pauldrons
				{ 5, 56323 },	-- Clutches of Dying Light
				{ 6, 56319 },	-- Carrier Wave Pendant
				{ 7, 56320 },	-- Witching Hourglass
				{ 8, 56317 },	-- Amber Messenger
				{ 9, 56322 },	-- Crepuscular Shield
				{ 11, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5060" },
				{ 17, "ac5284" },
			},
		},
		{	--BlackrockCavernsTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 55791 },	-- Acanthia's Lost Pendant
				{ 16, 55790 },	-- Toxidunk Dagger
				{ 17, 55789 },	-- Berto's Staff
			},
		},
		CATA_DUNGEON_HERO_AC_TABLE,
		CATA_DEFENDER_AC_TABLE,
		CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["ThroneOfTheTides"] = {
	MapID = 5004,
	EncounterJournalID = 65,
	InstanceID = 643,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {77, 80, 83},
	items = {
		{ -- Lady Naz'jar
			name = AL["Lady Naz'jar"],
			EncounterJournalID = 101,
			[NORMAL_DIFF] = {
				{ 1, 55202 },	-- Periwinkle Cloak
				{ 2, 55198 },	-- Aurelian Mitre
				{ 3, 55195 },	-- Wrasse Handwraps
				{ 4, 55201 },	-- Entwined Nereis
				{ 5, 55203 },	-- Lightning Whelk Axe
			},
			[HEROIC_DIFF] = {
				{ 1, 56267 },	-- Periwinkle Cloak
				{ 2, 56269 },	-- Aurelian Mitre
				{ 3, 56268 },	-- Wrasse Handwraps
				{ 4, 56270 },	-- Entwined Nereis
				{ 5, 56266 },	-- Lightning Whelk Axe
				{ 16, "ac5285" },
			},
		},
		{ -- Commander Ulthok, the Festering Prince
			name = AL["Commander Ulthok, the Festering Prince"],
			EncounterJournalID = 102,
			[NORMAL_DIFF] = {
				{ 1, 55206 },	-- Eagle Ray Cloak
				{ 2, 55204 },	-- Caridean Epaulettes
				{ 3, 55205 },	-- Chromis Chestpiece
				{ 4, 55207 },	-- Harp Shell Pauldrons
				{ 5, 55228 },	-- Cerith Spire Staff
			},
			[HEROIC_DIFF] = {
				{ 1, 56275 },	-- Eagle Ray Cloak
				{ 2, 56273 },	-- Caridean Epaulettes
				{ 3, 56274 },	-- Chromis Chestpiece
				{ 4, 56272 },	-- Harp Shell Pauldrons
				{ 5, 56271 },	-- Cerith Spire Staff
			},
		},
		{ -- Mindbender Ghur'sha
			name = AL["Mindbender Ghur'sha"],
			EncounterJournalID = 103,
			[NORMAL_DIFF] = {
				{ 1, 55236 },	-- Anthia's Ring
				{ 2, 55235 },	-- Decapod Slippers
				{ 3, 55229 },	-- Anomuran Helm
				{ 4, 55237 },	-- Porcelain Crab
			},
			[HEROIC_DIFF] = {
				{ 1, 56276 },	-- Anthia's Ring
				{ 2, 56277 },	-- Decapod Slippers
				{ 3, 56278 },	-- Anomuran Helm
				{ 4, 56280 },	-- Porcelain Crab
			},
		},
		{ -- Ozumat
			name = AL["Ozumat"],
			EncounterJournalID = 104,
			[NORMAL_DIFF] = {
				{ 1, 55255 },	-- Mnemiopsis Gloves
				{ 2, 55253 },	-- Wentletrap Vest
				{ 3, 55254 },	-- Abalone Plate Armor
				{ 4, 55249 },	-- Triton Legplates
				{ 5, 55258 },	-- Pipefish Cord
				{ 6, 55250 },	-- Nautilus Ring
				{ 7, 55251 },	-- Might of the Ocean
				{ 8, 55256 },	-- Sea Star
				{ 9, 55259 },	-- Bioluminescent Lamp
				{ 10, 55252 },	-- Whitefin Axe
				{ 16, "ac4839" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56286 },	-- Mnemiopsis Gloves
				{ 2, 56281 },	-- Wentletrap Vest
				{ 3, 56291 },	-- Abalone Plate Armor
				{ 4, 56283 },	-- Triton Legplates
				{ 5, 56288 },	-- Pipefish Cord
				{ 6, 56282 },	-- Nautilus Ring
				{ 7, 56285 },	-- Might of the Ocean
				{ 8, 56290 },	-- Sea Star
				{ 9, 56289 },	-- Bioluminescent Lamp
				{ 10, 56284 },	-- Whitefin Axe
				{ 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5061" },
				{ 17, "ac5286" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 55260 },	-- Alpheus Legguards
			{ 16, 55262 },	-- Barnacle Pendant
			{ 17, 55261 },	-- Ring of the Great Whale
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["TheStonecore"] = {
	MapID = 5088,
	EncounterJournalID = 67,
	InstanceID = 725,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {79, 81, 85},
	items = {
		{ -- Corborus
			name = AL["Corborus"],
			EncounterJournalID = 110,
			[NORMAL_DIFF] = {
				{ 1, 55793 },	-- Dolomite Adorned Gloves
				{ 2, 55792 },	-- Cinnabar Shoulders
				{ 3, 55794 },	-- Phosphorescent Ring
				{ 4, 55795 },	-- Key to the Endless Chamber
				{ 5, 55796 },	-- Fist of Pained Senses
			},
			[HEROIC_DIFF] = {
				{ 1, 56331 },	-- Dolomite Adorned Gloves
				{ 2, 56330 },	-- Cinnabar Shoulders
				{ 3, 56332 },	-- Phosphorescent Ring
				{ 4, 56328 },	-- Key to the Endless Chamber
				{ 5, 56329 },	-- Fist of Pained Senses
			},
		},
		{ -- Slabhide
			name = AL["Slabhide"],
			EncounterJournalID = 111,
			[NORMAL_DIFF] = {
				{ 1, 55798 },	-- Deep Delving Gloves
				{ 2, 55797 },	-- Hematite Plate Gloves
				{ 3, 55799 },	-- Rose Quartz Band
				{ 4, 55801 },	-- Quicksilver Blade
				{ 16, 63043, "mount" },	-- Reins of the Vitreous Stone Drake
			},
			[HEROIC_DIFF] = {
				{ 1, 56334 },	-- Deep Delving Gloves
				{ 2, 56336 },	-- Hematite Plate Gloves
				{ 3, 56333 },	-- Rose Quartz Band
				{ 4, 56335 },	-- Quicksilver Blade
				{ 16, 63043, "mount" },	-- Reins of the Vitreous Stone Drake
			},
		},
		{ -- Ozruk
			name = AL["Ozruk"],
			EncounterJournalID = 112,
			[NORMAL_DIFF] = {
				{ 1, 55802 },	-- Elementium Scale Bracers
				{ 2, 55803 },	-- Belt of the Ringworm
				{ 3, 55804 },	-- Pendant of the Lightless Grotto
				{ 4, 55810 },	-- Tendrils of Burrowing Dark
				{ 5, 55811 },	-- Sword of the Bottomless Pit
			},
			[HEROIC_DIFF] = {
				{ 1, 56340 },	-- Elementium Scale Bracers
				{ 2, 56341 },	-- Belt of the Ringworm
				{ 3, 56338 },	-- Pendant of the Lightless Grotto
				{ 4, 56339 },	-- Tendrils of Burrowing Dark
				{ 5, 56342 },	-- Sword of the Bottomless Pit
			},
		},
		{ -- High Priestess Azil
			name = AL["High Priestess Azil"],
			EncounterJournalID = 113,
			[NORMAL_DIFF] = {
				{ 1, 55817 },	-- Slippers of the Twilight Prophet
				{ 2, 55812 },	-- Helm of Numberless Shadows
				{ 3, 55818 },	-- Cowl of the Unseen World
				{ 4, 55816 },	-- Leaden Despair
				{ 5, 55814 },	-- Magnetite Mirror
				{ 6, 55819 },	-- Tear of Blood
				{ 7, 55820 },	-- Prophet's Scepter
				{ 8, 55813 },	-- Elementium Fang
				{ 9, 55815 },	-- Darkling Staff
				{ 16, "ac4846" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56348 },	-- Slippers of the Twilight Prophet
				{ 2, 56344 },	-- Helm of Numberless Shadows
				{ 3, 56352 },	-- Cowl of the Unseen World
				{ 4, 56347 },	-- Leaden Despair
				{ 5, 56345 },	-- Magnetite Mirror
				{ 6, 56351 },	-- Tear of Blood
				{ 7, 56349 },	-- Prophet's Scepter
				{ 8, 56346 },	-- Elementium Fang
				{ 9, 56343 },	-- Darkling Staff
				{ 11, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5063" },
				{ 17, "ac5287" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 55824 },	-- Skin of Stone
			{ 16, 55822 },	-- Heavy Geode Mace
			{ 17, 55823 },	-- Wand of Dark Worship
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["TheVortexPinnacle"] = {
	MapID = 5035,
	InstanceID = 657,
	EncounterJournalID = 68,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {79, 81, 85},
	items = {
		{ -- Grand Vizier Ertan
			name = AL["Grand Vizier Ertan"],
			EncounterJournalID = 114,
			[NORMAL_DIFF] = {
				{ 1, 55830 },	-- Stratosphere Belt
				{ 2, 55832 },	-- Fallen Snow Shoulderguards
				{ 3, 55831 },	-- Headcover of Fog
				{ 4, 55833 },	-- Red Sky Pendant
				{ 5, 55834 },	-- Biting Wind
				{ 7, 65660, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grand Vizier Ertan's Heart
			},
			[HEROIC_DIFF] = {
				{ 1, 56356 },	-- Stratosphere Belt
				{ 2, 56359 },	-- Fallen Snow Shoulderguards
				{ 3, 56358 },	-- Headcover of Fog
				{ 4, 56360 },	-- Red Sky Pendant
				{ 5, 56357 },	-- Biting Wind
				{ 7, 65660, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grand Vizier Ertan's Heart
			},
		},
		{ -- Altairus
			name = AL["Altairus"],
			EncounterJournalID = 115,
			[NORMAL_DIFF] = {
				{ 1, 55838 },	-- Mantle of Bestilled Winds
				{ 2, 55835 },	-- Hail-Strung Belt
				{ 3, 55840 },	-- Amulet of Tender Breath
				{ 4, 55839 },	-- Skyshard Ring
				{ 5, 55841 },	-- Axe of the Eclipse
				{ 16, 63040, "mount" },	-- Reins of the Drake of the North Wind
			},
			[HEROIC_DIFF] = {
				{ 1, 56361 },	-- Mantle of Bestilled Winds
				{ 2, 56363 },	-- Hail-Strung Belt
				{ 3, 56362 },	-- Amulet of Tender Breath
				{ 4, 56365 },	-- Skyshard Ring
				{ 5, 56364 },	-- Axe of the Eclipse
				{ 16, 63040, "mount" },	-- Reins of the Drake of the North Wind
			},
		},
		{ -- Asaad, Caliph of Zephyrs
			name = AL["Asaad, Caliph of Zephyrs"],
			EncounterJournalID = 116,
			[NORMAL_DIFF] = {
				{ 1, 55847 },	-- Billowing Cape
				{ 2, 55850 },	-- Shadow of Perfect Bliss
				{ 3, 55849 },	-- Leggings of Iridescent Clouds
				{ 4, 55844 },	-- Gloves of Haze
				{ 5, 55848 },	-- Lunar Halo
				{ 6, 55842 },	-- Legguards of Winnowing Wind
				{ 7, 55851 },	-- Ring of Frozen Rain
				{ 8, 55845 },	-- Heart of Thunder
				{ 9, 55846 },	-- Lightningflash
				{ 10, 55853 },	-- Thundercall
				{ 16, "ac4847" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56369 },	-- Billowing Cape
				{ 2, 56371 },	-- Shadow of Perfect Bliss
				{ 3, 56375 },	-- Leggings of Iridescent Clouds
				{ 4, 56368 },	-- Gloves of Haze
				{ 5, 56374 },	-- Lunar Halo
				{ 6, 56367 },	-- Legguards of Winnowing Wind
				{ 7, 56373 },	-- Ring of Frozen Rain
				{ 8, 56370 },	-- Heart of Thunder
				{ 9, 56366 },	-- Lightningflash
				{ 10, 56376 },	-- Thundercall
				{ 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5064" },
				{ 17, "ac5288" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 55855 },	-- Darksky Treads
			{ 16, 55854 },	-- Rainsong
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["LostCityOfTolvir"] = {
	MapID = 5396,
	InstanceID = 755,
	EncounterJournalID = 69,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {80, 83, 85},
	items = {
		{ -- General Husam
			name = AL["General Husam"],
			EncounterJournalID = 117,
			[NORMAL_DIFF] = {
				{ 1, 55858 },	-- Kaleki Cloak
				{ 2, 55857 },	-- Ionic Gloves
				{ 3, 55856 },	-- Greaves of Wu the Elder
				{ 4, 55859 },	-- Spirit Creeper Ring
				{ 5, 55860 },	-- Seliza's Spear
			},
			[HEROIC_DIFF] = {
				{ 1, 56379 },	-- Kaleki Cloak
				{ 2, 56383 },	-- Ionic Gloves
				{ 3, 56381 },	-- Greaves of Wu the Elder
				{ 4, 56380 },	-- Spirit Creeper Ring
				{ 5, 56382 },	-- Seliza's Spear
			},
		},
		{ -- Lockmaw
			name = AL["Lockmaw"],
			EncounterJournalID = 118,
			[NORMAL_DIFF] = {
				{ 1, 55866 },	-- Sand Silk Wristband
				{ 2, 55867 },	-- Sand Dune Belt
				{ 3, 55869 },	-- Veneficial Band
				{ 4, 55868 },	-- Heart of Solace
				{ 5, 55870 },	-- Barim's Main Gauche
			},
			[HEROIC_DIFF] = {
				{ 1, 56389 },	-- Sand Silk Wristband
				{ 2, 56392 },	-- Sand Dune Belt
				{ 3, 56391 },	-- Veneficial Band
				{ 4, 56393 },	-- Heart of Solace
				{ 5, 56390 },	-- Barim's Main Gauche
				{ 16, "ac5291" },
			},
		},
		{ -- High Prophet Barim
			name = AL["High Prophet Barim"],
			EncounterJournalID = 119,
			[NORMAL_DIFF] = {
				{ 1, 55861 },	-- Balkar's Waders
				{ 2, 55862 },	-- Greaves of Wu the Younger
				{ 3, 55864 },	-- Tauntka's Necklace
				{ 4, 55863 },	-- Ring of the Darkest Day
				{ 5, 55865 },	-- Resonant Kris
			},
			[HEROIC_DIFF] = {
				{ 1, 56386 },	-- Balkar's Waders
				{ 2, 56387 },	-- Greaves of Wu the Younger
				{ 3, 56385 },	-- Tauntka's Necklace
				{ 4, 56388 },	-- Ring of the Darkest Day
				{ 5, 56384 },	-- Resonant Kris
				{ 16, "ac5290" },
			},
		},
		{ -- Siamat
			name = AL["Siamat"],
			EncounterJournalID = 122,
			[NORMAL_DIFF] = {
				{ 1, 55872 },	-- Geordan's Cloak
				{ 2, 55876 },	-- Mantle of Master Cho
				{ 3, 55878 },	-- Evelyn's Belt
				{ 4, 55877 },	-- Leggings of the Path
				{ 5, 55871 },	-- Crafty's Gaiters
				{ 6, 55873 },	-- Ring of Three Lights
				{ 7, 55874 },	-- Tia's Grace
				{ 8, 55879 },	-- Sorrowsong
				{ 9, 55875 },	-- Hammer of Sparks
				{ 10, 55880 },	-- Zora's Ward
				{ 16, "ac4848" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56397 },	-- Geordan's Cloak
				{ 2, 56399 },	-- Mantle of Master Cho
				{ 3, 56403 },	-- Evelyn's Belt
				{ 4, 56401 },	-- Leggings of the Path
				{ 5, 56395 },	-- Crafty's Gaiters
				{ 6, 56398 },	-- Ring of Three Lights
				{ 7, 56394 },	-- Tia's Grace
				{ 8, 56400 },	-- Sorrowsong
				{ 9, 56396 },	-- Hammer of Sparks
				{ 10, 56402 },	-- Zora's Ward
				{ 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5066" },
				{ 17, "ac5292" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 55882 },	-- Oasis Bracers
			{ 16, 55884 },	-- Mirage Ring
			{ 17, 55881 },	-- Impetuous Query
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["HallsOfOrigination"] = {
	MapID = 4945,
	InstanceID = 644,
	EncounterJournalID = 70,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {80, 83, 85},
	items = {
		{ -- Temple Guardian Anhuur
			name = AL["Temple Guardian Anhuur"],
			EncounterJournalID = 124,
			[NORMAL_DIFF] = {
				{ 1, 55886 },	-- Poison Fang Bracers
				{ 2, 55890 },	-- Awakening Footfalls
				{ 3, 55887 },	-- Belt of Petrified Tears
				{ 4, 55888 },	-- Darkhowl Amulet
				{ 5, 55889 },	-- Anhuur's Hymnal
			},
			[HEROIC_DIFF] = {
				{ 1, 56409 },	-- Poison Fang Bracers
				{ 2, 56408 },	-- Awakening Footfalls
				{ 3, 56410 },	-- Belt of Petrified Tears
				{ 4, 56411 },	-- Darkhowl Amulet
				{ 5, 56407 },	-- Anhuur's Hymnal
				{ 16, "ac5293" },
			},
		},
		{ -- Earthrager Ptah
			name = AL["Earthrager Ptah"],
			EncounterJournalID = 125,
			[NORMAL_DIFF] = {
				{ 1, 56094 },	-- Underworld Cord
				{ 2, 56093 },	-- Breastplate of the Risen Land
				{ 3, 56095 },	-- Mouth of the Earth
				{ 4, 56097 },	-- Soul Releaser
				{ 5, 56096 },	-- Bulwark of the Primordial Mound
			},
			[HEROIC_DIFF] = {
				{ 1, 56423 },	-- Underworld Cord
				{ 2, 56425 },	-- Breastplate of the Risen Land
				{ 3, 56422 },	-- Mouth of the Earth
				{ 4, 56424 },	-- Soul Releaser
				{ 5, 56426 },	-- Bulwark of the Primordial Mound
				{ 16, "ac5294" },
			},
		},
		{ -- Anraphet
			name = AL["Anraphet"],
			EncounterJournalID = 126,
			[NORMAL_DIFF] = {
				{ 1, 57860 },	-- Anraphet's Regalia
				{ 2, 57858 },	-- Mantle of Soft Shadows
				{ 3, 57857 },	-- Boots of Crumbling Ruin
				{ 4, 57856 },	-- Omega Breastplate
				{ 5, 57855 },	-- Alpha Bracers
			},
			[HEROIC_DIFF] = {
				{ 1, 57868 },	-- Anraphet's Regalia
				{ 2, 57866 },	-- Mantle of Soft Shadows
				{ 3, 57867 },	-- Boots of Crumbling Ruin
				{ 4, 57869 },	-- Omega Breastplate
				{ 5, 57870 },	-- Alpha Bracers
				{ 16, "ac5296" },
			},
		},
		{ -- Isiset, Construct of Magic
			name = AL["Isiset, Construct of Magic"],
			EncounterJournalID = 127,
			[NORMAL_DIFF] = {
				{ 1, 55993 },	-- Legwraps of Astral Rain
				{ 2, 55992 },	-- Armguards of Unearthly Light
				{ 3, 55996 },	-- Nova Band
				{ 4, 55994 },	-- Ring of Blinding Stars
				{ 5, 55995 },	-- Blood of Isiset
			},
			[HEROIC_DIFF] = {
				{ 1, 56413 },	-- Legwraps of Astral Rain
				{ 2, 56416 },	-- Armguards of Unearthly Light
				{ 3, 56415 },	-- Nova Band
				{ 4, 56412 },	-- Ring of Blinding Stars
				{ 5, 56414 },	-- Blood of Isiset
			},
		},
		{ -- Ammunae, Construct of Life
			name = AL["Ammunae, Construct of Life"],
			EncounterJournalID = 128,
			[NORMAL_DIFF] = {
				{ 1, 55998 },	-- Robes of Rampant Growth
				{ 2, 55997 },	-- Bloodpetal Mantle
				{ 3, 55999 },	-- Seedling Pod
				{ 4, 56000 },	-- Band of Life Energy
			},
			[HEROIC_DIFF] = {
				{ 1, 56417 },	-- Robes of Rampant Growth
				{ 2, 56419 },	-- Bloodpetal Mantle
				{ 3, 56421 },	-- Seedling Pod
				{ 4, 56418 },	-- Band of Life Energy
			},
		},
		{ -- Setesh, Construct of Destruction
			name = AL["Setesh, Construct of Destruction"],
			EncounterJournalID = 129,
			[NORMAL_DIFF] = {
				{ 1, 57864 },	-- Helm of the Typhonic Beast
				{ 2, 57863 },	-- Hieroglyphic Vest
				{ 3, 57862 },	-- Chaotic Wrappings
				{ 4, 57861 },	-- Helm of Setesh
				{ 5, 57865 },	-- Scepter of Power
			},
			[HEROIC_DIFF] = {
				{ 1, 57871 },	-- Helm of the Typhonic Beast
				{ 2, 57874 },	-- Hieroglyphic Vest
				{ 3, 57875 },	-- Chaotic Wrappings
				{ 4, 57873 },	-- Helm of Setesh
				{ 5, 57872 },	-- Scepter of Power
			},
		},
		{ -- Rajh, Construct of Sun
			name = AL["Rajh, Construct of Sun"],
			EncounterJournalID = 130,
			[NORMAL_DIFF] = {
				{ 1, 56107 },	-- Solar Wind Cloak
				{ 2, 56105 },	-- Hekatic Slippers
				{ 3, 56098 },	-- Red Beam Cord
				{ 4, 56099 },	-- Fingers of Light
				{ 5, 56104 },	-- Legguards of Noon
				{ 6, 56106 },	-- Band of Rays
				{ 7, 56102 },	-- Left Eye of Rajh
				{ 8, 56100 },	-- Right Eye of Rajh
				{ 9, 56108 },	-- Blade of the Burning Sun
				{ 10, 56101 },	-- Sun Strike
				{ 16, "ac4841" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56434 },	-- Solar Wind Cloak
				{ 2, 56436 },	-- Hekatic Slippers
				{ 3, 56429 },	-- Red Beam Cord
				{ 4, 56428 },	-- Fingers of Light
				{ 5, 56435 },	-- Legguards of Noon
				{ 6, 56432 },	-- Band of Rays
				{ 7, 56427 },	-- Left Eye of Rajh
				{ 8, 56431 },	-- Right Eye of Rajh
				{ 9, 56433 },	-- Blade of the Burning Sun
				{ 10, 56430 },	-- Sun Strike
				{ 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5065" },
				{ 17, "ac5295" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 56110 },	-- Charm of the Muse
			{ 2, 56111 },	-- Temple Band
			{ 16, 56109 },	-- Book of Origination
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["GrimBatol"] = {
	MapID = 4950,
	InstanceID = 670,
	EncounterJournalID = 71,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {80, 84, 85},
	items = {
		{ -- General Umbriss
			name = AL["General Umbriss"],
			EncounterJournalID = 131,
			[NORMAL_DIFF] = {
				{ 1, 56113 },	-- Cursed Skardyn Vest
				{ 2, 56112 },	-- Wildhammer Riding Helm
				{ 3, 56114 },	-- Umbriss Band
				{ 4, 56115 },	-- Skardyn's Grace
				{ 5, 56116 },	-- Modgud's Blade
			},
			[HEROIC_DIFF] = {
				{ 1, 56442 },	-- Cursed Skardyn Vest
				{ 2, 56443 },	-- Wildhammer Riding Helm
				{ 3, 56444 },	-- Umbriss Band
				{ 4, 56440 },	-- Skardyn's Grace
				{ 5, 56441 },	-- Modgud's Blade
				{ 16, "ac5297" },
			},
		},
		{ -- Forgemaster Throngus
			name = AL["Forgemaster Throngus"],
			EncounterJournalID = 132,
			[NORMAL_DIFF] = {
				{ 1, 56119 },	-- Dark Iron Chain Boots
				{ 2, 56118 },	-- Belt of the Forgemaster
				{ 3, 56120 },	-- Ring of Dun Algaz
				{ 4, 56121 },	-- Throngus's Finger
				{ 5, 56122 },	-- Wand of Untainted Power
			},
			[HEROIC_DIFF] = {
				{ 1, 56448 },	-- Dark Iron Chain Boots
				{ 2, 56447 },	-- Belt of the Forgemaster
				{ 3, 56445 },	-- Ring of Dun Algaz
				{ 4, 56449 },	-- Throngus's Finger
				{ 5, 56446 },	-- Wand of Untainted Power
			},
		},
		{ -- Drahga Shadowburner
			name = AL["Drahga Shadowburner"],
			EncounterJournalID = 133,
			[NORMAL_DIFF] = {
				{ 1, 56126 },	-- Azureborne Cloak
				{ 2, 56125 },	-- Crimsonborne Bracers
				{ 3, 56123 },	-- Red Scale Boots
				{ 4, 56124 },	-- Earthshape Pauldrons
				{ 5, 56127 },	-- Windwalker Blade
				{ 7, 66927, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Missive to Cho'gall
			},
			[HEROIC_DIFF] = {
				{ 1, 56450 },	-- Azureborne Cloak
				{ 2, 56453 },	-- Crimsonborne Bracers
				{ 3, 56451 },	-- Red Scale Boots
				{ 4, 56452 },	-- Earthshape Pauldrons
				{ 5, 56454 },	-- Windwalker Blade
				{ 7, 66927, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Missive to Cho'gall
			},
		},
		{ -- Erudax, the Duke of Below
			name = AL["Erudax, the Duke of Below"],
			EncounterJournalID = 134,
			[NORMAL_DIFF] = {
				{ 1, 56133 },	-- Crown of Enfeebled Bodies
				{ 2, 56128 },	-- Vest of Misshapen Hides
				{ 3, 56135 },	-- Bracers of Umbral Mending
				{ 4, 56129 },	-- Circle of Bone
				{ 5, 56136 },	-- Corrupted Egg Shell
				{ 6, 56138 },	-- Gale of Shadows
				{ 7, 56132 },	-- Mark of Khardros
				{ 8, 56130 },	-- Mace of Transformed Bone
				{ 9, 56131 },	-- Wild Hammer
				{ 10, 56137 },	-- Staff of Siphoned Essences
				{ 16, "ac4840" },
			},
			[HEROIC_DIFF] = {
				{ 1, 56460 },	-- Crown of Enfeebled Bodies
				{ 2, 56455 },	-- Vest of Misshapen Hides
				{ 3, 56464 },	-- Bracers of Umbral Mending
				{ 4, 56457 },	-- Circle of Bone
				{ 5, 56463 },	-- Corrupted Egg Shell
				{ 6, 56462 },	-- Gale of Shadows
				{ 7, 56458 },	-- Mark of Khardros
				{ 8, 56459 },	-- Mace of Transformed Bone
				{ 9, 56456 },	-- Wild Hammer
				{ 10, 56461 },	-- Staff of Siphoned Essences
				{ 12, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5062" },
				{ 17, "ac5298" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[NORMAL_DIFF] = {
			{ 1, 56219 },	-- Shroud of Dark Memories
			{ 2, 56218 },	-- Curse-Tainted Leggings
			{ 16, 56220 },	-- Abandoned Dark Iron Ring
		},
	},
	CATA_DUNGEON_HERO_AC_TABLE,
	CATA_DEFENDER_AC_TABLE,
	CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["Deadmines"] = {
	MapID = 1581,
	--EncounterJournalID = 36,
	InstanceID = 36,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Glubtok
			name = AL["Glubtok"],
			EncounterJournalID = 89,
			[HEROIC_DIFF] = {
				{ 1, 63467 },	-- Shadow of the Past
				{ 2, 63468 },	-- Defias Brotherhood Vest
				{ 3, 63471 },	-- Vest of the Curious Visitor
				{ 4, 63470 },	-- Missing Diplomat's Pauldrons
				{ 5, 65163 },	-- Buzzer Blade
				{ 16, "ac5366" },
			},
		},
		{ -- Helix Gearbreaker
			name = AL["Helix Gearbreaker"],
			EncounterJournalID = 90,
			[HEROIC_DIFF] = {
				{ 1, 63473 },	-- Cloak of Thredd
				{ 2, 63475 },	-- Old Friend's Gloves
				{ 3, 63476 },	-- Gearbreaker's Bindings
				{ 4, 63474 },	-- Gear-Marked Gauntlets
				{ 5, 65164 },	-- Cruel Barb
				{ 16, "ac5367" },
			},
		},
		{ -- Foe Reaper 5000
			name = AL["Foe Reaper 5000"],
			EncounterJournalID = 91,
			[HEROIC_DIFF] = {
				{ 1, 65166 },	-- Buzz Saw
				{ 2, 65165 },	-- Foe Reaper
				{ 3, 65167 },	-- Emberstone Staff
				{ 16, "ac5368" },
			},
		},
		{ -- Admiral Ripsnarl
			name = AL["Admiral Ripsnarl"],
			EncounterJournalID = 92,
			[HEROIC_DIFF] = {
				{ 1, 65169 },	-- Lavishly Jeweled Ring
				{ 2, 65170 },	-- Smite's Reaver
				{ 3, 65168 },	-- Rockslicer
				{ 16, "ac5369" },
			},
		},
		{ -- "Captain" Cookie
			name = AL["\"Captain\" Cookie"],
			EncounterJournalID = 93,
			[HEROIC_DIFF] = {
				{ 1, 65177 },	-- Cape of the Brotherhood
				{ 2, 65174 },	-- Corsair's Overshirt
				{ 3, 65173 },	-- Thief's Blade
				{ 4, 65171 },	-- Cookie's Tenderizer
				{ 5, 65172 },	-- Cookie's Stirring Rod
				{ 16, "ac5370" },
			},
		},
		{ -- Vanessa VanCleef
			name = AL["Vanessa VanCleef"],
			EncounterJournalID = 95,
			[HEROIC_DIFF] = {
				{ 1, 63484 },	-- Armbands of Exiled Architects
				{ 2, 63482 },	-- Daughter's Hands
				{ 3, 63485 },	-- Cowl of Rebellion
				{ 4, 65178 },	-- VanCleef's Boots
				{ 5, 63479 },	-- Bracers of Some Consequence
				{ 6, 63486 },	-- Shackles of the Betrayed
				{ 7, 63478 },	-- Stonemason's Helm
				{ 8, 63483 },	-- Guildmaster's Greaves
				{ 10, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5083" },
				{ 17, "ac5371" },
			},
		},
		CATA_DUNGEON_HERO_AC_TABLE,
		CATA_DEFENDER_AC_TABLE,
		CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["ShadowfangKeep"] = {
	MapID = 209,
	--EncounterJournalID = 209,
	InstanceID = 33,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Baron Ashbury
			name = AL["Baron Ashbury"],
			EncounterJournalID = 96,
			[HEROIC_DIFF] = {
				{ 1, 63433 },	-- Robes of Arugal
				{ 2, 63437 },	-- Baron Ashbury's Cuffs
				{ 3, 63435 },	-- Boots of the Predator
				{ 4, 63436 },	-- Traitor's Grips
				{ 5, 63434 },	-- Gloves of the Greymane Wall
				{ 16, "ac5503" },
			},
		},
		{ -- Baron Silverlaine
			name = AL["Baron Silverlaine"],
			EncounterJournalID = 97,
			[HEROIC_DIFF] = {
				{ 1, 63440 },	-- Boots of Lingering Sorrow
				{ 2, 63439 },	-- Gloves of the Uplifted Cup
				{ 3, 63444 },	-- Baron Silverlaine's Greaves
				{ 4, 63438 },	-- Baroness Silverlaine's Locket
				{ 5, 63441 },	-- Pendant of the Keep
				{ 6, 132567 }, -- Blindwatcher's Chain
			},
		},
		{ -- Commander Springvale
			name = AL["Commander Springvale"],
			EncounterJournalID = 98,
			[HEROIC_DIFF] = {
				{ 1, 63448 },	-- Springvale's Cloak
				{ 2, 63449 },	-- Thieving Spaulders
				{ 3, 63447 },	-- Breastplate of the Stilled Heart
				{ 4, 63446 },	-- Haunting Footfalls
				{ 5, 63445 },	-- Arced War Axe
				{ 16, "ac5504" },
			},
		},
		{ -- Lord Walden
			name = AL["Lord Walden"],
			EncounterJournalID = 99,
			[HEROIC_DIFF] = {
				{ 1, 63465 },	-- Mantle of Loss
				{ 2, 63463 },	-- Mantle of the Eastern Lords
				{ 3, 63459 },	-- Worgen Hunter's Helm
				{ 4, 63462 },	-- Helm of Untold Stories
				{ 5, 63458 },	-- Lord Walden's Breastplate
				{ 6, 63457 },	-- Shackles of Undeath
				{ 7, 63464 },	-- Greaves of the Misguided
				{ 8, 63456 },	-- Meteor Shard
				{ 9, 63461 },	-- Staff of Isolation
				{ 11, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 16, "ac5093" },
				{ 17, "ac5505" },
			},
		},
		{ -- Lord Godfrey
			name = AL["Lord Godfrey"],
			EncounterJournalID = 100,
			[HEROIC_DIFF] = {
				{1, 63456},
				{2, 63457},
				{3, 63458},
				{4, 63459},
				{5, 63460},
				{6, 63461},
				{7, 63462},
				{8, 63463},
				{9, 63464},
				{10, 63465},
			},
		},
		CATA_DUNGEON_HERO_AC_TABLE,
		CATA_DEFENDER_AC_TABLE,
		CATA_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["ZulAman"] = {
	MapID = 3805,
	InstanceID = 568,
	--EncounterJournalID = 77,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Akil'zon
			name = AL["Akil'zon"],
			EncounterJournalID = 1189,
			[HEROIC_DIFF] = {
				{ 1, 69550 },	-- Leggings of Ancient Magics
				{ 2, 69551 },	-- Feathers of Akil'zon
				{ 3, 69549 },	-- Wristguards of the Predator
				{ 4, 69552 },	-- Bracers of Hidden Purpose
				{ 5, 69553 },	-- Talonguard Band
			},
		},
		{ -- Nalorakk
			name = AL["Nalorakk"],
			EncounterJournalID = 1190,
			[HEROIC_DIFF] = {
				{ 1, 69555 },	-- Boots of the Ursine
				{ 2, 69556 },	-- Armbands of the Bear Spirit
				{ 3, 69554 },	-- Pauldrons of Nalorakk
				{ 4, 69558 },	-- Spiritshield Mask
				{ 5, 69557 },	-- Jungle Striders
			},
		},
		{ -- Jan'alai
			name = AL["Jan'alai"],
			EncounterJournalID = 1191,
			[HEROIC_DIFF] = {
				{ 1, 69560 },	-- Jan'alai's Spaulders
				{ 2, 69559 },	-- Amani'shi Bracers
				{ 3, 69561 },	-- Hawkscale Waistguard
				{ 4, 69562 },	-- Boots of Bad Mojo
				{ 5, 69563 },	-- Ring of the Numberless Brood
			},
		},
		{ -- Halazzi
			name = AL["Halazzi"],
			EncounterJournalID = 1192,
			[HEROIC_DIFF] = {
				{ 1, 69567 },	-- Wristwraps of Departed Spirits
				{ 2, 69564 },	-- The Savager's Mask
				{ 3, 69565 },	-- Breastplate of Primal Fury
				{ 4, 69568 },	-- Shadowmender Wristguards
				{ 5, 69566 },	-- Shimmerclaw Band
				{ 16, "ac5750" },
			},
		},
		{ -- Hex Lord Malacrass
			name = AL["Hex Lord Malacrass"],
			EncounterJournalID = 1193,
			[HEROIC_DIFF] = {
				{ 1, 69572 },	-- Hex Lord's Bloody Cloak
				{ 2, 69569 },	-- Shadowtooth Trollskin Breastplate
				{ 3, 69570 },	-- Waistband of Hexes
				{ 4, 69573 },	-- Pauldrons of Sacrifice
				{ 5, 69571 },	-- Soul Drain Signet
				{ 6, 69762 },	-- Miniature Voodoo Mask
				{ 8, 69264, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Hex Lord's Fetish
				{ 16, 70080 },	-- Reforged Heartless
			},
		},
		{ -- Daakara
			name = AL["Daakara"],
			EncounterJournalID = 1194,
			[HEROIC_DIFF] = {
				{ 1, 69577 },	-- Collar of Bones
				{ 2, 69578 },	-- Hexing Robes
				{ 3, 69579 },	-- Amani Headdress
				{ 4, 69574 },	-- Tusked Shoulderpads
				{ 5, 69576 },	-- Headdress of Sharpened Vision
				{ 6, 69580 },	-- Mask of Restless Spirits
				{ 7, 69582 },	-- Skullpiercer Pauldrons
				{ 8, 69583 },	-- Legguards of the Unforgiving
				{ 16, 69581 },	-- Amani Scepter of Rites
				{ 17, 69575 },	-- Mace of the Sacrificed
				{ 19, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 21, "ac5769" },
				{ 22, "ac5760" },
			},
		},
		{	-- Timed Chest
		name = AL["Timed Reward Chest"],
		ExtraList = true,
		[HEROIC_DIFF] = {
			{ 1, 69584 },	-- Recovered Cloak of Frostheim
			{ 2, 69585 },	-- Wristwraps of Madness
			{ 3, 69589 },	-- Leggings of Dancing Blades
			{ 4, 69586 },	-- Two-Toed Boots
			{ 5, 69590 },	-- Mojo-Mender's Gloves
			{ 6, 69593 },	-- Battleplate of the Amani Empire
			{ 7, 69587 },	-- Chestplate of Hubris
			{ 8, 69588 },	-- Skullcrusher Warboots
			{ 16, 69591 },	-- Voodoo Hexblade
			{ 17, 69592 },	-- Reforged Trollbane
			{ 19, "INV_Box_01", "ac5858", AL["Bonus Loot"], nil },
			{ 20, 69747, "mount" },	-- Amani Battle Bear
		},
	},
	{	-- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[HEROIC_DIFF] = {
			{ 1, 69797 },	-- Charmbinder Grips
			{ 2, 69801 },	-- Amani Armguards
			{ 4, 69802 },	-- Band of the Gurubashi Berserker
			{ 5, 69799 },	-- Quickfinger Ring
			{ 16, 33993, "pet165" },	-- Mojo
			{ 18, "ac5761" },
		},
	},
	}
}

local ZUL_GURUB_MADNESS_LOOT = {
	{ 1, "INV_Box_01", nil, AL["Gri'lek"], nil },	-- Gri'lek
	{ 2, 69634 },	-- Fasc's Preserved Boots
	{ 3, 69635 },	-- Amulet of Protection
	{ 5, "INV_Box_01", nil, AL["Hazza'rah"], nil },	-- Hazza'rah
	{ 6, 69636 },	-- Thekal's Claws
	{ 7, 69637 },	-- Gurubashi Destroyer
	{ 9, "INV_Box_01", nil, AL["Renataki"], nil },	-- Renataki
	{ 10, 69638 },	-- Arlokk's Claws
	{ 11, 69639 },	-- Renataki's Soul Slicer
	{ 13, "INV_Box_01", nil, AL["Wushoolay"], nil },	-- Wushoolay
	{ 14, 69640 },	-- Kilt of Forgotten Rites
	{ 15, 69641 },	-- Troll Skull Chestplate
	{ 16, "INV_Box_01", nil, AL["Shared"], nil },	-- Shared
	{ 17, 69630 },	-- Handguards of the Tormented
	{ 18, 69633 },	-- Plunderer's Gauntlets
	{ 19, 69632 },	-- Lost Bag of Whammies
	{ 20, 69631 },	-- Zulian Voodoo Stick
	{ 21, 69647, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Gurubashi Bijou
}
data["ZulGurub"] = {
	MapID = 1977,
	EncounterJournalID = 76,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- High Priest Venoxis
			name = AL["High Priest Venoxis"],
			EncounterJournalID = 1178,
			[HEROIC_DIFF] = {
				{ 1, 69601 },	-- Serpentine Leggings
				{ 2, 69600 },	-- Belt of Slithering Serpents
				{ 3, 69603 },	-- Breastplate of Serenity
				{ 4, 69604 },	-- Coils of Hate
				{ 5, 69602 },	-- Signet of Venoxis
				{ 16, "ac5743" },
			},
		},
		{ -- Bloodlord Mandokir
			name = AL["Bloodlord Mandokir"],
			EncounterJournalID = 1179,
			[HEROIC_DIFF] = {
				{ 1, 69606 },	-- Hakkari Loa Drape
				{ 2, 69608 },	-- Deathcharged Wristguards
				{ 3, 69605 },	-- Amulet of the Watcher
				{ 4, 69609 },	-- Bloodlord's Protector
				{ 5, 69607 },	-- Touch of Discord
				{ 7, 68823, "mount" },	-- Armored Razzashi Raptor
				{ 16, "ac5762" },
			},
		},
		{ -- Cache of Madness - Gri'lek
			name = AL["Gri'lek"],
			EncounterJournalID = 788,
			[HEROIC_DIFF] = ZUL_GURUB_MADNESS_LOOT,
		},
		{ -- Cache of Madness - Hazza'rah
			name = AL["Hazza'rah"],
			EncounterJournalID = 788,
			[HEROIC_DIFF] = ZUL_GURUB_MADNESS_LOOT,
		},
		{ -- Cache of Madness - Renataki
			name = AL["Renataki"],
			EncounterJournalID = 788,
			[HEROIC_DIFF] = ZUL_GURUB_MADNESS_LOOT,
		},
		{ -- Cache of Madness - Wushoolay
			name = AL["Wushoolay"],
			EncounterJournalID = 788,
			[HEROIC_DIFF] = ZUL_GURUB_MADNESS_LOOT,
		},
		{ -- High Priestess Kilnara
			name = AL["High Priestess Kilnara"],
			EncounterJournalID = 1180,
			[HEROIC_DIFF] = {
				{ 1, 69612 },	-- Claw-Fringe Mantle
				{ 2, 69611 },	-- Sash of Anguish
				{ 3, 69613 },	-- Leggings of the Pride
				{ 4, 69614 },	-- Roaring Mask of Bethekk
				{ 5, 69610 },	-- Arlokk's Signet
				{ 7, 68824, "mount" },	-- Swift Zulian Panther
			},
		},
		{ -- Zanzil
			name = AL["Zanzil"],
			EncounterJournalID = 1181,
			[HEROIC_DIFF] = {
				{ 1, 69616 },	-- Spiritbinder Spaulders
				{ 2, 69615 },	-- Zombie Walker Legguards
				{ 3, 69617 },	-- Plumed Medicine Helm
				{ 4, 69619 },	-- Bone Plate Handguards
				{ 5, 69618 },	-- Zulian Slasher
			},
		},
		{ -- Jin'do the Godbreaker
			name = AL["Jin'do the Godbreaker"],
			EncounterJournalID = 1182,
			[HEROIC_DIFF] = {
				{ 1, 69622 },	-- The Hexxer's Mask
				{ 2, 69623 },	-- Vestments of the Soulflayer
				{ 4, 69621 },	-- Twinblade of the Hakkari
				{ 5, 69620 },	-- Twinblade of the Hakkari
				{ 6, 69628 },	-- Jeklik's Smasher
				{ 7, 69626 },	-- Jin'do's Verdict
				{ 8, 69624 },	-- Legacy of Arlokk
				{ 16, 69629 },	-- Shield of the Blood God
				{ 17, 69627 },	-- Zulian Ward
				{ 18, 69625 },	-- Mandokir's Tribute
				{ 20, 69774, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Zul'Gurub Stone
				{ 22, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 24, "ac5768" },
				{ 25, "ac5759" },
			},
		},
		{	-- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
		[HEROIC_DIFF] = {
			{ 1, 69800 },	-- Spiritguard Drape
			{ 2, 69796 },	-- Spiritcaller Cloak
			{ 3, 69798 },	-- Knotted Handwraps
			{ 5, 69803 },	-- Gurubashi Punisher
			{ 16, "ac5744" },
		},
	},
	}
}

data["TheBastionOfTwilight"] = {
	MapID = 5334,
	InstanceID = 671,
	EncounterJournalID = 72,
	ContentType = RAID_CONTENT,
	items = {
		{ -- Halfus Wyrmbreaker
			name = AL["Halfus Wyrmbreaker"],
			EncounterJournalID = 156,
			[NORMAL_DIFF] = {
				{ 1, 59482 },	-- Robes of the Burning Acolyte
				{ 2, 59475 },	-- Bracers of the Bronze Flight
				{ 3, 59469 },	-- Storm Rider's Boots
				{ 4, 59481 },	-- Helm of the Nether Scion
				{ 5, 59472 },	-- Proto-Handler's Gauntlets
				{ 6, 59471 },	-- Pauldrons of the Great Ettin
				{ 7, 59470 },	-- Bracers of Impossible Strength
				{ 8, 59476 },	-- Legguards of the Emerald Brood
				{ 16, 59483 },	-- Wyrmbreaker's Amulet
				{ 17, 59473 },	-- Essence of the Cyclone
				{ 18, 59484 },	-- Book of Binding Will
				{ 20, 59474 },	-- Malevolence
				{ 22, "ac5300" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65135 },	-- Robes of the Burning Acolyte
				{ 2, 65138 },	-- Bracers of the Bronze Flight
				{ 3, 65144 },	-- Storm Rider's Boots
				{ 4, 65136 },	-- Helm of the Nether Scion
				{ 5, 65141 },	-- Proto-Handler's Gauntlets
				{ 6, 65142 },	-- Pauldrons of the Great Ettin
				{ 7, 65143 },	-- Bracers of Impossible Strength
				{ 8, 65137 },	-- Legguards of the Emerald Brood
				{ 10, 65134 },	-- Wyrmbreaker's Amulet
				{ 11, 65140 },	-- Essence of the Cyclone
				{ 12, 65133 },	-- Book of Binding Will
				{ 16, 67423 },	-- Chest of the Forlorn Conqueror
				{ 17, 67424 },	-- Chest of the Forlorn Protector
				{ 18, 67425 },	-- Chest of the Forlorn Vanquisher
				{ 20, 65139 },	-- Malevolence
				{ 22, "ac5118" },
				{ 23, "ac5300" },
			},
		},
		{ -- Theralion and Valiona
			name = AL["Theralion and Valiona"],
			EncounterJournalID = 157,
			[NORMAL_DIFF] = {
				{ 1, 59516 },	-- Drape of the Twins
				{ 2, 63534 },	-- Helm of Eldritch Authority
				{ 3, 63535 },	-- Waistguard of Hatred
				{ 4, 63531 },	-- Daybreaker Helm
				{ 6, 59517 },	-- Necklace of Strife
				{ 7, 59512 },	-- Valiona's Medallion
				{ 8, 59518 },	-- Ring of Rivalry
				{ 9, 59519 },	-- Theralion's Mirror
				{ 10, 59515 },	-- Vial of Stolen Memories
				{ 12, 152969, "pet2081" }, -- Odd Twilight Egg -> Twilight Clutch-Sister
				{ 16, 63533 },	-- Fang of Twilight
				{ 17, 63536 },	-- Blade of the Witching Hour
				{ 18, 63532 },	-- Dragonheart Piercer
				{ 20, "ac4852" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65108 },	-- Drape of the Twins
				{ 2, 65093 },	-- Helm of Eldritch Authority
				{ 3, 65092 },	-- Waistguard of Hatred
				{ 4, 65096 },	-- Daybreaker Helm
				{ 6, 65107 },	-- Necklace of Strife
				{ 7, 65112 },	-- Valiona's Medallion
				{ 8, 65106 },	-- Ring of Rivalry
				{ 9, 65105 },	-- Theralion's Mirror
				{ 10, 65109 },	-- Vial of Stolen Memories
				{ 12, 152969, "pet2081" }, -- Odd Twilight Egg -> Twilight Clutch-Sister
				{ 16, 65094 },	-- Fang of Twilight
				{ 17, 65091 },	-- Blade of the Witching Hour
				{ 18, 65095 },	-- Dragonheart Piercer
				{ 20, "ac5117" },
				{ 21, "ac4852" },
			},
		},
		{ -- Ascendant Council
			name = AL["Ascendant Council"],
			EncounterJournalID = 158,
			[NORMAL_DIFF] = {
				{ 1, 59507 },	-- Glittering Epidermis
				{ 2, 59508 },	-- Treads of Liquid Ice
				{ 3, 59511 },	-- Hydrolance Gloves
				{ 4, 59502 },	-- Dispersing Belt
				{ 5, 59504 },	-- Arion's Crown
				{ 6, 59510 },	-- Feludius' Mantle
				{ 7, 59509 },	-- Glaciated Helm
				{ 8, 59505 },	-- Gravitational Pull
				{ 9, 59503 },	-- Terrastra's Legguards
				{ 11, 152970, "pet2082" }, -- Lesser Circle of Binding -> Bound Stream
				{ 16, 59506 },	-- Crushing Weight
				{ 17, 59514 },	-- Heart of Ignacious
				{ 18, 59513 },	-- Scepter of Ice
				{ 20, "ac5311" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65117 },	-- Glittering Epidermis
				{ 2, 65116 },	-- Treads of Liquid Ice
				{ 3, 65113 },	-- Hydrolance Gloves
				{ 4, 65122 },	-- Dispersing Belt
				{ 5, 65120 },	-- Arion's Crown
				{ 6, 65114 },	-- Feludius' Mantle
				{ 7, 65115 },	-- Glaciated Helm
				{ 8, 65119 },	-- Gravitational Pull
				{ 9, 65121 },	-- Terrastra's Legguards
				{ 11, 152970, "pet2082" }, -- Lesser Circle of Binding -> Bound Stream
				{ 16, 65118 },	-- Crushing Weight
				{ 17, 65110 },	-- Heart of Ignacious
				{ 18, 65111 },	-- Scepter of Ice
				{ 20, "ac5119" },
				{ 21, "ac5311" },
			},
		},
		{ -- Cho'gall
			name = AL["Cho'gall"],
			EncounterJournalID = 167,
			[NORMAL_DIFF] = {
				{ 1, 59498 },	-- Hands of the Twilight Council
				{ 2, 59490 },	-- Membrane of C'Thun
				{ 3, 59495 },	-- Treads of Hideous Transformation
				{ 4, 59485 },	-- Coil of Ten-Thousand Screams
				{ 5, 59499 },	-- Kilt of the Forgotten Battle
				{ 6, 59487 },	-- Helm of Maddening Whispers
				{ 7, 59486 },	-- Battleplate of the Apocalypse
				{ 8, 59497 },	-- Shackles of the End of Days
				{ 10, 59501 },	-- Signet of the Fifth Circle
				{ 11, 59500 },	-- Fall of Mortality
				{ 13, 152972, "pet2083" }, -- Twilight Summoning Portal -> Faceless Minion
				{ 16, 64315 },	-- Mantle of the Forlorn Conqueror
				{ 17, 64316 },	-- Mantle of the Forlorn Protector
				{ 18, 64314 },	-- Mantle of the Forlorn Vanquisher
				{ 20, 59494 },	-- Uhn'agh Fash, the Darkest Betrayal
				{ 21, 59330 },	-- Shalug'doom, the Axe of Unmaking
				{ 22, 63680 },	-- Twilight's Hammer
				{ 24, "ac5312" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65126 },	-- Hands of the Twilight Council
				{ 2, 65129 },	-- Membrane of C'Thun
				{ 3, 65128 },	-- Treads of Hideous Transformation
				{ 4, 65132 },	-- Coil of Ten-Thousand Screams
				{ 5, 65125 },	-- Kilt of the Forgotten Battle
				{ 6, 65130 },	-- Helm of Maddening Whispers
				{ 7, 65131 },	-- Battleplate of the Apocalypse
				{ 8, 65127 },	-- Shackles of the End of Days
				{ 10, 65123 },	-- Signet of the Fifth Circle
				{ 11, 65124 },	-- Fall of Mortality
				{ 13, 152972, "pet2083" }, -- Twilight Summoning Portal -> Faceless Minion
				{ 16, 65088 },	-- Shoulders of the Forlorn Conqueror
				{ 17, 65087 },	-- Shoulders of the Forlorn Protector
				{ 18, 65089 },	-- Shoulders of the Forlorn Vanquisher
				{ 20, 68600 },	-- Uhn'agh Fash, the Darkest Betrayal
				{ 21, 65145 },	-- Shalug'doom, the Axe of Unmaking
				{ 22, 65090 },	-- Twilight's Hammer
				{ 24, "ac5120" },
				{ 25, "ac5312" },
			},
		},
		{ -- Sinestra
			name = AL["Sinestra"],
			EncounterJournalID = 168,
			[HEROIC_DIFF] = {
				{ 1, 60232 },	-- Shroud of Endless Grief
				{ 2, 60237 },	-- Crown of the Twilight Queen
				{ 3, 60238 },	-- Bracers of the Dark Mother
				{ 4, 60231 },	-- Belt of the Fallen Brood
				{ 5, 60236 },	-- Nightmare Rider's Boots
				{ 6, 60230 },	-- Twilight Scale Leggings
				{ 7, 60235 },	-- Boots of Az'galada
				{ 8, 60234 },	-- Bindings of Bleak Betrayal
				{ 9, 60228 },	-- Bracers of the Mat'redor
				{ 10, 60229 },	-- War-Torn Crushers
				{ 16, 60227 },	-- Caelestrasz's Will
				{ 17, 60226 },	-- Dargonax's Signet
				{ 18, 60233 },	-- Shard of Woe
				{ 20, "ac5121" },
			},
		},
		{ -- Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 60211 },	-- Bracers of the Dark Pool
				{ 2, 60202 },	-- Tsanga's Helm
				{ 3, 60201 },	-- Phase-Twister Leggings
				{ 4, 59901 },	-- Heaving Plates of Protection
				{ 6, 59520 },	-- Unheeded Warning
				{ 16, 59521 },	-- Soul Blade
				{ 17, 59525 },	-- Chelley's Staff of Dark Mending
				{ 18, 60210 },	-- Crossfire Carbine
			},
		},
		T11_SET,
		CATA_DEFENDER_AC_TABLE,
		CATA_RAID1_AC_TABLE,
	}
}

data["BlackwingDescent"] = {
	MapID = 5094,
	InstanceID = 669,
	EncounterJournalID = 73,
	ContentType = RAID_CONTENT,
	items = {
		{ -- Omnotron Defense System
			name = AL["Omnotron Defense System"],
			EncounterJournalID = 169,
			[NORMAL_DIFF] = {
				{ 1, 59219 },	-- Power Generator Hood
				{ 2, 59217 },	-- X-Tron Duct Tape
				{ 3, 59218 },	-- Passive Resistor Spaulders
				{ 4, 59120 },	-- Poison Protocol Pauldrons
				{ 5, 63540 },	-- Circuit Design Breastplate
				{ 6, 59119 },	-- Voltage Source Chestguard
				{ 7, 59118 },	-- Electron Inductor Coils
				{ 8, 59117 },	-- Jumbotron Power Belt
				{ 9, 59216 },	-- Life Force Chargers
				{ 11, 152966, "pet2078" }, -- Rough-Hewn Remote -> Tinytron
				{ 16, 59220 },	-- Security Measure Alpha
				{ 17, 59121 },	-- Lightning Conductor Band
				{ 19, 59122 },	-- Organic Lifeform Inverter
				{ 21, "ac5307" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65077 },	-- Power Generator Hood
				{ 2, 65079 },	-- X-Tron Duct Tape
				{ 3, 65078 },	-- Passive Resistor Spaulders
				{ 4, 65083 },	-- Poison Protocol Pauldrons
				{ 5, 65004 },	-- Circuit Design Breastplate
				{ 6, 65084 },	-- Voltage Source Chestguard
				{ 7, 65085 },	-- Electron Inductor Coils
				{ 8, 65086 },	-- Jumbotron Power Belt
				{ 9, 65080 },	-- Life Force Chargers
				{ 11, 152966, "pet2078" }, -- Rough-Hewn Remote -> Tinytron
				{ 16, 65076 },	-- Security Measure Alpha
				{ 17, 65082 },	-- Lightning Conductor Band
				{ 19, 65081 },	-- Organic Lifeform Inverter
				{ 21, "ac5107" },
				{ 22, "ac5307" },
			},
		},
		{ -- Magmaw
			name = AL["Magmaw"],
			EncounterJournalID = 170,
			[NORMAL_DIFF] = {
				{ 1, 59452 },	-- Crown of Burning Waters
				{ 2, 59336 },	-- Flame Pillar Leggings
				{ 3, 59335 },	-- Scorched Wormling Vest
				{ 4, 59329 },	-- Parasitic Bands
				{ 5, 59334 },	-- Lifecycle Waistguard
				{ 6, 59331 },	-- Leggings of Lethal Force
				{ 7, 59340 },	-- Breastplate of Avenging Flame
				{ 8, 59328 },	-- Molten Tantrum Boots
				{ 10, 59332 },	-- Symbiotic Worm
				{ 16, 59333 },	-- Lava Spine
				{ 17, 59492 },	-- Akirus the Worm-Breaker
				{ 18, 59341 },	-- Incineratus
				{ 20, "ac5306" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65020 },	-- Crown of Burning Waters
				{ 2, 65044 },	-- Flame Pillar Leggings
				{ 3, 65045 },	-- Scorched Wormling Vest
				{ 4, 65050 },	-- Parasitic Bands
				{ 5, 65046 },	-- Lifecycle Waistguard
				{ 6, 65049 },	-- Leggings of Lethal Force
				{ 7, 65042 },	-- Breastplate of Avenging Flame
				{ 8, 65051 },	-- Molten Tantrum Boots
				{ 10, 65048 },	-- Symbiotic Worm
				{ 16, 67429 },	-- Gauntlets of the Forlorn Conqueror
				{ 17, 67430 },	-- Gauntlets of the Forlorn Protector
				{ 18, 67431 },	-- Gauntlets of the Forlorn Vanquisher
				{ 20, 65047 },	-- Lava Spine
				{ 21, 65007 },	-- Akirus the Worm-Breaker
				{ 22, 65041 },	-- Incineratus
				{ 24, "ac5094" },
				{ 25, "ac5306" },
			},
		},
		{ -- Atramedes
			name = AL["Atramedes"],
			EncounterJournalID = 171,
			[NORMAL_DIFF] = {
				{ 1, 59325 },	-- Mantle of Roaring Flames
				{ 2, 59322 },	-- Bracers of the Burningeye
				{ 3, 59312 },	-- Helm of the Blind Seer
				{ 4, 59318 },	-- Sark of the Unwatched
				{ 5, 59324 },	-- Gloves of Cacophony
				{ 6, 59315 },	-- Boots of Vertigo
				{ 7, 59316 },	-- Battleplate of Ancient Kings
				{ 8, 59317 },	-- Legguards of the Unseeing
				{ 16, 59319 },	-- Ironstar Amulet
				{ 17, 59326 },	-- Bell of Enraging Resonance
				{ 18, 59320 },	-- Themios the Darkbringer
				{ 19, 59327 },	-- Kingdom's Heart
				{ 21, "ac5308" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65054 },	-- Mantle of Roaring Flames
				{ 2, 65056 },	-- Bracers of the Burningeye
				{ 3, 65066 },	-- Helm of the Blind Seer
				{ 4, 65060 },	-- Sark of the Unwatched
				{ 5, 65055 },	-- Gloves of Cacophony
				{ 6, 65063 },	-- Boots of Vertigo
				{ 7, 65062 },	-- Battleplate of Ancient Kings
				{ 8, 65061 },	-- Legguards of the Unseeing
				{ 16, 65059 },	-- Ironstar Amulet
				{ 17, 65053 },	-- Bell of Enraging Resonance
				{ 18, 65058 },	-- Themios the Darkbringer
				{ 19, 65052 },	-- Kingdom's Heart
				{ 21, "ac5109" },
				{ 22, "ac5308" },
			},
		},
		{ -- Chimaeron
			name = AL["Chimaeron"],
			EncounterJournalID = 172,
			[NORMAL_DIFF] = {
				{ 1, 59313 },	-- Brackish Gloves
				{ 2, 59234 },	-- Einhorn's Galoshes
				{ 3, 59451 },	-- Manacles of the Sleeping Beast
				{ 4, 59223 },	-- Double Attack Handguards
				{ 5, 59310 },	-- Chaos Beast Bracers
				{ 6, 59355 },	-- Chimaeron Armguards
				{ 7, 59311 },	-- Burden of Mortality
				{ 8, 59225 },	-- Plated Fists of Provocation
				{ 9, 59221 },	-- Massacre Treads
				{ 16, 59233 },	-- Bile-O-Tron Nut
				{ 17, 59224 },	-- Heart of Rage
				{ 19, 59314 },	-- Finkle's Mixer Upper
				{ 21, "ac5309" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65065 },	-- Brackish Gloves
				{ 2, 65069 },	-- Einhorn's Galoshes
				{ 3, 65021 },	-- Manacles of the Sleeping Beast
				{ 4, 65073 },	-- Double Attack Handguards
				{ 5, 65068 },	-- Chaos Beast Bracers
				{ 6, 65028 },	-- Chimaeron Armguards
				{ 7, 65067 },	-- Burden of Mortality
				{ 8, 65071 },	-- Plated Fists of Provocation
				{ 9, 65075 },	-- Massacre Treads
				{ 16, 65070 },	-- Bile-O-Tron Nut
				{ 17, 65072 },	-- Heart of Rage
				{ 19, 65064 },	-- Finkle's Mixer Upper
				{ 21, "ac5115" },
				{ 22, "ac5309" },
			},
		},
		{ -- Maloriak
			name = AL["Maloriak"],
			EncounterJournalID = 173,
			[NORMAL_DIFF] = {
				{ 1, 59348 },	-- Cloak of Biting Chill
				{ 2, 59349 },	-- Belt of Arcane Storms
				{ 3, 59351 },	-- Legwraps of the Greatest Son
				{ 4, 59343 },	-- Aberration's Leggings
				{ 5, 59353 },	-- Leggings of Consuming Flames
				{ 6, 59346 },	-- Tunic of Failed Experiments
				{ 7, 59350 },	-- Treads of Flawless Creation
				{ 8, 59344 },	-- Dragon Bone Warhelm
				{ 9, 59352 },	-- Flash Freeze Gauntlets
				{ 10, 59342 },	-- Belt of Absolute Zero
				{ 12, 152967, "pet2079" }, -- Experiment-In-A-Jar -> Discarded Experiment
				{ 16, 59354 },	-- Jar of Ancient Remedies
				{ 18, 59347 },	-- Mace of Acrid Death
				{ 20, "ac5310" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65035 },	-- Cloak of Biting Chill
				{ 2, 65034 },	-- Belt of Arcane Storms
				{ 3, 65032 },	-- Legwraps of the Greatest Son
				{ 4, 65039 },	-- Aberration's Leggings
				{ 5, 65030 },	-- Leggings of Consuming Flames
				{ 6, 65037 },	-- Tunic of Failed Experiments
				{ 7, 65033 },	-- Treads of Flawless Creation
				{ 8, 65038 },	-- Dragon Bone Warhelm
				{ 9, 65031 },	-- Flash Freeze Gauntlets
				{ 10, 65040 },	-- Belt of Absolute Zero
				{ 12, 152967, "pet2079" }, -- Experiment-In-A-Jar -> Discarded Experiment
				{ 16, 67428 },	-- Leggings of the Forlorn Conqueror
				{ 17, 67427 },	-- Leggings of the Forlorn Protector
				{ 18, 67426 },	-- Leggings of the Forlorn Vanquisher
				{ 20, 65029 },	-- Jar of Ancient Remedies
				{ 22, 65036 },	-- Mace of Acrid Death
				{ 24, "ac5108" },
				{ 25, "ac5310" },
			},
		},
		{ -- Nefarian's End
			name = AL["Nefarian's End"],
			EncounterJournalID = 174,
			[NORMAL_DIFF] = {
				{ 1, 59457 },	-- Shadow of Dread
				{ 2, 59337 },	-- Mantle of Nefarius
				{ 3, 59454 },	-- Shadowblaze Robes
				{ 4, 59321 },	-- Belt of the Nightmare
				{ 5, 59222 },	-- Spaulders of the Scarred Lady
				{ 6, 59356 },	-- Pauldrons of the Apocalypse
				{ 7, 59450 },	-- Belt of the Blackhand
				{ 9, 59442 },	-- Rage of Ages
				{ 10, 59441 },	-- Prestor's Talisman of Machination
				{ 12, 152968, "pet2080" }, -- Shadowy Pile of Bones -> Rattlejaw
				{ 16, 63683 },	-- Helm of the Forlorn Conqueror
				{ 17, 63684 },	-- Helm of the Forlorn Protector
				{ 18, 63682 },	-- Helm of the Forlorn Vanquisher
				{ 20, 59443 },	-- Crul'korak, the Lightning's Arc
				{ 21, 63679 },	-- Reclaimed Ashkandi, Greatsword of the Brotherhood
				{ 22, 59459 },	-- Andoros, Fist of the Dragon King
				{ 23, 59444 },	-- Akmin-Kurai, Dominion's Shield
				{ 25, "ac4849" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65018 },	-- Shadow of Dread
				{ 2, 65043 },	-- Mantle of Nefarius
				{ 3, 65019 },	-- Shadowblaze Robes
				{ 4, 65057 },	-- Belt of the Nightmare
				{ 5, 65074 },	-- Spaulders of the Scarred Lady
				{ 6, 65027 },	-- Pauldrons of the Apocalypse
				{ 7, 65022 },	-- Belt of the Blackhand
				{ 9, 65025 },	-- Rage of Ages
				{ 10, 65026 },	-- Prestor's Talisman of Machination
				{ 12, 152968, "pet2080" }, -- Shadowy Pile of Bones -> Rattlejaw
				{ 16, 65001 },	-- Crown of the Forlorn Conqueror
				{ 17, 65000 },	-- Crown of the Forlorn Protector
				{ 18, 65002 },	-- Crown of the Forlorn Vanquisher
				{ 20, 65024 },	-- Crul'korak, the Lightning's Arc
				{ 21, 65003 },	-- Reclaimed Ashkandi, Greatsword of the Brotherhood
				{ 22, 65017 },	-- Andoros, Fist of the Dragon King
				{ 23, 65023 },	-- Akmin-Kurai, Dominion's Shield
				{ 25, "ac5116" },
				{ 26, "ac4849" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 59466 },	-- Ironstar's Impenetrable Cover
				{ 2, 59468 },	-- Shadowforge's Lightbound Smock
				{ 3, 59467 },	-- Hide of Chromaggus
				{ 4, 59465 },	-- Corehammer's Riveted Girdle
				{ 5, 59464 },	-- Treads of Savage Beatings
				{ 7, 59461 },	-- Fury of Angerforge
				{ 16, 59462 },	-- Maimgor's Bite
				{ 17, 59463 },	-- Maldo's Sword Cane
				{ 18, 63537 },	-- Claws of Torment
				{ 19, 63538 },	-- Claws of Agony
				{ 20, 68601 },	-- Scaleslicer
				{ 21, 59460 },	-- Theresa's Booklight
			},
		},
		T11_SET,
		CATA_DEFENDER_AC_TABLE,
		CATA_RAID1_AC_TABLE,
	}
}

data["ThroneOfTheFourWinds"] = {
	nameFormat = NAME_SKYWALL,
	MapID = 5638,
	InstanceID = 754,
	EncounterJournalID = 74,
	ContentType = RAID_CONTENT,
	items = {
		{ -- The Conclave of Wind
			name = AL["The Conclave of Wind"],
			EncounterJournalID = 154,
			[NORMAL_DIFF] = {
				{ 1, 63498 },	-- Soul Breath Belt
				{ 2, 63497 },	-- Gale Rouser Belt
				{ 3, 63493 },	-- Wind Stalker Belt
				{ 4, 63496 },	-- Lightning Well Belt
				{ 5, 63492 },	-- Star Chaser Belt
				{ 6, 63490 },	-- Sky Strider Belt
				{ 7, 63495 },	-- Tempest Keeper Belt
				{ 8, 63491 },	-- Thunder Wall Belt
				{ 10, 152974, "pet2085" }, -- Breezy Essence -> Drafty
				{ 16, 63488 },	-- Mistral Circle
				{ 17, 63489 },	-- Permafrost Signet
				{ 18, 63494 },	-- Planetary Band
				{ 20, "ac5304" },
			},
			[HEROIC_DIFF] = {
				{ 1, 65376 },	-- Soul Breath Belt
				{ 2, 65374 },	-- Gale Rouser Belt
				{ 3, 65371 },	-- Wind Stalker Belt
				{ 4, 65377 },	-- Lightning Well Belt
				{ 5, 65368 },	-- Star Chaser Belt
				{ 6, 65369 },	-- Sky Strider Belt
				{ 7, 65375 },	-- Tempest Keeper Belt
				{ 8, 65370 },	-- Thunder Wall Belt
				{ 10, 152974, "pet2085" }, -- Breezy Essence -> Drafty
				{ 16, 65367 },	-- Mistral Circle
				{ 17, 65372 },	-- Permafrost Signet
				{ 18, 65373 },	-- Planetary Band
				{ 20, "ac5122" },
				{ 21, "ac5304" },
			},
		},
		{ -- Al'Akir
			name = AL["Al'Akir"],
			EncounterJournalID = 155,
			[NORMAL_DIFF] = {
				{ 1, 69834 },	-- Cloudburst Cloak
				{ 2, 69831 },	-- Mistral Drape
				{ 3, 69833 },	-- Permafrost Cape
				{ 4, 69835 },	-- Planetary Drape
				{ 5, 63507 },	-- Soul Breath Leggings
				{ 6, 63506 },	-- Gale Rouser Leggings
				{ 7, 63503 },	-- Wind Stalker Leggings
				{ 8, 63505 },	-- Lightning Well Legguards
				{ 9, 63502 },	-- Star Chaser Legguards
				{ 10, 63500 },	-- Sky Strider Greaves
				{ 11, 63504 },	-- Tempest Keeper Leggings
				{ 12, 63501 },	-- Thunder Wall Greaves
				{ 13, 68127 },	-- Stormwake, the Tempest's Reach
				{ 14, 68128 },	-- Stormwake, the Tempest's Reach
				{ 15, 68129 },	-- Stormwake, the Tempest's Reach
				{ 16, 63683 },	-- Helm of the Forlorn Conqueror
				{ 17, 63684 },	-- Helm of the Forlorn Protector
				{ 18, 63682 },	-- Helm of the Forlorn Vanquisher
				{ 19, 64315 },	-- Mantle of the Forlorn Conqueror
				{ 20, 64316 },	-- Mantle of the Forlorn Protector
				{ 21, 64314 },	-- Mantle of the Forlorn Vanquisher
				{ 23, 69829 },	-- Cloudburst Necklace
				{ 24, 69827 },	-- Mistral Pendant
				{ 25, 69828 },	-- Permafrost Choker
				{ 26, 69830 },	-- Planetary Amulet
				{ 27, 63499 },	-- Cloudburst Ring
				{ 29, 63041, "mount" },	-- Reins of the Drake of the South Wind
				{ 101, 152973, "pet2084" }, -- Zephyr's Call -> Zephyrian Prince
				{ 116, "ac5305" },
			},
			[HEROIC_DIFF] = {
				{ 1, 69879 },	-- Cloudburst Cloak
				{ 2, 69884 },	-- Mistral Drape
				{ 3, 69878 },	-- Permafrost Cape
				{ 4, 69881 },	-- Planetary Drape
				{ 5, 65383 },	-- Soul Breath Leggings
				{ 6, 65384 },	-- Gale Rouser Leggings
				{ 7, 65381 },	-- Wind Stalker Leggings
				{ 8, 65386 },	-- Lightning Well Legguards
				{ 9, 65378 },	-- Star Chaser Legguards
				{ 10, 65379 },	-- Sky Strider Greaves
				{ 11, 65385 },	-- Tempest Keeper Leggings
				{ 12, 65380 },	-- Thunder Wall Greaves
				{ 13, 68132 },	-- Stormwake, the Tempest's Reach
				{ 14, 68131 },	-- Stormwake, the Tempest's Reach
				{ 15, 68130 },	-- Stormwake, the Tempest's Reach
				{ 16, 66998 },	-- Essence of the Forlorn
				{ 17, 65001 },	-- Crown of the Forlorn Conqueror
				{ 18, 65000 },	-- Crown of the Forlorn Protector
				{ 19, 65002 },	-- Crown of the Forlorn Vanquisher
				{ 20, 65088 },	-- Shoulders of the Forlorn Conqueror
				{ 21, 65087 },	-- Shoulders of the Forlorn Protector
				{ 22, 65089 },	-- Shoulders of the Forlorn Vanquisher
				{ 24, 69885 },	-- Cloudburst Necklace
				{ 25, 69880 },	-- Mistral Pendant
				{ 26, 69883 },	-- Permafrost Choker
				{ 27, 69882 },	-- Planetary Amulet
				{ 28, 65382 },	-- Cloudburst Ring
				{ 30, 63041, "mount" },	-- Reins of the Drake of the South Wind
				{ 101, 152973, "pet2084" }, -- Zephyr's Call -> Zephyrian Prince
				{ 116, "ac5123" },
				{ 117, "ac5305" },
			},
		},
		T11_SET,
		CATA_DEFENDER_AC_TABLE,
		CATA_RAID1_AC_TABLE,
	}
}

data["Firelands"] = {
	MapID = 5723,
	InstanceID = 720,
	EncounterJournalID = 78,
	ContentType = RAID_CONTENT,
	items = {
		{ -- Beth'tilac
			name = AL["Beth'tilac"],
			EncounterJournalID = 192,
			[NORMAL_DIFF] = {
				{ 1, 71041 },	-- Robes of Smoldering Devastation
				{ 2, 71040 },	-- Cowl of the Clicking Menace
				{ 3, 71044 },	-- Cindersilk Gloves
				{ 4, 71031 },	-- Cinderweb Leggings
				{ 5, 71030 },	-- Flickering Shoulders
				{ 6, 71042 },	-- Thoracic Flame Kilt
				{ 7, 71043 },	-- Spaulders of Manifold Eyes
				{ 8, 70914 },	-- Carapace of Imbibed Flame
				{ 9, 71029 },	-- Arachnaflame Treads
				{ 11, 71032 },	-- Widow's Kiss
				{ 12, 68981 },	-- Spidersilk Spindle
				{ 14, 152976, "pet2087" }, -- Cinderweb Egg -> Cinderweb Recluse
				{ 16, 70922 },	-- Mandible of Beth'tilac
				{ 17, 71039 },	-- Funeral Pyre
				{ 18, 71038 },	-- Ward of the Red Widow
				{ 20, "ac5821" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71407 },	-- Robes of Smoldering Devastation
				{ 2, 71411 },	-- Cowl of the Clicking Menace
				{ 3, 71410 },	-- Cindersilk Gloves
				{ 4, 71402 },	-- Cinderweb Leggings
				{ 5, 71403 },	-- Flickering Shoulders
				{ 6, 71412 },	-- Thoracic Flame Kilt
				{ 7, 71413 },	-- Spaulders of Manifold Eyes
				{ 8, 71405 },	-- Carapace of Imbibed Flame
				{ 9, 71404 },	-- Arachnaflame Treads
				{ 11, 71401 },	-- Widow's Kiss
				{ 12, 69138 },	-- Spidersilk Spindle
				{ 14, 152976, "pet2087" }, -- Cinderweb Egg -> Cinderweb Recluse
				{ 16, 71406 },	-- Mandible of Beth'tilac
				{ 17, 71409 },	-- Funeral Pyre
				{ 18, 71408 },	-- Ward of the Red Widow
				{ 20, "ac5807" },
				{ 21, "ac5821" },
			},
		},
		{ -- Lord Rhyolith
			name = AL["Lord Rhyolith"],
			EncounterJournalID = 193,
			[NORMAL_DIFF] = {
				{ 1, 70992 },	-- Dreadfire Drape
				{ 2, 71011 },	-- Flickering Cowl
				{ 3, 71003 },	-- Hood of Rampant Disdain
				{ 4, 71010 },	-- Incendic Chestguard
				{ 5, 71005 },	-- Flaming Core Chestguard
				{ 6, 71009 },	-- Lava Line Wristbands
				{ 7, 71004 },	-- Earthcrack Bracers
				{ 8, 70993 },	-- Fireskin Gauntlets
				{ 9, 71007 },	-- Grips of the Raging Giant
				{ 10, 70912 },	-- Cracked Obsidian Stompers
				{ 16, 71012 },	-- Heartstone of Rhyolith
				{ 18, 71006 },	-- Volcanospike
				{ 19, 70991 },	-- Arbalest of Erupting Fury
				{ 21, "ac5810" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71415 },	-- Dreadfire Drape
				{ 2, 71421 },	-- Flickering Cowl
				{ 3, 71416 },	-- Hood of Rampant Disdain
				{ 4, 71424 },	-- Incendic Chestguard
				{ 5, 71417 },	-- Flaming Core Chestguard
				{ 6, 71425 },	-- Lava Line Wristbands
				{ 7, 71418 },	-- Earthcrack Bracers
				{ 8, 71419 },	-- Fireskin Gauntlets
				{ 9, 71426 },	-- Grips of the Raging Giant
				{ 10, 71420 },	-- Cracked Obsidian Stompers
				{ 16, 71423 },	-- Heartstone of Rhyolith
				{ 18, 71422 },	-- Volcanospike
				{ 19, 71414 },	-- Arbalest of Erupting Fury
				{ 21, "ac5808" },
				{ 22, "ac5810" },
			},
		},
		{ -- Alysrazor
			name = AL["Alysrazor"],
			EncounterJournalID = 194,
			[NORMAL_DIFF] = {
				{ 1, 70990 },	-- Wings of Flame
				{ 2, 70989 },	-- Leggings of Billowing Fire
				{ 3, 70735 },	-- Flickering Wristbands
				{ 4, 70987 },	-- Phoenix-Down Treads
				{ 5, 70985 },	-- Craterflame Spaulders
				{ 6, 70986 },	-- Clawshaper Gauntlets
				{ 7, 70736 },	-- Moltenfeather Leggings
				{ 8, 70734 },	-- Greathelm of the Voracious Maw
				{ 9, 70737 },	-- Spaulders of Recurring Flame
				{ 10, 70988 },	-- Clutch of the Firemother
				{ 11, 70739 },	-- Lavaworm Legplates
				{ 13, 71665, "mount", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Flametalon of Alysrazor
				{ 16, 70738 },	-- Alysrazor's Band
				{ 17, 68983 },	-- Eye of Blazing Power
				{ 19, 70733 },	-- Alysra's Razor
				{ 21, "ac5813" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71434 },	-- Wings of Flame
				{ 2, 71435 },	-- Leggings of Billowing Fire
				{ 3, 71428 },	-- Flickering Wristbands
				{ 4, 71436 },	-- Phoenix-Down Treads
				{ 5, 71438 },	-- Craterflame Spaulders
				{ 6, 71437 },	-- Clawshaper Gauntlets
				{ 7, 71429 },	-- Moltenfeather Leggings
				{ 8, 71430 },	-- Greathelm of the Voracious Maw
				{ 9, 71432 },	-- Spaulders of Recurring Flame
				{ 10, 71439 },	-- Clutch of the Firemother
				{ 11, 71431 },	-- Lavaworm Legplates
				{ 13, 71665, "mount", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Flametalon of Alysrazor
				{ 16, 71679 },	-- Chest of the Fiery Conqueror
				{ 17, 71686 },	-- Chest of the Fiery Protector
				{ 18, 71672 },	-- Chest of the Fiery Vanquisher
				{ 20, 71433 },	-- Alysrazor's Band
				{ 21, 69149 },	-- Eye of Blazing Power
				{ 23, 71427 },	-- Alysra's Razor
				{ 25, "ac5809" },
				{ 26, "ac5813" },
			},
		},
		{ -- Shannox
			name = AL["Shannox"],
			EncounterJournalID = 195,
			[NORMAL_DIFF] = {
				{ 1, 71023 },	-- Coalwalker Sandals
				{ 2, 71025 },	-- Flickering Shoulderpads
				{ 3, 71020 },	-- Gloves of Dissolving Smoke
				{ 4, 71018 },	-- Scalp of the Bandit Prince
				{ 5, 71027 },	-- Treads of Implicit Obedience
				{ 6, 71026 },	-- Bracers of the Dread Hunter
				{ 7, 71021 },	-- Uncrushable Belt of Fury
				{ 8, 71028 },	-- Legplates of Absolute Control
				{ 9, 70913 },	-- Legplates of Frenzied Devotion
				{ 11, 71019 },	-- Necklace of Fetishes
				{ 12, 71024 },	-- Crystal Prison Band
				{ 13, 71022 },	-- Goblet of Anger
				{ 15, 152975, "pet2086" }, -- Smoldering Treat -> Blazehound
				{ 16, 71014 },	-- Skullstealer Greataxe
				{ 17, 71013 },	-- Feeding Frenzy
				{ 19, "ac5829" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71447 },	-- Coalwalker Sandals
				{ 2, 71450 },	-- Flickering Shoulderpads
				{ 3, 71440 },	-- Gloves of Dissolving Smoke
				{ 4, 71442 },	-- Scalp of the Bandit Prince
				{ 5, 71451 },	-- Treads of Implicit Obedience
				{ 6, 71452 },	-- Bracers of the Dread Hunter
				{ 7, 71443 },	-- Uncrushable Belt of Fury
				{ 8, 71453 },	-- Legplates of Absolute Control
				{ 9, 71444 },	-- Legplates of Frenzied Devotion
				{ 11, 71446 },	-- Necklace of Fetishes
				{ 12, 71449 },	-- Crystal Prison Band
				{ 13, 71448 },	-- Goblet of Anger
				{ 15, 152975, "pet2086" }, -- Smoldering Treat -> Blazehound
				{ 16, 71678 },	-- Leggings of the Fiery Conqueror
				{ 17, 71685 },	-- Leggings of the Fiery Protector
				{ 18, 71671 },	-- Leggings of the Fiery Vanquisher
				{ 20, 71445 },	-- Skullstealer Greataxe
				{ 21, 71441 },	-- Feeding Frenzy
				{ 23, "ac5806" },
				{ 24, "ac5829" },
			},
		},
		{ -- Baleroc, the Gatekeeper
			name = AL["Baleroc, the Gatekeeper"],
			EncounterJournalID = 196,
			[NORMAL_DIFF] = {
				{ 1, 71343 },	-- Mantle of Closed Doors
				{ 2, 71345 },	-- Shoulderpads of the Forgotten Gate
				{ 3, 71314 },	-- Breastplate of the Incendiary Soul
				{ 4, 71341 },	-- Glowing Wing Bracers
				{ 5, 71340 },	-- Gatekeeper's Embrace
				{ 6, 71315 },	-- Decimation Treads
				{ 7, 71342 },	-- Casque of Flame
				{ 8, 70916 },	-- Helm of Blazing Glory
				{ 9, 70917 },	-- Flickering Handguards
				{ 11, 68982 },	-- Necromantic Focus
				{ 12, 71323 },	-- Molten Scream
				{ 14, 152977, "pet2088" }, -- Vibrating Stone -> Surger
				{ 16, 71312 },	-- Gatecrasher
				{ 17, 70915 },	-- Shard of Torment
				{ 19, "ac5830" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71461 },	-- Mantle of Closed Doors
				{ 2, 71456 },	-- Shoulderpads of the Forgotten Gate
				{ 3, 71455 },	-- Breastplate of the Incendiary Soul
				{ 4, 71463 },	-- Glowing Wing Bracers
				{ 5, 71464 },	-- Gatekeeper's Embrace
				{ 6, 71457 },	-- Decimation Treads
				{ 7, 71465 },	-- Casque of Flame
				{ 8, 71459 },	-- Helm of Blazing Glory
				{ 9, 71458 },	-- Flickering Handguards
				{ 11, 69139 },	-- Necromantic Focus
				{ 12, 71462 },	-- Molten Scream
				{ 14, 152977, "pet2088" }, -- Vibrating Stone -> Surger
				{ 16, 71676 },	-- Gauntlets of the Fiery Conqueror
				{ 17, 71683 },	-- Gauntlets of the Fiery Protector
				{ 18, 71669 },	-- Gauntlets of the Fiery Vanquisher
				{ 20, 71454 },	-- Gatecrasher
				{ 21, 71460 },	-- Shard of Torment
				{ 23, "ac5805" },
				{ 24, "ac5830" },
			},
		},
		{ -- Majordomo Staghelm
			name = AL["Majordomo Staghelm"],
			EncounterJournalID = 197,
			[NORMAL_DIFF] = {
				{ 1, 71350 },	-- Wristwraps of Arrogant Doom
				{ 2, 71349 },	-- Firecat Leggings
				{ 3, 71313 },	-- Sandals of Leaping Coals
				{ 4, 71346 },	-- Grips of Unerring Precision
				{ 5, 71344 },	-- Breastplate of Shifting Visions
				{ 6, 70920 },	-- Bracers of the Fiery Path
				{ 7, 71351 },	-- Treads of the Penitent Man
				{ 9, 71348 },	-- Flowform Choker
				{ 10, 68927 },	-- The Hungerer
				{ 11, 68926 },	-- Jaws of Defeat
				{ 13, 152978, "pet2089" }, -- Fandral's Pet Carrier -> Infernal Pyreclaw
				{ 16, 71681 },	-- Mantle of the Fiery Conqueror
				{ 17, 71688 },	-- Mantle of the Fiery Protector
				{ 18, 71674 },	-- Mantle of the Fiery Vanquisher
				{ 20, 69897 },	-- Fandral's Flamescythe
				{ 21, 71347 },	-- Stinger of the Flaming Scorpion
				{ 23, "ac5799" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71471 },	-- Wristwraps of Arrogant Doom
				{ 2, 71474 },	-- Firecat Leggings
				{ 3, 71467 },	-- Sandals of Leaping Coals
				{ 4, 71468 },	-- Grips of Unerring Precision
				{ 5, 71469 },	-- Breastplate of Shifting Visions
				{ 6, 71470 },	-- Bracers of the Fiery Path
				{ 7, 71475 },	-- Treads of the Penitent Man
				{ 9, 71472 },	-- Flowform Choker
				{ 10, 69112 },	-- The Hungerer
				{ 11, 69111 },	-- Jaws of Defeat
				{ 13, 152978, "pet2089" }, -- Fandral's Pet Carrier -> Infernal Pyreclaw
				{ 16, 71680 },	-- Shoulders of the Fiery Conqueror
				{ 17, 71687 },	-- Shoulders of the Fiery Protector
				{ 18, 71673 },	-- Shoulders of the Fiery Vanquisher
				{ 20, 71466 },	-- Fandral's Flamescythe
				{ 21, 71473 },	-- Stinger of the Flaming Scorpion
				{ 23, "ac5804" },
				{ 24, "ac5799" },
			},
		},
		{ -- Ragnaros
			name = AL["Ragnaros"],
			EncounterJournalID = 198,
			[NORMAL_DIFF] = {
				{ 1, 71358 },	-- Fingers of Incineration
				{ 2, 71357 },	-- Majordomo's Chain of Office
				{ 3, 71356 },	-- Crown of Flame
				{ 4, 70921 },	-- Pauldrons of Roaring Flame
				{ 6, 71354 },	-- Choker of the Vanquished Lord
				{ 7, 68994 },	-- Matrix Restabilizer
				{ 8, 68925 },	-- Variable Pulse Lightning Capacitor
				{ 9, 68995 },	-- Vessel of Acceleration
				{ 11, 69224, "mount" },	-- Smoldering Egg of Millagazor
				{ 16, 71675 },	-- Helm of the Fiery Conqueror
				{ 17, 71682 },	-- Helm of the Fiery Protector
				{ 18, 71668 },	-- Helm of the Fiery Vanquisher
				{ 20, 71355 },	-- Ko'gun, Hammer of the Firelord
				{ 21, 71352 },	-- Sulfuras, the Extinguished Hand
				{ 22, 71798 },	-- Sho'ravon, Greatstaff of Annihilation
				{ 23, 71353 },	-- Arathar, the Eye of Flame
				{ 25, "ac5855" },
			},
			[HEROIC_DIFF] = {
				{ 1, 71614 },	-- Fingers of Incineration
				{ 2, 71613 },	-- Majordomo's Chain of Office
				{ 3, 71616 },	-- Crown of Flame
				{ 4, 71612 },	-- Pauldrons of Roaring Flame
				{ 6, 71610 },	-- Choker of the Vanquished Lord
				{ 7, 69150 },	-- Matrix Restabilizer
				{ 8, 69110 },	-- Variable Pulse Lightning Capacitor
				{ 9, 69167 },	-- Vessel of Acceleration
				{ 11, 69224, "mount" },	-- Smoldering Egg of Millagazor
				{ 16, 71677 },	-- Crown of the Fiery Conqueror
				{ 17, 71684 },	-- Crown of the Fiery Protector
				{ 18, 71670 },	-- Crown of the Fiery Vanquisher
				{ 20, 71615 },	-- Ko'gun, Hammer of the Firelord
				{ 21, 70723 },	-- Sulfuras, the Extinguished Hand
				{ 22, 71797 },	-- Sho'ravon, Greatstaff of Annihilation
				{ 23, 71611 },	-- Arathar, the Eye of Flame
				{ 25, "ac5803" },
				{ 26, "ac5855" },
			},
		},
		{ -- Shared Loot
			name = AL["Shared Boss Loot"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 71779 },	-- Avool's Incendiary Shanker
				{ 2, 71787 },	-- Entrail Disgorger
				{ 3, 71785 },	-- Firethorn Mindslicer
				{ 4, 71780 },	-- Zoid's Firelit Greatsword
				{ 5, 71776 },	-- Eye of Purification
				{ 6, 71782 },	-- Shatterskull Bonecrusher
				{ 7, 71775 },	-- Smoldering Censer of Purity
			},
			[HEROIC_DIFF] = {
				{ 1, 71778 },	-- Avool's Incendiary Shanker
				{ 2, 71786 },	-- Entrail Disgorger
				{ 3, 71784 },	-- Firethorn Mindslicer
				{ 4, 71781 },	-- Zoid's Firelit Greatsword
				{ 5, 71777 },	-- Eye of Purification
				{ 6, 71783 },	-- Shatterskull Bonecrusher
				{ 7, 71774 },	-- Smoldering Censer of Purity
			},
		},
		{	--Firelands Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 71640 },	-- Riplimb's Lost Collar
				{ 2, 71365 },	-- Hide-Bound Chains
				{ 4, 70929 },	-- Firebound Gorget
				{ 5, 71367 },	-- Theck's Emberseal
				{ 6, 68972 },	-- Apparatus of Khaz'goroth
				{ 7, 68915 },	-- Scales of Life
				{ 16, 71359 },	-- Chelley's Sterilized Scalpel
				{ 17, 71362 },	-- Obsidium Cleaver
				{ 18, 71361 },	-- Ranseur of Hatred
				{ 19, 71360 },	-- Spire of Scarlet Pain
				{ 20, 71366 },	-- Lava Bolt Crossbow
			},
		},
		{ -- Patterns
			name = AL["Patterns"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 69976 },	-- Pattern: Boots of the Black Flame
				{ 2, 69966 },	-- Pattern: Don Tayo's Inferno Mittens
				{ 3, 69975 },	-- Pattern: Endless Dream Walkers
				{ 4, 69965 },	-- Pattern: Grips of Altered Reality
				{ 6, 69962 },	-- Pattern: Clutches of Evil
				{ 7, 69960 },	-- Pattern: Dragonfire Gloves
				{ 8, 69971 },	-- Pattern: Earthen Scale Sabatons
				{ 9, 69974 },	-- Pattern: Ethereal Footfalls
				{ 10, 69972 },	-- Pattern: Footwraps of Quenched Fire
				{ 11, 69961 },	-- Pattern: Gloves of Unforgiving Flame
				{ 12, 69963 },	-- Pattern: Heavenly Gloves of the Moon
				{ 13, 69973 },	-- Pattern: Treads of the Craft
				{ 16, 69970 },	-- Plans: Emberforged Elementium Boots
				{ 17, 69969 },	-- Plans: Mirrored Boots
				{ 18, 69968 },	-- Plans: Warboots of Mighty Lords
				{ 19, 69958 },	-- Plans: Eternal Elementium Handguards
				{ 20, 69957 },	-- Plans: Fists of Fury
				{ 21, 69959 },	-- Plans: Holy Flame Gauntlets
			},
		},
		{ -- Firestones
			name = AL["Firestone Vendor"],
			ExtraList = true,
			[HEROIC_DIFF] = {
				{ 1, 71641 },	-- Riplimb's Lost Collar
				{ 2, 71561 },	-- Hide-Bound Chains
				{ 4, 71563 },	-- Firebound Gorget
				{ 5, 71564 },	-- Theck's Emberseal
				{ 6, 69113 },	-- Apparatus of Khaz'goroth
				{ 7, 69109 },	-- Scales of Life
				{ 9, 71560 },	-- Chelley's Sterilized Scalpel
				{ 10, 71562 },	-- Obsidium Cleaver
				{ 11, 71557 },	-- Ranseur of Hatred
				{ 12, 71559 },	-- Spire of Scarlet Pain
				{ 13, 71558 },	-- Lava Bolt Crossbow
				{ 16, 71579 },	-- Scorchvine Wand
				{ 17, 71575 },	-- Trail of Embers
				{ 19, 71617 },	-- Crystallized Firestone
			},
		},
		T12_SET,
		CATA_RAID2_AC_TABLE,
	}
}

local END_TIME_ECHO_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(340), nil },	--Echo of Baine
	{ 2, 72815 },	-- Bloodhoof Legguards
	{ 3, 72814 },	-- Axe of the Tauren Chieftains
	{ 4, "INV_Box_01", nil, EJ_GetEncounterInfo(285), nil },	--Echo of Jaina
	{ 5, 72808 },	-- Jaina's Staff
	{ 6, 72809 },	-- Ward of Incantations
	{ 7, "INV_Box_01", nil, EJ_GetEncounterInfo(323), nil },	--Echo of Sylvanas
	{ 8, 72811 },	-- Cloak of the Banshee Queen
	{ 9, 72810 },	-- Windrunner's Bow
	{ 10, "ac6130" },
	{ 11, "INV_Box_01", nil, EJ_GetEncounterInfo(283), nil },	--Echo of Tyrande
	{ 12, 72813 },	-- Whisperwind Robes
	{ 13, 72812 },	-- Crescent Moon
	{ 14, "ac5995" },
	{ 16, "INV_Box_01", nil, AL["Shared"], nil },	--Shared
	{ 17, 72802 },	-- Time Traveler's Leggings
	{ 18, 72805 },	-- Gloves of the Hollow
	{ 19, 72798 },	-- Cord of Lost Hope
	{ 20, 72806 },	-- Echoing Headguard
	{ 21, 72799 },	-- Dead End Boots
	{ 22, 72801 },	-- Breastplate of Sorrow
	{ 23, 72800 },	-- Gauntlets of Temporal Interference
	{ 24, 72803 },	-- Girdle of Lost Heroes
	{ 25, 72807 },	-- Waistguard of Lost Time
	{ 26, 72804 },	-- Dragonshrine Scepter
}
data["EndTime"] = {
	nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 5789,
	InstanceID = 938,
	EncounterJournalID = 184,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Echo of Baine
			name = AL["Echo of Baine"],
			EncounterJournalID = 340,
			[HEROIC_DIFF] = END_TIME_ECHO_LOOT,
		},
		{ -- Echo of Jaina
			name = AL["Echo of Jaina"],
			EncounterJournalID = 285,
			[HEROIC_DIFF] = END_TIME_ECHO_LOOT,
		},
		{ -- Echo of Tyrande
			name = AL["Echo of Tyrande"],
			EncounterJournalID = 283,
			[HEROIC_DIFF] = END_TIME_ECHO_LOOT,
		},
		{ -- Echo of Sylvanas
			name = AL["Echo of Sylvanas"],
			EncounterJournalID = 323,
			[HEROIC_DIFF] = END_TIME_ECHO_LOOT,
		},
		{ -- Murozond
			name = AL["Murozond"],
			EncounterJournalID = 289,
			[HEROIC_DIFF] = {
				{ 1, 72825 },	-- Mantle of Time
				{ 2, 72826 },	-- Robes of Fate
				{ 3, 72823 },	-- Timeway Headgear
				{ 4, 72824 },	-- Time Twisted Tunic
				{ 5, 72816 },	-- Distortion Greaves
				{ 6, 72820 },	-- Crown of Epochs
				{ 7, 72821 },	-- Temporal Pauldrons
				{ 8, 72818 },	-- Breastplate of Tarnished Bronze
				{ 9, 72817 },	-- Time Altered Legguards
				{ 10, 72819 },	-- Chrono Boots
				{ 16, 72897 },	-- Arrow of Time
				{ 18, 72822 },	-- Jagged Edge of Time
				{ 20, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 22, "ac6117" },
			},
		},
		{ -- Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[HEROIC_DIFF] = {
				{ 1, 76154 },	-- Breastplate of Despair
				{ 2, 76156 },	-- Bindings of the End Times
			},
		},
	}
}

data["WellOfEternity"] = {
	nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 5788,
	InstanceID = 939,
	EncounterJournalID = 185,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Peroth'arn
			name = AL["Peroth'arn"],
			EncounterJournalID = 290,
			[HEROIC_DIFF] = {
				{ 1, 72830 },	-- Peroth'arn's Belt
				{ 2, 72832 },	-- Girdle of the Queen's Champion
				{ 4, 72831 },	-- Horned Band
				{ 5, 72829 },	-- Orb of the First Satyrs
				{ 16, 72828 },	-- Trickster's Edge
				{ 17, 72827 },	-- Gavel of Peroth'arn
				{ 19, "ac6127" },
			},
		},
		{ -- Queen Azshara
			name = AL["Queen Azshara"],
			EncounterJournalID = 291,
			[HEROIC_DIFF] = {
				{ 1, 72838 },	-- Cloak of the Royal Protector
				{ 2, 72836 },	-- Slippers of Wizardry
				{ 3, 72835 },	-- Puppeteer's Pantaloons
				{ 4, 72834 },	-- Breastplate of the Queen's Guard
				{ 16, 72837 },	-- Queen's Boon
				{ 18, 72833 },	-- Scepter of Azshara
			},
		},
		{ -- Mannoroth and Varo'then
			name = AL["Mannoroth and Varo'then"],
			EncounterJournalID = 292,
			[HEROIC_DIFF] = {
				{ 1, 72839 },	-- Cowl of Highborne Sorcerors
				{ 2, 72847 },	-- Helm of Thorns
				{ 3, 72840 },	-- Spaulders of Eternity
				{ 4, 72841 },	-- Demonsbane Chestguard
				{ 5, 72848 },	-- Legguards of the Legion
				{ 6, 72842 },	-- Annihilan Helm
				{ 7, 72843 },	-- Helm of Power
				{ 16, 72845 },	-- Mannoroth's Signet
				{ 17, 72899 },	-- Varo'then's Brooch
				{ 18, 72898 },	-- Foul Gift of the Demon Lord
				{ 20, 72844 },	-- Pit Lord's Destroyer
				{ 21, 72846 },	-- Thornwood Staff
				{ 23, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 25, "ac6118" },
				{ 26, "ac6070" },
			},
		},
		{ -- Trash
		name = AL["Trash Mobs"],
		ExtraList = true,
			[HEROIC_DIFF] = {
				{ 1, 76158 },	-- Courtier's Slippers
				{ 2, 76157 },	-- Waterworn Handguards
				{ 3, 76159 },	-- Legion Bindings
			},
		},
	}
}

data["HourOfTwilight"] = {
	nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 5844,
	InstanceID = 940,
	EncounterJournalID = 186,
	ContentType = DUNGEON_CONTENT,
	LevelRange = {85, 85, 85},
	items = {
		{ -- Arcurion
			name = AL["Arcurion"],
			EncounterJournalID = 322,
			[HEROIC_DIFF] = {
				{ 1, 72854 },	-- Iceward Cloak
				{ 2, 72851 },	-- Chillbane Belt
				{ 3, 76150 },	-- Evergreen Wristbands
				{ 4, 72849 },	-- Wayfinder Boots
				{ 5, 72850 },	-- Surestride Boots
				{ 6, 72853 },	-- Arcurion Legguards
				{ 8, 77957, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Urgent Twilight Missive
			},
		},
		{ -- Asira Dawnslayer
			name = AL["Asira Dawnslayer"],
			EncounterJournalID = 342,
			[HEROIC_DIFF] = {
				{ 1, 76151 },	-- Cloak of Subtle Light
				{ 2, 72857 },	-- Leggings of Blinding Speed
				{ 3, 72859 },	-- Dawnslayer Helm
				{ 4, 72856 },	-- Pauldrons of Midnight Whispers
				{ 6, 77957, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Urgent Twilight Missive
				{ 16, 72855 },	-- Corrupted Carapace
				{ 17, 72860 },	-- Mandible of the Old Ones
			},
		},
		{ -- Archbishop Benedictus
			name = AL["Archbishop Benedictus"],
			EncounterJournalID = 341,
			[HEROIC_DIFF] = {
				{ 1, 72865 },	-- Mantle of False Virtue
				{ 2, 72868 },	-- Desecrated Shoulderguards
				{ 3, 72870 },	-- Betrayer's Pauldrons
				{ 4, 72864 },	-- Pauldrons of Conviction
				{ 5, 72861 },	-- Pauldrons of the Dragonblight
				{ 7, 72901 },	-- Rosary of Light
				{ 8, 72900 },	-- Veil of Darkness
				{ 16, 72867 },	-- Clattering Claw
				{ 17, 72862 },	-- Fanged Tentacle
				{ 18, 72866 },	-- Treachery's Bite
				{ 19, 72863 },	-- Stalk of Corruption
				{ 20, 72869 },	-- Dragonsmaw Blaster
				{ 22, 52078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chaos Orb
				{ 24, "ac6119" },
				{ 25, "ac6132" },
			},
		},
		{ -- Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[HEROIC_DIFF] = {
				{ 1, 76160 },	-- Drapes of the Dragonshrine
				{ 2, 76161 },	-- Gauntlets of the Twilight Hour
				{ 16, 76162 },	-- Twilight Amulet
			},
		},
	}
}

data["DragonSoul"] = {
	MapID = 5892,
	InstanceID = 967,
	EncounterJournalID = 187,
	ContentType = RAID_CONTENT,
	items = {
		{ -- Morchok
			name = AL["Morchok"],
			EncounterJournalID = 311,
			--[[
			[RF_DIFF] = {
				{ 1, 78381 },	-- Mosswrought Shoulderguards
				{ 2, 78380 },	-- Robe of Glowing Stone
				{ 3, 78375 },	-- Underdweller's Spaulders
				{ 4, 78384 },	-- Mycosynth Wristguards
				{ 5, 78376 },	-- Sporebeard Gauntlets
				{ 6, 78385 },	-- Girdle of Shattered Stone
				{ 7, 78378 },	-- Brackenshell Shoulderplates
				{ 8, 78377 },	-- Rockhide Bracers
				{ 9, 78386 },	-- Pillarfoot Greaves
				{ 16, 78382 },	-- Petrified Fungal Heart
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77267 },	-- Mosswrought Shoulderguards
				{ 2, 77263 },	-- Robe of Glowing Stone
				{ 3, 77271 },	-- Underdweller's Spaulders
				{ 4, 77261 },	-- Mycosynth Wristguards
				{ 5, 77269 },	-- Sporebeard Gauntlets
				{ 6, 77266 },	-- Girdle of Shattered Stone
				{ 7, 77268 },	-- Brackenshell Shoulderplates
				{ 8, 77270 },	-- Rockhide Bracers
				{ 9, 77265 },	-- Pillarfoot Greaves
				{ 16, 77262 },	-- Petrified Fungal Heart
				{ 18, 77214 },	-- Vagaries of Time
				{ 19, 77212 },	-- Hand of Morchok
				{ 21, "ac6174" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78366 },	-- Mosswrought Shoulderguards
				{ 2, 78365 },	-- Robe of Glowing Stone
				{ 3, 78368 },	-- Underdweller's Spaulders
				{ 4, 78372 },	-- Mycosynth Wristguards
				{ 5, 78362 },	-- Sporebeard Gauntlets
				{ 6, 78370 },	-- Girdle of Shattered Stone
				{ 7, 78367 },	-- Brackenshell Shoulderplates
				{ 8, 78373 },	-- Rockhide Bracers
				{ 9, 78361 },	-- Pillarfoot Greaves
				{ 16, 78364 },	-- Petrified Fungal Heart
				{ 18, 78363 },	-- Vagaries of Time
				{ 19, 78371 },	-- Hand of Morchok
				{ 21, "ac6109" },
				{ 22, "ac6174" },
			},
		},
		{ -- Warlord Zon'ozz
		name = AL["Warlord Zon'ozz"],
		EncounterJournalID = 324,
		--[[
		[RF_DIFF] = {
			{ 1, 78398 },	-- Cord of the Slain Champion
			{ 2, 78395 },	-- Belt of Flayed Skin
			{ 3, 78400 },	-- Grotesquely Writhing Bracers
			{ 4, 78397 },	-- Graveheart Bracers
			{ 5, 78396 },	-- Treads of Crushed Flesh
			{ 7, 77969 },	-- Seal of the Seven Signs
			{ 16, 78866 },	-- Gauntlets of the Corrupted Conqueror
			{ 17, 78867 },	-- Gauntlets of the Corrupted Protector
			{ 18, 78865 },	-- Gauntlets of the Corrupted Vanquisher
			{ 20, 78399 },	-- Finger of Zon'ozz
		},
		--]]
		[NORMAL_DIFF] = {
			{ 1, 77255 },	-- Cord of the Slain Champion
			{ 2, 77260 },	-- Belt of Flayed Skin
			{ 3, 77257 },	-- Grotesquely Writhing Bracers
			{ 4, 77258 },	-- Graveheart Bracers
			{ 5, 77259 },	-- Treads of Crushed Flesh
			{ 7, 77204 },	-- Seal of the Seven Signs
			{ 16, 78183 },	-- Gauntlets of the Corrupted Conqueror
			{ 17, 78178 },	-- Gauntlets of the Corrupted Protector
			{ 18, 78173 },	-- Gauntlets of the Corrupted Vanquisher
			{ 20, 77215 },	-- Horrifying Horn Arbalest
			{ 21, 77216 },	-- Finger of Zon'ozz
			{ 23, "ac6128" },
		},
		[HEROIC_DIFF] = {
			{ 1, 78391 },	-- Cord of the Slain Champion
			{ 2, 78388 },	-- Belt of Flayed Skin
			{ 3, 78393 },	-- Grotesquely Writhing Bracers
			{ 4, 78390 },	-- Graveheart Bracers
			{ 5, 78389 },	-- Treads of Crushed Flesh
			{ 7, 77989 },	-- Seal of the Seven Signs
			{ 16, 78853 },	-- Gauntlets of the Corrupted Conqueror
			{ 17, 78854 },	-- Gauntlets of the Corrupted Protector
			{ 18, 78855 },	-- Gauntlets of the Corrupted Vanquisher
			{ 20, 78387 },	-- Horrifying Horn Arbalest
			{ 21, 78392 },	-- Finger of Zon'ozz
			{ 23, "ac6110" },
			{ 24, "ac6128" },
		},
		},
		{ -- Yor'sahj the Unsleeping
			name = AL["Yor'sahj the Unsleeping"],
			EncounterJournalID = 325,
			--[[
			[RF_DIFF] = {
				{ 1, 78408 },	-- Interrogator's Bloody Footpads
				{ 2, 78411 },	-- Mindstrainer Treads
				{ 3, 78412 },	-- Heartblood Wristplates
				{ 5, 77971 },	-- Insignia of the Corrupted Mind
				{ 6, 77970 },	-- Soulshifter Vortex
				{ 8, 152979, "pet2090" }, -- Puddle of Black Liquid -> Faceless Mindlasher
				{ 16, 78872 },	-- Leggings of the Corrupted Conqueror
				{ 17, 78873 },	-- Leggings of the Corrupted Protector
				{ 18, 78871 },	-- Leggings of the Corrupted Vanquisher
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77254 },	-- Interrogator's Bloody Footpads
				{ 2, 77252 },	-- Mindstrainer Treads
				{ 3, 77253 },	-- Heartblood Wristplates
				{ 5, 77217 },	-- Experimental Specimen Slicer
				{ 6, 77218 },	-- Spire of Coagulated Globules
				{ 7, 77219 },	-- Scalpel of Unrelenting Agony
				{ 9, 152979, "pet2090" }, -- Puddle of Black Liquid -> Faceless Mindlasher
				{ 16, 78181 },	-- Leggings of the Corrupted Conqueror
				{ 17, 78176 },	-- Leggings of the Corrupted Protector
				{ 18, 78171 },	-- Leggings of the Corrupted Vanquisher
				{ 20, 77203 },	-- Insignia of the Corrupted Mind
				{ 21, 77206 },	-- Soulshifter Vortex
				{ 23, "ac6129" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78402 },	-- Interrogator's Bloody Footpads
				{ 2, 78405 },	-- Mindstrainer Treads
				{ 3, 78406 },	-- Heartblood Wristplates
				{ 5, 78403 },	-- Experimental Specimen Slicer
				{ 6, 78401 },	-- Spire of Coagulated Globules
				{ 7, 78404 },	-- Scalpel of Unrelenting Agony
				{ 9, 152979, "pet2090" }, -- Puddle of Black Liquid -> Faceless Mindlasher
				{ 16, 78856 },	-- Leggings of the Corrupted Conqueror
				{ 17, 78857 },	-- Leggings of the Corrupted Protector
				{ 18, 78858 },	-- Leggings of the Corrupted Vanquisher
				{ 20, 77991 },	-- Insignia of the Corrupted Mind
				{ 21, 77990 },	-- Soulshifter Vortex
				{ 23, "ac6111" },
				{ 24, "ac6129" },
			},
		},
		{ -- Hagara the Stormbinder
			name = AL["Hagara the Stormbinder"],
			EncounterJournalID = 317,
			--[[
			[RF_DIFF] = {
				{ 1, 78425 },	-- Bracers of the Banished
				{ 2, 78428 },	-- Girdle of the Grotesque
				{ 3, 78423 },	-- Treads of Dormant Dreams
				{ 4, 78424 },	-- Runescriven Demon Collar
				{ 6, 78427 },	-- Ring of the Riven
				{ 7, 78421 },	-- Signet of Grasping Mouths
				{ 16, 78875 },	-- Shoulders of the Corrupted Conqueror
				{ 17, 78876 },	-- Shoulders of the Corrupted Protector
				{ 18, 78874 },	-- Shoulders of the Corrupted Vanquisher
				{ 20, 78422 },	-- Electrowing Dagger
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77249 },	-- Bracers of the Banished
				{ 2, 77248 },	-- Girdle of the Grotesque
				{ 3, 77251 },	-- Treads of Dormant Dreams
				{ 4, 77250 },	-- Runescriven Demon Collar
				{ 6, 78012 },	-- Ring of the Riven
				{ 7, 78011 },	-- Signet of Grasping Mouths
				{ 16, 78180 },	-- Shoulders of the Corrupted Conqueror
				{ 17, 78175 },	-- Shoulders of the Corrupted Protector
				{ 18, 78170 },	-- Shoulders of the Corrupted Vanquisher
				{ 20, 77221 },	-- Lightning Rod
				{ 21, 77220 },	-- Electrowing Dagger
				{ 23, "ac6175" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78417 },	-- Bracers of the Banished
				{ 2, 78420 },	-- Girdle of the Grotesque
				{ 3, 78415 },	-- Treads of Dormant Dreams
				{ 4, 78416 },	-- Runescriven Demon Collar
				{ 6, 78419 },	-- Ring of the Riven
				{ 7, 78413 },	-- Signet of Grasping Mouths
				{ 16, 78859 },	-- Shoulders of the Corrupted Conqueror
				{ 17, 78860 },	-- Shoulders of the Corrupted Protector
				{ 18, 78861 },	-- Shoulders of the Corrupted Vanquisher
				{ 20, 78418 },	-- Lightning Rod
				{ 21, 78414 },	-- Electrowing Dagger
				{ 23, "ac6112" },
				{ 24, "ac6175" },
			},
		},
		{ -- Ultraxion
			name = AL["Ultraxion"],
			EncounterJournalID = 331,
			--[[
			[RF_DIFF] = {
				{ 1, 78442 },	-- Treads of Sordid Screams
				{ 2, 78443 },	-- Imperfect Specimens 27 and 28
				{ 3, 78438 },	-- Bracers of Looming Darkness
				{ 4, 78444 },	-- Dragonfracture Belt
				{ 5, 78439 },	-- Stillheart Warboots
				{ 7, 78440 },	-- Curled Twilight Claw
				{ 8, 77972 },	-- Creche of the Final Dragon
				{ 9, 78441 },	-- Ledger of Revolting Rituals
				{ 16, 78863 },	-- Chest of the Corrupted Conqueror
				{ 17, 78864 },	-- Chest of the Corrupted Protector
				{ 18, 78862 },	-- Chest of the Corrupted Vanquisher
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77243 },	-- Treads of Sordid Screams
				{ 2, 77242 },	-- Imperfect Specimens 27 and 28
				{ 3, 77247 },	-- Bracers of Looming Darkness
				{ 4, 77244 },	-- Dragonfracture Belt
				{ 5, 77246 },	-- Stillheart Warboots
				{ 7, 78013 },	-- Curled Twilight Claw
				{ 8, 77205 },	-- Creche of the Final Dragon
				{ 9, 77245 },	-- Ledger of Revolting Rituals
				{ 16, 78184 },	-- Chest of the Corrupted Conqueror
				{ 17, 78179 },	-- Chest of the Corrupted Protector
				{ 18, 78174 },	-- Chest of the Corrupted Vanquisher
				{ 20, 77223 },	-- Morningstar of Heroic Will
				{ 22, 78919, "mount", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Experiment 12-B
				{ 24, "ac6084" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78434 },	-- Treads of Sordid Screams
				{ 2, 78435 },	-- Imperfect Specimens 27 and 28
				{ 3, 78430 },	-- Bracers of Looming Darkness
				{ 4, 78436 },	-- Dragonfracture Belt
				{ 5, 78431 },	-- Stillheart Warboots
				{ 7, 78432 },	-- Curled Twilight Claw
				{ 8, 77992 },	-- Creche of the Final Dragon
				{ 9, 78433 },	-- Ledger of Revolting Rituals
				{ 16, 78847 },	-- Chest of the Corrupted Conqueror
				{ 17, 78848 },	-- Chest of the Corrupted Protector
				{ 18, 78849 },	-- Chest of the Corrupted Vanquisher
				{ 20, 78429 },	-- Morningstar of Heroic Will
				{ 22, 78919, "mount", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Experiment 12-B
				{ 24, "ac6113" },
				{ 25, "ac6084" },
			},
		},
		{ -- Warmaster Blackhorn
			name = AL["Warmaster Blackhorn"],
			EncounterJournalID = 332,
			--[[
			[RF_DIFF] = {
				{ 1, 78457 },	-- Janglespur Jackboots
				{ 2, 78454 },	-- Shadow Wing Armbands
				{ 3, 78455 },	-- Belt of the Beloved Companion
				{ 4, 78460 },	-- Goriona's Collar
				{ 6, 77973 },	-- Starcatcher Compass
				{ 16, 78869 },	-- Crown of the Corrupted Conqueror
				{ 17, 78870 },	-- Crown of the Corrupted Protector
				{ 18, 78868 },	-- Crown of the Corrupted Vanquisher
				{ 20, 78456 },	-- Blackhorn's Mighty Bulwark
				{ 21, 78458 },	-- Timepiece of the Bronze Flight
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77234 },	-- Janglespur Jackboots
				{ 2, 77240 },	-- Shadow Wing Armbands
				{ 3, 77241 },	-- Belt of the Beloved Companion
				{ 4, 77239 },	-- Goriona's Collar
				{ 6, 77224 },	-- Ataraxis, Cudgel of the Warmaster
				{ 7, 77225 },	-- Visage of the Destroyer
				{ 8, 77226 },	-- Blackhorn's Mighty Bulwark
				{ 9, 77227 },	-- Timepiece of the Bronze Flight
				{ 16, 78182 },	-- Crown of the Corrupted Conqueror
				{ 17, 78177 },	-- Crown of the Corrupted Protector
				{ 18, 78172 },	-- Crown of the Corrupted Vanquisher
				{ 20, 77202 },	-- Starcatcher Compass
				{ 22, "ac6105" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78449 },	-- Janglespur Jackboots
				{ 2, 78446 },	-- Shadow Wing Armbands
				{ 3, 78447 },	-- Belt of the Beloved Companion
				{ 4, 78452 },	-- Goriona's Collar
				{ 6, 78445 },	-- Ataraxis, Cudgel of the Warmaster
				{ 7, 78451 },	-- Visage of the Destroyer
				{ 8, 78448 },	-- Blackhorn's Mighty Bulwark
				{ 9, 78450 },	-- Timepiece of the Bronze Flight
				{ 16, 78850 },	-- Crown of the Corrupted Conqueror
				{ 17, 78851 },	-- Crown of the Corrupted Protector
				{ 18, 78852 },	-- Crown of the Corrupted Vanquisher
				{ 20, 77993 },	-- Starcatcher Compass
				{ 22, "ac6114" },
				{ 23, "ac6105" },
			},
		},
		{ -- Spine of Deathwing
			name = AL["Spine of Deathwing"],
			EncounterJournalID = 318,
			--[[
			[RF_DIFF] = {
				{ 1, 78466 },	-- Gloves of Liquid Smoke
				{ 2, 78467 },	-- Molten Blood Footpads
				{ 3, 78468 },	-- Belt of Shattered Elementium
				{ 4, 78470 },	-- Backbreaker Spaulders
				{ 5, 78469 },	-- Gauntlets of the Golden Thorn
				{ 7, 152980, "pet2091" }, -- Elementium Back Plate -> Corrupted Blood
				{ 16, 77977 },	-- Eye of Unmaking
				{ 17, 77976 },	-- Heart of Unliving
				{ 18, 77975 },	-- Will of Unbinding
				{ 19, 77974 },	-- Wrath of Unchaining
				{ 20, 77978 },	-- Resolve of Undying
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 78357 },	-- Gloves of Liquid Smoke
				{ 2, 77238 },	-- Molten Blood Footpads
				{ 3, 77237 },	-- Belt of Shattered Elementium
				{ 4, 77236 },	-- Backbreaker Spaulders
				{ 5, 77235 },	-- Gauntlets of the Golden Thorn
				{ 7, 152980, "pet2091" }, -- Elementium Back Plate -> Corrupted Blood
				{ 16, 77200 },	-- Eye of Unmaking
				{ 17, 77199 },	-- Heart of Unliving
				{ 18, 77198 },	-- Will of Unbinding
				{ 19, 77197 },	-- Wrath of Unchaining
				{ 20, 77201 },	-- Resolve of Undying
				{ 22, "ac6133" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78461 },	-- Gloves of Liquid Smoke
				{ 2, 78462 },	-- Molten Blood Footpads
				{ 3, 78463 },	-- Belt of Shattered Elementium
				{ 4, 78465 },	-- Backbreaker Spaulders
				{ 5, 78464 },	-- Gauntlets of the Golden Thorn
				{ 7, 152980, "pet2091" }, -- Elementium Back Plate -> Corrupted Blood
				{ 16, 77997 },	-- Eye of Unmaking
				{ 17, 77996 },	-- Heart of Unliving
				{ 18, 77995 },	-- Will of Unbinding
				{ 19, 77994 },	-- Wrath of Unchaining
				{ 20, 77998 },	-- Resolve of Undying
				{ 22, "ac6113" },
				{ 23, "ac6133" },
			},
		},
		{ -- Madness of Deathwing
			name = AL["Madness of Deathwing"],
			EncounterJournalID = 333,
			--[[
			[RF_DIFF] = {
				{ 1, 78484 },	-- Rathrak, the Poisonous Mind
				{ 2, 78483 },	-- Blade of the Unmaker
				{ 3, 78488 },	-- Souldrinker
				{ 4, 78487 },	-- Gurthalak, Voice of the Deeps
				{ 5, 78481 },	-- No'Kaled, the Elements of Death
				{ 6, 78485 },	-- Maw of the Dragonlord
				{ 8, 152981, "pet2092" }, -- Severed Tentacle -> Unstable Tendril
				{ 16, 78482 },	-- Kiril, Fury of Beasts
				{ 17, 78486 },	-- Ti'tahk, the Steps of Time
				{ 18, 78480 },	-- Vishanka, Jaws of the Earth
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77195 },	-- Rathrak, the Poisonous Mind
				{ 2, 77189 },	-- Blade of the Unmaker
				{ 3, 77193 },	-- Souldrinker
				{ 4, 77191 },	-- Gurthalak, Voice of the Deeps
				{ 5, 77188 },	-- No'Kaled, the Elements of Death
				{ 6, 77196 },	-- Maw of the Dragonlord
				{ 8, 152981, "pet2092" }, -- Severed Tentacle -> Unstable Tendril
				{ 16, 77194 },	-- Kiril, Fury of Beasts
				{ 17, 77190 },	-- Ti'tahk, the Steps of Time
				{ 18, 78359 },	-- Vishanka, Jaws of the Earth
				{ 20, 77067, "mount" },	-- Reins of the Blazing Drake
				{ 22, "ac6177" },
				{ 23, "ac6180" },
			},
			[HEROIC_DIFF] = {
				{ 1, 78475 },	-- Rathrak, the Poisonous Mind
				{ 2, 78474 },	-- Blade of the Unmaker
				{ 3, 78479 },	-- Souldrinker
				{ 4, 78478 },	-- Gurthalak, Voice of the Deeps
				{ 5, 78472 },	-- No'Kaled, the Elements of Death
				{ 6, 78476 },	-- Maw of the Dragonlord
				{ 8, 152981, "pet2092" }, -- Severed Tentacle -> Unstable Tendril
				{ 16, 78473 },	-- Kiril, Fury of Beasts
				{ 17, 78477 },	-- Ti'tahk, the Steps of Time
				{ 18, 78471 },	-- Vishanka, Jaws of the Earth
				{ 20, 77069, "mount" },	-- Life-Binder's Handmaiden
				{ 22, "ac6177" },
				{ 23, "ac6116" },
				{ 24, "ac6180" },
			},
		},
		{ -- Shared
			name = AL["Shared Boss Loot"],
			ExtraList = true,
			--[[
			[RF_DIFF] = {
				{ 1, 78497 },	-- Breathstealer Band
				{ 2, 78498 },	-- Hardheart Ring
				{ 3, 78495 },	-- Infinite Loop
				{ 4, 78494 },	-- Seal of Primordial Shadow
				{ 5, 78496 },	-- Signet of Suturing
				{ 6, 52078 },	-- Chaos Orb
				{ 16, 77982 },	-- Bone-Link Fetish
				{ 17, 77980 },	-- Cunning of the Cruel
				{ 18, 77983 },	-- Indomitable Pride
				{ 19, 77979 },	-- Vial of Shadows
				{ 20, 77981 },	-- Windward Heart
			},
			--]]
			[NORMAL_DIFF] = {
				{ 1, 77230 },	-- Breathstealer Band
				{ 2, 77232 },	-- Hardheart Ring
				{ 3, 77228 },	-- Infinite Loop
				{ 4, 77231 },	-- Seal of Primordial Shadow
				{ 5, 77229 },	-- Signet of Suturing
				{ 6, 71998 },	-- Essence of Destruction
				{ 16, 77210 },	-- Bone-Link Fetish
				{ 17, 77208 },	-- Cunning of the Cruel
				{ 18, 77211 },	-- Indomitable Pride
				{ 19, 77207 },	-- Vial of Shadows
				{ 20, 77209 },	-- Windward Heart
			},
			[HEROIC_DIFF] = {
				{ 1, 78492 },	-- Breathstealer Band
				{ 2, 78493 },	-- Hardheart Ring
				{ 3, 78490 },	-- Infinite Loop
				{ 4, 78489 },	-- Seal of Primordial Shadow
				{ 5, 78491 },	-- Signet of Suturing
				{ 6, 71998 },	-- Essence of Destruction
				{ 16, 78002 },	-- Bone-Link Fetish
				{ 17, 78000 },	-- Cunning of the Cruel
				{ 18, 78003 },	-- Indomitable Pride
				{ 19, 77999 },	-- Vial of Shadows
				{ 20, 78001 },	-- Windward Heart
			},
		},
		{ -- Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 78879 },	-- Sash of Relentless Truth
				{ 2, 78884 },	-- Girdle of Fungal Dreams
				{ 3, 78882 },	-- Nightblind Cinch
				{ 4, 78886 },	-- Belt of Ghostly Graces
				{ 5, 78885 },	-- Dragoncarver Belt
				{ 6, 78887 },	-- Girdle of Soulful Mending
				{ 7, 78888 },	-- Waistguard of Bleeding Bone
				{ 8, 78889 },	-- Waistplate of the Desecrated Future
				{ 16, 78878 },	-- Spine of the Thousand Cuts
				{ 17, 77192 },	-- Ruinblaster Shotgun
				{ 19, 77938 },	-- Dragonfire Orb
			},
		},
		{ -- Patterns
			name = AL["Patterns"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 72004 },	-- Pattern: Bracers of Unconquered Power
				{ 2, 72003 },	-- Pattern: Dreamwraps of the Light
				{ 3, 72002 },	-- Pattern: Lavaquake Legwraps
				{ 4, 72000 },	-- Pattern: World Mender's Pants
				{ 6, 72006 },	-- Pattern: Bladeshadow Leggings
				{ 7, 72010 },	-- Pattern: Bladeshadow Wristguards
				{ 8, 72008 },	-- Pattern: Bracers of Flowing Serenity
				{ 9, 72011 },	-- Pattern: Bracers of the Hunter-Killer
				{ 10, 72005 },	-- Pattern: Deathscale Leggings
				{ 11, 71999 },	-- Pattern: Leggings of Nature's Champion
				{ 12, 72007 },	-- Pattern: Rended Earth Leggings
				{ 13, 72009 },	-- Pattern: Thundering Deathscale Wristguards
				{ 16, 72015 },	-- Plans: Bracers of Destructive Strength
				{ 17, 72013 },	-- Plans: Foundations of Courage
				{ 18, 72001 },	-- Plans: Pyrium Legplates of Purified Evil
				{ 19, 72014 },	-- Plans: Soul Redeemer Bracers
				{ 20, 72016 },	-- Plans: Titanguard Wristplates
				{ 21, 72012 },	-- Plans: Unstoppable Destroyer's Legplates
			},
		},
		T13_SET,
		CATA_RAID3_AC_TABLE,
	}
}

data["BaradinHold"] = {
	MapID = 5600,
	InstanceID = 757,
	EncounterJournalID = 75,
	ContentType = RAID_CONTENT,
	items = {
		{ -- Argaloth
			name = AL["Argaloth"],
			EncounterJournalID = 139,
			[NORMAL_DIFF] = {
				{ 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 2, 60285 },	-- Stormrider's Gloves
				{ 3, 60283 },	-- Stormrider's Leggings
				{ 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 6, 60290 },	-- Stormrider's Grips
				{ 7, 60288 },	-- Stormrider's Legguards
				{ 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 10, 60280 },	-- Stormrider's Handwraps
				{ 11, 60278 },	-- Stormrider's Legwraps
				{ 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 17, 60453 },	-- Vicious Gladiator's Wyrmhide Gloves
				{ 18, 60455 },	-- Vicious Gladiator's Wyrmhide Legguards
				{ 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 21, 60443 },	-- Vicious Gladiator's Dragonhide Gloves
				{ 22, 60445 },	-- Vicious Gladiator's Dragonhide Legguards
				{ 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 25, 60448 },	-- Vicious Gladiator's Kodohide Gloves
				{ 26, 60450 },	-- Vicious Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 102, 60307 },	-- Lightning-Charged Gloves
				{ 103, 60305 },	-- Lightning-Charged Legguards
				{ 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 106, 60247 },	-- Firelord's Gloves
				{ 107, 60245 },	-- Firelord's Leggings
				{ 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 110, 60298 },	-- Wind Dancer's Gloves
				{ 111, 60300 },	-- Wind Dancer's Legguards
				{ 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 114, 60248 },	-- Shadowflame Handwraps
				{ 115, 60250 },	-- Shadowflame Leggings
				{ 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 117, 60424 },	-- Vicious Gladiator's Chain Gauntlets
				{ 118, 60426 },	-- Vicious Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 121, 60463 },	-- Vicious Gladiator's Silk Handguards
				{ 122, 60465 },	-- Vicious Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 125, 60459 },	-- Vicious Gladiator's Leather Gloves
				{ 126, 60461 },	-- Vicious Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 129, 60478 },	-- Vicious Gladiator's Felweave Handguards
				{ 130, 60480 },	-- Vicious Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 202, 60363 },	-- Reinforced Sapphirium Gloves
				{ 203, 60361 },	-- Reinforced Sapphirium Greaves
				{ 205, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 206, 60345 },	-- Reinforced Sapphirium Gauntlets
				{ 207, 60347 },	-- Reinforced Sapphirium Legplates
				{ 209, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
				{ 210, 60355 },	-- Reinforced Sapphirium Handguards
				{ 211, 60357 },	-- Reinforced Sapphirium Legguards
				{ 216, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 217, 60602 },	-- Vicious Gladiator's Ornamented Gloves
				{ 218, 60604 },	-- Vicious Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 221, 60414 },	-- Vicious Gladiator's Scaled Gauntlets
				{ 222, 60416 },	-- Vicious Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, 60275 },	-- Mercurial Handwraps
				{ 303, 60261 },	-- Mercurial Legwraps
				{ 305, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 306, 60257 },	-- Mercurial Gloves
				{ 307, 60255 },	-- Mercurial Leggings
				{ 316, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 60468 },	-- Vicious Gladiator's Mooncloth Gloves
				{ 318, 60470 },	-- Vicious Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 321, 60476 },	-- Vicious Gladiator's Satin Gloves
				{ 322, 60475 },	-- Vicious Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 402, 60314 },	-- Gloves of the Raging Elements
				{ 403, 60316 },	-- Kilt of the Raging Elements
				{ 405, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 406, 60319 },	-- Grips of the Raging Elements
				{ 407, 60321 },	-- Legguards of the Raging Elements
				{ 409, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 410, 60312 },	-- Handwraps of the Raging Elements
				{ 411, 60310 },	-- Legwraps of the Raging Elements
				{ 416, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 417, 60439 },	-- Vicious Gladiator's Mail Gauntlets
				{ 418, 60441 },	-- Vicious Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 421, 60434 },	-- Vicious Gladiator's Linked Gauntlets
				{ 422, 60436 },	-- Vicious Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 425, 60429 },	-- Vicious Gladiator's Ringmail Gauntlets
				{ 426, 60431 },	-- Vicious Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, 60340 },	-- Magma Plated Gauntlets
				{ 503, 60342 },	-- Magma Plated Legplates
				{ 505, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, 60350 },	-- Magma Plated Handguards
				{ 507, 60352 },	-- Magma Plated Legguards
				{ 509, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, 60326 },	-- Earthen Gauntlets
				{ 511, 60324 },	-- Earthen Legplates
				{ 513, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
				{ 514, 60332 },	-- Earthen Handguards
				{ 515, 60330 },	-- Earthen Legguards
				{ 516, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
				{ 517, 60409 },	-- Vicious Gladiator's Dreadplate Gauntlets
				{ 518, 60411 },	-- Vicious Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
				{ 525, 60419 },	-- Vicious Gladiator's Plate Gauntlets
				{ 526, 60421 },	-- Vicious Gladiator's Plate Legguards
				{ 601, 60628 },	-- Vicious Gladiator's Cuffs of Accuracy
				{ 602, 60626 },	-- Vicious Gladiator's Cord of Accuracy
				{ 603, 60630 },	-- Vicious Gladiator's Treads of Alacrity
				{ 605, 60635 },	-- Vicious Gladiator's Cuffs of Meditation
				{ 606, 60637 },	-- Vicious Gladiator's Cord of Meditation
				{ 607, 60636 },	-- Vicious Gladiator's Treads of Meditation
				{ 609, 60634 },	-- Vicious Gladiator's Cuffs of Prowess
				{ 610, 60612 },	-- Vicious Gladiator's Cord of Cruelty
				{ 611, 60613 },	-- Vicious Gladiator's Treads of Cruelty
				{ 616, 60591 },	-- Vicious Gladiator's Armwraps of Accuracy
				{ 617, 60589 },	-- Vicious Gladiator's Waistband of Accuracy
				{ 618, 60587 },	-- Vicious Gladiator's Boots of Cruelty
				{ 620, 60594 },	-- Vicious Gladiator's Armwraps of Alacrity
				{ 621, 60586 },	-- Vicious Gladiator's Waistband of Cruelty
				{ 622, 60593 },	-- Vicious Gladiator's Boots of Alacrity
				{ 624, 60611 },	-- Vicious Gladiator's Bindings of Prowess
				{ 625, 60583 },	-- Vicious Gladiator's Belt of Cruelty
				{ 626, 60607 },	-- Vicious Gladiator's Footguards of Alacrity
				{ 628, 60582 },	-- Vicious Gladiator's Bindings of Meditation
				{ 629, 60580 },	-- Vicious Gladiator's Belt of Meditation
				{ 630, 60581 },	-- Vicious Gladiator's Footguards of Meditation
				{ 701, 60535 },	-- Vicious Gladiator's Armbands of Meditation
				{ 702, 60533 },	-- Vicious Gladiator's Waistguard of Meditation
				{ 703, 60534 },	-- Vicious Gladiator's Footguards of Meditation
				{ 705, 60569 },	-- Vicious Gladiator's Armbands of Prowess
				{ 706, 60536 },	-- Vicious Gladiator's Waistguard of Cruelty
				{ 707, 60567 },	-- Vicious Gladiator's Sabatons of Alacrity
				{ 709, 60559 },	-- Vicious Gladiator's Wristguards of Alacrity
				{ 710, 60555 },	-- Vicious Gladiator's Links of Cruelty
				{ 711, 60557 },	-- Vicious Gladiator's Sabatons of Alacrity
				{ 713, 60565 },	-- Vicious Gladiator's Wristguards of Accuracy
				{ 714, 60564 },	-- Vicious Gladiator's Links of Accuracy
				{ 715, 60554 },	-- Vicious Gladiator's Sabatons of Cruelty
				{ 716, 60541 },	-- Vicious Gladiator's Bracers of Meditation
				{ 717, 60539 },	-- Vicious Gladiator's Clasp of Meditation
				{ 718, 60540 },	-- Vicious Gladiator's Greaves of Meditation
				{ 720, 60523 },	-- Vicious Gladiator's Armplates of Proficiency
				{ 721, 60521 },	-- Vicious Gladiator's Girdle of Prowess
				{ 722, 60513 },	-- Vicious Gladiator's Warboots of Alacrity
				{ 724, 60520 },	-- Vicious Gladiator's Bracers of Prowess
				{ 725, 60505 },	-- Vicious Gladiator's Clasp of Cruelty
				{ 726, 60516 },	-- Vicious Gladiator's Greaves of Alacrity
				{ 728, 60512 },	-- Vicious Gladiator's Armplates of Alacrity
				{ 729, 60508 },	-- Vicious Gladiator's Girdle of Cruelty
				{ 730, 60509 },	-- Vicious Gladiator's Warboots of Cruelty
				{ 801, 60783 },	-- Vicious Gladiator's Cape of Cruelty
				{ 802, 60779 },	-- Vicious Gladiator's Cape of Prowess
				{ 803, 60776 },	-- Vicious Gladiator's Cloak of Alacrity
				{ 804, 60778 },	-- Vicious Gladiator's Cloak of Prowess
				{ 805, 60786 },	-- Vicious Gladiator's Drape of Diffusion
				{ 806, 60788 },	-- Vicious Gladiator's Drape of Meditation
				{ 807, 60787 },	-- Vicious Gladiator's Drape of Prowess
				{ 809, 60673 },	-- Vicious Gladiator's Choker of Accuracy
				{ 810, 60670 },	-- Vicious Gladiator's Choker of Proficiency
				{ 811, 60669 },	-- Vicious Gladiator's Necklace of Proficiency
				{ 812, 60668 },	-- Vicious Gladiator's Necklace of Prowess
				{ 813, 60662 },	-- Vicious Gladiator's Pendant of Alacrity
				{ 814, 60661 },	-- Vicious Gladiator's Pendant of Diffusion
				{ 815, 60664 },	-- Vicious Gladiator's Pendant of Meditation
				{ 816, 60647 },	-- Vicious Gladiator's Band of Accuracy
				{ 817, 60645 },	-- Vicious Gladiator's Band of Cruelty
				{ 818, 60649 },	-- Vicious Gladiator's Band of Meditation
				{ 819, 60658 },	-- Vicious Gladiator's Ring of Accuracy
				{ 820, 60659 },	-- Vicious Gladiator's Ring of Cruelty
				{ 821, 60651 },	-- Vicious Gladiator's Signet of Accuracy
				{ 822, 60650 },	-- Vicious Gladiator's Signet of Cruelty
				{ 901, 61033 },	-- Vicious Gladiator's Badge of Conquest
				{ 902, 61035 },	-- Vicious Gladiator's Badge of Dominance
				{ 903, 61034 },	-- Vicious Gladiator's Badge of Victory
				{ 905, 61026 },	-- Vicious Gladiator's Emblem of Cruelty
				{ 906, 61031 },	-- Vicious Gladiator's Emblem of Meditation
				{ 907, 61032 },	-- Vicious Gladiator's Emblem of Tenacity
				{ 916, [ATLASLOOT_IT_ALLIANCE] = 60794, [ATLASLOOT_IT_HORDE] = 60801 },	-- Vicious Gladiator's Medallion of Cruelty
				{ 917, [ATLASLOOT_IT_ALLIANCE] = 60799, [ATLASLOOT_IT_HORDE] = 60806 },	-- Vicious Gladiator's Medallion of Meditation
				{ 918, [ATLASLOOT_IT_ALLIANCE] = 60800, [ATLASLOOT_IT_HORDE] = 60807 },	-- Vicious Gladiator's Medallion of Tenacity
				{ 920, 61047 },	-- Vicious Gladiator's Insignia of Conquest
				{ 921, 61045 },	-- Vicious Gladiator's Insignia of Dominance
				{ 922, 61046 },	-- Vicious Gladiator's Insignia of Victory
				{ 924, "ac5416" },
			},
		},
		{ -- Occu'thar
			name = AL["Occu'thar"],
			EncounterJournalID = 140,
			[NORMAL_DIFF] = {
				{ 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 2, 71107 },	-- Obsidian Arborweave Gloves
				{ 3, 71109 },	-- Obsidian Arborweave Leggings
				{ 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 6, 71097 },	-- Obsidian Arborweave Grips
				{ 7, 71099 },	-- Obsidian Arborweave Legguards
				{ 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 10, 71102 },	-- Obsidian Arborweave Handwraps
				{ 11, 71104 },	-- Obsidian Arborweave Legwraps
				{ 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 17, 70289 },	-- Ruthless Gladiator's Wyrmhide Gloves
				{ 18, 70291 },	-- Ruthless Gladiator's Wyrmhide Legguards
				{ 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 21, 70279 },	-- Ruthless Gladiator's Dragonhide Gloves
				{ 22, 70281 },	-- Ruthless Gladiator's Dragonhide Legguards
				{ 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 25, 70284 },	-- Ruthless Gladiator's Kodohide Gloves
				{ 26, 70286 },	-- Ruthless Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 102, 71050 },	-- Flamewaker's Gloves
				{ 103, 71052 },	-- Flamewaker's Legguards
				{ 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 106, 71286 },	-- Firehawk Gloves
				{ 107, 71288 },	-- Firehawk Leggings
				{ 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 110, 71046 },	-- Dark Phoenix Gloves
				{ 111, 71048 },	-- Dark Phoenix Legguards
				{ 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 114, 71281 },	-- Balespider's Handwraps
				{ 115, 71283 },	-- Balespider's Leggings
				{ 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 117, 70260 },	-- Ruthless Gladiator's Chain Gauntlets
				{ 118, 70262 },	-- Ruthless Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 121, 70299 },	-- Ruthless Gladiator's Silk Handguards
				{ 122, 70301 },	-- Ruthless Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 125, 70301 },	-- Ruthless Gladiator's Leather Gloves
				{ 126, 70297 },	-- Ruthless Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 129, 70314 },	-- Ruthless Gladiator's Felweave Handguards
				{ 130, 70316 },	-- Ruthless Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 202, 71092 },	-- Immolation Gloves
				{ 203, 71094 },	-- Immolation Greaves
				{ 205, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 206, 71064 },	-- Immolation Gauntlets
				{ 207, 71066 },	-- Immolation Legplates
				{ 209, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
				{ 210, 70949 },	-- Immolation Handguards
				{ 211, 70947 },	-- Immolation Legguards
				{ 216, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 217, 70354 },	-- Ruthless Gladiator's Ornamented Gloves
				{ 218, 70356 },	-- Ruthless Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 221, 70250 },	-- Ruthless Gladiator's Scaled Gauntlets
				{ 222, 70252 },	-- Ruthless Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, 71271 },	-- Handwraps of the Cleansing Flame
				{ 303, 71273 },	-- Legwraps of the Cleansing Flame
				{ 305, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 306, 71276 },	-- Gloves of the Cleansing Flame
				{ 307, 71278 },	-- Leggings of the Cleansing Flame
				{ 316, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 70304 },	-- Ruthless Gladiator's Mooncloth Gloves
				{ 318, 70306 },	-- Ruthless Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 321, 70309 },	-- Ruthless Gladiator's Satin Gloves
				{ 322, 70311 },	-- Ruthless Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 402, 71292 },	-- Erupting Volcanic Gloves
				{ 403, 71294 },	-- Erupting Volcanic Kilt
				{ 405, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 406, 71302 },	-- Erupting Volcanic Grips
				{ 407, 71304 },	-- Erupting Volcanic Legguards
				{ 409, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 410, 71297 },	-- Erupting Volcanic Handwraps
				{ 411, 71299 },	-- Erupting Volcanic Legwraps
				{ 416, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 417, 70275 },	-- Ruthless Gladiator's Mail Gauntlets
				{ 418, 70277 },	-- Ruthless Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 421, 70270 },	-- Ruthless Gladiator's Linked Gauntlets
				{ 422, 70272 },	-- Ruthless Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 425, 70265 },	-- Ruthless Gladiator's Ringmail Gauntlets
				{ 426, 70267 },	-- Ruthless Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, 71059 },	-- Elementium Deathplate Gauntlets
				{ 503, 71061 },	-- Elementium Deathplate Greaves
				{ 505, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, 70953 },	-- Elementium Deathplate Handguards
				{ 507, 70952 },	-- Elementium Deathplate Legguards
				{ 509, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, 71069 },	-- Gauntlets of the Molten Giant
				{ 511, 71071 },	-- Legplates of the Molten Giant
				{ 513, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
				{ 514, 70943 },	-- Handguards of the Molten Giant
				{ 515, 70942 },	-- Legguards of the Molten Giant
				{ 516, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
				{ 517, 70245 },	-- Ruthless Gladiator's Dreadplate Gauntlets
				{ 518, 70247 },	-- Ruthless Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
				{ 525, 70255 },	-- Ruthless Gladiator's Plate Gauntlets
				{ 526, 70257 },	-- Ruthless Gladiator's Plate Legguards
				{ 601, 70363 },	-- Ruthless Gladiator's Cuffs of Accuracy
				{ 602, 70362 },	-- Ruthless Gladiator's Cord of Accuracy
				{ 603, 70364 },	-- Ruthless Gladiator's Treads of Alacrity
				{ 605, 70366 },	-- Ruthless Gladiator's Cuffs of Meditation
				{ 606, 70368 },	-- Ruthless Gladiator's Cord of Meditation
				{ 607, 70367 },	-- Ruthless Gladiator's Treads of Meditation
				{ 609, 70365 },	-- Ruthless Gladiator's Cuffs of Prowess
				{ 610, 70360 },	-- Ruthless Gladiator's Cord of Cruelty
				{ 611, 70361 },	-- Ruthless Gladiator's Treads of Cruelty
				{ 616, 70350 },	-- Ruthless Gladiator's Armwraps of Accuracy
				{ 617, 70349 },	-- Ruthless Gladiator's Waistband of Accuracy
				{ 618, 70348 },	-- Ruthless Gladiator's Boots of Cruelty
				{ 620, 70352 },	-- Ruthless Gladiator's Armwraps of Alacrity
				{ 621, 70347 },	-- Ruthless Gladiator's Waistband of Cruelty
				{ 622, 70351 },	-- Ruthless Gladiator's Boots of Alacrity
				{ 624, 70359 },	-- Ruthless Gladiator's Bindings of Prowess
				{ 625, 70346 },	-- Ruthless Gladiator's Belt of Cruelty
				{ 626, 70358 },	-- Ruthless Gladiator's Footguards of Alacrity
				{ 628, 70345 },	-- Ruthless Gladiator's Bindings of Meditation
				{ 629, 70343 },	-- Ruthless Gladiator's Belt of Meditation
				{ 630, 70344 },	-- Ruthless Gladiator's Footguards of Meditation
				{ 701, 70330 },	-- Ruthless Gladiator's Armbands of Meditation
				{ 702, 70328 },	-- Ruthless Gladiator's Waistguard of Meditation
				{ 703, 70329 },	-- Ruthless Gladiator's Sabatons of Meditation
				{ 705, 70342 },	-- Ruthless Gladiator's Armbands of Prowess
				{ 706, 70331 },	-- Ruthless Gladiator's Waistguard of Cruelty
				{ 707, 70341 },	-- Ruthless Gladiator's Sabatons of Alacrity
				{ 709, 70338 },	-- Ruthless Gladiator's Wristguards of Alacrity
				{ 710, 70336 },	-- Ruthless Gladiator's Links of Cruelty
				{ 711, 70337 },	-- Ruthless Gladiator's Sabatons of Alacrity
				{ 713, 70340 },	-- Ruthless Gladiator's Wristguards of Accuracy
				{ 714, 70339 },	-- Ruthless Gladiator's Links of Accuracy
				{ 715, 70335 },	-- Ruthless Gladiator's Sabatons of Cruelty
				{ 716, 70334 },	-- Ruthless Gladiator's Bracers of Meditation
				{ 717, 70332 },	-- Ruthless Gladiator's Clasp of Meditation
				{ 718, 70333 },	-- Ruthless Gladiator's Greaves of Meditation
				{ 720, 70327 },	-- Ruthless Gladiator's Armplates of Proficiency
				{ 721, 70326 },	-- Ruthless Gladiator's Girdle of Prowess
				{ 722, 70323 },	-- Ruthless Gladiator's Warboots of Alacrity
				{ 724, 70325 },	-- Ruthless Gladiator's Bracers of Prowess
				{ 725, 70319 },	-- Ruthless Gladiator's Clasp of Cruelty
				{ 726, 70324 },	-- Ruthless Gladiator's Greaves of Alacrity
				{ 728, 70322 },	-- Ruthless Gladiator's Armplates of Alacrity
				{ 729, 70320 },	-- Ruthless Gladiator's Girdle of Cruelty
				{ 730, 70321 },	-- Ruthless Gladiator's Warboots of Cruelty
				{ 801, 70386 },	-- Ruthless Gladiator's Cape of Cruelty
				{ 802, 70385 },	-- Ruthless Gladiator's Cape of Prowess
				{ 803, 70383 },	-- Ruthless Gladiator's Cloak of Alacrity
				{ 804, 70384 },	-- Ruthless Gladiator's Cloak of Prowess
				{ 805, 70387 },	-- Ruthless Gladiator's Drape of Diffusion
				{ 806, 70389 },	-- Ruthless Gladiator's Drape of Meditation
				{ 807, 70388 },	-- Ruthless Gladiator's Drape of Prowess
				{ 809, 70382 },	-- Ruthless Gladiator's Choker of Accuracy
				{ 810, 70381 },	-- Ruthless Gladiator's Choker of Proficiency
				{ 811, 70380 },	-- Ruthless Gladiator's Necklace of Proficiency
				{ 812, 70379 },	-- Ruthless Gladiator's Necklace of Prowess
				{ 813, 70377 },	-- Ruthless Gladiator's Pendant of Alacrity
				{ 814, 70376 },	-- Ruthless Gladiator's Pendant of Diffusion
				{ 815, 70378 },	-- Ruthless Gladiator's Pendant of Meditation
				{ 816, 70370 },	-- Ruthless Gladiator's Band of Accuracy
				{ 817, 70369 },	-- Ruthless Gladiator's Band of Cruelty
				{ 818, 70371 },	-- Ruthless Gladiator's Band of Meditation
				{ 819, 70374 },	-- Ruthless Gladiator's Ring of Accuracy
				{ 820, 70375 },	-- Ruthless Gladiator's Ring of Cruelty
				{ 821, 70373 },	-- Ruthless Gladiator's Signet of Accuracy
				{ 822, 70372 },	-- Ruthless Gladiator's Signet of Cruelty
				{ 901, 70399 },	-- Ruthless Gladiator's Badge of Conquest
				{ 902, 70401 },	-- Ruthless Gladiator's Badge of Dominance
				{ 903, 70400 },	-- Ruthless Gladiator's Badge of Victory
				{ 905, 70396 },	-- Ruthless Gladiator's Emblem of Cruelty
				{ 906, 70397 },	-- Ruthless Gladiator's Emblem of Meditation
				{ 907, 70398 },	-- Ruthless Gladiator's Emblem of Tenacity
				{ 916, [ATLASLOOT_IT_ALLIANCE] = 70390, [ATLASLOOT_IT_HORDE] = 70393 },	-- Ruthless Gladiator's Medallion of Cruelty
				{ 917, [ATLASLOOT_IT_ALLIANCE] = 70391, [ATLASLOOT_IT_HORDE] = 70394 },	-- Ruthless Gladiator's Medallion of Meditation
				{ 918, [ATLASLOOT_IT_ALLIANCE] = 70392, [ATLASLOOT_IT_HORDE] = 70395 },	-- Ruthless Gladiator's Medallion of Tenacity
				{ 920, 70404 },	-- Ruthless Gladiator's Insignia of Conquest
				{ 921, 70402 },	-- Ruthless Gladiator's Insignia of Dominance
				{ 922, 70403 },	-- Ruthless Gladiator's Insignia of Victory
				{ 924, "ac6045" },
			},
		},
		{ -- Alizabal, Mistress of Hate
			name = AL["Alizabal, Mistress of Hate"],
			EncounterJournalID = 339,
			[NORMAL_DIFF] = {
				{ 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 2, 77018 },	-- Deep Earth Gloves
				{ 3, 77020 },	-- Deep Earth Leggings
				{ 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 6, 77014 },	-- Deep Earth Grips
				{ 7, 77016 },	-- Deep Earth Legguards
				{ 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 10, 76749 },	-- Deep Earth Handwraps
				{ 11, 76751 },	-- Deep Earth Legwraps
				{ 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
				{ 17, 73599 },	-- Cataclysmic Gladiator's Wyrmhide Gloves
				{ 18, 73597 },	-- Cataclysmic Gladiator's Wyrmhide Legguards
				{ 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
				{ 21, 73615 },	-- Cataclysmic Gladiator's Dragonhide Gloves
				{ 22, 73613 },	-- Cataclysmic Gladiator's Dragonhide Legguards
				{ 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
				{ 25, 73607 },	-- Cataclysmic Gladiator's Kodohide Gloves
				{ 26, 73605 },	-- Cataclysmic Gladiator's Kodohide Legguards
				{ 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 102, 77029 },	-- Wyrmstalker's Gloves
				{ 103, 77031 },	-- Wyrmstalker's Legguards
				{ 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 106, 76212 },	-- Time Lord's Gloves
				{ 107, 76214 },	-- Time Lord's Leggings
				{ 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 110, 77024 },	-- Blackfang Battleweave Gloves
				{ 111, 77026 },	-- Blackfang Battleweave Legguards
				{ 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 114, 76343 },	-- Gloves of the Faceless Shroud
				{ 115, 76341 },	-- Leggings of the Faceless Shroud
				{ 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
				{ 117, 73583 },	-- Cataclysmic Gladiator's Chain Gauntlets
				{ 118, 73581 },	-- Cataclysmic Gladiator's Chain Leggings
				{ 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
				{ 121, 73576 },	-- Cataclysmic Gladiator's Silk Handguards
				{ 122, 73574 },	-- Cataclysmic Gladiator's Silk Trousers
				{ 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
				{ 125, 73526 },	-- Cataclysmic Gladiator's Leather Gloves
				{ 126, 73524 },	-- Cataclysmic Gladiator's Leather Legguards
				{ 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
				{ 129, 73487 },	-- Cataclysmic Gladiator's Felweave Handguards
				{ 130, 73485 },	-- Cataclysmic Gladiator's Felweave Trousers
				{ 201, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 202, 76766 },	-- Gloves of Radiant Glory
				{ 203, 76768 },	-- Greaves of Radiant Glory
				{ 205, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 206, 76875 },	-- Gauntlets of Radiant Glory
				{ 207, 76877 },	-- Legplates of Radiant Glory
				{ 209, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
				{ 210, 77004 },	-- Handguards of Radiant Glory
				{ 211, 77006 },	-- Legguards of Radiant Glory
				{ 216, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
				{ 217, 73559 },	-- Cataclysmic Gladiator's Ornamented Gloves
				{ 218, 73557 },	-- Cataclysmic Gladiator's Ornamented Legplates
				{ 220, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
				{ 221, 73570 },	-- Cataclysmic Gladiator's Scaled Gauntlets
				{ 222, 73568 },	-- Cataclysmic Gladiator's Scaled Legguards
				{ 301, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 302, 76357 },	-- Handwraps of Dying Light
				{ 303, 76359 },	-- Legwraps of Dying Light
				{ 305, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 306, 76348 },	-- Gloves of Dying Light
				{ 307, 76346 },	-- Leggings of Dying Light
				{ 316, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"].." / "..ALIL["Holy"] },
				{ 317, 73549 },	-- Cataclysmic Gladiator's Mooncloth Gloves
				{ 318, 73547 },	-- Cataclysmic Gladiator's Mooncloth Leggings
				{ 320, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
				{ 321, 73544 },	-- Cataclysmic Gladiator's Satin Gloves
				{ 322, 73542 },	-- Cataclysmic Gladiator's Satin Leggings
				{ 401, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 402, 77038 },	-- Spiritwalker's Gloves
				{ 403, 77036 },	-- Spiritwalker's Kilt
				{ 405, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 406, 77041 },	-- Spiritwalker's Grips
				{ 407, 77043 },	-- Spiritwalker's Legguards
				{ 409, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 410, 76757 },	-- Spiritwalker's Handwraps
				{ 411, 76759 },	--Spiritwalker's Legwraps
				{ 416, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
				{ 417, 73505 },	-- Cataclysmic Gladiator's Mail Gauntlets
				{ 418, 73503 },	-- Cataclysmic Gladiator's Mail Leggings
				{ 420, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
				{ 421, 73511 },	-- Cataclysmic Gladiator's Linked Gauntlets
				{ 422, 73509 },	-- Cataclysmic Gladiator's Linked Leggings
				{ 424, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
				{ 425, 73516 },	-- Cataclysmic Gladiator's Ringmail Gauntlets
				{ 426, 73514 },	-- Cataclysmic Gladiator's Ringmail Leggings
				{ 501, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"].." / "..ALIL["Unholy"] },
				{ 502, 76975 },	-- Necrotic Boneplate Gauntlets
				{ 503, 76977 },	-- Necrotic Boneplate Greaves
				{ 505, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
				{ 506, 77009 },	-- Necrotic Boneplate Handguards
				{ 507, 77011 },	-- Necrotic Boneplate Legguards
				{ 509, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"].." / "..ALIL["Fury"] },
				{ 510, 76985 },	-- Colossal Dragonplate Gauntlets
				{ 511, 76986 },	-- Colossal Dragonplate Legplates
				{ 513, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
				{ 514, 76989 },	-- Colossal Dragonplate Handguards
				{ 515, 76991 },	-- Colossal Dragonplate Legguards
				{ 516, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
				{ 517, 73619 },	-- Cataclysmic Gladiator's Dreadplate Gauntlets
				{ 518, 73617 },	-- Cataclysmic Gladiator's Dreadplate Legguards
				{ 524, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
				{ 525, 73481 },	-- Cataclysmic Gladiator's Plate Gauntlets
				{ 526, 73479 },	-- Cataclysmic Gladiator's Plate Legguards
				{ 601, 73633 },	-- Cataclysmic Gladiator's Cuffs of Accuracy
				{ 602, 73638 },	-- Cataclysmic Gladiator's Cord of Accuracy
				{ 603, 73635 },	-- Cataclysmic Gladiator's Treads of Alacrity
				{ 605, 73631 },	-- Cataclysmic Gladiator's Cuffs of Meditation
				{ 606, 73637 },	-- Cataclysmic Gladiator's Cord of Meditation
				{ 607, 73634 },	-- Cataclysmic Gladiator's Treads of Meditation
				{ 609, 73632 },	-- Cataclysmic Gladiator's Cuffs of Prowess
				{ 610, 73639 },	-- Cataclysmic Gladiator's Cord of Cruelty
				{ 611, 73636 },	-- Cataclysmic Gladiator's Treads of Cruelty
				{ 616, 73528 },	-- Cataclysmic Gladiator's Armwraps of Accuracy
				{ 617, 73532 },	-- Cataclysmic Gladiator's Waistband of Accuracy
				{ 618, 73531 },	-- Cataclysmic Gladiator's Boots of Cruelty
				{ 620, 73529 },	-- Cataclysmic Gladiator's Armwraps of Alacrity
				{ 621, 73533 },	-- Cataclysmic Gladiator's Waistband of Cruelty
				{ 622, 73530 },	-- Cataclysmic Gladiator's Boots of Alacrity
				{ 624, 73600 },	-- Cataclysmic Gladiator's Bindings of Prowess
				{ 625, 73602 },	-- Cataclysmic Gladiator's Belt of Cruelty
				{ 626, 73601 },	-- Cataclysmic Gladiator's Footguards of Alacrity
				{ 628, 73608 },	-- Cataclysmic Gladiator's Bindings of Meditation
				{ 629, 73610 },	-- Cataclysmic Gladiator's Belt of Meditation
				{ 630, 73609 },	-- Cataclysmic Gladiator's Footguards of Meditation
				{ 701, 73518 },	-- Cataclysmic Gladiator's Armbands of Meditation
				{ 702, 73522 },	-- Cataclysmic Gladiator's Waistguard of Meditation
				{ 703, 73520 },	-- Cataclysmic Gladiator's Sabatons of Meditation
				{ 705, 73519 },	-- Cataclysmic Gladiator's Armbands of Prowess
				{ 706, 73507 },	-- Cataclysmic Gladiator's Waistguard of Cruelty
				{ 707, 73677 },	-- Cataclysmic Gladiator's Sabatons of Alacrity
				{ 709, 73586 },	-- Cataclysmic Gladiator's Wristguards of Alacrity
				{ 710, 73590 },	-- Cataclysmic Gladiator's Links of Cruelty
				{ 711, 73587 },	-- Cataclysmic Gladiator's Sabatons of Alacrity
				{ 713, 73585 },	-- Cataclysmic Gladiator's Wristguards of Accuracy
				{ 714, 73589 },	-- Cataclysmic Gladiator's Links of Accuracy
				{ 715, 73588 },	-- Cataclysmic Gladiator's Sabatons of Cruelty
				{ 716, 73561 },	-- Cataclysmic Gladiator's Bracers of Meditation
				{ 717, 73565 },	-- Cataclysmic Gladiator's Clasp of Meditation
				{ 718, 73563 },	-- Cataclysmic Gladiator's Greaves of Meditation
				{ 720, 73551 },	-- Cataclysmic Gladiator's Armplates of Proficiency
				{ 721, 73554 },	-- Cataclysmic Gladiator's Girdle of Prowess
				{ 722, 73552 },	-- Cataclysmic Gladiator's Warboots of Alacrity
				{ 724, 73562 },	-- Cataclysmic Gladiator's Bracers of Prowess
				{ 725, 73566 },	-- Cataclysmic Gladiator's Clasp of Cruelty
				{ 726, 73564 },	-- Cataclysmic Gladiator's Greaves of Alacrity
				{ 728, 73550 },	-- Cataclysmic Gladiator's Armplates of Alacrity
				{ 729, 73555 },	-- Cataclysmic Gladiator's Girdle of Cruelty
				{ 730, 73553 },	-- Cataclysmic Gladiator's Warboots of Cruelty
				{ 801, 73647 },	-- Cataclysmic Gladiator's Cape of Cruelty
				{ 802, 73646 },	-- Cataclysmic Gladiator's Cape of Prowess
				{ 803, 73495 },	-- Cataclysmic Gladiator's Cloak of Alacrity
				{ 804, 73494 },	-- Cataclysmic Gladiator's Cloak of Prowess
				{ 805, 73629 },	-- Cataclysmic Gladiator's Drape of Diffusion
				{ 806, 73628 },	-- Cataclysmic Gladiator's Drape of Meditation
				{ 807, 73630 },	-- Cataclysmic Gladiator's Drape of Prowess
				{ 809, 73492 },	-- Cataclysmic Gladiator's Choker of Accuracy
				{ 810, 73493 },	-- Cataclysmic Gladiator's Choker of Proficiency
				{ 811, 73645 },	-- Cataclysmic Gladiator's Necklace of Proficiency
				{ 812, 73644 },	-- Cataclysmic Gladiator's Necklace of Prowess
				{ 813, 73627 },	-- Cataclysmic Gladiator's Pendant of Alacrity
				{ 814, 73626 },	-- Cataclysmic Gladiator's Pendant of Diffusion
				{ 815, 73625 },	-- Cataclysmic Gladiator's Pendant of Meditation
				{ 816, 73622 },	-- Cataclysmic Gladiator's Band of Accuracy
				{ 817, 73623 },	-- Cataclysmic Gladiator's Band of Cruelty
				{ 818, 73621 },	-- Cataclysmic Gladiator's Band of Meditation
				{ 819, 73640 },	-- Cataclysmic Gladiator's Ring of Accuracy
				{ 820, 73641 },	-- Cataclysmic Gladiator's Ring of Cruelty
				{ 821, 73488 },	-- Cataclysmic Gladiator's Signet of Accuracy
				{ 822, 73489 },	-- Cataclysmic Gladiator's Signet of Cruelty
				{ 901, 73648 },	-- Cataclysmic Gladiator's Badge of Conquest
				{ 902, 73498 },	-- Cataclysmic Gladiator's Badge of Dominance
				{ 903, 73496 },	-- Cataclysmic Gladiator's Badge of Victory
				{ 905, 73593 },	-- Cataclysmic Gladiator's Emblem of Cruelty
				{ 906, 73591 },	-- Cataclysmic Gladiator's Emblem of Meditation
				{ 907, 73592 },	-- Cataclysmic Gladiator's Emblem of Tenacity
				{ 916, [ATLASLOOT_IT_ALLIANCE] = 73539, [ATLASLOOT_IT_HORDE] = 73538 },	-- Cataclysmic Gladiator's Medallion of Cruelty
				{ 917, [ATLASLOOT_IT_ALLIANCE] = 73535, [ATLASLOOT_IT_HORDE] = 73534 },	-- Cataclysmic Gladiator's Medallion of Meditation
				{ 918, [ATLASLOOT_IT_ALLIANCE] = 73536, [ATLASLOOT_IT_HORDE] = 73537 },	-- Cataclysmic Gladiator's Medallion of Tenacity
				{ 920, 73643 },	-- Cataclysmic Gladiator's Insignia of Conquest
				{ 921, 73497 },	-- Cataclysmic Gladiator's Insignia of Dominance
				{ 922, 73491 },	-- Cataclysmic Gladiator's Insignia of Victory
				{ 924, "ac6108" },
			},
		},
	},
	T11_SET,
	T12_SET,
	T13_SET,
}
