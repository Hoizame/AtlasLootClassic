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
				{1, 80719},	-- Flask of Steelskin
				{2, 80720},	-- Flask of the Draconic Mind
				{3, 80721},	-- Flask of the Winds
				{4, 80723},	-- Flask of the Frost Wyrm
				{5, 94162},	-- Flask of Flowing Water
                {7, 92643}, -- Cauldron of Battle
                {8, 92688}, -- Big Cauldron of Battle
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{1, 80245}, -- Transmute: Inferno Ruby
                {2, 80246}, -- Transmute: Ocean Sapphire
                {3, 80247}, -- Transmute: Amberjewel
                {4, 80248}, -- Transmute: Demonseye
                {5, 80250}, -- Transmute: Ember Topaz
                {6, 80251}, -- Transmute: Dream Emerald
				{8, 80237}, -- Transmute: Shadowspirit Diamond
                {10, 80243}, -- Transmute: Truegold
                {11, 80244}, -- Transmute: Pyrium Bar
				{16, 78866}, -- Transmute: Living Elements
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
		        {1, 80498}, -- Mythical Healing Potion
                {2, 80494}, -- Mythical Mana Potion
                {3, 80490}, -- Mighty Rejuvenation Potion
                {4, 93935}, -- Draught of War
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
                {1, 80492}, -- Prismatic Elixir
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
                {1, 80478}, -- Earthen Potion
                {2, 80481}, -- Volcanic Potion
                {3, 80482}, -- Potion of Concentration
                {4, 80487}, -- Mysterious Potion
                {5, 80495}, -- Potion of the Tol'vir
                {6, 80496}, -- Golemblood Potion
			},
		},
		{
			name = AL["Elixirs"],
			[NORMAL_DIFF] = {
                {1, 80477}, -- Ghost Elixir
                {2, 80479}, -- Deathblood Venom
                {3, 80480}, -- Elixir of the Naga
                {4, 80484}, -- Elixir of the Cobra
                {5, 80488}, -- Elixir of Deep Earth
                {6, 80491}, -- Elixir of Impossible Accuracy
                {7, 80493}, -- Elixir of Mighty Speed
                {8, 80497}, -- Elixir of the Master
			},
		},
		{
			name = AL["Stones"],
			[NORMAL_DIFF] = {
                {1, 80508}, -- Lifebound Alchemist Stone
                {2, 96252}, -- Volatile Alchemist Stone
                {3, 96253}, -- Quicksilver Alchemist Stone
                {4, 96254}, -- Vibrant Alchemist Stone
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 80724}, -- Flask of Enhancement
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{1, 93328}, -- Vial of the Sands

                {3, 80269}, -- Potion of Illusion
                {4, 80725}, -- Potion of Deepholm
                {5, 80726}, -- Potion of Treasure Finding
				{7, 80486}, -- Deepstone Oil
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
				{ 1, 76434 }, -- Cold Forged Shank
				{ 2, 76453 }, -- Elementium Shank	
				{ 3, 99652 }, -- Brainsplinter	
			}
		},
		{ -- Axes
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 76433 },	-- Decapitator's Razor
				{ 3, 94718 },	-- Elementium Gutslicer
				{ 4, 76452 },	-- Elementium Bonesplitter 
				{ 5, 99655 },   -- Elementium-Edged Scalper
			}
		},
		{ -- Maces
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 76436 }, -- Lifeforce Hammer	
				{ 3, 76450 }, -- Elementium Hammer
				{ 4, 99654 }, -- Lightforged Elementium Hammer
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
				{ 17, 76437 }, -- Obsidian Executioner 
				{ 18, 99658 }, -- Masterwork Elementium Deathblade
			}
		},
		{ -- Polearms
			name = AL["Weapons"].." - "..AL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_06", nil, ALIL["Polearms"] },
				{ 2, 76474 }, -- Obsidium Bladespear
				{ 3, 76451 }, -- Elementium Poleaxe
				{ 4, 99660 }, -- Witch Hunter's Harvester
				
			}
		},		
		{ -- Shield
			name = AL["Weapons"].." - "..ALIL["Shield"],
			[NORMAL_DIFF] = {
				{ 1, 76291 }, -- Hardened Obsidium Shield	
				{ 2, 76293 }, -- Stormforged Shield 	
				{ 3, 76455 }, -- Elementium Stormshield	 
				{ 4, 76454 }, -- Elementium Earthguard	
			}
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[PLATE_DIFF] = {
				{ 1, 76260 },	-- Hardened Obsidium Helm
				{ 2, 76288 },	-- Stormforged Helm
				{ 3, 76269 },	-- Redsteel Helm
				{ 4,76471 },	-- Vicious Ornate Pyrium Helm
				{ 5, 76463 },	-- Vicious Pyrium Helm
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[PLATE_DIFF] = {
				{ 1, 76266 },	-- Redsteel Shoulders
				{ 2, 76258 },	-- Hardened Obsidium Shoulders
				{ 3, 76286 },	-- Stormforged Shoulders
				{ 4, 76469 },	-- Vicious Ornate Pyrium Shoulders
				{ 5, 76461 },	-- Vicious Pyrium Shoulders
			},
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[PLATE_DIFF] = {
				{ 1, 76261 },	-- Hardened Obsidium Breastplate
				{ 2, 76289 },	-- Stormforged Breastplate
				{ 3, 76270 },	-- Redsteel Breastplate
				{ 4, 76447 },	-- Light Elementium Chestguard
				{ 5, 76445 },	-- Elementium Deathplate
				{ 6, 76443 },	-- Hardened Elementium Hauberk
				{ 7, 76464 },	-- Vicious Pyrium Breastplate
				{ 8, 76472 },	-- Vicious Ornate Pyrium Breastplate
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[PLATE_DIFF] = {
				{ 1, 76182 }, -- Hardened Obsidium Boots 	 
				{ 2, 76285 }, -- Stormforged Boots
				{ 3, 76265 }, -- Redsteel Boots	
				{ 4, 76468 }, -- Vicious Ornate Pyrium Boots	
				{ 5, 76459 }, -- Vicious Pyrium Boots
				{ 6, 99454 }, -- Emberforged Elementium Boots
				{ 7, 99453 }, -- Mirrored Boots	
				{ 8, 99452 }, -- Warboots of Mighty Lords	
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[PLATE_DIFF] = {
				{ 1, 76263 }, -- Redsteel Gauntlets
				{ 2, 76180 }, -- Hardened Obsidium Gauntlets 	
				{ 3, 76281 }, -- Stormforged Gauntlets 	
				{ 4, 76457 }, -- Vicious Pyrium Gauntlets 	
				{ 5, 76466 }, -- Vicious Ornate Pyrium Gauntlets 	
				{ 6, 99441 }, -- Holy Flame Gauntlets 
				{ 7, 99440 }, -- Eternal Elementium Handguards	
				{ 8, 99439 }, -- Fists of Fury	
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[PLATE_DIFF] = {
				{ 1, 76259 }, -- Hardened Obsidium Legguards	
				{ 2, 76287 }, -- Stormforged Legguards	
				{ 3, 76267 }, -- Redsteel Legguards	
				{ 4,76462 }, -- Vicious Pyrium Legguards	
				{ 5, 76470 }, -- Vicious Ornate Pyrium Legguards	
				{ 6, 101928 }, -- Foundations of Courage
				{ 7, 101925 }, -- Unstoppable Destroyer's Legplates				
				{ 8, 101924 }, -- Pyrium Legplates of Purified Evil				
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[PLATE_DIFF] = {
				{ 1, 76181 }, -- Hardened Obsidium Belt				
				{ 2, 76283 }, -- Stormforged Belt				
				{ 3, 76264 }, -- Redsteel Belt				
				{ 4, 76448 }, -- Light Elementium Belt				
				{ 5, 76446 }, -- Elementium Girdle of Pain	 			
				{ 6, 76444 }, -- Hardened Elementium Girdle				
				{ 7, 76458 }, -- Vicious Pyrium Belt
				{ 8, 76467 }, -- Vicious Ornate Pyrium Belt
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[PLATE_DIFF] = {
				{ 1, 76280 }, -- Stormforged Bracers
				{ 2, 76262 }, -- Redsteel Bracers
				{ 3, 76179 }, -- Hardened Obsidium Bracers
				{ 4, 76465 }, -- Vicious Ornate Pyrium Bracers
				{ 5, 76456 }, -- Vicious Pyrium Bracers 
				{ 6, 101932 }, -- Titanguard Wristplates	
				{ 7, 101931 }, -- Bracers off DEstructive Strength	 
				{ 8, 101929 }, -- Soul Redeemer Bracers	 
			},
		},
		{ -- Enhancements
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 76439 }, -- Ebonsteel Belt Buckle
				{ 16, 76440 }, -- Pyrium Shield Spike
				{ 18, 76442 }, -- Pyrium Weapon Chain	
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
				{1, 74197}, -- Enchant Weapon - Avalanche
				{2, 74211}, -- Enchant Weapon - Elemental Slayer
				{3, 74225}, -- Enchant Weapon - Heartsong
				{4, 74223}, -- Enchant Weapon - Hurricane
				{5, 74246}, -- Enchant Weapon - Landslide
				{6, 74195}, -- Enchant Weapon - Mending
				{7, 74242}, -- Enchant Weapon - Power Torrent
				{8, 74244}, -- Enchant Weapon - Windwalk
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 95471}, -- Enchant 2H Weapon - Mighty Agility
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74230}, -- Enchant Cloak - Critical Strike
				{2, 74247}, -- Enchant Cloak - Greater Critical Strike
				{3, 74240}, -- Enchant Cloak - Greater Intellect
				{4, 74192}, -- Enchant Cloak - Greater Spell Piercing
				{5, 74202}, -- Enchant Cloak - Intellect
				{6, 74234}, -- Enchant Cloak - Protection
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74231}, -- Enchant Chest - Exceptional Spirit
				{2, 74251}, -- Enchant Chest - Greater Stamina
				{3, 74214}, -- Enchant Chest - Mighty Resilience
				{4, 74191}, -- Enchant Chest - Mighty Stats
				{5, 74250}, -- Enchant Chest - Peerless Stats
				{6, 74200}, -- Enchant Chest - Stamina
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74252}, -- Enchant Boots - Assassin's Step
				{2, 74189}, -- Enchant Boots - Earthen Vitality
				{3, 74199}, -- Enchant Boots - Haste
				{4, 74253}, -- Enchant Boots - Lavawalker
				{5, 74213}, -- Enchant Boots - Major Agility
				{6, 74238}, -- Enchant Boots - Mastery
				{7, 74236}, -- Enchant Boots - Precision
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74212}, -- Enchant Gloves - Exceptional Strength
				{2, 74220}, -- Enchant Gloves - Greater Expertise
				{3, 74255}, -- Enchant Gloves - Greater Mastery
				{4, 74198}, -- Enchant Gloves - Haste
				{5, 74132}, -- Enchant Gloves - Mastery
				{6, 74254}, -- Enchant Gloves - Mighty Strength
			}
		},
		{
			name = ALIL["Off-Hand/Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74235}, -- Enchant Off-Hand - Superior Intellect
				{3, 74226}, -- Enchant Shield - Mastery
				{4, 74207}, -- Enchant Shield - Protection
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 96264}, -- Enchant Bracer - Agility
				{2, 74201}, -- Enchant Bracer - Critical Strike
				{3, 74237}, -- Enchant Bracer - Exceptional Spirit
				{4, 74248}, -- Enchant Bracer - Greater Critical Strike
				{5, 74239}, -- Enchant Bracer - Greater Expertise
				{6, 74256}, -- Enchant Bracer - Greater Speed
				{7, 96261}, -- Enchant Bracer - Major Strength
				{8, 96262}, -- Enchant Bracer - Mighty Intellect
				{9, 74232}, -- Enchant Bracer - Precision
				{10, 74193}, -- Enchant Bracer - Speed
				{11, 74229}, -- Enchant Bracer - Superior Dodge
			}
		},
		{
			name = AL["Ring"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{1, 74216}, -- Enchant Ring - Agility
				{2, 74218}, -- Enchant Ring - Greater Stamina
				{3, 74217}, -- Enchant Ring - Intellect
				{4, 74215}, -- Enchant Ring - Strength
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{1, 92370}, -- Runed Elementium Rod
				{3, 104698}, -- Maelstrom Shatter
				{5, 93841}, -- Enchanted Lantern
				{6, 93843}, -- Magic Lamp

			}
		},
	}
}

--[[
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
				{ 1, 56484 },	-- Visage Liquification Goggles
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 56486 },	-- Greensight Gogs
				{ 2, 56481 },	-- Weakness Spectralizers
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 56487 },	-- Electroflux Sight Enhancers
				{ 2, 56574 },	-- Truesight Ice Blinders
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 56480 },	-- Armored Titanium Goggles
				{ 2, 56483 },	-- Charged Titanium Specs
				{ 3, 62271 },	-- Unbreakable Healing Amplifiers
				{ 16, 61483 },	-- Mechanized Snow Goggles
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 56469 },	-- Gnomish Lightning Generator
				{ 2, 56467 },	-- Noise Machine
				{ 3, 56466 },	-- Sonic Booster
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 56478 },	-- Heartseeker Scope
				{ 2, 56470 },	-- Sun Scope
				{ 3, 61471 },	-- Diamond-Cut Refractor Scope
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 56479 },	-- Armor Plated Combat Shotgun
				{ 2, 60874 },	-- Nesingwary 4000
				{ 3, 54353 },	-- Mark "S" Boomstick
			}
		},
		{
			name = ALIL["Projectile"],
			[NORMAL_DIFF] = {
				{ 1, 72953 },	-- Iceblade Arrow
				{ 2, 56475 },	-- Saronite Razorheads
				{ 16, 72952 },	-- Shatter Rounds
				{ 17, 56474 },	-- Mammoth Cutters
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 56471 },	-- Froststeel Tube
				{ 2, 56464 },	-- Overcharged Capacitor
				{ 3, 56349 },	-- Handful of Cobalt Bolts
				{ 4, 53281 },	-- Volatile Blasting Trigger
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 56514 },	-- Global Thermal Sapper Charge
				{ 3, 56463 },	-- Explosive Decoy
				{ 4, 56460 },	-- Cobalt Frag Bomb
				{ 16, 56468 },	-- Box of Bombs
				{ 17, "i44951" }
			}
		},
		{
			name = ALIL["Engineering"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 54999 },	-- Hyperspeed Accelerators
				{ 2, 54998 },	-- Hand-Mounted Pyro Rocket
				{ 3, 63770 },	-- Reticulated Armor Webbing
				{ 5, 55016 },	-- Nitro Boosts
				{ 16, 54736 },	-- Personal Electromagnetic Pulse Generator
				{ 17, 54793 },	-- Frag Belt
				{ 19, 55002 },	-- Flexweave Underlay
				{ 20, 63765 },	-- Springy Arachnoweave
				{ 22, 67839 },	-- Mind Amplification Dish
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,   [ATLASLOOT_IT_ALLIANCE] = { 60867 }, [ATLASLOOT_IT_HORDE] = { 60866 } }, -- Mekgineer's Chopper / Mechano-Hog
				{ 3, 56476 },	-- Healing Injector Kit
				{ 4, 56477 },	-- Mana Injector Kit
				{ 6, 56461 },	-- Bladed Pickaxe
				{ 7, 56459 },	-- Hammer Pick
				{ 9, 55252 },	-- Scrapbot Construction Kit
				{ 11, 56462 },	-- Gnomish Army Knife
				{ 13, 67326 },	-- Goblin Beam Welder
				{ 16, 68067 },	-- Jeeves
				{ 18, 56472 },	-- MOLL-E
				{ 20, 67920 },	-- Wormhole Generator: Northrend
				{ 22, 30349 },	-- Titanium Toolbox
				{ 24, 56473 },	-- Gnomish X-Ray Specs
			}
		},
	}
}

data["TailoringWrath"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 56017 },	-- Deathchill Cloak
				{ 2, 56016 },	-- Wispcloak
				{ 3, 64730 },	-- Cloak of Crimson Snow
				{ 4, 64729 },	-- Frostguard Drape
				{ 5, 56015 },	-- Cloak of Frozen Spirits
				{ 6, 56014 },	-- Cloak of the Moon
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 56018 },	-- Hat of Wintry Doom
				{ 2, 59589 },	-- Frostsavage Cowl
				{ 3, 55919 },	-- Duskweave Cowl
				{ 4, 55907 },	-- Frostwoven Cowl
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 59584 },	-- Frostsavage Shoulders
				{ 2, 55910 },	-- Mystic Frostwoven Shoulders
				{ 3, 55923 },	-- Duskweave Shoulders
				{ 4, 55902 },	-- Frostwoven Shoulders
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67066 }, [ATLASLOOT_IT_HORDE] = { 67146 } },	-- Merlin's Robe
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67064 }, [ATLASLOOT_IT_HORDE] = { 67144 } },	-- Royal Moonshroud Robe
				{ 3, 56026 },	-- Ebonweave Robe
				{ 4, 56024 },	-- Moonshroud Robe
				{ 5, 56028 },	-- Spellweave Robe
				{ 6, 60993 },	-- Glacial Robe
				{ 7, 59587 },	-- Frostsavage Robe
				{ 8, 55941 },	-- Black Duskweave Robe
				{ 9, 55911 },	-- Mystic Frostwoven Robe
				{ 10, 55921 },	-- Duskweave Robe
				{ 11, 55903 },	-- Frostwoven Robe
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 70551 },	-- Deathfrost Boots
				{ 2, 70553 },	-- Sandals of Consecration
				{ 3, 63206 },	-- Savior's Slippers
				{ 4, 63204 },	-- Spellslinger's Slippers
				{ 5, 60994 },	-- Glacial Slippers
				{ 6, 56023 },	-- Aurora Slippers
				{ 7, 59585 },	-- Frostsavage Boots
				{ 8, 56019 },	-- Silky Iceshard Boots
				{ 9, 55924 },	-- Duskweave Boots
				{ 10, 55906 },	-- Frostwoven Boots
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 56027 },	-- Ebonweave Gloves
				{ 2, 56025 },	-- Moonshroud Gloves
				{ 3, 56029 },	-- Spellweave Gloves
				{ 4, 59586 },	-- Frostsavage Gloves
				{ 5, 56022 },	-- Light Blessed Mittens
				{ 6, 55922 },	-- Duskweave Gloves
				{ 7, 55904 },	-- Frostwoven Gloves
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 70550 },	-- Leggings of Woven Death
				{ 2, 70552 },	-- Lightweave Leggings
				{ 3, 56021 },	-- Frostmoon Pants
				{ 4, 59588 },	-- Frostsavage Leggings
				{ 5, 55925 },	-- Black Duskweave Leggings
				{ 6, 55901 },	-- Duskweave Leggings
				{ 7, 56030 },	-- Frostwoven Leggings
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 63205 },	-- Cord of the White Dawn
				{ 2, 63203 },	-- Sash of Ancient Power
				{ 3, 60990 },	-- Glacial Waistband
				{ 4, 56020 },	-- Deep Frozen Cord
				{ 5, 59582 },	-- Frostsavage Belt
				{ 6, 55914 },	-- Duskweave Belt
				{ 7, 55908 },	-- Frostwoven Belt
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67079 }, [ATLASLOOT_IT_HORDE] = { 67145 } },	-- Bejeweled Wizard's Bracers
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67065 }, [ATLASLOOT_IT_HORDE] = { 67147 } },	-- Royal Moonshroud Bracers
				{ 3, 55943 },	-- Black Duskweave Wristwraps
				{ 4, 59583 },	-- Frostsavage Bracers
				{ 5, 55913 },	-- Mystic Frostwoven Wriststraps
				{ 6, 55920 },	-- Duskweave Wriststraps
				{ 7, 56031 },	-- Frostwoven Wriststraps
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 56005 },	-- Glacial Bag
				{ 2, 56007 },	-- Frostweave Bag
				{ 16, 63924 },	-- Emerald Bag
				{ 18, 56004 },	-- Abyssal Bag
				{ 20, 56006 },	-- Mysterious Bag
			}
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 56034 },	-- Master's Spellthread
				{ 2, 56010 },	-- Azure Spellthread
				{ 3, 56011 },   -- Sapphire Spellthread
				{ 5, 55777 },	-- Schwertwallgarn
				{ 6, 55642 },	-- Hell leuchtendes Garn
				{ 7, 55769 },	-- Dunkel glühendes Garn
				{ 16, 56039 },	-- Sanctified Spellthread
				{ 17, 56008 },	-- Shining Spellthread
				{ 18, 56009 },  -- Brilliant Spellthread
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 75597 },	-- Frosty Flying Carpet
				{ 2, 60971 },	-- Magnificent Flying Carpet
				{ 3, 60969 },	-- Flying Carpet
				{ 5, 56002 },	-- Ebonweave
				{ 6, 56001 },	-- Moonshroud
				{ 8, 55900 },	-- Bolt of Imbued Frostweave
				{ 9, 55899 },	-- Bolt of Frostweave
				{ 16, 55898 },	-- Frostweave Net
				{ 20, 56003 },	-- Spellweave
			}
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 764 }, -- Duskweaver
				{ 2, 763 }, -- Frostwoven Power
			},
		},
	}
}

data["LeatherworkingWrath"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{ -- Cloak
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 60637 },	-- Ice Striker's Cloak
				{ 2, 60640 },	-- Durable Nerubhide Cape
				{ 3, 55199 },	-- Cloak of Tormented Skies
				{ 4, 60631 },	-- Cloak of Harsh Winds
			}
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67086 }, [ATLASLOOT_IT_HORDE] = { 67142 } },	-- Knightbane Carapace
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67084 }, [ATLASLOOT_IT_HORDE] = { 67140 } },	-- Lunar Eclipse Chestguard
				{ 3, 60996 },	-- Polar Vest
				{ 4, 60703 },	-- Eviscerator's Chestguard
				{ 5, 60718 },	-- Overcast Chestguard
				{ 6, 60669 },	-- Wildscale Breastplate
				{ 7, 51570 },	-- Dark Arctic Chestpiece
				{ 8, 60613 },	-- Dark Iceborne Chestguard
				{ 9, 50944 },	-- Arctic Chestpiece
				{ 10, 50938 },	-- Iceborne Chestguard
			},
			[MAIL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67082 }, [ATLASLOOT_IT_HORDE] = { 67138 } },	-- Crusader's Dragonscale Breastplate
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67080 }, [ATLASLOOT_IT_HORDE] = { 67136 } },	-- Ensorcelled Nerubian Breastplate
				{ 3, 60756 },	-- Revenant's Breastplate
				{ 4, 60999 },	-- Icy Scale Chestguard
				{ 5, 60730 },	-- Swiftarrow Hauberk
				{ 6, 60747 },	-- Stormhide Hauberk
				{ 7, 60649 },	-- Razorstrike Breastplate
				{ 8, 60604 },	-- Dark Frostscale Breastplate
				{ 9, 60629 },	-- Dark Nerubian Chestpiece
				{ 10, 50950 },	-- Frostscale Chestguard
				{ 11, 50956 },	-- Nerubian Chestguard
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 70555 },	-- Blessed Cenarion Boots
				{ 2, 70557 },	-- Footpads of Impending Death
				{ 3, 63201 },	-- Boots of Wintry Endurance
				{ 4, 63199 },	-- Footpads of Silence
				{ 5, 60761 },	-- Earthgiving Boots
				{ 6, 60998 },	-- Polar Boots
				{ 7, 62176 },	-- Windripper Boots
				{ 8, 60712 },	-- Eviscerator's Treads
				{ 9, 60727 },	-- Overcast Boots
				{ 10, 60666 },	-- Jormscale Footpads
				{ 11, 51568 },	-- Black Chitinguard Boots
				{ 12, 60620 },	-- Bugsquashers
				{ 13, 50948 },	-- Arctic Boots
				{ 14, 50942 },	-- Iceborne Boots
			},
			[MAIL_DIFF] = {
				{ 1, 70559 },	-- Earthsoul Boots
				{ 2, 70561 },	-- Rock-Steady Treads
				{ 3, 63195 },	-- Boots of Living Scale
				{ 4, 63197 },	-- Lightning Grounded Boots
				{ 5, 60757 },	-- Revenant's Treads
				{ 6, 61002 },	-- Icy Scale Boots
				{ 7, 60737 },	-- Swiftarrow Boots
				{ 8, 60752 },	-- Stormhide Stompers
				{ 9, 60605 },	-- Dragonstompers
				{ 10, 60630 },	-- Scaled Icewalkers
				{ 11, 50954 },	-- Frostscale Boots
				{ 12, 50960 },	-- Nerubian Boots
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 60705 },	-- Eviscerator's Gauntlets
				{ 2, 60721 },	-- Overcast Handwraps
				{ 3, 60665 },	-- Seafoam Gauntlets
				{ 4, 50947 },	-- Arctic Gloves
				{ 5, 50941 },	-- Iceborne Gloves
			},
			[MAIL_DIFF] = {
				{ 1, 60732 },	-- Swiftarrow Gauntlets
				{ 2, 60749 },	-- Stormhide Grips
				{ 3, 50953 },	-- Frostscale Gloves
				{ 4, 50959 },	-- Nerubian Gloves
			},
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 60697 },	-- Eviscerator's Facemask
				{ 2, 60715 },	-- Overcast Headguard
				{ 3, 51572 },	-- Arctic Helm
				{ 4, 60608 },	-- Iceborne Helm
			},
			[MAIL_DIFF] = {
				{ 1, 60728 },	-- Swiftarrow Helm
				{ 2, 60743 },	-- Stormhide Crown
				{ 3, 60655 },	-- Nightshock Hood
				{ 4, 60600 },	-- Frostscale Helm
				{ 5, 60624 },	-- Nerubian Helm
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 70556 },	-- Bladeborn Leggings
				{ 2, 70554 },	-- Legwraps of Unleashed Nature
				{ 3, 60760 },	-- Earthgiving Legguards
				{ 4, 62177 },	-- Windripper Leggings
				{ 5, 60711 },	-- Eviscerator's Legguards
				{ 6, 60725 },	-- Overcast Leggings
				{ 7, 60660 },	-- Leggings of Visceral Strikes
				{ 8, 51569 },	-- Dark Arctic Leggings
				{ 9, 60611 },	-- Dark Iceborne Leggings
				{ 10, 50945 },	-- Arctic Leggings
				{ 11, 50939 },	-- Iceborne Leggings
			},
			[MAIL_DIFF] = {
				{ 1, 70560 },	-- Draconic Bonesplinter Legguards
				{ 2, 70558 },	-- Lightning-Infused Leggings
				{ 3, 60754 },	-- Giantmaim Legguards
				{ 4, 60735 },	-- Swiftarrow Leggings
				{ 5, 60751 },	-- Stormhide Legguards
				{ 6, 60601 },	-- Dark Frostscale Leggings
				{ 7, 60627 },	-- Dark Nerubian Leggings
				{ 8, 50951 },	-- Frostscale Leggings
				{ 9, 50957 },	-- Nerubian Legguards
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 60758 },	-- Trollwoven Spaulders
				{ 2, 60702 },	-- Eviscerator's Shoulderpads
				{ 3, 60716 },	-- Overcast Spaulders
				{ 4, 60671 },	-- Purehorn Spaulders
				{ 5, 50946 },	-- Arctic Shoulderpads
				{ 6, 50940 },	-- Iceborne Shoulderpads
			},
			[MAIL_DIFF] = {
				{ 1, 60729 },	-- Swiftarrow Shoulderguards
				{ 2, 60746 },	-- Stormhide Shoulders
				{ 3, 60651 },	-- Virulent Spaulders
				{ 4, 50952 },	-- Frostscale Shoulders
				{ 5, 50958 },	-- Nerubian Shoulders
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 63200 },	-- Belt of Arctic Life
				{ 2, 63198 },	-- Death-warmed Belt
				{ 3, 60759 },	-- Trollwoven Girdle
				{ 4, 60997 },	-- Polar Cord
				{ 5, 60706 },	-- Eviscerator's Waistguard
				{ 6, 60723 },	-- Overcast Belt
				{ 7, 50949 },	-- Arctic Belt
				{ 8, 50943 },	-- Iceborne Belt
			},
			[MAIL_DIFF] = {
				{ 1, 63194 },	-- Belt of Dragons
				{ 2, 63196 },	-- Blue Belt of Chaos
				{ 3, 61000 },	-- Icy Scale Belt
				{ 4, 60734 },	-- Swiftarrow Belt
				{ 5, 60750 },	-- Stormhide Belt
				{ 6, 60658 },	-- Nightshock Girdle
				{ 7, 50955 },	-- Frostscale Belt
				{ 8, 50961 },	-- Nerubian Belt
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67087 }, [ATLASLOOT_IT_HORDE] = { 67139 } },	-- Bracers of Swift Death
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67085 }, [ATLASLOOT_IT_HORDE] = { 67141 } },	-- Moonshadow Armguards
				{ 3, 60704 },	-- Eviscerator's Bindings
				{ 4, 60720 },	-- Overcast Bracers
				{ 5, 51571 },	-- Arctic Wristguards
				{ 6, 60607 },	-- Iceborne Wristguards
			},
			[MAIL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67081 }, [ATLASLOOT_IT_HORDE] = { 67137 } },	-- Black Chitin Bracers
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67083 }, [ATLASLOOT_IT_HORDE] = { 67143 } },	-- Crusader's Dragonscale Bracers
				{ 3, 60755 },	-- Giantmaim Bracers
				{ 4, 60731 },	-- Swiftarrow Bracers
				{ 5, 60748 },	-- Stormhide Wristguards
				{ 6, 60652 },	-- Eaglebane Bracers
				{ 7, 60599 },	-- Frostscale Bracers
				{ 8, 60622 },	-- Nerubian Bracers
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 62448 },	-- Earthen Leg Armor
				{ 2, 50965 },	-- Frosthide Leg Armor
				{ 3, 50967 },	-- Icescale Leg Armor
				{ 5, 50964 },	-- Jormungar Leg Armor
				{ 6, 50966 },	-- Nerubian Leg Armor
				{ 8, 50963 },	-- Heavy Borean Armor Kit

				{ 10, 60584 },	-- Nerubian Leg Reinforcements
				{ 11, 60583 },	-- Jormungar Leg Reinforcements

				{ 16, 57691 },	-- Fur Lining - Spell Power
				{ 17, 57690 },	-- Fur Lining - Stamina
				{ 18, 57683 },	-- Fur Lining - Attack Power

				{ 20, 57701 },	-- Fur Lining - Arcane Resist
				{ 21, 57692 },	-- Fur Lining - Fire Resist
				{ 22, 57694 },	-- Fur Lining - Frost Resist
				{ 23, 57699 },	-- Fur Lining - Nature Resist
				{ 24, 57696 },	-- Fur Lining - Shadow Resist

			},
		},
		{
			name = AL["Drums"],
			[NORMAL_DIFF] = {
				{ 1, 69386 },	-- Drums of Forgotten Kings
				{ 2, 69388 },	-- Drums of the Wild
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 50971 },	-- Mammoth Mining Bag
				{ 2, 60643 },	-- Pack of Endless Pockets
				{ 3, 50970 },	-- Trapper's Traveling Pack
				{ 5, 60647 },	-- Nerubian Reinforced Quiver
				{ 6, 60645 },	-- Dragonscale Ammo Pouch
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 50936 },	-- Heavy Borean Leather
				{ 2, 64661 },	-- Borean Leather
			},
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 754 }, -- Iceborne Embrace
				{ 2, 757 }, -- Borean Embrace
				{ 16, 756 }, -- Nerubian Hive
				{ 17, 755 }, -- Frostscale Binding
			},
		},
	}
}

data["JewelcraftingWrath"] = {
	name = ALIL["Jewelcrafting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.JEWELCRAFTING_LINK,
	items = {
		{
			name = ALIL["Jewelcrafting"].." - "..ALIL["Gems"],
			[NORMAL_DIFF] = {
				-- red
				{ 1, 56049 },	-- Bold Dragon's Eye
				{ 2, 56052 },	-- Delicate Dragon's Eye
				{ 3, 56053 },	-- Runed  Dragon's Eye
				{ 4, 56054 },	-- Bright Dragon's Eye
				{ 5, 56055 },	-- Subtle Dragon's Eye
				{ 6, 56056 },	-- Flashing Dragon's Eye
				{ 7, 56076 },	-- Fractured Dragon's Eye
				{ 8, 56081 },	-- Precise Dragon's Eye
				-- blue
				{ 10, 56077 },	-- Lustrous Dragon's Eye
				{ 11, 56086 },	-- Solid Dragon's Eye
				{ 12, 56087 },	-- Sparkling Dragon's Eye
				{ 13, 56088 },	-- Stormy Dragon's Eye
				-- yellow
				{ 16, 56074 },	-- Brilliant Dragon's Eye
				{ 17, 56079 },	-- Mystic Dragon's Eye
				{ 18, 56083 },	-- Quick Dragon's Eye
				{ 19, 56084 },	-- Rigid Dragon's Eye
				{ 20, 56085 },	-- Smooth Dragon's Eye
				{ 21, 56089 },	-- Thick Dragon's Eye
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 56500 },	-- Titanium Earthguard Chain
				{ 2, 56499 },	-- Titanium Impact Choker
				{ 3, 56501 },	-- Titanium Spellshock Necklace
				{ 5, 64725 },	-- Emerald Choker
				{ 6, 64726 },	-- Sky Sapphire Amulet
				{ 7, 56196 },	-- Blood Sun Necklace
				{ 8, 56195 },	-- Jade Dagger Pendant
				{ 10, 58142 },	-- Crystal Chalcedony Amulet
				{ 11, 58141 },	-- Crystal Citrine Necklace
			}
		},
		{
			name = AL["Armor"].." - "..AL["Ring"],
			[NORMAL_DIFF] = {
				{ 1, 56497 },	-- Titanium Earthguard Ring
				{ 2, 56496 },	-- Titanium Impact Band
				{ 3, 56498 },	-- Titanium Spellshock Ring
				{ 4, 58954 },	-- Titanium Frostguard Ring
				{ 5, 56197 },	-- Dream Signet
				{ 6, 58147 },	-- Ring of Earthen Might
				{ 7, 58150 },	-- Ring of Northern Tears
				{ 8, 58148 },	-- Ring of Scarlet Shadows
				{ 9, 64727 },	-- Runed Mana Band
				{ 10, 58507 },	-- Savage Titanium Band
				{ 11, 58492 },	-- Savage Titanium Ring
				{ 12, 64728 },	-- Scarlet Signet
				{ 13, 58149 },	-- Windfire Band
				{ 14, 58146 },	-- Shadowmight Ring
				{ 15, 58145 },	-- Stoneguard Band
				{ 16, 58143 },	-- Earthshadow Ring
				{ 17, 58144 },	-- Jade Ring of Slaying
				{ 18, 56193 },	-- Bloodstone Band
				{ 19, 56194 },	-- Sun Rock Ring
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 56203 },	-- Figurine - Emerald Boar
				{ 2, 59759 },	-- Figurine - Monarch Crab
				{ 3, 56199 },	-- Figurine - Ruby Hare
				{ 4, 56202 },	-- Figurine - Sapphire Owl
				{ 5, 56201 },	-- Figurine - Twilight Serpent
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Meta"]),
			[NORMAL_DIFF] = {
				{ 1, 55401 },	-- Austere Earthsiege Diamond
				{ 2, 55405 },	-- Beaming Earthsiege Diamond
				{ 3, 55397 },	-- Bracing Earthsiege Diamond
				{ 4, 55398 },	-- Eternal Earthsiege Diamond
				{ 5, 55396 },	-- Insightful Earthsiege Diamond
				{ 6, 55404 },	-- Invigorating Earthsiege Diamond
				{ 7, 55402 },	-- Persistant Earthsiege Diamond
				{ 8, 55399 },	-- Powerful Earthsiege Diamond
				{ 9, 55400 },	-- Relentless Earthsiege Diamond
				{ 10, 55403 },	-- Trenchant Earthsiege Diamond
				{ 16, 55389 },	-- Chaotic Skyflare Diamond
				{ 17, 55390 },	-- Destructive Skyflare Diamond
				{ 18, 55384 },  -- Effulgent Skyflare Diamond
				{ 19, 55392 },	-- Ember Skyflare Diamond
				{ 20, 55393 },	-- Enigmatic Skyflare Diamond
				{ 21, 55387 },	-- Forlorn Skyflare Diamond
				{ 22, 55388 },	-- Impassive Skyflare Diamond
				{ 23, 55407 },	-- Revitalizing Skyflare Diamond
				{ 24, 55394 },	-- Swift Skyflare Diamond
				{ 25, 55395 },	-- Thundering Skyflare Diamond
				{ 26, 55386 },	-- Tireless Skyflare Diamond
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Red"]),
			[NORMAL_DIFF] = {
				{ 1, 66447 },	-- Bold Cardinal Ruby
				{ 2, 66446 },	-- Runed Cardinal Ruby
				{ 3, 66448 },	-- Delicate Cardinal Ruby
				{ 4, 66453 },	-- Flashing Cardinal Ruby
				{ 5, 66450 },	-- Precise Cardinal Ruby
				{ 6, 66449 },	-- Bright Cardinal Ruby
				{ 7, 66451 },   -- Fractured Cardinal Ruby
				{ 8, 66452 },   -- Subtle Cardinal Ruby
				-- blue
				{ 16, 53830 },	-- Bold Scarlet Ruby
				{ 17, 53946 },	-- Runed Scarlet Ruby
				{ 18, 53945 },	-- Delicate Scarlet Ruby
				{ 19, 53949 },	-- Flashing Scarlet Ruby
				{ 20, 53951 },	-- Precise Scarlet Ruby
				{ 21, 53947 },	-- Bright Scarlet Ruby
				{ 22, 53950 },  -- Fractured Scarlet Ruby
				{ 23, 53948 },  -- Subtle Scarlet Ruby
				-- green
				{ 101, 53831 },	-- Bold Bloodstone
				{ 102, 53834 },	-- Runed Bloodstone
				{ 103, 53832 },	-- Delicate Bloodstone
				{ 104, 53844 },	-- Flashing Bloodstone
				{ 105, 54017 },	-- Precise Bloodstone
				{ 106, 53835 },	-- Bright Bloodstone
				{ 107, 53845 }, -- Fractured Bloodstone
				{ 108, 53843 }, -- Subtle Bloodstone
				-- perfect
				{ 116, "i41432" }, -- Perfect Bold Bloodstone
				{ 117, "i41438" }, -- Perfect Runed Bloodstone
				{ 118, "i41434" }, -- Perfect Delicate Bloodstone
				{ 119, "i41435" }, -- Perfect Flashing Bloodstone
				{ 120, "i41437" }, -- Perfect Precise Bloodstone
				{ 121, "i41433" }, -- Perfect Bright Bloodstone
				{ 122, "i41436" }, -- Perfect Fractured Bloodstone
				{ 123, "i41439" }, -- Perfect Subtle Bloodstone
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Yellow"]),
			[NORMAL_DIFF] = {
				{ 1, 66503 },	-- Brilliant King's Amber
				{ 2, 66505 },	-- Mystic King's Amber
				{ 3, 66506 },	-- Quick King's Amber
				{ 4, 66501 },	-- Rigid King's Amber
				{ 5, 66502 },	-- Smooth King's Amber
				{ 6, 66504 },	-- Thick King's Amber
				{ 8, 53956 },	-- Brilliant Autumn's Glow
				{ 9, 53960 },	-- Mystic Autumn's Glow
				{ 10, 53961 },	-- Quick Autumn's Glow
				{ 11, 53958 },	-- Rigid Autumn's Glow
				{ 12, 53957 },	-- Smooth Autumn's Glow
				{ 13, 53959 },	-- Thick Autumn's Glow
				{ 16, 53852 },	-- Brilliant Sun Crystal
				{ 17, 53857 },	-- Mystic Sun Crystal
				{ 18, 53856 },	-- Quick Sun Crystal
				{ 19, 53854 },	-- Rigid Sun Crystal
				{ 20, 53853 },	-- Smooth Sun Crystal
				{ 21, 53855 },	-- Thick Sun Crystal
				-- perfect
				{ 23, "i41444" },	-- Perfect Brilliant Sun Crystal
				{ 24, "i41445" },	-- Perfect Mystic Sun Crystal
				{ 25, "i41446" },	-- Perfect Quick Sun Crystal
				{ 26, "i41447" },	-- Perfect Rigid Sun Crystal
				{ 27, "i41448" },	-- Perfect Smooth Sun Crystal
				{ 28, "i41449" },	-- Perfect Thick Sun Crystal
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Blue"]),
			[NORMAL_DIFF] = {
				{ 1, 66498 },	-- Sparkling Majestic Zircon
				{ 2, 66497 },	-- Solid Majestic Zircon
				{ 3, 66500 },	-- Lustrous Majestic Zircon
				{ 4, 66499 },	-- Stormy Majestic Zircon
				{ 6, 53953 },	-- Sparkling Sky Sapphire
				{ 7, 53952 },	-- Solid Sky Sapphire
				{ 8, 53954 },	-- Lustrous Sky Sapphire
				{ 9, 53955 },	-- Stormy Sky Sapphire
				{ 16, 53940 },	-- Sparkling Chalcedony
				{ 17, 53934 },	-- Solid Chalcedony
				{ 18, 53941 },	-- Lustrous Chalcedony
				{ 19, 53943 },	-- Stormy Chalcedony
				-- perfect
				{ 21, "i41442" },	-- Perfect Sparkling Chalcedony
				{ 22, "i41441" },	-- Perfect Solid Chalcedony
				{ 23, "i41440" },	-- Perfect Lustrous Chalcedony
				{ 24, "i41443" },	-- Perfect Stormy Chalcedony
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Orange"]),
			[NORMAL_DIFF] = {
				{ 1, 66576 },   -- Accurate Ametrine
				{ 2, 66579 },	-- Champion's Ametrine
				{ 3, 66568 },	-- Deadly Ametrine
				{ 4, 66584 },	-- Deft Ametrine
				{ 5, 66571 },	-- Durable Ametrine
				{ 6, 66580 },	-- Empowered Ametrine
				{ 7, 66572 },	-- Etched Ametrine
				{ 8, 66583 },	-- Fierce Ametrine
				{ 9, 66578 },   -- Glimmering Ametrine
				{ 10, 66575 },  -- Glinting Ametrine
				{ 11, 66567 },	-- Inscribed Ametrine
				{ 12, 66585 },	-- Lucent Ametrine
				{ 13, 66566 },  -- Luminous Ametrine
				{ 14, 66569 },	-- Potent Ametrine
				{ 15, 66573 },	-- Pristine Ametrine
				{ 16, 66574 },	-- Reckless Ametrine
				{ 17, 66586 },	-- Resolute Ametrine
				{ 18, 66582 },	-- Resplendent Ametrine
				{ 19, 66581 },	-- Stalwart Ametrine
				{ 20, 66587 },  -- Stark Ametrine
				{ 21, 66570 },  -- Veiled Ametrine
				{ 22, 66577 },	-- Wicked Ametrine
				-- blue
				{ 101, 53994 }, -- Accurate Monarch Topaz
				{ 102, 53977 },	-- Champion's Monarch Topaz
				{ 103, 53979 },	-- Deadly Monarch Topaz
				{ 104, 53991 },	-- Deft Monarch Topaz
				{ 105, 53986 },	-- Durable Monarch Topaz
				{ 106, 53990 },	-- Empowered Monarch Topaz
				{ 107, 53976 }, -- Etched Monarch Topaz
				{ 108, 54019 },	-- Fierce Monarch Topaz
				{ 109, 53993 }, -- Glimmering Monarch Topaz
				{ 110, 53980 }, -- Glinting Monarch Topaz
				{ 111, 53975 },	-- Inscribed Monarch Topaz
				{ 112, 53981 },	-- Lucent Monarch Topaz
				{ 113, 53983 }, -- Luminous Monarch Topaz
				{ 114, 53984 },	-- Potent Monarch Topaz
				{ 115, 53989 }, -- Pristine Monarch Topaz
				{ 116, 53987 },	-- Reckless Monarch Topaz
				{ 117, 54023 },	-- Resolute Monarch Topaz
				{ 118, 53978 },	-- Resplendent Monarch Topaz
				{ 119, 53993 },	-- Stalwart Monarch Topaz
				{ 120, 53991 }, -- Stark Monarch Topaz
				{ 121, 53985 }, -- Veiled Monarch Topaz
				{ 122, 53988 }, -- Wicked Monarch Topaz
				-- green
				{ 201, 53892 }, -- Accurate Huge Citrine
				{ 202, 53874 },	-- Champion's Huge Citrine
				{ 203, 53877 },	-- Deadly Huge Citrine
				{ 204, 53880 },	-- Deft Huge Citrine
				{ 205, 53884 }, -- Durable Huge Citrine
				{ 206, 53888 }, -- Empowered Huge Citrine
				{ 207, 53873 }, -- Etched Huge Citrine
				{ 208, 53876 },	-- Fierce Huge Citrine
				{ 209, 53891 }, -- Glimmering Huge Citrine
				{ 210, 53878 }, -- Glinting Huge Citrine
				{ 211, 53872 },	-- Inscribed Huge Citrine
				{ 212, 53879 },	-- Lucent Huge Citrine
				{ 213, 53881 }, -- Luminous Huge Citrine
				{ 214, 53882 },	-- Potent Huge Citrine
				{ 215, 53887 }, -- Prisinte Huge Citrine
				{ 216, 53885 },	-- Reckless Huge Citrine
				{ 217, 53893 },	-- Resolute Huge Citrine
				{ 218, 53875 },	-- Resplendent Huge Citrine
				{ 219, 53891 },	-- Stalwart Huge Citrine
				{ 220, 53889 }, -- Stark Huge Citrine
				{ 221, 53883 },	-- Veiled Huge Citrine
				{ 222, 53886 }, -- Wicked Huge Citrine
				-- perfect
				{ 301, "i41482" }, -- Perfect Accurate Huge Citrine
				{ 302, "i41483" }, -- Perfect Champion's Huge Citrine
				{ 303, "i41484" }, -- Perfect Deadly Huge Citrine
				{ 304, "i41485" }, -- Perfect Deft Huge Citrine
				{ 305, "i41486" }, -- Perfect Durable Huge Citrine
				{ 306, "i41487" }, -- Perfect Empowered Huge Citrine
				{ 307, "i41488" }, -- Perfect Etched Huge Citrine
				{ 308, "i41489" }, -- Perfect Fierce Huge Citrine
				{ 309, "i41490" }, -- Perfect Glimmering Huge Citrine
				{ 310, "i41491" }, -- Perfect Glinting Huge Citrine
				{ 311, "i41492" }, -- Perfect Inscribed Huge Citrine
				{ 312, "i41493" }, -- Perfect Lucent Huge Citrine
				{ 313, "i41494" }, -- Perfect Luminous Huge Citrine
				{ 314, "i41495" }, -- Perfect Potent Huge Citrine
				{ 315, "i41496" }, -- Perfect Prisinte Huge Citrine
				{ 316, "i41497" }, -- Perfect Reckless Huge Citrine
				{ 317, "i41498" }, -- Perfect Resolute Huge Citrine
				{ 318, "i41499" }, -- Perfect Resplendent Huge Citrine
				{ 319, "i41500" }, -- Perfect Stalwart Huge Citrine
				{ 320, "i41501" }, -- Perfect Stark Huge Citrine
				{ 321, "i41502" }, -- Perfect Veiled Huge Citrine
				{ 322, "i41429" }, -- Perfect Wicked Huge Citrine
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Green"]),
			[NORMAL_DIFF] = {
				{ 1, 66430 },   -- Dazzling Eye of Zul
				{ 2, 66338 },   -- Enduring Eye of Zul
				{ 3, 66442 },	-- Energized Eye of Zul
				{ 4, 66434 },	-- Forceful Eye of Zul
				{ 5, 66440 },   -- Intricate Eye of Zul
				{ 6, 66431 },	-- Jagged Eye of Zul
				{ 7, 66439 },   -- Lambent Eye of Zul
				{ 8, 66435 },	-- Misty Eye of Zul
				{ 9, 66444 },   -- Opaque Eye of Zul
				{ 10, 66441 },	-- Radiant Eye of Zul
				{ 11, 66433 },  -- Seer Eye of Zul
				{ 12, 66443 },	-- Shattered Eye of Zul
				{ 13, 66437 },  -- Shining Eye of Zul
				{ 14, 66428 },	-- Steady Eye of Zul
				{ 15, 66436 },  -- Sundered Eye of Zul
				{ 16, 66438 },  -- Tense Eye of Zul
				{ 17, 66432 },  -- Timeless Eye of Zul
				{ 18, 66445 },	-- Turbid Eye of Zul
				{ 19, 66429 },  -- Vivid Eye of Zul
				-- blue
				{ 101, 54007 }, -- Dazzling Forest Emerald
				{ 102, 53998 }, -- Enduring Forest Emerald
				{ 103, 54011 },	-- Energized Forest Emerald
				{ 104, 54001 },	-- Forceful Forest Emerald
				{ 105, 54006 }, -- Intricate Forest Emerald
				{ 106, 53996 },	-- Jagged Forest Emerald
				{ 107, 54009 }, -- Lambent Forest Emerald
				{ 108, 54003 },	-- Misty Forest Emerald
				{ 109, 54010 }, -- Opaque Forest Emerald
				{ 110, 54012 },	-- Radiant Forest Emerald
				{ 111, 54002 }, -- Seer Forest Emerald
				{ 112, 54014 },	-- Shattered Forest Emerald
				{ 113, 54004 }, -- Shining Forest Emerald
				{ 114, 54000 },	-- Steady Forest Emerald
				{ 115, 54008 }, -- Sundered Forest Emerald
				{ 116, 54013 }, -- Tense Forest Emerald
				{ 117, 53995 }, -- Timeless Forest Emerald
				{ 118, 54005 },	-- Turbid Forest Emerald
				{ 119, 53997 }, -- Vivid Forest Emerald
				-- green
				{ 201, 53926 }, -- Dazzling Dark Jade
				{ 202, 53918 }, -- Enduring Dark Jade
				{ 203, 53930 },	-- Energized Dark Jade
				{ 204, 53925 },	-- Forceful Dark Jade
				{ 205, 53925 }, -- Intricate Dark Jade
				{ 206, 53916 },	-- Jagged Dark Jade
				{ 207, 53928 }, -- Lambent Dark Jade
				{ 208, 53922 },	-- Misty Dark Jade
				{ 209, 53929 }, -- Opaque Dark Jade
				{ 210, 53931 },	-- Radiant Dark Jade
				{ 211, 53921 }, -- Seer Dark Jade
				{ 212, 53933 },	-- Shattered Dark Jade
				{ 213, 53919 }, -- Shining Dark Jade
				{ 214, 53919 },	-- Steady Dark Jade
				{ 215, 53927 }, -- Sundered Dark Jade
				{ 216, 53932 }, -- Tense Dark Jade
				{ 217, 53894 }, -- Timeless Dark Jade
				{ 218, 53924 },	-- Turbid Dark Jade
				{ 219, 53917 }, -- Vivid Dark Jade
				-- perfect
				{ 301, "i41463" }, -- Perfect Dazzling Dark Jade
				{ 302, "i41464" }, -- Perfect Enduring Dark Jade
				{ 303, "i41465" }, -- Perfect Energized Dark Jade
				{ 304, "i41466" }, -- Perfect Forceful Dark Jade
				{ 305, "i41467" }, -- Perfect Intricate Dark Jade
				{ 306, "i41468" }, -- Perfect Jagged Dark Jade
				{ 307, "i41469" }, -- Perfect Lambent Dark Jade
				{ 308, "i41470" }, -- Perfect Misty Dark Jade
				{ 309, "i41471" }, -- Perfect Opaque Dark Jade
				{ 310, "i41472" }, -- Perfect Radiant Dark Jade
				{ 311, "i41473" }, -- Perfect Seer Dark Jade
				{ 312, "i41474" }, -- Perfect Shattered Dark Jade
				{ 313, "i41475" }, -- Perfect Shining Dark Jade
				{ 314, "i41476" }, -- Perfect Steady Dark Jade
				{ 315, "i41477" }, -- Perfect Sundered Dark Jade
				{ 316, "i41478" }, -- Perfect Tense Dark Jade
				{ 317, "i41479" }, -- Perfect Timeless Dark Jade
				{ 318, "i41480" }, -- Perfect Turbid Dark Jade
				{ 319, "i41481" }, -- Perfect Vivid Dark Jade
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Purple"]),
			[NORMAL_DIFF] = {
				{ 1, 66553 },	-- Balanced Dreadstone
				{ 2, 66560 },	-- Defender's Dreadstone
				{ 3, 66555 },	-- Glowing Dreadstone
				{ 4, 66561 },	-- Guardian's Dreadstone
				{ 5, 66564 },	-- Infused Dreadstone
				{ 6, 66562 },	-- Mysterious Dreadstone
				{ 7, 66563 },	-- Puissant Dreadstone
				{ 8, 66556 },	-- Purified Dreadstone
				{ 9, 66559 },	-- Regal Dreadstone
				{ 10, 66558 },	-- Royal Dreadstone
				{ 11, 66557 },	-- Shifting Dreadstone
				{ 12, 66554 },	-- Sovereign Dreadstone
				{ 13, 66565 },	-- Tenuous Dreadstone
				-- blue
				{ 16, 53969 },	-- Balanced Twilight Opal
				{ 17, 53972 },	-- Defender's Twilight Opal
				{ 18, 53965 },	-- Glowing Twilight Opal
				{ 19, 53974 },	-- Guardian's Twilight Opal
				{ 20, 53970 },	-- Infused Twilight Opal
				{ 21, 53968 },	-- Mysterious Twilight Opal
				{ 22, 53973 },	-- Puissant Twilight Opal
				{ 23, 53966 },	-- Purified Twilight Opal
				{ 24, 53971 },	-- Regal Twilight Opal
				{ 25, 53967 },	-- Royal Twilight Opal
				{ 26, 53963 },	-- Shifting Twilight Opal
				{ 27, 53962 },	-- Sovereign Twilight Opal
				{ 28, 53964 },	-- Tenuous Twilight Opal
				-- green
				{ 101, 53866 },	-- Balanced Shadow Crystal
				{ 102, 53869 },	-- Defender's Shadow Crystal
				{ 103, 53862 },	-- Glowing Shadow Crystal
				{ 104, 53871 },	-- Guardian's Shadow Crystal
				{ 105, 53867 },	-- Infused Shadow Crystal
				{ 106, 53865 },	-- Mysterious Shadow Crystal
				{ 107, 53870 },	-- Puissant Shadow Crystal
				{ 108, 53863 },	-- Purified Shadow Crystal
				{ 109, 53868 },	-- Regal Shadow Crystal
				{ 110, 53864 },	-- Royal Shadow Crystal
				{ 111, 53860 },	-- Shifting Shadow Crystal
				{ 112, 53859 },	-- Sovereign Shadow Crystal
				{ 113, 53861 },	-- Tenuous Shadow Crystal
				-- perfect
				{ 116, "i41450" },	-- Perfect Balanced Shadow Crystal
				{ 117, "i41451" },	-- Perfect Defender's Shadow Crystal
				{ 118, "i41452" },	-- Perfect Glowing Shadow Crystal
				{ 119, "i41453" },	-- Perfect Guardian's Shadow Crystal
				{ 120, "i41454" },	-- Perfect Infused Shadow Crystal
				{ 121, "i41455" },	-- Perfect Mysterious Shadow Crystal
				{ 122, "i41456" },	-- Perfect Puissant Shadow Crystal
				{ 123, "i41457" },	-- Perfect Purified Shadow Crystal
				{ 124, "i41458" },	-- Perfect Regal Shadow Crystal
				{ 125, "i41459" },	-- Perfect Royal Shadow Crystal
				{ 126, "i41460" },	-- Perfect Shifting Shadow Crystal
				{ 127, "i41461" },	-- Perfect Sovereign Shadow Crystal
				{ 128, "i41462" },	-- Perfect Tenuous Shadow Crystal
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Prismatic"]),
			[NORMAL_DIFF] = {
				{ 1, 56530 }, -- Enchanted Pearl
				{ 2, 56531 }, -- Enchanted Tear
				{ 3, 68253 }, -- Nightmare Tear
			}
		},
		{
			name = AL["Raw Gems"],
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 41334 }, --  Earthsiege Diamond
				{ 2, 41266 }, --  Skyflare Diamond
				{ 3, 36783 }, --  Northsea Pearl
				{ 5, 36925 }, --  Majestic Zircon
				{ 6, 36924 }, -- Sky Sapphire
				{ 7, 36923 }, --  Chalcedony
				{ 9, 36934 }, --  Eye of Zul
				{ 10, 36933 }, --  Forest Emerald
				{ 11, 36932 }, --  Dark Jade
				{ 13, 36931 }, --  Ametrine
				{ 14, 36930 }, --  Monarch Topaz
				{ 15, 36929 }, --  Huge Citrine
				{ 16, 42225 }, --  Dragon's Eye
				{ 17, 36784 }, --  Siren's Tear
				{ 20, 36928 }, --  Dreadstone
				{ 21, 36927 }, --  Twilight Opal
				{ 22, 36926 }, --  Shadow Crystal
				{ 24, 36919 }, --  Cardinal Ruby
				{ 25, 36918 }, --  Scarlet Ruby
				{ 26, 36917 }, --  Bloodstone
				{ 28, 36922 }, --  King's Amber
				{ 29, 36921 }, --  Autumn's Glow
				{ 30, 36920 }, --  Sun Crystal
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 62242 },	-- Icy Prism
				{ 3, "i43297" },	-- Damaged Necklace
				{ 16, 56208 },	-- Shadow Jade Focusing Lens
				{ 17, 56206 },	-- Shadow Crystal Focusing Lens
				{ 18, 56205 },	-- Dark Jade Focusing Lens
			}
		},
	}
}

data["InscriptionWrath"] = {
	name = ALIL["Inscription"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.INSCRIPTION_LINK,
	items = {
		{
			name = AL["Scrolls"],
			[NORMAL_DIFF] = {
				{ 1, 69385 },	-- Runescroll of Fortitude
				{ 3, 60337 },	-- Scroll of Recall III
				{ 4, 60336 },	-- Scroll of Recall II
				{ 5, 48248 },	-- Scroll of Recall

				{ 16, 58483 },	-- Scroll of Agility VIII
				{ 17, 58482 },	-- Scroll of Agility VII
				{ 18, 58481 },	-- Scroll of Agility VI
				{ 19, 58480 },	-- Scroll of Agility V
				{ 20, 58478 },	-- Scroll of Agility IV
				{ 21, 58476 },	-- Scroll of Agility III
				{ 22, 58473 },	-- Scroll of Agility II
				{ 23, 58472 },	-- Scroll of Agility

				{ 101, 50604 },	-- Scroll of Intellect VIII
				{ 102, 50603 },	-- Scroll of Intellect VII
				{ 103, 50602 },	-- Scroll of Intellect VI
				{ 104, 50601 },	-- Scroll of Intellect V
				{ 105, 50600 },	-- Scroll of Intellect IV
				{ 106, 50599 },	-- Scroll of Intellect III
				{ 107, 50598 },	-- Scroll of Intellect II
				{ 108, 48114 },	-- Scroll of Intellect

				{ 116, 50611 },	-- Scroll of Spirit VIII
				{ 117, 50610 },	-- Scroll of Spirit VII
				{ 118, 50609 },	-- Scroll of Spirit VI
				{ 119, 50608 },	-- Scroll of Spirit V
				{ 120, 50607 },	-- Scroll of Spirit IV
				{ 121, 50606 },	-- Scroll of Spirit III
				{ 122, 50605 },	-- Scroll of Spirit II
				{ 123, 48116 },	-- Scroll of Spirit

				{ 201, 50620 },	-- Scroll of Stamina VIII
				{ 202, 50619 },	-- Scroll of Stamina VII
				{ 203, 50618 },	-- Scroll of Stamina VI
				{ 204, 50617 },	-- Scroll of Stamina V
				{ 205, 50616 },	-- Scroll of Stamina IV
				{ 206, 50614 },	-- Scroll of Stamina III
				{ 207, 50612 },	-- Scroll of Stamina II
				{ 208, 45382 },	-- Scroll of Stamina

				{ 216, 58491 },	-- Scroll of Strength VIII
				{ 217, 58490 },	-- Scroll of Strength VII
				{ 218, 58489 },	-- Scroll of Strength VI
				{ 219, 58488 },	-- Scroll of Strength V
				{ 220, 58487 },	-- Scroll of Strength IV
				{ 221, 58486 },	-- Scroll of Strength III
				{ 222, 58485 },	-- Scroll of Strength II
				{ 223, 58484 },	-- Scroll of Strength
			}
		},
		{
			name = ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 59498 },	-- Faces of Doom
				{ 2, 59497 },	-- Iron-bound Tome
				{ 3, 64051 },	-- Rituals of the New Moon
				{ 4, 64053 },	-- Twilight Tome
				{ 5, 59496 },	-- Book of Clever Tricks
				{ 6, 59495 },	-- Hellfire Tome
				{ 7, 59494 },	-- Manual of Clouds
				{ 8, 59493 },	-- Stormbound Tome
				{ 9, 59490 },	-- Book of Stars
				{ 10, 59489 },	-- Fire Eater's Guide
				{ 11, 59486 },	-- Royal Guide of Escape Routes
				{ 12, 59484 },	-- Tome of Kings
				{ 13, 59478 },	-- Book of Survival
				{ 14, 59475 },	-- Tome of the Dawn
				{ 15, 58565 },	-- Mystic Tome
			}
		},
		{
			name = AL["Cards"],
			[NORMAL_DIFF] = {
				{ 1, 59504 },	-- Darkmoon Card of the North
				{ 2, 59503 },	-- Greater Darkmoon Card
				{ 3, 59502 },	-- Darkmoon Card
				{ 16, 59491 },	-- Shadowy Tarot
				{ 17, 59487 },	-- Arcane Tarot
				{ 18, 48247 },	-- Mysterious Tarot
				{ 19, 59480 },	-- Strange Tarot
			}
		},
		{
			name = ALIL["WARRIOR"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 57159 }, -- Glyph of Intervene / 375
				{ 2, 57166 }, -- Glyph of Last Stand / 375
				{ 3, 64255 }, -- Glyph of Vigilance / 375
				{ 4, 64312 }, -- Glyph of Enraged Regeneration / 375
				{ 5, 64252 }, -- Glyph of Shield Wall / 375
				{ 6, 57170 }, -- Glyph of Victory Rush / 375
				{ 7, 57164 }, -- Glyph of Resonating Power / 375
				{ 8, 64296 }, -- Glyph of Shockwave / 375
				{ 9, 57153 }, -- Glyph of Bloodthirst / 375
				{ 10, 64295 }, -- Glyph of Bladestorm / 375
				{ 11, 57155 }, -- Glyph of Devastate / 375
				{ 12, 57169 }, -- Glyph of Taunt / 375
				{ 13, 57152 }, -- Glyph of Blocking / 375
				{ 14, 57160 }, -- Glyph of Mortal Strike / 375
				{ 15, 64302 }, -- Glyph of Spell Reflection / 375
				{ 16, 57172 }, -- Glyph of Whirlwind / 345
				{ 17, 57168 }, -- Glyph of Sweeping Strikes / 320
				{ 18, 57156 }, -- Glyph of Execution / 285
				{ 19, 57154 }, -- Glyph of Cleaving / 240
				{ 20, 57151 }, -- Glyph of Barbaric Insults / 220
				{ 21, 57165 }, -- Glyph of Revenge / 190
				{ 22, 57161 }, -- Glyph of Overpower / 170
				{ 23, 57167 }, -- Glyph of Sunder Armor / 140
				{ 24, 57157 }, -- Glyph of Hamstring / 125
				{ 25, 57163 }, -- Glyph of Rending / 110
				{ 26, 57158 }, -- Glyph of Heroic Strike / 95
				{ 27, 57162 }, -- Glyph of Rapid Charge / 85
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58347 }, -- Glyph of Enduring Victory / 330
				{ 2, 58345 }, -- Glyph of Mocking Blow / 105
				{ 3, 58344 }, -- Glyph of Charge / 75
				{ 4, 58343 }, -- Glyph of Bloodrage / 75
				{ 5, 58346 }, -- Glyph of Thunder Clap / 75
				{ 6, 68166 }, -- Glyph of Command / 75
				{ 7, 58342 }, -- Glyph of Battle / 75
			},
		},
		{
			name = ALIL["PALADIN"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64308 }, -- Glyph of Shield of Righteousness / 375
				{ 2, 57021 }, -- Glyph of Avenging Wrath / 375
				{ 3, 64279 }, -- Glyph of Divine Storm / 375
				{ 4, 57034 }, -- Glyph of Seal of Light / 375
				{ 5, 57028 }, -- Glyph of Hammer of Wrath / 375
				{ 6, 64251 }, -- Glyph of Salvation / 375
				{ 7, 57019 }, -- Glyph of Avenger / 375
				{ 8, 64254 }, -- Glyph of Holy Shock / 375
				{ 9, 57036 }, -- Glyph of Turn Evil / 375
				{ 10, 59560 }, -- Glyph of Seal of Righteousness / 375
				{ 11, 64305 }, -- Glyph of Divine Plea / 375
				{ 12, 59559 }, -- Glyph of Holy Wrath / 375
				{ 13, 59561 }, -- Glyph of Seal of Vengeance / 375
				{ 14, 57035 }, -- Glyph of Seal of Wisdom / 375
				{ 15, 64277 }, -- Glyph of Beacon of Light / 375
				{ 16, 64278 }, -- Glyph of Hammer of the Righteous / 375
				{ 17, 57033 }, -- Glyph of Seal of Command / 335
				{ 18, 57026 }, -- Glyph of Flash of Light / 300
				{ 19, 57025 }, -- Glyph of Exorcism / 265
				{ 20, 57024 }, -- Glyph of Crusader Strike / 230
				{ 21, 57023 }, -- Glyph of Consecration / 205
				{ 22, 57020 }, -- Glyph of Cleansing / 180
				{ 23, 57031 }, -- Glyph of Divinity / 135
				{ 24, 57030 }, -- Glyph of Judgement / 120
				{ 25, 57027 }, -- Glyph of Hammer of Justice / 90
				{ 26, 57022 }, -- Glyph of Spiritual Attunement / 80
				{ 27, 57032 }, -- Glyph of Righteous Defense / 75
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58313 }, -- Glyph of Lay on Hands / 75
				{ 2, 58316 }, -- Glyph of the Wise / 75
				{ 3, 58311 }, -- Glyph of Blessing of Kings / 75
				{ 4, 58314 }, -- Glyph of Blessing of Might / 75
				{ 5, 58315 }, -- Glyph of Sense Undead / 75
				{ 6, 58312 }, -- Glyph of Blessing of Wisdom / 75
			},
		},
		{
			name = ALIL["HUNTER"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64249 }, -- Glyph of Scatter Shot / 375
				{ 2, 64271 }, -- Glyph of Chimera Shot / 375
				{ 3, 57013 }, -- Glyph of Volley / 375
				{ 4, 64246 }, -- Glyph of Raptor Strike / 375
				{ 5, 57006 }, -- Glyph of the Hawk / 375
				{ 6, 56998 }, -- Glyph of Aspect of the Viper / 375
				{ 7, 64253 }, -- Glyph of Explosive Trap / 375
				{ 8, 57014 }, -- Glyph of Wyvern Sting / 375
				{ 9, 57012 }, -- Glyph of Trueshot Aura / 375
				{ 10, 64304 }, -- Glyph of Kill Shot / 375
				{ 11, 64273 }, -- Glyph of Explosive Shot / 375
				{ 12, 57010 }, -- Glyph of Snake Trap / 375
				{ 13, 57011 }, -- Glyph of Steady Shot / 375
				{ 14, 56999 }, -- Glyph of Bestial Wrath / 375
				{ 15, 56996 }, -- Glyph of the Beast / 375
				{ 16, 57003 }, -- Glyph of Frost Trap / 350
				{ 17, 57008 }, -- Glyph of Rapid Fire / 315
				{ 18, 57002 }, -- Glyph of Freezing Trap / 260
				{ 19, 57001 }, -- Glyph of Disengage / 225
				{ 20, 57000 }, -- Glyph of Deterrence / 200
				{ 21, 56994 }, -- Glyph of Aimed Shot / 175
				{ 22, 57007 }, -- Glyph of Multi / 150
				{ 23, 57005 }, -- Glyph of Immolation Trap / 130
				{ 24, 56997 }, -- Glyph of Mending / 115
				{ 25, 56995 }, -- Glyph of Arcane Shot / 100
				{ 26, 57009 }, -- Glyph of Serpent Sting / 90
				{ 27, 57004 }, -- Glyph of Hunter / 80
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58302 }, -- Glyph of Feign Death / 155
				{ 2, 58301 }, -- Glyph of Mend Pet / 80
				{ 3, 58300 }, -- Glyph of Possessed Strength / 75
				{ 4, 58299 }, -- Glyph of Revive Pet / 75
				{ 5, 58297 }, -- Glyph of the Pack / 75
				{ 6, 58298 }, -- Glyph of Scare Beast / 75
			},
		},
		{
			name = ALIL["ROGUE"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 57117 }, -- Glyph of Deadly Throw / 375
				{ 2, 57116 }, -- Glyph of Crippling Poison / 375
				{ 3, 57127 }, -- Glyph of Preparation / 375
				{ 4, 57115 }, -- Glyph of Blade Flurry / 375
				{ 5, 64303 }, -- Glyph of Cloak of Shadows / 375
				{ 6, 64315 }, -- Glyph of Fan of Knives / 375
				{ 7, 57128 }, -- Glyph of Rupture / 375
				{ 8, 57124 }, -- Glyph of Ghostly Strike / 375
				{ 9, 64310 }, -- Glyph of Tricks of the Trade / 375
				{ 10, 57126 }, -- Glyph of Hemorrhage / 375
				{ 11, 64286 }, -- Glyph of Shadow Dance / 375
				{ 12, 64285 }, -- Glyph of Killing Spree / 375
				{ 13, 57130 }, -- Glyph of Vigor / 375
				{ 14, 64284 }, -- Glyph of Hunger for Blood / 375
				{ 15, 57113 }, -- Glyph of Ambush / 340
				{ 16, 57122 }, -- Glyph of Feint / 305
				{ 17, 57133 }, -- Glyph of Sprint / 285
				{ 18, 64260 }, -- Glyph of Mutilate / 255
				{ 19, 57132 }, -- Glyph of Slice and Dice / 235
				{ 20, 57131 }, -- Glyph of Sinister Strike / 210
				{ 21, 57129 }, -- Glyph of Sap / 185
				{ 22, 57125 }, -- Glyph of Gouge / 160
				{ 23, 57123 }, -- Glyph of Garrote / 135
				{ 24, 57121 }, -- Glyph of Expose Armor / 120
				{ 25, 57120 }, -- Glyph of Eviscerate / 105
				{ 26, 57119 }, -- Glyph of Evasion / 95
				{ 27, 57114 }, -- Glyph of Backstab / 80
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58323 }, -- Glyph of Blurred Speed / 75
				{ 2, 58328 }, -- Glyph of Vanish / 75
				{ 3, 58325 }, -- Glyph of Pick Lock / 75
				{ 4, 58324 }, -- Glyph of Distract / 75
				{ 5, 58327 }, -- Glyph of Safe Fall / 75
				{ 6, 58326 }, -- Glyph of Pick Pocket / 75
			},
		},
		{
			name = ALIL["PRIEST"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 57189 }, -- Glyph of Lightwell / 375
				{ 2, 57199 }, -- Glyph of Shadow Word / 375
				{ 3, 57190 }, -- Glyph of Mass Dispel / 375
				{ 4, 57195 }, -- Glyph of Prayer of Healing / 375
				{ 5, 57191 }, -- Glyph of Mind Control / 375
				{ 6, 64281 }, -- Glyph of Guardian Spirit / 375
				{ 7, 64309 }, -- Glyph of Mind Sear / 375
				{ 8, 57202 }, -- Glyph of Spirit of Redemption / 375
				{ 9, 57181 }, -- Glyph of Circle of Healing / 375
				{ 10, 64282 }, -- Glyph of Penance / 375
				{ 11, 64280 }, -- Glyph of Dispersion / 375
				{ 12, 57198 }, -- Glyph of Scourge Imprisonment / 375
				{ 13, 64283 }, -- Glyph of Hymn of Hope / 375
				{ 14, 57193 }, -- Glyph of Shadow / 375
				{ 15, 57192 }, -- Glyph of Shadow Word / 350
				{ 16, 57187 }, -- Glyph of Holy Nova / 315
				{ 17, 57185 }, -- Glyph of Fear Ward / 270
				{ 18, 64259 }, -- Glyph of Pain Suppression / 255
				{ 19, 57183 }, -- Glyph of Dispel Magic / 230
				{ 20, 57201 }, -- Glyph of Smite / 210
				{ 21, 57200 }, -- Glyph of Mind Flay / 180
				{ 22, 57197 }, -- Glyph of Renew / 160
				{ 23, 57188 }, -- Glyph of Inner Fire / 135
				{ 24, 57186 }, -- Glyph of Flash Heal / 120
				{ 25, 57184 }, -- Glyph of Fade / 105
				{ 26, 57196 }, -- Glyph of Psychic Scream / 95
				{ 27, 57194 }, -- Glyph of Power Word / 80
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58319 }, -- Glyph of Levitate / 75
				{ 2, 58322 }, -- Glyph of Shadowfiend / 75
				{ 3, 58317 }, -- Glyph of Fading / 75
				{ 4, 58321 }, -- Glyph of Shadow Protection / 75
				{ 5, 58318 }, -- Glyph of Fortitude / 75
				{ 6, 58320 }, -- Glyph of Shackle Undead / 75
			},
		},
		{
			name = ALIL["DEATHKNIGHT"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 57225 }, -- Glyph of Strangulate / 375
				{ 2, 57223 }, -- Glyph of Rune Strike / 375
				{ 3, 57208 }, -- Glyph of Heart Strike / 375
				{ 4, 57207 }, -- Glyph of Anti / 375
				{ 5, 57218 }, -- Glyph of Icebound Fortitude / 375
				{ 6, 64297 }, -- Glyph of Dancing Rune Weapon / 375
				{ 7, 57211 }, -- Glyph of Chains of Ice / 375
				{ 8, 64299 }, -- Glyph of Unholy Blight / 375
				{ 9, 64298 }, -- Glyph of Hungering Cold / 375
				{ 10, 64300 }, -- Glyph of Howling Blast / 375
				{ 11, 57212 }, -- Glyph of Dark Command / 375
				{ 12, 57220 }, -- Glyph of Obliterate / 375
				{ 13, 57214 }, -- Glyph of Death and Decay / 375
				{ 14, 57222 }, -- Glyph of the Ghoul / 350
				{ 15, 57227 }, -- Glyph of Vampiric Blood / 345
				{ 16, 59340 }, -- Glyph of Death Strike / 340
				{ 17, 57224 }, -- Glyph of Scourge Strike / 330
				{ 18, 59339 }, -- Glyph of Blood Strike / 320
				{ 19, 59338 }, -- Glyph of Rune Tap / 310
				{ 20, 57226 }, -- Glyph of Unbreakable Armor / 305
				{ 21, 57221 }, -- Glyph of Plague Strike / 300
				{ 22, 57213 }, -- Glyph of Death Grip / 285
				{ 23, 57219 }, -- Glyph of Icy Touch / 280
				{ 24, 64267 }, -- Glyph of Disease / 280
				{ 25, 64266 }, -- Glyph of Dark Death / 275
				{ 26, 57216 }, -- Glyph of Frost Strike / 270
				{ 27, 57210 }, -- Glyph of Bone Shield / 265
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 57228 }, -- Glyph of Raise Dead / 75
				{ 2, 57217 }, -- Glyph of Horn of Winter / 75
				{ 3, 57215 }, -- Glyph of Death / 75
				{ 4, 57209 }, -- Glyph of Blood Tap / 75
				{ 5, 57230 }, -- Glyph of Pestilence / 75
				{ 6, 57229 }, -- Glyph of Corpse Explosion / 75
			},
		},
		{
			name = ALIL["SHAMAN"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64316 }, -- Glyph of Hex / 375
				{ 2, 64247 }, -- Glyph of Stoneclaw Totem / 375
				{ 3, 57237 }, -- Glyph of Fire Elemental Totem / 375
				{ 4, 64288 }, -- Glyph of Feral Spirit / 375
				{ 5, 64287 }, -- Glyph of Thunder / 375
				{ 6, 57235 }, -- Glyph of Shocking / 375
				{ 7, 57233 }, -- Glyph of Chain Lightning / 375
				{ 8, 57243 }, -- Glyph of Healing Wave / 375
				{ 9, 57247 }, -- Glyph of Mana Tide Totem / 375
				{ 10, 57232 }, -- Glyph of Chain Heal / 375
				{ 11, 64289 }, -- Glyph of Riptide / 375
				{ 12, 57234 }, -- Glyph of Lava / 375
				{ 13, 57250 }, -- Glyph of Elemental Mastery / 375
				{ 14, 57248 }, -- Glyph of Stormstrike / 375
				{ 15, 57252 }, -- Glyph of Windfury Weapon / 330
				{ 16, 57236 }, -- Glyph of Earthliving Weapon / 300
				{ 17, 57251 }, -- Glyph of Water Mastery / 275
				{ 18, 64262 }, -- Glyph of Totem of Wrath / 255
				{ 19, 64261 }, -- Glyph of Earth Shield / 250
				{ 20, 57244 }, -- Glyph of Lesser Healing Wave / 235
				{ 21, 57242 }, -- Glyph of Healing Stream Totem / 215
				{ 22, 57241 }, -- Glyph of Frost Shock / 185
				{ 23, 57249 }, -- Glyph of Lava Lash / 165
				{ 24, 57245 }, -- Glyph of Lightning Bolt / 140
				{ 25, 57240 }, -- Glyph of Flametongue Weapon / 125
				{ 26, 57238 }, -- Glyph of Fire Nova / 110
				{ 27, 57246 }, -- Glyph of Lightning Shield / 95
				{ 28, 57239 }, -- Glyph of Flame Shock / 85
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 59326 }, -- Glyph of Ghost Wolf / 105
				{ 2, 58331 }, -- Glyph of Water Breathing / 75
				{ 3, 58330 }, -- Glyph of Renewed Life / 75
				{ 4, 57253 }, -- Glyph of Thunderstorm / 75
				{ 5, 58332 }, -- Glyph of Water Shield / 75
				{ 6, 58333 }, -- Glyph of Water Walking / 75
				{ 7, 58329 }, -- Glyph of Astral Recall / 75
			},
		},
		{
			name = ALIL["MAGE"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64314 }, -- Glyph of Mirror Image / 375
				{ 2, 64257 }, -- Glyph of Ice Barrier / 375
				{ 3, 56987 }, -- Glyph of Polymorph / 375
				{ 4, 64274 }, -- Glyph of Deep Freeze / 375
				{ 5, 56983 }, -- Glyph of Invisibility / 375
				{ 6, 56980 }, -- Glyph of Ice Lance / 375
				{ 7, 57719 }, -- Glyph of Fire Blast / 375
				{ 8, 56975 }, -- Glyph of Fireball / 375
				{ 9, 61677 }, -- Glyph of Frostfire / 375
				{ 10, 56986 }, -- Glyph of Molten Armor / 375
				{ 11, 56988 }, -- Glyph of Remove Curse / 375
				{ 12, 64275 }, -- Glyph of Living Bomb / 375
				{ 13, 56989 }, -- Glyph of Water Elemental / 375
				{ 14, 64276 }, -- Glyph of Arcane Barrage / 375
				{ 15, 56972 }, -- Glyph of Arcane Power / 335
				{ 16, 56984 }, -- Glyph of Mage Armor / 325
				{ 17, 56991 }, -- Glyph of Arcane Blast / 315
				{ 18, 56985 }, -- Glyph of Mana Gem / 280
				{ 19, 71101 }, -- Glyph of Eternal Water / 250
				{ 20, 56979 }, -- Glyph of Ice Block / 225
				{ 21, 56982 }, -- Glyph of Scorch / 205
				{ 22, 56981 }, -- Glyph of Icy Veins / 175
				{ 23, 56974 }, -- Glyph of Evocation / 155
				{ 24, 56973 }, -- Glyph of Blink / 130
				{ 25, 56971 }, -- Glyph of Arcane Missiles / 115
				{ 26, 56968 }, -- Glyph of Arcane Explosion / 100
				{ 27, 56978 }, -- Glyph of Ice Armor / 90
				{ 28, 56976 }, -- Glyph of Frost Nova / 80
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58306 }, -- Glyph of Frost Armor / 80
				{ 2, 58303 }, -- Glyph of Arcane Intellect / 75
				{ 3, 58307 }, -- Glyph of Frost Ward / 75
				{ 4, 58310 }, -- Glyph of the Penguin / 75
				{ 5, 58308 }, -- Glyph of Slow Fall / 75
				{ 6, 56990 }, -- Glyph of Blast Wave / 75
				{ 7, 58305 }, -- Glyph of Fire Ward / 75
			},
		},
		{
			name = ALIL["WARLOCK"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64248 }, -- Glyph of Life Tap / 375
				{ 2, 64311 }, -- Glyph of Shadowflame / 375
				{ 3, 57276 }, -- Glyph of Unstable Affliction / 375
				{ 4, 64294 }, -- Glyph of Chaos Bolt / 375
				{ 5, 57261 }, -- Glyph of Death Coil / 375
				{ 6, 57260 }, -- Glyph of Curse of Agony / 375
				{ 7, 57264 }, -- Glyph of Felhunter / 375
				{ 8, 64250 }, -- Glyph of Soul Link / 375
				{ 9, 57267 }, -- Glyph of Howl of Terror / 375
				{ 10, 57268 }, -- Glyph of Immolate / 375
				{ 11, 64318 }, -- Glyph of Metamorphosis / 375
				{ 12, 64317 }, -- Glyph of Demonic Circle / 375
				{ 13, 71102 }, -- Glyph of Quick Decay / 375
				{ 14, 57263 }, -- Glyph of Felguard / 375
				{ 15, 57273 }, -- Glyph of Siphon Life / 375
				{ 16, 57258 }, -- Glyph of Conflagrate / 375
				{ 17, 64291 }, -- Glyph of Haunt / 375
				{ 18, 57257 }, -- Glyph of Incinerate / 350
				{ 19, 57275 }, -- Glyph of Succubus / 325
				{ 20, 57272 }, -- Glyph of Shadowburn / 275
				{ 21, 57274 }, -- Glyph of Soulstone / 240
				{ 22, 57270 }, -- Glyph of Searing Pain / 215
				{ 23, 57277 }, -- Glyph of Voidwalker / 190
				{ 24, 57271 }, -- Glyph of Shadow Bolt / 165
				{ 25, 57269 }, -- Glyph of Imp / 140
				{ 26, 57262 }, -- Glyph of Fear / 125
				{ 27, 57265 }, -- Glyph of Health Funnel / 110
				{ 28, 57266 }, -- Glyph of Healthstone / 95
				{ 29, 57259 }, -- Glyph of Corruption / 85
			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58341 }, -- Glyph of Souls / 355
				{ 2, 58337 }, -- Glyph of Drain Soul / 75
				{ 3, 58339 }, -- Glyph of Subjugate Demon / 75
				{ 4, 58336 }, -- Glyph of Unending Breath / 75
				{ 5, 58340 }, -- Glyph of Kilrogg / 75
			},
		},
		{
			name = ALIL["DRUID"],
			[MAJOR_GLYPHS_DIFF] = {
				{ 1, 64313 }, -- Glyph of Nourish / 375
				{ 2, 64268 }, -- Glyph of Berserk / 375
				{ 3, 64307 }, -- Glyph of Savage Roar / 375
				{ 4, 56950 }, -- Glyph of Mangle / 375
				{ 5, 71015 }, -- Glyph of Rapid Rejuvenation / 375
				{ 6, 65245 }, -- Glyph of Survival Instincts / 375
				{ 7, 56954 }, -- Glyph of Regrowth / 375
				{ 8, 56944 }, -- Glyph of Growl / 375
				{ 9, 56949 }, -- Glyph of Lifebloom / 375
				{ 10, 64256 }, -- Glyph of Barkskin / 375
				{ 11, 62162 }, -- Glyph of Focus / 375
				{ 12, 56947 }, -- Glyph of Innervate / 375
				{ 13, 56960 }, -- Glyph of Swiftmend / 375
				{ 14, 64270 }, -- Glyph of Wild Growth / 375
				{ 15, 56958 }, -- Glyph of Starfall / 375
				{ 16, 56943 }, -- Glyph of Frenzied Regeneration / 350
				{ 17, 56952 }, -- Glyph of Rake / 310
				{ 18, 56957 }, -- Glyph of Shred / 260
				{ 19, 64258 }, -- Glyph of Monsoon / 250
				{ 20, 56959 }, -- Glyph of Starfire / 220
				{ 21, 56956 }, -- Glyph of Rip / 200
				{ 22, 56953 }, -- Glyph of Rebirth / 170
				{ 23, 56948 }, -- Glyph of Insect Swarm / 150
				{ 24, 56951 }, -- Glyph of Moonfire / 130
				{ 25, 56945 }, -- Glyph of Healing Touch / 115
				{ 26, 48121 }, -- Glyph of Entangling Roots / 100
				{ 27, 67600 }, -- Glyph of Claw / 100
				{ 28, 56961 }, -- Glyph of Maul / 90
				{ 29, 56963 }, -- Glyph of Wrath / 85
				{ 30, 56955 }, -- Glyph of Rejuvenation / 80

			},
			[MINOR_GLYPHS_DIFF] = {
				{ 1, 58288 }, -- Glyph of Unburdened Rebirth / 105
				{ 2, 58289 }, -- Glyph of Thorns / 75
				{ 3, 56965 }, -- Glyph of Typhoon / 75
				{ 4, 58287 }, -- Glyph of Challenging Roar / 75
				{ 5, 58296 }, -- Glyph of the Wild / 75
				{ 6, 59315 }, -- Glyph of Dash / 75
				{ 7, 58286 }, -- Glyph of Aquatic Form / 75
			},
		},
		{
			name = AL["Ink"],
			[NORMAL_DIFF] = {
				{ 1, 57716 },	-- Snowfall Ink
				{ 2, 57715 },	-- Ink of the Sea
				{ 3, 57714 },	-- Darkflame Ink
				{ 4, 57713 },	-- Ethereal Ink
				{ 5, 57712 },	-- Ink of the Sky
				{ 6, 57711 },	-- Shimmering Ink
				{ 7, 57710 },	-- Fiery Ink
				{ 8, 57709 },	-- Celestial Ink
				{ 9, 57708 },	-- Royal Ink
				{ 10, 57707 },	-- Jadefire Ink
				{ 11, 57706 },	-- Dawnstar Ink
				{ 12, 57704 },	-- Lion's Ink
				{ 13, 57703 },	-- Hunter's Ink
				{ 14, 53462 },	-- Midnight Ink
				{ 15, 52843 },	-- Moonglow Ink
			}
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 61117 },	-- Master's Inscription of the Axe
				{ 2, 61119 },	-- Master's Inscription of the Pinnacle
				{ 16, 61120 },	-- Master's Inscription of the Storm
				{ 17, 61118 },	-- Master's Inscription of the Crag
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 59387 },	-- Certificate of Ownership
				{ 3, 52739 },	-- Armor Vellum
				{ 4, 59499 },	-- Armor Vellum II
				{ 5, 59500 },	-- Armor Vellum III
				{ 18, 52840 },	-- Weapon Vellum
				{ 19, 59488 },	-- Weapon Vellum II
				{ 20, 59501 },	-- Weapon Vellum III
			}
		},
	}
}
--]]

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
				{ 1, 84038 }, -- Smelt Obsidium
				{ 2, 74530 }, -- Smelt Elementium
				{ 3, 74537 }, -- Smelt Hardened Elementium
				{ 4, 74529 }, -- Smelt Pyrite
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
				{ 1,  52983 }, -- Cinderbloom
				{ 2,  52985 }, -- Azshara's Veil
				{ 3,  52984 }, -- Stormvine
				{ 4,  52987 }, -- Twilight Jasmine
				{ 5,  52986 }, -- Heartblossom
				{ 6,  52988 }, -- Whiptail
				{ 16,  52989 }, -- Deathspore Pod
			}
		},
	}
}

data["SkinningCata"] = {
	name = ALIL["Skinning"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Illustrious Grand Master"],
			[NORMAL_DIFF] = {
				{ 1, 52977 }, -- Savage Leather Scraps
				{ 2, 52976 }, -- Savage Leather
				{ 3, 56516 }, -- Heavy Savage Leather
				{ 4, 52980 }, -- Pristine Hide
				{ 6, 52982 }, -- Deepsea Scale
				{ 7, 52979 }, -- Blackened Dragonscale
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
			name = ALIL["Useful Stat"],
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
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 88017 }, -- Feathered Lure
				{ 3, 88013 }, -- Chocolate Cookie
				{ 4, 88045 }, -- Starfire Espresso
				{ 16, 88044 }, -- South Island Iced Tea
				{ 17, 88022 }, -- Highland Spirits
				{ 18, 88015 }, -- Darkbrew Lager
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
				{ 1, 74556 },	-- Embersilk Bandage
				{ 2, 74557 },	-- Heavy Embersilk Bandage
				{ 3, 74558 },	-- Field Bandage: Dense Embersilk
				{ 4, 88893 },	-- Dense Embersilk Bandage
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
				{1, 90608}, -- Zin'rokh, Destroyer of Worlds
				{2, 91227}, -- Staff of Sorcerer-Thane Thaurissan
				{3, 92163}, -- Scimitar of the Sirocco
				{4, 98533}, -- Extinct Turtle Shell
				{5, 92139}, -- Staff of Ammunae
				{16, 92168}, -- Ring of the Boy Emperor
				{18, 91757}, -- Tyrande's Favorite Doll
			},
		},
		{
			name = AL["Leveling Gear"],
			[NORMAL_DIFF] = {
				{1, 90997}, -- Nifflevar Bearded Axe
				{16, 90843}, -- Headdress of the First Shaman
				{17, 90616}, -- Queen Azshara's Dressing Gown
			},
		},
		{
			name = AL["Toys"],
			[NORMAL_DIFF] = {
				{1, 91214}, -- Blessing of the Old God
				{2, 91761}, -- Bones of Transformation
				{3, 91215}, -- Puzzle Box of Yogg-Saron
				{4, 91773}, -- Wisp Amulet
				{5, 92145}, -- Pendant of the Scarab Storm
				{16, 90984}, -- The Last Relic of Argus
				{17, 91226}, -- The Innkeeper's Daughter
				{18, 98493}, -- Druid and Priest Statue Set
				{19, 90553}, -- Chalice of the Mountain Kings
				{20, 90464}, -- Highborne Soul Mirror
				{21, 90983}, -- Arrival of the Naaru
				{22, 90614}, -- Kaldorei Wind Chimes
				{23, 98560}, -- Ancient Amber
				{24, 98556}, -- Haunted War Drum
				{25, 98569}, -- Vrykul Drinking Horn
			},
		},
		{
			name = AL["Mounts"],
			[NORMAL_DIFF] = {
				{1, 92148}, -- Scepter of Azj'Aqir
				{2, 90619}, -- Fossilized Raptor
			},
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{1, 92137}, -- Crawling Claw
				{3, 98588}, -- Voodoo Figurine
				{4, 98582}, -- Pterrordax Hatchling
				{5, 90521}, -- Clockwork Gnome
				{6, 89693}, -- Fossilized Hatchling
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{1, 91790}, -- Canopic Jar
			}
		},
	}
}
