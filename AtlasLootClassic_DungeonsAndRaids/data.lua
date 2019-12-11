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
local data = AtlasLoot.ItemDB:Add(addonname, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local RAID20_DIFF = data:AddDifficulty(AL["20 Raid"], "r20", 9)
local RAID40_DIFF = data:AddDifficulty(AL["40 Raid"], "r40", 9)
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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1, "INV_Box_01", nil, AL["Key"], nil },
		{ 2, 16309,},
		{ 3, 12344,},
		{ 4, 17191,},
		{ 5, 7146, },
		{ 6, 12382,},
		{ 7, 6893, },
		{ 8, 11000,},
		{ 9, 11140,},
		{ 10, 18249, },
		{ 11, 13704, },
		{ 12, 11197, },
		{ 13, 18266, },
		{ 14, 18268, },
		{ 15, 13873, },
		{ 16, "INV_Box_01", nil, AL["Misc"], nil },
		{ 17, 19931 },
		{ 18, 18250 },
		{ 19, 9240 },
		{ 20, 17333 },
		{ 21, 22754 },
		{ 22, 13523 },
		{ 23, 18746 },
		{ 24, 18663 },
		{ 25, 19974 },
		{ 26, 7733 },
		{ 27, 10818 },
		{ 29, 22057 },
		{ 30, 21986 },
	},
}

local T1_SET = {
	name = format(AL["Tier %s Sets"], "1"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 203 }, -- Warlock
		{ 3, 202 }, -- Priest
		{ 16, 201 }, -- Mage
		{ 5, 204 }, -- Rogue
		{ 20, 205 }, -- Druid
		{ 7, 206 }, -- Hunter
		{ 9, 209 }, -- Warrior
		{ 24, 208 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 207 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local T2_SET = {
	name = format(AL["Tier %s Sets"], "2"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 3,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 212 }, -- Warlock
		{ 3, 211 }, -- Priest
		{ 16, 210 }, -- Mage
		{ 5, 213 }, -- Rogue
		{ 20, 214 }, -- Druid
		{ 7, 215 }, -- Hunter
		{ 9, 218 }, -- Warrior
		{ 24, 217 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 216 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local T3_SET = {
	name = format(AL["Tier %s Sets"], "3"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 6,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1, 529 }, -- Warlock
		{ 3, 525 }, -- Priest
		{ 16, 526 }, -- Mage
		{ 5, 524 }, -- Rogue
		{ 20, 521 }, -- Druid
		{ 7, 530 }, -- Hunter
		{ 9, 523 }, -- Warrior
		{ 24, 528 }, -- Paladin
	},

	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 22, 527 }, -- Shaman
		{ 24 }, -- Paladin
	},
}

local AQ_OPENING = {	-- Keys
	name = AL["AQ opening"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	ContentPhase = 5,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  21138 }, -- Red Scepter Shard
		{ 2,  21529 }, -- Amulet of Shadow Shielding
		{ 3,  21530 }, -- Onyx Embedded Leggings
		{ 5,  21139 }, -- Green Scepter Shard
		{ 6,  21531 }, -- Drake Tooth Necklace
		{ 7,  21532 }, -- Drudge Boots
		{ 9,  21137 }, -- Blue Scepter Shard
		{ 10, 21517 }, -- Gnomish Turban of Psychic Might
		{ 11, 21527 }, -- Darkwater Robes
		{ 12, 21526 }, -- Band of Icy Depths
		{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
		{ 16, 21175 }, -- The Scepter of the Shifting Sands
		{ 17, 21176 }, -- Black Qiraji Resonating Crystal
		{ 18, 21523 }, -- Fang of Korialstrasz
		{ 19, 21521 }, -- Runesword of the Red
		{ 20, 21522 }, -- Shadowsong's Sorrow
		{ 21, 21520 }, -- Ravencrest's Legacy
	},
}

local DM_BOOKS = { -- DMBooks
	name = AL["Books"],
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  18401 }, -- Foror's Compendium of Dragon Slaying
		{ 3,  18362 }, -- Holy Bologna: What the Light Won't Tell You
		{ 4,  18358 }, -- The Arcanist's Cookbook
		{ 5,  18360 }, -- Harnessing Shadows
		{ 6,  18356 }, -- Garona: A Study on Stealth and Treachery
		{ 7,  18364 }, -- The Emerald Dream
		{ 8,  18361 }, -- The Greatest Race of Hunters
		{ 9,  18363 }, -- Frost Shock and You
		{ 10, 18359 }, -- The Light and How to Swing It
		{ 11, 18357 }, -- Codex of Defense
		--{ 16, 18348 }, -- Quel'Serrar
		{ 18, 18333 }, -- Libram of Focus
		{ 19, 18334 }, -- Libram of Protection
		{ 20, 18332 }, -- Libram of Rapidity
		{ 22, 11733 }, -- Libram of Constitution
		{ 23, 11736 }, -- Libram of Resilience
		{ 24, 11732 }, -- Libram of Rumination
		{ 25, 11734 }, -- Libram of Tenacity
		{ 26, 11737 }, -- Libram of Voracity
	},
}

data["Ragefire"] = {
	MapID = 2437,
	InstanceID = 389,
	AtlasMapID = "Ragefire",
	AtlasMapFile = "RagefireChasm",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {10, 13, 18},
	items = {
		{ -- RFCTaragaman
			name = AL["Taragaman the Hungerer"],
			npcID = 11520,
			Level = 16,
			DisplayIDs = {{7970}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  14149 }, -- Subterranean Cape
				{ 2,  14148 }, -- Crystalline Cuffs
				{ 3,  14145 }, -- Cursed Felblade
			},
		},
		{ -- RFCJergosh
			name = AL["Jergosh the Invoker"],
			npcID = 11518,
			Level = 16,
			DisplayIDs = {{11429}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  14150 }, -- Robe of Evocation
				{ 2,  14147 }, -- Cavedweller Bracers
				{ 3,  14151 }, -- Chanting Blade
			},
		},
	},
}

data["WailingCaverns"] = {
	MapID = 718,
	InstanceID = 43,
	SubAreaIDs = { 15285, 15301, 15294, 15300, 15292, 17731 },
	AtlasMapID = "WailingCaverns",
	AtlasMapFile = {"WailingCaverns", "WailingCavernsEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {10, 17, 24},
	items = {
		{ -- WCLordCobrahn
			name = AL["Lord Cobrahn"],
			npcID = 3669,
			Level = 20,
			SubAreaID = 15300,
			DisplayIDs = {{4213}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6460 }, -- Cobrahn's Grasp
				{ 2,  10410 }, -- Leggings of the Fang
				{ 4,  6465 }, -- Robe of the Moccasin
			},
		},
		{ -- WCLadyAnacondra
			name = AL["Lady Anacondra"],
			npcID = 3671,
			Level = 20,
			DisplayIDs = {{4313}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  10412 }, -- Belt of the Fang
				{ 3,  5404 }, -- Serpent's Shoulders
				{ 4,  6446 }, -- Snakeskin Bag
			},
		},
		{ -- WCKresh
			name = AL["Kresh"],
			npcID = 3653,
			Level = 20,
			DisplayIDs = {{5126}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  13245 }, -- Kresh's Back
				{ 3,  6447 }, -- Worn Turtle Shell Shield
			},
		},
		{ -- WCLordPythas
			name = AL["Lord Pythas"],
			npcID = 3670,
			Level = 21,
			SubAreaID = 17731,
			DisplayIDs = {{4214}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6472 }, -- Stinging Viper
				{ 3,  6473 }, -- Armor of the Fang
			},
		},
		{ -- WCSkum
			name = AL["Skum"],
			npcID = 3674,
			Level = 21,
			DisplayIDs = {{4203}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6449 }, -- Glowing Lizardscale Cloak
				{ 3,  6448 }, -- Tail Spike
			},
		},
		{ -- WCLordSerpentis
			name = AL["Lord Serpentis"],
			npcID = 3673,
			Level = 21,
			DisplayIDs = {{4215}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6469 }, -- Venomstrike
				{ 3,  5970 }, -- Serpent Gloves
				{ 4,  10411 }, -- Footpads of the Fang
				{ 5,  6459 }, -- Savage Trodders
			},
		},
		{ -- WCVerdan
			name = AL["Verdan the Everliving"],
			npcID = 5775,
			Level = 21,
			DisplayIDs = {{4256}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6630 }, -- Seedcloud Buckler
				{ 2,  6631 }, -- Living Root
				{ 4,  6629 }, -- Sporid Cape
			},
		},
		{ -- WCMutanus
			name = AL["Mutanus the Devourer"],
			npcID = 3654,
			Level = 22,
			SubAreaID = 15294,
			DisplayIDs = {{4088}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6461 }, -- Slime-encrusted Pads
				{ 2,  6627 }, -- Mutant Scale Breastplate
				{ 3,  6463 }, -- Deep Fathom Ring
				{ 16,  10441 }, -- Glowing Shard
			},
		},
		{ -- WCDeviateFaerieDragon
			name = AL["Deviate Faerie Dragon"],
			npcID = 5912,
			Level = 20,
			DisplayIDs = {{1267}},
			AtlasMapBossID = 10,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  5243 }, -- Firebelcher
				{ 3,  6632 }, -- Feyscale Cloak
			},
		},
		{ -- WCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10413 }, -- Gloves of the Fang
			},
		},
	},
}

data["TheDeadmines"] = {
	MapID = 1581,
	InstanceID = 36,
	SubAreaIDs = { 19444, 19529, 19502, 26104 },
	AtlasMapID = "TheDeadmines",
	AtlasMapFile = {"TheDeadmines", "TheDeadminesEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {10, 17, 26},
	items = {
		{	--DMRhahkZor
			name = AL["Rhahk'Zor"],
			npcID = 644,
			Level = 19,
			DisplayIDs = {{14403}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 872 },	-- Rockslicer
				{ 3, 5187 },	-- Rhahk'Zor's Hammer
			},
		},
		{	--DMMinerJohnson
			name = AL["Miner Johnson"],
			npcID = 3586,
			Level = 19,
			DisplayIDs = {{556}},
			specialType = "rare",
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 5443 },	-- Gold-plated Buckler
				{ 3, 5444 },	-- Miner's Cape
			},
		},
		{	--DMSneed
			name = AL["Sneed"],
			npcID = 643,
			Level = 20,
			SubAreaID = 19529,
			DisplayIDs = {{7125}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 5194 },	-- Taskmaster Axe
				{ 3, 5195 },	-- Gold-flecked Gloves
			},
		},
		{	--DMSneedsShredder
			name = AL["Sneed's Shredder"],
			npcID = 642,
			Level = 20,
			DisplayIDs = {{1269}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 1937 },	-- Buzz Saw
				{ 3, 2169 },	-- Buzzer Blade
			},
		},
		{	--DMGilnid
			name = AL["Gilnid"],
			npcID = 1763,
			Level = 20,
			SubAreaID = 19502,
			DisplayIDs = {{7124}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 3, 5199 },	-- Smelting Pants
			},
		},
		{	--DMDefiasGunpowder
			name = AL["Defias Gunpowder"],
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 5397 },	-- Defias Gunpowder
			},
		},
		{	--DMMrSmite
			name = AL["Mr. Smite"],
			npcID = 646,
			Level = 20,
			SubAreaID = 26104,
			DisplayIDs = {{2026}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 7230 },	-- Smite's Mighty Hammer
				{ 3, 5192 },	-- Thief's Blade
				{ 4, 5196 },	-- Smite's Reaver
			},
		},
		{	--DMCaptainGreenskin
			name = AL["Captain Greenskin"],
			npcID = 647,
			Level = 20,
			DisplayIDs = {{7113},{2349},{2347},{5207}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5201 },	-- Emberstone Staff
				{ 3, 10403 },	-- Blackened Defias Belt
				{ 4, 5200 },	-- Impaling Harpoon
			},
		},
		{	--DMVanCleef
			name = AL["Edwin VanCleef"],
			npcID = 639,
			Level = 21,
			DisplayIDs = {{2029}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 10399 },	-- Blackened Defias Armor
				{ 4, 5191 },	-- Cruel Barb
				{ 6, 2874 },	-- An Unsent Letter
			},
		},
		{	--DMCookie
			name = AL["Cookie"],
			npcID = 645,
			Level = 20,
			DisplayIDs = {{1305}},
			specialType = "elite",
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5198 },	-- Cookie's Stirring Rod
				{ 3, 5197 },	-- Cookie's Tenderizer
				{ 5, 8490 },	-- Cat Carrier (Siamese)
			},
		},
		{	--DMTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 8492 },	-- Parrot Cage (Green Wing Macaw)
			},
		},
		KEYS,
	}
}

data["ShadowfangKeep"] = {
	MapID = 209,
	InstanceID = 33,
	AtlasMapID = "ShadowfangKeep",
	AtlasMapFile = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {11, 22, 30},
	items = {
		{ -- SFKRethilgore
			name = AL["Rethilgore"],
			npcID = 3914,
			Level = 20,
			DisplayIDs = {{524}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  5254 }, -- Rugged Spaulders
			},
		},
		{ -- SFKFelSteed
			name = AL["Fel Steed / Shadow Charger"],
			npcID = {3865, 3864},
			Level = {19, 20},
			DisplayIDs = {{1952},{1951}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6341 }, -- Eerie Stable Lantern
				{ 3,  932 }, -- Fel Steed Saddlebags
			},
		},
		{ -- SFKRazorclawtheButcher
			name = AL["Razorclaw the Butcher"],
			npcID = 3886,
			Level = 22,
			DisplayIDs = {{524}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  1292 }, -- Butcher's Cleaver
				{ 3,  6226 }, -- Bloody Apron
				{ 4,  6633 }, -- Butcher's Slicer
			},
		},
		{ -- SFKSilverlaine
			name = AL["Baron Silverlaine"],
			npcID = 3887,
			Level = 24,
			DisplayIDs = {{3222}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6321 }, -- Silverlaine's Family Seal
				{ 3,  6323 }, -- Baron's Scepter
			},
		},
		{ -- SFKSpringvale
			name = AL["Commander Springvale"],
			npcID = 4278,
			Level = 24,
			DisplayIDs = {{3223}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  6320 }, -- Commander's Crest
				{ 3,  3191 }, -- Arced War Axe
			},
		},
		{ -- SFKSever
			name = AL["Sever"],
			npcID = 14682,
			DisplayIDs = {{1061}},
			AtlasMapBossID = 7,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  23173 }, -- Abomination Skin Leggings
				{ 2,  23171 }, -- The Axe of Severing
			},
		},
		{ -- SFKOdotheBlindwatcher
			name = AL["Odo the Blindwatcher"],
			npcID = 4279,
			Level = 24,
			DisplayIDs = {{522}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  6318 }, -- Odo's Ley Staff
				{ 3,  6319 }, -- Girdle of the Blindwatcher
			},
		},
		{ -- SFKDeathswornCaptain
			name = AL["Deathsworn Captain"],
			npcID = 3872,
			Level = 25,
			DisplayIDs = {{3224}},
			specialType = "rare",
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6642 }, -- Phantom Armor
				{ 3,  6641 }, -- Haunting Blade
			},
		},
		{ -- SFKArugalsVoidwalker
			name = AL["Arugal's Voidwalker"],
			npcID = 4627,
			Level = {24, 25},
			DisplayIDs = {{1131}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  5943 }, -- Rift Bracers
			},
		},
		{ -- SFKFenrustheDevourer
			name = AL["Fenrus the Devourer"],
			npcID = 4274,
			Level = 25,
			DisplayIDs = {{2352}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6340 }, -- Fenrus' Hide
				{ 2,  3230 }, -- Black Wolf Bracers
			},
		},
		{ -- SFKWolfMasterNandos
			name = AL["Wolf Master Nandos"],
			npcID = 3927,
			Level = 25,
			DisplayIDs = {{11179}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  3748 }, -- Feline Mantle
				{ 3,  6314 }, -- Wolfmaster Cape
			},
		},
		{ -- SFKArchmageArugal
			name = AL["Archmage Arugal"],
			npcID = 4275,
			Level = 26,
			DisplayIDs = {{2353}},
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  6324 }, -- Robes of Arugal
				{ 2,  6392 }, -- Belt of Arugal
				{ 3,  6220 }, -- Meteor Shard
			},
		},
		{ -- SFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2292 }, -- Necrology Robes
				{ 2,  1489 }, -- Gloomshroud Armor
				{ 3,  1974 }, -- Mindthrust Bracers
				{ 4,  2807 }, -- Guillotine Axe
				{ 5,  1482 }, -- Shadowfang
				{ 6,  1935 }, -- Assassin's Blade
				{ 7,  1483 }, -- Face Smasher
				{ 8,  1318 }, -- Night Reaver
				{ 9,  3194 }, -- Black Malice
				{ 10, 2205 }, -- Duskbringer
				{ 11, 1484 }, -- Witching Stave
			},
		},
		{ -- SFKJordansHammer
			name = AL["Jordan's Smithing Hammer"],
			ExtraList = true,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  6895 }, -- Jordan's Smithing Hammer
			},
		},
		{ -- SFKBookofUr
			name = AL["The Book of Ur"],
			ExtraList = true,
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6283 }, -- The Book of Ur
			},
		},
	},
}

data["BlackfathomDeeps"] = {
	MapID = 719,
	InstanceID = 48,
	AtlasMapID = "BlackfathomDeeps",
	AtlasMapFile = {"BlackfathomDeeps", "BlackfathomDeepsEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {15, 24, 32},
	items = {
		{ -- BFDGhamoora
			name = AL["Ghamoo-ra"],
			npcID = 4887,
			Level = 25,
			DisplayIDs = {{5027}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  6907 }, -- Tortoise Armor
				{ 3,  6908 }, -- Ghamoo-ra's Bind
			},
		},
		{ -- BFDLadySarevess
			name = AL["Lady Sarevess"],
			npcID = 4831,
			Level = 25,
			DisplayIDs = {{4979}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  888 }, -- Naga Battle Gloves
				{ 3,  3078 }, -- Naga Heartpiercer
				{ 4,  11121 }, -- Darkwater Talwar
			},
		},
		{ -- BFDGelihast
			name = AL["Gelihast"],
			npcID = 6243,
			Level = 26,
			DisplayIDs = {{1773}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6906 }, -- Algae Fists
				{ 3,  6905 }, -- Reef Axe
				{ 5,  1470 }, -- Murloc Skin Bag
			},
		},
		{ -- BFDBaronAquanis
			name = AL["Baron Aquanis"],
			npcID = 12876,
			Level = 28,
			DisplayIDs = {{110}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  16782 }, -- Strange Water Globe
			},
		},
		{ -- BFDTwilightLordKelris
			name = AL["Twilight Lord Kelris"],
			npcID = 4832,
			Level = 27,
			DisplayIDs = {{4939}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  1155 }, -- Rod of the Sleepwalker
				{ 3,  6903 }, -- Gaze Dreamer Pants
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Old Serra'kis"],
			npcID = 4830,
			Level = 26,
			DisplayIDs = {{1816}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6901 }, -- Glowing Thresher Cape
				{ 2,  6904 }, -- Bite of Serra'kis
				{ 4,  6902 }, -- Bands of Serra'kis
			},
		},
		{ -- BFDAkumai
			name = AL["Aku'mai"],
			npcID = 4829,
			Level = 28,
			DisplayIDs = {{2837}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  6911 }, -- Moss Cinch
				{ 2,  6910 }, -- Leech Pants
				{ 3,  6909 }, -- Strike of the Hydra
			},
		},
		{ -- BFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1486 }, -- Tree Bark Jacket
				{ 2,  3416 }, -- Martyr's Chain
				{ 3,  1491 }, -- Ring of Precision
				{ 4,  3414 }, -- Crested Scepter
				{ 5,  1454 }, -- Axe of the Enforcer
				{ 6,  1481 }, -- Grimclaw
				{ 7,  2567 }, -- Evocator's Blade
				{ 8,  3413 }, -- Doomspike
				{ 9,  3417 }, -- Onyx Claymore
				{ 10, 3415 }, -- Staff of the Friar
				{ 11, 2271 }, -- Staff of the Blessed Seer
			},
		},
	},
}

data["TheStockade"] = {
	MapID = 717,
	InstanceID = 34,
	AtlasMapID = "TheStockade",
	AtlasMapFile = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {15, 24, 32},
	items = {
		{ -- SWStKamDeepfury
			name = AL["Kam Deepfury"],
			npcID = 1666,
			Level = 27,
			DisplayIDs = {{825}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  2280 }, -- Kam's Walking Stick
			},
		},
		{ -- SWStBruegalIronknuckle
			name = AL["Bruegal Ironknuckle"],
			npcID = 1720,
			Level = 26,
			DisplayIDs = {{2142}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  3228 }, -- Jimmied Handcuffs
				{ 2,  2941 }, -- Prison Shank
				{ 3,  2942 }, -- Iron Knuckles
			},
		},
		{ -- SWStTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1076 }, -- Defias Renegade Ring
			},
		},
	},
}

data["Gnomeregan"] = {
	MapID = 721,
	InstanceID = 90,
	AtlasMapID = "Gnomeregan",
	AtlasMapFile = {"Gnomeregan", "GnomereganEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {19, 29, 38},
	items = {
		{ -- GnTechbot
			name = AL["Techbot"],
			npcID = 6231,
			Level = 26,
			DisplayIDs = {{7288}},
			[NORMAL_DIFF] = {
				{ 1,  9444 }, -- Techbot CPU Shell
			},
		},
		{ -- GnGrubbis
			name = AL["Grubbis"],
			npcID = 7361,
			Level = 32,
			DisplayIDs = {{6533}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9445 }, -- Grubbis Paws
			},
		},
		{ -- GnViscousFallout
			name = AL["Viscous Fallout"],
			npcID = 7079,
			Level = 30,
			DisplayIDs = {{5497}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  9454 }, -- Acidic Walkers
				{ 2,  9453 }, -- Toxic Revenger
				{ 3,  9452 }, -- Hydrocane
			},
		},
		{ -- GnElectrocutioner6000
			name = AL["Electrocutioner 6000"],
			npcID = 6235,
			Level = 32,
			DisplayIDs = {{6915}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  9447 }, -- Electrocutioner Lagnut
				{ 2,  9446 }, -- Electrocutioner Leg
				{ 4,  9448 }, -- Spidertank Oilrag
				{ 6,  6893 }, -- Workshop Key
			},
		},
		{ -- GnCrowdPummeler960
			name = AL["Crowd Pummeler 9-60"],
			npcID = 6229,
			Level = 32,
			DisplayIDs = {{6774}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  9449 }, -- Manual Crowd Pummeler
				{ 3,  9450 }, -- Gnomebot Operating Boots
			},
		},
		{ -- GnDIAmbassador
			name = AL["Dark Iron Ambassador"],
			npcID = 6228,
			Level = 33,
			DisplayIDs = {{6669}},
			AtlasMapBossID = 7,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  9455 }, -- Emissary Cuffs
				{ 2,  9456 }, -- Glass Shooter
				{ 3,  9457 }, -- Royal Diplomatic Scepter
			},
		},
		{ -- GnMekgineerThermaplugg
			name = AL["Mekgineer Thermaplugg"],
			npcID = 7800,
			Level = 34,
			DisplayIDs = {{6980}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  9492 }, -- Electromagnetic Gigaflux Reactivator
				{ 2,  9461 }, -- Charged Gear
				{ 3,  9458 }, -- Thermaplugg's Central Core
				{ 4,  9459 }, -- Thermaplugg's Left Arm
				{ 16, 4415 }, -- Schematic: Craftsman's Monocle
				--{ 17, 4393 }, -- Craftsman's Monocle
				{ 17, 4413 }, -- Schematic: Discombobulator Ray
				--{ 20, 4388 }, -- Discombobulator Ray
				{ 18, 4411 }, -- Schematic: Flame Deflector
				--{ 23, 4376 }, -- Flame Deflector
				{ 19, 7742 }, -- Schematic: Gnomish Cloaking Device
				--{ 26, 4397 }, -- Gnomish Cloaking Device
			},
		},
		{ -- GnTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9508 }, -- Mechbuilder's Overalls
				{ 2,  9491 }, -- Hotshot Pilot's Gloves
				{ 3,  9509 }, -- Petrolspill Leggings
				{ 4,  9510 }, -- Caverndeep Trudgers
				{ 5,  9487 }, -- Hi-tech Supergun
				{ 6,  9485 }, -- Vibroblade
				{ 7,  9488 }, -- Oscillating Power Hammer
				{ 8,  9486 }, -- Supercharger Battle Axe
				{ 9,  9490 }, -- Gizmotron Megachopper
				{ 16, 9327 }, -- Security DELTA Data Access Card
				{ 18, 7191 }, -- Fused Wiring
				{ 19, 9308 }, -- Grime-Encrusted Object
				{ 20, 9326 }, -- Grime-Encrusted Ring
				{ 22, 9279 }, -- White Punch Card
				{ 23, 9280 }, -- Yellow Punch Card
				{ 24, 9282 }, -- Blue Punch Card
				{ 25, 9281 }, -- Red Punch Card
				{ 26, 9316 }, -- Prismatic Punch Card
			},
		},

	},
}

data["RazorfenKraul"] = {
	MapID = 491,
	InstanceID = 47,
	AtlasMapID = "RazorfenKraul",
	AtlasMapFile = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {25, 29, 38},
	items = {
		{ -- RFKAggem
			name = AL["Aggem Thorncurse"],
			npcID = 4424,
			Level = 30,
			DisplayIDs = {{6097}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  6681 }, -- Thornspike
			},
		},
		{ -- RFKDeathSpeakerJargba
			name = AL["Death Speaker Jargba"],
			npcID = 4428,
			Level = 30,
			DisplayIDs = {{4644}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  2816 }, -- Death Speaker Scepter
				{ 3,  6685 }, -- Death Speaker Mantle
				{ 4,  6682 }, -- Death Speaker Robes
			},
		},
		{ -- RFKOverlordRamtusk
			name = AL["Overlord Ramtusk"],
			npcID = 4420,
			Level = 32,
			DisplayIDs = {{4652}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6687 }, -- Corpsemaker
				{ 3,  6686 }, -- Tusken Helm
			},
		},
		{ -- RFKRazorfenSpearhide
			name = AL["Razorfen Spearhide"],
			npcID = 4438,
			Level = {29, 30},
			DisplayIDs = {{6078}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  6679 }, -- Armor Piercer
			},
		},
		{ -- RFKAgathelos
			name = AL["Agathelos the Raging"],
			npcID = 4422,
			Level = 33,
			DisplayIDs = {{2450}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  6691 }, -- Swinetusk Shank
				{ 3,  6690 }, -- Ferine Leggings
			},
		},
		{ -- RFKBlindHunter
			name = AL["Blind Hunter"],
			npcID = 4425,
			Level = 32,
			DisplayIDs = {{4735}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6695 }, -- Stygian Bone Amulet
				{ 2,  6697 }, -- Batwing Mantle
				{ 3,  6696 }, -- Nightstalker Bow
			},
		},
		{ -- RFKCharlgaRazorflank
			name = AL["Charlga Razorflank"],
			npcID = 4421,
			Level = 33,
			DisplayIDs = {{4642}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6693 }, -- Agamaggan's Clutch
				{ 2,  6694 }, -- Heart of Agamaggan
				{ 3,  6692 }, -- Pronged Reaver
				{ 16,  17008 }, -- Small Scroll
			},
		},
		{ -- RFKEarthcallerHalmgar
			name = AL["Earthcaller Halmgar"],
			npcID = 4842,
			Level = 32,
			DisplayIDs = {{6102}},
			AtlasMapBossID = 9,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  6689 }, -- Wind Spirit Staff
				{ 3,  6688 }, -- Whisperwind Headdress
			},
		},
		{ -- RFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2264 }, -- Mantle of Thieves
				{ 2,  1488 }, -- Avenger's Armor
				{ 3,  4438 }, -- Pugilist Bracers
				{ 4,  1978 }, -- Wolfclaw Gloves
				{ 5,  2039 }, -- Plains Ring
				{ 6,  1727 }, -- Sword of Decay
				{ 7,  776 }, -- Vendetta
				{ 8,  1976 }, -- Slaghammer
				{ 9,  1975 }, -- Pysan's Old Greatsword
				{ 10, 2549 }, -- Staff of the Shade
			},
		},
	},
}

data["ScarletMonasteryGraveyard"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21379, 24000, 23805 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Graveyard"],
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"SMGraveyard", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {20, 26, 36},
	items = {
		-- Graveyard
		{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcID = 3983,
			Level = 32,
			DisplayIDs = {{2044}},
			SubAreaID = 21379,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcID = 6490,
			Level = 33,
			DisplayIDs = {{5534}},
			SubAreaID = 24000,
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2,  7708 }, -- Necrotic Wand
				{ 3,  7731 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcID = 6488,
			Level = 33,
			DisplayIDs = {{5230}},
			specialType = "rare",
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  7691 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcID = 6489,
			Level = 33,
			DisplayIDs = {{5231}},
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcID = 4543,
			Level = 34,
			SubAreaID = 23805,
			DisplayIDs = {{11396}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
		},
		{ -- SMGTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7727 }, -- Watchman Pauldrons
				{ 3,  7728 }, -- Beguiler Robes
				{ 4,  7754 }, -- Harbinger Boots
				{ 5,  10332 }, -- Scarlet Boots
				{ 6,  2262 }, -- Mark of Kern
				{ 7,  7787 }, -- Resplendent Guardian
				{ 8,  7729 }, -- Chesterfall Musket
				{ 9,  7761 }, -- Steelclaw Reaver
				{ 10, 7752 }, -- Dreamslayer
				{ 11, 8226 }, -- The Butcher
				{ 12, 7786 }, -- Headsplitter
				{ 13, 7753 }, -- Bloodspiller
				{ 14, 7730 }, -- Cobalt Crusher
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryLibrary"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21426, 21444, 21420 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Library"],
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"SMLibrary", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {20, 29, 39},
	items = {
		-- Library
		{ -- SMHoundmasterLoksey
			name = AL["Houndmaster Loksey"],
			npcID = 3974,
			Level = 34,
			SubAreaID = 21444,
			DisplayIDs = {{2040}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7710 }, -- Loksey's Training Stick
				{ 3,  7756 }, -- Dog Training Gloves
				{ 4,  3456 }, -- Dog Whistle
			},
		},
		{ -- SMDoan
			name = AL["Arcanist Doan"],
			npcID = 6487,
			Level = 37,
			SubAreaID = 21420,
			DisplayIDs = {{5266}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  7714 }, -- Hypnotic Blade
				{ 2,  7713 }, -- Illusionary Rod
				{ 4,  7712 }, -- Mantle of Doan
				{ 5,  7711 }, -- Robe of Doan
			},
		},
		{ -- SMLTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
			},
		},
		{
			name = AL["Doan's Strongbox"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  7146 }, -- The Scarlet Key
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryArmory"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21460, 21455, 21448, 21457 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Armory"],
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"SMArmory", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {20, 32, 42},
	items = {
		-- Armory
		{ -- SMHerod
			name = AL["Herod"],
			npcID = 3975,
			Level = 40,
			SubAreaID = 21448,
			DisplayIDs = {{2041}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7719 }, -- Raging Berserker's Helm
				{ 2,  7718 }, -- Herod's Shoulder
				{ 3,  10330 }, -- Scarlet Leggings
				{ 4,  7717 }, -- Ravager
			},
		},
		{ -- SMATrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7754 }, -- Harbinger Boots
				{ 7,  10332 }, -- Scarlet Boots
				{ 8,  1992 }, -- Swampchill Fetish
				{ 9,  2262 }, -- Mark of Kern
				{ 10, 7787 }, -- Resplendent Guardian
				{ 11, 7729 }, -- Chesterfall Musket
				{ 12, 7761 }, -- Steelclaw Reaver
				{ 13, 7752 }, -- Dreamslayer
				{ 14, 8226 }, -- The Butcher
				{ 15, 7786 }, -- Headsplitter
				{ 16, 5756 }, -- Sliverblade
				{ 17, 7736 }, -- Fight Club
				{ 18, 8225 }, -- Tainted Pierce
				{ 19, 7753 }, -- Bloodspiller
				{ 20, 7730 }, -- Cobalt Crusher
				{ 21, 7757 }, -- Windweaver Staff
				{ 23, 10333 }, -- Scarlet Wristguards
				{ 24, 10329 }, -- Scarlet Belt
				{ 26, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryCathedral"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21401, 21410 },
	name = C_Map.GetAreaInfo(796) .." - ".. AL["Cathedral"],
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = {"SMCathedral", "SMEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {20, 35, 45},
	items = {
		-- Cathedral
		{ -- SMFairbanks
			name = AL["High Inquisitor Fairbanks"],
			npcID = 4542,
			Level = 40,
			DisplayIDs = {{2605}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcID = 3976,
			Level = 42,
			DisplayIDs = {{2042}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  7724 }, -- Gauntlets of Divinity
				{ 2,  10330 }, -- Scarlet Leggings
				{ 3,  7726 }, -- Aegis of the Scarlet Commander
				{ 4,  7723 }, -- Mograine's Might
			},
		},
		{ -- SMWhitemane
			name = AL["High Inquisitor Whitemane"],
			npcID = 3977,
			Level = 42,
			DisplayIDs = {{2043}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  7720 }, -- Whitemane's Chapeau
				{ 2,  7722 }, -- Triune Amulet
				{ 3,  7721 }, -- Hand of Righteousness
			},
		},
		{ -- SMCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
		},
		KEYS,
	},
}

--[[
data["ScarletMonastery"] = {
	MapID = 796,
	AtlasMapID = "ScarletMonastery",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {20, 34, 45},
	items = {
		-- Graveyard
		{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcID = 3983,
			DisplayIDs = {{2044}},
			[NORMAL_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcID = 6490,
			DisplayIDs = {{5534}},
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2,  7708 }, -- Necrotic Wand
				{ 3,  7731 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcID = 6488,
			DisplayIDs = {{5230}},
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7691 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcID = 6489,
			DisplayIDs = {{5231}},
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcID = 4543,
			DisplayIDs = {{11396}},
			[NORMAL_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
		},
		-- Library
		{ -- SMHoundmasterLoksey
			name = AL["Houndmaster Loksey"],
			npcID = 3974,
			DisplayIDs = {{2040}},
			[NORMAL_DIFF] = {
				{ 1,  7710 }, -- Loksey's Training Stick
				{ 3,  7756 }, -- Dog Training Gloves
				{ 4,  3456 }, -- Dog Whistle
			},
		},
		{ -- SMDoan
			name = AL["Arcanist Doan"],
			npcID = 6487,
			DisplayIDs = {{5266}},
			[NORMAL_DIFF] = {
				{ 1,  7714 }, -- Hypnotic Blade
				{ 2,  7713 }, -- Illusionary Rod
				{ 4,  7712 }, -- Mantle of Doan
				{ 5,  7711 }, -- Robe of Doan
			},
		},
		-- Armory
		{ -- SMHerod
			name = AL["Herod"],
			npcID = 3975,
			DisplayIDs = {{2041}},
			[NORMAL_DIFF] = {
				{ 1,  7719 }, -- Raging Berserker's Helm
				{ 2,  7718 }, -- Herod's Shoulder
				{ 3,  10330 }, -- Scarlet Leggings
				{ 4,  7717 }, -- Ravager
			},
		},
		-- Cathedral
		{ -- SMFairbanks
			name = AL["High Inquisitor Fairbanks"],
			npcID = 4542,
			DisplayIDs = {{2605}},
			[NORMAL_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcID = 3976,
			DisplayIDs = {{2042}},
			[NORMAL_DIFF] = {
				{ 1,  7724 }, -- Gauntlets of Divinity
				{ 2,  10330 }, -- Scarlet Leggings
				{ 3,  7726 }, -- Aegis of the Scarlet Commander
				{ 4,  7723 }, -- Mograine's Might
			},
		},
		{ -- SMWhitemane
			name = AL["High Inquisitor Whitemane"],
			npcID = 3977,
			DisplayIDs = {{2043}},
			[NORMAL_DIFF] = {
				{ 1,  7720 }, -- Whitemane's Chapeau
				{ 2,  7722 }, -- Triune Amulet
				{ 3,  7721 }, -- Hand of Righteousness
			},
		},


		{ -- SMGTrash
			name = AL["Graveyard"] .." ".. AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7727 }, -- Watchman Pauldrons
				{ 3,  7728 }, -- Beguiler Robes
				{ 4,  7754 }, -- Harbinger Boots
				{ 5,  10332 }, -- Scarlet Boots
				{ 6,  2262 }, -- Mark of Kern
				{ 7,  7787 }, -- Resplendent Guardian
				{ 8,  7729 }, -- Chesterfall Musket
				{ 9,  7761 }, -- Steelclaw Reaver
				{ 10, 7752 }, -- Dreamslayer
				{ 11, 8226 }, -- The Butcher
				{ 12, 7786 }, -- Headsplitter
				{ 13, 7753 }, -- Bloodspiller
				{ 14, 7730 }, -- Cobalt Crusher
			},
		},
		{ -- SMLTrash
			name = AL["Library"] .." ".. AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
			},
		},
		{ -- SMATrash
			name = AL["Armory"] .." ".. AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7754 }, -- Harbinger Boots
				{ 7,  10332 }, -- Scarlet Boots
				{ 8,  1992 }, -- Swampchill Fetish
				{ 9,  2262 }, -- Mark of Kern
				{ 10, 7787 }, -- Resplendent Guardian
				{ 11, 7729 }, -- Chesterfall Musket
				{ 12, 7761 }, -- Steelclaw Reaver
				{ 13, 7752 }, -- Dreamslayer
				{ 14, 8226 }, -- The Butcher
				{ 15, 7786 }, -- Headsplitter
				{ 16, 5756 }, -- Sliverblade
				{ 17, 7736 }, -- Fight Club
				{ 18, 8225 }, -- Tainted Pierce
				{ 19, 7753 }, -- Bloodspiller
				{ 20, 7730 }, -- Cobalt Crusher
				{ 21, 7757 }, -- Windweaver Staff
				{ 23, 10333 }, -- Scarlet Wristguards
				{ 24, 10329 }, -- Scarlet Belt
				{ 26, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		{ -- SMCTrash
			name = AL["Cathedral"] .." ".. AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
		},
		KEYS,
	},
}
]]--

data["RazorfenDowns"] = {
	MapID = 722,
	InstanceID = 129,
	AtlasMapID = "RazorfenDowns",
	AtlasMapFile = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {35, 37, 46},
	items = {
		{ -- RFDTutenkash
			name = AL["Tuten'kash"],
			npcID = 7355,
			Level = 40,
			DisplayIDs = {{7845}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  10776 }, -- Silky Spider Cape
				{ 2,  10775 }, -- Carapace of Tuten'kash
				{ 3,  10777 }, -- Arachnid Gloves
			},
		},
		{ -- RFDLadyF
			name = AL["Lady Falther'ess"],
			npcID = 14686,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  23178 }, -- Mantle of Lady Falther'ess
				{ 2,  23177 }, -- Lady Falther'ess' Finger
			},
		},
		{ -- RFDMordreshFireEye
			name = AL["Mordresh Fire Eye"],
			npcID = 7357,
			Level = 39,
			DisplayIDs = {{8055}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  10769 }, -- Glowing Eye of Mordresh
				{ 2,  10771 }, -- Deathmage Sash
				{ 3,  10770 }, -- Mordresh's Lifeless Skull
			},
		},
		{ -- RFDGlutton
			name = AL["Glutton"],
			npcID = 8567,
			Level = 40,
			DisplayIDs = {{7864}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  10774 }, -- Fleshhide Shoulders
				{ 3,  10772 }, -- Glutton's Cleaver
			},
		},
		{ -- RFDRagglesnout
			name = AL["Ragglesnout"],
			npcID = 7354,
			Level = 40,
			DisplayIDs = {{11382}},
			AtlasMapBossID = 5,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  10768 }, -- Boar Champion's Belt
				{ 2,  10767 }, -- Savage Boar's Guard
				{ 3,  10758 }, -- X'caliboar
			},
		},
		{ -- RFDAmnennar
			name = AL["Amnennar the Coldbringer"],
			npcID = 7358,
			Level = 41,
			DisplayIDs = {{7971}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  10763 }, -- Icemetal Barbute
				{ 2,  10762 }, -- Robes of the Lich
				{ 3,  10764 }, -- Deathchill Armor
				{ 4,  10761 }, -- Coldrage Dagger
				{ 6,  10765 }, -- Bonefingers
			},
		},
		{ -- RFDPlaguemaw
			name = AL["Plaguemaw the Rotting"],
			npcID = 7356,
			Level = 40,
			DisplayIDs = {{6124}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  10766 }, -- Plaguerot Sprig
				{ 3,  10760 }, -- Swine Fists
			},
		},
		{ -- RFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10574 }, -- Corpseshroud
				{ 2,  10581 }, -- Death's Head Vestment
				{ 3,  10583 }, -- Quillward Harness
				{ 4,  10584 }, -- Stormgale Fists
				{ 5,  10578 }, -- Thoughtcast Boots
				{ 6,  10582 }, -- Briar Tredders
				{ 7,  10572 }, -- Freezing Shard
				{ 8,  10567 }, -- Quillshooter
				{ 9,  10571 }, -- Ebony Boneclub
				{ 10, 10570 }, -- Manslayer
				{ 11, 10573 }, -- Boneslasher
			},
		},
		{ -- RFDHenryStern
			name = AL["Henry Stern"],
			npcID = 8696,
			DisplayIDs = {{8029}},
			AtlasMapBossID = 2,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  3826 }, -- Mighty Troll's Blood Potion
				{ 2,  10841 }, -- Goldthorn Tea
			},
		},
	},
}

data["Uldaman"] = {
	MapID = 1337, -- just no...
	InstanceID = 70,
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	AtlasMapFile = {"Uldaman", "UldamanEnt"},
	LevelRange = {30, 41, 51},
	items = {
		{ -- UldEric
			name = AL["Eric \"The Swift\""],
			npcID = 6907,
			Level = 40,
			DisplayIDs = {{5708}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9394 }, -- Horned Viking Helmet
				{ 3,  9398 }, -- Worn Running Boots
				{ 5,  2459 }, -- Swiftness Potion
			},
		},
		{ -- UldBaelog
			name = AL["Baelog"],
			npcID = 6906,
			Level = 41,
			DisplayIDs = {{5710}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9401 }, -- Nordic Longshank
				{ 3,  9399 }, -- Precision Arrow
				{ 5,  9400 }, -- Baelog's Shortbow
			},
		},
		{ -- UldOlaf
			name = AL["Olaf"],
			npcID = 6908,
			Level = 40,
			DisplayIDs = {{5709}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9404 }, -- Olaf's All Purpose Shield
				{ 3,  9403 }, -- Battered Viking Shield
				{ 4,  1177 }, -- Oil of Olaf
			},
		},
		{ -- UldRevelosh
			name = AL["Revelosh"],
			npcID = 6910,
			Level = 40,
			DisplayIDs = {{5945}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  9389 }, -- Revelosh's Spaulders
				{ 2,  9388 }, -- Revelosh's Armguards
				{ 3,  9390 }, -- Revelosh's Gloves
				{ 4,  9387 }, -- Revelosh's Boots
				{ 6,  7741 }, -- The Shaft of Tsol
			},
		},
		{ -- UldIronaya
			name = AL["Ironaya"],
			npcID = 7228,
			Level = 40,
			DisplayIDs = {{6089}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  9409 }, -- Ironaya's Bracers
				{ 2,  9407 }, -- Stoneweaver Leggings
				{ 3,  9408 }, -- Ironshod Bludgeon
			},
		},
		{ -- UldAncientStoneKeeper
			name = AL["Ancient Stone Keeper"],
			npcID = 7206,
			Level = 44,
			DisplayIDs = {{10798}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  9410 }, -- Cragfists
				{ 3,  9411 }, -- Rockshard Pauldrons
			},
		},
		{ -- UldGalgannFirehammer
			name = AL["Galgann Firehammer"],
			npcID = 7291,
			Level = 45,
			DisplayIDs = {{6059}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11310 }, -- Flameseer Mantle
				{ 2,  9412 }, -- Galgann's Fireblaster
				{ 4,  11311 }, -- Emberscale Cape
				{ 5,  9419 }, -- Galgann's Firehammer
			},
		},
		{ -- UldGrimlok
			name = AL["Grimlok"],
			npcID = 4854,
			Level = 45,
			DisplayIDs = {{11165}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  9415 }, -- Grimlok's Tribal Vestments
				{ 2,  9416 }, -- Grimlok's Charge
				{ 4,  9414 }, -- Oilskin Leggings
			},
		},
		{ -- UldArchaedas
			name = AL["Archaedas"],
			npcID = 2748,
			Level = 47,
			DisplayIDs = {{5988}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  11118 }, -- Archaedic Stone
				{ 2,  9413 }, -- The Rockpounder
				{ 3,  9418 }, -- Stoneslayer
			},
		},
		{ -- UldTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9431 }, -- Papal Fez
				{ 2,  9429 }, -- Miner's Hat of the Deep
				{ 3,  9420 }, -- Adventurer's Pith Helmet
				{ 4,  9430 }, -- Spaulders of a Lost Age
				{ 5,  9397 }, -- Energy Cloak
				{ 6,  9406 }, -- Spirewind Fetter
				{ 7,  9428 }, -- Unearthed Bands
				{ 8,  9432 }, -- Skullplate Bracers
				{ 9,  9396 }, -- Legguards of the Vault
				{ 10, 9393 }, -- Beacon of Hope
				{ 12, 7666 }, -- Shattered Necklace
				--{ 13, 7673 }, -- Talvash's Enhancing Necklace
				{ 16, 9381 }, -- Earthen Rod
				{ 17, 9426 }, -- Monolithic Bow
				{ 18, 9422 }, -- Shadowforge Bushmaster
				{ 19, 9465 }, -- Digmaster 5000
				{ 20, 9384 }, -- Stonevault Shiv
				{ 21, 9386 }, -- Excavator's Brand
				{ 22, 9427 }, -- Stonevault Bonebreaker
				{ 23, 9392 }, -- Annealed Blade
				{ 24, 9424 }, -- Ginn-su Sword
				{ 25, 9383 }, -- Obsidian Cleaver
				{ 26, 9425 }, -- Pendulum of Doom
				{ 27, 9423 }, -- The Jackhammer
				{ 28, 9391 }, -- The Shoveler
			},
		},
		{ -- UldBaelogsChest
			name = AL["Baelog's Chest"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  7740 }, -- Gni'kiv Medallion
			},
		},
		{ -- UldShadowforgeCache
			name = AL["Shadowforge Cache"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  7669 }, -- Shattered Necklace Ruby
			},
		},
		{ -- UldTabletofWill
			name = AL["Tablet of Will"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  5824 }, -- Tablet of Will
			},
		},
	},
}

data["Zul'Farrak"] = {
	MapID = 1176,
	InstanceID = 209,
	AtlasMapID = "Zul'Farrak",
	AtlasMapFile = "ZulFarrak",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {39, 42, 46},
	items = {
		{ -- ZFAntusul
			name = AL["Antu'sul"],
			npcID = 8127,
			Level = 48,
			DisplayIDs = {{7353}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  9640 }, -- Vice Grips
				{ 2,  9641 }, -- Lifeblood Amulet
				{ 3,  9639 }, -- The Hand of Antu'sul
				{ 5,  9379 }, -- Sang'thraze the Deflector
			},
		},
		{ -- ZFThekatheMartyr
			name = AL["Theka the Martyr"],
			npcID = 7272,
			Level = {45, 46},
			DisplayIDs = {{6696}},
			AtlasMapBossID = 2,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  10660 }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFWitchDoctorZumrah
			name = AL["Witch Doctor Zum'rah"],
			npcID = 7271,
			Level = 46,
			DisplayIDs = {{6434}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18083 }, -- Jumanza Grips
				{ 2,  18082 }, -- Zum'rah's Vexing Cane
			},
		},
		{ -- ZFNekrumGutchewer
			name = AL["Nekrum Gutchewer"],
			npcID = 7796,
			Level = {45, 46},
			DisplayIDs = {{6690}},
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  9471 }, -- Nekrum's Medallion
			},
		},
		{ -- ZFSezzziz
			name = AL["Shadowpriest Sezz'ziz"],
			npcID = 7275,
			Level = 47,
			DisplayIDs = {{6441}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  9470 }, -- Bad Mojo Mask
				{ 2,  9473 }, -- Jinxed Hoodoo Skin
				{ 3,  9474 }, -- Jinxed Hoodoo Kilt
				{ 4,  9475 }, -- Diabolic Skiver
			},
		},
		{ -- ZFDustwraith
			name = AL["Dustwraith"],
			npcID = 10081,
			Level = 47,
			DisplayIDs = {{9292}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  12471 }, -- Desertwalker Cane
			},
		},
		{ -- ZFSandfury
			name = AL["Sandfury Executioner"],
			npcID = 7274,
			Level = 46,
			DisplayIDs = {{6440}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  8444 }, -- Executioner's Key
			},
		},
		{ -- ZFSergeantBly
			name = AL["Sergeant Bly"],
			npcID = 7604,
			Level = 45,
			DisplayIDs = {{6433}},
			AtlasMapBossID = 5,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  8548 }, -- Divino-matic Rod
			},
		},
		{ -- ZFHydromancerVelratha
			name = AL["Hydromancer Velratha"],
			npcID = 7795,
			Level = 46,
			DisplayIDs = {{6685}},
			AtlasMapBossID = 6,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  9234 }, -- Tiara of the Deep
				{ 2,  10661 }, -- Second Mosh'aru Tablet
			},
		},
		{ -- ZFGahzrilla
			name = AL["Gahz'rilla"],
			npcID = 7273,
			Level = 46,
			DisplayIDs = {{7271}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  9469 }, -- Gahz'rilla Scale Armor
				{ 3,  9467 }, -- Gahz'rilla Fang
			},
		},
		{ -- ZFChiefUkorzSandscalp
			name = AL["Chief Ukorz Sandscalp"],
			npcID = 7267,
			Level = 48,
			DisplayIDs = {{6439}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  9479 }, -- Embrace of the Lycan
				{ 2,  9476 }, -- Big Bad Pauldrons
				{ 3,  9478 }, -- Ripsaw
				{ 4,  9477 }, -- The Chief's Enforcer
				{ 6,  11086 }, -- Jang'thraze the Protector
			},
		},
		{ -- ZFZerillis
			name = AL["Zerillis"],
			npcID = 10082,
			Level = 45,
			DisplayIDs = {{9293}},
			AtlasMapBossID = 8,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  12470 }, -- Sandstalker Ankleguards
			},
		},
		{ -- ZFTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9512 }, -- Blackmetal Cape
				{ 2,  9484 }, -- Spellshock Leggings
				{ 3,  862 }, -- Runed Ring
				{ 4,  6440 }, -- Brainlash
				{ 5,  9483 }, -- Flaming Incinerator
				{ 6,  2040 }, -- Troll Protector
				{ 7,  5616 }, -- Gutwrencher
				{ 8,  9511 }, -- Bloodletter Scalpel
				{ 9,  9481 }, -- The Minotaur
				{ 10, 9480 }, -- Eyegouger
				{ 11, 9482 }, -- Witch Doctor's Cane
				{ 13, 9243 }, -- Shriveled Heart
			},
		},
	},
}

data["Maraudon"] = {
	MapID = 2100,
	InstanceID = 349,
	AtlasMapID = "Maraudon",
	AtlasMapFile = {"Maraudon", "MaraudonEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {25, 46, 55},
	items = {
		{ -- MaraKhanVeng
			name = AL["Veng"],
			npcID = 13738,
			DisplayIDs = {{9418}},
			AtlasMapBossID = 1,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17765 }, -- Gem of the Fifth Khan
			},
		},
		{ -- MaraNoxxion
			name = AL["Noxxion"],
			npcID = 13282,
			Level = 48,
			DisplayIDs = {{11172}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  17746 }, -- Noxxion's Shackles
				{ 2,  17744 }, -- Heart of Noxxion
				{ 3,  17745 }, -- Noxious Shooter
			},
		},
		{ -- MaraRazorlash
			name = AL["Razorlash"],
			npcID = 12258,
			Level = 48,
			DisplayIDs = {{12389}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  17749 }, -- Phytoskin Spaulders
				{ 2,  17748 }, -- Vinerot Sandals
				{ 4,  17750 }, -- Chloromesh Girdle
				{ 5,  17751 }, -- Brusslehide Leggings
			},
		},
		{ -- MaraKhanMaraudos
			name = AL["Maraudos"],
			npcID = 13739,
			DisplayIDs = {{9441}},
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17764 }, -- Gem of the Fourth Khan
			},
		},
		{ -- MaraLordVyletongue
			name = AL["Lord Vyletongue"],
			npcID = 12236,
			Level = 47,
			DisplayIDs = {{12334}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  17755 }, -- Satyrmane Sash
				{ 2,  17754 }, -- Infernal Trickster Leggings
				{ 3,  17752 }, -- Satyr's Lash
			},
		},
		{ -- MaraMeshlok
			name = AL["Meshlok the Harvester"],
			npcID = 12237,
			Level = 48,
			DisplayIDs = {{9014}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  17767 }, -- Bloomsprout Headpiece
				{ 2,  17741 }, -- Nature's Embrace
				{ 3,  17742 }, -- Fungus Shroud Armor
			},
		},
		{ -- MaraCelebras
			name = AL["Celebras the Cursed"],
			npcID = 12225,
			Level = 49,
			DisplayIDs = {{12350}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  17740 }, -- Soothsayer's Headdress
				{ 2,  17739 }, -- Grovekeeper's Drape
				{ 3,  17738 }, -- Claw of Celebras
			},
		},
		{ -- MaraLandslide
			name = AL["Landslide"],
			npcID = 12203,
			Level = 50,
			DisplayIDs = {{12293}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  17734 }, -- Helm of the Mountain
				{ 2,  17736 }, -- Rockgrip Gauntlets
				{ 3,  17737 }, -- Cloud Stone
				{ 4,  17943 }, -- Fist of Stone
			},
		},
		{ -- MaraTinkererGizlock
			name = AL["Tinkerer Gizlock"],
			npcID = 13601,
			Level = 50,
			DisplayIDs = {{7125}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  17718 }, -- Gizlock's Hypertech Buckler
				{ 2,  17717 }, -- Megashot Rifle
				{ 3,  17719 }, -- Inventor's Focal Sword
			},
		},
		{ -- MaraRotgrip
			name = AL["Rotgrip"],
			npcID = 13596,
			Level = 50,
			DisplayIDs = {{13589}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  17732 }, -- Rotgrip Mantle
				{ 2,  17728 }, -- Albino Crocscale Boots
				{ 3,  17730 }, -- Gatorbite Axe
			},
		},
		{ -- MaraPrincessTheradras
			name = AL["Princess Theradras"],
			npcID = 12201,
			Level = 51,
			DisplayIDs = {{12292}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  17780 }, -- Blade of Eternal Darkness
				{ 3,  17715 }, -- Eye of Theradras
				{ 4,  17707 }, -- Gemshard Heart
				{ 5,  17714 }, -- Bracers of the Stone Princess
				{ 6,  17711 }, -- Elemental Rockridge Leggings
				{ 7,  17713 }, -- Blackstone Ring
				{ 8,  17710 }, -- Charstone Dirk
				{ 9,  17766 }, -- Princess Theradras' Scepter
			},
		},
		{ -- MaraNamelesProphet
			name = AL["The Nameless Prophet"],
			npcID = 13718,
			DisplayIDs = {{9426}},
			AtlasMapFile = "MaraudonEnt",
			AtlasMapBossID = "*A",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17757 }, -- Amulet of Spirits
			},
		},
		{ -- MaraKhanMagra
			name = AL["Magra"],
			npcID = 13740,
			DisplayIDs = {{9433}},
			AtlasMapFile = "MaraudonEnt",
			AtlasMapBossID = "*1",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17763 }, -- Gem of the Third Khan
			},
		},
		{ -- MaraKhanGelk
			name = AL["Gelk"],
			npcID = 13741,
			DisplayIDs = {{9427}},
			AtlasMapFile = "MaraudonEnt",
			AtlasMapBossID = "*2",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17762 }, -- Gem of the Second Khan
			},
		},
		{ -- MaraKhanKolk
			name = AL["Kolk"],
			npcID = 13742,
			DisplayIDs = {{4860}},
			AtlasMapFile = "MaraudonEnt",
			AtlasMapBossID = "*3",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  17761 }, -- Gem of the First Khan
			},
		},
	},
}

data["TheTempleOfAtal'Hakkar"] = {
	MapID = 1477,
	InstanceID = 109,
	AtlasMapID = "TheTempleOfAtal'Hakkar",
	AtlasMapFile = { "TheSunkenTemple", "TheSunkenTempleEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {45, 50, 56},
	items = {
		{ -- STBalconyMinibosses
			name = AL["Balcony Minibosses"],
			npcID = {5716, 5712, 5717, 5714, 5715, 5713},
			Level = {51, 52},
			DisplayIDs = {{6701},{6699},{6707},{6700},{6702},{6698}},
			AtlasMapBossID = "C",
			[NORMAL_DIFF] = {
				{ 1,  10783 }, -- Atal'ai Spaulders
				{ 2,  10784 }, -- Atal'ai Breastplate
				{ 3,  10787 }, -- Atal'ai Gloves
				{ 5,  10788 }, -- Atal'ai Girdle
				{ 6,  10785 }, -- Atal'ai Leggings
				{ 7,  10786 }, -- Atal'ai Boots
				{ 9,  20606 }, -- Amber Voodoo Feather
				{ 10, 20607 }, -- Blue Voodoo Feather
				{ 11, 20608 }, -- Green Voodoo Feather
			},
		},
		{ -- STAtalalarion
			name = AL["Atal'alarion"],
			npcID = 8580,
			Level = 50,
			DisplayIDs = {{7873}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  10800 }, -- Darkwater Bracers
				{ 2,  10798 }, -- Atal'alarion's Tusk Ring
				{ 3,  10799 }, -- Headspike
			},
		},
		{ -- STSpawnOfHakkar
			name = AL["Spawn of Hakkar"],
			npcID = 5708,
			Level = 51,
			DisplayIDs = {{4065}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  10801 }, -- Slitherscale Boots
				{ 3,  10802 }, -- Wingveil Cloak
			},
		},
		{ -- STAvatarofHakkar
			name = AL["Avatar of Hakkar"],
			npcID = 8443,
			DisplayIDs = {{8053}},
			AtlasMapBossID = 3,
			Level = 48,
			[NORMAL_DIFF] = {
				{ 1,  12462 }, -- Embrace of the Wind Serpent
				{ 3,  10843 }, -- Featherskin Cape
				{ 4,  10845 }, -- Warrior's Embrace
				{ 5,  10842 }, -- Windscale Sarong
				{ 6,  10846 }, -- Bloodshot Greaves
				{ 7,  10838 }, -- Might of Hakkar
				{ 8,  10844 }, -- Spire of Hakkar
			},
		},
		{ -- STJammalan
			name = AL["Jammal'an the Prophet"],
			npcID = 5710,
			Level = 54,
			DisplayIDs = {{6708}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  10806 }, -- Vestments of the Atal'ai Prophet
				{ 2,  10808 }, -- Gloves of the Atal'ai Prophet
				{ 3,  10807 }, -- Kilt of the Atal'ai Prophet
			},
		},
		{ -- STOgom
			name = AL["Ogom the Wretched"],
			npcID = 5711,
			Level = 53,
			DisplayIDs = {{6709}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  10805 }, -- Eater of the Dead
				{ 2,  10803 }, -- Blade of the Wretched
				{ 3,  10804 }, -- Fist of the Damned
			},
		},
		{ -- STDreamscythe
			name = AL["Dreamscythe"],
			npcID = 5721,
			Level = 53,
			DisplayIDs = {{7553}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  12465 }, -- Nightfall Drape
				{ 2,  12466 }, -- Dawnspire Cord
				{ 3,  12464 }, -- Bloodfire Talons
				{ 4,  10797 }, -- Firebreather
				{ 5,  12463 }, -- Drakefang Butcher
				{ 6,  12243 }, -- Smoldering Claw
				{ 7,  10795 }, -- Drakeclaw Band
				{ 8,  10796 }, -- Drakestone
			},
		},
		{ -- STWeaver
			name = AL["Weaver"],
			npcID = 5720,
			Level = 51,
			DisplayIDs = {{6375}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  12465 }, -- Nightfall Drape
				{ 2,  12466 }, -- Dawnspire Cord
				{ 3,  12464 }, -- Bloodfire Talons
				{ 4,  10797 }, -- Firebreather
				{ 5,  12463 }, -- Drakefang Butcher
				{ 6,  12243 }, -- Smoldering Claw
				{ 7,  10795 }, -- Drakeclaw Band
				{ 8,  10796 }, -- Drakestone
			},
		},
		{ -- STHazzas
			name = AL["Hazzas"],
			npcID = 5722,
			Level = 53,
			DisplayIDs = {{9584}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  12465 }, -- Nightfall Drape
				{ 2,  12466 }, -- Dawnspire Cord
				{ 3,  12464 }, -- Bloodfire Talons
				{ 4,  10797 }, -- Firebreather
				{ 5,  12463 }, -- Drakefang Butcher
				{ 6,  12243 }, -- Smoldering Claw
				{ 7,  10795 }, -- Drakeclaw Band
				{ 8,  10796 }, -- Drakestone
			},
		},
		{ -- STMorphaz
			name = AL["Morphaz"],
			npcID = 5719,
			Level = 52,
			DisplayIDs = {{7975}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  12465 }, -- Nightfall Drape
				{ 2,  12466 }, -- Dawnspire Cord
				{ 3,  12464 }, -- Bloodfire Talons
				{ 4,  10797 }, -- Firebreather
				{ 5,  12463 }, -- Drakefang Butcher
				{ 6,  12243 }, -- Smoldering Claw
				{ 7,  10795 }, -- Drakeclaw Band
				{ 8,  10796 }, -- Drakestone
			},
		},
		{ -- STEranikus
			name = AL["Shade of Eranikus"],
			npcID = 5709,
			Level = 55,
			DisplayIDs = {{7806}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  10847 }, -- Dragon's Call
				{ 3,  10833 }, -- Horns of Eranikus
				{ 4,  10829 }, -- Dragon's Eye
				{ 5,  10836 }, -- Rod of Corrosion
				{ 6,  10835 }, -- Crest of Supremacy
				{ 7,  10837 }, -- Tooth of Eranikus
				{ 8,  10828 }, -- Dire Nail
				{ 10, 10454 }, -- Essence of Eranikus
			},
		},
		{ -- STTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10630 }, -- Soulcatcher Halo
				{ 2,  10632 }, -- Slimescale Bracers
				{ 3,  10631 }, -- Murkwater Gauntlets
				{ 4,  10633 }, -- Silvershell Leggings
				{ 5,  10629 }, -- Mistwalker Boots
				{ 6,  10634 }, -- Mindseye Circle
				{ 7,  10624 }, -- Stinging Bow
				{ 8,  10623 }, -- Winter's Bite
				{ 9,  10625 }, -- Stealthblade
				{ 10, 10626 }, -- Ragehammer
				{ 11, 10628 }, -- Deathblow
				{ 12, 10627 }, -- Bludgeon of the Grinning Dog
				{ 16, 10782 }, -- Hakkari Shroud
				{ 17, 10781 }, -- Hakkari Breastplate
				{ 18, 10780 }, -- Mark of Hakkar
				{ 20, 16216 }, -- Formula: Enchant Cloak - Greater Resistance
				{ 21, 15733 }, -- Pattern: Green Dragonscale Leggings
			},
		},
	},
}

data["BlackrockDepths"] = {
	MapID = 1584,
	InstanceID = 230,
	SubAreaIDs = { 26758, 26761, 26747, 26733, 26755, 26740, 26751, 26759, 26735, 26769, 26768, 26766, 26781, 26765, 26764, 26742, 26750, 26745, 26784, 26749 },
	AtlasMapID = "BlackrockDepths",
	AtlasMapFile = {"BlackrockDepths", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {42, 52, 60},
	items = {
		{ -- BRDLordRoccor
			name = AL["Lord Roccor"],
			npcID = 9025,
			Level = 51,
			SubAreaID = 26735,
			DisplayIDs = {{5781}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  22234 }, -- Mantle of Lost Hope
				{ 2,  11632 }, -- Earthslag Shoulders
				{ 3,  11631 }, -- Stoneshell Guard
				{ 4,  22397 }, -- Idol of Ferocity
				{ 5,  11630 }, -- Rockshard Pellets
				{ 7,  11813 }, -- Formula: Smoking Heart of the Mountain
				--{ 8,  11811 }, -- Smoking Heart of the Mountain
			},
		},
		{ -- BRDHighInterrogatorGerstahn
			name = AL["High Interrogator Gerstahn "],
			npcID = 9018,
			Level = 52,
			SubAreaID = 26733,
			DisplayIDs = {{8761}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  11623 }, -- Spritecaster Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4,  11625 }, -- Enthralled Sphere
				{ 16,  11140 }, -- Prison Cell Key
			},
		},
		{ -- BRDHoundmaster
			name = AL["Houndmaster Grebmar"],
			npcID = 9319,
			Level = 52,
			SubAreaID = 26735,
			DisplayIDs = {{9212}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11627 }, -- Fleetfoot Greaves
				{ 3,  11628 }, -- Houndmaster's Bow
				{ 4,  11629 }, -- Houndmaster's Rifle
			},
		},
		{ -- BRDGorosh
			name = AL["Gorosh the Dervish"],
			npcID = 9027,
			Level = 56,
			SubAreaID = 26742,
			DisplayIDs = {{8760}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11726 }, -- Savage Gladiator Chain
				{ 2,  11729 }, -- Savage Gladiator Helm
				{ 3,  11730 }, -- Savage Gladiator Grips
				{ 4,  11728 }, -- Savage Gladiator Leggings
				{ 5,  11731 }, -- Savage Gladiator Greaves
				{ 7,  22271 }, -- Leggings of Frenzied Magic
				{ 8,  22257 }, -- Bloodclot Band
				{ 9,  22266 }, -- Flarethorn
			},
		},
		{ -- BRDGrizzle
			name = AL["Grizzle"],
			npcID = 9028,
			Level = 54,
			DisplayIDs = {{7873}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11722 }, -- Dregmetal Spaulders
				{ 2,  11703 }, -- Stonewall Girdle
				{ 3,  22270 }, -- Entrenching Boots
				{ 4,  11702 }, -- Grizzle's Skinner
				{ 6,  11610 }, -- Plans: Dark Iron Pulverizer
				--{ 2,  11608 }, -- Dark Iron Pulverizer
			},
		},
		{ -- BRDEviscerator
			name = AL["Eviscerator"],
			npcID = 9029,
			Level = 54,
			DisplayIDs = {{523}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11685 }, -- Splinthide Shoulders
				{ 2,  11679 }, -- Rubicund Armguards
				{ 4,  11686 }, -- Girdle of Beastial Fury
			},
		},
		{ -- BRDOkthor
			name = AL["Ok'thor the Breaker"],
			npcID = 9030,
			Level = 53,
			DisplayIDs = {{11538}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11665 }, -- Ogreseer Fists
				{ 2,  11662 }, -- Ban'thok Sash
				{ 3,  11824 }, -- Cyclopean Band
			},
		},
		{ -- BRDAnubshiah
			name = AL["Anub'shiah"],
			npcID = 9031,
			Level = 54,
			DisplayIDs = {{3004}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11678 }, -- Carapace of Anub'shiah
				{ 2,  11677 }, -- Graverot Cape
				{ 3,  11675 }, -- Shadefiend Boots
			},
		},
		{ -- BRDHedrum
			name = AL["Hedrum the Creeper"],
			npcID = 9032,
			Level = 53,
			DisplayIDs = {{8271}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  11633 }, -- Spiderfang Carapace
				{ 2,  11634 }, -- Silkweb Gloves
				{ 3,  11635 }, -- Hookfang Shanker
			},
		},
		-- RING END
		{ -- BRDPyromancerLoregrain
			name = AL["Pyromancer Loregrain"],
			npcID = 9024,
			Level = 52,
			SubAreaID = 26745,
			DisplayIDs = {{8762}},
			AtlasMapBossID = 7,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  11747 }, -- Flamestrider Robes
				{ 2,  11749 }, -- Searingscale Leggings
				{ 3,  11748 }, -- Pyric Caduceus
				{ 4,  11750 }, -- Kindling Stave
				{ 6,  11207 }, -- Formula: Enchant Weapon - Fiery Weapon
			},
		},
		{ -- BRDTheVault
			name = AL["Dark Coffer"],
			SubAreaID = 26758,
			npcID = {9438, 9442, 9443, 9439, 9437, 9441},
			DisplayIDs = {{8592},{8595},{8596},{8593},{8591},{8594}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dark Keeper"], nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 5, "INV_Box_01", nil, AL["Secret Safe"], nil },
				{ 6,  22256 }, -- Mana Shaping Handwraps
				{ 7,  22205 }, -- Black Steel Bindings
				{ 8,  22255 }, -- Magma Forged Band
				{ 9,  22254 }, -- Wand of Eternal Light
				{ 10,  11923 }, -- The Hammer of Grace
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
				{ 20, "INV_Box_01", nil, AL["Dark Coffer"], nil },
				{ 21, 11752 }, -- Black Blood of the Tormented
				{ 22, 11751 }, -- Burning Essence
				{ 23, 11753 }, -- Eye of Kajal
			},
		},
		{ -- BRDWarderStilgiss
			name = AL["Warder Stilgiss"],
			npcID = 9041,
			Level = 56,
			SubAreaID = 26758,
			DisplayIDs = {{9089}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11782 }, -- Boreal Mantle
				{ 2,  22241 }, -- Dark Warder's Pauldrons
				{ 3,  11783 }, -- Chillsteel Girdle
				{ 4,  11784 }, -- Arbiter's Blade
			},
		},
		{ -- BRDVerek
			name = AL["Verek"],
			npcID = 9042,
			Level = 55,
			SubAreaID = 26758,
			DisplayIDs = {{9019}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  11755 }, -- Verek's Collar
				{ 2,  22242 }, -- Verek's Leash
			},
		},
		{ -- BRDWatchmanDoomgrip
			name = AL["Watchman Doomgrip"],
			npcID = 9476,
			Level = 55,
			SubAreaID = 26758,
			DisplayIDs = {{8655}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  22205 }, -- Black Steel Bindings
				{ 2,  22255 }, -- Magma Forged Band
				{ 3,  22256 }, -- Mana Shaping Handwraps
				{ 4,  22254 }, -- Wand of Eternal Light
			},
		},
		{ -- BRDFineousDarkvire
			name = AL["Fineous Darkvire"],
			npcID = 9056,
			Level = 54,
			SubAreaID = 26759,
			DisplayIDs = {{8704}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  11839 }, -- Chief Architect's Monocle
				{ 2,  22223 }, -- Foreman's Head Protector
				{ 3,  11842 }, -- Lead Surveyor's Mantle
				{ 4,  11841 }, -- Senior Designer's Pantaloons
				{ 6,  11840 }, -- Master Builder's Shirt
			},
		},
		{ -- BRDLordIncendius
			name = AL["Lord Incendius"],
			npcID = 9017,
			Level = 55,
			SubAreaID = 26750,
			DisplayIDs = {{1204}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  11766 }, -- Flameweave Cuffs
				{ 2,  11764 }, -- Cinderhide Armsplints
				{ 3,  11765 }, -- Pyremail Wristguards
				{ 4,  11767 }, -- Emberplate Armguards
				{ 6,  19268 }, -- Ace of Elementals
				{ 8,  11768 }, -- Incendic Bracers
			},
		},
		{ -- BRDBaelGar
			name = AL["Bael'Gar"],
			npcID = 9016,
			Level = 54,
			SubAreaID = 26747,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  11807 }, -- Sash of the Burning Heart
				{ 2,  11802 }, -- Lavacrest Leggings
				{ 3,  11805 }, -- Rubidium Hammer
				{ 4,  11803 }, -- Force of Magma
			},
		},
		{ -- BRDGeneralAngerforge
			name = AL["General Angerforge"],
			npcID = 9033,
			Level = 57,
			SubAreaID = 26749,
			DisplayIDs = {{8756}},
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 1,  11820 }, -- Royal Decorated Armor
				{ 2,  11821 }, -- Warstrife Leggings
				{ 3,  11815 }, -- Hand of Justice
				{ 4,  11817 }, -- Lord General's Sword
				{ 5,  11816 }, -- Angerforge's Battle Axe
				{ 6,  11841 }, -- Senior Designer's Pantaloons
			},
		},
		{ -- BRDGolemLordArgelmach
			name = AL["Golem Lord Argelmach"],
			npcID = 8983,
			Level = 57,
			SubAreaID = 26781,
			DisplayIDs = {{8759}},
			AtlasMapBossID = 14,
			[NORMAL_DIFF] = {
				{ 1,  11823 }, -- Luminary Kilt
				{ 2,  11822 }, -- Omnicast Boots
				{ 3,  11669 }, -- Naglering
				{ 4,  11819 }, -- Second Wind
			},
		},
		{ -- BRDGuzzler
			name = AL["Guzzler"],
			SubAreaID = 26751,
			npcID = {9537, 12944, 9543, 9499},
			Level = 55,
			DisplayIDs = {{8658},{14666},{8667},{8652}},
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Hurley Blackbreath"], nil },
				{ 2,  11735 }, -- Ragefury Eyepatch
				{ 3,  18043 }, -- Coal Miner Boots
				{ 4,  22275 }, -- Firemoss Boots
				{ 5,  18044 }, -- Hurley's Tankard
				{ 7, "INV_Box_01", nil, AL["Lokhtos Darkbargainer"], nil },
				{ 8, 18592 }, -- Plans: Sulfuron Hammer
				{ 16, "INV_Box_01", nil, AL["Ribbly Screwspigot"], nil },
				{ 17, 11612 }, -- Plans: Dark Iron Plate
				{ 18, 2662 }, -- Ribbly's Quiver
				{ 19, 2663 }, -- Ribbly's Bandolier
				{ 20, 11742 }, -- Wayfarer's Knapsack
				{ 22, "INV_Box_01", nil, AL["Plugger Spazzring"], nil },
				{ 23, 12793 }, -- Mixologist's Tunic
				{ 24, 12791 }, -- Barman Shanker
				{ 25, 18653 }, -- Schematic: Goblin Jumper Cables XL
				{ 26, 13483 }, -- Recipe: Transmute Fire to Earth
				{ 27, 15759 }, -- Pattern: Black Dragonscale Breastplate
				{ 28, 11325 }, -- Dark Iron Ale Mug
				{ 29, 11602 }, -- Grim Guzzler Key
			},
		},
		{ -- Phalanx
			name = AL["Phalanx"],
			npcID = 9502,
			Level = 55,
			SubAreaID = 26751,
			DisplayIDs = {{8177}},
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  11746 }, -- Golem Skull Helm
				{ 2,  22212 }, -- Golem Fitted Pauldrons
				{ 3,  11745 }, -- Fists of Phalanx
				{ 4, 11744 }, -- Bloodfist
				{ 5, 11743 }, -- Rockfist
			},
		},
		{ -- BRDFlamelash
			name = AL["Ambassador Flamelash"],
			npcID = 9156,
			Level = 57,
			SubAreaID = 26761,
			DisplayIDs = {{8329}},
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1,  11808 }, -- Circle of Flame
				{ 3,  11812 }, -- Cape of the Fire Salamander
				{ 4,  11814 }, -- Molten Fists
				{ 5,  11832 }, -- Burst of Knowledge
				{ 6,  11809 }, -- Flame Wrath
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- BRDPanzor
			name = AL["Panzor the Invincible"],
			npcID = 8923,
			Level = 57,
			SubAreaID = 26764,
			DisplayIDs = {{8270}},
			AtlasMapBossID = 17,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  22245 }, -- Soot Encrusted Footwear
				{ 2,  11787 }, -- Shalehusk Boots
				{ 3,  11785 }, -- Rock Golem Bulwark
				{ 4,  11786 }, -- Stone of the Earth
			},
		},
		{ -- BRDTomb
			name = AL["Chest of The Seven"],
			SubAreaID = 26784,
			npcID = {9034, 9035, 9036, 9037, 9038, 9039, 9040},
			ObjectID = 169243,
			Level = {55, 57},
			DisplayIDs = {{8690},{8686},{8692},{8689},{8691},{8687},{8688}},
			AtlasMapBossID = 18,
			[NORMAL_DIFF] = {
				{ 1,  11925 }, -- Ghostshroud
				{ 2,  11926 }, -- Deathdealer Breastplate
				{ 3,  11929 }, -- Haunting Specter Leggings
				{ 4,  11927 }, -- Legplates of the Eternal Guardian
				{ 5,  11920 }, -- Wraith Scythe
				{ 6,  11923 }, -- The Hammer of Grace
				{ 7,  11922 }, -- Blood-etched Blade
				{ 8,  11921 }, -- Impervious Giant
			},
		},
		{ -- BRDMagmus
			name = AL["Magmus"],
			npcID = 9938,
			Level = 57,
			SubAreaID = 26768,
			DisplayIDs = {{12162}},
			AtlasMapBossID = 20,
			[NORMAL_DIFF] = {
				{ 1,  11935 }, -- Magmus Stone
				{ 2,  22395 }, -- Totem of Rage
				{ 3,  22400 }, -- Libram of Truth
				{ 4,  22208 }, -- Lavastone Hammer
			},
		},
		{ -- BRDPrincess
			name = AL["Princess Moira Bronzebeard "],
			npcID = 8929,
			Level = 58,
			SubAreaID = 26769,
			DisplayIDs = {{8705}},
			AtlasMapBossID = 21,
			[NORMAL_DIFF] = {
				{ 1,  12557 }, -- Ebonsteel Spaulders
				{ 2,  12554 }, -- Hands of the Exalted Herald
				{ 3,  12556 }, -- High Priestess Boots
				{ 4,  12553 }, -- Swiftwalker Boots
			},
		},
		{ -- BRDEmperorDagranThaurissan
			name = AL["Emperor Dagran Thaurissan"],
			npcID = 9019,
			Level = 59,
			SubAreaID = 26769,
			DisplayIDs = {{8807}},
			AtlasMapBossID = 21,
			[NORMAL_DIFF] = {
				{ 1,  11684 }, -- Ironfoe
				{ 3,  16724 }, -- Lightforge Gauntlets
				{ 4,  11933 }, -- Imperial Jewel
				{ 5,  11930 }, -- The Emperor's New Cape
				{ 6,  11924 }, -- Robes of the Royal Crown
				{ 7,  22204 }, -- Wristguards of Renown
				{ 8,  22207 }, -- Sash of the Grand Hunt
				{ 9,  11934 }, -- Emperor's Seal
				{ 10, 11810 }, -- Force of Will
				{ 11, 11928 }, -- Thaurissan's Royal Scepter
				{ 12, 11931 }, -- Dreadforge Retaliator
				{ 13, 11932 }, -- Guiding Stave of Wisdom
				{ 16, 12033 }, -- Thaurissan Family Jewels
			},
		},
		{ -- BRDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  12549 }, -- Braincage
				{ 2,  12552 }, -- Blisterbane Wrap
				{ 3,  12551 }, -- Stoneshield Cloak
				{ 4,  12542 }, -- Funeral Pyre Vestment
				{ 5,  12546 }, -- Aristocratic Cuffs
				{ 6,  12550 }, -- Runed Golem Shackles
				{ 7,  12547 }, -- Mar Alom's Grip
				{ 8,  12555 }, -- Battlechaser's Greaves
				{ 9,  12527 }, -- Ribsplitter
				{ 10, 12531 }, -- Searing Needle
				{ 11, 12535 }, -- Doomforged Straightedge
				{ 12, 12528 }, -- The Judge's Gavel
				{ 13, 12532 }, -- Spire of the Stoneshaper
				{ 16, 15781 }, -- Pattern: Black Dragonscale Leggings
				{ 17, 15770 }, -- Pattern: Black Dragonscale Shoulders
				{ 19, 11611 }, -- Plans: Dark Iron Sunderer
				{ 20, 11614 }, -- Plans: Dark Iron Mail
				{ 21, 11615 }, -- Plans: Dark Iron Shoulders
				{ 23, 16048 }, -- Schematic: Dark Iron Rifle
				{ 24, 16053 }, -- Schematic: Master Engineer's Goggles
				{ 25, 16049 }, -- Schematic: Dark Iron Bomb
				{ 26, 18654 }, -- Schematic: Gnomish Alarm-O-Bot
				{ 27, 18661 }, -- Schematic: World Enlarger
			},
		},
		{ -- BRDBSPlans
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  11614 }, -- Plans: Dark Iron Mail
				{ 2,  11615 }, -- Plans: Dark Iron Shoulders
			},
		},
		{ -- BRDTheldren
			name = AL["Theldren"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16059,
			DisplayIDs = {{15981}},
			AtlasMapBossID = 6,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  22305 }, -- Ironweave Mantle
				{ 2,  22330 }, -- Shroud of Arcane Mastery
				{ 3,  22318 }, -- Malgen's Long Bow
				{ 4,  22317 }, -- Lefty's Brass Knuckle
			},
		},
	},
}

data["LowerBlackrockSpire"] = {
	name = AL["Lower Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26683, 26718, 26711, 26713, 26686, 32528, 26688 },
	AtlasMapID = "LowerBlackrockSpire",
	AtlasMapFile = {"BlackrockSpireLower", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {48, 55, 60},
	items = {
		{ -- LBRSFelguard
			name = AL["Burning Felguard"],
			npcID = 10263,
			Level = {56, 57},
			DisplayIDs = {{5047}},
			AtlasMapBossID = 1,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13181 }, -- Demonskin Gloves
				{ 2,  13182 }, -- Phase Blade
			},
		},
		{ -- LBRSSpirestoneButcher
			name = AL["Spirestone Butcher"],
			npcID = 9219,
			Level = 57,
			DisplayIDs = {{11574}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  12608 }, -- Butcher's Apron
				{ 2,  13286 }, -- Rivenspike
			},
		},
		{ -- LBRSOmokk
			name = AL["Highlord Omokk"],
			npcID = 9196,
			Level = 59,
			SubAreaID = 26713,
			DisplayIDs = {{11565}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  13166 }, -- Slamshot Shoulders
				{ 2,  13168 }, -- Plate of the Shaman King
				{ 3,  13170 }, -- Skyshroud Leggings
				{ 4,  13169 }, -- Tressermane Leggings
				{ 5,  13167 }, -- Fist of Omokk
				{ 7,  12336 }, -- Gemstone of Spirestone
				{ 9, 12534 }, -- Omokk's Head
			},
		},
		{ -- LBRSSpirestoneBattleLord
			name = AL["Spirestone Battle Lord"],
			npcID = 9218,
			Level = 58,
			DisplayIDs = {{11576}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13284 }, -- Swiftdart Battleboots
				{ 2,  13285 }, -- The Nicker
			},
		},
		{ -- LBRSSpirestoneLordMagus
			name = AL["Spirestone Lord Magus"],
			npcID = 9217,
			Level = {57, 58},
			DisplayIDs = {{11578}},
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13282 }, -- Ogreseer Tower Boots
				{ 2,  13283 }, -- Magus Ring
				{ 3,  13261 }, -- Globe of D'sak
			},
		},
		{ -- LBRSVosh
			name = AL["Shadow Hunter Vosh'gajin"],
			npcID = 9236,
			Level = 58,
			SubAreaID = 26688,
			DisplayIDs = {{9732}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  16712 }, -- Shadowcraft Gloves
				{ 3,  13257 }, -- Demonic Runed Spaulders
				{ 4,  12626 }, -- Funeral Cuffs
				{ 5,  13255 }, -- Trueaim Gauntlets
				{ 6,  12653 }, -- Riphook
				{ 7,  12651 }, -- Blackcrow
				{ 8,  12654 }, -- Doomshot
			},
		},
		{ -- LBRSVoone
			name = AL["War Master Voone"],
			npcID = 9237,
			Level = 59,
			SubAreaID = 26688,
			DisplayIDs = {{9733}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  16676 }, -- Beaststalker's Gloves
				{ 3,  13177 }, -- Talisman of Evasion
				{ 4,  13178 }, -- Rosewine Circle
				{ 5,  13179 }, -- Brazecore Armguards
				{ 6,  22231 }, -- Kayser's Boots of Precision
				{ 7,  13173 }, -- Flightblade Throwing Axe
				{ 8,  12582 }, -- Keris of Zul'Serak
				{ 10,  12335 }, -- Gemstone of Smolderthorn
			},
		},
		{ -- LBRSGrimaxe
			name = AL["Bannok Grimaxe"],
			npcID = 9596,
			Level = 59,
			DisplayIDs = {{9668}},
			AtlasMapBossID = 12,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  12637 }, -- Backusarian Gauntlets
				{ 2,  12634 }, -- Chiselbrand Girdle
				{ 3,  12621 }, -- Demonfork
				{ 5,  12838 }, -- Plans: Arcanite Reaper
				--{ 6,  12784 }, -- Arcanite Reaper
			},
		},
		{ -- LBRSSmolderweb
			name = AL["Mother Smolderweb"],
			npcID = 10596,
			Level = 59,
			SubAreaID = 26686,
			DisplayIDs = {{9929}},
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 1,  16715 }, -- Wildheart Boots
				{ 3,  13244 }, -- Gilded Gauntlets
				{ 4,  13213 }, -- Smolderweb's Eye
				{ 5,  13183 }, -- Venomspitter
			},
		},
		{ -- LBRSCrystalFang
			name = AL["Crystal Fang"],
			npcID = 10376,
			Level = 60,
			SubAreaID = 26686,
			DisplayIDs = {{9755}},
			AtlasMapBossID = 14,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13185 }, -- Sunderseer Mantle
				{ 2,  13184 }, -- Fallbrush Handgrips
				{ 3,  13218 }, -- Fang of the Crystal Spider
			},
		},
		{ -- LBRSDoomhowl
			name = AL["Urok Doomhowl"],
			npcID = 10584,
			Level = 60,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  16670 }, -- Boots of Elements
				{ 3,  13258 }, -- Slaghide Gauntlets
				{ 4,  22232 }, -- Marksman's Girdle
				{ 5,  13259 }, -- Ribsteel Footguards
				{ 7,  18784 }, -- Top Half of Advanced Armorsmithing: Volume III
			},
		},
		{ -- LBRSZigris
			name = AL["Quartermaster Zigris"],
			npcID = 9736,
			Level = 59,
			SubAreaID = 32528,
			DisplayIDs = {{9738}},
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1,  13247 }, -- Quartermaster Zigris' Footlocker
				{ 3,  13253 }, -- Hands of Power
				{ 4,  13252 }, -- Cloudrunner Girdle
				{ 6,  12835 }, -- Plans: Annihilator
				--{ 5,  12798 }, -- Annihilator
			},
		},
		{ -- LBRSHalycon
			name = AL["Halycon"],
			npcID = 10220,
			Level = 59,
			SubAreaID = 26711,
			DisplayIDs = {{9567}},
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1,  13212 }, -- Halycon's Spiked Collar
				{ 2,  22313 }, -- Ironweave Bracers
				{ 3,  13211 }, -- Slashclaw Bracers
				{ 4,  13210 }, -- Pads of the Dread Wolf
			},
		},
		{ -- LBRSSlavener
			name = AL["Gizrul the Slavener"],
			npcID = 10268,
			Level = 60,
			SubAreaID = 26711,
			DisplayIDs = {{9564}},
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1,  16718 }, -- Wildheart Spaulders
				{ 3,  13208 }, -- Bleak Howler Armguards
				{ 4,  13206 }, -- Wolfshear Leggings
				{ 5,  13205 }, -- Rhombeard Protector
			},
		},
		{ -- LBRSBashguud
			name = AL["Ghok Bashguud"],
			npcID = 9718,
			Level = 59,
			DisplayIDs = {{11809}},
			AtlasMapBossID = 18,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13203 }, -- Armswake Cloak
				{ 2,  13198 }, -- Hurd Smasher
				{ 3,  13204 }, -- Bashguuder
			},
		},
		{ -- LBRSWyrmthalak
			name = AL["Overlord Wyrmthalak"],
			npcID = 9568,
			Level = 60,
			SubAreaID = 26718,
			DisplayIDs = {{8711}},
			AtlasMapBossID = 19,
			[NORMAL_DIFF] = {
				{ 1,  13143 }, -- Mark of the Dragon Lord
				{ 3,  16679 }, -- Beaststalker's Mantle
				{ 5,  13162 }, -- Reiver Claws
				{ 6,  13164 }, -- Heart of the Scale
				{ 7,  22321 }, -- Heart of Wyrmthalak
				{ 8,  13163 }, -- Relentless Scythe
				{ 9,  13148 }, -- Chillpike
				{ 10, 13161 }, -- Trindlehaven Staff
				{ 12, 12337 }, -- Gemstone of Bloodaxe
				{ 16, 12780 }, -- General Drakkisath's Command
			},
		},

		{ -- LBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  14513 }, -- Pattern: Robe of the Archmage
				--{ 2,  14152 }, -- Robe of the Archmage
				{ 3,  16696 }, -- Devout Belt
				{ 4,  16685 }, -- Magister's Belt
				{ 5,  16683 }, -- Magister's Bindings
				{ 6,  16703 }, -- Dreadmist Bracers
				{ 7,  16713 }, -- Shadowcraft Belt
				{ 8,  16716 }, -- Wildheart Belt
				{ 9, 16680 }, -- Beaststalker's Belt
				{ 10, 16673 }, -- Cord of Elements
				{ 11, 16736 }, -- Belt of Valor
				{ 12, 16735 }, -- Bracers of Valor
				{ 16, 15749 }, -- Pattern: Volcanic Breastplate
				{ 17, 15775 }, -- Pattern: Volcanic Shoulders
				{ 18, 13494 }, -- Recipe: Greater Fire Protection Potion
				{ 19, 16250 }, -- Formula: Enchant Weapon - Superior Striking
				{ 20, 16244 }, -- Formula: Enchant Gloves - Greater Strength
				{ 21, 9214 }, -- Grimoire of Inferno
				{ 23, 12219 }, -- Unadorned Seal of Ascension
				{ 24, 12586 }, -- Immature Venom Sac
			},
		},
		{ -- LBRSGrayhoof
			name = AL["Mor Grayhoof"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16080,
			DisplayIDs = {{15997}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  22306 }, -- Ironweave Belt
				{ 2,  22325 }, -- Belt of the Trickster
				{ 3,  22319 }, -- Tome of Divine Right
				{ 4,  22398 }, -- Idol of Rejuvenation
				{ 5,  22322 }, -- The Jaw Breaker
			},
		},
	},
}

data["UpperBlackrockSpire"] = {
	name = AL["Upper Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26670, 26668, 26684, 26662, 26642, 26683, 15492, 26666, 26715 },
	AtlasMapID = "UpperBlackrockSpire",
	AtlasMapFile = {"BlackrockSpireUpper", "BlackrockMountainEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {48, 55, 60},
	items = {
		{ -- UBRSEmberseer
			name = AL["Pyroguard Emberseer"],
			npcID = 9816,
			Level = 60,
			SubAreaID = 26662,
			DisplayIDs = {{2172}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  16672 }, -- Gauntlets of Elements
				{ 3,  12929 }, -- Emberfury Talisman
				{ 4,  12927 }, -- TruestrikeShoulders
				{ 5,  12905 }, -- Wildfire Cape
				{ 6,  12926 }, -- Flaming Band
				{ 8,  23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- UBRSSolakar
			name = AL["Solakar Flamewreath"],
			npcID = 10264,
			Level = 60,
			SubAreaID = 26666,
			DisplayIDs = {{9581}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  16695 }, -- Devout Mantle
				{ 3,  12609 }, -- Polychromatic Visionwrap
				{ 4,  12603 }, -- Nightbrace Tunic
				{ 5,  12589 }, -- Dustfeather Sash
				{ 6,  12606 }, -- Crystallized Girdle
				{ 8,  18657 }, -- Schematic: Hyper-Radiant Flame Reflector
			},
		},
		{ -- UBRSRunewatcher
			name = AL["Jed Runewatcher"],
			npcID = 10509,
			Level = 59,
			SubAreaID = 26642,
			DisplayIDs = {{9686}},
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  12604 }, -- Starfire Tiara
				{ 2,  12930 }, -- Briarwood Reed
				{ 3,  12605 }, -- Serpentine Skuller
			},
		},
		{ -- UBRSAnvilcrack
			name = AL["Goraluk Anvilcrack "],
			npcID = 10899,
			Level = 61,
			SubAreaID = 26642,
			DisplayIDs = {{10222}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  13502 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3,  18047 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9, 18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 16, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 17, 12806 }, -- Unforged Rune Covered Breastplate
				{ 18, 12696 }, -- Plans: Demon Forged Breastplate
			},
		},
		{ -- UBRSGyth
			name = AL["Gyth"],
			npcID = 10339,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9806}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  12871 }, -- Chromatic Carapace
				{ 3,  16669 }, -- Pauldrons of Elements
				{ 5,  22225 }, -- Dragonskin Cowl
				{ 6,  12960 }, -- Tribal War Feathers
				{ 7,  12953 }, -- Dragoneye Coif
				{ 8,  12952 }, -- Gyth's Skull
				{ 10, 13522 }, -- Recipe: Flask of Chromatic Resistance
			},
		},
		{ -- UBRSRend
			name = AL["Warchief Rend Blackhand"],
			npcID = 10429,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = {{9778}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  12590 }, -- Felstriker
				{ 3,  16733 }, -- Spaulders of Valor
				{ 5,  12587 }, -- Eye of Rend
				{ 6,  12588 }, -- Bonespike Shoulder
				{ 7,  12936 }, -- Battleborn Armbraces
				{ 8,  18104 }, -- Feralsurge Girdle
				{ 9,  12935 }, -- Warmaster Legguards
				{ 10, 18102 }, -- Dragonrider Boots
				{ 11, 22247 }, -- Faith Healer's Boots
				{ 12, 18103 }, -- Band of Rumination
				{ 13, 12940 }, -- Dal'Rend's Sacred Charge
				{ 14, 12939 }, -- Dal'Rend's Tribal Guardian
				{ 15, 12583 }, -- Blackhand Doomsaw
			},
		},
		{ -- UBRSBeast
			name = AL["The Beast"],
			npcID = 10430,
			Level = 62,
			SubAreaID = 26684,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  12731 }, -- Pristine Hide of the Beast
				{ 3,  16729 }, -- Lightforge Spaulders
				{ 5,  12967 }, -- Bloodmoon Cloak
				{ 6,  12968 }, -- Frostweaver Cape
				{ 7,  12966 }, -- Blackmist Armguards
				{ 8,  12965 }, -- Spiritshroud Leggings
				{ 9,  12963 }, -- Blademaster Leggings
				{ 10, 12964 }, -- Tristam Legguards
				{ 11, 22311 }, -- Ironweave Boots
				{ 12, 12709 }, -- Finkle's Skinner
				{ 13, 12969 }, -- Seeping Willow
				{ 15, 24101 }, -- Book of Ferocious Bite V
				{ 16, 19227 }, -- Ace of Beasts
			},
		},
		{ -- UBRSDrakkisath
			name = AL["General Drakkisath"],
			npcID = 10363,
			Level = 62,
			SubAreaID = 26715,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  12592 }, -- Blackblade of Shahram
				{ 3,  22267 }, -- Spellweaver's Turban
				{ 4,  13141 }, -- Tooth of Gnarr
				{ 5,  22269 }, -- Shadow Prowler's Cloak
				{ 6,  13142 }, -- Brigam Girdle
				{ 7,  13098 }, -- Painweaver Band
				{ 8,  22268 }, -- Draconic Infused Emblem
				{ 9,  22253 }, -- Tome of the Lost
				{ 10, 12602 }, -- Draconian Deflector
				{ 12, 15730 }, -- Pattern: Red Dragonscale Breastplate
				{ 14, 13519 }, -- Recipe: Flask of the Titans
				{ 16, 16690 }, -- Devout Robe
				{ 17, 16688 }, -- Magister's Robes
				{ 18, 16700 }, -- Dreadmist Robe
				{ 19, 16721 }, -- Shadowcraft Tunic
				{ 20, 16706 }, -- Wildheart Vest
				{ 21, 16674 }, -- Beaststalker's Tunic
				{ 22, 16666 }, -- Vest of Elements
				{ 23, 16726 }, -- Lightforge Breastplate
				{ 24, 16730 }, -- Breastplate of Valor
			},
		},
		{ -- UBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  24102 }, -- Manual of Eviscerate IX
				{ 2,  13260 }, -- Wind Dancer Boots
				{ 4,  16696 }, -- Devout Belt
				{ 5,  16683 }, -- Magister's Bindings
				{ 6,  16703 }, -- Dreadmist Bracers
				{ 7,  16713 }, -- Shadowcraft Belt
				{ 8,  16681 }, -- Beaststalker's Bindings
				{ 9,  16680 }, -- Beaststalker's Belt
				{ 10, 16673 }, -- Cord of Elements
				{ 11, 16735 }, -- Bracers of Valor
				{ 16, 16247 }, -- Formula: Enchant 2H Weapon - Superior Impact
			},
		},
		{
			name = AL["Darkstone Tablet"],
			ExtraList = true,
			AtlasMapBossID = 3,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1,  12358 }, -- Darkstone Tablet
			},
		},
		{ -- UBRSValthalak
			name = AL["Lord Valthalak"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16042,
			DisplayIDs = {{14308}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  22302 }, -- Ironweave Cowl
				{ 2,  22340 }, -- Pendant of Celerity
				{ 3,  22337 }, -- Shroud of Domination
				{ 4,  22343 }, -- Handguards of Savagery
				{ 5,  22342 }, -- Leggings of Torment
				{ 6,  22339 }, -- Rune Band of Wizardry
				{ 7,  22336 }, -- Draconian Aegis of the Legion
				{ 8,  22335 }, -- Lord Valthalak's Staff of Command
			},
		},
	},
}

data["DireMaulEast"] = {
	name = AL["Dire Maul East"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 34776, 33730 },
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulEast", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 55, 60},
	items = {
		{ -- DMEPusillin
			name = AL["Pusillin"],
			npcID = 14354,
			Level = 57,
			DisplayIDs = {{7552}},
			AtlasMapBossID = "1-2",
			[NORMAL_DIFF] = {
				{ 1,  18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3,  18249 }, -- Crescent Key
			},
		},
		{ -- DMEZevrimThornhoof
			name = AL["Zevrim Thornhoof"],
			npcID = 11490,
			Level = 57,
			DisplayIDs = {{11335}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18319 }, -- Fervent Helm
				{ 2,  18313 }, -- Helm of Awareness
				{ 3,  18323 }, -- Satyr's Bow
				{ 5,  18308 }, -- Clever Hat
				{ 6,  18306 }, -- Gloves of Shadowy Mist
			},
		},
		{ -- DMEHydro
			name = AL["Hydrospawn"],
			npcID = 13280,
			Level = 57,
			DisplayIDs = {{5489}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18317 }, -- Tempest Talisman
				{ 2,  18322 }, -- Waterspout Boots
				{ 3,  18324 }, -- Waveslicer
				{ 5,  19268 }, -- Ace of Elementals
				{ 7,  18305 }, -- Breakwater Legguards
				{ 8,  18307 }, -- Riptide Shoes
			},
		},
		{ -- DMELethtendris
			name = AL["Lethtendris"],
			npcID = 14327,
			Level = 57,
			DisplayIDs = {{14378}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18325 }, -- Felhide Cap
				{ 2,  18311 }, -- Quel'dorai Channeling Rod
				{ 4,  18301 }, -- Lethtendris's Wand
				{ 5,  18302 }, -- Band of Vigor
			},
		},
		{ -- DMEAlzzin
			name = AL["Alzzin the Wildshaper"],
			npcID = 11492,
			Level = 58,
			DisplayIDs = {{14416}},
			AtlasMapBossID = 5,
			SubAreaID = 33730,
			[NORMAL_DIFF] = {
				{ 1,  18328 }, -- Shadewood Cloak
				{ 2,  18312 }, -- Energized Chestplate
				{ 3,  18309 }, -- Gloves of Restoration
				{ 4,  18326 }, -- Razor Gauntlets
				{ 5,  18327 }, -- Whipvine Cord
				{ 6,  18318 }, -- Merciful Greaves
				{ 7,  18321 }, -- Energetic Rod
				{ 8,  18310 }, -- Fiendish Machete
				{ 9,  18314 }, -- Ring of Demonic Guile
				{ 10, 18315 }, -- Ring of Demonic Potency
			},
		},
		{ -- DMETrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18289 }, -- Barbed Thorn Necklace
				{ 2,  18296 }, -- Marksman Bands
				{ 3,  18298 }, -- Unbridled Leggings
				{ 4,  18295 }, -- Phasing Boots
				{ 6,  18333 }, -- Libram of Focus
				{ 7,  18334 }, -- Libram of Protection
				{ 8,  18332 }, -- Libram of Rapidity
				{ 10, 18255 }, -- Runn Tum Tuber
				{ 11, 18297 }, -- Thornling Seed
			},
		},
		{ -- DMEIsalien
			name = AL["Isalien"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16097,
			DisplayIDs = {{16000}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  22304 }, -- Ironweave Gloves
				{ 2,  22472 }, -- Boots of Ferocity
				{ 3,  22401 }, -- Libram of Hope
				{ 4,  22345 }, -- Totem of Rebirth
				{ 5,  22315 }, -- Hammer of Revitalization
				{ 6,  22314 }, -- Huntsman's Harpoon
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulWest"] = {
	name = AL["Dire Maul West"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33748, 33749, 33750, 33710 },
	AtlasMapID = "DireMaul",
	AtlasMapFile = {"DireMaulWest", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 55, 60},
	items = {
		{ -- DMWTendrisWarpwood
			name = AL["Tendris Warpwood"],
			npcID = 11489,
			Level = 60,
			DisplayIDs = {{14383}},
			AtlasMapBossID = 2,
			SubAreaID = 33748,
			[NORMAL_DIFF] = {
				{ 1,  18393 }, -- Warpwood Binding
				{ 2,  18390 }, -- Tanglemoss Leggings
				{ 4,  18352 }, -- Petrified Bark Shield
				{ 5,  18353 }, -- Stoneflower Staff
			},
		},
		{ -- DMWIllyannaRavenoak
			name = AL["Illyanna Ravenoak"],
			npcID = 11488,
			Level = 60,
			DisplayIDs = {{11270}},
			SubAreaID = 33749,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18383 }, -- Force Imbued Gauntlets
				{ 2,  18386 }, -- Padre's Trousers
				{ 4,  18349 }, -- Gauntlets of Accuracy
				{ 5,  18347 }, -- Well Balanced Axe
			},
		},
		{ -- DMWMagisterKalendris
			name = AL["Magister Kalendris"],
			npcID = 11487,
			Level = 60,
			DisplayIDs = {{14384}},
			AtlasMapBossID = 4,
			SubAreaID = 33749,
			[NORMAL_DIFF] = {
				{ 1,  18374 }, -- Flamescarred Shoulders
				{ 2,  18397 }, -- Elder Magus Pendant
				{ 3,  18371 }, -- Mindtap Talisman
				{ 5,  18350 }, -- Amplifying Cloak
				{ 6,  18351 }, -- Magically Sealed Bracers
				{ 8,  22309 }, -- Pattern: Big Bag of Enchantment
				--{ 9,  22249 }, -- Big Bag of Enchantment
			},
		},
		{ -- DMWTsuzee
			name = AL["Tsu'zee"],
			npcID = 11467,
			Level = 60,
			DisplayIDs = {{11250}},
			specialType = "rare",
			AtlasMapBossID = 5,
			SubAreaID = 33749,
			[NORMAL_DIFF] = {
				{ 1,  18387 }, -- Brightspark Gloves
				{ 3,  18346 }, -- Threadbare Trousers
				{ 4,  18345 }, -- Murmuring Ring
			},
		},
		{ -- DMWImmolthar
			name = AL["Immol'thar"],
			npcID = 11496,
			Level = 61,
			DisplayIDs = {{14173}},
			AtlasMapBossID = 6,
			SubAreaID = 33750,
			[NORMAL_DIFF] = {
				{ 1,  18381 }, -- Evil Eye Pendant
				{ 2,  18384 }, -- Bile-etched Spaulders
				{ 3,  18389 }, -- Cloak of the Cosmos
				{ 4,  18385 }, -- Robe of Everlasting Night
				{ 5,  18394 }, -- Demon Howl Wristguards
				{ 6,  18377 }, -- Quickdraw Gloves
				{ 7,  18391 }, -- Eyestalk Cord
				{ 8,  18379 }, -- Odious Greaves
				{ 9,  18370 }, -- Vigilance Charm
				{ 10, 18372 }, -- Blade of the New Moon
			},
		},
		{ -- DMWPrinceTortheldrin
			name = AL["Prince Tortheldrin"],
			npcID = 11486,
			Level = 61,
			DisplayIDs = {{11256}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  18382 }, -- Fluctuating Cloak
				{ 2,  18373 }, -- Chestplate of Tranquility
				{ 3,  18375 }, -- Bracers of the Eclipse
				{ 4,  18378 }, -- Silvermoon Leggings
				{ 5,  18380 }, -- Eldritch Reinforced Legplates
				{ 6,  18395 }, -- Emerald Flame Ring
				{ 7,  18388 }, -- Stoneshatter
				{ 8,  18396 }, -- Mind Carver
				{ 9,  18376 }, -- Timeworn Mace
				{ 10, 18392 }, -- Distracting Dagger
			},
		},
		{ -- DMWTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18340 }, -- Eidolon Talisman
				{ 2,  18344 }, -- Stonebark Gauntlets
				{ 3,  18338 }, -- Wand of Arcane Potency
				{ 5,  18333 }, -- Libram of Focus
				{ 6,  18334 }, -- Libram of Protection
				{ 7,  18332 }, -- Libram of Rapidity
			},
		},
		{ -- DMWShendralarProvisioner
			name = AL["Shen'dralar Provisioner"],
			npcID = 14371,
			DisplayIDs = {{14412}},
			ExtraList = true,
			AtlasMapBossID = "1'",
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
				--{ 2,  18486 }, -- Mooncloth Robe
			},
		},
		{ -- DMWHelnurath
			name = AL["Lord Hel'nurath"],
			npcID = 14506,
			DisplayIDs = {{14556}},
			ExtraList = true,
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18757 }, -- Diabolic Mantle
				{ 2,  18754 }, -- Fel Hardened Bracers
				{ 3,  18755 }, -- Xorothian Firestick
				{ 4,  18756 }, -- Dreadguard's Protector
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulNorth"] = {
	name = AL["Dire Maul North"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33774, 33775 },
	AtlasMapID = "DireMaulNorth",
	AtlasMapFile = {"DireMaulNorth", "DireMaulEnt"},
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {31, 55, 60},
	items = {
		{ -- DMNGuardMoldar
			name = AL["Guard Mol'dar"],
			npcID = 14326,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  18494 }, -- Denwatcher's Shoulders
				{ 2,  18493 }, -- Bulky Iron Spaulders
				{ 3,  18496 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
				{ 17, 18268 }, -- Gordok Inner Door Key
			},
		},
		{ -- DMNStomperKreeg
			name = AL["Stomper Kreeg"],
			npcID = 14322,
			Level = 59,
			DisplayIDs = {{11545}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  18425 }, -- Kreeg's Mug
				{ 16, "INV_Box_01", nil, AL["Sells:"], nil },
				{ 17, 18269, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Gordok Green Grog
				{ 18, 18284, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Kreeg's Stout Beatdown
				{ 19, 18287, [PRICE_EXTRA_ITTYPE] = "money:200" }, -- Evermurky
				{ 20, 18288, [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Molasses Firewater
				{ 21, 9260, [PRICE_EXTRA_ITTYPE] = "money:1600" }, -- Volatile Rum
			},
		},
		{ -- DMNGuardFengus
			name = AL["Guard Fengus"],
			npcID = 14321,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18450 }, -- Robe of Combustion
				{ 2,  18458 }, -- Modest Armguards
				{ 3,  18459 }, -- Gallant's Wristguards
				{ 4,  18451 }, -- Hyena Hide Belt
				{ 5,  18462 }, -- Jagged Bone Fist
				{ 6,  18463 }, -- Ogre Pocket Knife
				{ 7,  18464 }, -- Gordok Nose Ring
				{ 8,  18460 }, -- Unsophisticated Hand Cannon
				{ 10, 18250 }, -- Gordok Shackle Key
				{ 16, "INV_Box_01", nil, AL["Fengus's Chest"], nil },
				{ 17, 18266 }, -- Gordok Courtyard Key
			},
		},
		{ -- DMNGuardSlipkik
			name = AL["Guard Slip'kik"],
			npcID = 14323,
			Level = 59,
			DisplayIDs = {{11561}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  18494 }, -- Denwatcher's Shoulders
				{ 2,  18493 }, -- Bulky Iron Spaulders
				{ 3,  18496 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
			},
		},
		{ -- DMNThimblejack
			name = AL["Knot Thimblejack's Cache"],
			AtlasMapBossID = 4,
			npcID = 14338,
			ObjectID = 179501,
			[NORMAL_DIFF] = {
				{ 1,  18414 }, -- Pattern: Belt of the Archmage
				{ 16,  18517 }, -- Pattern: Chromatic Cloak
				{ 17,  18518 }, -- Pattern: Hide of the Wild
				{ 18,  18519 }, -- Pattern: Shifting Cloak
				{ 5,  18415 }, -- Pattern: Felcloth Gloves
				{ 6,  18416 }, -- Pattern: Inferno Gloves
				{ 7,  18417 }, -- Pattern: Mooncloth Gloves
				{ 8,  18418 }, -- Pattern: Cloak of Warding
				{ 20, 18514 }, -- Pattern: Girdle of Insight
				{ 21, 18515 }, -- Pattern: Mongoose Boots
				{ 22, 18516 }, -- Pattern: Swift Flight Bracers
				{ 10, 18258 }, -- Gordok Ogre Suit
				{ 11, 18240 }, -- Ogre Tannin
			},
		},
		{ -- DMNCaptainKromcrush
			name = AL["Captain Kromcrush"],
			npcID = 14325,
			Level = 61,
			DisplayIDs = {{11564}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  18503 }, -- Kromcrush's Chestplate
				{ 2,  18505 }, -- Mugger's Belt
				{ 3,  18507 }, -- Boots of the Full Moon
				{ 4,  18502 }, -- Monstrous Glaive
			},
		},
		{ -- DMNChoRush
			name = AL["Cho'Rush the Observer"],
			npcID = 14324,
			Level = 60,
			DisplayIDs = {{11537}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18490 }, -- Insightful Hood
				{ 2,  18483 }, -- Mana Channeling Wand
				{ 3,  18485 }, -- Observer's Shield
				{ 4,  18484 }, -- Cho'Rush's Blade
			},
		},
		{ -- DMNKingGordok
			name = AL["King Gordok"],
			npcID = 11501,
			Level = 62,
			DisplayIDs = {{11583}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18526 }, -- Crown of the Ogre King
				{ 2,  18525 }, -- Bracers of Prosperity
				{ 3,  18527 }, -- Harmonious Gauntlets
				{ 4,  18524 }, -- Leggings of Destruction
				{ 5,  18521 }, -- Grimy Metal Boots
				{ 6,  18522 }, -- Band of the Ogre King
				{ 7,  18523 }, -- Brightly Glowing Stone
				{ 8,  18520 }, -- Barbarous Blade
				{ 16, 19258 }, -- Ace of Warlords
				{ 18, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
			},
		},
		{ -- DMNTRIBUTERUN
			name = AL["Tribute"],
			ExtraList = true,
			npcID = 14324,
			ObjectID = 179564,
			[NORMAL_DIFF] = {
				{ 1,  18538 }, -- Treant's Bane
				{ 3,  18528 }, -- Cyclone Spaulders
				{ 4,  18495 }, -- Redoubt Cloak
				{ 5,  18532 }, -- Mindsurge Robe
				{ 6,  18530 }, -- Ogre Forged Hauberk
				{ 7,  18533 }, -- Gordok Bracers of Power
				{ 8,  18529 }, -- Elemental Plate Girdle
				{ 9,  18500 }, -- Tarnished Elven Ring
				{ 10, 18537 }, -- Counterattack Lodestone
				{ 11, 18499 }, -- Barrier Shield
				{ 12, 18531 }, -- Unyielding Maul
				{ 13, 18534 }, -- Rod of the Ogre Magi
				{ 16, 18479 }, -- Carrion Scorpid Helm
				{ 17, 18480 }, -- Scarab Plate Helm
				{ 18, 18478 }, -- Hyena Hide Jerkin
				{ 19, 18475 }, -- Oddly Magical Belt
				{ 20, 18477 }, -- Shaggy Leggings
				{ 21, 18476 }, -- Mud Stained Boots
				{ 22, 18482 }, -- Ogre Toothpick Shooter
				{ 23, 18481 }, -- Skullcracking Mace
				{ 25, 18655 }, -- Schematic: Major Recombobulator
			},
		},
		{ -- DMNTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18250 }, -- Gordok Shackle Key
				{ 3,  18333 }, -- Libram of Focus
				{ 4,  18334 }, -- Libram of Protection
				{ 5,  18332 }, -- Libram of Rapidity
				{ 7,  18640 }, -- Happy Fun Rock
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["Scholomance"] = {
	MapID = 2057,
	InstanceID = 289,
	SubAreaIDs = { 32549, 32574, 32567, 32577, 32566, 32565, 32581, 32579, 32573, 32568, 32576, 32569 },
	AtlasMapID = "Scholomance",
	AtlasMapFile = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {33, 58, 60},
	items = {
		{ -- SCHOLOBlood
			name = AL["Blood Steward of Kirtonos"],
			npcID = 14861,
			Level = 61,
			SubAreaID = 32573,
			DisplayIDs = {{10925}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLOKirtonostheHerald
			name = AL["Kirtonos the Herald"],
			npcID = 10506,
			Level = 60,
			SubAreaID = 32574,
			DisplayIDs = {{7534}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  16734 }, -- Boots of Valor
				{ 3,  13960 }, -- Heart of the Fiend
				{ 4,  13955 }, -- Stoneform Shoulders
				{ 5,  13969 }, -- Loomguard Armbraces
				{ 6,  13957 }, -- Gargoyle Slashers
				{ 7,  13956 }, -- Clutch of Andros
				{ 8,  13967 }, -- Windreaver Greaves
				{ 9,  14024 }, -- Frightalon
				{ 10, 13983 }, -- Gravestone War Axe
			},
		},
		{ -- SCHOLOJandiceBarov
			name = AL["Jandice Barov"],
			npcID = 10503,
			Level = 61,
			DisplayIDs = {{11073}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  16701 }, -- Dreadmist Mantle
				{ 3,  14548 }, -- Royal Cap Spaulders
				{ 4,  18689 }, -- Phantasmal Cloak
				{ 5,  14543 }, -- Darkshade Gloves
				{ 6,  14545 }, -- Ghostloom Leggings
				{ 7,  18690 }, -- Wraithplate Leggings
				{ 8,  14541 }, -- Barovian Family Sword
				{ 9,  22394 }, -- Staff of Metanoia
				{ 12, 13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLORattlegore
			name = AL["Rattlegore"],
			npcID = 11622,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{12073}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  16711 }, -- Shadowcraft Boots
				{ 3,  14539 }, -- Bone Ring Helm
				{ 4,  14538 }, -- Deadwalker Mantle
				{ 5,  18686 }, -- Bone Golem Shoulders
				{ 6,  14537 }, -- Corpselight Greaves
				{ 7,  14528 }, -- Rattlecage Buckler
				{ 8,  14531 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 12, 13873 }, -- Viewing Room Key
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcID = 14516,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = {{14591}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  18760 }, -- Necromantic Band
				{ 2,  18761 }, -- Oblivion's Touch
				{ 3,  18758 }, -- Specter's Blade
				{ 4,  18759 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOMarduk
			name = AL["Marduk Blackpool"],
			npcID = 10433,
			Level = 58,
			SubAreaID = 32576,
			DisplayIDs = {{10248}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18692 }, -- Death Knight Sabatons
				{ 2,  14576 }, -- Ebon Hilt of Marduk
			},
		},
		{ -- SCHOLOVectus
			name = AL["Vectus"],
			npcID = 10432,
			Level = 60,
			SubAreaID = 32576,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18691 }, -- Dark Advisor's Pendant
				{ 2,  14577 }, -- Skullsmoke Pants
			},
		},
		{ -- SCHOLORasFrostwhisper
			name = AL["Ras Frostwhisper"],
			npcID = 10508,
			Level = 62,
			SubAreaID = 32579,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  13314 }, -- Alanna's Embrace
				{ 3,  16689 }, -- Magister's Mantle
				{ 5,  14503 }, -- Death's Clutch
				{ 6,  14340 }, -- Freezing Lich Robes
				{ 7,  18693 }, -- Shivery Handwraps
				{ 8,  14525 }, -- Boneclenched Gauntlets
				{ 9,  14502 }, -- Frostbite Girdle
				{ 10, 14522 }, -- Maelstrom Leggings
				{ 11, 18694 }, -- Shadowy Mail Greaves
				{ 12, 18695 }, -- Spellbound Tome
				{ 13, 18696 }, -- Intricately Runed Shield
				{ 14, 13952 }, -- Iceblade Hacker
				{ 15, 14487 }, -- Bonechill Hammer
				{ 16, 13521 }, -- Recipe: Flask of Supreme Power
			},
		},
		{ -- SCHOLOInstructorMalicia
			name = AL["Instructor Malicia"],
			npcID = 10505,
			Level = 60,
			SubAreaID = 32567,
			DisplayIDs = {{11069}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  16710 }, -- Shadowcraft Bracers
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODoctorTheolenKrastinov
			name = AL["Doctor Theolen Krastinov"],
			npcID = 11261,
			Level = 60,
			SubAreaID = 32565,
			DisplayIDs = {{10901}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  16684 }, -- Magister's Gloves
				{ 2,  14617 }, -- Sawbones Shirt
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLorekeeperPolkelt
			name = AL["Lorekeeper Polkelt"],
			npcID = 10901,
			Level = 60,
			SubAreaID = 32566,
			DisplayIDs = {{11492}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  16705 }, -- Dreadmist Wraps
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOTheRavenian
			name = AL["The Ravenian"],
			npcID = 10507,
			Level = 60,
			SubAreaID = 32569,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  16716 }, -- Wildheart Belt
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLordAlexeiBarov
			name = AL["Lord Alexei Barov"],
			npcID = 10504,
			Level = 60,
			SubAreaID = 32549,
			DisplayIDs = {{11072}},
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  16722 }, -- Lightforge Bracers
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLadyIlluciaBarov
			name = AL["Lady Illucia Barov"],
			npcID = 10502,
			Level = 60,
			SubAreaID = 32568,
			DisplayIDs = {{11835}},
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  14633 }, -- Necropile Mantle
				{ 6,  14626 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  14611 }, -- Bloodmail Hauberk
				{ 9,  14624 }, -- Deathbone Chestplate
				{ 10, 14629 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 14615 }, -- Bloodmail Gauntlets
				{ 13, 14622 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 14614 }, -- Bloodmail Belt
				{ 16, 14620 }, -- Deathbone Girdle
				{ 17, 14632 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 14612 }, -- Bloodmail Legguards
				{ 21, 14623 }, -- Deathbone Legguards
				{ 22, 14631 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 14616 }, -- Bloodmail Boots
				{ 25, 14621 }, -- Deathbone Sabatons
				{ 26, 18684 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 18680 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODarkmasterGandling
			name = AL["Darkmaster Gandling"],
			npcID = 1853,
			Level = 61,
			SubAreaID = 32581,
			DisplayIDs = {{11070}},
			AtlasMapBossID = 14,
			[NORMAL_DIFF] = {
				{ 1,  13937 }, -- Headmaster's Charge
				{ 2,  14514 }, -- Pattern: Robe of the Void
				{ 4,  16693 }, -- Devout Crown
				{ 5,  16686 }, -- Magister's Crown
				{ 6,  16698 }, -- Dreadmist Mask
				{ 7,  16707 }, -- Shadowcraft Cap
				{ 8,  16720 }, -- Wildheart Cowl
				{ 9, 16677 }, -- Beaststalker's Cap
				{ 10, 16667 }, -- Coif of Elements
				{ 11, 16727 }, -- Lightforge Helm
				{ 12, 16731 }, -- Helm of Valor
				{ 16, 13944 }, -- Tombstone Breastplate
				{ 17, 13951 }, -- Vigorsteel Vambraces
				{ 18, 13950 }, -- Detention Strap
				{ 19, 13398 }, -- Boots of the Shrieker
				{ 20, 22433 }, -- Don Mauricio's Band of Domination
				{ 21, 13938 }, -- Bonecreeper Stylus
				{ 22, 13953 }, -- Silent Fang
				{ 23, 13964 }, -- Witchblade
				{ 25, 19276 }, -- Ace of Portals
				{ 27, 13501 }, -- Recipe: Major Mana Potion
			},
		},
		{ -- SCHOLOTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  16685 }, -- Magister's Belt
				{ 2,  16702 }, -- Dreadmist Belt
				{ 3,  16710 }, -- Shadowcraft Bracers
				{ 4,  16714 }, -- Wildheart Bracers
				{ 5,  16716 }, -- Wildheart Belt
				{ 6,  16671 }, -- Bindings of Elements
				{ 7,  16722 }, -- Lightforge Bracers
				{ 9,  12843 }, -- Corruptor's Scourgestone
				{ 10, 12841 }, -- Invader's Scourgestone
				{ 11, 12840 }, -- Minion's Scourgestone
				{ 13, 20520 }, -- Dark Rune
				{ 14, 12753 }, -- Skin of Shadow
				{ 16, 18698 }, -- Tattered Leather Hood
				{ 17, 18699 }, -- Icy Tomb Spaulders
				{ 18, 14536 }, -- Bonebrace Hauberk
				{ 19, 18700 }, -- Malefic Bracers
				{ 20, 18702 }, -- Belt of the Ordained
				{ 21, 18697 }, -- Coldstone Slippers
				{ 22, 18701 }, -- Innervating Band
				{ 24, 16254 }, -- Formula: Enchant Weapon - Lifestealing
				{ 25, 16255 }, -- Formula: Enchant 2H Weapon - Major Spirit
				{ 26, 15773 }, -- Pattern: Wicked Leather Armor
				{ 27, 15776 }, -- Pattern: Runic Leather Armor
				{ 29, 13920 }, -- Healthy Dragon Scale
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcID = 14516,
			ExtraList = true,
			SubAreaID = 32577,
			DisplayIDs = {{14591}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  18760 }, -- Necromantic Band
				{ 2,  18761 }, -- Oblivion's Touch
				{ 3,  18758 }, -- Specter's Blade
				{ 4,  18759 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOKormok
			name = AL["Kormok"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16118,
			DisplayIDs = {{16020}},
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  22303 }, -- Ironweave Pants
				{ 2,  22326 }, -- Amalgam's Band
				{ 3,  22331 }, -- Band of the Steadfast Hero
				{ 4,  22332 }, -- Blade of Necromancy
				{ 5,  22333 }, -- Hammer of Divine Might
			},
		},
		KEYS,
	},
}

data["Stratholme"] = {
	MapID = 2017,
	InstanceID = 329,
	SubAreaIDs = {
		-- Living
		32319, 32320, 32367, 32331, 32357, 32281, 32285, 32277,
		-- Undead
		32342, 32322, 32303, 32301, 32352,
			-- Ziggurats
			32344, 32345, 32349,
	},
	AtlasMapID = "Stratholme",
	AtlasMapFile = "Stratholme",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = {37, 58, 60},
	items = {
		{ -- STRATSkull
			name = AL["Skul"],
			npcID = 10393,
			Level = 58,
			DisplayIDs = {{2606}},
			AtlasMapBossID = 1,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13395 }, -- Skul's Fingerbone Claws
				{ 2,  13394 }, -- Skul's Cold Embrace
				{ 3,  13396 }, -- Skul's Ghastly Touch
			},
		},
		{ -- STRATStratholmeCourier
			name = AL["Stratholme Courier"],
			npcID = 11082,
			Level = 57,
			DisplayIDs = {{10547}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  13303 }, -- Crusaders' Square Postbox Key
				{ 2,  13305 }, -- Elders' Square Postbox Key
				{ 3,  13304 }, -- Festival Lane Postbox Key
				{ 4,  13307 }, -- Fras Siabi's Postbox Key
				{ 5,  13306 }, -- King's Square Postbox Key
				{ 6,  13302 }, -- Market Row Postbox Key
			},
		},
		{ -- STRATHearthsingerForresten
			name = AL["Hearthsinger Forresten"],
			npcID = 10558,
			Level = 57,
			SubAreaID = 32277,
			DisplayIDs = {{10482}},
			AtlasMapBossID = 3,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13378 }, -- Songbird Blouse
				{ 2,  13384 }, -- Rainbow Girdle
				{ 3,  13383 }, -- Woollies of the Prancing Minstrel
				{ 4,  13379 }, -- Piccolo of the Flaming Fire
			},
		},
		{ -- STRATTheUnforgiven
			name = AL["The Unforgiven"],
			npcID = 10516,
			Level = 57,
			SubAreaID = 32281,
			DisplayIDs = {{10771}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  16717 }, -- Wildheart Gloves
				{ 3,  13404 }, -- Mask of the Unforgiven
				{ 4,  13405 }, -- Wailing Nightbane Pauldrons
				{ 5,  13409 }, -- Tearfall Bracers
				{ 6,  13408 }, -- Soul Breaker
			},
		},
		{ -- STRATTimmytheCruel
			name = AL["Timmy the Cruel"],
			npcID = 10808,
			Level = 58,
			SubAreaID = 32319,
			DisplayIDs = {{571}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  13400 }, -- Vambraces of the Sadist
				{ 2,  13403 }, -- Grimgore Noose
				{ 3,  13402 }, -- Timmy's Galoshes
				{ 4,  13401 }, -- The Cruel Hand of Timmy
			},
		},
		{ -- STRATMalorsStrongbox
			name = AL["Malor the Zealous"],
			npcID = 11032,
			ObjectID = 176112,
			Level = 60,
			SubAreaID = 32319,
			DisplayIDs = {{10458}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2,  12845 }, -- Medallion of Faith
			},
		},
		{ -- STRATCrimsonHammersmith
			name = AL["Crimson Hammersmith"],
			npcID = 11120,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10637}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
				--{ 3,  12824 }, -- Plans: Enchanted Battlehammer
			},
		},
		{ -- STRATCannonMasterWilley
			name = AL["Cannon Master Willey"],
			npcID = 10997,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = {{10674}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  16708 }, -- Shadowcraft Spaulders
				{ 3,  22407 }, -- Helm of the New Moon
				{ 4,  22403 }, -- Diana's Pearl Necklace
				{ 5,  22405 }, -- Mantle of the Scarlet Crusade
				{ 6,  18721 }, -- Barrage Girdle
				{ 7,  13381 }, -- Master Cannoneer Boots
				{ 8,  13382 }, -- Cannonball Runner
				{ 9,  13380 }, -- Willey's Portable Howitzer
				{ 10, 13377 }, -- Miniature Cannon Balls
				{ 11, 22404 }, -- Willey's Back Scratcher
				{ 12, 22406 }, -- Redemption
				{ 16, 12839 }, -- Plans: Heartseeker
			},
		},
		{ -- STRATArchivistGalford
			name = AL["Archivist Galford"],
			npcID = 10811,
			Level = 60,
			SubAreaID = 32331,
			DisplayIDs = {{10544}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  16692 }, -- Devout Gloves
				{ 3,  13386 }, -- Archivist Cape
				{ 4,  13387 }, -- Foresight Girdle
				{ 5,  18716 }, -- Ash Covered Boots
				{ 6,  13385 }, -- Tome of Knowledge
				{ 8,  12811 }, -- Righteous Orb
				{ 10, 22897 }, -- Tome of Conjure Food VII
			},
		},
		{ -- STRATBalnazzar
			name = AL["Balnazzar"],
			npcID = {10812, 10813},
			Level = 999,
			SubAreaID = 32367,
			DisplayIDs = {{10545}, {10691}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  13353 }, -- Book of the Dead
				{ 2,  14512 }, -- Pattern: Truefaith Vestments
				{ 4,  16725 }, -- Lightforge Boots
				{ 6,  13359 }, -- Crown of Tyranny
				{ 7,  18718 }, -- Grand Crusader's Helm
				{ 8,  12103 }, -- Star of Mystaria
				{ 9, 18720 }, -- Shroud of the Nathrezim
				{ 10, 13358 }, -- Wyrmtongue Shoulders
				{ 11, 13369 }, -- Fire Striders
				{ 12, 13360 }, -- Gift of the Elven Magi
				{ 13, 18717 }, -- Hammer of the Grand Crusader
				{ 14,  22334 }, -- Band of Mending
				{ 15, 13348 }, -- Demonshear
				{ 16, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 18, 13250 }, -- Head of Balnazzar
			},
		},
		{ -- STRATMagistrateBarthilas
			name = AL["Magistrate Barthilas"],
			npcID = 10435,
			Level = 58,
			SubAreaID = 32342,
			DisplayIDs = {{10433}},
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  18727 }, -- Crimson Felt Hat
				{ 2,  13376 }, -- Royal Tribunal Cloak
				{ 3,  18726 }, -- Magistrate's Cuffs
				{ 4,  18722 }, -- Death Grips
				{ 5,  23198 }, -- Idol of Brutality
				{ 6,  18725 }, -- Peacemaker
				{ 8,  12382 }, -- Key to the City
			},
		},
		{ -- STRATStonespine
			name = AL["Stonespine"],
			npcID = 10809,
			Level = 60,
			SubAreaID = 32303,
			DisplayIDs = {{7856}},
			AtlasMapBossID = 14,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1,  13397 }, -- Stoneskin Gargoyle Cape
				{ 2,  13954 }, -- Verdant Footpads
				{ 3,  13399 }, -- Gargoyle Shredder Talons
			},
		},
		{ -- STRATBaronessAnastari
			name = AL["Baroness Anastari"],
			npcID = 10436,
			Level = 59,
			SubAreaID = 32344,
			DisplayIDs = {{10698}},
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  16704 }, -- Dreadmist Sandals
				{ 3,  18728 }, -- Anastari Heirloom
				{ 4,  18730 }, -- Shadowy Laced Handwraps
				{ 5,  18729 }, -- Screeching Bow
				{ 6,  13534 }, -- Banshee Finger
				{ 8,  13538 }, -- Windshrieker Pauldrons
				{ 9,  13535 }, -- Coldtouch Phantom Wraps
				{ 10, 13537 }, -- Chillhide Bracers
				{ 11, 13539 }, -- Banshee's Touch
				{ 12, 13514 }, -- Wail of the Banshee
			},
		},
		{ -- STRATBlackGuardSwordsmith
			name = AL["Black Guard Swordsmith"],
			npcID = 11121,
			Level = {61, 62},
			SubAreaID = 32345,
			DisplayIDs = {{775}},
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				--{ 2,  12725 }, -- Plans: Enchanted Thorium Helm
				--{ 3,  12620 }, -- Enchanted Thorium Helm
				--{ 3,  12825 }, -- Plans: Blazing Rapier
				--{ 6,  12777 }, -- Blazing Rapier
			},
		},
		{ -- STRATNerubenkan
			name = AL["Nerub'enkan"],
			npcID = 10437,
			Level = 60,
			SubAreaID = 32345,
			DisplayIDs = {{9793}},
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1,  16675 }, -- Beaststalker's Boots
				{ 3,  18740 }, -- Thuzadin Sash
				{ 4,  18739 }, -- Chitinous Plate Legguards
				{ 5,  18738 }, -- Carapace Spine Crossbow
				{ 6,  13529 }, -- Husk of Nerub'enkan
				{ 8,  13533 }, -- Acid-etched Pauldrons
				{ 9,  13532 }, -- Darkspinner Claws
				{ 10, 13531 }, -- Crypt Stalker Leggings
				{ 11, 13530 }, -- Fangdrip Runners
				{ 12, 13508 }, -- Eye of Arachnida
			},
		},
		{ -- STRATMalekithePallid
			name = AL["Maleki the Pallid"],
			npcID = 10438,
			Level = 61,
			SubAreaID = 32349,
			DisplayIDs = {{10546}},
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1,  16691 }, -- Devout Sandals
				{ 3,  18734 }, -- Pale Moon Cloak
				{ 4,  18735 }, -- Maleki's Footwraps
				{ 5,  13524 }, -- Skull of Burning Shadows
				{ 6,  18737 }, -- Bone Slicing Hatchet
				{ 8,  13528 }, -- Twilight Void Bracers
				{ 9,  13525 }, -- Darkbind Fingers
				{ 10, 13526 }, -- Flamescarred Girdle
				{ 11, 13527 }, -- Lavawalker Greaves
				{ 12, 13509 }, -- Clutch of Foresight
				{ 16, 12833 }, -- Plans: Hammer of the Titans
			},
		},
		{ -- STRATRamsteintheGorger
			name = AL["Ramstein the Gorger"],
			npcID = 10439,
			Level = 61,
			SubAreaID = 32301,
			DisplayIDs = {{12818}},
			AtlasMapBossID = 18,
			[NORMAL_DIFF] = {
				{ 1,  16737 }, -- Gauntlets of Valor
				{ 3,  18723 }, -- Animated Chain Necklace
				{ 4,  13374 }, -- Soulstealer Mantle
				{ 5,  13373 }, -- Band of Flesh
				{ 6,  13515 }, -- Ramstein's Lightning Bolts
				{ 7,  13375 }, -- Crest of Retribution
				{ 8,  13372 }, -- Slavedriver's Cane
			},
		},
		{ -- STRATBaronRivendare
			name = AL["Baron Rivendare"],
			npcID = 10440,
			Level = 62,
			SubAreaID = 32352,
			DisplayIDs = {{10729}},
			AtlasMapBossID = 19,
			[NORMAL_DIFF] = {
				{ 1,  13335 }, -- Deathcharger's Reins
				{ 2,  13505 }, -- Runeblade of Baron Rivendare
				{ 4,  22411 }, -- Helm of the Executioner
				{ 5,  22412 }, -- Thuzadin Mantle
				{ 6,  13340 }, -- Cape of the Black Baron
				{ 7,  13346 }, -- Robes of the Exalted
				{ 8,  22409 }, -- Tunic of the Crescent Moon
				{ 9,  13344 }, -- Dracorian Gauntlets
				{ 10, 22410 }, -- Gauntlets of Deftness
				{ 11, 13345 }, -- Seal of Rivendare
				{ 12, 22408 }, -- Ritssyn's Wand of Bad Mojo
				{ 13, 13349 }, -- Scepter of the Unholy
				{ 14, 13368 }, -- Bonescraper
				{ 15, 13361 }, -- Skullforge Reaver
				{ 16, 16694 }, -- Devout Skirt
				{ 17, 16687 }, -- Magister's Leggings
				{ 18, 16699 }, -- Dreadmist Leggings
				{ 19, 16709 }, -- Shadowcraft Pants
				{ 20, 16719 }, -- Wildheart Kilt
				{ 21, 16678 }, -- Beaststalker's Pants
				{ 22, 16668 }, -- Kilt of Elements
				{ 23, 16728 }, -- Lightforge Legplates
				{ 24, 16732 }, -- Legplates of Valor
			},
		},
		{ -- STRATPostmaster
			name = AL["Postmaster Malown"],
			npcID = 11143,
			Level = 60,
			DisplayIDs = {{10669}},
			AtlasMapBossID = "6'",
			[NORMAL_DIFF] = {
				{ 1,  16682 }, -- Magister's Boots
				{ 3,  13390 }, -- The Postmaster's Band
				{ 4,  13388 }, -- The Postmaster's Tunic
				{ 5,  13389 }, -- The Postmaster's Trousers
				{ 6,  13391 }, -- The Postmaster's Treads
				{ 7,  13392 }, -- The Postmaster's Seal
				{ 8,  13393 }, -- Malown's Slam
			},
		},
		{ -- STRATTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  16697 }, -- Devout Bracers
				{ 2,  16685 }, -- Magister's Belt
				{ 3,  16702 }, -- Dreadmist Belt
				{ 4,  16710 }, -- Shadowcraft Bracers
				{ 5,  16714 }, -- Wildheart Bracers
				{ 6,  16681 }, -- Beaststalker's Bindings
				{ 7,  16671 }, -- Bindings of Elements
				{ 8,  16723 }, -- Lightforge Belt
				{ 9,  16736 }, -- Belt of Valor
				{ 11, 12811 }, -- Righteous Orb
				{ 12, 12735 }, -- Frayed Abomination Stitching
				{ 13, 12843 }, -- Corruptor's Scourgestone
				{ 14, 12841 }, -- Invader's Scourgestone
				{ 15, 12840 }, -- Minion's Scourgestone
				{ 16, 18742 }, -- Stratholme Militia Shoulderguard
				{ 17, 18743 }, -- Gracious Cape
				{ 18, 17061 }, -- Juno's Shadow
				{ 19, 18741 }, -- Morlune's Bracer
				{ 20, 18744 }, -- Plaguebat Fur Gloves
				{ 21, 18745 }, -- Sacred Cloth Leggings
				{ 22, 18736 }, -- Plaguehound Leggings
				{ 24, 16249 }, -- Formula: Enchant 2H Weapon - Major Intellect
				{ 25, 16248 }, -- Formula: Enchant Weapon - Unholy
				{ 26, 14495 }, -- Pattern: Ghostweave Pants
				{ 27, 15777 }, -- Pattern: Runic Leather Shoulders
				{ 28, 15768 }, -- Pattern: Wicked Leather Belt
				{ 29, 18658 }, -- Schematic: Ultra-Flash Shadow Reflector
				{ 30, 16052 }, -- Schematic: Voice Amplification Modulator
			},
		},
		{ -- STRATBSPlansSerenity / STRATBSPlansCorruption
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  12827 }, -- Plans: Serenity
				{ 2,  12781 }, -- Serenity
				{ 16,  12830 }, -- Plans: Corruption
				{ 17,  12782 }, -- Corruption
			},
		},
		{ -- STRATAtiesh
			name = AL["Atiesh"],
			ExtraList = true,
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  22736 }, -- Andonisus, Reaper of Souls
			},
		},
		{ -- STRATBalzaphon
			name = AL["Balzaphon"],
			ExtraList = true,
			npcID = 14684,
			DisplayIDs = {{7919}},
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1,  23125 }, -- Chains of the Lich
				{ 2,  23126 }, -- Waistband of Balzaphon
				{ 3,  23124 }, -- Staff of Balzaphon
			},
		},
		{ -- STRATSothosJarien
			name = AL["Sothos and Jarien's Heirlooms"].." - "..format(AL["Tier %s Sets"], "0.5"),
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  22327 }, -- Amulet of the Redeemed
				{ 2,  22301 }, -- Ironweave Robe
				{ 3,  22328 }, -- Legplates of Vigilance
				{ 4,  22334 }, -- Band of Mending
				{ 5,  22329 }, -- Scepter of Interminable Focus
			},
		},
		KEYS,
	},
}

-- ########################
-- Raids
-- ########################
data["WorldBosses"] = {
	name = AL["World Bosses"],
	AtlasMapFile = "Azuregos",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2,
	items = {
		{ -- AAzuregos
			name = AL["Azuregos"],
			AtlasMapFile = "Azuregos",
			npcID = 6109,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = {{11460}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  19132 }, -- Crystal Adorned Crown
				{ 2,  18208 }, -- Drape of Benediction
				{ 3,  18541 }, -- Puissant Cape
				{ 4,  18547 }, -- Unmelting Ice Girdle
				{ 5,  18545 }, -- Leggings of Arcane Supremacy
				{ 6,  19131 }, -- Snowblind Shoes
				{ 7,  19130 }, -- Cold Snap
				{ 8,  17070 }, -- Fang of the Mystics
				{ 9,  18202 }, -- Eskhandar's Left Claw
				{ 10, 18542 }, -- Typhoon
				{ 16, 18704 }, -- Mature Blue Dragon Sinew
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- KKazzak
			name = AL["Lord Kazzak"],
			AtlasMapFile = "LordKazzak",
			npcID = 12397,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = {{12449}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  18546 }, -- Infernal Headcage
				{ 2,  17111 }, -- Blazefury Medallion
				{ 3,  18204 }, -- Eskhandar's Pelt
				{ 4,  19135 }, -- Blacklight Bracer
				{ 5,  18544 }, -- Doomhide Gauntlets
				{ 6,  19134 }, -- Flayed Doomguard Belt
				{ 7,  19133 }, -- Fel Infused Leggings
				{ 8,  18543 }, -- Ring of Entropy
				{ 9,  17112 }, -- Empyrean Demolisher
				{ 10, 17113 }, -- Amberseal Keeper
				{ 16, 18665 }, -- The Eye of Shadow
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DLethon
			name = AL["Lethon"],
			AtlasMapFile = "FourDragons",
			npcID = 14888,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15365}},
			[NORMAL_DIFF] = {
				{ 1,  20628 }, -- Deviate Growth Cap
				{ 2,  20626 }, -- Black Bark Wristbands
				{ 3,  20630 }, -- Gauntlets of the Shining Light
				{ 4,  20625 }, -- Belt of the Dark Bog
				{ 5,  20627 }, -- Dark Heart Pants
				{ 6,  20629 }, -- Malignant Footguards
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DEmeriss
			name = AL["Emeriss"],
			AtlasMapFile = "FourDragons",
			npcID = 14889,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15366}},
			[NORMAL_DIFF] = {
				{ 1,  20623 }, -- Circlet of Restless Dreams
				{ 2,  20622 }, -- Dragonheart Necklace
				{ 3,  20624 }, -- Ring of the Unliving
				{ 4,  20621 }, -- Boots of the Endless Moor
				{ 5,  20599 }, -- Polished Ironwood Crossbow
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DTaerar
			name = AL["Taerar"],
			AtlasMapFile = "FourDragons",
			npcID = 14890,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15363}, {15367}},
			[NORMAL_DIFF] = {
				{ 1,  20633 }, -- Unnatural Leather Spaulders
				{ 2,  20631 }, -- Mendicant's Slippers
				{ 3,  20634 }, -- Boots of Fright
				{ 4,  20632 }, -- Mindtear Band
				{ 5,  20577 }, -- Nightmare Blade
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- DYsondre
			name = AL["Ysondre"],
			AtlasMapFile = "FourDragons",
			npcID = 14887,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = {{15364}},
			[NORMAL_DIFF] = {
				{ 1,  20637 }, -- Acid Inscribed Pauldrons
				{ 2,  20635 }, -- Jade Inlaid Vestments
				{ 3,  20638 }, -- Leggings of the Demented Mind
				{ 4,  20639 }, -- Strangely Glyphed Legplates
				{ 5,  20636 }, -- Hibernation Crystal
				{ 6,  20578 }, -- Emerald Dragonfang
				{ 9,  20579 }, -- Green Dragonskin Cloak
				{ 10, 20615 }, -- Dragonspur Wraps
				{ 11, 20616 }, -- Dragonbone Wristguards
				{ 12, 20618 }, -- Gloves of Delusional Power
				{ 13, 20617 }, -- Ancient Corroded Leggings
				{ 14, 20619 }, -- Acid Inscribed Greaves
				{ 15, 20582 }, -- Trance Stone
				{ 16, 20644 }, -- Nightmare Engulfed Object
				{ 17, 20600 }, -- Malfurion's Signet Ring
				{ 24, 20580 }, -- Hammer of Bestial Fury
				{ 25, 20581 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	}
}

data["MoltenCore"] = {
	MapID = 2717,
	InstanceID = 409,
	AtlasMapID = "MoltenCore",
	AtlasMapFile = "MoltenCore",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{	--MCLucifron
			name = AL["Lucifron"],
			npcID = 12118,
			Level = 999,
			DisplayIDs = {{13031},{12030}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 16800 },	-- Arcanist Boots
				{ 2, 16805 },	-- Felheart Gloves
				{ 3, 16829 },	-- Cenarion Boots
				{ 4, 16837 },	-- Earthfury Boots
				{ 5, 16859 },	-- Lawbringer Boots
				{ 6, 16863 },	-- Gauntlets of Might
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 17109 },	-- Choker of Enlightenment
				{ 18, 19145 },	-- Robe of Volatile Power
				{ 19, 19146 },	-- Wristguards of Stability
				{ 20, 18872 },	-- Manastorm Leggings
				{ 21, 18875 },	-- Salamander Scale Pants
				{ 22, 18861 },	-- Flamewaker Legplates
				{ 23, 18879 },	-- Heavy Dark Iron Ring
				{ 24, 19147 },	-- Ring of Spell Power
				{ 25, 17077 },	-- Crimson Shocker
				{ 26, 18878 },	-- Sorcerous Dagger
				{ 30, 16665 },	-- Tome of Tranquilizing Shot
			},
		},
		{	--MCMagmadar
			name = AL["Magmadar"],
			npcID = 11982,
			Level = 999,
			DisplayIDs = {{10193}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  16814 },	-- Pants of Prophecy
				{ 2,  16796 },	-- Arcanist Leggings
				{ 3,  16810 },	-- Felheart Pants
				{ 4,  16822 },	-- Nightslayer Pants
				{ 5,  16835 },	-- Cenarion Leggings
				{ 6,  16847 },	-- Giantstalker's Leggings
				{ 7,  16843 },	-- Earthfury Legguards
				{ 8,  16855 },	-- Lawbringer Legplates
				{ 9,  16867 },	-- Legplates of Might
				{ 11, 18203 },	-- Eskhandar's Right Claw
				{ 16, 17065 },	-- Medallion of Steadfast Might
				{ 17, 18829 },	-- Deep Earth Spaulders
				{ 18, 18823 },	-- Aged Core Leather Gloves
				{ 19, 19143 },	-- Flameguard Gauntlets
				{ 20, 19136 },	-- Mana Igniting Cord
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 19144 },	-- Sabatons of the Flamewalker
				{ 23, 18824 },	-- Magma Tempered Boots
				{ 24, 18821 },	-- Quick Strike Ring
				{ 25, 18820 },	-- Talisman of Ephemeral Power
				{ 26, 19142 },	-- Fire Runed Grimoire
				{ 27, 17069 },	-- Striker's Mark
				{ 28, 17073 },	-- Earthshaker
				{ 29, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCGehennas
			name = AL["Gehennas"],
			npcID = 12259,
			Level = 999,
			DisplayIDs = {{13030},{12002}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  16812 },	-- Gloves of Prophecy
				{ 2,  16826 },	-- Nightslayer Gloves
				{ 3,  16849 },	-- Giantstalker's Boots
				{ 4,  16839 },	-- Earthfury Gauntlets
				{ 5,  16860 },	-- Lawbringer Gauntlets
				{ 6,  16862 },	-- Sabatons of Might
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 19145 },	-- Robe of Volatile Power
				{ 18, 19146 },	-- Wristguards of Stability
				{ 19, 18872 },	-- Manastorm Leggings
				{ 20, 18875 },	-- Salamander Scale Pants
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 18879 },	-- Heavy Dark Iron Ring
				{ 23, 19147 },	-- Ring of Spell Power
				{ 24, 17077 },	-- Crimson Shocker
				{ 25, 18878 },	-- Sorcerous Dagger
			},
		},
		{	--MCGarr
			name = AL["Garr"],
			npcID = 12057,
			Level = 999,
			DisplayIDs = {{12110}, {5781}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 18564 },	-- Bindings of the Windseeker
				{ 3,  16813 },	-- Circlet of Prophecy
				{ 4,  16795 },	-- Arcanist Crown
				{ 5,  16808 },	-- Felheart Horns
				{ 6,  16821 },	-- Nightslayer Cover
				{ 7,  16834 },	-- Cenarion Helm
				{ 8,  16846 },	-- Giantstalker's Helmet
				{ 9,  16842 },	-- Earthfury Helmet
				{ 10,  16854 },	-- Lawbringer Helm
				{ 11,  16866 },	-- Helm of Might
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 18820 },	-- Talisman of Ephemeral Power
				{ 25, 19142 },	-- Fire Runed Grimoire
				{ 26, 17066 },	-- Drillborer Disk
				{ 27, 17071 },	-- Gutgore Ripper
				{ 28, 17105 },	-- Aurastone Hammer
				{ 29, 18832 },	-- Brutality Blade
				{ 30, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCShazzrah
			name = AL["Shazzrah"],
			npcID = 12264,
			Level = 999,
			DisplayIDs = {{13032}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  16811 },	-- Boots of Prophecy
				{ 2,  16801 },	-- Arcanist Gloves
				{ 3,  16803 },	-- Felheart Slippers
				{ 4,  16824 },	-- Nightslayer Boots
				{ 5,  16831 },	-- Cenarion Gloves
				{ 6,  16852 },	-- Giantstalker's Gloves
				{ 16, 18870 },	-- Helm of the Lifegiver
				{ 17, 19145 },	-- Robe of Volatile Power
				{ 18, 19146 },	-- Wristguards of Stability
				{ 19, 18872 },	-- Manastorm Leggings
				{ 20, 18875 },	-- Salamander Scale Pants
				{ 21, 18861 },	-- Flamewaker Legplates
				{ 22, 18879 },	-- Heavy Dark Iron Ring
				{ 23, 19147 },	-- Ring of Spell Power
				{ 24, 17077 },	-- Crimson Shocker
				{ 25, 18878 },	-- Sorcerous Dagger
			},
		},
		{	--MCGeddon
			name = AL["Baron Geddon"],
			npcID = 12056,
			Level = 999,
			DisplayIDs = {{12129}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18563 },	-- Bindings of the Windseeker
				{ 3,  16797 },	-- Arcanist Mantle
				{ 4,  16807 },	-- Felheart Shoulder Pads
				{ 5,  16836 },	-- Cenarion Spaulders
				{ 6,  16844 },	-- Earthfury Epaulets
				{ 7,  16856 },	-- Lawbringer Spaulders
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 17110 },	-- Seal of the Archmagus
				{ 25, 18820 },	-- Talisman of Ephemeral Power
				{ 26, 19142 },	-- Fire Runed Grimoire
				{ 27, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCGolemagg
			name = AL["Golemagg the Incinerator"],
			npcID = 11988,
			Level = 999,
			DisplayIDs = {{11986}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  16815 },	-- Robes of Prophecy
				{ 2,  16798 },	-- Arcanist Robes
				{ 3,  16809 },	-- Felheart Robes
				{ 4,  16820 },	-- Nightslayer Chestpiece
				{ 5,  16833 },	-- Cenarion Vestments
				{ 6,  16845 },	-- Giantstalker's Breastplate
				{ 7,  16841 },	-- Earthfury Vestments
				{ 8,  16853 },	-- Lawbringer Chestguard
				{ 9,  16865 },	-- Breastplate of Might
				{ 11, 17203 },	-- Sulfuron Ingot
				{ 16, 18829 },	-- Deep Earth Spaulders
				{ 17, 18823 },	-- Aged Core Leather Gloves
				{ 18, 19143 },	-- Flameguard Gauntlets
				{ 19, 19136 },	-- Mana Igniting Cord
				{ 20, 18861 },	-- Flamewaker Legplates
				{ 21, 19144 },	-- Sabatons of the Flamewalker
				{ 22, 18824 },	-- Magma Tempered Boots
				{ 23, 18821 },	-- Quick Strike Ring
				{ 24, 18820 },	-- Talisman of Ephemeral Power
				{ 25, 19142 },	-- Fire Runed Grimoire
				{ 26, 17072 },	-- Blastershot Launcher
				{ 27, 17103 },	-- Azuresong Mageblade
				{ 28, 18822 },	-- Obsidian Edged Blade
				{ 29, 18842 },	-- Staff of Dominance
			},
		},
		{ -- MCSulfuron
			name = AL["Sulfuron Harbinger"],
			npcID = 12098,
			Level = 999,
			DisplayIDs = {{13030},{12030}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  16816 }, -- Mantle of Prophecy
				{ 2,  16823 }, -- Nightslayer Shoulder Pads
				{ 3,  16848 }, -- Giantstalker's Epaulets
				{ 4,  16868 }, -- Pauldrons of Might
				{ 16, 18870 }, -- Helm of the Lifegiver
				{ 17, 19145 }, -- Robe of Volatile Power
				{ 18, 19146 }, -- Wristguards of Stability
				{ 19, 18872 }, -- Manastorm Leggings
				{ 20, 18875 }, -- Salamander Scale Pants
				{ 21, 18861 }, -- Flamewaker Legplates
				{ 22, 18879 }, -- Heavy Dark Iron Ring
				{ 23, 19147 }, -- Ring of Spell Power
				{ 24, 17077 }, -- Crimson Shocker
				{ 25, 18878 }, -- Sorcerous Dagger
				{ 26, 17074 }, -- Shadowstrike
			},
		},
		{ -- MCMajordomo
			name = AL["Majordomo Executus"],
			npcID = 12018,
			Level = 999,
			ObjectID = 179703,
			DisplayIDs = {{12029},{13029},{12002}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  19139 }, -- Fireguard Shoulders
				{ 2,  18810 }, -- Wild Growth Spaulders
				{ 3,  18811 }, -- Fireproof Cloak
				{ 4,  18808 }, -- Gloves of the Hypnotic Flame
				{ 5,  18809 }, -- Sash of Whispered Secrets
				{ 6,  18812 }, -- Wristguards of True Flight
				{ 7,  18806 }, -- Core Forged Greaves
				{ 8,  19140 }, -- Cauterizing Band
				{ 9,  18805 }, -- Core Hound Tooth
				{ 10, 18803 }, -- Finkle's Lava Dredger
				{ 16, 18703 }, -- Ancient Petrified Leaf
				{ 18, 18646 }, -- The Eye of Divinity
			},
		},
		{ -- MCRagnaros
			name = AL["Ragnaros"],
			npcID = 11502,
			Level = 999,
			DisplayIDs = {{11121}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 17204 }, -- Eye of Sulfuras
				{ 2, 19017 }, -- Essence of the Firelord
				{ 4,  16922 }, -- Leggings of Transcendence
				{ 5,  16915 }, -- Netherwind Pants
				{ 6,  16930 }, -- Nemesis Leggings
				{ 7,  16909 }, -- Bloodfang Pants
				{ 8,  16901 }, -- Stormrage Legguards
				{ 9,  16938 }, -- Dragonstalker's Legguards
				{ 10,  16946 }, -- Legplates of Ten Storms
				{ 11,  16954 }, -- Judgement Legplates
				{ 12,  16962 }, -- Legplates of Wrath
				{ 14, 17082 }, -- Shard of the Flame
				{ 16, 18817 }, -- Crown of Destruction
				{ 17, 18814 }, -- Choker of the Fire Lord
				{ 18, 17102 }, -- Cloak of the Shrouded Mists
				{ 19, 17107 }, -- Dragon's Blood Cape
				{ 20, 19137 }, -- Onslaught Girdle
				{ 21, 17063 }, -- Band of Accuria
				{ 22, 19138 }, -- Band of Sulfuras
				{ 23, 18815 }, -- Essence of the Pure Flame
				{ 24, 17106 }, -- Malistar's Defender
				{ 25, 18816 }, -- Perdition's Blade
				{ 26, 17104 }, -- Spinal Reaper
				{ 27, 17076 }, -- Bonereaver's Edge
			},
		},
		{ -- MCRANDOMBOSSDROPS
			name = AL["All bosses"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 3,  18292 }, -- Schematic: Core Marksman Rifle
				{ 4,  18291 }, -- Schematic: Force Reactive Disk
				{ 5, 18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 7, 18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 8, 18260 }, -- Formula: Enchant Weapon - Healing Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 18, 18265 }, -- Pattern: Flarecore Wraps
				{ 19, 21371 }, -- Pattern: Core Felcloth Bag
				{ 21, 18257 }, -- Recipe: Major Rejuvenation Potion
			},
		},
		{ -- MCTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  16817 }, -- Girdle of Prophecy
				{ 2,  16802 }, -- Arcanist Belt
				{ 3,  16806 }, -- Felheart Belt
				{ 4,  16827 }, -- Nightslayer Belt
				{ 5,  16828 }, -- Cenarion Belt
				{ 6,  16851 }, -- Giantstalker's Belt
				{ 7,  16838 }, -- Earthfury Belt
				{ 8,  16858 }, -- Lawbringer Belt
				{ 9,  16864 }, -- Belt of Might
				{ 12, 17011 }, -- Lava Core
				{ 13, 17010 }, -- Fiery Core
				{ 14, 11382 }, -- Blood of the Mountain
				{ 15, 17012 }, -- Core Leather
				{ 16, 16819 }, -- Vambraces of Prophecy
				{ 17, 16799 }, -- Arcanist Bindings
				{ 18, 16804 }, -- Felheart Bracers
				{ 19, 16825 }, -- Nightslayer Bracelets
				{ 20, 16830 }, -- Cenarion Bracers
				{ 21, 16850 }, -- Giantstalker's Bracers
				{ 22, 16840 }, -- Earthfury Bracers
				{ 23, 16857 }, -- Lawbringer Bracers
				{ 24, 16861 }, -- Bracers of Might
			},
		},
		T1_SET,
	}
}

data["Onyxia"] = {
	MapID = 2159,
	InstanceID = 249,
	AtlasMapID = "Onyxia",
	AtlasMapFile = "OnyxiasLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ -- Onyxia
			name = AL["Onyxia"],
			npcID = 10184,
			Level = 999,
			DisplayIDs = {{8570}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  16921 }, -- Halo of Transcendence
				{ 2,  16914 }, -- Netherwind Crown
				{ 3,  16929 }, -- Nemesis Skullcap
				{ 4,  16908 }, -- Bloodfang Hood
				{ 5,  16900 }, -- Stormrage Cover
				{ 6,  16939 }, -- Dragonstalker's Helm
				{ 7,  16947 }, -- Helmet of Ten Storms
				{ 8,  16955 }, -- Judgement Crown
				{ 9,  16963 }, -- Helm of Wrath
				{ 11, 18423 }, -- Head of Onyxia
				{ 12, 15410 }, -- Scale of Onyxia
				{ 16, 18705 }, -- Mature Black Dragon Sinew
				{ 18, 18205 }, -- Eskhandar's Collar
				{ 19, 17078 }, -- Sapphiron Drape
				{ 20, 18813 }, -- Ring of Binding
				{ 21, 17064 }, -- Shard of the Scale
				{ 22, 17067 }, -- Ancient Cornerstone Grimoire
				{ 23, 17068 }, -- Deathbringer
				{ 24, 17075 }, -- Vis'kag the Bloodletter
				{ 26, 17966 }, -- Onyxia Hide Backpack
				{ 27, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
	},
}

data["Zul'Gurub"] = {
	MapID = 1977,
	InstanceID = 309,
	AtlasMapID = "Zul'Gurub", -- ??
	AtlasMapFile = "ZulGurub",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 4,
	items = {
		{ -- ZGJeklik
			name = AL["High Priestess Jeklik"],
			npcID = 14517,
			Level = 999,
			DisplayIDs = {{15219}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19918 }, -- Jeklik's Crusher
				{ 18, 19923 }, -- Jeklik's Opaline Talisman
				{ 19, 19928 }, -- Animist's Spaulders
				{ 20, 20262 }, -- Seafury Boots
				{ 21, 20265 }, -- Peacekeeper Boots
				{ 22, 19920 }, -- Primalist's Band
				{ 23, 19915 }, -- Zulian Defender
			},
		},
		{ -- ZGVenoxis
			name = AL["High Priest Venoxis"],
			npcID = 14507,
			Level = 999,
			DisplayIDs = {{15217}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19904 }, -- Runed Bloodstained Hauberk
				{ 17, 19903 }, -- Fang of Venoxis
				{ 19, 19907 }, -- Zulian Tigerhide Cloak
				{ 20, 19906 }, -- Blooddrenched Footpads
				{ 21, 19905 }, -- Zanzil's Band
				{ 22, 19900 }, -- Zulian Stone Axe
			},
		},
		{ -- ZGMarli
			name = AL["High Priestess Mar'li"],
			npcID = 14510,
			Level = 999,
			DisplayIDs = {{15220}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 20032 }, -- Flowing Ritual Robes
				{ 17, 19927 }, -- Mar'li's Touch
				{ 19, 19871 }, -- Talisman of Protection
				{ 20, 19919 }, -- Bloodstained Greaves
				{ 21, 19925 }, -- Band of Jin
				{ 22, 19930 }, -- Mar'li's Eye
			},
		},
		{ -- ZGMandokir
			name = AL["Bloodlord Mandokir"],
			npcID = 11382,
			Level = 999,
			DisplayIDs = {{11288}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19872 }, -- Swift Razzashi Raptor
				{ 17, 20038 }, -- Mandokir's Sting
				{ 18, 19867 }, -- Bloodlord's Defender
				{ 19, 19866 }, -- Warblade of the Hakkari
				{ 20, 19874 }, -- Halberd of Smiting
				{ 22, 19878 }, -- Bloodsoaked Pauldrons
				{ 23, 19870 }, -- Hakkari Loa Cloak
				{ 24, 19869 }, -- Blooddrenched Grips
				{ 25, 19895 }, -- Bloodtinged Kilt
				{ 26, 19877 }, -- Animist's Leggings
				{ 27, 19873 }, -- Overlord's Crimson Band
				{ 28, 19863 }, -- Primalist's Seal
				{ 29, 19893 }, -- Zanzil's Seal
			},
		},
		{ -- ZGGrilek
			name = AL["Gri'lek"],
			npcID = 15082,
			Level = 999,
			DisplayIDs = {{8390}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  19961 }, -- Gri'lek's Grinder
				{ 2,  19962 }, -- Gri'lek's Carver
				{ 4,  19939 }, -- Gri'lek's Blood
			},
		},
		{ -- ZGHazzarah
			name = AL["Hazza'rah"],
			npcID = 15083,
			Level = 999,
			DisplayIDs = {{15267}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  19967 }, -- Thoughtblighter
				{ 2,  19968 }, -- Fiery Retributer
				{ 4,  19942 }, -- Hazza'rah's Dream Thread
			},
		},
		{ -- ZGRenataki
			name = AL["Renataki"],
			npcID = 15084,
			Level = 999,
			DisplayIDs = {{15268}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  19964 }, -- Renataki's Soul Conduit
				{ 2,  19963 }, -- Pitchfork of Madness
				{ 4,  19940 }, -- Renataki's Tooth
			},
		},
		{ -- ZGWushoolay
			name = AL["Wushoolay"],
			npcID = 15085,
			Level = 999,
			DisplayIDs = {{15269}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  19993 }, -- Hoodoo Hunting Bow
				{ 2,  19965 }, -- Wushoolay's Poker
				{ 4,  19941 }, -- Wushoolay's Mane
			},
		},
		{ -- ZGGahzranka
			name = AL["Gahz'ranka"],
			npcID = 15114,
			Level = 999,
			DisplayIDs = {{15288}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  19945 }, -- Foror's Eyepatch
				{ 2,  19944 }, -- Nat Pagle's Fish Terminator
				{ 4,  19947 }, -- Nat Pagle's Broken Reel
				{ 5,  19946 }, -- Tigule's Harpoon
				{ 7,  22739 }, -- Tome of Polymorph: Turtle
			},
		},
		{ -- ZGThekal
			name = AL["High Priest Thekal"],
			npcID = 14509,
			Level = 999,
			DisplayIDs = {{15216}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19902 }, -- Swift Zulian Tiger
				{ 17, 19897 }, -- Betrayer's Boots
				{ 18, 19896 }, -- Thekal's Grasp
				{ 20, 19899 }, -- Ritualistic Legguards
				{ 21, 20260 }, -- Seafury Leggings
				{ 22, 20266 }, -- Peacekeeper Leggings
				{ 23, 19898 }, -- Seal of Jin
				{ 24, 19901 }, -- Zulian Slicer
			},
		},
		{ -- ZGArlokk
			name = AL["High Priestess Arlokk"],
			npcID = 14515,
			Level = 999,
			DisplayIDs = {{15218}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19910 }, -- Arlokk's Grasp
				{ 17, 19909 }, -- Will of Arlokk
				{ 19, 19913 }, -- Bloodsoaked Greaves
				{ 20, 19912 }, -- Overlord's Onyx Band
				{ 21, 19922 }, -- Arlokk's Hoodoo Stick
				{ 22, 19914 }, -- Panther Hide Sack
			},
		},
		{ -- ZGJindo
			name = AL["Jin'do the Hexxer"],
			npcID = 11380,
			Level = 999,
			DisplayIDs = {{11311}},
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19885 }, -- Jin'do's Evil Eye
				{ 17, 19891 }, -- Jin'do's Bag of Whammies
				{ 18, 19890 }, -- Jin'do's Hexxer
				{ 19, 19884 }, -- Jin'do's Judgement
				{ 21, 19886 }, -- The Hexxer's Cover
				{ 22, 19875 }, -- Bloodstained Coif
				{ 23, 19888 }, -- Overlord's Embrace
				{ 24, 19929 }, -- Bloodtinged Gloves
				{ 25, 19894 }, -- Bloodsoaked Gauntlets
				{ 26, 19889 }, -- Blooddrenched Leggings
				{ 27, 19887 }, -- Bloodstained Legplates
				{ 28, 19892 }, -- Animist's Boots
			},
		},
		{ -- ZGHakkar
			name = AL["Hakkar"],
			npcID = 14834,
			Level = 999,
			DisplayIDs = {{15295}},
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  19857 }, -- Cloak of Consumption
				{ 2,  20257 }, -- Seafury Gauntlets
				{ 3,  20264 }, -- Peacekeeper Gauntlets
				{ 4,  19855 }, -- Bloodsoaked Legplates
				{ 6,  19876 }, -- Soul Corrupter's Necklace
				{ 7,  19856 }, -- The Eye of Hakkar
				{ 8,  19861 }, -- Touch of Chaos
				{ 9,  19853 }, -- Gurubashi Dwarf Destroyer
				{ 10, 19862 }, -- Aegis of the Blood God
				{ 11, 19864 }, -- Bloodcaller
				{ 12, 19865 }, -- Warblade of the Hakkari
				{ 13, 19852 }, -- Ancient Hakkari Manslayer
				{ 14, 19859 }, -- Fang of the Faceless
				{ 15, 19854 }, -- Zin'rokh, Destroyer of Worlds
				{ 16, 19802 }, -- Heart of Hakkar
			},
		},
		{ -- ZGShared
			name = AL["Shared loot"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  22721 }, -- Band of Servitude
				{ 2,  22722 }, -- Seal of the Gurubashi Berserker
				{ 4,  22720 }, -- Zulian Headdress
				{ 5,  22718 }, -- Blooddrenched Mask
				{ 6,  22711 }, -- Cloak of the Hakkari Worshipers
				{ 7,  22712 }, -- Might of the Tribe
				{ 8,  22715 }, -- Gloves of the Tormented
				{ 9,  22714 }, -- Sacrificial Gauntlets
				{ 10, 22716 }, -- Belt of Untapped Power
				{ 11, 22713 }, -- Zulian Scepter of Rites
			},
		},
		{ -- ZGTrash1
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  20263 }, -- Gurubashi Helm
				{ 2,  20259 }, -- Shadow Panther Hide Gloves
				{ 3,  20261 }, -- Shadow Panther Hide Belt
				{ 4,  19921 }, -- Zulian Hacker
				{ 5,  19908 }, -- Sceptre of Smiting
				{ 6,  20258 }, -- Zulian Ceremonial Staff
				{ 8,  19727 }, -- Blood Scythe
				{ 10, 19726 }, -- Bloodvine
				{ 11, 19774 }, -- Souldarite
				{ 12, 19767 }, -- Primal Bat Leather
				{ 13, 19768 }, -- Primal Tiger Leather
				{ 16, 19820 }, -- Punctured Voodoo Doll
				{ 17, 19818 }, -- Punctured Voodoo Doll
				{ 18, 19819 }, -- Punctured Voodoo Doll
				{ 19, 19814 }, -- Punctured Voodoo Doll
				{ 20, 19821 }, -- Punctured Voodoo Doll
				{ 21, 19816 }, -- Punctured Voodoo Doll
				{ 22, 19817 }, -- Punctured Voodoo Doll
				{ 23, 19815 }, -- Punctured Voodoo Doll
				{ 24, 19813 }, -- Punctured Voodoo Doll
				{ 101, 19706 }, -- Bloodscalp Coin
				{ 102, 19701 }, -- Gurubashi Coin
				{ 103, 19700 }, -- Hakkari Coin
				{ 104, 19699 }, -- Razzashi Coin
				{ 105, 19704 }, -- Sandfury Coin
				{ 106, 19705 }, -- Skullsplitter Coin
				{ 107, 19702 }, -- Vilebranch Coin
				{ 108, 19703 }, -- Witherbark Coin
				{ 109, 19698 }, -- Zulian Coin
				{ 116, 19708 }, -- Blue Hakkari Bijou
				{ 117, 19713 }, -- Bronze Hakkari Bijou
				{ 118, 19715 }, -- Gold Hakkari Bijou
				{ 119, 19711 }, -- Green Hakkari Bijou
				{ 120, 19710 }, -- Orange Hakkari Bijou
				{ 121, 19712 }, -- Purple Hakkari Bijou
				{ 122, 19707 }, -- Red Hakkari Bijou
				{ 123, 19714 }, -- Silver Hakkari Bijou
				{ 124, 19709 }, -- Yellow Hakkari Bijou
			},
		},
		{ -- ZGEnchants
			name = AL["Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19789 }, -- Prophetic Aura
				{ 2,  19787 }, -- Presence of Sight
				{ 3,  19788 }, -- Hoodoo Hex
				{ 4,  19784 }, -- Death's Embrace
				{ 5,  19790 }, -- Animist's Caress
				{ 6,  19785 }, -- Falcon's Call
				{ 7,  19786 }, -- Vodouisant's Vigilant Embrace
				{ 8,  19783 }, -- Syncretist's Sigil
				{ 9,  19782 }, -- Presence of Might
				{ 16, 20077 }, -- Zandalar Signet of Might
				{ 17, 20076 }, -- Zandalar Signet of Mojo
				{ 18, 20078 }, -- Zandalar Signet of Serenity
				{ 20, 22635 }, -- Savage Guard
			},
		},
		{ -- ZGMuddyChurningWaters
			name = AL["Muddy Churning Waters"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1,  19975 }, -- Zulian Mudskunk
			},
		},
		{ -- ZGJinxedHoodooPile
			name = AL["Jinxed Hoodoo Pile"],
			ExtraList = true,
			AtlasMapBossID = "2'",
			[NORMAL_DIFF] = {
				{ 1,  19727 }, -- Blood Scythe
				{ 3,  19820 }, -- Punctured Voodoo Doll
				{ 4,  19818 }, -- Punctured Voodoo Doll
				{ 5,  19819 }, -- Punctured Voodoo Doll
				{ 6,  19814 }, -- Punctured Voodoo Doll
				{ 7,  19821 }, -- Punctured Voodoo Doll
				{ 8,  19816 }, -- Punctured Voodoo Doll
				{ 9,  19817 }, -- Punctured Voodoo Doll
				{ 10, 19815 }, -- Punctured Voodoo Doll
				{ 11, 19813 }, -- Punctured Voodoo Doll
			},
		},
	},
}

data["BlackwingLair"] = {
	MapID = 2677,
	InstanceID = 469,
	AtlasMapID = "BlackwingLair",
	AtlasMapFile = "BlackwingLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 3,
	items = {
		{ -- BWLRazorgore
			name = AL["Razorgore the Untamed"],
			npcID = 12435,
			Level = 999,
			DisplayIDs = {{10115}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  16926 }, -- Bindings of Transcendence
				{ 2,  16918 }, -- Netherwind Bindings
				{ 3,  16934 }, -- Nemesis Bracers
				{ 4,  16911 }, -- Bloodfang Bracers
				{ 5,  16904 }, -- Stormrage Bracers
				{ 6,  16935 }, -- Dragonstalker's Bracers
				{ 7,  16943 }, -- Bracers of Ten Storms
				{ 8,  16951 }, -- Judgement Bindings
				{ 9,  16959 }, -- Bracelets of Wrath
				{ 16, 19336 }, -- Arcane Infused Gem
				{ 17, 19337 }, -- The Black Book
				{ 19, 19370 }, -- Mantle of the Blackwing Cabal
				{ 20, 19369 }, -- Gloves of Rapid Evolution
				{ 21, 19335 }, -- Spineshatter
				{ 22, 19334 }, -- The Untamed Blade
			},
		},
		{ -- BWLVaelastrasz
			name = AL["Vaelastrasz the Corrupt"],
			npcID = 13020,
			Level = 999,
			DisplayIDs = {{13992}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  16925 }, -- Belt of Transcendence
				{ 2,  16818 }, -- Netherwind Belt
				{ 3,  16933 }, -- Nemesis Belt
				{ 4,  16910 }, -- Bloodfang Belt
				{ 5,  16903 }, -- Stormrage Belt
				{ 6,  16936 }, -- Dragonstalker's Belt
				{ 7,  16944 }, -- Belt of Ten Storms
				{ 8,  16952 }, -- Judgement Belt
				{ 9,  16960 }, -- Waistband of Wrath
				{ 16, 19339 }, -- Mind Quickening Gem
				{ 17, 19340 }, -- Rune of Metamorphosis
				{ 19, 19372 }, -- Helm of Endless Rage
				{ 20, 19371 }, -- Pendant of the Fallen Dragon
				{ 21, 19348 }, -- Red Dragonscale Protector
				{ 22, 19346 }, -- Dragonfang Blade
			},
		},
		{ -- BWLLashlayer
			name = AL["Broodlord Lashlayer"],
			npcID = 12017,
			Level = 999,
			DisplayIDs = {{14308}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  16919 }, -- Boots of Transcendence
				{ 2,  16912 }, -- Netherwind Boots
				{ 3,  16927 }, -- Nemesis Boots
				{ 4,  16906 }, -- Bloodfang Boots
				{ 5,  16898 }, -- Stormrage Boots
				{ 6,  16941 }, -- Dragonstalker's Greaves
				{ 7,  16949 }, -- Greaves of Ten Storms
				{ 8,  16957 }, -- Judgement Sabatons
				{ 9,  16965 }, -- Sabatons of Wrath
				{ 16, 19341 }, -- Lifegiving Gem
				{ 17, 19342 }, -- Venomous Totem
				{ 19, 19373 }, -- Black Brood Pauldrons
				{ 20, 19374 }, -- Bracers of Arcane Accuracy
				{ 21, 19350 }, -- Heartstriker
				{ 22, 19351 }, -- Maladath, Runed Blade of the Black Flight
				{ 24, 20383 }, -- Head of the Broodlord Lashlayer
			},
		},
		{ -- BWLFiremaw
			name = AL["Firemaw"],
			npcID = 11983,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 13, 19344 }, -- Natural Alignment Crystal
				{ 14, 19343 }, -- Scrolls of Blinding Light
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19398 }, -- Cloak of Firemaw
				{ 18, 19399 }, -- Black Ash Robe
				{ 19, 19400 }, -- Firemaw's Clutch
				{ 20, 19396 }, -- Taut Dragonhide Belt
				{ 21, 19401 }, -- Primalist's Linked Legguards
				{ 22, 19402 }, -- Legguards of the Fallen Crusader
				{ 24, 19365 }, -- Claw of the Black Drake
				{ 25, 19353 }, -- Drake Talon Cleaver
				{ 26, 19355 }, -- Shadow Wing Focus Staff
				{ 28, 19397 }, -- Ring of Blackrock
				{ 29, 19395 }, -- Rejuvenating Gem
			},
		},
		{ -- BWLEbonroc
			name = AL["Ebonroc"],
			npcID = 14601,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19345 }, -- Aegis of Preservation
				{ 12, 19406 }, -- Drake Fang Talisman
				{ 13, 19395 }, -- Rejuvenating Gem
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19405 }, -- Malfurion's Blessed Bulwark
				{ 21, 19368 }, -- Dragonbreath Hand Cannon
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19403 }, -- Band of Forced Concentration
				{ 27, 19397 }, -- Ring of Blackrock

			},
		},
		{ -- BWLFlamegor
			name = AL["Flamegor"],
			npcID = 11981,
			Level = 999,
			DisplayIDs = {{6377}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  16920 }, -- Handguards of Transcendence
				{ 2,  16913 }, -- Netherwind Gloves
				{ 3,  16928 }, -- Nemesis Gloves
				{ 4,  16907 }, -- Bloodfang Gloves
				{ 5,  16899 }, -- Stormrage Handguards
				{ 6,  16940 }, -- Dragonstalker's Gauntlets
				{ 7,  16948 }, -- Gauntlets of Ten Storms
				{ 8,  16956 }, -- Judgement Gauntlets
				{ 9,  16964 }, -- Gauntlets of Wrath
				{ 11, 19395 }, -- Rejuvenating Gem
				{ 12, 19431 }, -- Styleen's Impeding Scarab
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19430 }, -- Shroud of Pure Thought
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19433 }, -- Emberweave Leggings
				{ 21, 19367 }, -- Dragon's Touch
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19357 }, -- Herald of Woe
				{ 24, 19355 }, -- Shadow Wing Focus Staff
				{ 26, 19432 }, -- Circle of Applied Force
				{ 27, 19397 }, -- Ring of Blackrock
			},
		},
		{ -- BWLChromaggus
			name = AL["Chromaggus"],
			npcID = 14020,
			Level = 999,
			DisplayIDs = {{14367}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  16924 }, -- Pauldrons of Transcendence
				{ 2,  16917 }, -- Netherwind Mantle
				{ 3,  16932 }, -- Nemesis Spaulders
				{ 4,  16832 }, -- Bloodfang Spaulders
				{ 5,  16902 }, -- Stormrage Pauldrons
				{ 6,  16937 }, -- Dragonstalker's Spaulders
				{ 7,  16945 }, -- Epaulets of Ten Storms
				{ 8,  16953 }, -- Judgement Spaulders
				{ 9,  16961 }, -- Pauldrons of Wrath
				{ 16, 19389 }, -- Taut Dragonhide Shoulderpads
				{ 17, 19386 }, -- Elementium Threaded Cloak
				{ 18, 19390 }, -- Taut Dragonhide Gloves
				{ 19, 19388 }, -- Angelista's Grasp
				{ 20, 19393 }, -- Primalist's Linked Waistguard
				{ 21, 19392 }, -- Girdle of the Fallen Crusader
				{ 22, 19385 }, -- Empowered Leggings
				{ 23, 19391 }, -- Shimmering Geta
				{ 24, 19387 }, -- Chromatic Boots
				{ 26, 19361 }, -- Ashjre'thul, Crossbow of Smiting
				{ 27, 19349 }, -- Elementium Reinforced Bulwark
				{ 28, 19347 }, -- Claw of Chromaggus
				{ 29, 19352 }, -- Chromatically Tempered Sword
			},
		},
		{ -- BWLNefarian
			name = AL["Nefarian"],
			npcID = 11583,
			Level = 999,
			DisplayIDs = {{11380}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  16923 }, -- Robes of Transcendence
				{ 2,  16916 }, -- Netherwind Robes
				{ 3,  16931 }, -- Nemesis Robes
				{ 4,  16905 }, -- Bloodfang Chestpiece
				{ 5,  16897 }, -- Stormrage Chestguard
				{ 6,  16942 }, -- Dragonstalker's Breastplate
				{ 7,  16950 }, -- Breastplate of Ten Storms
				{ 8,  16958 }, -- Judgement Breastplate
				{ 9,  16966 }, -- Breastplate of Wrath
				{ 11, 19003 }, -- Head of Nefarian
				{ 16, 19360 }, -- Lok'amir il Romathis
				{ 17, 19363 }, -- Crul'shorukh, Edge of Chaos
				{ 18, 19364 }, -- Ashkandi, Greatsword of the Brotherhood
				{ 19, 19356 }, -- Staff of the Shadow Flame
				{ 21, 19375 }, -- Mish'undare, Circlet of the Mind Flayer
				{ 22, 19377 }, -- Prestor's Talisman of Connivery
				{ 23, 19378 }, -- Cloak of the Brood Lord
				{ 24, 19380 }, -- Therazane's Link
				{ 25, 19381 }, -- Boots of the Shadow Flame
				{ 26, 19376 }, -- Archimtiros' Ring of Reckoning
				{ 27, 19382 }, -- Pure Elementium Band
				{ 28, 19379 }, -- Neltharion's Tear
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0, 17962 }, -- Blue Sack of Gems
				{ 0, 17963 }, -- Green Sack of Gems
				{ 0, 17964 }, -- Gray Sack of Gems
				{ 0, 17965 }, -- Yellow Sack of Gems
				{ 0, 17969 }, -- Red Sack of Gems
			},
		},
		{ -- BWLTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19436 }, -- Cloak of Draconic Might
				{ 2,  19439 }, -- Interlaced Shadow Jerkin
				{ 3,  19437 }, -- Boots of Pure Thought
				{ 4,  19438 }, -- Ringo's Blizzard Boots
				{ 5,  19434 }, -- Band of Dark Dominion
				{ 6,  19435 }, -- Essence Gatherer
				{ 7,  19362 }, -- Doom's Edge
				{ 8,  19354 }, -- Draconic Avenger
				{ 9,  19358 }, -- Draconic Maul
				{ 11, 18562 }, -- Elementium Ore
			},
		},
		T2_SET,
	},
}

data["TheRuinsofAhnQiraj"] = { -- AQ20
	MapID = 3429,
	InstanceID = 509,
	AtlasMapID = "TheRuinsofAhnQiraj",
	AtlasMapFile = "TheRuinsofAhnQiraj",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 5,
	items = {
		{ -- AQ20Kurinnaxx
			name = AL["Kurinnaxx"],
			npcID = 15348,
			Level = 999,
			DisplayIDs = {{15742}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  21499 }, -- Vestments of the Shifting Sands
				{ 2,  21498 }, -- Qiraji Sacrificial Dagger
				{ 4,  21502 }, -- Sand Reaver Wristguards
				{ 5,  21501 }, -- Toughened Silithid Hide Gloves
				{ 6,  21500 }, -- Belt of the Inquisition
				{ 7,  21503 }, -- Belt of the Sand Reaver
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Rajaxx
			name = AL["General Rajaxx"],
			npcID = 15341,
			Level = 999,
			DisplayIDs = {{15376}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  21493 }, -- Boots of the Vanguard
				{ 2,  21492 }, -- Manslayer of the Qiraji
				{ 4,  21496 }, -- Bracers of Qiraji Command
				{ 5,  21494 }, -- Southwind's Grasp
				{ 6,  21495 }, -- Legplates of the Qiraji Command
				{ 7,  21497 }, -- Boots of the Qiraji General
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Moam
			name = AL["Moam"],
			npcID = 15340,
			Level = 999,
			DisplayIDs = {{15392}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  21472 }, -- Dustwind Turban
				{ 2,  21467 }, -- Thick Silithid Chestguard
				{ 3,  21479 }, -- Gauntlets of the Immovable
				{ 4,  21471 }, -- Talon of Furious Concentration
				{ 6,  21455 }, -- Southwind Helm
				{ 7,  21468 }, -- Mantle of Maz'Nadir
				{ 8,  21474 }, -- Chitinous Shoulderguards
				{ 9,  21470 }, -- Cloak of the Savior
				{ 10, 21469 }, -- Gauntlets of Southwind
				{ 11, 21476 }, -- Obsidian Scaled Leggings
				{ 12, 21475 }, -- Legplates of the Destroyer
				{ 13, 21477 }, -- Ring of Fury
				{ 14, 21473 }, -- Eye of Moam
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
				{ 24, 22220 }, -- Plans: Black Grasp of the Destroyer
				--{ 24, 22194 }, -- Black Grasp of the Destroyer
			},
		},
		{ -- AQ20Buru
			name = AL["Buru the Gorger"],
			npcID = 15370,
			Level = 999,
			DisplayIDs = {{15654}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  21487 }, -- Slimy Scaled Gauntlets
				{ 2,  21486 }, -- Gloves of the Swarm
				{ 3,  21485 }, -- Buru's Skull Fragment
				{ 5,  21491 }, -- Scaled Bracers of the Gorger
				{ 6,  21489 }, -- Quicksand Waders
				{ 7,  21490 }, -- Slime Kickers
				{ 8,  21488 }, -- Fetish of Chitinous Spikes
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ayamiss
			name = AL["Ayamiss the Hunter"],
			npcID = 15369,
			Level = 999,
			DisplayIDs = {{15431}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  21479 }, -- Gauntlets of the Immovable
				{ 2,  21478 }, -- Bow of Taut Sinew
				{ 3,  21466 }, -- Stinger of Ayamiss
				{ 5,  21484 }, -- Helm of Regrowth
				{ 6,  21480 }, -- Scaled Silithid Gauntlets
				{ 7,  21482 }, -- Boots of the Fiery Sands
				{ 8,  21481 }, -- Boots of the Desert Protector
				{ 9,  21483 }, -- Ring of the Desert Winds
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ossirian
			name = AL["Ossirian the Unscarred"],
			npcID = 15339,
			Level = 999,
			DisplayIDs = {{15432}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  21460 }, -- Helm of Domination
				{ 2,  21454 }, -- Runic Stone Shoulders
				{ 3,  21453 }, -- Mantle of the Horusath
				{ 4,  21456 }, -- Sandstorm Cloak
				{ 5,  21464 }, -- Shackles of the Unscarred
				{ 6,  21457 }, -- Bracers of Brutality
				{ 7,  21462 }, -- Gloves of Dark Wisdom
				{ 8,  21458 }, -- Gauntlets of New Life
				{ 9,  21463 }, -- Ossirian's Binding
				{ 10, 21461 }, -- Leggings of the Black Blizzard
				{ 11, 21459 }, -- Crossbow of Imminent Doom
				{ 12, 21715 }, -- Sand Polished Hammer
				{ 13, 21452 }, -- Staff of the Ruins
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
				{ 23, 21220 }, -- Head of Ossirian the Unscarred
			},
		},
		{ -- AQ20Trash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21804 }, -- Coif of Elemental Fury
				{ 2,  21803 }, -- Helm of the Holy Avenger
				{ 3,  21805 }, -- Polished Obsidian Pauldrons
				{ 5,  20873 }, -- Alabaster Idol
				{ 6,  20869 }, -- Amber Idol
				{ 7,  20866 }, -- Azure Idol
				{ 8,  20870 }, -- Jasper Idol
				{ 9,  20868 }, -- Lambent Idol
				{ 10, 20871 }, -- Obsidian Idol
				{ 11, 20867 }, -- Onyx Idol
				{ 12, 20872 }, -- Vermillion Idol
				{ 14, 21761 }, -- Scarab Coffer Key
				{ 15, 21156 }, -- Scarab Bag
				{ 16, 21801 }, -- Antenna of Invigoration
				{ 17, 21800 }, -- Silithid Husked Launcher
				{ 18, 21802 }, -- The Lost Kris of Zedd
				{ 20, 20864 }, -- Bone Scarab
				{ 21, 20861 }, -- Bronze Scarab
				{ 22, 20863 }, -- Clay Scarab
				{ 23, 20862 }, -- Crystal Scarab
				{ 24, 20859 }, -- Gold Scarab
				{ 25, 20865 }, -- Ivory Scarab
				{ 26, 20860 }, -- Silver Scarab
				{ 27, 20858 }, -- Stone Scarab
				{ 29, 22203 }, -- Large Obsidian Shard
				{ 30, 22202 }, -- Small Obsidian Shard
			},
		},
		{ -- AQ20ClassBooks
			name = AL["Class books"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21284 }, -- Codex of Greater Heal V
				{ 2,  21287 }, -- Codex of Prayer of Healing V
				{ 3,  21285 }, -- Codex of Renew X
				{ 4,  21279 }, -- Tome of Fireball XII
				{ 5,  21214 }, -- Tome of Frostbolt XI
				{ 6,  21280 }, -- Tome of Arcane Missiles VIII
				{ 7,  21281 }, -- Grimoire of Shadow Bolt X
				{ 8,  21283 }, -- Grimoire of Corruption VII
				{ 9,  21282 }, -- Grimoire of Immolate VIII
				{ 10, 21300 }, -- Handbook of Backstab IX
				{ 11, 21303 }, -- Handbook of Feint V
				{ 12, 21302 }, -- Handbook of Deadly Poison V
				{ 13, 21294 }, -- Book of Healing Touch XI
				{ 14, 21296 }, -- Book of Rejuvenation XI
				{ 15, 21295 }, -- Book of Starfire VII
				{ 16, 21306 }, -- Guide: Serpent Sting IX
				{ 17, 21304 }, -- Guide: Multi-Shot V
				{ 18, 21307 }, -- Guide: Aspect of the Hawk VII
				{ 19, 21291 }, -- Tablet of Healing Wave X
				{ 20, 21292 }, -- Tablet of Strength of Earth Totem V
				{ 21, 21293 }, -- Tablet of Grace of Air Totem III
				{ 22, 21288 }, -- Libram: Blessing of Wisdom VI
				{ 23, 21289 }, -- Libram: Blessing of Might VII
				{ 24, 21290 }, -- Libram: Holy Light IX
				{ 25, 21298 }, -- Manual of Battle Shout VII
				{ 26, 21299 }, -- Manual of Revenge VI
				{ 27, 21297 }, -- Manual of Heroic Strike IX
			},
		},
		AQ_OPENING,
	},
}

data["TheTempleofAhnQiraj"] = { -- AQ40
	MapID = 3428,
	InstanceID = 531,
	AtlasMapID = "TheTempleofAhnQiraj",
	AtlasMapFile = "TheTempleofAhnQiraj",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 5,
	items = {
		{ -- AQ40Skeram
			name = AL["The Prophet Skeram"],
			npcID = 15263,
			Level = 999,
			DisplayIDs = {{15345}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  21699 }, -- Barrage Shoulders
				{ 2,  21814 }, -- Breastplate of Annihilation
				{ 3,  21708 }, -- Beetle Scaled Wristguards
				{ 4,  21698 }, -- Leggings of Immersion
				{ 5,  21705 }, -- Boots of the Fallen Prophet
				{ 6,  21704 }, -- Boots of the Redeemed Prophecy
				{ 7,  21706 }, -- Boots of the Unwavering Will
				{ 9,  21702 }, -- Amulet of Foul Warding
				{ 10, 21700 }, -- Pendant of the Qiraji Guardian
				{ 11, 21701 }, -- Cloak of Concentrated Hatred
				{ 12, 21707 }, -- Ring of Swarming Thought
				{ 13, 21703 }, -- Hammer of Ji'zhi
				{ 14, 21128 }, -- Staff of the Qiraji Prophets
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 22222 }, -- Plans: Thick Obsidian Breastplate
				--{ 20, 22196 }, -- Thick Obsidian Breastplate
			},
		},
		{ -- AQ40Trio
			name = AL["Bug Trio"],
			npcID = {15543, 15544, 15511},
			Level = 999,
			DisplayIDs = {{15657},{15658},{15656}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  21693 }, -- Guise of the Devourer
				{ 2,  21694 }, -- Ternary Mantle
				{ 3,  21697 }, -- Cape of the Trinity
				{ 4,  21696 }, -- Robes of the Triumvirate
				{ 5,  21692 }, -- Triad Girdle
				{ 6,  21695 }, -- Angelista's Touch
				{ 8,  21237 }, -- Imperial Qiraji Regalia
				{ 9,  21232 }, -- Imperial Qiraji Armaments
				{ 11, 21680 }, -- Vest of Swift Execution
				{ 12, 21681 }, -- Ring of the Devoured
				{ 13, 21685 }, -- Petrified Scarab
				{ 14, 21603 }, -- Wand of Qiraji Nobility
				{ 16, 21690 }, -- Angelista's Charm
				{ 17, 21689 }, -- Gloves of Ebru
				{ 18, 21691 }, -- Ooze-ridden Gauntlets
				{ 19, 21688 }, -- Boots of the Fallen Hero
				{ 21, 21686 }, -- Mantle of Phrenic Power
				{ 22, 21684 }, -- Mantle of the Desert's Fury
				{ 23, 21683 }, -- Mantle of the Desert Crusade
				{ 24, 21682 }, -- Bile-Covered Gauntlets
				{ 25, 21687 }, -- Ukko's Ring of Darkness
			},
		},
		{ -- AQ40Sartura
			name = AL["Battleguard Sartura"],
			npcID = 15516,
			Level = 999,
			DisplayIDs = {{15583}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  21669 }, -- Creeping Vine Helm
				{ 2,  21678 }, -- Necklace of Purity
				{ 3,  21671 }, -- Robes of the Battleguard
				{ 4,  21672 }, -- Gloves of Enforcement
				{ 5,  21674 }, -- Gauntlets of Steadfast Determination
				{ 6,  21675 }, -- Thick Qirajihide Belt
				{ 7,  21676 }, -- Leggings of the Festering Swarm
				{ 8,  21668 }, -- Scaled Leggings of Qiraji Fury
				{ 9,  21667 }, -- Legplates of Blazing Light
				{ 10, 21648 }, -- Recomposed Boots
				{ 11, 21670 }, -- Badge of the Swarmguard
				{ 12, 21666 }, -- Sartura's Might
				{ 13, 21673 }, -- Silithid Claw
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Fankriss
			name = AL["Fankriss the Unyielding"],
			npcID = 15510,
			Level = 999,
			DisplayIDs = {{15743}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  21665 }, -- Mantle of Wicked Revenge
				{ 2,  21639 }, -- Pauldrons of the Unrelenting
				{ 3,  21627 }, -- Cloak of Untold Secrets
				{ 4,  21663 }, -- Robes of the Guardian Saint
				{ 5,  21652 }, -- Silithid Carapace Chestguard
				{ 6,  21651 }, -- Scaled Sand Reaver Leggings
				{ 7,  21645 }, -- Hive Tunneler's Boots
				{ 8,  21650 }, -- Ancient Qiraji Ripper
				{ 9,  21635 }, -- Barb of the Sand Reaver
				{ 11, 21664 }, -- Barbed Choker
				{ 12, 21647 }, -- Fetish of the Sand Reaver
				{ 13, 22402 }, -- Libram of Grace
				{ 14, 22396 }, -- Totem of Life
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Viscidus
			name = AL["Viscidus"],
			npcID = 15299,
			Level = 999,
			DisplayIDs = {{15686}},
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  21624 }, -- Gauntlets of Kalimdor
				{ 2,  21623 }, -- Gauntlets of the Righteous Champion
				{ 3,  21626 }, -- Slime-coated Leggings
				{ 4,  21622 }, -- Sharpened Silithid Femur
				{ 6,  21677 }, -- Ring of the Qiraji Fury
				{ 7,  21625 }, -- Scarab Brooch
				{ 8,  22399 }, -- Idol of Health
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Huhuran
			name = AL["Princess Huhuran"],
			npcID = 15509,
			Level = 999,
			DisplayIDs = {{15739}},
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  21621 }, -- Cloak of the Golden Hive
				{ 2,  21618 }, -- Hive Defiler Wristguards
				{ 3,  21619 }, -- Gloves of the Messiah
				{ 4,  21617 }, -- Wasphide Gauntlets
				{ 5,  21620 }, -- Ring of the Martyr
				{ 6,  21616 }, -- Huhuran's Stinger
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19, 20928 }, -- Qiraji Bindings of Command
				{ 20, 20932 }, -- Qiraji Bindings of Dominance
			},
		},
		{ -- AQ40Emperors
			name = AL["Twin Emperors"],
			npcID = {15275, 15276},
			Level = 999,
			DisplayIDs = {{15761},{15778}},
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Emperor Vek'lor"], nil },
				{ 2,  20930 }, -- Vek'lor's Diadem
				{ 3,  21602 }, -- Qiraji Execution Bracers
				{ 4,  21599 }, -- Vek'lor's Gloves of Devastation
				{ 5,  21598 }, -- Royal Qiraji Belt
				{ 6,  21600 }, -- Boots of Epiphany
				{ 7,  21601 }, -- Ring of Emperor Vek'lor
				{ 8,  21597 }, -- Royal Scepter of Vek'lor
				{ 9,  20735 }, -- Formula: Enchant Cloak - Subtlety
				{ 12, 21232 }, -- Imperial Qiraji Armaments
				{ 16, "INV_Box_01", nil, AL["Emperor Vek'nilash"], nil },
				{ 17, 20926 }, -- Vek'nilash's Circlet
				{ 18, 21608 }, -- Amulet of Vek'nilash
				{ 19, 21604 }, -- Bracelets of Royal Redemption
				{ 20, 21605 }, -- Gloves of the Hidden Temple
				{ 21, 21609 }, -- Regenerating Belt of Vek'nilash
				{ 22, 21607 }, -- Grasp of the Fallen Emperor
				{ 23, 21606 }, -- Belt of the Fallen Emperor
				{ 24, 21679 }, -- Kalimdor's Revenge
				{ 25, 20726 }, -- Formula: Enchant Gloves - Threat
				{ 27, 21237 }, -- Imperial Qiraji Regalia
			},
		},
		{ -- AQ40Ouro
			name = AL["Ouro"],
			npcID = 15517,
			Level = 999,
			DisplayIDs = {{15509}},
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  21615 }, -- Don Rigoberto's Lost Hat
				{ 2,  21611 }, -- Burrower Bracers
				{ 3,  23558 }, -- The Burrower's Shell
				{ 4,  23570 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  23557 }, -- Larvae of the Great Worm
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21232 }, -- Imperial Qiraji Armaments
				{ 19,  20927 }, -- Ouro's Intact Hide
				{ 20,  20931 }, -- Skin of the Great Sandworm
			},
		},
		{ -- AQ40CThun
			name = AL["C'Thun"],
			npcID = 15727,
			Level = 999,
			DisplayIDs = {{15787}},
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  22732 }, -- Mark of C'Thun
				{ 2,  21583 }, -- Cloak of Clarity
				{ 3,  22731 }, -- Cloak of the Devoured
				{ 4,  22730 }, -- Eyestalk Waist Cord
				{ 5,  21582 }, -- Grasp of the Old God
				{ 6,  21586 }, -- Belt of Never-ending Agony
				{ 7,  21585 }, -- Dark Storm Gauntlets
				{ 8,  21581 }, -- Gauntlets of Annihilation
				{ 9,  21596 }, -- Ring of the Godslayer
				{ 10, 21579 }, -- Vanquished Tentacle of C'Thun
				{ 11, 21839 }, -- Scepter of the False Prophet
				{ 12, 21126 }, -- Death's Sting
				{ 13, 21134 }, -- Dark Edge of Insanity
				{ 16, 20929 }, -- Carapace of the Old God
				{ 17, 20933 }, -- Husk of the Old God
				{ 19, 21221 }, -- Eye of C'Thun
				{ 21, 22734 }, -- Base of Atiesh
			},
		},
		{ -- AQ40Trash1
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21838 }, -- Garb of Royal Ascension
				{ 2,  21888 }, -- Gloves of the Immortal
				{ 3,  21889 }, -- Gloves of the Redeemed Prophecy
				{ 4,  21856 }, -- Neretzek, The Blood Drinker
				{ 5,  21837 }, -- Anubisath Warhammer
				{ 6,  21836 }, -- Ritssyn's Ring of Chaos
				{ 7,  21891 }, -- Shard of the Fallen Star
				{ 16, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 17, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 18, 21323 }, -- Green Qiraji Resonating Crystal
				{ 19, 21321 }, -- Red Qiraji Resonating Crystal
			},
		},
		{ -- AQ40Trash2
			name = AL["Ahn'Qiraj scarabs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  20876 }, -- Idol of Death
				{ 2,  20879 }, -- Idol of Life
				{ 3,  20875 }, -- Idol of Night
				{ 4,  20878 }, -- Idol of Rebirth
				{ 5,  20881 }, -- Idol of Strife
				{ 6,  20877 }, -- Idol of the Sage
				{ 7,  20874 }, -- Idol of the Sun
				{ 8,  20882 }, -- Idol of War
				{ 10, 21762 }, -- Greater Scarab Coffer Key
				{ 12, 21156 }, -- Scarab Bag
				{ 14, 21230 }, -- Ancient Qiraji Artifact
				{ 16, 20864 }, -- Bone Scarab
				{ 17, 20861 }, -- Bronze Scarab
				{ 18, 20863 }, -- Clay Scarab
				{ 19, 20862 }, -- Crystal Scarab
				{ 20, 20859 }, -- Gold Scarab
				{ 21, 20865 }, -- Ivory Scarab
				{ 22, 20860 }, -- Silver Scarab
				{ 23, 20858 }, -- Stone Scarab
				{ 26, 22203 }, -- Large Obsidian Shard
				{ 27, 22202 }, -- Small Obsidian Shard
				{ 29, 21229 }, -- Qiraji Lord's Insignia
			},
		},
		{ -- AQEnchants
			name = AL["Ahn'Qiraj enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  20728 }, -- Formula: Enchant Gloves - Frost Power
				{ 2,  20731 }, -- Formula: Enchant Gloves - Superior Agility
				{ 3,  20734 }, -- Formula: Enchant Cloak - Stealth
				{ 4,  20729 }, -- Formula: Enchant Gloves - Fire Power
				{ 5,  20736 }, -- Formula: Enchant Cloak - Dodge
				{ 6,  20730 }, -- Formula: Enchant Gloves - Healing Power
				{ 7,  20727 }, -- Formula: Enchant Gloves - Shadow Power
			},
		},
		AQ_OPENING,
	},
}

local BLUE = "|cff6666ff"
local GREY = "|cff999999"
local GREN = "|cff66cc33"
local _RED = "|cffcc6666"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
data["Naxxramas"] = {
	MapID = 3456,
	InstanceID = 533,
	AtlasMapID = "Naxxramas",
	AtlasMapFile = "Naxxramas",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 6,
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
			Level = 999,
			DisplayIDs = {{15931}},
			AtlasMapBossID = BLUE.."1",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22935 }, -- Touch of Frost
				{ 9,  22938 }, -- Cryptfiend Silk Cloak
				{ 10, 22936 }, -- Wristguards of Vengeance
				{ 11, 22939 }, -- Band of Unanswered Prayers
				{ 12, 22937 }, -- Gem of Nerubis
			},
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
			Level = 999,
			DisplayIDs = {{15940}},
			AtlasMapBossID = BLUE.."2",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22369 }, -- Desecrated Bindings
				{ 5,  22362 }, -- Desecrated Wristguards
				{ 6,  22355 }, -- Desecrated Bracers
				{ 8,  22943 }, -- Malice Stone Pendant
				{ 9,  22941 }, -- Polar Shoulder Pads
				{ 10, 22940 }, -- Icebane Pauldrons
				{ 11, 22942 }, -- The Widow's Embrace
				{ 12, 22806 }, -- Widow's Remorse
			},
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
			Level = 999,
			DisplayIDs = {{15928}},
			AtlasMapBossID = BLUE.."3",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22371 }, -- Desecrated Gloves
				{ 5,  22364 }, -- Desecrated Handguards
				{ 6,  22357 }, -- Desecrated Gauntlets
				{ 8,  22947 }, -- Pendant of Forgotten Names
				{ 9,  23220 }, -- Crystal Webbed Robe
				{ 10, 22954 }, -- Kiss of the Spider
				{ 11, 22807 }, -- Wraith Blade
				{ 12, 22804 }, -- Maexxna's Fang
			},
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
			Level = 999,
			DisplayIDs = {{16590}},
			AtlasMapBossID = PURP.."1",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23030 }, -- Cloak of the Scourge
				{ 9,  23031 }, -- Band of the Inevitable
				{ 10, 23028 }, -- Hailstone Band
				{ 11, 23029 }, -- Noth's Frigid Heart
				{ 12, 23006 }, -- Libram of Light
				{ 13, 23005 }, -- Totem of Flowing Water
				{ 14, 22816 }, -- Hatchet of Sundered Bone
			},
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
			Level = 999,
			DisplayIDs = {{16309}},
			AtlasMapBossID = PURP.."2",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22370 }, -- Desecrated Belt
				{ 5,  22363 }, -- Desecrated Girdle
				{ 6,  22356 }, -- Desecrated Waistguard
				{ 8,  23035 }, -- Preceptor's Hat
				{ 9,  23033 }, -- Icy Scale Coif
				{ 10, 23019 }, -- Icebane Helmet
				{ 11, 23036 }, -- Necklace of Necropsy
				{ 12, 23068 }, -- Legplates of Carnage
			},
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
			Level = 999,
			DisplayIDs = {{16110}},
			AtlasMapBossID = PURP.."3",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22366 }, -- Desecrated Leggings
				{ 5,  22359 }, -- Desecrated Legguards
				{ 6,  22352 }, -- Desecrated Legplates
				{ 8,  23038 }, -- Band of Unnatural Forces
				{ 9,  23037 }, -- Ring of Spiritual Fervor
				{ 10, 23042 }, -- Loatheb's Reflection
				{ 11, 23039 }, -- The Eye of Nerub
				{ 12, 22800 }, -- Brimstone Staff
			},
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
			Level = 999,
			DisplayIDs = {{16582}},
			AtlasMapBossID = _RED.."1",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23017 }, -- Veil of Eclipse
				{ 9,  23219 }, -- Girdle of the Mentor
				{ 10, 23018 }, -- Signet of the Fallen Defender
				{ 11, 23004 }, -- Idol of Longevity
				{ 12, 23009 }, -- Wand of the Whispering Dead
				{ 13, 23014 }, -- Iblis, Blade of the Fallen Seraph
			},
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
			Level = 999,
			DisplayIDs = {{16279}},
			AtlasMapBossID = _RED.."2",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22372 }, -- Desecrated Sandals
				{ 5,  22365 }, -- Desecrated Boots
				{ 6,  22358 }, -- Desecrated Sabatons
				{ 8,  23032 }, -- Glacial Headdress
				{ 9,  23020 }, -- Polar Helmet
				{ 10, 23023 }, -- Sadist's Collar
				{ 11, 23021 }, -- The Soul Harvester's Bindings
				{ 12, 23073 }, -- Boots of Displacement
			},
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = {16064, 16065, 30549, 16063},
			Level = 999,
			DisplayIDs = {{16155},{16153},{10729},{16154}},
			AtlasMapBossID = _RED.."3",
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22351 }, -- Desecrated Robe
				{ 5,  22350 }, -- Desecrated Tunic
				{ 6,  22349 }, -- Desecrated Breastplate
				{ 8,  23071 }, -- Leggings of Apocalypse
				{ 9,  23025 }, -- Seal of the Damned
				{ 10, 23027 }, -- Warmth of Forgiveness
				{ 11, 22811 }, -- Soulstring
				{ 12, 22809 }, -- Maul of the Redeemed Crusader
				{ 13, 22691 }, -- Corrupted Ashbringer
			},
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
			Level = 999,
			DisplayIDs = {{16174}},
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22960 }, -- Cloak of Suturing
				{ 9,  22961 }, -- Band of Reanimation
				{ 10, 22820 }, -- Wand of Fates
				{ 11, 22818 }, -- The Plague Bearer
				{ 12, 22815 }, -- Severance
			},
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
			Level = 999,
			DisplayIDs = {{16035}},
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22368 }, -- Desecrated Shoulderpads
				{ 5,  22361 }, -- Desecrated Spaulders
				{ 6,  22354 }, -- Desecrated Pauldrons
				{ 8,  22968 }, -- Glacial Mantle
				{ 9,  22967 }, -- Icy Scale Spaulders
				{ 10, 22810 }, -- Toxin Injector
				{ 11, 22803 }, -- Midnight Haze
				{ 12, 22988 }, -- The End of Dreams
			},
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
			Level = 999,
			DisplayIDs = {{16064}},
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22983 }, -- Rime Covered Mantle
				{ 5,  22981 }, -- Gluth's Missing Collar
				{ 6,  22994 }, -- Digested Hand of Power
				{ 7,  23075 }, -- Death's Bargain
				{ 8,  22813 }, -- Claymore of Unholy Might
				{ 16, 22368 }, -- Desecrated Shoulderpads
				{ 17, 22369 }, -- Desecrated Bindings
				{ 18, 22370 }, -- Desecrated Belt
				{ 19, 22372 }, -- Desecrated Sandals
				{ 20, 22361 }, -- Desecrated Spaulders
				{ 21, 22362 }, -- Desecrated Wristguards
				{ 22, 22363 }, -- Desecrated Girdle
				{ 23, 22365 }, -- Desecrated Boots
				{ 24, 22354 }, -- Desecrated Pauldrons
				{ 25, 22355 }, -- Desecrated Bracers
				{ 26, 22356 }, -- Desecrated Waistguard
				{ 27, 22358 }, -- Desecrated Sabatons
			},
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
			Level = 999,
			DisplayIDs = {{16137}},
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  22367 }, -- Desecrated Circlet
				{ 5,  22360 }, -- Desecrated Headpiece
				{ 6,  22353 }, -- Desecrated Helmet
				{ 8,  23000 }, -- Plated Abomination Ribcage
				{ 9,  23070 }, -- Leggings of Polarity
				{ 10, 23001 }, -- Eye of Diminution
				{ 11, 22808 }, -- The Castigator
				{ 12, 22801 }, -- Spire of Twilight
			},
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
			Level = 999,
			DisplayIDs = {{16033}},
			AtlasMapBossID = GREN.."1",
			[NORMAL_DIFF] = {
				{ 1,  23050 }, -- Cloak of the Necropolis
				{ 2,  23045 }, -- Shroud of Dominion
				{ 3,  23040 }, -- Glyph of Deflection
				{ 4,  23047 }, -- Eye of the Dead
				{ 5,  23041 }, -- Slayer's Crest
				{ 6,  23046 }, -- The Restrained Essence of Sapphiron
				{ 7,  23049 }, -- Sapphiron's Left Eye
				{ 8,  23048 }, -- Sapphiron's Right Eye
				{ 9,  23043 }, -- The Face of Death
				{ 10, 23242 }, -- Claw of the Frost Wyrm
				{ 16, 23549 }, -- Fortitude of the Scourge
				{ 17, 23548 }, -- Might of the Scourge
				{ 18, 23545 }, -- Power of the Scourge
				{ 19, 23547 }, -- Resilience of the Scourge
			},
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
			Level = 999,
			DisplayIDs = {{15945}},
			AtlasMapBossID = GREN.."2",
			[NORMAL_DIFF] = {
				{ 1,  23057 }, -- Gem of Trapped Innocents
				{ 2,  23053 }, -- Stormrage's Talisman of Seething
				{ 3,  22812 }, -- Nerubian Slavemaker
				{ 4,  22821 }, -- Doomfinger
				{ 5,  22819 }, -- Shield of Condemnation
				{ 6,  22802 }, -- Kingsfall
				{ 7,  23056 }, -- Hammer of the Twisting Nether
				{ 8,  23054 }, -- Gressil, Dawn of Ruin
				{ 9,  23577 }, -- The Hungering Cold
				{ 10, 22798 }, -- Might of Menethil
				{ 11, 22799 }, -- Soulseeker
				{ 13, 22520 }, -- The Phylactery of Kel'Thuzad
				{ 16, 23061 }, -- Ring of Faith
				{ 17, 23062 }, -- Frostfire Ring
				{ 18, 23063 }, -- Plagueheart Ring
				{ 19, 23060 }, -- Bonescythe Ring
				{ 20, 23064 }, -- Ring of the Dreamwalker
				{ 21, 23067 }, -- Ring of the Cryptstalker
				{ 22, 23065 }, -- Ring of the Earthshatterer
				{ 23, 23066 }, -- Ring of Redemption
				{ 24, 23059 }, -- Ring of the Dreadnaught
				{ 26, 22733 }, -- Staff Head of Atiesh
			},
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  23664 }, -- Pauldrons of Elemental Fury
				{ 2,  23667 }, -- Spaulders of the Grand Crusader
				{ 3,  23069 }, -- Necro-Knight's Garb
				{ 4,  23226 }, -- Ghoul Skin Tunic
				{ 5,  23663 }, -- Girdle of Elemental Fury
				{ 6,  23666 }, -- Belt of the Grand Crusader
				{ 7,  23665 }, -- Leggings of Elemental Fury
				{ 8,  23668 }, -- Leggings of the Grand Crusader
				{ 9,  23237 }, -- Ring of the Eternal Flame
				{ 10, 23238 }, -- Stygian Buckler
				{ 11, 23044 }, -- Harbinger of Doom
				{ 12, 23221 }, -- Misplaced Servo Arm
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 23055 }, -- Word of Thawing
				{ 22, 22682 }, -- Frozen Rune
			},
		},
		T3_SET,
	},
}