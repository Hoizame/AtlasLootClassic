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
				{ 1, 99652 }, -- Brainsplinter
				{ 2, 76453 }, -- Elementium Shank
				{ 3, 76434 }, -- Cold Forged Shank
			}
		},
		{ -- Axes
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 99655 },   -- Elementium-Edged Scalper
				{ 3, 76452 },	-- Elementium Bonesplitter
				{ 4, 94718 },	-- Elementium Gutslicer
				{ 5, 76433 },	-- Decapitator's Razor
			}
		},
		{ -- Maces
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 99654 }, -- Lightforged Elementium Hammer
				{ 3, 76450 }, -- Elementium Hammer
				{ 4, 76436 }, -- Lifeforce Hammer
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
				{ 17, 99658 }, -- Masterwork Elementium Deathblade
				{ 18, 76437 }, -- Obsidian Executioner
			}
		},
		{ -- Polearms
			name = AL["Weapons"].." - "..AL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_06", nil, ALIL["Polearms"] },
				{ 2, 99660 }, -- Witch Hunter's Harvester
				{ 3, 76451 }, -- Elementium Poleaxe
				{ 4, 76474 }, -- Obsidium Bladespear
			}
		},
		{ -- Shield
			name = AL["Weapons"].." - "..ALIL["Shield"],
			[NORMAL_DIFF] = {
				{ 1, 76454 }, -- Elementium Earthguard
				{ 2, 76455 }, -- Elementium Stormshield
				{ 3, 76293 }, -- Stormforged Shield
				{ 4, 76291 }, -- Hardened Obsidium Shield
			}
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[PLATE_DIFF] = {
				{ 1, 76463 },	-- Vicious Pyrium Helm
				{ 2, 76471 },	-- Vicious Ornate Pyrium Helm
				{ 3, 76288 },	-- Stormforged Helm
				{ 4, 76260 },	-- Hardened Obsidium Helm
				{ 5, 76269 },	-- Redsteel Helm
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[PLATE_DIFF] = {
				{ 1, 76461 },	-- Vicious Pyrium Shoulders
				{ 2, 76469 },	-- Vicious Ornate Pyrium Shoulders
				{ 3, 76286 },	-- Stormforged Shoulders
				{ 4, 76258 },	-- Hardened Obsidium Shoulders
				{ 5, 76266 },	-- Redsteel Shoulders
			},
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[PLATE_DIFF] = {
				{ 1, 76443 },	-- Hardened Elementium Hauberk
				{ 2, 76445 },	-- Elementium Deathplate
				{ 3, 76447 },	-- Light Elementium Chestguard
				{ 4, 76472 },	-- Vicious Ornate Pyrium Breastplate
				{ 5, 76464 },	-- Vicious Pyrium Breastplate
				{ 6, 76270 },	-- Redsteel Breastplate
				{ 7, 76289 },	-- Stormforged Breastplate
				{ 8, 76261 },	-- Hardened Obsidium Breastplate
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[PLATE_DIFF] = {
				{ 1, 99452 }, -- Warboots of Mighty Lords
				{ 2, 99453 }, -- Mirrored Boots
				{ 3, 99454 }, -- Emberforged Elementium Boots
				{ 4, 76459 }, -- Vicious Pyrium Boots
				{ 5, 76468 }, -- Vicious Ornate Pyrium Boots
				{ 6, 76265 }, -- Redsteel Boots
				{ 7, 76285 }, -- Stormforged Boots
				{ 8, 76182 }, -- Hardened Obsidium Boots
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[PLATE_DIFF] = {
				{ 1, 99439 }, -- Fists of Fury
				{ 2, 99440 }, -- Eternal Elementium Handguards
				{ 3, 99441 }, -- Holy Flame Gauntlets
				{ 4, 76466 }, -- Vicious Ornate Pyrium Gauntlets
				{ 5, 76457 }, -- Vicious Pyrium Gauntlets
				{ 6, 76281 }, -- Stormforged Gauntlets
				{ 7, 76180 }, -- Hardened Obsidium Gauntlets
				{ 8, 76263 }, -- Redsteel Gauntlets
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[PLATE_DIFF] = {
				{ 1, 101924 }, -- Pyrium Legplates of Purified Evil
				{ 2, 101925 }, -- Unstoppable Destroyer's Legplates
				{ 3, 101928 }, -- Foundations of Courage
				{ 4, 76470 },  -- Vicious Ornate Pyrium Legguards
				{ 5,76462 },   -- Vicious Pyrium Legguards
				{ 6, 76287 },  -- Stormforged Legguards
				{ 7, 76267 },  -- Redsteel Legguards
				{ 8, 76259 },  -- Hardened Obsidium Legguards
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[PLATE_DIFF] = {
				{ 1, 76444 }, -- Hardened Elementium Girdle
				{ 2, 76446 }, -- Elementium Girdle of Pain
				{ 3, 76448 }, -- Light Elementium Belt
				{ 4, 76467 }, -- Vicious Ornate Pyrium Belt
				{ 5, 76458 }, -- Vicious Pyrium Belt
				{ 6, 76264 }, -- Redsteel Belt
				{ 7, 76283 }, -- Stormforged Belt
				{ 8, 76181 }, -- Hardened Obsidium Belt
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[PLATE_DIFF] = {
				{ 1, 101929 }, -- Soul Redeemer Bracers
				{ 2, 101931 }, -- Bracers off DEstructive Strength
				{ 3, 101932 }, -- Titanguard Wristplates
				{ 4, 76456 }, -- Vicious Pyrium Bracers
				{ 5, 76465 }, -- Vicious Ornate Pyrium Bracers
				{ 6, 76179 }, -- Hardened Obsidium Bracers
				{ 7, 76262 }, -- Redsteel Bracers
				{ 8, 76280 }, -- Stormforged Bracers
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
				{ 1, 81725 }, -- Lightweight Bio-Optic Killshades
				{ 3, 84406 }, -- Authentic Jr. Engineer Goggles
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 81724 },	-- Camouflage Bio-Optic Killshades
				{ 2, 81722 },	-- Agile Bio-Optic Killshades
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 81720 },	-- Energized Bio-Optic Killshades
				{ 2, 81716 },	-- Deadly Bio-Optic Killshades
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 81715 },	-- Specialized Bio-Optic Killshades
				{ 2, 81714 },	-- Reinforced Bio-Optic Killshades
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 84418 },	-- Elementium Dragonling
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 84428 },	-- Gnomish X-Ray Scope
				{ 2, 100587 },	-- Flintlocke's Woodchucker
				{ 3, 84408 },	-- R19 Threatfinder
				{ 4, 84410 },	-- Safety Catch Removal Kit
			}
		},
		{
			name = AL["Weapons"],
			[NORMAL_DIFF] = {
				{ 1, 100687 },	-- Extreme-Impact Hole Puncher
				{ 2, 84432 },	-- Kickback 5000
				{ 3, 84431 },	-- Overpowered Chicken Splitter
				{ 4, 84420 },	-- Finely-Tuned Throat Needler
				{ 16, 84411 },	-- High-Powered Bolt Gun
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 94748 },	-- Electrified Ether
				{ 2, 84403 },	-- Handful of Obsidium Bolts
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 95707 },	-- Big Daddy
				{ 2, 84409 },	-- Volatile Seaforium Blastpack
			}
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 82175 },	-- Synapse Springs
				{ 2, 82177 },	-- Quickflip Deflection Plates
				{ 3, 82180 },	-- Tazik Shocker
				{ 4, 82200 },	-- Spinal Healing Injector
				{ 5, 82201 },	-- Z50 Mana Gulper
				{ 6, 84424 },	-- Invisibility Field
				{ 7, 84425 },	-- Cardboard Assassin
				{ 8, 84427 },	-- Grounded Plasma Shield
				{ 16, 84430 },	-- Heat-Treated Spinning Lure
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 84412 },   -- Personal World Destroyer
				{ 2, 84413 },	-- De-Weaponized Mechanical Companion
				{ 4, 84421 },	-- Loot-a-Rang
				{ 5, 95705 },	-- Gnomish Gravity Well
				{ 7, 95703 },	-- Electrostatic Condenser
				{ 9, 84429 },	-- Goblin Barbecue
				{ 11, 84416 },	-- Elementium Toolbox
				{ 12, 84415 },	-- Lure Master Tackle Box
			}
		},
	}
}

data["LeatherworkingCata"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{ -- Cloak
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 78475 },	-- Razor-Edged Cloak
				{ 2, 78476 },	-- Twilight Dragonscale Cloak
				{ 3, 99536 },   -- Vicious Fur Cloak
				{ 4, 99535 },	-- Vicious Hide Cloak
				{ 5, 78439 },	-- Cloak of War
				{ 6, 78438 },	-- Cloak of Beasts
				{ 7, 78405 },	-- Hardened Scale Cloak
				{ 8, 78380 },	-- Savage Cloak
			}
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 78480 },	-- Vicious Wyrmhide Helm
				{ 2, 78469 },	-- Vicious Leather Helm
				{ 3, 78424 },	-- Darkbrand Helm
			},
			[MAIL_DIFF] = {
				{ 1, 78484 },	-- Vicious Charscale Helm
				{ 2, 78474 },	-- Vicious Dragonscale Helm
				{ 3, 78432 },	-- Tsunami Helm
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 78464 },	-- Vicious Wyrmhide Shoulders
				{ 2, 78455 },	-- Vicious Leather Shoulders
				{ 3, 78411 },	-- Darkbrand Shoulders
			},
			[MAIL_DIFF] = {
				{ 1, 78470 },	-- Vicious Charscale Shoulders
				{ 2, 78451 },	-- Vicious Dragonscale Shoulders
				{ 3, 78415 },	-- Tsunami Shoulders
			},
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, 78487 },	-- Chestguard of Nature's Fury
				{ 2, 78488 },	-- Assassin's Chestplate
				{ 3, 78481 },	-- Vicious Leather Chest
				{ 4, 78467 },	-- Vicious Wyrmhide Chest
				{ 5, 78428 },	-- Darkbrand Chestguard
			},
			[MAIL_DIFF] = {
				{ 1, 78489 },	-- Twilight Scale Chestguard
				{ 2, 78490 },	-- Dragonkiller Tunic
				{ 3, 78486 },	-- Vicious Dragonscale Chest
				{ 4, 78483 },	-- Vicious Charscale Chest
				{ 5, 78423 },	-- Tsunami Chestguard
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, 101940 },	-- Bladeshadow Wristguards
				{ 2, 101937 },	-- Bracers of Flowing Serenity
				{ 3, 78444 },	-- Vicious Wyrmhide Bracers
				{ 4, 78446 },	-- Vicious Leather Bracers
				{ 5, 78398 },	-- Darkbrand Bracers
			},
			[MAIL_DIFF] = {
				{ 1, 101939 },	-- Thundering Deathscale Wristguards
				{ 2, 101941 },	-- Bracers of the Hunter-Killer
				{ 3, 78448 },	-- Vicious Charscale Bracers
				{ 4, 78450 },	-- Vicious Dragonscale Bracers
				{ 5, 78388 },	-- Tsunami Bracers
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 99446 },	-- Clutches of Evil
				{ 2, 99447 },	-- Heavenly Gloves of the Moon
				{ 3, 78452 },	-- Vicious Wyrmhide Gloves
				{ 4, 78447 },	-- Vicious Leather Gloves
				{ 5, 78399 },	-- Darkbrand Gloves
			},
			[MAIL_DIFF] = {
				{ 1, 99445 },	-- Gloves of Unforgiving Flame
				{ 2, 99443 },	-- Dragonfire Gloves
				{ 3, 78459 },	-- Vicious Dragonscale Gloves
				{ 4, 78449 },	-- Vicious Charscale Gloves
				{ 5, 78406 },	-- Tsunami Gloves
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 78460 },	-- Lightning Lash
				{ 2, 78461 },	-- Belt of Nefarious Whispers
				{ 3, 78468 },	-- Vicious Leather Belt
				{ 4, 78445 },	-- Vicious Wyrmhide Belt
				{ 5, 78416 },	-- Darkbrand Belt
			},
			[MAIL_DIFF] = {
				{ 1, 78462 },	-- Stormleather Sash
				{ 2, 78463 },	-- Corded Viper Belt
				{ 3, 78473 },	-- Vicious Dragonscale Belt
				{ 4, 78457 },	-- Vicious Charscale Belt
				{ 5, 78396 },	-- Tsunami Belt
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 101933 },	-- Leggings of Nature's Champion
				{ 2, 101935 },	-- Bladeshadow Leggings
				{ 3, 78482 },	-- Vicious Leather Legs
				{ 4, 78479 },	-- Vicious Wyrmhide Legs
				{ 5, 78433 },	-- Darkbrand Leggings
			},
			[MAIL_DIFF] = {
				{ 1, 101936 },	-- Rended Earth Leggings
				{ 2, 101934 },	-- Deathscale Leggings
				{ 3, 78485 },	-- Vicious Dragonscale Legs
				{ 4, 78471 },	-- Vicious Charscale Legs
				{ 5, 78427 },	-- Tsunami Leggings
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 99457 },	-- Treads of the Craft
				{ 2, 99458 },	-- Ethereal Footfalls
				{ 3, 78454 },	-- Vicious Leather Boots
				{ 4, 78453 },	-- Vicious Wyrmhide Boots
				{ 5, 78407 },	-- Darkbrand Boots
			},
			[MAIL_DIFF] = {
				{ 1, 99455 },	-- Earthen Scale Sabatons
				{ 2, 99456 },	-- Footwraps of Quenched Fire
				{ 3, 78456 },	-- Vicious Charscale Boots
				{ 4, 78458 },	-- Vicious Dragonscale Boots
				{ 5, 78410 },	-- Tsunami Boots
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 78477 },	-- Dragonscale Leg Armor
				{ 2, 78478 },	-- Charscale Leg Armor
				{ 3, 101599 },	-- Drakehide Leg Armor
				{ 5, 78419 },	-- Scorched Leg Armor
				{ 6, 78420 },	-- Twilight Leg Armor
				{ 8, 78379 },	-- Savage Armor Kit
				{ 16, 85007 },	-- Draconic Embossment - Stamina
				{ 17, 85008 },	-- Draconic Embossment - Agility
				{ 18, 85009 },	-- Draconic Embossment - Strength
				{ 19, 85010 },	-- Draconic Embossment - Intellect
				{ 21, 85067 },	-- Dragonbone Leg Reinforcements
				{ 22, 85068 },	-- Charscale Leg Reinforcements
				{ 23, 101600 },	-- Drakehide Leg Reinforcements
			},
		},
		{
				name = ALIL["Bag"],
				[NORMAL_DIFF] = {
					{ 1, 70136 },	-- Royal Scribe's Satchel
					{ 2, 70137 },	-- Triple-Reinforced Mining Bag
				},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 78436 },	-- Heavy Savage Leather
				{ 2, 84950 },	-- Savage Leather
			},
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 949 }, -- The Dark Brand
				{ 2, 950 }, -- The Big Wave
			},
		}
	}
}

data["TailoringCata"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{ -- Cloak
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 99537 },	-- Vicious Embersilk Cape
			}
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 75304 },	-- Vicious Fireweave Cowl
				{ 2, 75306 },	-- Vicious Embersilk Cowl
				{ 3, 75266 },	-- Spiritmend Cowl
				{ 4, 75256 },	-- Deathsilk Cowl
				{ 6, 75289 },	-- High Society Top Hat
			}
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 75292 },	-- Vicious Fireweave Shoulders
				{ 2, 75291 },	-- Vicious Embersilk Shoulders
				{ 3, 75260 },	-- Spiritmend Shoulders
				{ 4, 75251 },	-- Deathsilk Shoulders
			}
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, 75305 },	-- Vicious Embersilk Robe
				{ 2, 75303 },	-- Vicious Fireweave Robe
				{ 3, 75257 },	-- Deathsilk Robe
				{ 4, 75267 },	-- Spiritmend Robe
				{ 5, 102171 },	-- Black Silk Vest
				{ 7, 75288 },	-- Black Embersilk Gown
			}
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 101922 },	-- Dreamwraps of the Light
				{ 2, 101923 },	-- Bracers of Unconquered Power
				{ 3, 75270 },	-- Vicious Embersilk Bracers
				{ 4, 75290 },	-- Vicious Fireweave Bracers
				{ 5, 75259 },	-- Spiritmend Bracers
				{ 6, 75249 },	-- Deathsilk Bracers
			}
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 99448 },	-- Grips of Altered Reality
				{ 2, 99449 },	-- Don Tayo's Inferno Mittens
				{ 3, 75296 },	-- Vicious Fireweave Gloves
				{ 4, 75295 },	-- Vicious Embersilk Gloves
				{ 5, 75253 },	-- Deathsilk Gloves
				{ 6, 75262 },	-- Spiritmend Gloves
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 75298 },	-- Belt of the Depths
				{ 2, 75299 },	-- Dreamless Belt
				{ 3, 75269 },	-- Vicious Fireweave Belt
				{ 4, 75293 },	-- Vicious Embersilk Belt
				{ 5, 75258 },	-- Spiritmend Belt
				{ 6, 75248 },	-- Deathsilk Belt
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 101920 },	-- World Mender's Pants
				{ 2, 101921 },	-- Lavaquake Legwraps
				{ 3, 75301 },	-- Flame-Ascended Pantaloons
				{ 4, 75300 },	-- Breeches of Mended Nightmares
				{ 5, 75302 },	-- Vicious Fireweave Pants
				{ 6, 75307 },	-- Vicious Embersilk Pants
				{ 7, 75263 },	-- Spiritmend Leggings
				{ 8, 75254 },	-- Deathsilk Leggings
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 99459 },	-- Endless Dream Walkers
				{ 2, 99460 },	-- Boots of the Black Flame
				{ 3, 75297 },	-- Vicious Embersilk Boots
				{ 4, 75294 },	-- Vicious Fireweave Boots
				{ 5, 75261 },	-- Spiritmend Boots
				{ 6, 75252 },	-- Deathsilk Boots
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 75310 },	-- Powerful Ghostly Spellthread
				{ 2, 75309 },	-- Powerful Enchanted Spellthread
				{ 3, 75255 },	-- Ghostly Spellthread
				{ 4, 75250 },	-- Enchanted Spellthread
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 75308 },	-- Illusionary Bag
				{ 2, 75264 },	-- Embersilk Bag
				{ 4, 75268 },	-- Hyjal Expedition Bag
				{ 6, 100585 },	-- Luxurious Silk Gem Bag
				{ 8, 75268 },	-- Otherworldly Bag
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 75247 },	-- Embersilk Net
				{ 3, 74964 },	-- Bolt of Embersilk Cloth
				{ 16, 75146 },	-- Dream of Azshara
				{ 17, 94743 },	-- Dream of Destruction
				{ 18, 75141 },	-- Dream of Skywall
				{ 19, 75145 },	-- Dream of Ragnaros
				{ 20, 75144 },	-- Dream of Hyjal
				{ 21, 75142 },	-- Dream of Deepholm
			},
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 944 }, -- Spiritmender
				{ 2, 945 }, -- Deathspeaker
			},
		}
	}
}

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
