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

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1)
local RAID20_DIFF = data:AddDifficulty(AL["20 Raid"], "r20", 9)
local RAID40_DIFF = data:AddDifficulty(AL["40 Raid"], "r40", 9)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
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

local AQ_OPENING = {	-- Keys
	name = AL["AQ opening"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
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
		{ 13, 18333 }, -- Libram of Focus
		{ 14, 18334 }, -- Libram of Protection
		{ 15, 18332 }, -- Libram of Rapidity
		{ 16, 18348 }, -- Quel'Serrar
		{ 18, 18469 }, -- Royal Seal of Eldre'Thalas
		{ 19, 18468 }, -- Royal Seal of Eldre'Thalas
		{ 20, 18467 }, -- Royal Seal of Eldre'Thalas
		{ 21, 18465 }, -- Royal Seal of Eldre'Thalas
		{ 22, 18470 }, -- Royal Seal of Eldre'Thalas
		{ 23, 18473 }, -- Royal Seal of Eldre'Thalas
		{ 24, 18471 }, -- Royal Seal of Eldre'Thalas
		{ 25, 18472 }, -- Royal Seal of Eldre'Thalas
		{ 26, 18466 }, -- Royal Seal of Eldre'Thalas
	},
}

data["Ragefire"] = {
	MapID = 2437,
	AtlasMapID = "Ragefire",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- RFCTaragaman
			name = AL["Taragaman the Hungerer"],
			npcId = 11520,
			DisplayIDs = {{7970}},
			[NORMAL_DIFF] = {
				{ 1,  14149 }, -- Subterranean Cape
				{ 2,  14148 }, -- Crystalline Cuffs
				{ 3,  14145 }, -- Cursed Felblade
			},
		},
		{ -- RFCJergosh
			name = AL["Jergosh the Invoker"],
			npcId = 11518,
			DisplayIDs = {{11429}},
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
	AtlasMapID = "WailingCaverns",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- WCKresh
			name = AL["Kresh"],
			npcId = 3653,
			DisplayIDs = {{5126}},
			[NORMAL_DIFF] = {
				{ 1,  13245 }, -- Kresh's Back
				{ 3,  6447 }, -- Worn Turtle Shell Shield
			},
		},
		{ -- WCLadyAnacondra
			name = AL["Lady Anacondra <Fanglord>"],
			npcId = 3671,
			DisplayIDs = {{4313}},
			[NORMAL_DIFF] = {
				{ 1,  10412 }, -- Belt of the Fang
				{ 3,  5404 }, -- Serpent's Shoulders
				{ 4,  6446 }, -- Snakeskin Bag
			},
		},
		{ -- WCLordCobrahn
			name = AL["Lord Cobrahn <Fanglord>"],
			npcId = 3669,
			DisplayIDs = {{4213}},
			[NORMAL_DIFF] = {
				{ 1,  6460 }, -- Cobrahn's Grasp
				{ 2,  10410 }, -- Leggings of the Fang
				{ 4,  6465 }, -- Robe of the Moccasin
			},
		},
		{ -- WCDeviateFaerieDragon
			name = AL["Deviate Faerie Dragon"],
			npcId = 5912,
			DisplayIDs = {{1267}},
			[NORMAL_DIFF] = {
				{ 1,  5243 }, -- Firebelcher
				{ 3,  6632 }, -- Feyscale Cloak
			},
		},
		{ -- WCLordPythas
			name = AL["Lord Pythas <Fanglord>"],
			npcId = 3670,
			DisplayIDs = {{4214}},
			[NORMAL_DIFF] = {
				{ 1,  6472 }, -- Stinging Viper
				{ 3,  6473 }, -- Armor of the Fang
			},
		},
		{ -- WCSkum
			name = AL["Skum"],
			npcId = 3674,
			DisplayIDs = {{4203}},
			[NORMAL_DIFF] = {
				{ 1,  6449 }, -- Glowing Lizardscale Cloak
				{ 3,  6448 }, -- Tail Spike
			},
		},
		{ -- WCLordSerpentis
			name = AL["Lord Serpentis <Fanglord>"],
			npcId = 3673,
			DisplayIDs = {{4215}},
			[NORMAL_DIFF] = {
				{ 1,  6469 }, -- Venomstrike
				{ 3,  5970 }, -- Serpent Gloves
				{ 4,  10411 }, -- Footpads of the Fang
				{ 5,  6459 }, -- Savage Trodders
			},
		},
		{ -- WCVerdan
			name = AL["Verdan the Everliving"],
			npcId = 5775,
			DisplayIDs = {{4256}},
			[NORMAL_DIFF] = {
				{ 1,  6630 }, -- Seedcloud Buckler
				{ 2,  6631 }, -- Living Root
				{ 4,  6629 }, -- Sporid Cape
			},
		},
		{ -- WCMutanus
			name = AL["Mutanus the Devourer"],
			npcId = 3654,
			DisplayIDs = {{4088}},
			[NORMAL_DIFF] = {
				{ 1,  6461 }, -- Slime-encrusted Pads
				{ 2,  6627 }, -- Mutant Scale Breastplate
				{ 3,  6463 }, -- Deep Fathom Ring
				{ 16,  10441 }, -- Glowing Shard
				{ 17,  10657 }, -- Talbar Mantle
				{ 18,  10658 }, -- Quagmire Galoshes
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
	AtlasMapID = "TheDeadmines",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--DMRhahkZor
			name = AL["Rhahk'Zor <The Foreman>"],
			npcId = 644,
			DisplayIDs = {{14403}},
			[NORMAL_DIFF] = {
				{ 1, 872 },	-- Rockslicer
				{ 3, 5187 },	-- Rhahk'Zor's Hammer
			},
		},
		{	--DMMinerJohnson
			name = AL["Miner Johnson"],
			npcId = 3586,
			DisplayIDs = {{556}},
			[NORMAL_DIFF] = {
				{ 1, 5443 },	-- Gold-plated Buckler
				{ 3, 5444 },	-- Miner's Cape
			},
		},
		{	--DMSneed
			name = AL["Sneed <Lumbermaster>"],
			npcId = 643,
			DisplayIDs = {{7125}},
			[NORMAL_DIFF] = {
				{ 1, 5194 },	-- Taskmaster Axe
				{ 3, 5195 },	-- Gold-flecked Gloves
			},
		},
		{	--DMSneedsShredder
			name = AL["Sneed's Shredder <Lumbermaster>"],
			npcId = 642,
			DisplayIDs = {{1269}},
			[NORMAL_DIFF] = {
				{ 1, 1937 },	-- Buzz Saw
				{ 3, 2169 },	-- Buzzer Blade
			},
		},
		{	--DMGilnid
			name = AL["Gilnid <The Smelter>"],
			npcId = 1763,
			DisplayIDs = {{7124}},
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 3, 5199 },	-- Smelting Pants
			},
		},
		--[[
		{	--DMDefiasGunpowder
			[NORMAL_DIFF] = {
				{ 1, 5397 },	-- Defias Gunpowder
			},
		},
		]]--
		{	--DMMrSmite
			name = AL["Mr. Smite <The Ship's First Mate>"],
			npcId = 646,
			DisplayIDs = {{2026}},
			[NORMAL_DIFF] = {
				{ 1, 7230 },	-- Smite's Mighty Hammer
				{ 3, 5192 },	-- Thief's Blade
				{ 4, 5196 },	-- Smite's Reaver
			},
		},
		{	--DMCaptainGreenskin
			name = AL["Captain Greenskin"],
			npcId = 647,
			DisplayIDs = {{7113},{2349},{2347},{5207}},
			[NORMAL_DIFF] = {
				{ 1, 5201 },	-- Emberstone Staff
				{ 3, 10403 },	-- Blackened Defias Belt
				{ 4, 5200 },	-- Impaling Harpoon
			},
		},
		{	--DMVanCleef
			name = AL["Edwin VanCleef <Defias Kingpin>"],
			npcId = 639,
			DisplayIDs = {{2029}},
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 10399 },	-- Blackened Defias Armor
				{ 4, 5191 },	-- Cruel Barb
				{ 6, 2874 },	-- An Unsent Letter
			},
		},
		{	--DMCookie
			name = AL["Cookie <The Ship's Cook>"],
			npcId = 645,
			DisplayIDs = {{1305}},
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
	AtlasMapID = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- SFKRethilgore
			name = AL["Rethilgore <The Cell Keeper>"],
			npcId = 3914,
			DisplayIDs = {{524}},
			[NORMAL_DIFF] = {
				{ 1,  5254 }, -- Rugged Spaulders
			},
		},
		{ -- SFKSever
			name = AL["Sever"],
			npcId = 14682,
			DisplayIDs = {{1061}},
			[NORMAL_DIFF] = {
				{ 1,  23173 }, -- Abomination Skin Leggings
				{ 2,  23171 }, -- The Axe of Severing
			},
		},
		{ -- SFKFelSteed
			name = AL["Fel Steed / Shadow Charger"],
			npcId = {3865, 3864},
			DisplayIDs = {{1952},{1951}},
			[NORMAL_DIFF] = {
				{ 1,  6341 }, -- Eerie Stable Lantern
				{ 3,  932 }, -- Fel Steed Saddlebags
			},
		},
		{ -- SFKRazorclawtheButcher
			name = AL["Razorclaw the Butcher"],
			npcId = 3886,
			DisplayIDs = {{524}},
			[NORMAL_DIFF] = {
				{ 1,  1292 }, -- Butcher's Cleaver
				{ 3,  6226 }, -- Bloody Apron
				{ 4,  6633 }, -- Butcher's Slicer
			},
		},
		{ -- SFKSilverlaine
			name = AL["Baron Silverlaine"],
			npcId = 3887,
			DisplayIDs = {{3222}},
			[NORMAL_DIFF] = {
				{ 1,  6321 }, -- Silverlaine's Family Seal
				{ 3,  6323 }, -- Baron's Scepter
			},
		},
		{ -- SFKSpringvale
			name = AL["Commander Springvale"],
			npcId = 4278,
			DisplayIDs = {{3223}},
			[NORMAL_DIFF] = {
				{ 1,  6320 }, -- Commander's Crest
				{ 3,  3191 }, -- Arced War Axe
			},
		},
		{ -- SFKOdotheBlindwatcher
			name = AL["Odo the Blindwatcher"],
			npcId = 4279,
			DisplayIDs = {{522}},
			[NORMAL_DIFF] = {
				{ 1,  6318 }, -- Odo's Ley Staff
				{ 3,  6319 }, -- Girdle of the Blindwatcher
			},
		},
		{ -- SFKDeathswornCaptain
			name = AL["Deathsworn Captain"],
			npcId = 3872,
			DisplayIDs = {{3224}},
			[NORMAL_DIFF] = {
				{ 1,  6642 }, -- Phantom Armor
				{ 3,  6641 }, -- Haunting Blade
			},
		},
		{ -- SFKFenrustheDevourer
			name = AL["Fenrus the Devourer"],
			npcId = 4274,
			DisplayIDs = {{2352}},
			[NORMAL_DIFF] = {
				{ 1,  6340 }, -- Fenrus' Hide
				{ 2,  3230 }, -- Black Wolf Bracers
			},
		},
		{ -- SFKWolfMasterNandos
			name = AL["Wolf Master Nandos"],
			npcId = 3927,
			DisplayIDs = {{11179}},
			[NORMAL_DIFF] = {
				{ 1,  3748 }, -- Feline Mantle
				{ 3,  6314 }, -- Wolfmaster Cape
			},
		},
		{ -- SFKArchmageArugal
			name = AL["Archmage Arugal"],
			npcId = 4275,
			DisplayIDs = {{2353}},
			[NORMAL_DIFF] = {
				{ 1,  6324 }, -- Robes of Arugal
				{ 2,  6392 }, -- Belt of Arugal
				{ 3,  6220 }, -- Meteor Shard
			},
		},
		{ -- SFKArugalsVoidwalker
			name = AL["Arugal's Voidwalker"],
			npcId = 4627,
			DisplayIDs = {{1131}},
			[NORMAL_DIFF] = {
				{ 1,  5943 }, -- Rift Bracers
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
		{ -- SFKBookofUr
			name = AL["The Book of Ur"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  6283 }, -- The Book of Ur
			},
		},
		{ -- SFKJordansHammer
			name = AL["Jordan's Smithing Hammer"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  6895 }, -- Jordan's Smithing Hammer
			},
		},
	},
}

data["BlackfathomDeeps"] = {
	MapID = 719,
	AtlasMapID = "BlackfathomDeeps",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- BFDGhamoora
			name = AL["Ghamoo-ra"],
			npcId = 4887,
			DisplayIDs = {{5027}},
			[NORMAL_DIFF] = {
				{ 1,  6907 }, -- Tortoise Armor
				{ 3,  6908 }, -- Ghamoo-ra's Bind
			},
		},
		{ -- BFDLadySarevess
			name = AL["Lady Sarevess"],
			npcId = 4831,
			DisplayIDs = {{4979}},
			[NORMAL_DIFF] = {
				{ 1,  888 }, -- Naga Battle Gloves
				{ 3,  3078 }, -- Naga Heartpiercer
				{ 4,  11121 }, -- Darkwater Talwar
			},
		},
		{ -- BFDGelihast
			name = AL["Gelihast"],
			npcId = 6243,
			DisplayIDs = {{1773}},
			[NORMAL_DIFF] = {
				{ 1,  6906 }, -- Algae Fists
				{ 3,  6905 }, -- Reef Axe
				{ 5,  1470 }, -- Murloc Skin Bag
			},
		},
		{ -- BFDBaronAquanis
			name = AL["Baron Aquanis"],
			npcId = 12876,
			DisplayIDs = {{110}},
			[NORMAL_DIFF] = {
				{ 1,  16782 }, -- Strange Water Globe
				{ 2,  16886 }, -- Outlaw Sabre
				{ 3,  16887 }, -- Witch's Finger
			},
		},
		{ -- BFDTwilightLordKelris
			name = AL["Twilight Lord Kelris"],
			npcId = 4832,
			DisplayIDs = {{4939}},
			[NORMAL_DIFF] = {
				{ 1,  1155 }, -- Rod of the Sleepwalker
				{ 3,  6903 }, -- Gaze Dreamer Pants
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Old Serra'kis"],
			npcId = 4830,
			DisplayIDs = {{1816}},
			[NORMAL_DIFF] = {
				{ 1,  6901 }, -- Glowing Thresher Cape
				{ 2,  6904 }, -- Bite of Serra'kis
				{ 4,  6902 }, -- Bands of Serra'kis
			},
		},
		{ -- BFDAkumai
			name = AL["Aku'mai"],
			npcId = 4829,
			DisplayIDs = {{2837}},
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
	AtlasMapID = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- SWStKamDeepfury
			name = AL["Kam Deepfury"],
			npcId = 1666,
			DisplayIDs = {{825}},
			[NORMAL_DIFF] = {
				{ 1,  2280 }, -- Kam's Walking Stick
			},
		},
		{ -- SWStBruegalIronknuckle
			name = AL["Bruegal Ironknuckle"],
			npcId = 1720,
			DisplayIDs = {{2142}},
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
	AtlasMapID = "Gnomeregan",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- GnTechbot
			name = AL["Techbot"],
			npcId = 6231,
			DisplayIDs = {{7288}},
			[NORMAL_DIFF] = {
				{ 1,  9444 }, -- Techbot CPU Shell
			},
		},
		{ -- GnViscousFallout
			name = AL["Viscous Fallout"],
			npcId = 7079,
			DisplayIDs = {{5497}},
			[NORMAL_DIFF] = {
				{ 1,  9454 }, -- Acidic Walkers
				{ 2,  9453 }, -- Toxic Revenger
				{ 3,  9452 }, -- Hydrocane
			},
		},
		{ -- GnGrubbis
			name = AL["Grubbis"],
			npcId = 7361,
			DisplayIDs = {{6533}},
			[NORMAL_DIFF] = {
				{ 1,  9445 }, -- Grubbis Paws
			},
		},
		{ -- GnElectrocutioner6000
			name = AL["Electrocutioner 6000"],
			npcId = 6235,
			DisplayIDs = {{6915}},
			[NORMAL_DIFF] = {
				{ 1,  9447 }, -- Electrocutioner Lagnut
				{ 2,  9446 }, -- Electrocutioner Leg
				{ 4,  9448 }, -- Spidertank Oilrag
				{ 6,  6893 }, -- Workshop Key
			},
		},
		{ -- GnCrowdPummeler960
			name = AL["Crowd Pummeler 9-60"],
			npcId = 6229,
			DisplayIDs = {{6774}},
			[NORMAL_DIFF] = {
				{ 1,  9449 }, -- Manual Crowd Pummeler
				{ 3,  9450 }, -- Gnomebot Operating Boots
			},
		},
		{ -- GnMekgineerThermaplugg
			name = AL["Mekgineer Thermaplugg"],
			npcId = 7800,
			DisplayIDs = {{6980}},
			[NORMAL_DIFF] = {
				{ 1,  9492 }, -- Electromagnetic Gigaflux Reactivator
				{ 2,  9461 }, -- Charged Gear
				{ 3,  9458 }, -- Thermaplugg's Central Core
				{ 4,  9459 }, -- Thermaplugg's Left Arm
				{ 16, 4415 }, -- Schematic: Craftsman's Monocle
				{ 17, 4393 }, -- Craftsman's Monocle
				{ 19, 4413 }, -- Schematic: Discombobulator Ray
				{ 20, 4388 }, -- Discombobulator Ray
				{ 22, 4411 }, -- Schematic: Flame Deflector
				{ 23, 4376 }, -- Flame Deflector
				{ 25, 7742 }, -- Schematic: Gnomish Cloaking Device
				{ 26, 4397 }, -- Gnomish Cloaking Device
			},
		},
		{ -- GnDIAmbassador
			name = AL["Dark Iron Ambassador"],
			npcId = 6228,
			DisplayIDs = {{6669}},
			[NORMAL_DIFF] = {
				{ 1,  9455 }, -- Emissary Cuffs
				{ 2,  9456 }, -- Glass Shooter
				{ 3,  9457 }, -- Royal Diplomatic Scepter
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
				{ 21, 9588 }, -- Nogg's Gold Ring
				{ 23, 9279 }, -- White Punch Card
				{ 24, 9280 }, -- Yellow Punch Card
				{ 25, 9282 }, -- Blue Punch Card
				{ 26, 9281 }, -- Red Punch Card
				{ 27, 9316 }, -- Prismatic Punch Card
			},
		},

	},
}

data["RazorfenKraul"] = {
	MapID = 491,
	AtlasMapID = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- RFKAggem
			name = AL["Aggem Thorncurse <Death's Head Prophet>"],
			npcId = 4424,
			DisplayIDs = {{6097}},
			[NORMAL_DIFF] = {
				{ 1,  6681 }, -- Thornspike
			},
		},
		{ -- RFKDeathSpeakerJargba
			name = AL["Death Speaker Jargba <Death's Head Captain>"],
			npcId = 4428,
			DisplayIDs = {{4644}},
			[NORMAL_DIFF] = {
				{ 1,  2816 }, -- Death Speaker Scepter
				{ 3,  6685 }, -- Death Speaker Mantle
				{ 4,  6682 }, -- Death Speaker Robes
			},
		},
		{ -- RFKOverlordRamtusk
			name = AL["Overlord Ramtusk"],
			npcId = 4420,
			DisplayIDs = {{4652}},
			[NORMAL_DIFF] = {
				{ 1,  6687 }, -- Corpsemaker
				{ 3,  6686 }, -- Tusken Helm
			},
		},
		{ -- RFKAgathelos
			name = AL["Agathelos the Raging"],
			npcId = 4422,
			DisplayIDs = {{2450}},
			[NORMAL_DIFF] = {
				{ 1,  6691 }, -- Swinetusk Shank
				{ 3,  6690 }, -- Ferine Leggings
			},
		},
		{ -- RFKEarthcallerHalmgar
			name = AL["Earthcaller Halmgar"],
			npcId = 4842,
			DisplayIDs = {{6102}},
			[NORMAL_DIFF] = {
				{ 1,  6689 }, -- Wind Spirit Staff
				{ 3,  6688 }, -- Whisperwind Headdress
			},
		},
		{ -- RFKRazorfenSpearhide
			name = AL["Razorfen Spearhide"],
			npcId = 4438,
			DisplayIDs = {{6078}},
			[NORMAL_DIFF] = {
				{ 1,  6679 }, -- Armor Piercer
			},
		},
		{ -- RFKBlindHunter
			name = AL["Blind Hunter"],
			npcId = 4425,
			DisplayIDs = {{4735}},
			[NORMAL_DIFF] = {
				{ 1,  6695 }, -- Stygian Bone Amulet
				{ 2,  6697 }, -- Batwing Mantle
				{ 3,  6696 }, -- Nightstalker Bow
			},
		},
		{ -- RFKCharlgaRazorflank
			name = AL["Charlga Razorflank <The Crone>"],
			npcId = 4421,
			DisplayIDs = {{4642}},
			[NORMAL_DIFF] = {
				{ 1,  6693 }, -- Agamaggan's Clutch
				{ 2,  6694 }, -- Heart of Agamaggan
				{ 3,  6692 }, -- Pronged Reaver
				{ 5,  17008 }, -- Small Scroll
				{ 6,  17043 }, -- Zealot's Robe
				{ 7,  17042 }, -- Nail Spitter
				{ 8,  17039 }, -- Skullbreaker
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

data["ScarletMonastery"] = {
	MapID = 796,
	AtlasMapID = "ScarletMonastery",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		-- Graveyard
		{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcId = 3983,
			DisplayIDs = {{2044}},
			[NORMAL_DIFF] = {
				{ 1,  7682 }, -- Torturing Poker
				{ 3,  7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcId = 6490,
			DisplayIDs = {{5534}},
			[NORMAL_DIFF] = {
				{ 1,  7709 }, -- Blighted Leggings
				{ 2,  7708 }, -- Necrotic Wand
				{ 3,  7731 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcId = 6488,
			DisplayIDs = {{5230}},
			[NORMAL_DIFF] = {
				{ 1,  7691 }, -- Embalmed Shroud
				{ 2,  7690 }, -- Ebon Vise
				{ 3,  7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcId = 6489,
			DisplayIDs = {{5231}},
			[NORMAL_DIFF] = {
				{ 1,  7688 }, -- Ironspine's Ribcage
				{ 2,  7687 }, -- Ironspine's Fist
				{ 3,  7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcId = 4543,
			DisplayIDs = {{11396}},
			[NORMAL_DIFF] = {
				{ 1,  7685 }, -- Orb of the Forgotten Seer
				{ 3,  7684 }, -- Bloodmage Mantle
			},
		},
		-- Library
		{ -- SMHoundmasterLoksey
			name = AL["Houndmaster Loksey"],
			npcId = 3974,
			DisplayIDs = {{2040}},
			[NORMAL_DIFF] = {
				{ 1,  7710 }, -- Loksey's Training Stick
				{ 3,  7756 }, -- Dog Training Gloves
				{ 4,  3456 }, -- Dog Whistle
			},
		},
		{ -- SMDoan
			name = AL["Arcanist Doan"],
			npcId = 6487,
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
			name = AL["Herod <The Scarlet Champion>"],
			npcId = 3975,
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
			npcId = 4542,
			DisplayIDs = {{2605}},
			[NORMAL_DIFF] = {
				{ 1,  19507 }, -- Inquisitor's Shawl
				{ 2,  19508 }, -- Branded Leather Bracers
				{ 3,  19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcId = 3976,
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
			npcId = 3977,
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

data["RazorfenDowns"] = {
	MapID = 722,
	AtlasMapID = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- RFDTutenkash
			name = AL["Tuten'kash"],
			npcId = 7355,
			DisplayIDs = {{7845}},
			[NORMAL_DIFF] = {
				{ 1,  10776 }, -- Silky Spider Cape
				{ 2,  10775 }, -- Carapace of Tuten'kash
				{ 3,  10777 }, -- Arachnid Gloves
			},
		},
		{ -- RFDMordreshFireEye
			name = AL["Mordresh Fire Eye"],
			npcId = 7357,
			DisplayIDs = {{8055}},
			[NORMAL_DIFF] = {
				{ 1,  10769 }, -- Glowing Eye of Mordresh
				{ 2,  10771 }, -- Deathmage Sash
				{ 3,  10770 }, -- Mordresh's Lifeless Skull
			},
		},
		{ -- RFDLadyF
			name = AL["Lady Falther'ess"],
			npcId = 14686,
			DisplayIDs = {{10698}},
			[NORMAL_DIFF] = {
				{ 1,  23178 }, -- Mantle of Lady Falther'ess
				{ 2,  23177 }, -- Lady Falther'ess' Finger
			},
		},
		{ -- RFDGlutton
			name = AL["Glutton"],
			npcId = 8567,
			DisplayIDs = {{7864}},
			[NORMAL_DIFF] = {
				{ 1,  10774 }, -- Fleshhide Shoulders
				{ 3,  10772 }, -- Glutton's Cleaver
			},
		},
		{ -- RFDRagglesnout
			name = AL["Ragglesnout"],
			npcId = 7354,
			DisplayIDs = {{11382}},
			[NORMAL_DIFF] = {
				{ 1,  10768 }, -- Boar Champion's Belt
				{ 2,  10767 }, -- Savage Boar's Guard
				{ 3,  10758 }, -- X'caliboar
			},
		},
		{ -- RFDPlaguemaw
			name = AL["Plaguemaw the Rotting"],
			npcId = 7356,
			DisplayIDs = {{6124}},
			[NORMAL_DIFF] = {
				{ 1,  10766 }, -- Plaguerot Sprig
				{ 3,  10760 }, -- Swine Fists
			},
		},
		{ -- RFDAmnennar
			name = AL["Amnennar the Coldbringer"],
			npcId = 7358,
			DisplayIDs = {{7971}},
			[NORMAL_DIFF] = {
				{ 1,  10763 }, -- Icemetal Barbute
				{ 2,  10762 }, -- Robes of the Lich
				{ 3,  10764 }, -- Deathchill Armor
				{ 4,  10761 }, -- Coldrage Dagger
				{ 6,  10765 }, -- Bonefingers
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
			npcId = 8696,
			DisplayIDs = {{8029}},
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
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- UldRevelosh
			name = AL["Revelosh"],
			npcId = 6910,
			DisplayIDs = {{5945}},
			[NORMAL_DIFF] = {
				{ 1,  9389 }, -- Revelosh's Spaulders
				{ 2,  9388 }, -- Revelosh's Armguards
				{ 3,  9390 }, -- Revelosh's Gloves
				{ 4,  9387 }, -- Revelosh's Boots
				{ 6,  7741 }, -- The Shaft of Tsol
			},
		},
		{ -- UldEric
			name = AL["Eric \"The Swift\""],
			npcId = 6907,
			DisplayIDs = {{5708}},
			[NORMAL_DIFF] = {
				{ 1,  9394 }, -- Horned Viking Helmet
				{ 3,  9398 }, -- Worn Running Boots
				{ 5,  2459 }, -- Swiftness Potion
			},
		},
		{ -- UldBaelog
			name = AL["Baelog"],
			npcId = 6906,
			DisplayIDs = {{5710}},
			[NORMAL_DIFF] = {
				{ 1,  9401 }, -- Nordic Longshank
				{ 3,  9399 }, -- Precision Arrow
				{ 5,  9400 }, -- Baelog's Shortbow
			},
		},
		{ -- UldOlaf
			name = AL["Olaf"],
			npcId = 6908,
			DisplayIDs = {{5709}},
			[NORMAL_DIFF] = {
				{ 1,  9404 }, -- Olaf's All Purpose Shield
				{ 3,  9403 }, -- Battered Viking Shield
				{ 4,  1177 }, -- Oil of Olaf
			},
		},
		{ -- UldIronaya
			name = AL["Ironaya"],
			npcId = 7228,
			DisplayIDs = {{6089}},
			[NORMAL_DIFF] = {
				{ 1,  9409 }, -- Ironaya's Bracers
				{ 2,  9407 }, -- Stoneweaver Leggings
				{ 3,  9408 }, -- Ironshod Bludgeon
			},
		},
		{ -- UldAncientStoneKeeper
			name = AL["Ancient Stone Keeper"],
			npcId = 7206,
			DisplayIDs = {{10798}},
			[NORMAL_DIFF] = {
				{ 1,  9410 }, -- Cragfists
				{ 3,  9411 }, -- Rockshard Pauldrons
			},
		},
		{ -- UldGalgannFirehammer
			name = AL["Galgann Firehammer"],
			npcId = 7291,
			DisplayIDs = {{6059}},
			[NORMAL_DIFF] = {
				{ 1,  11310 }, -- Flameseer Mantle
				{ 2,  9412 }, -- Galgann's Fireblaster
				{ 4,  11311 }, -- Emberscale Cape
				{ 5,  9419 }, -- Galgann's Firehammer
			},
		},
		{ -- UldGrimlok
			name = AL["Grimlok <Stonevault Chieftain>"],
			npcId = 4854,
			DisplayIDs = {{11165}},
			[NORMAL_DIFF] = {
				{ 1,  9415 }, -- Grimlok's Tribal Vestments
				{ 2,  9416 }, -- Grimlok's Charge
				{ 4,  9414 }, -- Oilskin Leggings
			},
		},
		{ -- UldArchaedas
			name = AL["Archaedas <Ancient Stone Watcher>"],
			npcId = 2748,
			DisplayIDs = {{5988}},
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
				{ 13, 7673 }, -- Talvash's Enhancing Necklace
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
		{ -- UldShadowforgeCache
			name = AL["Shadowforge Cache"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  7669 }, -- Shattered Necklace Ruby
			},
		},
		{ -- UldBaelogsChest
			name = AL["Baelog's Chest"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  7740 }, -- Gni'kiv Medallion
			},
		},
		{ -- UldTabletofWill
			name = AL["Tablet of Will"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5824 }, -- Tablet of Will
			},
		},
	},
}

data["Zul'Farrak"] = {
	MapID = 1176,
	AtlasMapID = "Zul'Farrak",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- ZFAntusul
			name = AL["Antu'sul <Overseer of Sul>"],
			npcId = 8127,
			DisplayIDs = {{7353}},
			[NORMAL_DIFF] = {
				{ 1,  9640 }, -- Vice Grips
				{ 2,  9641 }, -- Lifeblood Amulet
				{ 3,  9639 }, -- The Hand of Antu'sul
				{ 5,  9379 }, -- Sang'thraze the Deflector
				{ 6,  9372 }, -- Sul'thraze the Lasher
			},
		},
		{ -- ZFThekatheMartyr
			name = AL["Theka the Martyr"],
			npcId = 7272,
			DisplayIDs = {{6696}},
			[NORMAL_DIFF] = {
				{ 1,  10660 }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFWitchDoctorZumrah
			name = AL["Witch Doctor Zum'rah"],
			npcId = 7271,
			DisplayIDs = {{6434}},
			[NORMAL_DIFF] = {
				{ 1,  18083 }, -- Jumanza Grips
				{ 2,  18082 }, -- Zum'rah's Vexing Cane
			},
		},
		{ -- ZFNekrumGutchewer
			name = AL["Nekrum Gutchewer"],
			npcId = 7796,
			DisplayIDs = {{6690}},
			[NORMAL_DIFF] = {
				{ 1,  9471 }, -- Nekrum's Medallion
			},
		},
		{ -- ZFHydromancerVelratha
			name = AL["Hydromancer Velratha"],
			npcId = 7795,
			DisplayIDs = {{6685}},
			[NORMAL_DIFF] = {
				{ 1,  9234 }, -- Tiara of the Deep
				{ 2,  10661 }, -- Second Mosh'aru Tablet
			},
		},
		{ -- ZFSandfury
			name = AL["Sandfury Executioner"],
			npcId = 7274,
			DisplayIDs = {{6440}},
			[NORMAL_DIFF] = {
				{ 1,  8444 }, -- Executioner's Key
			},
		},
		{ -- ZFGahzrilla
			name = AL["Gahz'rilla"],
			npcId = 7273,
			DisplayIDs = {{7271}},
			[NORMAL_DIFF] = {
				{ 1,  9469 }, -- Gahz'rilla Scale Armor
				{ 3,  9467 }, -- Gahz'rilla Fang
			},
		},
		{ -- ZFSezzziz
			name = AL["Shadowpriest Sezz'ziz"],
			npcId = 7275,
			DisplayIDs = {{6441}},
			[NORMAL_DIFF] = {
				{ 1,  9470 }, -- Bad Mojo Mask
				{ 2,  9473 }, -- Jinxed Hoodoo Skin
				{ 3,  9474 }, -- Jinxed Hoodoo Kilt
				{ 4,  9475 }, -- Diabolic Skiver
			},
		},
		{ -- ZFDustwraith
			name = AL["Dustwraith"],
			npcId = 10081,
			DisplayIDs = {{9292}},
			[NORMAL_DIFF] = {
				{ 1,  12471 }, -- Desertwalker Cane
			},
		},
		{ -- ZFSergeantBly
			name = AL["Sergeant Bly"],
			npcId = 7604,
			DisplayIDs = {{6433}},
			[NORMAL_DIFF] = {
				{ 1,  8548 }, -- Divino-matic Rod
			},
		},
		{ -- ZFChiefUkorzSandscalp
			name = AL["Chief Ukorz Sandscalp"],
			npcId = 7267,
			DisplayIDs = {{6439}},
			[NORMAL_DIFF] = {
				{ 1,  9479 }, -- Embrace of the Lycan
				{ 2,  9476 }, -- Big Bad Pauldrons
				{ 3,  9478 }, -- Ripsaw
				{ 4,  9477 }, -- The Chief's Enforcer
				{ 6,  11086 }, -- Jang'thraze the Protector
				{ 7,  9372 }, -- Sul'thraze the Lasher
			},
		},
		{ -- ZFZerillis
			name = AL["Zerillis"],
			npcId = 10082,
			DisplayIDs = {{9293}},
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
	AtlasMapID = "Maraudon",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		-- Other
		{ -- MaraMeshlok
			name = AL["Meshlok the Harvester"],
			npcId = 12237,
			DisplayIDs = {{9014}},
			[NORMAL_DIFF] = {
				{ 1,  17767 }, -- Bloomsprout Headpiece
				{ 2,  17741 }, -- Nature's Embrace
				{ 3,  17742 }, -- Fungus Shroud Armor
			},
		},
		
		
		-- Orange
		{ -- MaraNoxxion
			name = AL["Noxxion"],
			npcId = 13282,
			DisplayIDs = {{11172}},
			[NORMAL_DIFF] = {
				{ 1,  17746 }, -- Noxxion's Shackles
				{ 2,  17744 }, -- Heart of Noxxion
				{ 3,  17745 }, -- Noxious Shooter
			},
		},
		{ -- MaraRazorlash
			name = AL["Razorlash"],
			npcId = 12258,
			DisplayIDs = {{12389}},
			[NORMAL_DIFF] = {
				{ 1,  17749 }, -- Phytoskin Spaulders
				{ 2,  17748 }, -- Vinerot Sandals
				{ 4,  17750 }, -- Chloromesh Girdle
				{ 5,  17751 }, -- Brusslehide Leggings
			},
		},
		-- Purple
		{ -- MaraLordVyletongue
			name = AL["Lord Vyletongue"],
			npcId = 12236,
			DisplayIDs = {{12334}},
			[NORMAL_DIFF] = {
				{ 1,  17755 }, -- Satyrmane Sash
				{ 2,  17754 }, -- Infernal Trickster Leggings
				{ 3,  17752 }, -- Satyr's Lash
			},
		},
		-- Poison Falls
		{ -- MaraCelebras
			name = AL["Celebras the Cursed"],
			npcId = 12225,
			DisplayIDs = {{12350}},
			[NORMAL_DIFF] = {
				{ 1,  17740 }, -- Soothsayer's Headdress
				{ 2,  17739 }, -- Grovekeeper's Drape
				{ 3,  17738 }, -- Claw of Celebras
			},
		},
		-- Inner
		{ -- MaraLandslide
			name = AL["Landslide"],
			npcId = 12203,
			DisplayIDs = {{12293}},
			[NORMAL_DIFF] = {
				{ 1,  17734 }, -- Helm of the Mountain
				{ 2,  17736 }, -- Rockgrip Gauntlets
				{ 3,  17737 }, -- Cloud Stone
				{ 4,  17943 }, -- Fist of Stone
			},
		},
		{ -- MaraTinkererGizlock
			name = AL["Tinkerer Gizlock"],
			npcId = 13601,
			DisplayIDs = {{7125}},
			[NORMAL_DIFF] = {
				{ 1,  17718 }, -- Gizlock's Hypertech Buckler
				{ 2,  17717 }, -- Megashot Rifle
				{ 3,  17719 }, -- Inventor's Focal Sword
			},
		},
		{ -- MaraRotgrip
			name = AL["Rotgrip"],
			npcId = 13596,
			DisplayIDs = {{13589}},
			[NORMAL_DIFF] = {
				{ 1,  17732 }, -- Rotgrip Mantle
				{ 2,  17728 }, -- Albino Crocscale Boots
				{ 3,  17730 }, -- Gatorbite Axe
			},
		},
		{ -- MaraPrincessTheradras
			name = AL["Princess Theradras"],
			npcId = 12201,
			DisplayIDs = {{12292}},
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
			npcId = 13718,
			DisplayIDs = {{9426}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17757 }, -- Amulet of Spirits
			},
		},
		{ -- MaraKhanKolk
			name = AL["Kolk <The First Kahn>"],
			npcId = 13742,
			DisplayIDs = {{4860}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17761 }, -- Gem of the First Khan
			},
		},
		{ -- MaraKhanGelk
			name = AL["Gelk <The Second Kahn>"],
			npcId = 13741,
			DisplayIDs = {{9427}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17762 }, -- Gem of the Second Khan
			},
		},
		{ -- MaraKhanMagra
			name = AL["Magra <The Third Kahn>"],
			npcId = 13740,
			DisplayIDs = {{9433}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17763 }, -- Gem of the Third Khan
			},
		},
		{ -- MaraKhanMaraudos
			name = AL["Maraudos <The Fourth Kahn>"],
			npcId = 13739,
			DisplayIDs = {{9441}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17764 }, -- Gem of the Fourth Khan
			},
		},
		{ -- MaraKhanVeng
			name = AL["Veng <The Fifth Kahn>"],
			npcId = 13738,
			DisplayIDs = {{9418}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  17765 }, -- Gem of the Fifth Khan
			},
		},
	},
}

data["TheTempleOfAtal'Hakkar"] = {
	MapID = 1477,
	AtlasMapID = "TheTempleOfAtal'Hakkar",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- STAtalalarion
			name = AL["Atal'alarion <Guardian of the Idol>"],
			npcId = 8580,
			DisplayIDs = {{7873}},
			[NORMAL_DIFF] = {
				{ 1,  10800 }, -- Darkwater Bracers
				{ 2,  10798 }, -- Atal'alarion's Tusk Ring
				{ 3,  10799 }, -- Headspike
			},
		},
		{ -- STBalconyMinibosses
			name = AL["Balcony Minibosses"],
			npcId = {5716, 5712, 5717, 5714, 5715, 5713},
			DisplayIDs = {{6701},{6699},{6707},{6700},{6702},{6698}},
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
		{ -- STSpawnOfHakkar
			name = AL["Spawn of Hakkar"],
			npcId = 5708,
			DisplayIDs = {{4065}},
			[NORMAL_DIFF] = {
				{ 1,  10801 }, -- Slitherscale Boots
				{ 3,  10802 }, -- Wingveil Cloak
			},
		},
		{ -- STJammalan
			name = AL["Jammal'an the Prophet"],
			npcId = 5710,
			DisplayIDs = {{6708}},
			[NORMAL_DIFF] = {
				{ 1,  10806 }, -- Vestments of the Atal'ai Prophet
				{ 2,  10808 }, -- Gloves of the Atal'ai Prophet
				{ 3,  10807 }, -- Kilt of the Atal'ai Prophet
			},
		},
		{ -- STOgom
			name = AL["Ogom the Wretched"],
			npcId = 5711,
			DisplayIDs = {{6709}},
			[NORMAL_DIFF] = {
				{ 1,  10805 }, -- Eater of the Dead
				{ 2,  10803 }, -- Blade of the Wretched
				{ 3,  10804 }, -- Fist of the Damned
			},
		},
		{ -- STWeaver
			name = AL["Weaver"],
			npcId = 5720,
			DisplayIDs = {{6375}},
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
		{ -- STDreamscythe
			name = AL["Dreamscythe"],
			npcId = 5721,
			DisplayIDs = {{7553}},
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
		{ -- STAvatarofHakkar
			name = AL["Avatar of Hakkar"],
			npcId = 8443,
			DisplayIDs = {{8053}},
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
		{ -- STHazzas
			name = AL["Hazzas"],
			npcId = 5722,
			DisplayIDs = {{9584}},
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
			npcId = 5719,
			DisplayIDs = {{7975}},
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
			npcId = 5709,
			DisplayIDs = {{7806}},
			[NORMAL_DIFF] = {
				{ 1,  10847 }, -- Dragon's Call
				{ 3,  10833 }, -- Horns of Eranikus
				{ 4,  10829 }, -- Dragon's Eye
				{ 5,  10836 }, -- Rod of Corrosion
				{ 6,  10835 }, -- Crest of Supremacy
				{ 7,  10837 }, -- Tooth of Eranikus
				{ 8,  10828 }, -- Dire Nail
				{ 10, 10454 }, -- Essence of Eranikus
				{ 11, 10455 }, -- Chained Essence of Eranikus
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
				{ 22, 15046 }, -- Green Dragonscale Leggings
			},
		},
	},
}

data["BlackrockDepths"] = {
	MapID = 1584,
	AtlasMapID = "BlackrockDepths",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- BRDHighInterrogatorGerstahn
			name = AL["High Interrogator Gerstahn "],
			npcId = 9018,
			DisplayIDs = {{8761}},
			[NORMAL_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4,  11625 }, -- Enthralled Sphere
				{ 6,  11140 }, -- Prison Cell Key
			},
		},
		{ -- BRDHoundmaster
			name = AL["Houndmaster Grebmar"],
			npcId = 9319,
			DisplayIDs = {{9212}},
			[NORMAL_DIFF] = {
				{ 1,  11623 }, -- Spritecaster Cape
				{ 2,  11627 }, -- Fleetfoot Greaves
				{ 3,  11628 }, -- Houndmaster's Bow
				{ 4,  11629 }, -- Houndmaster's Rifle
			},
		},
		{ -- BRDLordRoccor
			name = AL["Lord Roccor"],
			npcId = 9025,
			DisplayIDs = {{5781}},
			[NORMAL_DIFF] = {
				{ 1,  22234 }, -- Mantle of Lost Hope
				{ 2,  11632 }, -- Earthslag Shoulders
				{ 3,  11631 }, -- Stoneshell Guard
				{ 4,  22397 }, -- Idol of Ferocity
				{ 5,  11630 }, -- Rockshard Pellets
				{ 7,  11813 }, -- Formula: Smoking Heart of the Mountain
				{ 8,  11811 }, -- Smoking Heart of the Mountain
			},
		},
		-- RING start
		{ -- BRDGorosh
			name = AL["Gorosh the Dervish"],
			npcId = 9027,
			DisplayIDs = {{8760}},
			[NORMAL_DIFF] = {
				{ 1,  11726 }, -- Savage Gladiator Chain
				{ 2,  22271 }, -- Leggings of Frenzied Magic
				{ 3,  22257 }, -- Bloodclot Band
				{ 4,  22266 }, -- Flarethorn
			},
		},
		{ -- BRDGrizzle
			name = AL["Grizzle"],
			npcId = 9028,
			DisplayIDs = {{7873}},
			[NORMAL_DIFF] = {
				{ 1,  11610 }, -- Plans: Dark Iron Pulverizer
				{ 2,  11608 }, -- Dark Iron Pulverizer
				{ 3,  11722 }, -- Dregmetal Spaulders
				{ 4,  11703 }, -- Stonewall Girdle
				{ 5,  22270 }, -- Entrenching Boots
				{ 6,  11702 }, -- Grizzle's Skinner
			},
		},
		{ -- BRDEviscerator
			name = AL["Eviscerator"],
			npcId = 9029,
			DisplayIDs = {{523}},
			[NORMAL_DIFF] = {
				{ 1,  11685 }, -- Splinthide Shoulders
				{ 2,  11679 }, -- Rubicund Armguards
				{ 3,  11730 }, -- Savage Gladiator Grips
				{ 4,  11686 }, -- Girdle of Beastial Fury
			},
		},
		{ -- BRDOkthor
			name = AL["Ok'thor the Breaker"],
			npcId = 9030,
			DisplayIDs = {{11538}},
			[NORMAL_DIFF] = {
				{ 1,  11665 }, -- Ogreseer Fists
				{ 2,  11662 }, -- Ban'thok Sash
				{ 3,  11728 }, -- Savage Gladiator Leggings
				{ 4,  11824 }, -- Cyclopean Band
			},
		},
		{ -- BRDAnubshiah
			name = AL["Anub'shiah"],
			npcId = 9031,
			DisplayIDs = {{3004}},
			[NORMAL_DIFF] = {
				{ 1,  11678 }, -- Carapace of Anub'shiah
				{ 2,  11677 }, -- Graverot Cape
				{ 3,  11675 }, -- Shadefiend Boots
				{ 4,  11731 }, -- Savage Gladiator Greaves
			},
		},
		{ -- BRDHedrum
			name = AL["Hedrum the Creeper"],
			npcId = 9032,
			DisplayIDs = {{8271}},
			[NORMAL_DIFF] = {
				{ 1,  11729 }, -- Savage Gladiator Helm
				{ 2,  11633 }, -- Spiderfang Carapace
				{ 3,  11634 }, -- Silkweb Gloves
				{ 4,  11635 }, -- Hookfang Shanker
			},
		},
		-- RING END
		{ -- BRDPyromancerLoregrain
			name = AL["Pyromancer Loregrain"],
			npcId = 9024,
			DisplayIDs = {{8762}},
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
			npcId = {9438, 9442, 9443, 9439, 9437, 9441},
			DisplayIDs = {{8592},{8595},{8596},{8593},{8591},{8594}},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Dark Keeper"], nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 4, "INV_Box_01", nil, AL["Secret Safe"], nil },
				{ 5,  22256 }, -- Mana Shaping Handwraps
				{ 6,  22205 }, -- Black Steel Bindings
				{ 7,  22255 }, -- Magma Forged Band
				{ 8,  22254 }, -- Wand of Eternal Light
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
				{ 20, "INV_Box_01", nil, AL["Dark Coffer"], nil },
				{ 21, 11752 }, -- Black Blood of the Tormented
				{ 22, 11751 }, -- Burning Essence
				{ 23, 11753 }, -- Eye of Kajal
			},
		},
		{ -- BRDLordIncendius
			name = AL["Lord Incendius"],
			npcId = 9017,
			DisplayIDs = {{1204}},
			[NORMAL_DIFF] = {
				{ 1,  11766 }, -- Flameweave Cuffs
				{ 2,  11764 }, -- Cinderhide Armsplints
				{ 3,  11765 }, -- Pyremail Wristguards
				{ 4,  11767 }, -- Emberplate Armguards
				{ 6,  19268 }, -- Ace of Elementals
				{ 8,  11768 }, -- Incendic Bracers
			},
		},
		{ -- BRDWarderStilgiss
			name = AL["Warder Stilgiss"],
			npcId = 9041,
			DisplayIDs = {{9089}},
			[NORMAL_DIFF] = {
				{ 1,  11782 }, -- Boreal Mantle
				{ 2,  22241 }, -- Dark Warder's Pauldrons
				{ 3,  11783 }, -- Chillsteel Girdle
				{ 4,  11784 }, -- Arbiter's Blade
			},
		},
		{ -- BRDVerek
			name = AL["Verek"],
			npcId = 9042,
			DisplayIDs = {{9019}},
			[NORMAL_DIFF] = {
				{ 1,  11755 }, -- Verek's Collar
				{ 2,  22242 }, -- Verek's Leash
			},
		},
		{ -- BRDWatchmanDoomgrip
			name = AL["Watchman Doomgrip"],
			npcId = 9476,
			DisplayIDs = {{8655}},
			[NORMAL_DIFF] = {
				{ 1,  22205 }, -- Black Steel Bindings
				{ 2,  22255 }, -- Magma Forged Band
				{ 3,  22256 }, -- Mana Shaping Handwraps
				{ 4,  22254 }, -- Wand of Eternal Light
			},
		},
		{ -- BRDFineousDarkvire
			name = AL["Fineous Darkvire <Chief Architect>"],
			npcId = 9056,
			DisplayIDs = {{8704}},
			[NORMAL_DIFF] = {
				{ 1,  11839 }, -- Chief Architect's Monocle
				{ 2,  22223 }, -- Foreman's Head Protector
				{ 3,  11842 }, -- Lead Surveyor's Mantle
				{ 4,  11841 }, -- Senior Designer's Pantaloons
				{ 6,  11840 }, -- Master Builder's Shirt
			},
		},
		{ -- BRDBaelGar
			name = AL["Bael'Gar"],
			npcId = 9016,
			DisplayIDs = {{12162}},
			[NORMAL_DIFF] = {
				{ 1,  11807 }, -- Sash of the Burning Heart
				{ 2,  11802 }, -- Lavacrest Leggings
				{ 3,  11805 }, -- Rubidium Hammer
				{ 4,  11803 }, -- Force of Magma
			},
		},
		{ -- BRDGeneralAngerforge
			name = AL["General Angerforge"],
			npcId = 9033,
			DisplayIDs = {{8756}},
			[NORMAL_DIFF] = {
				{ 1,  11820 }, -- Royal Decorated Armor
				{ 2,  11821 }, -- Warstrife Leggings
				{ 3,  11810 }, -- Force of Will
				{ 4,  11817 }, -- Lord General's Sword
				{ 5,  11816 }, -- Angerforge's Battle Axe
			},
		},
		{ -- BRDGolemLordArgelmach
			name = AL["Golem Lord Argelmach"],
			npcId = 8983,
			DisplayIDs = {{8759}},
			[NORMAL_DIFF] = {
				{ 1,  11823 }, -- Luminary Kilt
				{ 2,  11822 }, -- Omnicast Boots
				{ 3,  11669 }, -- Naglering
				{ 4,  11819 }, -- Second Wind
			},
		},
		{ -- BRDGuzzler
			name = AL["Guzzler"],
			npcId = {9537, 9502, 12944, 9543, 9499},
			DisplayIDs = {{8658},{8177},{14666},{8667},{8652}},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Hurley Blackbreath"], nil },
				{ 2,  11735 }, -- Ragefury Eyepatch
				{ 3,  18043 }, -- Coal Miner Boots
				{ 4,  22275 }, -- Firemoss Boots
				{ 5,  18044 }, -- Hurley's Tankard
				{ 7, "INV_Box_01", nil, AL["Phalanx"], nil },
				{ 8,  22212 }, -- Golem Fitted Pauldrons
				{ 9,  11745 }, -- Fists of Phalanx
				{ 10, 11744 }, -- Bloodfist
				{ 12, "INV_Box_01", nil, AL["Lokhtos Darkbargainer"], nil },
				{ 13, 18592 }, -- Plans: Sulfuron Hammer
				{ 14, 17193 }, -- Sulfuron Hammer
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
		{ -- BRDFlamelash
			name = AL["Ambassador Flamelash"],
			npcId = 9156,
			DisplayIDs = {{8329}},
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
			npcId = 8923,
			DisplayIDs = {{8270}},
			[NORMAL_DIFF] = {
				{ 1,  22245 }, -- Soot Encrusted Footwear
				{ 2,  11787 }, -- Shalehusk Boots
				{ 3,  11785 }, -- Rock Golem Bulwark
				{ 4,  11786 }, -- Stone of the Earth
			},
		},
		{ -- BRDTomb
			name = AL["Chest of The Seven"],
			npcId = {9034, 9035, 9036, 9037, 9038, 9039, 9040},
			DisplayIDs = {{8690},{8686},{8692},{8689},{8691},{8687},{8688}},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Chest of The Seven"], nil },
				{ 2,  11925 }, -- Ghostshroud
				{ 3,  11926 }, -- Deathdealer Breastplate
				{ 4,  11929 }, -- Haunting Specter Leggings
				{ 5,  11927 }, -- Legplates of the Eternal Guardian
				{ 6,  11920 }, -- Wraith Scythe
				{ 7,  11923 }, -- The Hammer of Grace
				{ 8,  11922 }, -- Blood-etched Blade
				{ 9,  11921 }, -- Impervious Giant
			},
		},
		{ -- BRDMagmus
			name = AL["Magmus"],
			npcId = 9938,
			DisplayIDs = {{12162}},
			[NORMAL_DIFF] = {
				{ 1,  11746 }, -- Golem Skull Helm
				{ 2,  11935 }, -- Magmus Stone
				{ 3,  22395 }, -- Totem of Rage
				{ 4,  22400 }, -- Libram of Truth
				{ 5,  22208 }, -- Lavastone Hammer
			},
		},
		{ -- BRDPrincess
			name = AL["Princess Moira Bronzebeard "],
			npcId = 8929,
			DisplayIDs = {{8705}},
			[NORMAL_DIFF] = {
				{ 1,  12557 }, -- Ebonsteel Spaulders
				{ 2,  12554 }, -- Hands of the Exalted Herald
				{ 3,  12556 }, -- High Priestess Boots
				{ 4,  12553 }, -- Swiftwalker Boots
			},
		},
		{ -- BRDEmperorDagranThaurissan
			name = AL["Emperor Dagran Thaurissan"],
			npcId = 9019,
			DisplayIDs = {{8807}},
			[NORMAL_DIFF] = {
				{ 1,  11684 }, -- Ironfoe
				{ 3,  11933 }, -- Imperial Jewel
				{ 4,  11930 }, -- The Emperor's New Cape
				{ 5,  11924 }, -- Robes of the Royal Crown
				{ 6,  22204 }, -- Wristguards of Renown
				{ 7,  22207 }, -- Sash of the Grand Hunt
				{ 8,  11934 }, -- Emperor's Seal
				{ 9,  11815 }, --  of Justice
				{ 10, 11928 }, -- Thaurissan's Royal Scepter
				{ 11, 11931 }, -- Dreadforge Retaliator
				{ 12, 11932 }, -- Guiding Stave of Wisdom
				{ 14, 12033 }, -- Thaurissan Family Jewels
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
				{ 18, 11611 }, -- Plans: Dark Iron Sunderer
				{ 19, 11614 }, -- Plans: Dark Iron Mail
				{ 20, 11615 }, -- Plans: Dark Iron Shoulders
				{ 21, 16048 }, -- Schematic: Dark Iron Rifle
				{ 22, 16053 }, -- Schematic: Master Engineer's Goggles
				{ 23, 16049 }, -- Schematic: Dark Iron Bomb
				{ 24, 18654 }, -- Schematic: Gnomish Alarm-O-Bot
				{ 25, 18661 }, -- Schematic: World Enlarger
				{ 27, 18232 }, -- Field Repair Bot 74A
				{ 29, 11446 }, -- A Crumpled Up Note
			},
		},
		{ -- BRDBSPlans
			name = AL["Plans"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  11614 }, -- Plans: Dark Iron Mail
				{ 2,  11615 }, -- Plans: Dark Iron Shoulders
			},
		},
		{ -- BRDTheldren
			name = AL["Theldren ( T0.5 )"],
			npcId = 16059,
			DisplayIDs = {{15981}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 2,  22305 }, -- Ironweave Mantle
				{ 3,  22330 }, -- Shroud of Arcane Mastery
				{ 4,  22318 }, -- Malgen's Long Bow
				{ 5,  22317 }, -- Lefty's Brass Knuckle
			},
		},
	},
}

data["LowerBlackrockSpire"] = {
	name = AL["Lower "] .. C_Map.GetAreaInfo(1583),
	MapID = 1583,
	AtlasMapID = "LowerBlackrockSpire",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- LBRSFelguard
			name = AL["Burning Felguard"],
			npcId = 10263,
			DisplayIDs = {{5047}},
			[NORMAL_DIFF] = {
				{ 1,  13181 }, -- Demonskin Gloves
				{ 2,  13182 }, -- Phase Blade
			},
		},
		{ -- LBRSOmokk
			name = AL["Highlord Omokk"],
			npcId = 9196,
			DisplayIDs = {{11565}},
			[NORMAL_DIFF] = {
				{ 1,  16670 }, -- Boots of the Elements
				{ 3,  13166 }, -- Slamshot Shoulders
				{ 4,  13168 }, -- Plate of the Shaman King
				{ 5,  13170 }, -- Skyshroud Leggings
				{ 6,  13169 }, -- Tressermane Leggings
				{ 7,  13167 }, -- Fist of Omokk
				{ 9,  12336 }, -- Gemstone of Spirestone
				{ 11, 12534 }, -- Omokk's Head
			},
		},
		{ -- LBRSSpirestoneBattleLord
			name = AL["Spirestone Battle Lord"],
			npcId = 9218,
			DisplayIDs = {{11576}},
			[NORMAL_DIFF] = {
				{ 1,  13284 }, -- Swiftdart Battleboots
				{ 2,  13285 }, -- The Nicker
			},
		},
		{ -- LBRSSpirestoneLordMagus
			name = AL["Spirestone Lord Magus"],
			npcId = 9217,
			DisplayIDs = {{11578}},
			[NORMAL_DIFF] = {
				{ 1,  13282 }, -- Ogreseer Tower Boots
				{ 2,  13283 }, -- Magus Ring
				{ 3,  13261 }, -- Globe of D'sak
			},
		},
		{ -- LBRSVosh
			name = AL["Shadow Hunter Vosh'gajin"],
			npcId = 9236,
			DisplayIDs = {{9732}},
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
			npcId = 9237,
			DisplayIDs = {{9733}},
			[NORMAL_DIFF] = {
				{ 1,  16676 }, -- Beaststalker's Gloves
				{ 3,  13177 }, -- Talisman of Evasion
				{ 4,  13179 }, -- Brazecore Armguards
				{ 5,  22231 }, -- Kayser's Boots of Precision
				{ 6,  13173 }, -- Flightblade Throwing Axe
				{ 7,  12582 }, -- Keris of Zul'Serak
				{ 9,  12335 }, -- Gemstone of Smolderthorn
			},
		},
		{ -- LBRSGrimaxe
			name = AL["Bannok Grimaxe"],
			npcId = 9596,
			DisplayIDs = {{9668}},
			[NORMAL_DIFF] = {
				{ 1,  12637 }, -- Backusarian Gauntlets
				{ 2,  12634 }, -- Chiselbrand Girdle
				{ 3,  12621 }, -- Demonfork
				{ 5,  12838 }, -- Plans: Arcanite Reaper
				{ 6,  12784 }, -- Arcanite Reaper
			},
		},
		{ -- LBRSSmolderweb
			name = AL["Mother Smolderweb"],
			npcId = 10596,
			DisplayIDs = {{9929}},
			[NORMAL_DIFF] = {
				{ 1,  16715 }, -- Wildheart Boots
				{ 3,  13244 }, -- Gilded Gauntlets
				{ 4,  13213 }, -- Smolderweb's Eye
				{ 5,  13183 }, -- Venomspitter
			},
		},
		{ -- LBRSCrystalFang
			name = AL["Crystal Fang"],
			npcId = 10376,
			DisplayIDs = {{9755}},
			[NORMAL_DIFF] = {
				{ 1,  13185 }, -- Sunderseer Mantle
				{ 2,  13184 }, -- Fallbrush Handgrips
				{ 3,  13218 }, -- Fang of the Crystal Spider
			},
		},
		{ -- LBRSDoomhowl
			name = AL["Urok Doomhowl"],
			npcId = 10584,
			DisplayIDs = {{11583}},
			[NORMAL_DIFF] = {
				{ 1,  13258 }, -- Slaghide Gauntlets
				{ 2,  22232 }, -- Marksman's Girdle
				{ 3,  13259 }, -- Ribsteel Footguards
				{ 4,  13178 }, -- Rosewine Circle
				{ 6,  18784 }, -- Top Half of Advanced Armorsmithing: Volume III
				{ 7,  12725 }, -- Plans: Enchanted Thorium Helm
				{ 8,  12620 }, -- Enchanted Thorium Helm
			},
		},
		{ -- LBRSZigris
			name = AL["Quartermaster Zigris"],
			npcId = 9736,
			DisplayIDs = {{9738}},
			[NORMAL_DIFF] = {
				{ 1,  13253 }, -- Hands of Power
				{ 2,  13252 }, -- Cloudrunner Girdle
				{ 4,  12835 }, -- Plans: Annihilator
				{ 5,  12798 }, -- Annihilator
			},
		},
		{ -- LBRSHalycon
			name = AL["Halycon"],
			npcId = 10220,
			DisplayIDs = {{9567}},
			[NORMAL_DIFF] = {
				{ 1,  13212 }, -- Halycon's Spiked Collar
				{ 2,  22313 }, -- Ironweave Bracers
				{ 3,  13211 }, -- Slashclaw Bracers
				{ 4,  13210 }, -- Pads of the Dread Wolf
			},
		},
		{ -- LBRSSlavener
			name = AL["Gizrul the Slavener"],
			npcId = 10268,
			DisplayIDs = {{9564}},
			[NORMAL_DIFF] = {
				{ 1,  16718 }, -- Wildheart Spaulders
				{ 3,  13208 }, -- Bleak Howler Armguards
				{ 4,  13206 }, -- Wolfshear Leggings
				{ 5,  13205 }, -- Rhombeard Protector
			},
		},
		{ -- LBRSBashguud
			name = AL["Ghok Bashguud"],
			npcId = 9718,
			DisplayIDs = {{11809}},
			[NORMAL_DIFF] = {
				{ 1,  13203 }, -- Armswake Cloak
				{ 2,  13198 }, -- Hurd Smasher
				{ 3,  13204 }, -- Bashguuder
			},
		},
		{ -- LBRSSpirestoneButcher
			name = AL["Spirestone Butcher"],
			npcId = 9219,
			DisplayIDs = {{11574}},
			[NORMAL_DIFF] = {
				{ 1,  12608 }, -- Butcher's Apron
				{ 2,  13286 }, -- Rivenspike
			},
		},
		{ -- LBRSWyrmthalak
			name = AL["Overlord Wyrmthalak"],
			npcId = 9568,
			DisplayIDs = {{8711}},
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
				{ 17, 13966 }, -- Mark of Tyranny
				{ 18, 13968 }, -- Eye of the Beast
				{ 19, 13965 }, -- Blackhand's Breadth
			},
		},
		
		
		{ -- LBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  14513 }, -- Pattern: Robe of the Archmage
				{ 2,  14152 }, -- Robe of the Archmage
				{ 4,  16696 }, -- Devout Belt
				{ 5,  16685 }, -- Magister's Belt
				{ 6,  16683 }, -- Magister's Bindings
				{ 7,  16703 }, -- Dreadmist Bracers
				{ 8,  16713 }, -- Shadowcraft Belt
				{ 9,  16716 }, -- Wildheart Belt
				{ 10, 16680 }, -- Beaststalker's Belt
				{ 11, 16673 }, -- Cord of Elements
				{ 12, 16736 }, -- Belt of Valor
				{ 13, 16735 }, -- Bracers of Valor
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
			name = AL["Mor Grayhoof ( T0.5 )"],
			npcId = 16080,
			DisplayIDs = {{15997}},
			ExtraList = true,
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
	name = AL["Upper "] .. C_Map.GetAreaInfo(1583),
	MapID = 1583,
	AtlasMapID = "UpperBlackrockSpire",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- UBRSEmberseer
			name = AL["Pyroguard Emberseer"],
			npcId = 9816,
			DisplayIDs = {{2172}},
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
			npcId = 10264,
			DisplayIDs = {{9581}},
			[NORMAL_DIFF] = {
				{ 1,  16695 }, -- Devout Mantle
				{ 3,  12609 }, -- Polychromatic Visionwrap
				{ 4,  12603 }, -- Nightbrace Tunic
				{ 5,  12589 }, -- Dustfeather Sash
				{ 6,  12606 }, -- Crystallized Girdle
				{ 8,  18657 }, -- Schematic: Hyper-Radiant Flame Reflector
				{ 9,  18638 }, -- Hyper-Radiant Flame Reflector
			},
		},
		{ -- UBRSAnvilcrack
			name = AL["Goraluk Anvilcrack "],
			npcId = 10899,
			DisplayIDs = {{10222}},
			[NORMAL_DIFF] = {
				{ 1,  13502 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3,  18047 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12790 }, -- Arcanite Champion
				{ 8,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9,  12794 }, -- Masterwork Stormhammer
				{ 11, 18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 12, 12727 }, -- Plans: Enchanted Thorium Breastplate
				{ 13, 12618 }, -- Enchanted Thorium Breastplate
				{ 16, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 17, 12806 }, -- Unforged Rune Covered Breastplate
				{ 18, 12696 }, -- Plans: Demon Forged Breastplate
				{ 19, 12628 }, -- Demon Forged Breastplate
			},
		},
		{ -- UBRSRunewatcher
			name = AL["Jed Runewatcher"],
			npcId = 10509,
			DisplayIDs = {{9686}},
			[NORMAL_DIFF] = {
				{ 1,  12604 }, -- Starfire Tiara
				{ 2,  12930 }, -- Briarwood Reed
				{ 3,  12605 }, -- Serpentine Skuller
			},
		},
		{ -- UBRSGyth
			name = AL["Gyth"],
			npcId = 10339,
			DisplayIDs = {{9806}},
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
			npcId = 10429,
			DisplayIDs = {{9778}},
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
			npcId = 10430,
			DisplayIDs = {{10193}},
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
			npcId = 10363,
			DisplayIDs = {{10115}},
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
				{ 13, 15047 }, -- Red Dragonscale Breastplate
				{ 15, 13519 }, -- Recipe: Flask of the Titans
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
		{ -- UBRSValthalak
			name = AL["Lord Valthalak ( T0.5 )"],
			npcId = 16042,
			DisplayIDs = {{14308}},
			ExtraList = true,
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
	name = C_Map.GetAreaInfo(2557) .." ".. AL["East"],
	MapID = 2557,
	AtlasMapID = "DireMaul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- DMEPusillin
			name = AL["Pusillin"],
			npcId = 14354,
			DisplayIDs = {{7552}},
			[NORMAL_DIFF] = {
				{ 1,  18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3,  18249 }, -- Crescent Key
			},
		},
		{ -- DMEZevrimThornhoof
			name = AL["Zevrim Thornhoof"],
			npcId = 11490,
			DisplayIDs = {{11335}},
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
			npcId = 13280,
			DisplayIDs = {{5489}},
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
			npcId = 14327,
			DisplayIDs = {{14378}},
			[NORMAL_DIFF] = {
				{ 1,  18325 }, -- Felhide Cap
				{ 2,  18311 }, -- Quel'dorai Channeling Rod
				{ 4,  18301 }, -- Lethtendris's Wand
				{ 5,  18302 }, -- Band of Vigor
			},
		},
		{ -- DMEAlzzin
			name = AL["Alzzin the Wildshaper"],
			npcId = 11492,
			DisplayIDs = {{14416}},
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
			name = AL["Isalien ( T0.5 )"],
			npcId = 16097,
			DisplayIDs = {{16000}},
			ExtraList = true,
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
	name = C_Map.GetAreaInfo(2557) .." ".. AL["West"],
	MapID = 2557,
	AtlasMapID = "DireMaul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- DMWTendrisWarpwood
			name = AL["Tendris Warpwood"],
			npcId = 11489,
			DisplayIDs = {{14383}},
			[NORMAL_DIFF] = {
				{ 1,  18393 }, -- Warpwood Binding
				{ 2,  18390 }, -- Tanglemoss Leggings
				{ 4,  18352 }, -- Petrified Bark Shield
				{ 5,  18353 }, -- Stoneflower Staff
			},
		},
		{ -- DMWTsuzee
			name = AL["Tsu'zee"],
			npcId = 11467,
			DisplayIDs = {{11250}},
			[NORMAL_DIFF] = {
				{ 1,  18387 }, -- Brightspark Gloves
				{ 3,  18346 }, -- Threadbare Trousers
				{ 4,  18345 }, -- Murmuring Ring
			},
		},
		{ -- DMWIllyannaRavenoak
			name = AL["Illyanna Ravenoak"],
			npcId = 11488,
			DisplayIDs = {{11270}},
			[NORMAL_DIFF] = {
				{ 1,  18383 }, -- Force Imbued Gauntlets
				{ 2,  18386 }, -- Padre's Trousers
				{ 4,  18349 }, -- Gauntlets of Accuracy
				{ 5,  18347 }, -- Well Balanced Axe
			},
		},
		{ -- DMWMagisterKalendris
			name = AL["Magister Kalendris"],
			npcId = 11487,
			DisplayIDs = {{14384}},
			[NORMAL_DIFF] = {
				{ 1,  18374 }, -- Flamescarred Shoulders
				{ 2,  18397 }, -- Elder Magus Pendant
				{ 3,  18371 }, -- Mindtap Talisman
				{ 5,  18350 }, -- Amplifying Cloak
				{ 6,  18351 }, -- Magically Sealed Bracers
				{ 8,  22309 }, -- Pattern: Big Bag of Enchantment
				{ 9,  22249 }, -- Big Bag of Enchantment
			},
		},
		{ -- DMWImmolthar
			name = AL["Immol'thar"],
			npcId = 11496,
			DisplayIDs = {{14173}},
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
			npcId = 11486,
			DisplayIDs = {{11256}},
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
			npcId = 14371,
			DisplayIDs = {{14412}},
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
				{ 2,  18486 }, -- Mooncloth Robe
			},
		},
		{ -- DMWHelnurath
			name = AL["Lord Hel'nurath"],
			npcId = 14506,
			DisplayIDs = {{14556}},
			ExtraList = true,
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
	name = C_Map.GetAreaInfo(2557) .." ".. AL["North"],
	MapID = 2557,
	AtlasMapID = "DireMaulNorth",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- DMNGuardMoldar
			name = AL["Guard Mol'dar"],
			npcId = 14326,
			DisplayIDs = {{11561}},
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
			name = AL["Stomper Kreeg <The Drunk>"],
			npcId = 14322,
			DisplayIDs = {{11545}},
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
			npcId = 14321,
			DisplayIDs = {{11561}},
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
		{ -- DMNThimblejack
			name = AL["Knot Thimblejack's Cache"],
			[NORMAL_DIFF] = {
				{ 1,  18414 }, -- Pattern: Belt of the Archmage
				{ 2,  18517 }, -- Pattern: Chromatic Cloak
				{ 3,  18518 }, -- Pattern: Hide of the Wild
				{ 4,  18519 }, -- Pattern: Shifting Cloak
				{ 6,  18415 }, -- Pattern: Felcloth Gloves
				{ 7,  18416 }, -- Pattern: Inferno Gloves
				{ 8,  18417 }, -- Pattern: Mooncloth Gloves
				{ 9,  18418 }, -- Pattern: Cloak of Warding
				{ 10, 18514 }, -- Pattern: Girdle of Insight
				{ 11, 18515 }, -- Pattern: Mongoose Boots
				{ 12, 18516 }, -- Pattern: Swift Flight Bracers
				{ 14, 18258 }, -- Gordok Ogre Suit
				{ 15, 18240 }, -- Ogre Tannin
				{ 16, 18405 }, -- Belt of the Archmage
				{ 17, 18509 }, -- Chromatic Cloak
				{ 18, 18510 }, -- Hide of the Wild
				{ 19, 18511 }, -- Shifting Cloak
				{ 21, 18407 }, -- Felcloth Gloves
				{ 22, 18408 }, -- Inferno Gloves
				{ 23, 18409 }, -- Mooncloth Gloves
				{ 24, 18413 }, -- Cloak of Warding
				{ 25, 18504 }, -- Girdle of Insight
				{ 26, 18506 }, -- Mongoose Boots
				{ 27, 18508 }, -- Swift Flight Bracers
			},
		},
		{ -- DMNGuardSlipkik
			name = AL["Guard Slip'kik"],
			npcId = 14323,
			DisplayIDs = {{11561}},
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
		{ -- DMNCaptainKromcrush
			name = AL["Captain Kromcrush"],
			npcId = 14325,
			DisplayIDs = {{11564}},
			[NORMAL_DIFF] = {
				{ 1,  18503 }, -- Kromcrush's Chestplate
				{ 2,  18505 }, -- Mugger's Belt
				{ 3,  18507 }, -- Boots of the Full Moon
				{ 4,  18502 }, -- Monstrous Glaive
			},
		},
		{ -- DMNChoRush
			name = AL["Cho'Rush the Observer"],
			npcId = 14324,
			DisplayIDs = {{11537}},
			[NORMAL_DIFF] = {
				{ 1,  18490 }, -- Insightful Hood
				{ 2,  18483 }, -- Mana Channeling Wand
				{ 3,  18485 }, -- Observer's Shield
				{ 4,  18484 }, -- Cho'Rush's Blade
			},
		},
		{ -- DMNKingGordok
			name = AL["King Gordok"],
			npcId = 11501,
			DisplayIDs = {{11583}},
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
				{ 19, 12727 }, -- Plans: Enchanted Thorium Breastplate
				{ 20, 12618 }, -- Enchanted Thorium Breastplate
			},
		},
		{ -- DMNTRIBUTERUN
			name = AL["Tribute"],
			ExtraList = true,
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
				{ 24, 18655 }, -- Schematic: Major Recombobulator
				{ 25, 18637 }, -- Major Recombobulator
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
	AtlasMapID = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- SCHOLOBlood
			name = AL["Blood Steward of Kirtonos"],
			npcId = 14861,
			DisplayIDs = {{10925}},
			[NORMAL_DIFF] = {
				{ 1,  13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLOKirtonostheHerald
			name = AL["Kirtonos the Herald"],
			npcId = 10506,
			DisplayIDs = {{7534}},
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
			npcId = 10503,
			DisplayIDs = {{11073}},
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
			npcId = 11622,
			DisplayIDs = {{12073}},
			[NORMAL_DIFF] = {
				{ 1,  16711 }, -- Shadowcraft Boots
				{ 3,  14539 }, -- Bone Ring Helm
				{ 4,  14538 }, -- Deadwalker Mantle
				{ 5,  18686 }, -- Bone Golem Shoulders
				{ 6,  14537 }, -- Corpselight Greaves
				{ 7,  14528 }, -- Rattlecage Buckler
				{ 8,  14531 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 11, 12726 }, -- Plans: Enchanted Thorium Leggings
				{ 12, 12619 }, -- Enchanted Thorium Leggings
				{ 14, 13873 }, -- Viewing Room Key
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcId = 14516,
			DisplayIDs = {{14591}},
			[NORMAL_DIFF] = {
				{ 1,  18760 }, -- Necromantic Band
				{ 2,  18761 }, -- Oblivion's Touch
				{ 3,  18758 }, -- Specter's Blade
				{ 4,  18759 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOMarduk
			name = AL["Marduk Blackpool"],
			npcId = 10433,
			DisplayIDs = {{10248}},
			[NORMAL_DIFF] = {
				{ 1,  18692 }, -- Death Knight Sabatons
				{ 2,  14576 }, -- Ebon Hilt of Marduk
			},
		},
		{ -- SCHOLOVectus
			name = AL["Vectus"],
			npcId = 10432,
			DisplayIDs = {{2606}},
			[NORMAL_DIFF] = {
				{ 1,  18691 }, -- Dark Advisor's Pendant
				{ 2,  14577 }, -- Skullsmoke Pants
			},
		},
		{ -- SCHOLORasFrostwhisper
			name = AL["Ras Frostwhisper"],
			npcId = 10508,
			DisplayIDs = {{7919}},
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
		{ -- SCHOLODoctorTheolenKrastinov
			name = AL["Doctor Theolen Krastinov"],
			npcId = 11261,
			DisplayIDs = {{10901}},
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
			npcId = 10901,
			DisplayIDs = {{11492}},
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
		{ -- SCHOLOInstructorMalicia
			name = AL["Instructor Malicia"],
			npcId = 10505,
			DisplayIDs = {{11069}},
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
		{ -- SCHOLOLadyIlluciaBarov
			name = AL["Lady Illucia Barov"],
			npcId = 10502,
			DisplayIDs = {{11835}},
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
		{ -- SCHOLOLordAlexeiBarov
			name = AL["Lord Alexei Barov"],
			npcId = 10504,
			DisplayIDs = {{11072}},
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
		{ -- SCHOLOTheRavenian
			name = AL["The Ravenian"],
			npcId = 10507,
			DisplayIDs = {{10433}},
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
		{ -- SCHOLODarkmasterGandling
			name = AL["Darkmaster Gandling"],
			npcId = 1853,
			DisplayIDs = {{11070}},
			[NORMAL_DIFF] = {
				{ 1,  13937 }, -- Headmaster's Charge
				{ 2,  14514 }, -- Pattern: Robe of the Void
				{ 3,  14153 }, -- Robe of the Void
				{ 5,  16693 }, -- Devout Crown
				{ 6,  16686 }, -- Magister's Crown
				{ 7,  16698 }, -- Dreadmist Mask
				{ 8,  16707 }, -- Shadowcraft Cap
				{ 9,  16720 }, -- Wildheart Cowl
				{ 10, 16677 }, -- Beaststalker's Cap
				{ 11, 16667 }, -- Coif of Elements
				{ 12, 16727 }, -- Lightforge Helm
				{ 13, 16731 }, -- Helm of Valor
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
		{ -- SCHOLOKormok
			name = AL["Kormok ( T0.5 )"],
			npcId = 16118,
			DisplayIDs = {{16020}},
			ExtraList = true,
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
	AtlasMapID = "Stratholme",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{ -- STRATSkull
			name = AL["Skul"],
			npcId = 10393,
			DisplayIDs = {{2606}},
			[NORMAL_DIFF] = {
				{ 1,  13395 }, -- Skul's Fingerbone Claws
				{ 2,  13394 }, -- Skul's Cold Embrace
				{ 3,  13396 }, -- Skul's Ghastly Touch
			},
		},
		{ -- STRATStratholmeCourier
			name = AL["Stratholme Courier"],
			npcId = 11082,
			DisplayIDs = {{10547}},
			[NORMAL_DIFF] = {
				{ 1,  13303 }, -- Crusaders' Square Postbox Key
				{ 2,  13305 }, -- Elders' Square Postbox Key
				{ 3,  13304 }, -- Festival Lane Postbox Key
				{ 4,  13307 }, -- Fras Siabi's Postbox Key
				{ 5,  13306 }, -- King's Square Postbox Key
				{ 6,  13302 }, -- Market Row Postbox Key
			},
		},
		{ -- STRATTheUnforgiven
			name = AL["The Unforgiven"],
			npcId = 10516,
			DisplayIDs = {{10771}},
			[NORMAL_DIFF] = {
				{ 1,  16717 }, -- Wildheart Gloves
				{ 3,  13404 }, -- Mask of the Unforgiven
				{ 4,  13405 }, -- Wailing Nightbane Pauldrons
				{ 5,  13409 }, -- Tearfall Bracers
				{ 6,  13408 }, -- Soul Breaker
			},
		},
		{ -- STRATHearthsingerForresten
			name = AL["Hearthsinger Forresten"],
			npcId = 10558,
			DisplayIDs = {{10482}},
			[NORMAL_DIFF] = {
				{ 1,  16682 }, -- Magister's Boots
				{ 3,  13378 }, -- Songbird Blouse
				{ 4,  13384 }, -- Rainbow Girdle
				{ 5,  13383 }, -- Woollies of the Prancing Minstrel
				{ 6,  13379 }, -- Piccolo of the Flaming Fire
			},
		},
		{ -- STRATTimmytheCruel
			name = AL["Timmy the Cruel"],
			npcId = 10808,
			DisplayIDs = {{571}},
			[NORMAL_DIFF] = {
				{ 1,  16724 }, -- Lightforge Gauntlets
				{ 3,  13400 }, -- Vambraces of the Sadist
				{ 4,  13403 }, -- Grimgore Noose
				{ 5,  13402 }, -- Timmy's Galoshes
				{ 6,  13401 }, -- The Cruel Hand of Timmy
			},
		},
		{ -- STRATMalorsStrongbox
			name = AL["Malor the Zealous"],
			npcId = 11032,
			DisplayIDs = {{10458}},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2,  12845 }, -- Medallion of Faith
			},
		},
		{ -- STRATBalzaphon
			name = AL["Balzaphon"],
			npcId = 14684,
			DisplayIDs = {{7919}},
			[NORMAL_DIFF] = {
				{ 1,  23125 }, -- Chains of the Lich
				{ 2,  23126 }, -- Waistband of Balzaphon
				{ 3,  23124 }, -- Staff of Balzaphon
			},
		},
		{ -- STRATCrimsonHammersmith
			name = AL["Crimson Hammersmith"],
			npcId = 11120,
			DisplayIDs = {{10637}},
			[NORMAL_DIFF] = {
				{ 1,  18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
				{ 2,  12726 }, -- Plans: Enchanted Thorium Leggings
				{ 3,  12619 }, -- Enchanted Thorium Leggings
				{ 5,  12824 }, -- Plans: Enchanted Battlehammer
				{ 6,  12776 }, -- Enchanted Battlehammer
			},
		},
		{ -- STRATCannonMasterWilley
			name = AL["Cannon Master Willey"],
			npcId = 10997,
			DisplayIDs = {{10674}},
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
				{ 17, 12783 }, -- Heartseeker
			},
		},
		{ -- STRATArchivistGalford
			name = AL["Archivist Galford"],
			npcId = 10811,
			DisplayIDs = {{10544}},
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
			npcId = 10813,
			DisplayIDs = {{10691}},
			[NORMAL_DIFF] = {
				{ 1,  13353 }, -- Book of the Dead
				{ 2,  14512 }, -- Pattern: Truefaith Vestments
				{ 3,  14154 }, -- Truefaith Vestments
				{ 5,  16725 }, -- Lightforge Boots
				{ 7,  13359 }, -- Crown of Tyranny
				{ 8,  18718 }, -- Grand Crusader's Helm
				{ 9,  12103 }, -- Star of Mystaria
				{ 10, 18720 }, -- Shroud of the Nathrezim
				{ 11, 13358 }, -- Wyrmtongue Shoulders
				{ 12, 13369 }, -- Fire Striders
				{ 13, 13360 }, -- Gift of the Elven Magi
				{ 14, 18717 }, -- Hammer of the Grand Crusader
				{ 15, 13348 }, -- Demonshear
				{ 16, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 18, 13250 }, -- Head of Balnazzar
			},
		},
		{ -- STRATStonespine
			name = AL["Stonespine"],
			npcId = 10809,
			DisplayIDs = {{7856}},
			[NORMAL_DIFF] = {
				{ 1,  13397 }, -- Stoneskin Gargoyle Cape
				{ 2,  13954 }, -- Verdant Footpads
				{ 3,  13399 }, -- Gargoyle Shredder Talons
			},
		},
		{ -- STRATBaronessAnastari
			name = AL["Baroness Anastari"],
			npcId = 10436,
			DisplayIDs = {{10698}},
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
			npcId = 11121,
			DisplayIDs = {{775}},
			[NORMAL_DIFF] = {
				{ 1,  18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				{ 2,  12725 }, -- Plans: Enchanted Thorium Helm
				{ 3,  12620 }, -- Enchanted Thorium Helm
				{ 5,  12825 }, -- Plans: Blazing Rapier
				{ 6,  12777 }, -- Blazing Rapier
			},
		},
		{ -- STRATNerubenkan
			name = AL["Nerub'enkan"],
			npcId = 10437,
			DisplayIDs = {{9793}},
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
			npcId = 10438,
			DisplayIDs = {{10546}},
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
				{ 17, 12796 }, -- Hammer of the Titans
			},
		},
		{ -- STRATMagistrateBarthilas
			name = AL["Magistrate Barthilas"],
			npcId = 10435,
			DisplayIDs = {{10433}},
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
		{ -- STRATRamsteintheGorger
			name = AL["Ramstein the Gorger"],
			npcId = 10439,
			DisplayIDs = {{12818}},
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
		{ -- STRATPostmaster
			name = AL["Postmaster Malown"],
			npcId = 11143,
			DisplayIDs = {{10669}},
			[NORMAL_DIFF] = {
				{ 1,  13390 }, -- The Postmaster's Band
				{ 2,  13388 }, -- The Postmaster's Tunic
				{ 3,  13389 }, -- The Postmaster's Trousers
				{ 4,  13391 }, -- The Postmaster's Treads
				{ 5,  13392 }, -- The Postmaster's Seal
				{ 6,  13393 }, -- Malown's Slam
			},
		},
		{ -- STRATBaronRivendare
			name = AL["Baron Rivendare"],
			npcId = 10440,
			DisplayIDs = {{10729}},
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
		{ -- STRATSothosJarien
			name = AL["Sothos and Jarien's Heirlooms ( T0.5 )"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  22327 }, -- Amulet of the Redeemed
				{ 2,  22301 }, -- Ironweave Robe
				{ 3,  22328 }, -- Legplates of Vigilance
				{ 4,  22334 }, -- Band of Mending
				{ 5,  22329 }, -- Scepter of Interminable Focus
			},
		},
		{ -- STRATBSPlansSerenity / STRATBSPlansCorruption
			name = AL["Plans"],
			ExtraList = true,
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
			[NORMAL_DIFF] = {
				{ 1,  22736 }, -- Andonisus, Reaper of Souls
			},
		},
		KEYS,
	},
}


-- ########################
-- Raids
-- ########################
data["MoltenCore"] = {
	MapID = 2717,
	AtlasMapID = "MoltenCore",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{	--MCLucifron
			name = AL["Lucifron"],
			npcId = 12118,
			DisplayIDs = {{13031},{12030}},
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
			npcId = 11982,
			DisplayIDs = {{10193}},
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
				{ 28, 18203 },	-- Eskhandar's Right Claw
				{ 29, 17073 },	-- Earthshaker
				{ 30, 18822 },	-- Obsidian Edged Blade
			},
		},
		{	--MCGehennas
			name = AL["Gehennas"],
			npcId = 12259,
			DisplayIDs = {{13030},{12002}},
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
			npcId = 12057,
			DisplayIDs = {{12110}, {5781}},
			[NORMAL_DIFF] = {
				{ 1,  16813 },	-- Circlet of Prophecy
				{ 2,  16795 },	-- Arcanist Crown
				{ 3,  16808 },	-- Felheart Horns
				{ 4,  16821 },	-- Nightslayer Cover
				{ 5,  16834 },	-- Cenarion Helm
				{ 6,  16846 },	-- Giantstalker's Helmet
				{ 7,  16842 },	-- Earthfury Helmet
				{ 8,  16854 },	-- Lawbringer Helm
				{ 9,  16866 },	-- Helm of Might
				{ 14, 18564 },	-- Bindings of the Windseeker
				{ 15, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
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
			npcId = 12264,
			DisplayIDs = {{13032}},
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
			npcId = 12056,
			DisplayIDs = {{12129}},
			[NORMAL_DIFF] = {
				{ 1,  16797 },	-- Arcanist Mantle
				{ 2,  16807 },	-- Felheart Shoulder Pads
				{ 3,  16836 },	-- Cenarion Spaulders
				{ 4,  16844 },	-- Earthfury Epaulets
				{ 5,  16856 },	-- Lawbringer Spaulders
				{ 14, 18563 },	-- Bindings of the Windseeker
				{ 15, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
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
			npcId = 11988,
			DisplayIDs = {{11986}},
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
				{ 14, 17203 },	-- Sulfuron Ingot
				{ 15, 17182 },	-- Sulfuras, Hand of Ragnaros
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
			npcId = 12098,
			DisplayIDs = {{13030},{12030}},
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
				{ 27, 17223 }, -- Thunderstrike
			},
		},
		{ -- MCMajordomo
			name = AL["Majordomo Executus"],
			npcId = 12018,
			DisplayIDs = {{12029},{13029},{12002}},
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
				{ 17, 18714 }, -- Ancient Sinew Wrapped Lamina
				{ 18, 18713 }, -- Rhok'delar, Longbow of the Ancient Keepers
				{ 19, 18715 }, -- Lok'delar, Stave of the Ancient Keepers
				{ 21, 18646 }, -- The Eye of Divinity
				{ 22, 18608 }, -- Benediction
				{ 23, 18609 }, -- Anathema
			},
		},
		{ -- MCRagnaros
			name = AL["Ragnaros"],
			npcId = 11502,
			DisplayIDs = {{11121}},
			[NORMAL_DIFF] = {
				{ 1,  16922 }, -- Leggings of Transcendence
				{ 2,  16915 }, -- Netherwind Pants
				{ 3,  16930 }, -- Nemesis Leggings
				{ 4,  16909 }, -- Bloodfang Pants
				{ 5,  16901 }, -- Stormrage Legguards
				{ 6,  16938 }, -- Dragonstalker's Legguards
				{ 7,  16946 }, -- Legplates of Ten Storms
				{ 8,  16954 }, -- Judgement Legplates
				{ 9,  16962 }, -- Legplates of Wrath
				{ 11, 17204 }, -- Eye of Sulfuras
				{ 12, 17182 }, -- Sulfuras, Hand of Ragnaros
				{ 14, 19017 }, -- Essence of the Firelord
				{ 15, 19019 }, -- Thunderfury, Blessed Blade of the Windseeker
				{ 16, 18817 }, -- Crown of Destruction
				{ 17, 18814 }, -- Choker of the Fire Lord
				{ 18, 17102 }, -- Cloak of the Shrouded Mists
				{ 19, 17107 }, -- Dragon's Blood Cape
				{ 20, 19137 }, -- Onslaught Girdle
				{ 21, 17063 }, -- Band of Accuria
				{ 22, 19138 }, -- Band of Sulfuras
				{ 23, 18815 }, -- Essence of the Pure Flame
				{ 24, 17082 }, -- Shard of the Flame
				{ 25, 17106 }, -- Malistar's Defender
				{ 26, 18816 }, -- Perdition's Blade
				{ 27, 17104 }, -- Spinal Reaper
				{ 28, 17076 }, -- Bonereaver's Edge
			},
		},
		{ -- MCRANDOMBOSSDROPS
			name = AL["All bosses"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 2,  18262 }, -- Elemental Sharpening Stone
				{ 4,  18292 }, -- Schematic: Core Marksman Rifle
				{ 5,  18282 }, -- Core Marksman Rifle
				{ 7,  18291 }, -- Schematic: Force Reactive Disk
				{ 8,  18168 }, -- Force Reactive Disk
				{ 10, 18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 11, 18283 }, -- Biznicks 247x128 Accurascope
				{ 13, 18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 17, 18251 }, -- Core Armor Kit
				{ 19, 18265 }, -- Pattern: Flarecore Wraps
				{ 20, 18263 }, -- Flarecore Wraps
				{ 22, 21371 }, -- Pattern: Core Felcloth Bag
				{ 23, 21342 }, -- Core Felcloth Bag
				{ 25, 18257 }, -- Recipe: Major Rejuvenation Potion
				{ 26, 18253 }, -- Major Rejuvenation Potion
				{ 28, 18260 }, -- Formula: Enchant Weapon - Healing Power
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
	}
}

data["Onyxia"] = {
	MapID = 2159,
	AtlasMapID = "Onyxia",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ -- Onyxia
			name = AL["Onyxia"],
			npcId = 10184,
			DisplayIDs = {{8570}},
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
				{ 12, 18404 }, -- Onyxia Tooth Pendant
				{ 13, 18403 }, -- Dragonslayer's Signet
				{ 14, 18406 }, -- Onyxia Blood Talisman
				{ 15, 15138 }, -- Onyxia Scale Cloak
				{ 16, 18705 }, -- Mature Black Dragon Sinew
				{ 17, 18713 }, -- Rhok'delar, Longbow of the Ancient Keepers
				{ 19, 18205 }, -- Eskhandar's Collar
				{ 20, 17078 }, -- Sapphiron Drape
				{ 21, 18813 }, -- Ring of Binding
				{ 22, 17064 }, -- Shard of the Scale
				{ 23, 17067 }, -- Ancient Cornerstone Grimoire
				{ 24, 17068 }, -- Deathbringer
				{ 25, 17075 }, -- Vis'kag the Bloodletter
				{ 27, 17966 }, -- Onyxia Hide Backpack
				{ 28, 17962 }, -- Blue Sack of Gems
				{ 30, 15410 }, -- Scale of Onyxia
			},
		},
	},
}

data["Zul'Gurub"] = {
	MapID = 1977,
	AtlasMapID = "Zul'Gurub", -- ??
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	items = {
		{ -- ZGJeklik
			name = AL["High Priestess Jeklik"],
			npcId = 14517,
			DisplayIDs = {{15219}},
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
			npcId = 14507,
			DisplayIDs = {{15217}},
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
			npcId = 14510,
			DisplayIDs = {{15220}},
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
			npcId = 11382,
			DisplayIDs = {{11288}},
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
			npcId = 15082,
			DisplayIDs = {{8390}},
			[NORMAL_DIFF] = {
				{ 1,  19961 }, -- Gri'lek's Grinder
				{ 2,  19962 }, -- Gri'lek's Carver
				{ 4,  19939 }, -- Gri'lek's Blood
			},
		},
		{ -- ZGHazzarah
			name = AL["Hazza'rah"],
			npcId = 15083,
			DisplayIDs = {{15267}},
			[NORMAL_DIFF] = {
				{ 1,  19967 }, -- Thoughtblighter
				{ 2,  19968 }, -- Fiery Retributer
				{ 4,  19942 }, -- Hazza'rah's Dream Thread
			},
		},
		{ -- ZGRenataki
			name = AL["Renataki"],
			npcId = 15084,
			DisplayIDs = {{15268}},
			[NORMAL_DIFF] = {
				{ 1,  19964 }, -- Renataki's Soul Conduit
				{ 2,  19963 }, -- Pitchfork of Madness
				{ 4,  19940 }, -- Renataki's Tooth
			},
		},
		{ -- ZGWushoolay
			name = AL["Wushoolay"],
			npcId = 15085,
			DisplayIDs = {{15269}},
			[NORMAL_DIFF] = {
				{ 1,  19993 }, -- Hoodoo Hunting Bow
				{ 2,  19965 }, -- Wushoolay's Poker
				{ 4,  19941 }, -- Wushoolay's Mane
			},
		},
		{ -- ZGGahzranka
			name = AL["Gahz'ranka"],
			npcId = 15114,
			DisplayIDs = {{15288}},
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
			npcId = 14509,
			DisplayIDs = {{15216}},
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
			npcId = 14515,
			DisplayIDs = {{15218}},
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
			npcId = 11380,
			DisplayIDs = {{11311}},
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
			npcId = 14834,
			DisplayIDs = {{15295}},
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
				{ 17, 19950 }, -- Zandalarian Hero Charm(ZHC)
				{ 18, 19949 }, -- Zandalarian Hero Medallion
				{ 19, 19948 }, -- Zandalarian Hero Badge
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
				{ 101,  19706 }, -- Bloodscalp Coin
				{ 102,  19701 }, -- Gurubashi Coin
				{ 103,  19700 }, -- Hakkari Coin
				{ 104,  19699 }, -- Razzashi Coin
				{ 105,  19704 }, -- Sandfury Coin
				{ 106,  19705 }, -- Skullsplitter Coin
				{ 107,  19702 }, -- Vilebranch Coin
				{ 108,  19703 }, -- Witherbark Coin
				{ 109,  19698 }, -- Zulian Coin
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
		{ -- ZGJinxedHoodooPile
			name = AL["Jinxed Hoodoo Pile"],
			ExtraList = true,
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
		{ -- ZGMuddyChurningWaters
			name = AL["Muddy Churning Waters"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19975 }, -- Zulian Mudskunk
			},
		},
	},
}

data["BlackwingLair"] = {
	MapID = 2677,
	AtlasMapID = "BlackwingLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ -- BWLRazorgore
			name = AL["Razorgore the Untamed"],
			npcId = 12435,
			DisplayIDs = {{10115}},
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
			npcId = 13020,
			DisplayIDs = {{13992}},
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
			npcId = 12017,
			DisplayIDs = {{14308}},
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
				{ 15, 20383 }, -- Head of the Broodlord Lashlayer
				{ 16, 19341 }, -- Lifegiving Gem
				{ 17, 19342 }, -- Venomous Totem
				{ 19, 19373 }, -- Black Brood Pauldrons
				{ 20, 19374 }, -- Bracers of Arcane Accuracy
				{ 21, 19350 }, -- Heartstriker
				{ 22, 19351 }, -- Maladath, Runed Blade of the Black Flight
			},
		},
		{ -- BWLFiremaw
			name = AL["Firemaw"],
			npcId = 11983,
			DisplayIDs = {{6377}},
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
			npcId = 14601,
			DisplayIDs = {{6377}},
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
				{ 13, 19345 }, -- Aegis of Preservation
				{ 16, 19394 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 19396 }, -- Taut Dragonhide Belt
				{ 19, 19405 }, -- Malfurion's Blessed Bulwark
				{ 21, 19368 }, -- Dragonbreath Hand Cannon
				{ 22, 19353 }, -- Drake Talon Cleaver
				{ 23, 19355 }, -- Shadow Wing Focus Staff
				{ 25, 19403 }, -- Band of Forced Concentration
				{ 26, 19397 }, -- Ring of Blackrock
				{ 27, 19406 }, -- Drake Fang Talisman
				{ 28, 19395 }, -- Rejuvenating Gem
			},
		},
		{ -- BWLFlamegor
			name = AL["Flamegor"],
			npcId = 11981,
			DisplayIDs = {{6377}},
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
				{ 28, 19395 }, -- Rejuvenating Gem
				{ 29, 19431 }, -- Styleen's Impeding Scarab
			},
		},
		{ -- BWLChromaggus
			name = AL["Chromaggus"],
			npcId = 14020,
			DisplayIDs = {{14367}},
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
			npcId = 11583,
			DisplayIDs = {{11380}},
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
				{ 12, 19003 }, -- Head of Nefarian
				{ 13, 19383 }, -- Master Dragonslayer's Medallion
				{ 14, 19384 }, -- Master Dragonslayer's Ring
				{ 15, 19366 }, -- Master Dragonslayer's Orb
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
				{ 30, 17962 }, -- Blue Sack of Gems
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
	},
}

data["TheRuinsofAhnQiraj"] = { -- AQ20
	MapID = 3429,
	AtlasMapID = "TheRuinsofAhnQiraj",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	items = {
		{ -- AQ20Kurinnaxx
			name = AL["Kurinnaxx"],
			npcId = 15348,
			DisplayIDs = {{15742}},
			[NORMAL_DIFF] = {
				{ 1,  21499 }, -- Vestments of the Shifting Sands
				{ 2,  21498 }, -- Qiraji Sacrificial Dagger
				{ 4,  21502 }, -- Sand Reaver Wristguards
				{ 5,  21501 }, -- Toughened Silithid Hide Gloves
				{ 6,  21500 }, -- Belt of the Inquisition
				{ 7,  21503 }, -- Belt of the Sand Reaver
				{ 18, 20885 }, -- Qiraji Martial Drape
				{ 19, 20889 }, -- Qiraji Regal Drape
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Rajaxx
			name = AL["General Rajaxx"],
			npcId = 15341,
			DisplayIDs = {{15376}},
			[NORMAL_DIFF] = {
				{ 1,  21493 }, -- Boots of the Vanguard
				{ 2,  21492 }, -- Manslayer of the Qiraji
				{ 4,  21496 }, -- Bracers of Qiraji Command
				{ 5,  21494 }, -- Southwind's Grasp
				{ 6,  21495 }, -- Legplates of the Qiraji Command
				{ 7,  21497 }, -- Boots of the Qiraji General
				{ 18, 20885 }, -- Qiraji Martial Drape
				{ 19, 20889 }, -- Qiraji Regal Drape
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Moam
			name = AL["Moam"],
			npcId = 15340,
			DisplayIDs = {{15392}},
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
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
				{ 23, 22220 }, -- Plans: Black Grasp of the Destroyer
				{ 24, 22194 }, -- Black Grasp of the Destroyer
			},
		},
		{ -- AQ20Buru
			name = AL["Buru the Gorger"],
			npcId = 15370,
			DisplayIDs = {{15654}},
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
				{ 18, 20885 }, -- Qiraji Martial Drape
				{ 19, 20889 }, -- Qiraji Regal Drape
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ayamiss
			name = AL["Ayamiss the Hunter"],
			npcId = 15369,
			DisplayIDs = {{15431}},
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
				{ 18, 20885 }, -- Qiraji Martial Drape
				{ 19, 20889 }, -- Qiraji Regal Drape
				{ 20, 20888 }, -- Qiraji Ceremonial Ring
				{ 21, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ossirian
			name = AL["Ossirian the Unscarred"],
			npcId = 15339,
			DisplayIDs = {{15432}},
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
				{ 24, 21504 }, -- Charm of the Shifting Sands
				{ 25, 21507 }, -- Amulet of the Shifting Sands
				{ 26, 21505 }, -- Choker of the Shifting Sands
				{ 27, 21506 }, -- Pendant of the Shifting Sands
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
	AtlasMapID = "TheTempleofAhnQiraj",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ -- AQ40Skeram
			name = AL["The Prophet Skeram"],
			npcId = 15263,
			DisplayIDs = {{15345}},
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
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
				{ 27, 22222 }, -- Plans: Thick Obsidian Breastplate
				{ 28, 22196 }, -- Thick Obsidian Breastplate
			},
		},
		{ -- AQ40Trio
			name = AL["Bug Trio"],
			npcId = {15543, 15544, 15511},
			DisplayIDs = {{15657},{15658},{15656}},
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
			npcId = 15516,
			DisplayIDs = {{15583}},
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
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
			},
		},
		{ -- AQ40Fankriss
			name = AL["Fankriss the Unyielding"],
			npcId = 15510,
			DisplayIDs = {{15743}},
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
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
			},
		},
		{ -- AQ40Viscidus
			name = AL["Viscidus"],
			npcId = 15299,
			DisplayIDs = {{15686}},
			[NORMAL_DIFF] = {
				{ 1,  21624 }, -- Gauntlets of Kalimdor
				{ 2,  21623 }, -- Gauntlets of the Righteous Champion
				{ 3,  21626 }, -- Slime-coated Leggings
				{ 4,  21622 }, -- Sharpened Silithid Femur
				{ 6,  21677 }, -- Ring of the Qiraji Fury
				{ 7,  21625 }, -- Scarab Brooch
				{ 8,  22399 }, -- Idol of Health
				{ 10, 20928 }, -- Qiraji Bindings of Command
				{ 11, 20932 }, -- Qiraji Bindings of Dominance
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
			},
		},
		{ -- AQ40Huhuran
			name = AL["Princess Huhuran"],
			npcId = 15509,
			DisplayIDs = {{15739}},
			[NORMAL_DIFF] = {
				{ 1,  21621 }, -- Cloak of the Golden Hive
				{ 2,  21618 }, -- Hive Defiler Wristguards
				{ 3,  21619 }, -- Gloves of the Messiah
				{ 4,  21617 }, -- Wasphide Gauntlets
				{ 5,  21620 }, -- Ring of the Martyr
				{ 6,  21616 }, -- Huhuran's Stinger
				{ 9,  20928 }, -- Qiraji Bindings of Command
				{ 10, 20932 }, -- Qiraji Bindings of Dominance
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
			},
		},
		{ -- AQ40Emperors
			name = AL["Twin Emperors"],
			npcId = {15275, 15276},
			DisplayIDs = {{15761},{15778}},
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
				{ 11, 21232 }, -- Imperial Qiraji Armaments
				{ 12, 21242 }, -- Blessed Qiraji War Axe
				{ 13, 21244 }, -- Blessed Qiraji Pugio
				{ 14, 21272 }, -- Blessed Qiraji Musket
				{ 15, 21269 }, -- Blessed Qiraji Bulwark
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
				{ 28, 21268 }, -- Blessed Qiraji War Hammer
				{ 29, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 30, 21275 }, -- Blessed Qiraji Augur Staff
			},
		},
		{ -- AQ40Ouro
			name = AL["Ouro"],
			npcId = 15517,
			DisplayIDs = {{15509}},
			[NORMAL_DIFF] = {
				{ 1,  21615 }, -- Don Rigoberto's Lost Hat
				{ 2,  21611 }, -- Burrower Bracers
				{ 3,  23558 }, -- The Burrower's Shell
				{ 4,  23570 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  23557 }, -- Larvae of the Great Worm
				{ 8,  20927 }, -- Ouro's Intact Hide
				{ 9,  20931 }, -- Skin of the Great Sandworm
				{ 16, 21237 }, -- Imperial Qiraji Regalia
				{ 17, 21268 }, -- Blessed Qiraji War Hammer
				{ 18, 21273 }, -- Blessed Qiraji Acolyte Staff
				{ 19, 21275 }, -- Blessed Qiraji Augur Staff
				{ 21, 21232 }, -- Imperial Qiraji Armaments
				{ 22, 21242 }, -- Blessed Qiraji War Axe
				{ 23, 21244 }, -- Blessed Qiraji Pugio
				{ 24, 21272 }, -- Blessed Qiraji Musket
				{ 25, 21269 }, -- Blessed Qiraji Bulwark
			},
		},
		{ -- AQ40CThun
			name = AL["C'Thun"],
			npcId = 15727,
			DisplayIDs = {{15787}},
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
				{ 20, 21712 }, -- Amulet of the Fallen God
				{ 21, 21710 }, -- Cloak of the Fallen God
				{ 22, 21709 }, -- Ring of the Fallen God
				{ 24, 22734 }, -- Base of Atiesh
				{ 25, 22631 }, -- Atiesh, Greatstaff of the Guardian
				{ 26, 22589 }, -- Atiesh, Greatstaff of the Guardian
				{ 27, 22630 }, -- Atiesh, Greatstaff of the Guardian
				{ 28, 22632 }, -- Atiesh, Greatstaff of the Guardian
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

data["Naxxramas"] = {
	MapID = 3456,
	AtlasMapID = "Naxxramas",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcId = 15956,
			DisplayIDs = {{15931}},
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
			npcId = 15953,
			DisplayIDs = {{15940}},
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
			npcId = 15952,
			DisplayIDs = {{15928}},
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
			npcId = 15954,
			DisplayIDs = {{16590}},
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
			npcId = 15936,
			DisplayIDs = {{16309}},
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
			npcId = 16011,
			DisplayIDs = {{16110}},
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
			npcId = 16061,
			DisplayIDs = {{16582}},
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
			npcId = 16060,
			DisplayIDs = {{16279}},
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
			npcId = {16064, 16065, 30549, 16063},
			DisplayIDs = {{16155},{16153},{10729},{16154}},
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
			npcId = 16028,
			DisplayIDs = {{16174}},
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
			npcId = 15931,
			DisplayIDs = {{16035}},
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
			npcId = 15932,
			DisplayIDs = {{16064}},
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
			npcId = 15928,
			DisplayIDs = {{16137}},
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
			npcId = 15989,
			DisplayIDs = {{16033}},
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
			npcId = 15990,
			DisplayIDs = {{15945}},
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
				{ 14, 23207 }, -- Mark of the Champion
				{ 15, 23206 }, -- Mark of the Champion
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
				{ 27, 22631 }, -- Atiesh, Greatstaff of the Guardian
				{ 28, 22589 }, -- Atiesh, Greatstaff of the Guardian
				{ 29, 22630 }, -- Atiesh, Greatstaff of the Guardian
				{ 30, 22632 }, -- Atiesh, Greatstaff of the Guardian
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
	},
}

--[[
data["DireMaul"] = {
	name = C_Map.GetAreaInfo(2557) .." ".. AL["East"],
	MapID = 2557,
	AtlasMapID = "DireMaul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		
		
		DM_BOOKS,
		KEYS,
		ExtraList = true,
	},
}

]]--

--[=[ Shared loot tables
local CLASSIC_INSTANCE_AC_TABLE = {	--[Classic Dungeonmaster]
	name = select(2, GetAchievementInfo(1283)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1283 },
		{ 2, 628 },			{ 17, 629 },
		{ 3, 630 },			{ 18, 631 },
		{ 4, 632 },			{ 19, 633 },
		{ 5, 634 },			{ 20, 635 },
		{ 6, 636 },			{ 21, 637 },
		{ 7, 638 },			{ 22, 639 },
		{ 8, 640 },			{ 23, 641 },
		{ 9, 642 },			{ 24, 643 },
		{ 10, 644 },			{ 25, 645 },
		{ 11, 646 }
	},
}

local CLASSIC_RAID_AC_TABLE = {	--[Classic Raider]
	name = select(2, GetAchievementInfo(1285)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1285 },
		{ 2, 685 },			{ 17, 686 },
		{ 3, 687 },			{ 18, 689 },
	},
}

local BLACKFATHOM_DEEPS_LOOT1 = {
	{ 1, 6908 },	-- Ghamoo-Ra's Bind
	{ 2, 151432 },	-- Twilight Turtleskin Leggings
	{ 3, 6907 },	-- Tortoise Armor
	{ 4, 151433 },	-- Thick Shellplate Shoulders
}
local BLACKFATHOM_DEEPS_LOOT2 = {
	{ 1, 151434 },	-- Foul Shadowsleet Slippers
	{ 2, 888 },		-- Naga Battle Gloves
	{ 3, 132554 },	-- Deadly Serpentine Grips
	{ 4, 151435 },	-- Domina's Deathmaw Greaves
	{ 5, 3078 },	-- Naga Heartpiercer
	{ 6, 11121 },	-- Darkwater Talwar
}
local BLACKFATHOM_DEEPS_LOOT3 = {
	{ 1, 6906 },	-- Algae Fists
	{ 2, 151436 },	-- Murloc Oppressor's Band
	{ 3, 6905 },	-- Reef Axe
}
local BLACKFATHOM_DEEPS_LOOT4 = {
	{ 1, 151437 },	-- Hook Charm Necklace
	{ 2, 120165 },	-- Thruk's Fillet Knife
	{ 3, 120164 },	-- Thruk's Heavy Duty Fishing Pole
	{ 5, 120163 },	-- Thruk's Fishing Rod
}
local BLACKFATHOM_DEEPS_LOOT5 = {
	{ 1, 6901 },	-- Glowing Thresher Cape
	{ 2, 6902 },	-- Bands of Serra'kis
	{ 3, 132555 },	-- Serra'kis Scale Wraps
	{ 4, 6904 },	-- Bite of Serra'kis
}
local BLACKFATHOM_DEEPS_LOOT6 = {
	{ 1, 120167 },	-- Bloody Twilight Cloak
	{ 2, 120166 },	-- Gorestained Garb
}
local BLACKFATHOM_DEEPS_LOOT7 = {
	{ 1, 6903 },	-- Gaze Dreamer Pants
	{ 2, 151438 },	-- Hungering Deepwater Treads
	{ 3, 151439 },	-- Bathiel's Scale Spaulders
	{ 4, 151440 },	-- Blackfathom Ascendant's Helm
	{ 5, 1155 },	-- Rod of the Sleepwalker
}
local BLACKFATHOM_DEEPS_LOOT8 = {
	{ 1, 6910 },	-- Leech Pants
	{ 2, 6911 },	-- Moss Cinch
	{ 3, 132553 },	-- Algae-Twined Waistcord
	{ 4, 151441 },	-- Aku'mai Worshipper's Greatboots
	{ 5, 6909 },	-- Strike of the Hydra
	{ 16, "ac632" },
}
local BLACKFATHOM_DEEPS_LOOT9 = {
	{ 1, 1486 },	-- Tree Bark Jacket
	{ 2, 3416 },	-- Martyr's Chain
	{ 3, 1491 },	-- Ring of Precision
	{ 4, 3413 },	-- Doomspike
	{ 5, 2567 },	-- Evocator's Blade
	{ 6, 3417 },	-- Onyx Claymore
	{ 7, 1454 },	-- Axe of the Enforcer
	{ 8, 1481 },	-- Grimclaw
	{ 9, 3414 },	-- Crested Scepter
	{ 10, 3415 },	-- Staff of the Friar
	{ 11, 2271 },	-- Staff of the Blessed Seer
}
data["BlackfathomDeeps"] = {
	EncounterJournalID = 227,
	MapID = 221,
	AtlasMapID = "BlackfathomDeeps",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Ghamoo-ra
			EncounterJournalID = 368,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT1,
		},
		{	--Domina
			EncounterJournalID = 436,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT2,
		},
		{	--Subjugator Kor'ul
			EncounterJournalID = 426,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT3,
		},
		{	--Throk
			EncounterJournalID = 1145,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT4,
		},
		{	--Guardian of the Deep
			EncounterJournalID = 447,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT5,
		},
		{	--Executioner Gore
			EncounterJournalID = 1144,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT6,
		},
		{	--Twilight Lord Bathiel
			EncounterJournalID = 437,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT7,
		},
		{	--Aku'mai
			EncounterJournalID = 444,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT8,
		},
		{	--Trash Mobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = BLACKFATHOM_DEEPS_LOOT9,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["BlackrockDepths"] = {
	EncounterJournalID = 228,
	MapID = 242,
	AtlasMapID = "BlackrockDepths",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--BRDHighInterrogatorGerstahn
			EncounterJournalID = 369,
			[NORMAL_DIFF] = {
				{ 1, 11626 },	-- Blackveil Cape
				{ 2, 11624 },	-- Kentic Amice
				{ 3, 22240 },	-- Greaves of Withering Despair
				{ 4, 11625 },	-- Enthralled Sphere
			},
		},
		{	--BRDLordRoccor
			EncounterJournalID = 370,
			[NORMAL_DIFF] = {
				{ 1, 22234 },	-- Mantle of Lost Hope
				{ 2, 11632 },	-- Earthslag Shoulders
				{ 3, 11631 },	-- Stoneshell Guard
				{ 16, 45050, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Smoking Heart of the Mountain
			},
		},
		{	--BRDHoundmaster
			EncounterJournalID = 371,
			[NORMAL_DIFF] = {
				{ 1, 11623 },	-- Spritecaster Cape
				{ 2, 11627 },	-- Fleetfoot Greaves
				{ 3, 11628 },	-- Houndmaster's Bow
				{ 4, 11629 },	-- Houndmaster's Rifle
			},
		},
		{	--BRDBaelGar
			EncounterJournalID = 377,
			[NORMAL_DIFF] = {
				{ 1, 11807 },	-- Sash of the Burning Heart
				{ 2, 11802 },	-- Lavacrest Leggings
				{ 3, 11805 },	-- Rubidium Hammer
				{ 4, 11803 },	-- Force of Magma
			},
		},
		{	--BRDLordIncendius
			EncounterJournalID = 374,
			[NORMAL_DIFF] = {
				{ 1, 11766 },	-- Flameweave Cuffs
				{ 2, 11764 },	-- Cinderhide Armsplints
				{ 3, 11765 },	-- Pyremail Wristguards
				{ 4, 11767 },	-- Emberplate Armguards
				{ 16, 19268, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ace of Elementals
			},
		},
		{	--BRDFineousDarkvire
			EncounterJournalID = 376,
			[NORMAL_DIFF] = {
				{ 1, 11839 },	-- Chief Architect's Monocle
				{ 2, 11841 },	-- Senior Designer's Pantaloons
				{ 3, 151406 },	-- Belt of the Eminent Mason
				{ 4, 11842 },	-- Lead Surveyor's Mantle
				{ 5, 22223 },	-- Foreman's Head Protector
				{ 7, 11840, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Master Builder's Shirt
			},
		},
		{	--BRDTheVault
			name = AL["The Vault"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["The Vault"], nil },
				{ 2, 11309, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Heart of the Mountain
				{ 4, "INV_Box_01", nil, AL["The Secret Safe"], nil },
				{ 5, 22256 },	-- Mana Shaping Handwraps
				{ 6, 22205 },	-- Black Steel Bindings
				{ 7, 22255 },	-- Magma Forged Band
				{ 8, 22254 },	-- Wand of Eternal Light
				{ 16, "INV_Box_01", nil, BB["Dark Coffer"], nil },
				{ 17, 11752, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Black Blood of the Tormented
				{ 18, 11751, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Burning Essence
				{ 19, 11753, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Eye of Kajal
			},
		},
		{	--BRDWarderStilgiss
			EncounterJournalID = 375,
			[NORMAL_DIFF] = {
				{ 1, 11782 },	-- Boreal Mantle
				{ 2, 22241 },	-- Dark Warder's Pauldrons
				{ 3, 11783 },	-- Chillsteel Girdle
				{ 4, 151405 },	-- Cold-Forged Chestplate
				{ 5, 11784 },	-- Arbiter's Blade
			},
		},
		{	--BRDVerek
			name = BB["Verek"],
			[NORMAL_DIFF] = {
				{ 1, 22242 },	-- Verek's Leash
				{ 2, 11755 },	-- Verek's Collar
			},
		},
		{	--BRDPyromantLoregrain
			EncounterJournalID = 373,
			[NORMAL_DIFF] = {
				{ 1, 11747 },	-- Flamestrider Robes
				{ 2, 11749 },	-- Searingscale Leggings
				{ 3, 22270 },	-- Entrenching Boots
				{ 4, 11750 },	-- Kindling Stave
				{ 5, 11748 },	-- Pyric Caduceus
				{ 16, 11207, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Fiery Weapon
				{ 18, 63469, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Breath of Cenarius
				{ 19, 64305, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Loregrain's Grimoire
			},
		},
		{	--BRDArena
			EncounterJournalID = 372,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, BB["Anub'shiah"], nil },			--Anub'shiah
				{ 2, 11677 },	-- Graverot Cape
				{ 3, 11675 },	-- Shadefiend Boots
				{ 4, 11731 },	-- Savage Gladiator Greaves
				{ 5, 11678 },	-- Carapace of Anub'shiah
				{ 7, "INV_Box_01", nil, BB["Eviscerator"], nil },			--Eviscerator
				{ 8, 11685 },	-- Splinthide Shoulders
				{ 9, 11686 },	-- Girdle of Beastial Fury
				{ 10, 11730 },	-- Savage Gladiator Grips
				{ 11, 11679 },	-- Rubicund Armguards
				{ 16, "INV_Box_01", nil, BB["Gorosh the Dervish"], nil },	--Gorosh the Dervish
				{ 17, 11726 },	-- Savage Gladiator Chain
				{ 19, 11662 },	-- Ban'thok Sash
				{ 20, 22271 },	-- Leggings of Frenzied Magic
				{ 21, 22257 },	-- Bloodclot Band
				{ 22, 22266 },	-- Flarethorn
				{ 24, "INV_Box_01", nil, BB["Grizzle"], nil },				--Grizzle
				{ 25, 11722 },	-- Dregmetal Spaulders
				{ 26, 11703 },	-- Stonewall Girdle
				{ 27, 11702 },	-- Grizzle's Skinner
				{ 29, 11610, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Dark Iron Pulverizer
				{ 101, "INV_Box_01", nil, BB["Hedrum the Creeper"], nil },	--Hedrum the Creeper
				{ 102, 11634 },	-- Silkweb Gloves
				{ 103, 11729 },	-- Savage Gladiator Helm
				{ 104, 11633 },	-- Spiderfang Carapace
				{ 105, 11635 },	-- Hookfang Shanker
				{ 107, "INV_Box_01", nil, BB["Ok'thor the Breaker"], nil },	--Ok'thor the Breaker
				{ 108, 11665 },	-- Ogreseer Fists
				{ 109, 11728 },	-- Savage Gladiator Leggings
				{ 110, 11824 },	-- Cyclopean Band
			},
		},
		{	--BRDGeneralAngerforge
			EncounterJournalID = 378,
			[NORMAL_DIFF] = {
				{ 1, 11821 },	-- Warstrife Leggings
				{ 2, 11820 },	-- Royal Decorated Armor
				{ 3, 11810 },	-- Force of Will
				{ 4, 11817 },	-- Lord General's Sword
				{ 5, 11816 },	-- Angerforge's Battle Axe
				{ 16, 64302, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- General's Attack Plans
			},
		},
		{	--BRDGolemLordArgelmach
			EncounterJournalID = 379,
			[NORMAL_DIFF] = {
				{ 1, 11822 },	-- Omnicast Boots
				{ 2, 11823 },	-- Luminary Kilt
				{ 3, 11669 },	-- Naglering
				{ 4, 11819 },	-- Second Wind
				{ 16, 21956, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Dark Iron Scorpid
				{ 18, 64303, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Elemental Golem Blueprints
			},
		},
		{	--BRDGuzzler
			name = AL["The Grim Guzzler"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(380), nil },	--Hurley Blackbreath
				{ 2, 11735 },	-- Ragefury Eyepatch
				{ 3, 18043 },	-- Coal Miner Boots
				{ 4, 151407 },	-- Blackened Pit Trousers
				{ 5, 151408 },	-- Dark Iron Dredger's Pauldrons
				{ 6, 18044 },	-- Hurley's Tankard
				{ 8, 11312, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lost Thunderbrew Recipe
				{ 10, "INV_Box_01", nil, EJ_GetEncounterInfo(381), nil },	--Phalanx
				{ 11, 151409 },	-- Ferrous Cord
				{ 12, 22212 },	-- Golem Fitted Pauldrons
				{ 13, 11745 },	-- Fists of Phalanx
				{ 14, 11744 },	-- Bloodfist
				{ 16, "INV_Box_01", nil, BB["Ribbly Screwspigot"], nil },	--Ribbly Screwspigot
				{ 17, 11612, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Dark Iron Plate
				{ 18, 11742 },	-- Wayfarer's Knapsack
				{ 20, "INV_Box_01", nil, EJ_GetEncounterInfo(383), nil },	--Plugger Spazzring
				{ 21, 12793 },	-- Mixologist's Tunic
				{ 22, 151410 },	-- Bottle-Popper Ring
				{ 23, 12791 },	-- Barman Shanker
				{ 25, 13483, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Transmute Fire to Earth
				{ 26, 18653, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Goblin Jumper Cables XL
				{ 27, 15759, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Black Dragonscale Breastplate
				{ 28, 11602, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grim Guzzler Key
				{ 29, 11325, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Dark Iron Ale Mug
			},
		},
		{	--BRDFlamelash
			EncounterJournalID = 384,
			[NORMAL_DIFF] = {
				{ 1, 11808 },	-- Circle of Flame
				{ 3, 11812 },	-- Cape of the Fire Salamander
				{ 4, 11814 },	-- Molten Fists
				{ 5, 11832 },	-- Burst of Knowledge
				{ 6, 11809 },	-- Flame Wrath
			},
		},
		{	--BRDPanzor
			name = BB["Panzor the Invincible"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 22245 },	-- Soot Encrusted Footwear
				{ 2, 11787 },	-- Shalehusk Boots
				{ 3, 11785 },	-- Rock Golem Bulwark
				{ 4, 11786 },	-- Stone of the Earth
			},
		},
		{	--BRDTomb
			EncounterJournalID = 385,
			[NORMAL_DIFF] = {
				{ 1, 11929 },	-- Haunting Specter Leggings
				{ 2, 11925 },	-- Ghostshroud
				{ 3, 11926 },	-- Deathdealer Breastplate
				{ 4, 11927 },	-- Legplates of the Eternal Guardian
				{ 5, 11922 },	-- Blood-Etched Blade
				{ 6, 11920 },	-- Wraith Scythe
				{ 7, 11923 },	-- The Hammer of Grace
				{ 8, 11921 },	-- Impervious Giant
			},
		},
		{	--BRDMagmus
			EncounterJournalID = 386,
			[NORMAL_DIFF] = {
				{ 1, 151411 },	-- Molten-Warder Leggings
				{ 2, 11746 },	-- Golem Skull Helm
				{ 3, 11935 },	-- Magmus Stone
				{ 4, 22208 },	-- Lavastone Hammer
			},
		},
		{	--BRDHighPriestessofThaurissan; formerly PrincessMoira
			name = BB["High Priestess of Thaurissan"],
			[NORMAL_DIFF] = {
				{ 1, 12556 },	-- High Priestess Boots
				{ 2, 12554 },	-- Hands of the Exalted Herald
				{ 3, 12553 },	-- Swiftwalker Boots
				{ 4, 12557 },	-- Ebonsteel Spaulders
			},
		},
		{	--BRDImperatorDagranThaurissan
			EncounterJournalID = 387,
			[NORMAL_DIFF] = {
				{ 1, 11684 },	-- Ironfoe
				{ 3, 11930 },	-- The Emperor's New Cape
				{ 4, 11924 },	-- Robes of the Royal Crown
				{ 5, 22204 },	-- Wristguards of Renown
				{ 6, 22207 },	-- Sash of the Grand Hunt
				{ 8, 11934 },	-- Emperor's Seal
				{ 9, 11933 },	-- Imperial Jewel	
				{ 10, 11815 },	-- Hand of Justice
				{ 16, 11928 },	-- Thaurissan's Royal Scepter
				{ 17, 11932 },	-- Guiding Stave of Wisdom
				{ 18, 11931 },	-- Dreadforge Retaliator
				{ 20, 12033, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Thaurissan Family Jewels
				{ 22, "ac642" },
			},
		},
		{	--BRDTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 12552 },	-- Blisterbane Wrap
				{ 2, 12551 },	-- Stoneshield Cloak
				{ 3, 12542 },	-- Funeral Pyre Vestment
				{ 4, 12546 },	-- Aristocratic Cuffs
				{ 5, 12550 },	-- Runed Golem Shackles
				{ 6, 12547 },	-- Mar Alom's Grip
				{ 7, 12549 },	-- Braincage
				{ 8, 12555 },	-- Battlechaser's Greaves
				{ 9, 12531 },	-- Searing Needle
				{ 10, 12535 },	-- Doomforged Straightedge
				{ 11, 12527 },	-- Ribsplitter
				{ 12, 12528 },	-- The Judge's Gavel
				{ 13, 12532 },	-- Spire of the Stoneshaper
				{ 16, 15781, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Black Dragonscale Leggings
				{ 17, 15770, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Black Dragonscale Shoulders
				{ 18, 16053, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Master Engineer's Goggles
				{ 19, 16049, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Dark Iron Bomb
				{ 20, 16048, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Dark Iron Rifle
				{ 21, 18654, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Gnomish Alarm-o-Bot
				{ 22, 18661, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: World Enlarger
				{ 24, 11754, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Black Diamond
				{ 25, 11078, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Relic Coffer Key
				{ 26, 18945, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Dark Iron Residue
				{ 27, 64304, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Elemental Module
				{ 28, 64313, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Elemental-Imbued Weapon
			},
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		{	--BrewfestCorenDirebrew
			name = BB["Coren Direbrew"].." ("..AL["Brewfest"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:Brewfest:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Deadmines"] = {
	EncounterJournalID = 63,
	MapID = 291,
	AtlasMapID = "TheDeadmines",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--DeadminesGlubtok
			EncounterJournalID = 89,
			[NORMAL_DIFF] = {
				{ 1, 5444 },	-- Miner's Cape
				{ 2, 5195 },	-- Gold-Flecked Gloves
				{ 3, 2169 },	-- Buzzer Blade
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesGearbreaker
			EncounterJournalID = 90,
			[NORMAL_DIFF] = {
				{ 1, 151062 },	-- Armbands of Exiled Architects
				{ 2, 5199 },	-- Smelting Pants
				{ 3, 132556 },	-- Smelter's Britches
				{ 4, 151063 },	-- Gear-Marked Gauntlets
				{ 5, 5443 },	-- Gold-Plated Buckler
				{ 6, 5191 },	-- Cruel Barb
				{ 7, 5200 },	-- Impaling Harpoon	
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesFoeReaper
			EncounterJournalID = 91,
			[NORMAL_DIFF] = {
				{ 1, 151064 },	-- Vest of the Curious Visitor
				{ 2, 151065 },	-- Old Friend's Gloves
				{ 3, 151066 },	-- Missing Diplomat's Pauldrons
				{ 4, 1937 },	-- Buzz Saw
				{ 5, 5201 },	-- Emberstone Staff
				{ 6, 5187 },	-- Foe Reaper
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesRipsnarl
			EncounterJournalID = 92,
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 2, 5196 },	-- Smite's Reaver
				{ 3, 872 },		-- Rockslicer
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesCookie
			EncounterJournalID = 93,
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 5197 },	-- Cookie's Tenderizer
				{ 4, 5192 },	-- Thief's Blade
				{ 5, 5198 },	-- Cookie's Stirring Rod
				{ 16, "ac628" },
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 1930 },	-- Stonemason Cloak
				{ 2, 1926 },	-- Weighted Sap
				{ 3, 1951 },	-- Blackwater Cutlass
				
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local DIREMAULENT_LOOT1 = {
				{ 1, 18306 },	-- Gloves of Shadowy Mist
				{ 2, 18308 },	-- Clever Hat
				{ 3, 18319 },	-- Fervent Helm
				{ 4, 18313 },	-- Helm of Awareness
				{ 5, 18323 },	-- Satyr's Bow
}
local DIREMAULENT_LOOT2 = {
				{ 1, 18307 },	-- Riptide Shoes
				{ 2, 18322 },	-- Waterspout Boots
				{ 3, 18305 },	-- Breakwater Legguards
				{ 4, 18317 },	-- Tempest Talisman
				{ 5, 18324 },	-- Waveslicer
				{ 16, 19268, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ace of Elementals
				{ 18, 18299, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hydrospawn Essence
}
local DIREMAULENT_LOOT3 = {
				{ 1, 18325 },	-- Felhide Cap
				{ 2, 18302 },	-- Band of Vigor
				{ 3, 18311 },	-- Quel'dorei Channeling Rod
				{ 4, 18301 },	-- Lethtendris' Wand
				{ 6, 18426, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lethtendris' Web
				{ 16, "INV_Box_01", nil, BB["Pimgib"], nil },
				{ 17, 18354, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pimgib's Collar
}
local DIREMAULENT_LOOT4 = {
				{ 1, 18267, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Runn Tum Tuber Surprise
				{ 3, 18261, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Book of Incantations
}
local DIREMAULENT_LOOT5 = {
				{ 1, 18328 },	-- Shadewood Cloak
				{ 2, 18327 },	-- Whipvine Cord
				{ 3, 18318 },	-- Merciful Greaves
				{ 4, 18309 },	-- Gloves of Restoration
				{ 5, 18312 },	-- Energized Chestplate
				{ 6, 18326 },	-- Razor Gauntlets
				{ 7, 18314 },	-- Ring of Demonic Guile
				{ 8, 18315 },	-- Ring of Demonic Potency
				{ 9, 18310 },	-- Fiendish Machete
				{ 10, 18321 },	-- Energetic Rod
				{ 12, "INV_Box_01", nil, AL["Felvine Shard"], nil },
				{ 13, 18501, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Felvine Shard
				{ 16, "ac644" },
}
local DIREMAULWEST_LOOT1 = {
				{ 1, 18390 },	-- Tanglemoss Leggings
				{ 2, 18393 },	-- Warpwood Binding
				{ 3, 18352 },	-- Petrified Bark Shield
				{ 4, 18353 },	-- Stoneflower Staff
}
local DIREMAULWEST_LOOT2 = {
				{ 1, 18386 },	-- Padre's Trousers
				{ 2, 18349 },	-- Gauntlets of Accuracy
				{ 3, 18383 },	-- Force Imbued Gauntlets
				{ 4, 18347 },	-- Well Balanced Axe
}
local DIREMAULWEST_LOOT3 = {
				{ 1, 18350 },	-- Amplifying Cloak
				{ 2, 18374 },	-- Flamescarred Shoulders
				{ 3, 18351 },	-- Magically Sealed Bracers
				{ 4, 18397 },	-- Elder Magus Pendant
				{ 5, 18371 },	-- Mindtap Talisman
				{ 7, 22309, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Big Bag of Enchantment
}
local DIREMAULWEST_LOOT4 = {
				{ 1, 18387 },	-- Brightspark Gloves
				{ 2, 18346 },	-- Threadbare Trousers
				{ 3, 18345 },	-- Murmuring Ring
}
local DIREMAULWEST_LOOT5 = {
				{ 1, 18389 },	-- Cloak of the Cosmos
				{ 2, 18385 },	-- Robe of Everlasting Night
				{ 3, 18377 },	-- Quickdraw Gloves
				{ 4, 18391 },	-- Eyestalk Cord
				{ 5, 18394 },	-- Demon Howl Wristguards
				{ 6, 18379 },	-- Odious Greaves
				{ 7, 18384 },	-- Bile-Etched Spaulders
				{ 8, 18381 },	-- Evil Eye Pendant
				{ 9, 18370 },	-- Vigilance Charm
				{ 10, 18372 },	-- Blade of the New Moon
				{ 16, "ac644" },
}
local DIREMAULWEST_LOOT6 = {
				{ 1, 18757 },	-- Diabolic Mantle
				{ 2, 18754 },	-- Fel Hardened Bracers
				{ 3, 18755 },	-- Xorothian Firestick
				{ 4, 18756 },	-- Dreadguard's Protector
}
local DIREMAULWEST_LOOT7 = {
				{ 1, 18382 },	-- Fluctuating Cloak
				{ 2, 18373 },	-- Chestplate of Tranquility
				{ 3, 18375 },	-- Bracers of the Eclipse
				{ 4, 18378 },	-- Silvermoon Leggings
				{ 5, 18380 },	-- Eldritch Reinforced Legplates
				{ 7, 18395 },	-- Emerald Flame Ring
				{ 16, 18388 },	-- Stoneshatter
				{ 17, 18392 },	-- Distracting Dagger
				{ 18, 18376 },	-- Timeworn Mace
				{ 19, 18396 },	-- Mind Carver
}
local DIREMAULNORTH_LOOT1 = {
				{ 1, 18496 },	-- Heliotrope Cloak
				{ 2, 18450 },	-- Robe of Combustion
				{ 3, 18497 },	-- Sublime Wristguards
				{ 4, 18451 },	-- Hyena Hide Belt
				{ 5, 18494 },	-- Denwatcher's Shoulders
				{ 6, 18458 },	-- Modest Armguards
				{ 7, 18493 },	-- Bulky Iron Spaulders
				{ 8, 18459 },	-- Gallant's Wristguards
				{ 16, 18464 },	-- Gordok Nose Ring
				{ 18, 18462 },	-- Jagged Bone Fist
				{ 19, 18460 },	-- Unsophisticated Hand Cannon
				{ 20, 18498 },	-- Hedgecutter
				{ 21, 18463 },	-- Ogre Pocket Knife
}
local DIREMAULNORTH_LOOT2 = {
				{ 1, 18425 },	-- Kreeg's Mug
				{ 3, 18269, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gordok Green Grog
				{ 4, 18284, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Kreeg's Stout Beatdown
				{ 5, 18287, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Evermurky
				{ 6, 18288, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Molasses Firewater
}
local DIREMAULNORTH_LOOT3 = {
				{ 1, 18507 },	-- Boots of the Full Moon
				{ 2, 18505 },	-- Mugger's Belt
				{ 3, 18503 },	-- Kromcrush's Chestplate
				{ 4, 18502 },	-- Monstrous Glaive
}
local DIREMAULNORTH_LOOT4 = {
				{ 1, 18526 },	-- Crown of the Ogre King
				{ 2, 18525 },	-- Bracers of Prosperity
				{ 3, 18527 },	-- Harmonious Gauntlets
				{ 4, 18524 },	-- Leggings of Destruction
				{ 5, 18521 },	-- Grimy Metal Boots
				{ 7, 18522 },	-- Band of the Ogre King
				{ 8, 18523 },	-- Brightly Glowing Stone
				{ 9, 18520 },	-- Barbarous Blade
				{ 11, 19258, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ace of Warlords
				{ 16, "ac644" },
}
local DIREMAULNORTH_LOOT5 = {
				{ 1, 18490 },	-- Insightful Hood
				{ 2, 18485 },	-- Observer's Shield
				{ 3, 18484 },	-- Cho'Rush's Blade
				{ 4, 18483 },	-- Mana Channeling Wand
}
local DIREMAULNORTH_LOOT6 = {
				{ 1, 18538 },	-- Treant's Bane
				{ 3, 18495 },	-- Redoubt Cloak
				{ 4, 18532 },	-- Mindsurge Robe
				{ 5, 18475 },	-- Oddly Magical Belt
				{ 6, 18528 },	-- Cyclone Spaulders
				{ 7, 18478 },	-- Hyena Hide Jerkin
				{ 8, 18477 },	-- Shaggy Leggings
				{ 9, 18476 },	-- Mud Stained Boots
				{ 10, 18479 },	-- Carrion Scorpid Helm
				{ 11, 18530 },	-- Ogre Forged Hauberk
				{ 12, 18480 },	-- Scarab Plate Helm
				{ 13, 18533 },	-- Gordok Bracers of Power
				{ 14, 18529 },	-- Elemental Plate Girdle
				{ 16, 18500 },	-- Tarnished Elven Ring
				{ 17, 18537 },	-- Counterattack Lodestone
				{ 19, 18481 },	-- Skullcracking Mace
				{ 20, 18531 },	-- Unyielding Maul
				{ 21, 18534 },	-- Rod of the Ogre Magi
				{ 22, 18499 },	-- Barrier Shield
				{ 23, 18482 },	-- Ogre Toothpick Shooter
				{ 25, 18655, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Major Recombobulator
}
local DIREMAUL_LOOT1 = {
				{ 1, 9434 },	-- Elemental Raiment
				{ 2, 18295 },	-- Phasing Boots
				{ 3, 18344 },	-- Stonebark Gauntlets
				{ 4, 18298 },	-- Unbridled Leggings
				{ 5, 18296 },	-- Marksman Bands
				{ 6, 18289 },	-- Barbed Thorn Necklace
				{ 7, 18340 },	-- Eidolon Talisman
				{ 8, 18338 },	-- Wand of Arcane Potency
				{ 16, "INV_Box_01", nil, AL["Shen'dralar Provisioner"], nil },
				{ 17, 18487, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Mooncloth Robe
}

data["DireMaul"] = {
	EncounterJournalID = 230,
	MapID = 234,
	AtlasMapID = "DireMaulEnt",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Dire Maul East - Zevrim Thornhoof
			EncounterJournalID = 402,
			[NORMAL_DIFF] = DIREMAULENT_LOOT1,
		},
		{	--Dire Maul East - Hydrospawn
			EncounterJournalID = 403,
			[NORMAL_DIFF] = DIREMAULENT_LOOT2,
		},
		{	--Dire Maul East - Lethtendris Pimgib
			EncounterJournalID = 404,
			[NORMAL_DIFF] = DIREMAULENT_LOOT3,
		},
		{	--Dire Maul East - Pusillin
			name = BB["Pusillin"],
			[NORMAL_DIFF] = DIREMAULENT_LOOT4,
		},
		{	--Dire Maul East - Alzzin the Windshaper
			EncounterJournalID = 405,
			[NORMAL_DIFF] = DIREMAULENT_LOOT5,
		},
		{	--Dire Maul West - Tendris Warpwood
			EncounterJournalID = 406,
			[NORMAL_DIFF] = DIREMAULWEST_LOOT1,
		},
		{	--Dire Maul West - Illyanna Ravenoak
			EncounterJournalID = 407,
			[NORMAL_DIFF] = DIREMAULWEST_LOOT2,
		},
		{	--Dire Maul West - Magister Kalendris
			EncounterJournalID = 408,
			[NORMAL_DIFF] = DIREMAULWEST_LOOT3,
		},
		{	--Dire Maul West - Tsuzee
			name = BB["Tsu'zee"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = DIREMAULWEST_LOOT4,
		},
		{	--Dire Maul West - Immolthar
			EncounterJournalID = 409,
			[NORMAL_DIFF] = DIREMAULWEST_LOOT5,
		},
		{	--Dire Maul West - Lord Helnurath
			name = BB["Lord Hel'nurath"].." ("..AL["Summon"]..")",
			[NORMAL_DIFF] = DIREMAULWEST_LOOT6,
		},
		{	--Dire Maul West - Prince Tortheldrin
			EncounterJournalID = 410,
			[NORMAL_DIFF] = DIREMAULWEST_LOOT7,
		},
		{	--Dire Maul North - Guard Moldar
			EncounterJournalID = 411,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT1,
		},
		{	--Dire Maul North - Stomper Kreeg
			EncounterJournalID = 412,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT2,
		},
		{	--Dire Maul North - Guard Fengus
			EncounterJournalID = 413,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT1,
		},
		{	--Dire Maul North - Guard Slipkik
			EncounterJournalID = 414,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT1,
		},
		{	--Dire Maul North - Captain Kromcrush
			EncounterJournalID = 415,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT3,
		},
		{	--Dire Maul North - King Gordok
			EncounterJournalID = 417,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT4,
		},
		{	--Dire Maul North - Cho'Rush the Observer
			EncounterJournalID = 416,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT5,
		},
		{	--Dire Maul - Trash Mobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = DIREMAUL_LOOT1,
		},
		{	--Dire Maul North - Tribute Chest
			name = AL["Dire Maul North Tribute Chest"],
			ExtraList = true,
			[NORMAL_DIFF] = DIREMAULNORTH_LOOT6,
		},
		CLASSIC_INSTANCE_AC_TABLE,

	}
}

local GNOMEREGAN_LOOT1 = {
	{ 1, 151078 },	-- Shabby Trogg Britches
	{ 2, 151079 },	-- Chomper-Hide Belt
	{ 3, 151080 },	-- Grubbis' Protective Pail
	{ 4, 9445 },	-- Grubbis Paws
}
local GNOMEREGAN_LOOT2 = {
	{ 1, 9454 },	-- Acidic Walkers
	{ 2, 151081 },	-- Gnomish Rebreather
	{ 3, 151082 },	-- Lead Apron
	{ 4, 151083 },	-- Hazmat Galoshes
	{ 5, 9453 },	-- Toxic Revenger
	{ 6, 9452 },	-- Hydrocane
}
local GNOMEREGAN_LOOT3 = {
	{ 1, 9448 },	-- Spidertank Oilrag
	{ 2, 9447 },	-- Electrocutioner Lagnut
	{ 3, 9446 },	-- Electrocutioner Leg
}
local GNOMEREGAN_LOOT4 = {
	{ 1, 151084 },	-- Grease-Smudged Sash
	{ 2, 9450 },	-- Gnomebot Operating Boots
	{ 3, 132558 },	-- Bot Operator's Threads
	{ 4, 151085 },	-- Glitchbot Helm
	{ 5, 9449 },	-- Manual Crowd Pummeler
}
local GNOMEREGAN_LOOT5 = {
	{ 1, 9455 },	-- Emissary Cuffs
	{ 2, 9456 },	-- Glass Shooter
	{ 3, 9457 },	-- Royal Diplomatic Scepter
}
local GNOMEREGAN_LOOT6 = {
	{ 1, 9492 },	-- Electromagnetic Gigaflux Reactivator
	{ 2, 9461 },	-- Charged Gear
	{ 3, 9458 },	-- Thermaplugg's Central Core
	{ 4, 9459 },	-- Thermaplugg's Left Arm
	{ 6, 4415, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Craftsman's Monocle
	{ 8, 11828, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Pet Bombling
	{ 9, 4413, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Discombobulator Ray
	{ 10, 4411, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Flame Deflector
	{ 12, 7742, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Gnomish Cloaking Device
	{ 16, "ac634" },
}
local GNOMEREGAN_LOOT7 = {
	{ 1, 9508 },	-- Mechbuilder's Overalls
	{ 2, 9491 },	-- Hotshot Pilot's Gloves
	{ 3, 9509 },	-- Petrolspill Leggings
	{ 4, 9510 },	-- Caverndeep Trudgers
	{ 5, 9538 },	-- Talvash's Gold Ring
	{ 6, 9487 },	-- Hi-Tech Supergun
	{ 7, 9485 },	-- Vibroblade
	{ 8, 9488 },	-- Oscillating Power Hammer
	{ 9, 9486 },	-- Supercharger Battle Axe
	{ 10, 9490 },	-- Gizmotron Megachopper
	{ 12, 9362 },	-- Brilliant Gold Ring
	{ 16, 11827, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Lil' Smoky
	{ 18, 9327, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Security DELTA Data Access Card
	{ 20, 9326, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grime-Encrusted Ring
}
data["Gnomeregan"] = {
	EncounterJournalID = 231,
	MapID = 54,
	AtlasMapID = "Gnomeregan",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Grubbis
			EncounterJournalID = 419,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Viscous Fallout
			EncounterJournalID = 420,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT2,
		},
		{	--Electrocutioner 6000
			EncounterJournalID = 421,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT3,
		},
		{	--Crowd Pummeler 9-60
			EncounterJournalID = 418,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT4,
		},
		{	--Dark Iron Ambassador
			name = BB["Dark Iron Ambassador"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = GNOMEREGAN_LOOT5,
		},
		{	--Mekgineer Thermaplugg
			EncounterJournalID = 422,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT6,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT7,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["LowerBlackrockSpire"] = {
	EncounterJournalID = 229,
	MapID = 250,
	AtlasMapID = "LowerBlackrockSpire",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--LBRSFelguard
			name = BB["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Summon"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13181 },	-- Demonskin Gloves
				{ 2, 13182 },	-- Phase Blade
			},
		},
		{	--LBRSSpirestoneButcher
			name = BB["Spirestone Butcher"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12608 },	-- Butcher's Apron
				{ 2, 13286 },	-- Rivenspike
			},
		},
		{	--LBRSOmokk
			EncounterJournalID = 388,
			[NORMAL_DIFF] = {
				{ 1, 13170 },	-- Skyshroud Leggings
				{ 2, 13169 },	-- Tressermane Leggings
				{ 3, 151412 },	-- Ogre Highlord's Casque
				{ 4, 13168 },	-- Plate of the Shaman King
				{ 5, 13166 },	-- Slamshot Shoulders
				{ 6, 13167 },	-- Fist of Omokk
				{ 8, 12534, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Omokk's Head
			},
		},
		{	--LBRSSpirestoneLord
			name = BB["Spirestone Battle Lord"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13284 },	-- Swiftdart Battleboots
				{ 2, 13285 },	-- The Blackrock Slicer
			},
		},
		{	--LBRSLordMagus
			name = BB["Spirestone Lord Magus"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13282 },	-- Ogreseer Tower Boots
				{ 2, 13283 },	-- Magus Ring
				{ 3, 13261 },	-- Globe of D'sak
			},
		},
		{	--LBRSVosh
			EncounterJournalID = 389,
			[NORMAL_DIFF] = {
				{ 1, 12626 },	-- Funeral Cuffs
				{ 2, 13257 },	-- Demonic Runed Spaulders
				{ 3, 13255 },	-- Trueaim Gauntlets
				{ 4, 151413 },	-- Smolderthorn Greatbelt
				{ 5, 12653 },	-- Riphook
				{ 6, 12651 },	-- Blackcrow
			},
		},
		{	--LBRSVoone
			EncounterJournalID = 390,
			[NORMAL_DIFF] = {
				{ 1, 22231 },	-- Kayser's Boots of Precision
				{ 2, 13179 },	-- Brazecore Armguards
				{ 3, 13177 },	-- Talisman of Evasion
				{ 4, 12582 },	-- Keris of Zul'Serak
			},
		},
		{	--LBRSGrimaxe
			name = BB["Bannok Grimaxe"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12634 },	-- Chiselbrand Girdle
				{ 2, 12637 },	-- Backusarian Gauntlets
				{ 3, 12621 },	-- Demonfork
				{ 5, 12838, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Arcanite Reaper
			},
		},
		{	--LBRSSmolderweb
			EncounterJournalID = 391,
			[NORMAL_DIFF] = {
				{ 1, 151414 },	-- Arachnophile's Greatcloak
				{ 2, 13244 },	-- Gilded Gauntlets
				{ 3, 13213 },	-- Smolderweb's Eye
				{ 4, 13183 },	-- Venomspitter
				{ 6, 68673, "pet90" },	-- Smolderweb Egg
			},
		},
		{	--LBRSCrystalFang
			name = BB["Crystal Fang"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13185 },	-- Sunderseer Mantle
				{ 2, 13184 },	-- Fallbrush Handgrips
				{ 3, 13218 },	-- Fang of the Crystal Spider
			},
		},
		{	--LBRSDoomhowl
			EncounterJournalID = 392,
			[NORMAL_DIFF] = {
				{ 1, 13258 },	-- Slaghide Gauntlets
				{ 2, 22232 },	-- Marksman's Girdle
				{ 3, 13259 },	-- Ribsteel Footguards
				{ 4, 13178 },	-- Rosewine Circle
			},
		},
		{	--LBRSZigris
			EncounterJournalID = 393,
			[NORMAL_DIFF] = {
				{ 1, 13253 },	-- Hands of Power
				{ 2, 13252 },	-- Cloudrunner Girdle
				{ 3, 151415 },	-- Veteran Spearman's Chain Boots
				{ 4, 151416 },	-- Dark Horde Grunt's Legplates
				{ 6, 12835, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Annihilator
				{ 8, 21955, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Black Diamond Crab
				{ 16, 12264, "pet89" },	-- Worg Carrier
			},
		},
		{	--LBRSSlavener
			EncounterJournalID = 395,
			[NORMAL_DIFF] = {
				{ 1, 13206 },	-- Wolfshear Leggings
				{ 2, 13208 },	-- Bleak Howler Armguards
				{ 3, 151417 },	-- Worg-Keeper's Spaulders
				{ 4, 151418 },	-- Raider Aspirant's Helm
				{ 5, 13205 },	-- Rhombeard Protector
			},
		},
		{	--LBRSHalycon
			EncounterJournalID = 394,
			[NORMAL_DIFF] = {
				{ 1, 22313 },	-- Ironweave Bracers
				{ 2, 13210 },	-- Pads of the Dread Wolf
				{ 3, 13211 },	-- Slashclaw Bracers
				{ 4, 13212 },	-- Halycon's Spiked Collar
			},
		},
		{	--LBRSBashguud
			name = BB["Ghok Bashguud"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13203 },	-- Armswake Cloak
				{ 2, 13198 },	-- Hurd Smasher
				{ 3, 13204 },	-- Bashguuder
			},
		},
		{	--LBRSWyrmthalak
			EncounterJournalID = 396,
			[NORMAL_DIFF] = {
				{ 1, 13143 },	-- Mark of the Dragon Lord
				{ 3, 13162 },	-- Reiver Claws
				{ 4, 22321 },	-- Heart of Wyrmthalak
				{ 5, 13161 },	-- Trindlehaven Staff
				{ 6, 13163 },	-- Relentless Scythe
				{ 16, "ac643" },
			},
		},
		{	--LBRSTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 14513, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Robe of the Archmage
				{ 3, 16250, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Superior Striking
				{ 4, 15749, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Volcanic Breastplate
				{ 5, 15775, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Volcanic Shoulders
				{ 6, 13494, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Greater Fire Protection Potion
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local MARAUDON_LOOT1 = {
	{ 1, 151449 },	-- Fungal-Spore Cinch
	{ 2, 151450 },	-- Chainmail of the Noxious Hollow
	{ 3, 17746 },	-- Noxxion's Shackles
	{ 4, 17744 },	-- Heart of Noxxion
	{ 5, 17745 },	-- Noxious Shooter
}
local MARAUDON_LOOT2 = {
	{ 1, 17748 },	-- Vinerot Sandals
	{ 2, 17750 },	-- Chloromesh Girdle
	{ 3, 17751 },	-- Brusslehide Leggings
	{ 4, 17749 },	-- Phytoskin Spaulders
	{ 5, 132563 },	-- Chloro-Stained Britches
	{ 6, 132562 },	-- Leaf-Scale Pauldrons
	{ 7, 151451 },	-- Strip-Thorn Gauntlets
}
local MARAUDON_LOOT3 = {
	{ 1, 17741 },	-- Nature's Embrace
	{ 2, 17742 },	-- Fungus Shroud Armor
	{ 3, 17767 },	-- Bloomsprout Headpiece
}
local MARAUDON_LOOT4 = {
	{ 1, 17755 },	-- Satyrmane Sash
	{ 2, 151447 },	-- Zaetar-kin Wristwraps
	{ 3, 17754 },	-- Infernal Trickster Leggings
	{ 4, 151448 },	-- Lord Vyletongue's Satyrplate
	{ 5, 17752 },	-- Satyr's Lash
}
local MARAUDON_LOOT5 = {
	{ 1, 151446 },	-- Tinkerer's Pinkie Cylinder
	{ 2, 17717 },	-- Megashot Rifle
	{ 3, 17718 },	-- Gizlock's Hypertech Buckler
	{ 4, 17719 },	-- Inventor's Focal Sword
}
local MARAUDON_LOOT6 = {
	{ 1, 17739 },	-- Grovekeeper's Drape
	{ 2, 17740 },	-- Soothsayer's Headdress
	{ 3, 132561 },	-- Corrupted Keeper's Band
	{ 4, 17738 },	-- Claw of Celebras
}
local MARAUDON_LOOT7 = {
	{ 1, 17736 },	-- Rockgrip Gauntlets
	{ 2, 17734 },	-- Helm of the Mountain
	{ 3, 17737 },	-- Cloud Stone
	{ 4, 17943 },	-- Fist of Stone
}
local MARAUDON_LOOT8 = {
	{ 1, 17732 },	-- Rotgrip Mantle
	{ 2, 17728 },	-- Albino Crocscale Boots
	{ 3, 132564 },	-- Albino Crocscale Waders
	{ 4, 151452 },	-- Crocolisk Wrestler's Waistguard
	{ 5, 17730 },	-- Gatorbite Axe
}
local MARAUDON_LOOT9 = {
	{ 1, 17780 },	-- Blade of Eternal Darkness
	{ 3, 17715 },	-- Eye of Theradras
	{ 4, 17714 },	-- Bracers of the Stone Princess
	{ 5, 17711 },	-- Elemental Rockridge Leggings
	{ 6, 17707 },	-- Gemshard Heart
	{ 7, 17713 },	-- Blackstone Ring
	{ 8, 17710 },	-- Charstone Dirk
	{ 9, 17766 },	-- Princess Theradras' Scepter
	{ 16, "ac640" },
}
data["Maraudon"] = {
	EncounterJournalID = 232,
	MapID = 280,
	AtlasMapID = "Maraudon",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Noxxion
			EncounterJournalID = 423,
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Razorlash
			EncounterJournalID = 424,
			[NORMAL_DIFF] = MARAUDON_LOOT2,
		},
		{	--Meshlok the Harvester
			name = BB["Meshlok the Harvester"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = MARAUDON_LOOT3,
		},
		{	--Lord Vyletongue
			EncounterJournalID = 427,
			[NORMAL_DIFF] = MARAUDON_LOOT4,
		},
		{	--Tinkerer Gizlock
			EncounterJournalID = 425,
			[NORMAL_DIFF] = MARAUDON_LOOT5,
		},
		{	--Celebras the Cursed
			EncounterJournalID = 428,
			[NORMAL_DIFF] = MARAUDON_LOOT6,
		},
		{	--Landslide
			EncounterJournalID = 429,
			[NORMAL_DIFF] = MARAUDON_LOOT7,
		},
		{	--Rotgrip
			EncounterJournalID = 430,
			[NORMAL_DIFF] = MARAUDON_LOOT8,
		},
		{	--Princess Theradras
			EncounterJournalID =431,
			[NORMAL_DIFF] = MARAUDON_LOOT9,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAGEFIRE_CHASM_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(694), nil },	--Adarogg
	{ 2, 82772 },	-- Snarlmouth Leggings
	{ 3, 151421 },	-- Scorched Blazehound Boots
	{ 4, 151422 },	-- Bonecoal Waistguard
	{ 5, 82879 },	-- Collarspike Bracers
	{ 6, 82880 },	-- Fang of Adarogg
	{ 8, "INV_Box_01", nil, EJ_GetEncounterInfo(695), nil },	--Dark Shaman Koranthal
	{ 9, 82882 },	-- Dark Ritual Cape
	{ 10, 82881 },	-- Cuffs of Black Elements
	{ 11, 82877 },	-- Grasp of the Broken Totem
	{ 12, 132551 }, -- Dark Shaman's Jerkin
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(696), nil },	--Slagmaw
	{ 17, 82878 },	-- Fireworm Robes
	{ 18, 82884 },	-- Chitonous Bracers
	{ 19, 132552 },	-- Chitonous Bindings
	{ 20, 82885 },	-- Flameseared Carapace
	{ 22, "INV_Box_01", nil, EJ_GetEncounterInfo(697), nil },	--Lava Guard Gordoth
	{ 23, 82886 },	-- Gorewalker Treads
	{ 24, 82883 },	-- Bloodcursed Felblade
	{ 25, 82888 },	-- Heartboiler Staff
	{ 27, "ac629" },
}
data["RagefireChasm"] = {
	EncounterJournalID = 226,
	MapID = 213,
	AtlasMapID = "RagefireChasm",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Adarogg
			EncounterJournalID = 694,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Dark Shaman Koranthal
			EncounterJournalID = 695,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Slagmaw
			EncounterJournalID = 696,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Lava Guard Gordoth
			EncounterJournalID = 697,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAZORFEN_DOWNS_LOOT1 = {
	{ 1, 10776 },	-- Silky Spider Cape
	{ 2, 10777 },	-- Arachnid Gloves
	{ 3, 10775 },	-- Carapace of Tuten'kash
}
local RAZORFEN_DOWNS_LOOT2 = {
	{ 1, 10771 },	-- Deathmage Sash
	{ 2, 10769 },	-- Glowing Eye of Mordresh
	{ 3, 10770 },	-- Mordresh's Lifeless Skull
}
local RAZORFEN_DOWNS_LOOT3 = {
	{ 1, 10774 },	-- Fleshhide Shoulders
	{ 2, 151453 },	-- Grungy Necromantic Ring
	{ 3, 10772 },	-- Glutton's Cleaver
}
local RAZORFEN_DOWNS_LOOT4 = {
	{ 1, 10760 },	-- Swine Fists
	{ 2, 10768 },	-- Boar Champion's Belt
	{ 3, 151454 },	-- Splinterbone Sabatons
	{ 4, 10767 },	-- Savage Boar's Guard
	{ 5, 10758 },	-- X'caliboar
	{ 6, 10766 },	-- Plaguerot Sprig
}
local RAZORFEN_DOWNS_LOOT5 = {
	{ 1, 10762 },	-- Robes of the Lich
	{ 2, 10765 },	-- Bonefingers
	{ 3, 10764 },	-- Deathchill Armor
	{ 4, 10763 },	-- Icemetal Barbute
	{ 5, 10761 },	-- Coldrage Dagger
	{ 16, "ac636" },
}
local RAZORFEN_DOWNS_LOOT6 = {
	{ 1, 10581 },	-- Death's Head Vestment
	{ 2, 10578 },	-- Thoughtcast Boots
	{ 3, 10574 },	-- Corpseshroud
	{ 4, 10583 },	-- Quillward Harness
	{ 5, 10582 },	-- Briar Tredders
	{ 6, 10584 },	-- Stormgale Fists
	{ 7, 10567 },	-- Quillshooter
	{ 8, 10571 },	-- Ebony Boneclub
	{ 9, 10573 },	-- Boneslasher
	{ 10, 10570 },	-- Manslayer
	{ 11, 10572 },	-- Freezing Shard
}
data["RazorfenDowns"] = {
	EncounterJournalID = 233,
	MapID = 300,
	AtlasMapID = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Aarux
			EncounterJournalID = 1142,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Mordresh Fire Eye
			EncounterJournalID = 433,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT2,
		},
		{	--Mushlump
			EncounterJournalID = 1143,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT3,
		},
		{	--Death Speaker Blackthorn
			EncounterJournalID = 1146,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT4,
		},
		{	--Amnennar the Coldbringer
			EncounterJournalID = 1141,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT5,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT6,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAZORFEN_KRAUL_LOOT1 = {
	{ 1, 6688 },	-- Whisperwind Headdress
	{ 2, 6689 },	-- Wind Spirit Staff
}
local RAZORFEN_KRAUL_LOOT2 = {
	{ 1, 151442 },	-- Bonetusk Greatcloak
	{ 2, 6681 },	-- Thornspike
}
local RAZORFEN_KRAUL_LOOT3 = {
	{ 1, 6690 },	-- Ferine Leggings
	{ 2, 132565 },	-- Carnal Britches
	{ 3, 151443 },	-- Roogug's Swinsteel Girdle
	{ 4, 6691 },	-- Swinetusk Shank
}
local RAZORFEN_KRAUL_LOOT4 = {
	{ 1, 6686 },	-- Tusken Helm
	{ 2, 151445 },	-- Porcine-Warlord's Legplates
	{ 3, 6687 },	-- Corpsemaker
}
local RAZORFEN_KRAUL_LOOT5 = {
	{ 1, 6697 },	-- Batwing Mantle
	{ 2, 6695 },	-- Stygian Bone Amulet
	{ 3, 6696 },	-- Nightstalker Bow
}
local RAZORFEN_KRAUL_LOOT6 = {
	{ 1, "INV_Box_01", nil, "Enormous Bullfrog (Rare)", nil },	--Enormous Bullfrog
	{ 2, 13108 },	-- Tigerstrike Mantle
	{ 3, 9395 },	-- Gloves of Old
	{ 4, 2721 },	-- Holy Shroud
	{ 5, 2277 },	-- Necromancer Leggings
	{ 6, 13106 },	-- Glowing Magical Bracers
	{ 7, 3020 },	-- Enduring Cap
	{ 8, 2278 },	-- Forest Tracker Epaulets
	{ 9, 13124 },	-- Ravasaur Scale Boots
	{ 10, 13127 },	-- Frostreaver Boots
	{ 11, 9405 },	-- Girdle of Golem Strength
	{ 13, 13084 },	-- Kaleidoscope Chain
	{ 14, 13087 },	-- River Pride Choker
	{ 16, 13019 },	-- Harpyclaw Short Bow
	{ 17, 13037 },	-- Crystalpine Stinger
	{ 18, 2912 },	-- Claw of the Shadowmancer
	{ 19, 2565 },	-- Rod of Molten Fire
	{ 20, 13137 },	-- Ironweaver
	{ 21, 13048 },	-- Looming Gavel
	{ 22, 12974 },	-- The Black Knight
	{ 23, 13033 },	-- Zealot Blade
	{ 24, 791 },	-- Gnarled Ash Staff
	{ 25, 2299 },	-- Burning War Axe
	{ 26, 13045 },	-- Viscous Hammer
	{ 27, 2877 },	-- Combatant Claymore
	{ 28, 13063 },	-- Starfaller
}
local RAZORFEN_KRAUL_LOOT7 = {
	{ 1, 6693 },	-- Agamaggan's Clutch
	{ 2, 6694 },	-- Heart of Agamaggan
	{ 3, 6692 },	-- Pronged Reaver
	{ 5, 5793, [ATLASLOOT_IT_FILTERIGNORE] = true },			-- Razorflank's Heart
	{ 16, "ac635" },
}
local RAZORFEN_KRAUL_LOOT8 = {
	{ 1, 2264 },	-- Mantle of Thieves
	{ 2, 1978 },	-- Wolfclaw Gloves
	{ 3, 1488 },	-- Avenger's Armor
	{ 4, 4438 },	-- Pugilist Bracers
	{ 5, 2039 },	-- Plains Ring
	{ 6, 776 },	-- Vendetta
	{ 7, 1727 },	-- Sword of Decay
	{ 8, 2549 },	-- Staff of the Shade
	{ 9, 1976 },	-- Slaghammer
	{ 10, 1975 },	-- Pysan's Old Greatsword
}
data["RazorfenKraul"] = {
	EncounterJournalID = 234,
	MapID = 301,
	AtlasMapID = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Kraulshaper Tukaar
			name = "Kraulshaper Tukaar",
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Hunter Bonetusk
			EncounterJournalID = 896,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT2,
		},
		{	--Roogug
			EncounterJournalID = 895,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT3,
		},
		{	--Warlord Ramtusk
			EncounterJournalID = 899,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT4,
		},
		{	--Groyat, the Blind Hunter
			EncounterJournalID = 900,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT5,
		},
		{	--Enormous Bullfrog
			name = "Enormous Bullfrog (Rare)",
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT6,
		},
		{	--Charlga Razorflank
			EncounterJournalID = 901,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT7,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT8,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ScarletHalls"] = {
	EncounterJournalID = 311,
	MapID = 431,
	AtlasMapID = "ScarletHalls",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--SHBraun
			EncounterJournalID = 660,
			[NORMAL_DIFF] = {
				{ 1, 88266 },	-- Hound Trainer's Gloves
				{ 2, 88268 },	-- Canine Commander's Breastplate
				{ 3, 88267 },	-- Commanding Bracers
				{ 4, 88265 },	-- Beastbinder Ring
				{ 5, 88264 },	-- Houndmaster's Compound Crossbow
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SHHarlan
			EncounterJournalID = 654,
			[NORMAL_DIFF] = {
				{ 1, 88269 },	-- Scarlet Sandals
				{ 2, 88270 },	-- Lightblade Bracer
				{ 3, 132550 },	-- Scarlet Chain Footpads
				{ 4, 88271 },	-- Harlan's Shoulders
				{ 5, 88273 },	-- Armsmaster's Sealed Locket
				{ 6, 88272 },	-- The Gleaming Ravager
				{ 8, 23192, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tabard of the Scarlet Crusade
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SHKoegler
			EncounterJournalID = 656,
			[NORMAL_DIFF] = {
				{ 1, 88279 },	-- Robes of Koegler
				{ 2, 88282 },	-- Vellum-Ripper Gloves
				{ 3, 88283 },	-- Bradbury's Entropic Legguards
				{ 4, 88276 },	-- Bindburner Belt
				{ 5, 88277 },	-- Pyretic Legguards
				{ 6, 88275 },	-- Scorched Scarlet Key
				{ 7, 88281 },	-- Temperature-Sensing Necklace
				{ 8, 88274 },	-- Koegler's Ritual Knife
				{ 9, 88280 },	-- Melted Hypnotic Blade
				{ 10, 88278 },	-- Mograine's Immaculate Might
				{ 12, 87267, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Codex of the Crusade
				{ 16, "ac7413" },	
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
	}
}

data["ScarletMonastery"] = {
	EncounterJournalID = 316,
	MapID = 435,
	AtlasMapID = "ScarletMonastery",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--SMThalnos
			EncounterJournalID = 688,
			[NORMAL_DIFF] = {
				{ 1, 88288 },	-- Soulrender Greatcloak
				{ 2, 88284 },	-- Forgotten Bloodmage Mantle
				{ 3, 88286 },	-- Legguards of the Crimson Magus
				{ 4, 88287 },	-- Bracers of the Fallen Crusader
				{ 5, 88285 },	-- Signet of the Hidden Door
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SMKorloff
			EncounterJournalID = 671,
			[NORMAL_DIFF] = {
				{ 1, 88290 },	-- Scorched Earth Cloak
				{ 2, 88291 },	-- Korloff's Raiment
				{ 3, 88292 },	-- Helm of Rising Flame
				{ 4, 88293 },	-- Firefinger Ring
				{ 5, 88289 },	-- Firestorm Greatstaff
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SMWhitemane
			EncounterJournalID = 674,
			[NORMAL_DIFF] = {
				{ 1, 88299 },	-- Whitemane's Embroidered Chapeau
				{ 2, 88298 },	-- Leggings of Hallowed Fire
				{ 3, 88295 },	-- Dashing Strike Treads
				{ 4, 88302 },	-- Incarnadine Scarlet Spaulders
				{ 5, 132549 },	-- Deft Strike Treads
				{ 6, 88303 },	-- Crown of Holy Flame
				{ 7, 88296 },	-- Waistplate of Imminent Resurrection
				{ 8, 88300 },	-- Triune Signet
				{ 9, 88294 },	-- Flashing Steel Talisman
				{ 10, 88301 },	-- Greatstaff of Righteousness
				{ 11, 88297 },	-- Lightbreaker Greatsword
				{ 16, "ac637" },
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--HallowsEndHeadlessHorseman
			name = BB["Headless Horseman"].." ("..AL["Hallow's End"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:HallowsEnd:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Scholomance"] = {
	EncounterJournalID = 246,
	MapID = 476,
	AtlasMapID = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--ScholoChillheart
			EncounterJournalID = 659,
			[NORMAL_DIFF] = {
				{ 1, 88336 },	-- Icewrath Belt
				{ 2, 88337 },	-- Shadow Puppet Bracers
				{ 3, 88338 },	-- Breastplate of Wracking Souls
				{ 4, 88335 },	-- Anarchist's Pendant
				{ 5, 88339 },	-- Gravetouch Greatsword
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoJandice
			EncounterJournalID = 663,
			[NORMAL_DIFF] = {
				{ 1, 88349 },	-- Phantasmal Drape
				{ 2, 88345 },	-- Barovian Ritual Hood
				{ 3, 88347 },	-- Ghostwoven Legguards
				{ 4, 88348 },	-- Wraithplate Treads
				{ 5, 88346 },	-- Metanoia Shield
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoRattlegore
			EncounterJournalID = 665,
			[NORMAL_DIFF] = {
				{ 1, 88340 },	-- Deadwalker Bracers
				{ 2, 88342 },	-- Rattling Gloves
				{ 3, 88343 },	-- Bone Golem Boots
				{ 4, 88357 },	-- Vigorsteel Spaulders
				{ 5, 88344 },	-- Goresoaked Headreaper
				{ 6, 88341 },	-- Necromantic Wand
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoVoss
			EncounterJournalID = 666,
			[NORMAL_DIFF] = {
				{ 1, 88350 },	-- Leggings of Unleashed Anguish
				{ 2, 88351 },	-- Soulburner Crown
				{ 3, 88352 },	-- Shivbreaker Vest
				{ 4, 88353 },	-- Dark Blaze Gauntlets
				{ 5, 88354 },	-- Necklace of the Dark Blaze
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoGandling
			EncounterJournalID = 684,
			[NORMAL_DIFF] = {
				{ 1, 88359 },	-- Incineration Belt
				{ 2, 88356 },	-- Tombstone Gauntlets
				{ 3, 88361 },	-- Gloves of Explosive Pain
				{ 4, 88362 },	-- Shoulderguards of Painful Lessons
				{ 5, 88357 },	-- Vigorsteel Spaulders
				{ 6, 88358 },	-- Lessons of the Darkmaster
				{ 7, 88360 },	-- Price of Progress
				{ 8, 88355 },	-- Searing Words
				{ 16, "ac645" },
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ShadowfangKeep"] = {
	EncounterJournalID = 64,
	MapID = 310,
	AtlasMapID = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--ShadowfangDeathswornCaptain
			name = BB["Deathsworn Captain"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 6642 },    -- Phantom Armor
				{ 2, 6641 },    -- Haunting Blade
			},
		},
		{	--ShadowfangAshbury
			EncounterJournalID = 96,
			[NORMAL_DIFF] = {
				{ 1, 6314 },	-- Wolfmaster Cape
				{ 2, 6324 },	-- Robes of Arugal
				{ 3, 6323 },	-- Baron's Scepter
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangSilverlaine
			EncounterJournalID = 97,
			[NORMAL_DIFF] = {
				{ 1, 5254 }, -- Rugged Spaulders
				{ 2, 6319 }, -- Girdle of the Blindwatcher
				{ 3, 132568 }, -- Shadowfang Pauldrons
				{ 4, 132567 }, -- Blindwatcher's Chain
				{ 5, 5943 }, -- Rift Bracers
				{ 6, 6321 }, -- Silverlaine's Family Seal
				{ 8, 60885, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Silverlaine Family Sword
				{ 9, 60878, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Silverlaine's Enchanted Crystal
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangSpringvale
			EncounterJournalID = 98,
			[NORMAL_DIFF] = {
				{ 1, 151067 },	-- Boots of Lingering Sorrow
				{ 2, 151068 },	-- Boots of the Predator
				{ 3, 151069 },	-- Breastplate of the Stilled Heart
				{ 4, 151070 },	-- Gloves of the Greymane Wall
				{ 5, 6320 },	-- Commander's Crest
				{ 6, 3191 },	-- Arced War Axe
				{ 8, 60879, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Commander's Holy Symbol
				{ 9, 60880, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Springvale's Sharpening Stone
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangWalden
			EncounterJournalID = 99,
			[NORMAL_DIFF] = {
				{ 1, 3230 },	-- Black Wolf Bracers
				{ 2, 132566 },	-- Dark Lupine Wraps
				{ 3, 6642 },	-- Phantom Armor
				{ 4, 6341 },	-- Eerie Stable Lantern
				{ 5, 1292 },	-- Butcher's Cleaver
				{ 7, 60876, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Walden's Elixirs
				{ 8, 60881, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Walden's Talisman
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangGodfrey
			EncounterJournalID = 100,
			[NORMAL_DIFF] = {
				{ 1, 3748 },	-- Feline Mantle
				{ 2, 151071 },	-- Gloves of the Uplifted Cup
				{ 3, 151072 },	-- Worgen Hunter's Helm
				{ 4, 151073 },	-- Greaves of the Misguided
				{ 5, 6220 },	-- Meteor Shard
				{ 6, 6318 },	-- Odo's Ley Staff
				{ 7, 6641 },	-- Haunting Blade
				{ 9, 60877, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Godfrey's Crystal Scope
				{ 10, 60882, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tenebrous Orb
				{ 12, "ac631" },
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 1974 },	-- Mindthrust Bracers
				{ 2, 2807 },	-- Guillotine Axe
				{ 3, 1484 },	-- Witching Stave
				{ 4, 1483 },	-- Face Smasher
				{ 5, 1318 },	-- Night Reaver
				{ 6, 3194 },	-- Black Malice
				{ 16, 60977 },	-- Orders from High Command
				{ 17, 60874 },	-- Deathless Sinew
				{ 18, 60875 },	-- Ghostly Essence
			},
		},
		{	--LoveisintheAirTrio
			name = BB["Apothecary Hummel"].." ("..AL["Love is in the Air"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:LoveisintheAir:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Stratholme"] = {
	EncounterJournalID = 236,
	MapID = 317,
	AtlasMapID = "StratholmeCrusader",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--STRATSkull
			name = BB["Skul"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13395 },	-- Skul's Fingerbone Claws
				{ 2, 13394 },	-- Skul's Cold Embrace
				{ 3, 13396 },	-- Skul's Ghastly Touch
			},
		},
		{	--STRATTheUnforgiven
			EncounterJournalID = 450,
			[NORMAL_DIFF] = {
				{ 1, 13409 },	-- Tearfall Bracers
				{ 2, 13404 },	-- Mask of the Unforgiven
				{ 3, 151404 },	-- Gauntlets of Purged Sanity
				{ 4, 13405 },	-- Wailing Nightbane Pauldrons
				{ 5, 13408 },	-- Soul Breaker
				{ 6, 22406 },	-- Redemption
			},
		},
		{	--STRATHearthsingerForresten
			name = BB["Hearthsinger Forresten"].." ("..AL["Rare"]..")",
			EncounterJournalID = 443,
			[NORMAL_DIFF] = {
				{ 1, 13378 },	-- Songbird Blouse
				{ 2, 13383 },	-- Woollies of the Prancing Minstrel
				{ 3, 13384 },	-- Rainbow Girdle
				{ 5, 13379 },	-- Piccolo of the Flaming Fire
			},
		},
		{	--STRATPostmasterMalown
			name = BB["Postmaster Malown"],
			[NORMAL_DIFF] = {
				{ 1, 13391 },	-- The Postmaster's Treads
				{ 2, 13390 },	-- The Postmaster's Band
				{ 3, 13388 },	-- The Postmaster's Tunic
				{ 4, 13389 },	-- The Postmaster's Trousers
				{ 5, 13392 },	-- The Postmaster's Seal
				{ 6, 13393 },	-- Malown's Slam
			},
		},			
		{	--STRATTimmytheCruel
			EncounterJournalID = 445,
			[NORMAL_DIFF] = {
				{ 1, 13403 },	-- Grimgore Noose
				{ 2, 151403 },	-- Fetid Stranglers
				{ 3, 13402 },	-- Timmy's Galoshes
				{ 4, 13400 },	-- Vambraces of the Sadist
				{ 5, 13401 },	-- The Cruel Hand of Timmy
			},
		},
		{	--STRATCommanderMalor
			name = BB["Commander Malor"],
			[NORMAL_DIFF] = {
				{ 1, 22403 },	-- Diana's Pearl Necklace
			},
		},	
		{	--STRATWilleyHopebreaker
			EncounterJournalID = 446,
			[NORMAL_DIFF] = {
				{ 1, 22405 },	-- Mantle of the Scarlet Crusade
				{ 2, 22407 },	-- Helm of the New Moon
				{ 3, 18721 },	-- Barrage Girdle
				{ 4, 13381 },	-- Master Cannoneer Boots
				{ 5, 22403 },	-- Diana's Pearl Necklace
				{ 6, 13382 },	-- Cannonball Runner
				{ 7, 22404 },	-- Willey's Back Scratcher
				{ 8, 13380 },	-- Willey's Portable Howitzer
				{ 9, 22406 },	-- Redemption
				{ 16, 12839, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Heartseeker
			},
		},
		{	--STRATInstructorGalford
			EncounterJournalID = 448,
			[NORMAL_DIFF] = {
				{ 1, 13386 },	-- Archivist Cape
				{ 2, 18716 },	-- Ash Covered Boots
				{ 3, 13387 },	-- Foresight Girdle
				{ 4, 13385 },	-- Tome of Knowledge
				{ 6, 12811, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Righteous Orb
				{ 16, "INV_Box_01", nil, AL["Unfinished Painting"], nil },
				{ 17, 14679, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Of Love and Family
			},
		},
		{	--STRATBalnazzar
			EncounterJournalID = 449,
			[NORMAL_DIFF] = {
				{ 1, 13353 },	-- Book of the Dead
				{ 2, 14512, [ATLASLOOT_IT_FILTERIGNORE] = true  },	-- Pattern: Truefaith Vestments
				{ 4, 13369 },	-- Fire Striders
				{ 5, 18720 },	-- Shroud of the Nathrezim
				{ 6, 13358 },	-- Wyrmtongue Shoulders
				{ 7, 13359 },	-- Crown of Tyranny
				{ 8, 18718 },	-- Grand Crusader's Helm
				{ 9, 12103 },	-- Star of Mystaria
				{ 10, 13360 },	-- Gift of the Elven Magi
				{ 11, 18717 },	-- Hammer of the Grand Crusader
				{ 12, 13348 },	-- Demonshear
				{ 16, 13520, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Flask of Distilled Wisdom
				{ 18, "ac646" },
			},
		},
		{	--STRATStonespine
			name = BB["Stonespine"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13397 },	-- Stoneskin Gargoyle Cape
				{ 2, 13954 },	-- Verdant Footpads
				{ 3, 13399 },	-- Gargoyle Shredder Talons
			},
		},
		{	--STRATBaronessAnastari
			EncounterJournalID = 451,
			[NORMAL_DIFF] = {
				{ 1, 13535 },	-- Coldtouch Phantom Wraps
				{ 2, 18730 },	-- Shadowy Laced Handwraps
				{ 3, 13537 },	-- Chillhide Bracers
				{ 4, 13538 },	-- Windshrieker Pauldrons
				{ 5, 13539 },	-- Banshee's Touch
				{ 6, 18728 },	-- Anastari Heirloom
				{ 7, 18729 },	-- Screeching Bow
				{ 8, 13534 },	-- Banshee Finger
				{ 10, 13514, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Wail of the Banshee
			},
		},
		{	--STRATNerubenkan
			EncounterJournalID = 452,
			[NORMAL_DIFF] = {
				{ 1, 13530 },	-- Fangdrip Runners
				{ 2, 18740 },	-- Thuzadin Sash
				{ 3, 13531 },	-- Crypt Stalker Leggings
				{ 4, 13532 },	-- Darkspinner Claws
				{ 5, 18739 },	-- Chitinous Plate Legguards
				{ 6, 13533 },	-- Acid-Etched Pauldrons
				{ 7, 18738 },	-- Carapace Spine Crossbow
				{ 8, 13529 },	-- Husk of Nerub'enkan
				{ 10, 13508, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Eye of Arachnida
			},
		},
		{	--STRATMalekithePallid
			EncounterJournalID = 453,
			[NORMAL_DIFF] = {
				{ 1, 18734 },	-- Pale Moon Cloak
				{ 2, 18735 },	-- Maleki's Footwraps
				{ 3, 13525 },	-- Darkbind Fingers
				{ 4, 13526 },	-- Flamescarred Girdle
				{ 5, 13528 },	-- Twilight Void Bracers
				{ 6, 13527 },	-- Lavawalker Greaves
				{ 7, 13524 },	-- Skull of Burning Shadows
				{ 8, 18737 },	-- Bone Slicing Hatchet
				{ 10, 13509, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Clutch of Foresight
				{ 16, 12833, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Hammer of the Titans
			},
		},
		{	--STRATMagistrateBarthilas
			EncounterJournalID = 454,
			[NORMAL_DIFF] = {
				{ 1, 13376 },	-- Royal Tribunal Cloak
				{ 2, 18727 },	-- Crimson Felt Hat
				{ 3, 18726 },	-- Magistrate's Cuffs
				{ 4, 18722 },	-- Death Grips
				{ 5, 18725 },	-- Peacemaker
			},
		},
		{	--STRATRamsteintheGorger
			EncounterJournalID = 455,
			[NORMAL_DIFF] = {
				{ 1, 13374 },	-- Soulstealer Mantle
				{ 2, 13373 },	-- Band of Flesh
				{ 3, 18723 },	-- Animated Chain Necklace
				{ 4, 13515 },	-- Ramstein's Lightning Bolts
				{ 5, 13375 },	-- Crest of Retribution
				{ 6, 13372 },	-- Slavedriver's Cane
			},
		},
		{	--STRATLordAuriusRivendare
			EncounterJournalID = 456,
			[NORMAL_DIFF] = {
				{ 1, 13505 },	-- Runeblade of Baron Rivendare
				{ 2, 13335, "mount" },	-- Deathcharger's Reins
				{ 4, 13340 },	-- Cape of the Black Baron
				{ 5, 13346 },	-- Robes of the Exalted
				{ 6, 22412 },	-- Thuzadin Mantle
				{ 7, 22409 },	-- Tunic of the Crescent Moon
				{ 8, 13344 },	-- Dracorian Gauntlets
				{ 9, 22410 },	-- Gauntlets of Deftness
				{ 10, 22411 },	-- Helm of the Executioner
				{ 11, 13345 },	-- Seal of Rivendare
				{ 12, 13368 },	-- Bonescraper
				{ 13, 13349 },	-- Scepter of the Unholy
				{ 14, 13361 },	-- Skullforge Reaver
				{ 15, 22408 },	-- Ritssyn's Wand of Bad Mojo
				{ 16, "ac646" },
			},
		},
		{	--STRATTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18743 },	-- Gracious Cape
				{ 2, 17061 },	-- Juno's Shadow
				{ 3, 18745 },	-- Sacred Cloth Leggings
				{ 4, 18744 },	-- Plaguebat Fur Gloves
				{ 5, 18736 },	-- Plaguehound Leggings
				{ 6, 18742 },	-- Stratholme Militia Shoulderguard
				{ 7, 13071 },	-- Plated Fist of Hakoo
				{ 8, 18741 },	-- Morlune's Bracer
				{ 10, 12811 },	-- Righteous Orb
				{ 16, 16249, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant 2H Weapon - Major Intellect
				{ 17, 16248, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Unholy
				{ 18, 18658, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Ultra-Flash Shadow Reflector
				{ 19, 16052, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Voice Amplification Modulator
				{ 20, 15777, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Runic Leather Shoulders
				{ 21, 15768, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Wicked Leather Belt
				{ 23, "INV_Box_01", nil, BB["Fras Siabi"], nil },
				{ 24, 13172 },	-- Siabi's Premium Tobacco
			},
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local STOCKADE_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(464), nil },	--Hogger
	{ 2, 2168 },	-- Corpse Rompers
	{ 3, 1934 },	-- Hogger's Trousers
	{ 4, 132569 },	-- Stolen Jailer's Greaves
	{ 5, 151074 },	-- Turnkey's Pauldons
	{ 6, 1959 },	-- Cold Iron Pick
	{ 8, "INV_Box_01", nil, EJ_GetEncounterInfo(465), nil },	--Lord Overheat
	{ 9, 1929 },	-- Silk-Threaded Trousers
	{ 10, 5967 },	-- Girdle of Nobility
	{ 11, 151075 },	-- Cinderstitch Tunic
	{ 12, 151076 },	-- Fire-Hardened Shackles
	{ 13, 4676 },	-- Skeletal Gauntlets
	{ 15, 62305, [ATLASLOOT_IT_FILTERIGNORE] = true },			--Lord Overheat's Fiery Core
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(466), nil },	--Randolph Moloch
	{ 17, 63345 },	-- Noble's Robe
	{ 18, 63344 },	-- Standard Issue Prisoner Shoes
	{ 19, 132570 },	-- Stolen Guards Chain Boots
	{ 20, 151077 },	-- Cast Iron Waistplate
	{ 21, 63346 },	-- Wicked Dagger
	{ 23, "ac633" },
}
data["TheStockade"] = {
	EncounterJournalID = 238,
	MapID = 225,
	AtlasMapID = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Hogger
			EncounterJournalID = 464,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		{	--Lord Overheat
			EncounterJournalID = 465,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		{	--Randolph Moloch
			EncounterJournalID = 466,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["TheSunkenTemple"] = {
	EncounterJournalID = 237,
	MapID = 220,
	AtlasMapID = "TheSunkenTemple",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--STAvatarofHakkar
			EncounterJournalID = 457,
			[NORMAL_DIFF] = {
				{ 1, 12462 },	-- Embrace of the Wind Serpent
				{ 3, 10843 },	-- Featherskin Cape
				{ 4, 10842 },	-- Windscale Sarong
				{ 5, 10846 },	-- Bloodshot Greaves
				{ 6, 10845 },	-- Warrior's Embrace
				{ 7, 10838 },	-- Might of Hakkar
				{ 8, 10844 },	-- Spire of Hakkar
			},
		},
		{	--STJammalanandOgom
			EncounterJournalID = 458,
			[NORMAL_DIFF] = {
				{ 1, 10806 },	-- Vestments of the Atal'ai Prophet
				{ 2, 10808 },	-- Gloves of the Atal'ai Prophet
				{ 3, 10807 },	-- Kilt of the Atal'ai Prophet
				{ 5, 6212, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Head of Jammal'an
				{ 16, "INV_Box_01", nil, BB["Ogom the Wretched"], nil },
				{ 17, 10805 },	-- Eater of the Dead
				{ 18, 10804 },	-- Fist of the Damned
				{ 19, 10803 },	-- Blade of the Wretched
			},
		},
		{	--STDragons
			EncounterJournalID = 459,
			[NORMAL_DIFF] = {
				{ 1, 12465 },	-- Nightfall Drape
				{ 2, 12466 },	-- Dawnspire Cord
				{ 3, 12464 },	-- Bloodfire Talons
				{ 4, 10795 },	-- Drakeclaw Band
				{ 5, 10796 },	-- Drakestone
				{ 6, 10797 },	-- Firebreather
				{ 7, 12243 },	-- Smoldering Claw
				{ 8, 12463 },	-- Drakefang Butcher
			},
		},
		{	--STEranikus
			EncounterJournalID = 463,
			[NORMAL_DIFF] = {
				{ 1, 10847 },	-- Dragon's Call
				{ 3, 10833 },	-- Horns of Eranikus
				{ 4, 10829 },	-- The Dragon's Eye
				{ 5, 10828 },	-- Dire Nail
				{ 6, 10835 },	-- Crest of Supremacy
				{ 7, 10837 },	-- Tooth of Eranikus
				{ 8, 10836 },	-- Rod of Corrosion
				{ 16, "ac641" },
			},
		},
		{	--STTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 10630 },	-- Soulcatcher Halo
				{ 2, 10629 },	-- Mistwalker Boots
				{ 3, 10632 },	-- Slimescale Bracers
				{ 4, 10631 },	-- Murkwater Gauntlets
				{ 5, 10633 },	-- Silvershell Leggings
				{ 6, 10634 },	-- Mindseye Circle
				{ 8, 15733, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Green Dragonscale Leggings
				{ 16, 10623 },	-- Winter's Bite
				{ 17, 10625 },	-- Stealthblade
				{ 18, 10628 },	-- Deathblow
				{ 19, 10626 },	-- Ragehammer
				{ 20, 10627 },	-- Bludgeon of the Grinning Dog
				{ 21, 10624 },	-- Stinging Bow
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local ULDAMAN_LOOT1 = {
	{ 1, 151396 },	-- Erik's High-Performance Armbands
	{ 2, 9398 },	-- Worn Running Boots
	{ 3, 132734 },	-- Viking Chain Boots
	{ 4, 9394 },	-- Horned Viking Helmet
	{ 5, 9400 },	-- Baelog's Shortbow
	{ 6, 9403 },	-- Battered Viking Shield
	{ 7, 9404 },	-- Olaf's All Purpose Shield
	{ 8, 9401 },	-- Nordic Longshank
}
local ULDAMAN_LOOT2 = {
	{ 1, 9390 },	-- Revelosh's Gloves
	{ 2, 9389 },	-- Revelosh's Spaulders
	{ 3, 9387 },	-- Revelosh's Boots
	{ 4, 132736 },	-- Revelosh's Pauldrons
	{ 5, 9388 },	-- Revelosh's Armguards
	{ 6, 151395 },	-- Revelosh's Girdle
	{ 8, 7741, [ATLASLOOT_IT_FILTERIGNORE] = true }, 	-- The Shaft of Tsol
}
local ULDAMAN_LOOT3 = {
	{ 1, 9407 },	-- Stoneweaver Leggings
	{ 2, 151398 },	-- Hood of the Idle Architect
	{ 3, 9409 },	-- Ironaya's Bracers
	{ 4, 151420 },	-- Vault-Watcher's Breastplate
	{ 5, 9408 },	-- Ironshod Bludgeon
}
local ULDAMAN_LOOT4 = {
	{ 1, 151399 },	-- Splintered Obsidian Shard
	{ 3, 62053, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Obsidian Power Core
}
local ULDAMAN_LOOT5 = {
	{ 1, 151400 },	-- Sand-Scoured Treads
	{ 2, 9411 },	-- Rockshard Pauldrons
	{ 3, 9410 },	-- Cragfists
	{ 4, 132733 },	-- Stone Keeper's Mantle
	{ 5, 151401 },	-- Titanic Stone Leggards
	{ 7, 62055, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Titan Power Core
}
local ULDAMAN_LOOT6 = {
	{ 1, 11311 },	-- Emberscale Cape
	{ 2, 11310 },	-- Flameseer Mantle
	{ 3, 9412 },	-- Galgann's Fireblaster
	{ 4, 9419 },	-- Galgann's Firehammer
}
local ULDAMAN_LOOT7 = {
	{ 1, 9415 },	-- Grimlok's Tribal Vestments
	{ 2, 9414 },	-- Oilskin Leggings
	{ 3, 132735 },	-- Grimlok's Chain Chaps
	{ 4, 151402 },	-- Grimlok's Jagged Wristguards
	{ 5, 9416 },	-- Grimlok's Charge
}
local ULDAMAN_LOOT8 = {
	{ 1, 11118 },	-- Archaedic Stone
	{ 2, 9413 },	-- The Rockpounder
	{ 3, 9418 },	-- Stoneslayer
	{ 16, "ac638" },
}
local ULDAMAN_LOOT9 = {
	{ 1, 9397 },	-- Energy Cloak
	{ 2, 9429 },	-- Miner's Hat of the Deep
	{ 3, 9431 },	-- Papal Fez
	{ 4, 9406 },	-- Spirewind Fetter
	{ 5, 9420 },	-- Adventurer's Pith Helmet
	{ 6, 9430 },	-- Spaulders of a Lost Age
	{ 7, 9428 },	-- Unearthed Bands
	{ 8, 9396 },	-- Legguards of the Vault
	{ 9, 9432 },	-- Skullplate Bracers
	{ 16, 9426 },	-- Monolithic Bow
	{ 17, 9384 },	-- Stonevault Shiv
	{ 18, 9422 },	-- Shadowforge Bushmaster
	{ 19, 9393 },	-- Beacon of Hope
	{ 20, 9465 },	-- Digmaster 5000
	{ 21, 9386 },	-- Excavator's Brand
	{ 22, 9427 },	-- Stonevault Bonebreaker
	{ 23, 9392 },	-- Annealed Blade
	{ 24, 9424 },	-- Ginn-Su Sword
	{ 25, 9383 },	-- Obsidian Cleaver
	{ 26, 9425 },	-- Pendulum of Doom
	{ 27, 9423 },	-- The Jackhammer
	{ 28, 9391 },	-- The Shoveler
	{ 29, 9381 },	-- Earthen Rod
}
data["Uldaman"] = {
	EncounterJournalID = 239,
	MapID = 230,
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--The Lost Dwarves
			name = "The Lost Dwarves",
			EncounterJournalID = 468,
			[NORMAL_DIFF] = ULDAMAN_LOOT1,
		},
		{	--Revelosh
			EncounterJournalID = 467,
			[NORMAL_DIFF] = ULDAMAN_LOOT2,
		},
		{	--Ironaya
			EncounterJournalID = 469,
			[NORMAL_DIFF] = ULDAMAN_LOOT3,
		},
		{	--Obsidian Sentinel
			name = "Obsidian Sentinel",
			[NORMAL_DIFF] = ULDAMAN_LOOT4,
		},
		{	--Ancient Stone Keeper
			EncounterJournalID = 470,
			[NORMAL_DIFF] = ULDAMAN_LOOT5,
		},
		{	--Galgann Firehammer
			EncounterJournalID = 471,
			[NORMAL_DIFF] = ULDAMAN_LOOT6,
		},
		{	--Grimlok
			EncounterJournalID = 472,
			[NORMAL_DIFF] = ULDAMAN_LOOT7,
		},
		{	--Archaedas
			EncounterJournalID = 473,
			[NORMAL_DIFF] = ULDAMAN_LOOT8,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = ULDAMAN_LOOT9,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local WAILING_CAVERNS_LOOT1 = {
	{ 1, 5423 },	-- Boahn's Fang
	{ 3, 5422 },	-- Brambleweed Leggings
}
local WAILING_CAVERNS_LOOT2 = {
	{ 1, 5425 },	-- Runescale Girdle
	{ 2, 5426 },	-- Serpent's Kiss
}
local WAILING_CAVERNS_LOOT3 = {
	{ 1, 151426 },	-- Lady Anadondra's Satin Cuffs
	{ 2, 5404 },	-- Serpent's Shoulders
	{ 3, 10412 },	-- Belt of the Fang
	{ 4, 132737 },	-- Cavern Slitherer Pauldrons
	{ 5, 132740 },	-- Slither-Scale Cord
	{ 6, 151427 },	-- Snake Charmer's Casque
	{ 8, 6446 },	-- Snakeskin Bag
}
local WAILING_CAVERNS_LOOT4 = {
	{ 1, 151428 },	-- Slumbersilk Waistcord
	{ 2, 6473 },	-- Armor of the Fang
	{ 3, 132739 },	-- Slither-Scale Hauberk
	{ 4, 151429 },	-- Lord Pythas' Pauldrons
	{ 5, 6472 },	-- Stinging Viper
}
local WAILING_CAVERNS_LOOT5 = {
	{ 1, 6465 },	-- Robe of the Moccasin
	{ 2, 10410 },	-- Leggings of the Fang
	{ 3, 132742 },	-- Slither-Scale Britches
	{ 4, 6460 },	-- Cobrahn's Grasp
}
local WAILING_CAVERNS_LOOT6 = {
	{ 1, 151430 },	-- Hematite Tortoise Pendant
	{ 2, 13245 },	-- Kresh's Back
	{ 3, 6447 },	-- Worn Turtle Shell Shield
}
local WAILING_CAVERNS_LOOT7 = {
	{ 1, 6449 },	-- Glowing Lizardscale Cloak
	{ 2, 6448 },	-- Tail Spike
}
local WAILING_CAVERNS_LOOT8 = {
	{ 1, 6632 },	-- Feyscale Cloak
	{ 2, 5243 },	-- Firebelcher
}
local WAILING_CAVERNS_LOOT9 = {
	{ 1, 5970 },	-- Serpent Gloves
	{ 2, 10411 },	-- Footpads of the Fang
	{ 3, 132741 },	-- Slither-Scale Boots
	{ 4, 6459 },	-- Savage Trodders
	{ 5, 6469 },	-- Venomstrike
}
local WAILING_CAVERNS_LOOT10 = {
	{ 1, 6629 },	-- Sporid Cape
	{ 2, 6630 },	-- Seedcloud Buckler
	{ 3, 6631 },	-- Living Root
}
local WAILING_CAVERNS_LOOT11 = {
	{ 1, 6461 },	-- Slime-Encrusted Pads
	{ 2, 6627 },	-- Mutant Scale Breastplate
	{ 3, 6463 },	-- Deep Fathom Ring
	{ 16, "ac630" },
}
local WAILING_CAVERNS_LOOT12 = {
	{ 1, 12987 },	-- Darkweave Breeches
	{ 2, 10413 },	-- Gloves of the Fang
	{ 3, 132743 },	-- Slither-Scale Gauntlets
}
data["WailingCaverns"] = {
	EncounterJournalID = 240,
	MapID = 279,
	AtlasMapID = "WailingCaverns",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Boahn
			name = BB["Boahn"].." ("..AL["Rare"]..", "..AL["Entrance"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Trigore the Lasher
			name = BB["Trigore the Lasher"].." ("..AL["Rare"]..", "..AL["Entrance"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Lady Anacondra
			EncounterJournalID = 474,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT3,
		},
		{	--Lord Pythas
			EncounterJournalID = 476,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT4,
		},
		{	--Lord Cobrahn
			EncounterJournalID = 475,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT5,
		},
		{	--Kres-h
			EncounterJournalID = 477,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT6,
		},
		{	--Skum
			EncounterJournalID = 478,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT7,
		},
		{	--Deviate Faerie Dragon
			name = BB["Deviate Faerie Dragon"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT8,
		},
		{	--Lord Serpentis
			EncounterJournalID = 479,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT9,
		},
		{	--Verdan the Everliving
			EncounterJournalID = 480,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT10,
		},
		{	--Mutanus the Devourer
			EncounterJournalID = 481,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT11,
		},
		{	--Trash Mobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT12,
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ZulFarrak"] = {
	EncounterJournalID = 241,
	MapID = 219,
	AtlasMapID = "ZulFarrak",
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--ZFZerillis
			name = BB["Zerillis"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12470 },	-- Sandstalker Ankleguards
			},
		},
		{	--ZFAntusul
			EncounterJournalID = 484,
			[NORMAL_DIFF] = {
				{ 1, 9640 },	-- Vice Grips
				{ 2, 9641 },	-- Lifeblood Amulet
				{ 3, 9639 },	-- The Hand of Antu'sul
				{ 5, 9379 },	-- Sang'thraze the Deflector
				{ 6, 9372, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sul'thraze the Lasher
			},
		},
		{	--ZFThekaTheMartyr
			name = "Theka the Martyr",
			[NORMAL_DIFF] = {
				{ 1, 151456 },	-- Theka's Seal of Vigilance
				{ 3, 10660, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- First Mosh'aru Tablet
			},
		},
		{	--ZFWitchDoctorZum'rah
			EncounterJournalID = 486,
			[NORMAL_DIFF] = {
				{ 1, 18083 },	-- Jumanza Grips
				{ 2, 151457 },	-- Witch Doctor's Ritual Collar
				{ 3, 18082 },	-- Zum'rah's Vexing Cane
			},
		},
		{	--ZFHydromancerVelratha
			EncounterJournalID = 482,
			[NORMAL_DIFF] = {
				{ 1, 9234, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tiara of the Deep
			},
		},
		{	--ZFGahzrilla
			EncounterJournalID = 483,
			[NORMAL_DIFF] = {
				{ 1, 151455 },	-- Gahz'rilla Scale Cloak
				{ 2, 9469 },	-- Gahz'rilla Scale Armor
				{ 3, 9467 },	-- Gahz'rilla Fang
				{ 5, 8707, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gahz'rilla's Electrified Scale
			},
		},
		{	--ZFSezzziz
			EncounterJournalID = 487,
			[NORMAL_DIFF] = {
				{ 1, 9470 },	-- Bad Mojo Mask
				{ 2, 9473 },	-- Jinxed Hoodoo Skin
				{ 3, 9474 },	-- Jinxed Hoodoo Kilt
				{ 4, 151458 },	-- Sezz'ziz's Captive Kickers
				{ 5, 151459 },	-- Nekrum's Witherguard
				{ 6, 9475 },	-- Diabolic Skiver
			},
		},
		{	--ZFDustwraith
			name = BB["Dustwraith"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12471 },	-- Desertwalker Cane
			},
		},
		{	--ZFChiefUkorzSandscalp
			EncounterJournalID = 489,
			[NORMAL_DIFF] = {
				{ 1, 151460 },	-- Farraki Ceremonial Robes
				{ 2, 9479 },	-- Embrace of the Lycan
				{ 3, 151461 },	-- Ukorz's Chain Leggings
				{ 4, 9476 },	-- Big Bad Pauldrons
				{ 5, 9478 },	-- Ripsaw
				{ 6, 9477 },	-- The Chief's Enforcer
				{ 8, 11086 },	-- Jang'thraze the Protector
				{ 9, 9372, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sul'thraze the Lasher
				{ 16, "ac639" },
			},
		},
		{	--ZFTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 9512 },	-- Blackmetal Cape
				{ 2, 9484 },	-- Spellshock Leggings
				{ 3, 9243 },	-- Shriveled Troll Heart
				{ 4, 862  },	-- Runed Ring
				{ 5, 6440 },	-- Brainlash
				{ 16, 5616 },	-- Gutwrencher
				{ 17, 9511 },	-- Bloodletter Scalpel
				{ 18, 9481 },	-- The Minotaur
				{ 19, 9480 },	-- Eyegouger
				{ 20, 9482 },	-- Witch Doctor's Cane
				{ 21, 9483 },	-- Flaming Incinerator
				{ 22, 2040 },	-- Troll Protector
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local AQ_ENCHANTS = {
	{ 1, 20728, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Frost Power
	{ 2, 20731, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Superior Agility
	{ 3, 20734, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Cloak - Stealth
	{ 4, 20729, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Fire Power
	{ 5, 20736, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Cloak - Dodge
	{ 6, 20730, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Healing Power
	{ 7, 20727, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Shadow Power
}
data["AhnQiraj"] = {
	name = ALIL["Ahn'Qiraj"],
	EncounterJournalID = 744,
	MapID = 319,
	AtlasMapID = "TheTempleofAhnQiraj",
	ContentType = RAID_CONTENT,
	items = {
		{	--AQ40Skeram
			--name = BB["The Prophet Skeram"],
			EncounterJournalID = 1543,
			[NORMAL_DIFF] = {
				{ 1, 21701 },	-- Cloak of Concentrated Hatred
				{ 2, 21708 },	-- Beetle Scaled Wristguards
				{ 3, 21698 },	-- Leggings of Immersion
				{ 4, 21699 },	-- Barrage Shoulders
				{ 5, 21705 },	-- Boots of the Fallen Prophet
				{ 6, 21814 },	-- Breastplate of Annihilation
				{ 7, 21704 },	-- Boots of the Redeemed Prophecy
				{ 8, 21706 },	-- Boots of the Unwavering Will
				{ 10, 21702 },	-- Amulet of Foul Warding
				{ 11, 21700 },	-- Pendant of the Qiraji Guardian
				{ 12, 21707 },	-- Ring of Swarming Thought
				{ 13, 21703 },	-- Hammer of Ji'zhi
				{ 14, 21128 },	-- Staff of the Qiraji Prophets
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
				{ 27, 22222, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Thick Obsidian Breastplate
				{ 29, 93041, "pet1156" },	-- Jewel of Maddening Whispers
			},
		},
		{	--AQ40BugFam
			name = BB["The Bug Family"],
			[NORMAL_DIFF] = {
				{ 1, 21697 },	-- Cape of the Trinity
				{ 2, 21694 },	-- Ternary Mantle
				{ 3, 21696 },	-- Robes of the Triumvirate
				{ 4, 21693 },	-- Guise of the Devourer
				{ 5, 21692 },	-- Triad Girdle
				{ 6, 21695 },	-- Angelista's Touch
				{ 8, 21237 },	-- Imperial Qiraji Regalia
				{ 9, 21232 },	-- Imperial Qiraji Armaments
				{ 11, "INV_Box_01", nil, BB["Lord Kri"], nil },
				{ 12, 21680 },	-- Vest of Swift Execution
				{ 13, 21603 },	-- Wand of Qiraji Nobility
				{ 14, 21681 },	-- Ring of the Devoured
				{ 15, 21685 },	-- Petrified Scarab
				{ 16, "INV_Box_01", nil, BB["Princess Yauj"], nil },
				{ 17, 21686 },	-- Mantle of Phrenic Power
				{ 18, 21682 },	-- Bile-Covered Gauntlets
				{ 19, 21684 },	-- Mantle of the Desert's Fury
				{ 20, 21683 },	-- Mantle of the Desert Crusade
				{ 21, 21687 },	-- Ukko's Ring of Darkness
				{ 23, "INV_Box_01", nil, BB["Vem"], nil },
				{ 24, 21689 },	-- Gloves of Ebru
				{ 25, 21691 },	-- Ooze-Ridden Gauntlets
				{ 26, 21688 },	-- Boots of the Fallen Hero
				{ 27, 21690 },	-- Angelista's Charm
			},
		},
		{	--AQ40Sartura
			--name = BB["Battleguard Sartura"],
			EncounterJournalID = 1544,
			[NORMAL_DIFF] = {
				{ 1, 21671 },	-- Robes of the Battleguard
				{ 2, 21676 },	-- Leggings of the Festering Swarm
				{ 3, 21648 },	-- Recomposed Boots
				{ 4, 21669 },	-- Creeping Vine Helm
				{ 5, 21672 },	-- Gloves of Enforcement
				{ 6, 21675 },	-- Thick Qirajihide Belt
				{ 7, 21668 },	-- Scaled Leggings of Qiraji Fury
				{ 8, 21674 },	-- Gauntlets of Steadfast Determination
				{ 9, 21667 },	-- Legplates of Blazing Light
				{ 11, 21678 },	-- Necklace of Purity
				{ 12, 21670 },	-- Badge of the Swarmguard
				{ 13, 21666 },	-- Sartura's Might
				{ 14, 21673 },	-- Silithid Claw
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Fankriss
			--name = BB["Fankriss the Unyielding"],
			EncounterJournalID = 1545,
			[NORMAL_DIFF] = {
				{ 1, 21627 },	-- Cloak of Untold Secrets
				{ 2, 21663 },	-- Robes of the Guardian Saint
				{ 3, 21665 },	-- Mantle of Wicked Revenge
				{ 4, 21645 },	-- Hive Tunneler's Boots
				{ 5, 21651 },	-- Scaled Sand Reaver Leggings
				{ 6, 21639 },	-- Pauldrons of the Unrelenting
				{ 7, 21652 },	-- Silithid Carapace Chestguard
				{ 9, 21647 },	-- Fetish of the Sand Reaver
				{ 10, 21664 },	-- Barbed Choker
				{ 11, 21650 },	-- Ancient Qiraji Ripper
				{ 12, 21635 },	-- Barb of the Sand Reaver
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Viscidus
			--name = BB["Viscidus"],
			EncounterJournalID = 1548,
			[NORMAL_DIFF] = {
				{ 1, 21624 },	-- Gauntlets of Kalimdor
				{ 2, 21626 },	-- Slime-Coated Leggings
				{ 3, 21623 },	-- Gauntlets of the Righteous Champion
				{ 5, 21677 },	-- Ring of the Qiraji Fury
				{ 6, 21625 },	-- Scarab Brooch
				{ 7, 21622 },	-- Sharpened Silithid Femur
				{ 9, 20932 },	-- Qiraji Bindings of Dominance
				{ 10, 20928 },	-- Qiraji Bindings of Command
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
				{ 27, 93039, "pet1154" },	-- Viscidus Globule
			},
		},
		{	--AQ40Huhuran
			--name = BB["Princess Huhuran"],
			EncounterJournalID = 1546,
			[NORMAL_DIFF] = {
				{ 1, 21619 },	-- Gloves of the Messiah
				{ 2, 21621 },	-- Cloak of the Golden Hive
				{ 3, 21617 },	-- Wasphide Gauntlets
				{ 4, 21618 },	-- Hive Defiler Wristguards
				{ 6, 21620 },	-- Ring of the Martyr
				{ 7, 21616 },	-- Huhuran's Stinger
				{ 9, 20932 },	-- Qiraji Bindings of Dominance
				{ 10, 20928 },	-- Qiraji Bindings of Command
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Emperors
			--name = BB["The Twin Emperors"],
			EncounterJournalID = 1549,
			[NORMAL_DIFF] = {
				{ 1, 20930 },	-- Vek'lor's Diadem
				{ 2, 21600 },	-- Boots of Epiphany
				{ 3, 21602 },	-- Qiraji Execution Bracers
				{ 4, 21599 },	-- Vek'lor's Gloves of Devastation
				{ 5, 21598 },	-- Royal Qiraji Belt
				{ 6, 21597 },	-- Royal Scepter of Vek'lor
				{ 7, 21601 },	-- Ring of Emperor Vek'lor
				{ 8, 20735, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Cloak - Subtlety
				{ 9, 93040, "pet1155" },	-- Anubisath Idol
				{ 11, 21232 },	-- Imperial Qiraji Armaments
				{ 12, 21242 },	-- Blessed Qiraji War Axe
				{ 13, 21272 },	-- Blessed Qiraji Musket
				{ 14, 21244 },	-- Blessed Qiraji Pugio
				{ 15, 21269 },	-- Blessed Qiraji Bulwark
				{ 16, 20926 },	-- Vek'nilash's Circlet
				{ 17, 21604 },	-- Bracelets of Royal Redemption
				{ 18, 21605 },	-- Gloves of the Hidden Temple
				{ 19, 21609 },	-- Regenerating Belt of Vek'nilash
				{ 20, 21607 },	-- Grasp of the Fallen Emperor
				{ 21, 21606 },	-- Belt of the Fallen Emperor
				{ 22, 21679 },	-- Kalimdor's Revenge
				{ 23, 21608 },	-- Amulet of Vek'nilash
				{ 24, 20726, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Gloves - Threat
				{ 26, 21237 },	-- Imperial Qiraji Regalia
				{ 27, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 28, 21275 },	-- Blessed Qiraji Augur Staff
				{ 29, 21268 },	-- Blessed Qiraji War Hammer
			},
		},
		{	--AQ40Ouro
			--name = BB["Ouro"],
			EncounterJournalID = 1550,
			[NORMAL_DIFF] = {
				{ 1, 21615 },	-- Don Rigoberto's Lost Hat
				{ 2, 21611 },	-- Burrower Bracers
				{ 3, 23558 },	-- The Burrower's Shell
				{ 4, 23570 },	-- Jom Gabbar
				{ 5, 23557 },	-- Larvae of the Great Worm
				{ 6, 21610 },	-- Wormscale Blocker
				{ 8, 20927 },	-- Ouro's Intact Hide
				{ 9, 20931 },	-- Skin of the Great Sandworm
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40CThun
			--name = BB["C'Thun"],
			EncounterJournalID = 1551,
			[NORMAL_DIFF] = {
				{ 1, 21583 },	-- Cloak of Clarity
				{ 2, 22731 },	-- Cloak of the Devoured
				{ 3, 21585 },	-- Dark Storm Gauntlets
				{ 4, 22730 },	-- Eyestalk Waist Cord
				{ 5, 21582 },	-- Grasp of the Old God
				{ 6, 21586 },	-- Belt of Never-Ending Agony
				{ 7, 21581 },	-- Gauntlets of Annihilation
				{ 9, 22732 },	-- Mark of C'Thun
				{ 10, 21596 },	-- Ring of the Godslayer
				{ 11, 21579 },	-- Vanquished Tentacle of C'Thun
				{ 12, 21126 },	-- Death's Sting
				{ 13, 21134 },	-- Dark Edge of Insanity
				{ 14, 21839 },	-- Scepter of the False Prophet
				{ 16, 20933 },	-- Husk of the Old God
				{ 17, 20929 },	-- Carapace of the Old God
				{ 19, 21221 },	-- Eye of C'Thun
				{ 20, 21710 },	-- Cloak of the Fallen God
				{ 21, 21712 },	-- Amulet of the Fallen God
				{ 22, 21709 },	-- Ring of the Fallen God
				{ 24, "ac687" },
			},
		},
		{	--AQ40Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 21838 },	-- Garb of Royal Ascension
				{ 2, 21888 },	-- Gloves of the Immortal
				{ 3, 21889 },	-- Gloves of the Redeemed Prophecy
				{ 4, 21836 },	-- Ritssyn's Ring of Chaos
				{ 5, 21891 },	-- Shard of the Fallen Star
				{ 6, 21856 },	-- Neretzek, The Blood Drinker
				{ 7, 21837 },	-- Anubisath Warhammer
				{ 9, 22202 },	-- Small Obsidian Shard
				{ 10, 22203 },	-- Large Obsidian Shard
				{ 16, 21218, "mount" },	-- Blue Qiraji Resonating Crystal
				{ 17, 21323, "mount" },	-- Green Qiraji Resonating Crystal
				{ 18, 21321, "mount" },	-- Red Qiraji Resonating Crystal
				{ 19, 21324, "mount" },	-- Yellow Qiraji Resonating Crystal
				{ 101, 20876 },	-- Idol of Death
				{ 102, 20879 },	-- Idol of Life
				{ 103, 20875 },	-- Idol of Night
				{ 104, 20878 },	-- Idol of Rebirth
				{ 105, 20881 },	-- Idol of Strife
				{ 106, 20877 },	-- Idol of the Sage
				{ 107, 20874 },	-- Idol of the Sun
				{ 108, 20882 },	-- Idol of War
				{ 110, 21230 },	-- Ancient Qiraji Artifact
				{ 112, 21762 },	-- Greater Scarab Coffer Key
				{ 116, 20864 },	-- Bone Scarab
				{ 117, 20861 },	-- Bronze Scarab
				{ 118, 20863 },	-- Clay Scarab
				{ 119, 20862 },	-- Crystal Scarab
				{ 120, 20859 },	-- Gold Scarab
				{ 121, 20865 },	-- Ivory Scarab
				{ 122, 20860 },	-- Silver Scarab
				{ 123, 20858 },	-- Stone Scarab
			},
		},
		{	--AQ40Sets
			name = ALIL["Ahn'Qiraj"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:1",
		},
		{	--AQEnchants
			name = AL["AQ Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = AQ_ENCHANTS,
		},
		{	--BroodofNozdormu
			FactionID = 910,
			CoinTexture = "Reputation",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Factions:CLASSICFACTIONS:3",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["BlackwingLair"] = {
	name = ALIL["Blackwing Lair"],
	EncounterJournalID = 742,
	MapID = 287,
	AtlasMapID = "BlackwingLair",
	ContentType = RAID_CONTENT,
	items = {
		{	--BWLRazorgore
			--name = BB["Razorgore the Untamed"],
			EncounterJournalID = 1529,
			[NORMAL_DIFF] = {
				{ 1, 16918 },	-- Netherwind Bindings
				{ 2, 16926 },	-- Bindings of Transcendence
				{ 3, 16934 },	-- Nemesis Bracers
				{ 4, 16911 },	-- Bloodfang Bracers
				{ 5, 16904 },	-- Stormrage Bracers
				{ 6, 16935 },	-- Dragonstalker's Bracers
				{ 7, 16943 },	-- Bracers of Ten Storms
				{ 8, 16959 },	-- Bracelets of Wrath
				{ 9, 16951 },	-- Judgement Bindings
				{ 16, 19337 },	-- The Black Book
				{ 17, 19336 },	-- Arcane Infused Gem
				{ 19, 19370 },	-- Mantle of the Blackwing Cabal
				{ 20, 19369 },	-- Gloves of Rapid Evolution
				{ 21, 19334 },	-- The Untamed Blade
				{ 22, 19335 },	-- Spineshatter
				{ 24, 93036, "pet1151" },	-- Unscathed Egg
			},
		},
		{	--BWLVaelastrasz
			--name = BB["Vaelastrasz the Corrupt"],
			EncounterJournalID = 1530,
			[NORMAL_DIFF] = {
				{ 1, 16818 },	-- Netherwind Belt
				{ 2, 16925 },	-- Belt of Transcendence
				{ 3, 16933 },	-- Nemesis Belt
				{ 4, 16936 },	-- Dragonstalker's Belt
				{ 5, 16903 },	-- Stormrage Belt
				{ 6, 16910 },	-- Bloodfang Belt
				{ 7, 16944 },	-- Belt of Ten Storms
				{ 8, 16960 },	-- Waistband of Wrath
				{ 9, 16952 },	-- Judgement Belt
				{ 16, 19339 },	-- Mind Quickening Gem
				{ 17, 19340 },	-- Rune of Metamorphosis
				{ 19, 19372 },	-- Helm of Endless Rage
				{ 20, 19371 },	-- Pendant of the Fallen Dragon
				{ 21, 19346 },	-- Dragonfang Blade
				{ 22, 19348 },	-- Red Dragonscale Protector
			},
		},
		{	--BWLLashlayer
			--name = BB["Broodlord Lashlayer"],
			EncounterJournalID = 1531,
			[NORMAL_DIFF] = {
				{ 1, 16912 },	-- Netherwind Boots
				{ 2, 16919 },	-- Boots of Transcendence
				{ 3, 16927 },	-- Nemesis Boots
				{ 4, 16898 },	-- Stormrage Boots
				{ 5, 16906 },	-- Bloodfang Boots
				{ 6, 16941 },	-- Dragonstalker's Greaves
				{ 7, 16949 },	-- Greaves of Ten Storms
				{ 8, 16965 },	-- Sabatons of Wrath
				{ 9, 16957 },	-- Judgement Sabatons
				{ 16, 19342 },	-- Venomous Totem
				{ 17, 19341 },	-- Lifegiving Gem
				{ 19, 19374 },	-- Bracers of Arcane Accuracy
				{ 20, 19373 },	-- Black Brood Pauldrons
				{ 21, 19351 },	-- Maladath, Runed Blade of the Black Flight
				{ 22, 19350 },	-- Heartstriker
				{ 24, 93037, "pet1153" },	-- Blackwing Banner
			},
		},
		{	--BWLFiremaw
			--name = BB["Firemaw"],
			EncounterJournalID = 1532,
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 11, 19365 },	-- Claw of the Black Drake
				{ 12, 19355 },	-- Shadow Wing Focus Staff
				{ 13, 19353 },	-- Drake Talon Cleaver
				{ 16, 19343 },	-- Scrolls of Blinding Light
				{ 17, 19344 },	-- Natural Alignment Crystal
				{ 19, 19398 },	-- Cloak of Firemaw
				{ 20, 19400 },	-- Firemaw's Clutch
				{ 21, 19399 },	-- Black Ash Robe
				{ 22, 19396 },	-- Taut Dragonhide Belt
				{ 23, 19401 },	-- Primalist's Linked Legguards
				{ 24, 19394 },	-- Drake Talon Pauldrons
				{ 25, 19402 },	-- Legguards of the Fallen Crusader
				{ 27, 19397 },	-- Ring of Blackrock
				{ 28, 19395 },	-- Rejuvenating Gem
			},
		},
		{	--BWLEbonroc
			--name = BB["Ebonroc"],
			EncounterJournalID = 1533,
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 16, 19345 },	-- Aegis of Preservation
				{ 18, 19407 },	-- Ebony Flame Gloves
				{ 19, 19405 },	-- Malfurion's Blessed Bulwark
				{ 20, 19396 },	-- Taut Dragonhide Belt
				{ 21, 19394 },	-- Drake Talon Pauldrons
				{ 23, 19403 },	-- Band of Forced Concentration
				{ 24, 19397 },	-- Ring of Blackrock
				{ 25, 19406 },	-- Drake Fang Talisman
				{ 26, 19395 },	-- Rejuvenating Gem
				{ 28, 19353 },	-- Drake Talon Cleaver
				{ 29, 19355 },	-- Shadow Wing Focus Staff
				{ 30, 19368 },	-- Dragonbreath Hand Cannon
			},
		},
		{	--BWLFlamegor
			--name = BB["Flamegor"],
			EncounterJournalID = 1534,
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 16, 19430 },	-- Shroud of Pure Thought
				{ 17, 19396 },	-- Taut Dragonhide Belt
				{ 18, 19433 },	-- Emberweave Leggings
				{ 19, 19394 },	-- Drake Talon Pauldrons
				{ 21, 19397 },	-- Ring of Blackrock
				{ 22, 19432 },	-- Circle of Applied Force
				{ 23, 19395 },	-- Rejuvenating Gem
				{ 24, 19431 },	-- Styleen's Impeding Scarab
				{ 26, 19353 },	-- Drake Talon Cleaver
				{ 27, 19357 },	-- Herald of Woe
				{ 28, 19355 },	-- Shadow Wing Focus Staff
				{ 29, 19367 },	-- Dragon's Touch
			},
		},
		{	--BWLChromaggus
			--name = BB["Chromaggus"],
			EncounterJournalID = 1535,
			[NORMAL_DIFF] = {
				{ 1, 16917 },	-- Netherwind Mantle
				{ 2, 16924 },	-- Pauldrons of Transcendence
				{ 3, 16932 },	-- Nemesis Spaulders
				{ 4, 16937 },	-- Dragonstalker's Spaulders
				{ 5, 16902 },	-- Stormrage Pauldrons
				{ 6, 16832 },	-- Bloodfang Spaulders
				{ 7, 16945 },	-- Epaulets of Ten Storms
				{ 8, 16953 },	-- Judgement Spaulders
				{ 9, 16961 },	-- Pauldrons of Wrath
				{ 11, 93038, "pet1152" },	-- Whistle of Chromatic Bone
				{ 16, 19386 },	-- Elementium Threaded Cloak
				{ 17, 19388 },	-- Angelista's Grasp
				{ 18, 19385 },	-- Empowered Leggings
				{ 19, 19391 },	-- Shimmering Geta
				{ 20, 19389 },	-- Taut Dragonhide Shoulderpads
				{ 21, 19390 },	-- Taut Dragonhide Gloves
				{ 22, 19393 },	-- Primalist's Linked Waistguard
				{ 23, 19392 },	-- Girdle of the Fallen Crusader
				{ 24, 19387 },	-- Chromatic Boots
				{ 26, 19347 },	-- Claw of Chromaggus
				{ 27, 19352 },	-- Chromatically Tempered Sword
				{ 28, 19349 },	-- Elementium Reinforced Bulwark
				{ 29, 19361 },	-- Ashjre'thul, Crossbow of Smiting
			},
		},
		{	--BWLNefarian
			--name = BB["Nefarian"],
			EncounterJournalID = 1536,
			[NORMAL_DIFF] = {
				{ 1, 16914 },	-- Netherwind Crown
				{ 2, 16916 },	-- Netherwind Robes
				{ 3, 16929 },	-- Nemesis Skullcap
				{ 4, 16931 },	-- Nemesis Robes
				{ 5, 16921 },	-- Halo of Transcendence
				{ 6, 16923 },	-- Robes of Transcendence
				{ 7, 16908 },	-- Bloodfang Hood
				{ 8, 16905 },	-- Bloodfang Chestpiece
				{ 9, 16900 },	-- Stormrage Cover
				{ 10, 16897 },	-- Stormrage Chestguard
				{ 11, 16939 },	-- Dragonstalker's Helm
				{ 12, 16942 },	-- Dragonstalker's Breastplate
				{ 13, 16947 },	-- Helmet of Ten Storms
				{ 14, 16950 },	-- Breastplate of Ten Storms
				{ 15, 16963 },	-- Helm of Wrath
				{ 16, 16966 },	-- Breastplate of Wrath
				{ 17, 16955 },	-- Judgement Crown
				{ 18, 16958 },	-- Judgement Breastplate
				{ 20, 19378 },	-- Cloak of the Brood Lord
				{ 21, 19375 },	-- Mish'undare, Circlet of the Mind Flayer
				{ 22, 19381 },	-- Boots of the Shadow Flame
				{ 23, 19380 },	-- Therazane's Link
				{ 25, 19377 },	-- Prestor's Talisman of Connivery
				{ 26, 19376 },	-- Archimtiros' Ring of Reckoning
				{ 27, 19382 },	-- Pure Elementium Band
				{ 28, 19379 },	-- Neltharion's Tear
				{ 101, 19003 },	-- Head of Nefarian
				{ 102, 19383 },	-- Master Dragonslayer's Medallion
				{ 103, 19384 },	-- Master Dragonslayer's Ring
				{ 104, 19366 },	-- Master Dragonslayer's Orb
				{ 106, "ac685" },
				{ 116, 19364 },	-- Ashkandi, Greatsword of the Brotherhood
				{ 117, 19363 },	-- Crul'shorukh, Edge of Chaos
				{ 118, 19360 },	-- Lok'amir il Romathis
				{ 119, 19356 },	-- Staff of the Shadow Flame
			},
		},
		{	--BWLTrashMobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 19436 },	-- Cloak of Draconic Might
				{ 2, 19437 },	-- Boots of Pure Thought
				{ 3, 19438 },	-- Ringo's Blizzard Boots
				{ 4, 19439 },	-- Interlaced Shadow Jerkin
				{ 5, 19434 },	-- Band of Dark Dominion
				{ 6, 19362 },	-- Doom's Edge
				{ 7, 19354 },	-- Draconic Avenger
				{ 8, 19358 },	-- Draconic Maul
				{ 9, 19435 },	-- Essence Gatherer
				{ 11, 18562 },	-- Elementium Ingot
				{ 16, "INV_Box_01", nil, AL["Master Elemental Shaper Krixix"], nil },
				{ 17, 44956 },	-- Goblin's Guide to Elementium
			},
		},
		{	--Tier 2 Sets
			name = format(AL["Tier %d Sets"], 2),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:2",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["MoltenCore"] = {
	name = ALIL["Molten Core"],
	EncounterJournalID = 741,
	MapID = 232,
	AtlasMapID = "MoltenCore",
	ContentType = RAID_CONTENT,
	items = {
		{	--MCLucifron
			--name = BB["Lucifron"],
			EncounterJournalID = 1519,
			DisplayIDs = {
				{ 13031 }
			},
			[NORMAL_DIFF] = {
				{ 1, 18872 },	-- Manastorm Leggings
				{ 2, 19145 },	-- Robe of Volatile Power
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 17109 },	-- Choker of Enlightenment
				{ 8, 18879 },	-- Heavy Dark Iron Ring
				{ 9, 19147 },	-- Ring of Spell Power
				{ 10, 18878 },	-- Sorcerous Dagger
				{ 11, 17077 },	-- Crimson Shocker
				{ 16, 16800 },	-- Arcanist Boots
				{ 17, 16805 },	-- Felheart Gloves
				{ 18, 16829 },	-- Cenarion Boots
				{ 19, 16837 },	-- Earthfury Boots
				{ 20, 16863 },	-- Gauntlets of Might
				{ 21, 16859 },	-- Lawbringer Boots
			},
		},
		{	--MCMagmadar
			--name = BB["Magmadar"],
			EncounterJournalID = 1520,
			DisplayIDs = {
				{ 10193 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 17065 },	-- Medallion of Steadfast Might
				{ 9, 18821 },	-- Quick Strike Ring
				{ 10, 18820 },	-- Talisman of Ephemeral Power
				{ 12, 19142 },	-- Fire Runed Grimoire
				{ 13, 18202 },	-- Eskhandar's Left Claw
				{ 14, 18203 },	-- Eskhandar's Right Claw
				{ 15, 18822 },	-- Obsidian Edged Blade
				{ 16, 17073 },	-- Earthshaker
				{ 17, 17069 },	-- Striker's Mark
				{ 19, 16796 },	-- Arcanist Leggings
				{ 20, 16814 },	-- Pants of Prophecy
				{ 21, 16810 },	-- Felheart Pants
				{ 22, 16822 },	-- Nightslayer Pants
				{ 23, 16847 },	-- Giantstalker's Leggings
				{ 24, 16835 },	-- Cenarion Leggings
				{ 25, 16843 },	-- Earthfury Legguards
				{ 26, 16855 },	-- Lawbringer Legplates
				{ 27, 16867 },	-- Legplates of Might
				{ 29, 93034, "pet1149" },	-- Blazing Rune
			},
		},
		{	--MCGehennas
			--name = BB["Gehennas"],
			EncounterJournalID = 1521,
			DisplayIDs = {
				{ 13030 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17077 },	-- Crimson Shocker
				{ 16, 16812 },	-- Gloves of Prophecy
				{ 17, 16826 },	-- Nightslayer Gloves
				{ 18, 16849 },	-- Giantstalker's Boots
				{ 19, 16839 },	-- Earthfury Gauntlets
				{ 20, 16862 },	-- Sabatons of Might
				{ 21, 16860 },	-- Lawbringer Gauntlets
			},
		},
		{	--MCGarr
			--name = BB["Garr"],
			EncounterJournalID = 1522,
			DisplayIDs = {
				{ 12110 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 18821 },	-- Quick Strike Ring
				{ 9, 18820 },	-- Talisman of Ephemeral Power
				{ 10, 19142 },	-- Fire Runed Grimoire
				{ 11, 17071 },	-- Gutgore Ripper
				{ 12, 18832 },	-- Brutality Blade
				{ 13, 18822 },	-- Obsidian Edged Blade
				{ 14, 17105 },	-- Aurastone Hammer
				{ 15, 17066 },	-- Drillborer Disk
				{ 16, 16795 },	-- Arcanist Crown
				{ 17, 16813 },	-- Circlet of Prophecy
				{ 18, 16808 },	-- Felheart Horns
				{ 19, 16846 },	-- Giantstalker's Helmet
				{ 20, 16834 },	-- Cenarion Helm
				{ 21, 16821 },	-- Nightslayer Cover
				{ 22, 16842 },	-- Earthfury Helmet
				{ 23, 16866 },	-- Helm of Might
				{ 24, 16854 },	-- Lawbringer Helm
				{ 26, 18564 },	-- Bindings of the Windseeker
				{ 27, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
			},
		},
		{	--MCShazzrah
			--name = BB["Shazzrah"],
			EncounterJournalID = 1523,
			DisplayIDs = {
				{ 13032 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17077 },	-- Crimson Shocker
				{ 16, 16801 },	-- Arcanist Gloves
				{ 17, 16803 },	-- Felheart Slippers
				{ 18, 16811 },	-- Boots of Prophecy
				{ 19, 16831 },	-- Cenarion Gloves
				{ 20, 16852 },	-- Giantstalker's Gloves
				{ 21, 16824 },	-- Nightslayer Boots
			},
		},
		{	--MCGeddon
			--name = BB["Baron Geddon"],
			EncounterJournalID = 1524,
			DisplayIDs = {
				{ 12129 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 17110 },	-- Seal of the Archmagus
				{ 9, 18821 },	-- Quick Strike Ring
				{ 10, 18820 },	-- Talisman of Ephemeral Power
				{ 11, 19142 },	-- Fire Runed Grimoire
				{ 12, 18822 },	-- Obsidian Edged Blade
				{ 16, 16797 },	-- Arcanist Mantle
				{ 17, 16807 },	-- Felheart Shoulder Pads
				{ 18, 16836 },	-- Cenarion Spaulders
				{ 19, 16844 },	-- Earthfury Epaulets
				{ 20, 16856 },	-- Lawbringer Spaulders
				{ 22, 18563 },	-- Bindings of the Windseeker
				{ 23, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
			},
		},
		{	--MCGolemagg
			--name = BB["Golemagg the Incinerator"],
			EncounterJournalID = 1526,
			DisplayIDs = {
				{ 11986 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 18821 },	-- Quick Strike Ring
				{ 9, 18820 },	-- Talisman of Ephemeral Power
				{ 10, 19142 },	-- Fire Runed Grimoire
				{ 11, 17103 },	-- Azuresong Mageblade
				{ 12, 18822 },	-- Obsidian Edged Blade
				{ 13, 18842 },	-- Staff of Dominance
				{ 14, 17072 },	-- Blastershot Launcher
				{ 16, 16798 },	-- Arcanist Robes
				{ 17, 16815 },	-- Robes of Prophecy
				{ 18, 16809 },	-- Felheart Robes
				{ 19, 16820 },	-- Nightslayer Chestpiece
				{ 20, 16833 },	-- Cenarion Vestments
				{ 21, 16845 },	-- Giantstalker's Breastplate
				{ 22, 16841 },	-- Earthfury Vestments
				{ 23, 16865 },	-- Breastplate of Might
				{ 24, 16853 },	-- Lawbringer Chestguard
				{ 26, 17203 },	-- Sulfuron Ingot
				{ 27, 17182 },	-- Sulfuras, Hand of Ragnaros
				{ 29, 93035, "pet1150" },	-- Core of Hardened Ash
			},
		},
		{	--MCSulfuron
			--name = BB["Sulfuron Harbinger"],
			EncounterJournalID = 1525,
			DisplayIDs = {
				{ 13030 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17074 },	-- Shadowstrike
				{ 11, 17077 },	-- Crimson Shocker
				{ 16, 16816 },	-- Mantle of Prophecy
				{ 17, 16823 },	-- Nightslayer Shoulder Pads
				{ 18, 16848 },	-- Giantstalker's Epaulets
				{ 19, 16868 },	-- Pauldrons of Might
				{ 21, 93033, "pet1147" },	-- Mark of Flame
			},
		},
		{	--MCMajordomo
			--name = BB["Majordomo Executus"],
			EncounterJournalID = 1527,
			DisplayIDs = {
				{ 12029 }
			},
			[NORMAL_DIFF] = {
				{ 1, 18811 },	-- Fireproof Cloak
				{ 2, 18808 },	-- Gloves of the Hypnotic Flame
				{ 3, 18809 },	-- Sash of Whispered Secrets
				{ 4, 19139 },	-- Fireguard Shoulders
				{ 5, 18810 },	-- Wild Growth Spaulders
				{ 6, 18812 },	-- Wristguards of True Flight
				{ 7, 18806 },	-- Core Forged Greaves
				{ 8, 19140 },	-- Cauterizing Band
				{ 9, 18805 },	-- Core Hound Tooth
				{ 10, 18803 },	-- Finkle's Lava Dredger
			},
		},
		{	--MCRagnaros
			--name = BB["Ragnaros"],
			EncounterJournalID = 1528,
			DisplayIDs = {
				{ 11121 }
			},
			[RF_DIFF] = {
				{ 1, 118942 },	-- Crown of Power
				{ 2, 118941 },	-- Crown of Woe
				{ 3, 118939 },	-- Crown of Destruction
				{ 4, 118940 },	-- Crown of Desolation
				{ 16, 118572 },	-- Flames of Ragnaros
				{ 17, 118574, "pet1544" },	-- Hatespark the Tiny
				{ 19, "ac9550", "mount170347" },
			},
			[NORMAL_DIFF] = {
				{ 1, 16915 },	-- Netherwind Pants
				{ 2, 16922 },	-- Leggings of Transcendence
				{ 3, 16930 },	-- Nemesis Leggings
				{ 4, 16909 },	-- Bloodfang Pants
				{ 5, 16901 },	-- Stormrage Legguards
				{ 6, 16938 },	-- Dragonstalker's Legguards
				{ 7, 16946 },	-- Legplates of Ten Storms
				{ 8, 16962 },	-- Legplates of Wrath
				{ 9, 16954 },	-- Judgement Legplates
				{ 11, 17204 },	-- Eye of Sulfuras
				{ 12, 17182, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sulfuras, Hand of Ragnaros
				{ 14, 19017 },	-- Essence of the Firelord
				{ 15, 19019, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Thunderfury, Blessed Blade of the Windseeker
				{ 16, 17102 },	-- Cloak of the Shrouded Mists
				{ 17, 17107 },	-- Dragon's Blood Cape
				{ 18, 18817 },	-- Crown of Destruction
				{ 19, 19137 },	-- Onslaught Girdle
				{ 20, 18814 },	-- Choker of the Fire Lord
				{ 21, 19138 },	-- Band of Sulfuras
				{ 22, 17063 },	-- Band of Accuria
				{ 23, 17082 },	-- Shard of the Flame
				{ 24, 18815 },	-- Essence of the Pure Flame
				{ 25, 18816 },	-- Perdition's Blade
				{ 26, 17076 },	-- Bonereaver's Edge
				{ 27, 17104 },	-- Spinal Reaper
				{ 28, 17106 },	-- Malistar's Defender
				{ 30, "ac686" },
			},
		},
		{	--MCRANDOMBOSSDROPPS
			name = AL["Shared Boss Loot"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18264, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Elemental Sharpening Stone
				{ 2, 18262, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Elemental Sharpening Stone
				{ 4, 18292, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Core Marksman Rifle
				{ 5, 18282, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core Marksman Rifle
				{ 7, 18291, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Force Reactive Disk
				{ 8, 18168, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Force Reactive Disk
				{ 10, 18290, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Biznicks 247x128 Accurascope
				{ 11, 18283, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Biznicks 247x128 Accurascope
				{ 13, 18259, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Spell Power
				{ 16, 18252, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Core Armor Kit
				{ 17, 18251, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core Armor Kit
				{ 19, 18265, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Flarecore Wraps
				{ 20, 18263, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Flarecore Wraps
				{ 22, 21371, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Core Felcloth Bag
				{ 23, 21342, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core Felcloth Bag
				{ 25, 18257, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Major Rejuvenation Potion
				{ 26, 18253, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Major Rejuvenation Potion
				{ 28, 18260, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Healing Power
			},
		},
		{	--MCTrashMobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 16802 },	-- Arcanist Belt
				{ 2, 16817 },	-- Girdle of Prophecy
				{ 3, 16806 },	-- Felheart Belt
				{ 4, 16827 },	-- Nightslayer Belt
				{ 5, 16828 },	-- Cenarion Belt
				{ 6, 16851 },	-- Giantstalker's Belt
				{ 7, 16838 },	-- Earthfury Belt
				{ 8, 16864 },	-- Belt of Might
				{ 9, 16858 },	-- Lawbringer Belt
				{ 11, 17010 },	-- Fiery Core
				{ 12, 17011 },	-- Lava Core
				{ 13, 11382 },	-- Blood of the Mountain
				{ 14, 17012 },	-- Core Leather
				{ 16, 16799 },	-- Arcanist Bindings
				{ 17, 16819 },	-- Vambraces of Prophecy
				{ 18, 16804 },	-- Felheart Bracers
				{ 19, 16825 },	-- Nightslayer Bracelets
				{ 20, 16830 },	-- Cenarion Bracers
				{ 21, 16850 },	-- Giantstalker's Bracers
				{ 22, 16840 },	-- Earthfury Bracers
				{ 23, 16861 },	-- Bracers of Might
				{ 24, 16857 },	-- Lawbringer Bracers
			},
		},
		{	--Tier 1 Sets
			name = format(AL["Tier %d Sets"], 1),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:1",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["TheRuinsofAhnQiraj"] = {
	name = ALIL["Ruins of Ahn'Qiraj"],
	EncounterJournalID = 743,
	MapID = 247,
	AtlasMapID = "TheRuinsofAhnQiraj",
	ContentType = RAID_CONTENT,
	items = {
		{	--AQ20Kurinnaxx
			--name = BB["Kurinnaxx"],
			EncounterJournalID = 1537,
			[NORMAL_DIFF] = {
				{ 1, 21499 },	-- Vestments of the Shifting Sands
				{ 2, 21498 },	-- Qiraji Sacrificial Dagger
				{ 4, 21500 },	-- Belt of the Inquisition
				{ 5, 21501 },	-- Toughened Silithid Hide Gloves
				{ 6, 21502 },	-- Sand Reaver Wristguards
				{ 7, 21503 },	-- Belt of the Sand Reaver
				{ 16, 20889 },	-- Qiraji Regal Drape
				{ 17, 20885 },	-- Qiraji Martial Drape
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, 22217 },	-- Kurinnaxx's Venom Sac
			},
		},
		{	--AQ20Rajaxx
			--name = BB["General Rajaxx"],
			EncounterJournalID = 1538,
			[NORMAL_DIFF] = {
				{ 1, 21493 },	-- Boots of the Vanguard
				{ 2, 21492 },	-- Manslayer of the Qiraji
				{ 4, 21496 },	-- Bracers of Qiraji Command
				{ 5, 21494 },	-- Southwind's Grasp
				{ 6, 21497 },	-- Boots of the Qiraji General
				{ 7, 21495 },	-- Legplates of the Qiraji Command
				{ 9, "INV_Box_01", nil, AL["Rajaxx's Captains"], nil },
				{ 10, 21810 },	-- Treads of the Wandering Nomad
				{ 11, 21809 },	-- Fury of the Forgotten Swarm
				{ 12, 21806 },	-- Gavel of Qiraji Authority
				{ 16, 20889 },	-- Qiraji Regal Drape
				{ 17, 20885 },	-- Qiraji Martial Drape
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, "INV_Box_01", nil, BB["Lieutenant General Andorov"], nil },
				{ 22, 22221, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Obsidian Mail Tunic
				{ 23, 22219, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Jagged Obsidian Shield
			},
		},
		{	--AQ20Moam
			--name = BB["Moam"],
			EncounterJournalID = 1539,
			[NORMAL_DIFF] = {
				{ 1, 21472 },	-- Dustwind Turban
				{ 2, 21467 },	-- Thick Silithid Chestguard
				{ 3, 21479 },	-- Gauntlets of the Immovable
				{ 4, 21471 },	-- Talon of Furious Concentration
				{ 6, 21470 },	-- Cloak of the Savior
				{ 7, 21468 },	-- Mantle of Maz'Nadir
				{ 8, 21455 },	-- Southwind Helm
				{ 9, 21474 },	-- Chitinous Shoulderguards
				{ 10, 21469 },	-- Gauntlets of Southwind
				{ 11, 21476 },	-- Obsidian Scaled Leggings
				{ 12, 21475 },	-- Legplates of the Destroyer
				{ 13, 21477 },	-- Ring of Fury
				{ 14, 21473 },	-- Eye of Moam
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, 22220, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Black Grasp of the Destroyer
				{ 22, 22194 },	-- Black Grasp of the Destroyer
			},
		},
		{	--AQ20Buru
			--name = BB["Buru the Gorger"],
			EncounterJournalID = 1540,
			[NORMAL_DIFF] = {
				{ 1, 21487 },	-- Slimy Scaled Gauntlets
				{ 2, 21486 },	-- Gloves of the Swarm
				{ 3, 21485 },	-- Buru's Skull Fragment
				{ 5, 21489 },	-- Quicksand Waders
				{ 6, 21491 },	-- Scaled Bracers of the Gorger
				{ 7, 21490 },	-- Slime Kickers
				{ 8, 21488 },	-- Fetish of Chitinous Spikes
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20889 },	-- Qiraji Regal Drape
				{ 19, 20885 },	-- Qiraji Martial Drape
				{ 20, 20884 },	-- Qiraji Magisterial Ring
				{ 21, 20888 },	-- Qiraji Ceremonial Ring
			},
		},
		{	--AQ20Ayamiss
			--name = BB["Ayamiss the Hunter"],
			EncounterJournalID = 1541,
			[NORMAL_DIFF] = {
				{ 1, 21479 },	-- Gauntlets of the Immovable
				{ 2, 21466 },	-- Stinger of Ayamiss
				{ 3, 21478 },	-- Bow of Taut Sinew
				{ 5, 21484 },	-- Helm of Regrowth
				{ 6, 21480 },	-- Scaled Silithid Gauntlets
				{ 7, 21482 },	-- Boots of the Fiery Sands
				{ 8, 21481 },	-- Boots of the Desert Protector
				{ 9, 21483 },	-- Ring of the Desert Winds
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20889 },	-- Qiraji Regal Drape
				{ 19, 20885 },	-- Qiraji Martial Drape
				{ 20, 20884 },	-- Qiraji Magisterial Ring
				{ 21, 20888 },	-- Qiraji Ceremonial Ring
			},
		},
		{	--AQ20Ossirian
			--name = BB["Ossirian the Unscarred"],
			EncounterJournalID = 1542,
			[NORMAL_DIFF] = {
				{ 1, 21456 },	-- Sandstorm Cloak
				{ 2, 21464 },	-- Shackles of the Unscarred
				{ 3, 21462 },	-- Gloves of Dark Wisdom
				{ 4, 21461 },	-- Leggings of the Black Blizzard
				{ 5, 21458 },	-- Gauntlets of New Life
				{ 6, 21454 },	-- Runic Stone Shoulders
				{ 7, 21463 },	-- Ossirian's Binding
				{ 8, 21460 },	-- Helm of Domination
				{ 9, 21453 },	-- Mantle of the Horusath
				{ 10, 21457 },	-- Bracers of Brutality
				{ 11, 21715 },	-- Sand Polished Hammer
				{ 12, 21459 },	-- Crossbow of Imminent Doom
				{ 13, 21452 },	-- Staff of the Ruins
				{ 16, 21220 },	-- Head of Ossirian the Unscarred
				{ 17, 21504 },	-- Charm of the Shifting Sands
				{ 18, 21507 },	-- Amulet of the Shifting Sands
				{ 19, 21505 },	-- Choker of the Shifting Sands
				{ 20, 21506 },	-- Pendant of the Shifting Sands
				{ 22, 20886 },	-- Qiraji Spiked Hilt
				{ 23, 20890 },	-- Qiraji Ornate Hilt
				{ 24, 20884 },	-- Qiraji Magisterial Ring
				{ 25, 20888 },	-- Qiraji Ceremonial Ring
				{ 27, "ac689" },
			},
		},
		{	--AQ20Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 20873 },	-- Alabaster Idol
				{ 2, 20869 },	-- Amber Idol
				{ 3, 20866 },	-- Azure Idol
				{ 4, 20870 },	-- Jasper Idol
				{ 5, 20868 },	-- Lambent Idol
				{ 6, 20871 },	-- Obsidian Idol
				{ 7, 20867 },	-- Onyx Idol
				{ 8, 20872 },	-- Vermillion Idol
				{ 10, 22202 },	-- Small Obsidian Shard
				{ 11, 22203 },	-- Large Obsidian Shard
				{ 16, 20864 },	-- Bone Scarab
				{ 17, 20861 },	-- Bronze Scarab
				{ 18, 20863 },	-- Clay Scarab
				{ 19, 20862 },	-- Crystal Scarab
				{ 20, 20859 },	-- Gold Scarab
				{ 21, 20865 },	-- Ivory Scarab
				{ 22, 20860 },	-- Silver Scarab
				{ 23, 20858 },	-- Stone Scarab
			},
		},
		{	--AQ20Sets
			name = ALIL["Ruins of Ahn'Qiraj"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:2",
		},
		{	--AQEnchants
			name = AL["AQ Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = AQ_ENCHANTS,
		},
		{	--CenarionCircle
			FactionID = 609,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:CLASSICFACTIONS:4",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

--[[
data["Naxxramas"] = {
	name = ALIL["Naxxramas"],
	MapID = 535,
--	AtlasMapID = "",
	ContentType = REMOVED_CONTENT,
	LoadDifficulty = REMOVED_DIFF,
	TableType = REMOVED_ITTYPE,
	items = {
		{	--Naxx80AnubRekhan
			name = BB["Anub'Rekhan"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 27.61 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22369, 28.57 }, -- Desecrated Bindings
				{ 5, 22362, 31.3 }, -- Desecrated Wristguards
				{ 6, 22355, 29.53 }, -- Desecrated Bracers
				{ 8, 22938, 20.39 }, -- Cryptfiend Silk Cloak
				{ 9, 22936, 16.85 }, -- Wristguards of Vengeance
				{ 10, 22937, 15.09 }, -- Gem of Nerubis
				{ 11, 22939, 16.85 }, -- Band of Unanswered Prayers
				{ 12, 22935, 13.32 }, -- Touch of Frost
			},
		},
		{	--Naxx80Faerlina
			name = BB["Grand Widow Faerlina"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 19.01 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22369, 25.22 }, -- Desecrated Bindings
				{ 5, 22362, 24.59 }, -- Desecrated Wristguards
				{ 6, 22355, 35.74 }, -- Desecrated Bracers
				{ 8, 22941, 14.96 }, -- Polar Shoulder Pads
				{ 9, 22940, 21.55 }, -- Icebane Pauldrons
				{ 10, 22806, 14.45 }, -- Widow's Remorse
				{ 11, 22942, 21.67 }, -- The Widow's Embrace
				{ 12, 22943, 17.49 }, -- Malice Stone Pendant
			},
		},
		{	--Naxx80Maexxna
			name = BB["Maexxna"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 11.13 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22371, 44.26 }, -- Desecrated Gloves
				{ 5, 22364, 49.03 }, -- Desecrated Handguards
				{ 6, 22357, 90.8 }, -- Desecrated Gauntlets
				{ 8, 23220, 11.34 }, -- Crystal Webbed Robe
				{ 9, 22804, 18.05 }, -- Maexxna's Fang
				{ 10, 22807, 14.25 }, -- Wraith Blade
				{ 11, 22947, 31.88 }, -- Pendant of Forgotten Names
				{ 12, 22954, 11.62 }, -- Kiss of the Spider
			},
		},
		{	--Naxx80Noth
			name = BB["Noth the Plaguebringer"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 13.07 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22370, 26.23 }, -- Desecrated Belt
				{ 5, 22363, 32.67 }, -- Desecrated Girdle
				{ 6, 22356, 29.66 }, -- Desecrated Waistguard
				{ 8, 23030, 13.33 }, -- Cloak of the Scourge
				{ 9, 22816, 15.99 }, -- Hatchet of Sundered Bone
				{ 10, 23005, 3.01 }, -- Totem of Flowing Water
				{ 11, 23006, 14.36 }, -- Libram of Light
				{ 12, 23029, 11.09 }, -- Noth's Frigid Heart
				{ 13, 23031, 12.9 }, -- Band of the Inevitable
				{ 14, 23028, 13.59 }, -- Hailstone Band
			},
		},
		{	--Naxx80Heigan
			name = BB["Heigan the Unclean"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22370 }, -- Desecrated Belt
				{ 5, 22363 }, -- Desecrated Girdle
				{ 6, 22356 }, -- Desecrated Waistguard
				{ 8, 23035 }, -- Preceptor's Hat
				{ 9, 23033 }, -- Icy Scale Coif
				{ 10, 23019 }, -- Icebane Helmet
				{ 11, 23068 }, -- Legplates of Carnage
				{ 12, 23036 }, -- Necklace of Necropsy
			},
		},
		{	--Naxx80Loatheb
			name = BB["Loatheb"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22366 }, -- Desecrated Leggings
				{ 5, 22359 }, -- Desecrated Legguards
				{ 6, 22352 }, -- Desecrated Legplates
				{ 8, 23039 }, -- The Eye of Nerub
				{ 9, 22800 }, -- Brimstone Staff
				{ 10, 23037 }, -- Ring of Spiritual Fervor
				{ 11, 23038 }, -- Band of Unnatural Forces
				{ 12, 23042 }, -- Loatheb's Reflection
			},
		},
		{	--Naxx80Razuvious
			name = BB["Instructor Razuvious"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 24.39 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22372, 27.64 }, -- Desecrated Sandals
				{ 5, 22365, 31.1 }, -- Desecrated Boots
				{ 6, 22358, 26.02 }, -- Desecrated Sabatons
				{ 8, 23017, 19.31 }, -- Veil of Eclipse
				{ 9, 23219, 8.74 }, -- Girdle of the Mentor
				{ 10, 23014, 9.35 }, -- Iblis, Blade of the Fallen Seraph
				{ 11, 23009, 12.8 }, -- Wand of the Whispering Dead
				{ 12, 23004, 17.68 }, -- Idol of Longevity
				{ 13, 23018, 19.31 }, -- Signet of the Fallen Defender
			},
		},
		{	--Naxx80Gothik
			name = BB["Gothik the Harvester"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22372 }, -- Desecrated Sandals
				{ 5, 22365 }, -- Desecrated Boots
				{ 6, 22358 }, -- Desecrated Sabatons
				{ 8, 23032 }, -- Glacial Headdress
				{ 9, 23021 }, -- The Soul Harvester's Bindings
				{ 10, 23020 }, -- Polar Helmet
				{ 11, 23073 }, -- Boots of Displacement
				{ 12, 23023 }, -- Sadist's Collar
			},
		},
		{	--Naxx80FourHorsemen
			name = BB["The Four Horsemen"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22351 }, -- Desecrated Robe
				{ 5, 22350 }, -- Desecrated Tunic
				{ 6, 22349 }, -- Desecrated Breastplate
				{ 8, 23071 }, -- Leggings of Apocalypse
				{ 9, 22809 }, -- Maul of the Redeemed Crusader
				{ 10, 22691 }, -- Corrupted Ashbringer
				{ 11, 22811 }, -- Soulstring
				{ 12, 23025 }, -- Seal of the Damned
				{ 13, 23027 }, -- Warmth of Forgiveness
			},
		},
		{	--Naxx80Patchwerk
			name = BB["Patchwerk"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 11.39 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22368, 21.33 }, -- Desecrated Shoulderpads
				{ 5, 22361, 36.65 }, -- Desecrated Spaulders
				{ 6, 22354, 28.78 }, -- Desecrated Pauldrons
				{ 8, 22960, 12.84 }, -- Cloak of Suturing
				{ 9, 22815, 16.15 }, -- Severance
				{ 10, 22820, 23.19 }, -- Wand of Fates
				{ 11, 22818, 15.53 }, -- The Plague Bearer
				{ 12, 22961, 22.15 }, -- Band of Reanimation
			},
		},
		{	--Naxx80Grobbulus
			name = BB["Grobbulus"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22368 }, -- Desecrated Shoulderpads
				{ 5, 22361 }, -- Desecrated Spaulders
				{ 6, 22354 }, -- Desecrated Pauldrons
				{ 8, 22968 }, -- Glacial Mantle
				{ 9, 22967 }, -- Icy Scale Spaulders
				{ 10, 22803 }, -- Midnight Haze
				{ 11, 22988 }, -- The End of Dreams
				{ 12, 22810 }, -- Toxin Injector
			},
		},
		{	--Naxx80Gluth
			name = BB["Gluth"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22983 }, -- Rime Covered Mantle
				{ 5, 22813 }, -- Claymore of Unholy Might
				{ 6, 23075 }, -- Death's Bargain
				{ 7, 22994 }, -- Digested Hand of Power
				{ 8, 22981 }, -- Gluth's Missing Collar
				{ 16, 22368 }, -- Desecrated Shoulderpads
				{ 17, 22361 }, -- Desecrated Spaulders
				{ 18, 22354 }, -- Desecrated Pauldrons
				{ 19, 22369 }, -- Desecrated Bindings
				{ 20, 22362 }, -- Desecrated Wristguards
				{ 21, 22355 }, -- Desecrated Bracers
				{ 22, 22370 }, -- Desecrated Belt
				{ 23, 22363 }, -- Desecrated Girdle
				{ 24, 22356 }, -- Desecrated Waistguard
				{ 25, 22372 }, -- Desecrated Sandals
				{ 26, 22365 }, -- Desecrated Boots
				{ 27, 22358 }, -- Desecrated Sabatons
			},
		},
		{	--Naxx80Thaddius
			name = BB["Thaddius"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22367 }, -- Desecrated Circlet
				{ 5, 22360 }, -- Desecrated Headpiece
				{ 6, 22353 }, -- Desecrated Helmet
				{ 8, 23070 }, -- Leggings of Polarity
				{ 9, 23000 }, -- Plated Abomination Ribcage
				{ 10, 22808 }, -- The Castigator
				{ 11, 22801 }, -- Spire of Twilight
				{ 12, 23001 }, -- Eye of Diminution
			},
		},
		{	--Naxx80Sapphiron
			name = BB["Sapphiron"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 23050 }, -- Cloak of the Necropolis
				{ 2, 23045 }, -- Shroud of Dominion
				{ 3, 23072 }, -- Fists of the Unrelenting
				{ 4, 23043 }, -- The Face of Death
				{ 5, 23242 }, -- Claw of the Frost Wyrm
				{ 6, 23049 }, -- Sapphiron's Left Eye
				{ 7, 23048 }, -- Sapphiron's Right Eye
				{ 8, 23040 }, -- Glyph of Deflection
				{ 9, 23047 }, -- Eye of the Dead
				{ 10, 23046 }, -- The Restrained Essence of Sapphiron
				{ 11, 23041 }, -- Slayer's Crest
				{ 16, 23545 }, -- Power of the Scourge
				{ 17, 23547 }, -- Resilience of the Scourge
				{ 18, 23549 }, -- Fortitude of the Scourge
				{ 19, 23548 }, -- Might of the Scourge
			},
		},
		{	--Naxx80KelThuzad
			name = BB["Kel'Thuzad"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22802 }, -- Kingsfall
				{ 2, 23054 }, -- Gressil, Dawn of Ruin
				{ 3, 23577 }, -- The Hungering Cold
				{ 4, 23056 }, -- Hammer of the Twisting Nether
				{ 5, 22798 }, -- Might of Menethil
				{ 6, 22799 }, -- Soulseeker
				{ 7, 22821 }, -- Doomfinger
				{ 8, 22812 }, -- Nerubian Slavemaker
				{ 9, 22819 }, -- Shield of Condemnation
				{ 10, 23057 }, -- Gem of Trapped Innocents
				{ 11, 23053 }, -- Stormrage's Talisman of Seething
				{ 13, 22520, 100 }, -- The Phylactery of Kel'Thuzad
				{ 14, 23207 }, -- Mark of the Champion
				{ 15, 23206 }, -- Mark of the Champion
				{ 16, 23064 }, -- Ring of the Dreamwalker
				{ 17, 23067 }, -- Ring of the Cryptstalker
				{ 18, 23062 }, -- Frostfire Ring
				{ 19, 23066 }, -- Ring of Redemption
				{ 20, 23061 }, -- Ring of Faith
				{ 21, 23060 }, -- Bonescythe Ring
				{ 22, 23065 }, -- Ring of the Earthshatterer
				{ 23, 23063 }, -- Plagueheart Ring
				{ 24, 23059 }, -- Ring of the Dreadnaught
				{ 26, 22733 }, -- Staff Head of Atiesh
				{ 27, 22632 }, -- Atiesh, Greatstaff of the Guardian
				{ 28, 22589 }, -- Atiesh, Greatstaff of the Guardian
				{ 29, 22631 }, -- Atiesh, Greatstaff of the Guardian
				{ 30, 22630 }, -- Atiesh, Greatstaff of the Guardian
			},
		},
		{	--Naxx80Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 23069 }, -- Necro-Knight's Garb
				{ 2, 23226 }, -- Ghoul Skin Tunic
				{ 3, 23663 }, -- Girdle of Elemental Fury
				{ 4, 23664 }, -- Pauldrons of Elemental Fury
				{ 5, 23665 }, -- Leggings of Elemental Fury
				{ 6, 23666 }, -- Belt of the Grand Crusader
				{ 7, 23667 }, -- Spaulders of the Grand Crusader
				{ 8, 23668 }, -- Leggings of the Grand Crusader
				{ 9, 23044 }, -- Harbinger of Doom
				{ 10, 23221 }, -- Misplaced Servo Arm
				{ 11, 23238 }, -- Stygian Buckler
				{ 12, 23237 }, -- Ring of the Eternal Flame
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 22708 }, -- Fate of Ramaladni
				{ 22, 23055 }, -- Word of Thawing
			},
		},
		{	--Tier 3 Sets
			name = format(AL["Tier %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:7",
			[REMOVED_DIFF] = "AtlasLoot_Collections:TIERSETS:3:n",
		},
		{	-- WOTLK_RAID1_10_AC_TABLE
			name = select(2, GetAchievementInfo(2137)),
			ExtraList = true,
			TableType = AC_ITTYPE,
			CoinTexture = "Achievement",
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
		},
		{	-- WOTLK_RAID1_25_AC_TABLE
			name = select(2, GetAchievementInfo(2138)),
			ExtraList = true,
			TableType = AC_ITTYPE,
			CoinTexture = "Achievement",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
		},
	}
}
]]
]=]--
