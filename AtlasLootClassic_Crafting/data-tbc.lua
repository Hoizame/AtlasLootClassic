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
if AtlasLoot:GameVersion_LT(AtlasLoot.BC_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.BC_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)

local SPLIT_FORMAT = "%s - %s"

local GEM_FORMAT1 = ALIL["Gems"].." - %s"
local GEM_FORMAT2 = ALIL["Gems"].." - %s & %s"

data["AlchemyBC"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ALCHEMY_LINK,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 28591 }, -- Flask of Pure Death (390)
				{ 2, 28589 }, -- Flask of Relentless Assault (390)
				{ 3, 28588 }, -- Flask of Mighty Restoration (390)
				{ 4, 28587 }, -- Flask of Fortification (390)
				{ 5, 28590 }, -- Flask of Blinding Light (390)
				{ 6, 42736 }, -- Flask of Chromatic Wonder (375)
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 28581 }, -- Transmute: Primal Water to Shadow (385)
				{ 2, 28580 }, -- Transmute: Primal Shadow to Water (385)
				{ 3, 28582 }, -- Transmute: Primal Mana to Fire (385)
				{ 4, 28584 }, -- Transmute: Primal Life to Earth (385)
				{ 5, 28583 }, -- Transmute: Primal Fire to Mana (385)
				{ 6, 28585 }, -- Transmute: Primal Earth to Life (385)
				{ 7, 32766 }, -- Transmute: Skyfire Diamond (350)
				{ 8, 32765 }, -- Transmute: Earthstorm Diamond (350)
				{ 9, 29688 }, -- Transmute: Primal Might (350)
				{ 10, 28569 }, -- Transmute: Primal Water to Air (350)
				{ 11, 28568 }, -- Transmute: Primal Fire to Earth (350)
				{ 12, 28567 }, -- Transmute: Primal Earth to Water (350)
				{ 13, 28566 }, -- Transmute: Primal Air to Fire (350)
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1, 28586 }, -- Super Rejuvenation Potion (390)
				{ 3, 28551 }, -- Super Healing Potion (340)
				{ 4, 33732 }, -- Volatile Healing Potion (315)


				{ 16, 38961 }, -- Fel Mana Potion (360)
				{ 17, 28555 }, -- Super Mana Potion (340)
				{ 18, 33733 }, -- Unstable Mana Potion (325)
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 28576 }, -- Major Shadow Protection Potion (360)
				{ 2, 28573 }, -- Major Nature Protection Potion (360)
				{ 3, 28577 }, -- Major Holy Protection Potion (360)
				{ 4, 28572 }, -- Major Frost Protection Potion (360)
				{ 5, 28571 }, -- Major Fire Protection Potion (360)
				{ 6, 28575 }, -- Major Arcane Protection Potion (360)
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 28579 }, -- Ironshield Potion (365)
				{ 2, 28565 }, -- Destruction Potion (350)
				{ 3, 28564 }, -- Haste Potion (350)
				{ 4, 28563 }, -- Heroic Potion (350)
				{ 5, 28562 }, -- Major Dreamless Sleep Potion (350)
				{ 6, 38962 }, -- Fel Regeneration Potion (345)
				{ 7, 45061 }, -- Mad Alchemist's Potion (335)
				{ 8, 28554 }, -- Shrouding Potion (335)
				{ 9, 28550 }, -- Insane Strength Potion (320)
				{ 10, 28546 }, -- Sneaking Potion (315)
			},
		},
		{
			name = AL["Elixirs"],
			[NORMAL_DIFF] = {
				--{ 1, 11478 }, --Elixir of Detect Demon
				{ 1, 28578 }, -- Elixir of Empowerment (365)
				{ 2, 28570 }, -- Elixir of Major Mageblood (355)
				{ 3, 28558 }, -- Elixir of Major Shadow Power (350)
				{ 4, 28557 }, -- Elixir of Major Defense (345)
				{ 5, 28556 }, -- Elixir of Major Firepower (345)
				{ 6, 39638 }, -- Elixir of Draenic Wisdom (335)
				{ 7, 38960 }, -- Fel Strength Elixir (335)
				{ 8, 39639 }, -- Elixir of Ironskin (330)
				{ 9, 33741 }, -- Elixir of Mastery (330)
				{ 10, 28553 }, -- Elixir of Major Agility (330)
				{ 11, 39636 }, -- Elixir of Major Fortitude (325)
				{ 12, 28552 }, -- Elixir of the Searching Eye (325)
				{ 13, 28545 }, -- Elixir of Healing Power (325)
				{ 14, 39637 }, -- Earthen Elixir (320)
				{ 15, 28549 }, -- Elixir of Major Frost Power (320)
				{ 16, 28544 }, -- Elixir of Major Strength (320)
				{ 17, 33740 }, -- Adept's Elixir (315)
				{ 18, 33738 }, -- Onslaught Elixir (315)
				{ 19, 28543 }, -- Elixir of Camouflage (305)
			},
		},
		{
			name = AL["Cauldrons"],
			[NORMAL_DIFF] = {
				{ 1, 41503 }, -- Cauldron of Major Shadow Protection (360)
				{ 2, 41502 }, -- Cauldron of Major Nature Protection (360)
				{ 3, 41501 }, -- Cauldron of Major Frost Protection (360)
				{ 4, 41500 }, -- Cauldron of Major Fire Protection (360)
				{ 5, 41458 }, -- Cauldron of Major Arcane Protection (360)
			},
		},
		{
			name = AL["Stones"],
			[NORMAL_DIFF] = {
				{ 1, 47048 }, -- Sorcerer's Alchemist Stone (375)
				{ 2, 47049 }, -- Redeemer's Alchemist Stone (375)
				{ 3, 47046 }, -- Guardian's Alchemist Stone (375)
				{ 4, 47050 }, -- Assassin's Alchemist Stone (375)
				{ 16, 38070 }, -- Mercurial Stone (340)
			},
		},
	},
}

data["BlacksmithingBC"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.BLACKSMITHING_LINK,
	items = {
		{
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1, 29698 }, -- Eternium Runed Blade (365)
				{ 2, 29699 }, -- Dirge (365)
				{ 3, 29569 }, -- Adamantite Dagger (330)
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 36260 }, -- Wicked Edge of the Planes (385)
				{ 3, 34542 }, -- Black Planar Edge (385)
				{ 4, 34541 }, -- The Planar Edge (360)
				{ 6, 29694 }, -- Fel Edged Battleaxe (365)
				{ 7, 36134 }, -- Stormforged Axe (340)
				{ 8, 29557 }, -- Fel Iron Hatchet (320)
				{ 10, 36126 }, -- Light Skyforged Axe (280)
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 36261 }, -- Bloodmoon (385)
				{ 18, 34544 }, -- Mooncleaver (385)
				{ 19, 34543 }, -- Lunar Crescent (360)
				{ 21, 29695 }, -- Felsteel Reaper (365)
				{ 22, 29568 }, -- Adamantite Cleaver (330)
				{ 23, 36135 }, -- Skyforged Great Axe (340)
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 36262 }, -- Dragonstrike (385)
				{ 3, 34546 }, -- Dragonmaw (385)
				{ 4, 34545 }, -- Drakefist Hammer (360)
				{ 6, 29700 }, -- Hand of Eternity (365)
				{ 7, 29696 }, -- Runic Hammer (365)
				{ 8, 36136 }, -- Lavaforged Warhammer (340)
				{ 9, 29558 }, -- Fel Iron Hammer (325)
				{ 11, 36128 }, -- Light Emberforged Hammer (280)
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 36263 }, -- Stormherald (385)
				{ 18, 34548 }, -- Deep Thunder (385)
				{ 19, 34547 }, -- Thunder (360)
				{ 21, 43846 }, -- Hammer of Righteous Might (365)
				{ 22, 29697 }, -- Fel Hardened Maul (365)
				{ 23, 36137 }, -- Great Earthforged Hammer (340)
				{ 24, 29566 }, -- Adamantite Maul (325)
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2, 36258 }, -- Blazefury (385)
				{ 3, 34537 }, -- Blazeguard (385)
				{ 4, 34535 }, -- Fireguard (360)
				{ 6, 29692 }, -- Felsteel Longblade (365)
				{ 7, 29571 }, -- Adamantite Rapier (335)
				{ 8, 36131 }, -- Windforged Rapier (340)
				{ 10, 36125 }, -- Light Earthforged Blade (280)
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 36259 }, -- Lionheart Executioner (385)
				{ 18, 34540 }, -- Lionheart Champion (385)
				{ 19, 34538 }, -- Lionheart Blade (360)
				{ 21, 29693 }, -- Khorium Champion (365)
				{ 22, 36133 }, -- Stoneforged Claymore (340)
				{ 23, 29565 }, -- Fel Iron Greatsword (330)
				{ 25, 43549 }, -- Heavy Copper Longsword (35)
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Thrown"],
			[NORMAL_DIFF] = {
				{ 1, 34983 }, -- Felsteel Whisper Knives (360)
				{ 2, 34982 }, -- Enchanted Thorium Blades (320)
				{ 4, 34981 }, -- Whirling Steel Axes (220)
				{ 5, 34979 }, -- Thick Bronze Darts (130)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[MAIL_DIFF] = {
				{ 1, 29663 }, -- Storm Helm (365)
				{ 2, 29551 }, -- Fel Iron Chain Coif (310)
			},
			[PLATE_DIFF] = {
				{ 1, 38479 }, -- Iceguard Helm (375)
				{ 2, 38476 }, -- Wildguard Helm (375)
				{ 3, 29668 }, -- Oathkeeper's Helm (365)
				{ 4, 29664 }, -- Helm of the Stalwart Defender (365)
				{ 5, 29643 }, -- Ragesteel Helm (365)
				{ 6, 29621 }, -- Felsteel Helm (365)
				{ 7, 29615 }, -- Flamebane Helm (355)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[PLATE_DIFF] = {
				{ 1, 41135 }, -- Dawnsteel Shoulders (375)
				{ 2, 41133 }, -- Swiftsteel Shoulders (375)
				{ 3, 42662 }, -- Ragesteel Shoulders (365)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[MAIL_DIFF] = {
				{ 1, 36256 }, -- Embrace of the Twisting Nether (385)
				{ 2, 34530 }, -- Twisting Nether Chain Shirt (385)
				{ 3, 34529 }, -- Nether Chain Shirt (360)

				{ 16, 29649 }, -- Earthpeace Breastplate (370)
				{ 17, 36130 }, -- Stormforged Hauberk (340)
				{ 18, 29556 }, -- Fel Iron Chain Tunic (330)
			},
			[PLATE_DIFF] = {
				{ 1, 36257 }, -- Bulwark of the Ancient Kings (385)
				{ 2, 34534 }, -- Bulwark of Kings (385)
				{ 3, 34533 }, -- Breastplate of Kings (360)

				{ 16, 38477 }, -- Iceguard Breastplate (375)
				{ 17, 38473 }, -- Wildguard Breastplate (375)
				{ 18, 29645 }, -- Ragesteel Breastplate (370)
				{ 19, 46144 }, -- Hard Khorium Battleplate (365)
				{ 20, 46142 }, -- Sunblessed Breastplate (365)
				{ 21, 29617 }, -- Flamebane Breastplate (365)
				{ 22, 29610 }, -- Enchanted Adamantite Breastplate (360)
				{ 23, 29606 }, -- Adamantite Breastplate (340)
				{ 24, 36129 }, -- Heavy Earthforged Breastplate (340)
				{ 25, 29550 }, -- Fel Iron Breastplate (335)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[PLATE_DIFF] = {
				{ 1, 40033 }, -- Shadesteel Sabots (375)
				{ 2, 36392 }, -- Red Havoc Boots (375)
				{ 3, 36391 }, -- Boots of the Protector (375)
				{ 4, 29630 }, -- Khorium Boots (365)
				{ 5, 29611 }, -- Enchanted Adamantite Boots (355)
				{ 6, 29548 }, -- Fel Iron Plate Boots (325)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[MAIL_DIFF] = {
				{ 1, 29648 }, -- Swiftsteel Gloves (370)
				{ 2, 29658 }, -- Felfury Gauntlets (365)
				{ 3, 29552 }, -- Fel Iron Chain Gloves (320)
			},
			[PLATE_DIFF] = {
				{ 1, 46141 }, -- Hard Khorium Battlefists (365)
				{ 2, 46140 }, -- Sunblessed Gauntlets (365)
				{ 3, 29642 }, -- Ragesteel Gloves (365)
				{ 4, 29662 }, -- Steelgrip Gauntlets (365)
				{ 5, 29622 }, -- Gauntlets of the Iron Tower (365)
				{ 6, 29616 }, -- Flamebane Gloves (360)
				{ 7, 29619 }, -- Felsteel Gloves (360)
				{ 8, 29605 }, -- Adamantite Plate Gloves (335)
				{ 9, 29545 }, -- Fel Iron Plate Gloves (310)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[MAIL_DIFF] = {
				{ 1, 36124 }, -- Windforged Leggings (280)
			},
			[PLATE_DIFF] = {
				{ 1, 40035 }, -- Shadesteel Greaves (375)
				{ 2, 38478 }, -- Iceguard Leggings (375)
				{ 3, 38475 }, -- Wildguard Leggings (375)
				{ 4, 29613 }, -- Enchanted Adamantite Leggings (365)
				{ 5, 29620 }, -- Felsteel Leggings (360)
				{ 6, 29629 }, -- Khorium Pants (360)
				{ 7, 29549 }, -- Fel Iron Plate Pants (325)
				{ 9, 36122 }, -- Earthforged Leggings (280)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[PLATE_DIFF] = {
				{ 1, 40036 }, -- Shadesteel Girdle (375)
				{ 2, 36390 }, -- Red Belt of Battle (375)
				{ 3, 36389 }, -- Belt of the Guardian (375)
				{ 4, 29628 }, -- Khorium Belt (360)
				{ 5, 29608 }, -- Enchanted Adamantite Belt (355)
				{ 6, 29547 }, -- Fel Iron Plate Belt (315)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[PLATE_DIFF] = {
				{ 1, 41134 }, -- Dawnsteel Bracers (375)
				{ 2, 41132 }, -- Swiftsteel Bracers (375)
				{ 3, 40034 }, -- Shadesteel Bracers (375)
				{ 4, 29672 }, -- Blessed Bracers (365)
				{ 5, 29671 }, -- Bracers of the Green Fortress (365)
				{ 6, 29669 }, -- Black Felsteel Bracers (365)
				{ 7, 29614 }, -- Flamebane Bracers (350)
				{ 8, 29603 }, -- Adamantite Plate Bracers (335)
				{ 9, 29553 }, -- Fel Iron Chain Bracers (325)
			},
		},
		{
			name = ALIL["Armorsmith"],
			[MAIL_DIFF] = {
				{ 1, 36256 },	-- Embrace of the Twisting Nether
				{ 2, 34530 },	-- Twisting Nether Chain Shirt
				{ 3, 34529 },	-- Nether Chain Shirt
				{ 4, 36130 },	-- Stormforged Hauberk
				{ 5, 36124 },	-- Windforged Leggings
			},
			[PLATE_DIFF] = {
				{ 1, 55186 },	-- Chestplate of Conquest
				{ 2, 55187 },	-- Legplates of Conquest
				{ 3, 36257 },	-- Bulwark of the Ancient Kings
				{ 4, 34534 },	-- Bulwark of Kings
				{ 5, 34533 },	-- Breastplate of Kings
				{ 6, 36129 },	-- Heavy Earthforged Breastplate
				{ 7, 36122 },	-- Earthforged Leggings
			},
		},
		{
			name = ALIL["Weaponsmith"],
			[NORMAL_DIFF] = {
				{ 1, 55185 },	-- Saronite Mindcrusher
				{ 2, 55184 },	-- Corroded Saronite Woundbringer
				{ 3, 55183 },	-- Corroded Saronite Edge
				{ 4, 36126 },	-- Light Skyforged Axe
				{ 5, 36128 },	-- Light Emberforged Hammer
				{ 6, 36125 },	-- Light Earthforged Blade
			},
		},
		{
			name = ALIL["Axesmith"],
			[NORMAL_DIFF] = {
				{ 1, 36260 },	-- Wicked Edge of the Planes
				{ 2, 36261 },	-- Bloodmoon
				{ 3, 34542 },	-- Black Planar Edge
				{ 4, 34544 },	-- Mooncleaver
				{ 5, 34541 },	-- The Planar Edge
				{ 6, 34543 },	-- Lunar Crescent
				{ 7, 36134 },	-- Stormforged Axe
				{ 8, 36135 },	-- Skyforged Great Axe
			},
		},
		{
			name = ALIL["Hammersmith"],
			[NORMAL_DIFF] = {
				{ 1, 36262 },	-- Dragonstrike
				{ 2, 36263 },	-- Stormherald
				{ 3, 34546 },	-- Dragonmaw
				{ 4, 34548 },	-- Deep Thunder
				{ 5, 34545 },	-- Drakefist Hammer
				{ 6, 34547 },	-- Thunder
				{ 7, 36136 },	-- Lavaforged Warhammer
				{ 8, 36137 },	-- Great Earthforged Hammer
			},
		},
		{
			name = ALIL["Swordsmith"],
			[NORMAL_DIFF] = {
				{ 1, 36258 },	-- Blazefury
				{ 2, 36259 },	-- Lionheart Executioner
				{ 3, 34537 },	-- Blazeguard
				{ 4, 34540 },	-- Lionheart Champion
				{ 5, 34535 },	-- Fireguard
				{ 6, 34538 },	-- Lionheart Blade
				{ 7, 36131 },	-- Windforged Rapier
				{ 8, 36133 },	-- Stoneforged Claymore
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 32657 }, -- Eternium Rod (375)
				{ 2, 32656 }, -- Adamantite Rod (350)
				{ 3, 32655 }, -- Fel Iron Rod (300)
				{ 5, 34608 }, -- Adamantite Weightstone (350)
				{ 6, 34607 }, -- Fel Weightstone (300)
				{ 8, 29729 }, -- Greater Ward of Shielding (375)
				{ 9, 29728 }, -- Lesser Ward of Shielding (340)
				{ 16, 42688 }, -- Adamantite Weapon Chain (335)
				{ 18, 29657 }, -- Felsteel Shield Spike (360)
				{ 20, 29656 }, -- Adamantite Sharpening Stone (350)
				{ 21, 29654 }, -- Fel Sharpening Stone (300)
				{ 23, 32285 }, -- Greater Rune of Warding (350)
				{ 24, 32284 }, -- Lesser Rune of Warding (325)
			},
		},
	}
}

data["EnchantingBC"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENCHANTING_LINK,
	items = {
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 42974 }, -- Enchant Weapon - Executioner (375)
				{ 2, 27982 }, -- Enchant Weapon - Soulfrost (375)
				{ 3, 27981 }, -- Enchant Weapon - Sunfire (375)
				{ 4, 27984 }, -- Enchant Weapon - Mongoose (375)
				{ 5, 28003 }, -- Enchant Weapon - Spellsurge (360)
				{ 6, 28004 }, -- Enchant Weapon - Battlemaster (360)
				{ 7, 46578 }, -- Enchant Weapon - Deathfrost (350)
				{ 8, 42620 }, -- Enchant Weapon - Greater Agility (350)
				{ 9, 34010 }, -- Enchant Weapon - Major Healing (350)
				{ 10, 27975 }, -- Enchant Weapon - Major Spellpower (350)
				{ 11, 27972 }, -- Enchant Weapon - Potency (350)
				{ 12, 27968 }, -- Enchant Weapon - Major Intellect (340)
				{ 13, 27967 }, -- Enchant Weapon - Major Striking (340)
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 27977 }, -- Enchant 2H Weapon - Major Agility (360)
				{ 2, 27971 }, -- Enchant 2H Weapon - Savagery (350)
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 47051 }, -- Enchant Cloak - Steelweave (375)
				{ 2, 34006 }, -- Enchant Cloak - Greater Shadow Resistance (350)
				{ 3, 34005 }, -- Enchant Cloak - Greater Arcane Resistance (350)
				{ 4, 27962 }, -- Enchant Cloak - Major Resistance (330)
				{ 5, 34003 }, -- Enchant Cloak - Spell Penetration (325)
				{ 6, 34004 }, -- Enchant Cloak - Greater Agility (320)
				{ 7, 27961 }, -- Enchant Cloak - Major Armor (320)
				{ 8, 25086 }, -- Enchant Cloak - Dodge (320)
				{ 9, 25081 }, -- Enchant Cloak - Greater Fire Resistance (320)
				{ 10, 25082 }, --Enchant Cloak - Greater Nature Resistance (320)
				{ 11, 25084 }, --Enchant Cloak - Subtlety (320)
				{ 12, 25083 }, --Enchant Cloak - Stealth (320)
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 46594 }, -- Enchant Chest - Defense (360)
				{ 2, 33992 }, -- Enchant Chest - Major Resilience (345)
				{ 3, 27960 }, -- Enchant Chest - Exceptional Stats (345)
				{ 4, 33990 }, -- Enchant Chest - Major Spirit (330)
				--{ 5, 27958 }, -- Enchant Chest - Exceptional Mana (325) (Never added to the retail game)
				{ 5, 27957 }, -- Enchant Chest - Exceptional Health (325)
				{ 6, 33991 }, -- Enchant Chest - Restore Mana Prime (310)
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 27954 }, -- Enchant Boots - Surefooted (370)
				{ 2, 34008 }, -- Enchant Boots - Boar's Speed (360)
				{ 3, 34007 }, -- Enchant Boots - Cat's Swiftness (360)
				{ 4, 27951 }, -- Enchant Boots - Dexterity (340)
				{ 5, 27950 }, -- Enchant Boots - Fortitude (320)
				{ 6, 27948 }, -- Enchant Boots - Vitality (305)
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 33997 }, -- Enchant Gloves - Major Spellpower (360)
				{ 2, 33994 }, -- Enchant Gloves - Spell Strike (360)
				{ 3, 33999 }, -- Enchant Gloves - Major Healing (350)
				{ 4, 33995 }, -- Enchant Gloves - Major Strength (350)
				{ 5, 33996 }, -- Enchant Gloves - Assault (320)
				{ 6, 33993 }, -- Enchant Gloves - Blasting (315)
				{ 7, 25080 }, -- Enchant Gloves - Superior Agility (320)
				{ 8, 25072 }, -- Enchant Gloves - Threat (320)
			}
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 27947 }, -- Enchant Shield - Resistance (360)
				{ 2, 44383 }, -- Enchant Shield - Resilience (340)
				{ 3, 27946 }, -- Enchant Shield - Shield Block (340)
				{ 4, 34009 }, -- Enchant Shield - Major Stamina (325)
				{ 5, 27945 }, -- Enchant Shield - Intellect (325)
				{ 6, 27944 }, -- Enchant Shield - Tough Shield (320)
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 27917 }, -- Enchant Bracer - Spellpower (360)
				{ 2, 27914 }, -- Enchant Bracer - Fortitude (350)
				{ 3, 27913 }, -- Enchant Bracer - Restore Mana Prime (335)
				{ 4, 27911 }, -- Enchant Bracer - Superior Healing (325)
				{ 5, 27905 }, -- Enchant Bracer - Stats (325)
				{ 6, 27906 }, -- Enchant Bracer - Major Defense (320)
				{ 7, 34001 }, -- Enchant Bracer - Major Intellect (315)
				{ 8, 27899 }, -- Enchant Bracer - Brawn (315)
				{ 9, 34002 }, -- Enchant Bracer - Assault (310)
			}
		},
		{
			name = AL["Ring"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 27927 }, -- Enchant Ring - Stats (375)
				{ 2, 27926 }, -- Enchant Ring - Healing Power (370)
				{ 3, 27924 }, -- Enchant Ring - Spellpower (360)
				{ 4, 27920 }, -- Enchant Ring - Striking (360)
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 28019 }, -- Superior Wizard Oil (340)
				{ 2, 28016 }, -- Superior Mana Oil (310)
				{ 5, 45765 }, -- Void Shatter (375)
				{ 6, 28022 }, -- Large Prismatic Shard (335)
				{ 7, 42615 }, -- Small Prismatic Shard (315)
				{ 8, 42613 }, -- Nexus Transformation (295)
				--{ 10, 28021 }, -- Arcane Dust (undefined) (Never added to the retail game)
				{ 16, 32667 }, -- Runed Eternium Rod (375)
				{ 17, 32665 }, -- Runed Adamantite Rod (350)
				{ 18, 32664 }, -- Runed Fel Iron Rod (310)
				{ 20, 28028 }, -- Void Sphere (360)
				{ 21, 28027 }, -- Prismatic Sphere (325)
			}
		},
	}
}

data["EngineeringBC"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENGINEERING_LINK,
	items = {
		{
			name = AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 46697 }, -- Rocket Boots Xtreme Lite (355)
				{ 2, 30556 }, -- Rocket Boots Xtreme (355)
				{ 16, 30570 }, -- Nigh-Invulnerability Belt (360)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 46111 }, -- Annihilator Holo-Gogs (375)
				{ 2, 41320 }, -- Destruction Holo-gogs (370)
				{ 16, 46108 }, -- Powerheal 9000 Lens (375)
				{ 17, 41321 }, -- Powerheal 4000 Lens (370)
				{ 4, 30565 }, -- Foreman's Enchanted Helmet (375)
				{ 5, 30574 }, -- Gnomish Power Goggles (375)
				{ 6, 30318 }, -- Ultra-Spectropic Detection Goggles (350)
				{ 7, 30317 }, -- Power Amplification Goggles (340)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 46106 }, -- Wonderheal XT68 Shades (375)
				{ 2, 41318 }, -- Wonderheal XT40 Shades (370)
				{ 4, 46116 }, -- Quad Deathblow X44 Goggles (375)
				{ 5, 41317 }, -- Deathblow X11 Goggles (370)
				{ 7, 30575 }, -- Gnomish Battle Goggles (375)
				{ 8, 30325 }, -- Hyper-Vision Goggles (360)
				{ 9, 30316 }, -- Cogspinner Goggles (340)
				{ 16, 46109 }, -- Hyper-Magnified Moon Specs (375)
				{ 17, 41319 }, -- Magnified Moon Specs (370)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 46112 }, -- Lightning Etched Specs (375)
				{ 2, 41315 }, -- Gadgetstorm Goggles (370)
				{ 4, 46113 }, -- Surestrike Goggles v3.0 (375)
				{ 5, 41314 }, -- Surestrike Goggles v2.0 (370)
				{ 7, 30566 }, -- Foreman's Reinforced Helmet (375)
				{ 16, 46110 }, -- Primal-Attuned Goggles (375)
				{ 17, 41316 }, -- Living Replicator Specs (370)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 46115 }, -- Hard Khorium Goggles (375)
				{ 2, 41312 }, -- Tankatronic Goggles (370)
				{ 4, 46114 }, -- Mayhem Projection Goggles (375)
				{ 5, 40274 }, -- Furious Gizmatic Goggles (370)
				{ 16, 46107 }, -- Justicebringer 3000 Specs (375)
				{ 17, 41311 }, -- Justicebringer 2000 Specs (370)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 30563 }, -- Goblin Rocket Launcher (360)
				{ 2, 30569 }, -- Gnomish Poultryizer (360)
				{ 16, 36955 }, -- Ultrasafe Transporter - Toshley's Station (350)
				{ 17, 36954 }, -- Dimensional Ripper - Area 52 (350)
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 30334 }, -- Stabilized Eternium Scope (375)
				{ 2, 30332 }, -- Khorium Scope (360)
				{ 3, 30329 }, -- Adamantite Scope (335)
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 30315 }, -- Ornate Khorium Rifle (375)
				{ 2, 30314 }, -- Felsteel Boomstick (360)
				{ 3, 30313 }, -- Adamantite Rifle (350)
				{ 4, 30312 }, -- Fel Iron Musket (330)
			}
		},
		{
			name = ALIL["Projectile"],
			[NORMAL_DIFF] = {
				{ 1, 30347, 23773 }, -- Adamantite Shell Machine (335)
				{ 3, 30346 }, -- Fel Iron Shells (310)
				{ 16, 43676, 33803 }, -- Adamantite Arrow Maker (335)
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 30308 }, -- Khorium Power Core (350)
				{ 2, 30309 }, -- Felsteel Stabilizer (350)
				{ 3, 30307 }, -- Hardened Adamantite Tube (350)
				{ 4, 39971 }, -- Icy Blasting Primers (335)
				{ 5, 30306 }, -- Adamantite Frame (325)
				{ 6, 30303 }, -- Elemental Blasting Powder (300)
				{ 7, 30305 }, -- Handful of Fel Iron Bolts (300)
				{ 8, 30304 }, -- Fel Iron Casing (300)
				{ 10, 39895 }, -- Fused Wiring (275)
			}
		},
		{
			name = AL["Flares"],
			[NORMAL_DIFF] = {
				{ 1, 30343 }, -- Blue Smoke Flare (undefined)
				{ 2, 30342 }, -- Red Smoke Flare (undefined)
				{ 3, 32814 }, -- Purple Smoke Flare (335)
				{ 4, 30344 }, -- Green Smoke Flare (335)
				{ 5, 30341 }, -- White Smoke Flare (335)
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 39973 }, -- Frost Grenades (345)
				{ 2, 30560 }, -- Super Sapper Charge (340)
				{ 3, 30311 }, -- Adamantite Grenade (335)
				{ 4, 30558 }, -- The Bigger One (325)
				{ 5, 30310 }, -- Fel Iron Bomb (320)
				{ 16, 30568 }, -- Gnomish Flame Turret (335)
			}
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 30337 }, -- Crashin' Thrashin' Robot (325)
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 44157 }, -- Turbo-Charged Flying Machine (385)
				{ 2, 44155 }, -- Flying Machine (375)
				{ 4, 30349 }, -- Khorium Toolbox (350)
				{ 5, 30348 }, -- Fel Iron Toolbox (325)
				{ 7, 30552 }, -- Mana Potion Injector (345)
				{ 8, 30551 }, -- Healing Potion Injector (330)
				{ 10, 23078 }, -- Goblin Jumper Cables XL (265) (got updated from classic-era and is not a trinket anymore)
				{ 11, 9273 },  -- Goblin Jumper Cables (165) (got updated from classic-era and is not a trinket anymore)
				{ 16, 30548 }, -- Zapthrottle Mote Extractor (305)
				{ 18, 44391 }, -- Field Repair Bot 110G (360)
				{ 20, 30547 }, -- Elemental Seaforium Charge (350)

				-- The following Items were in the Beta but never made it into the game
				--{ 10, 30573 }, -- Gnomish Tonk Controller (undefined)
				--{ 11, 30561 }, -- Goblin Tonk Controller (undefined)
				--{ 20, 30549 }, -- Critter Enlarger (undefined)
			}
		},
	}
}

data["TailoringBC"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 40060 }, -- Night's End (375)
				{ 2, 31449 }, -- Vengeance Wrap (365)
				{ 3, 31450 }, -- Manaweave Cloak (365)
				{ 4, 31448 }, -- Resolute Cape (365)
				{ 5, 37873 }, -- Cloak of Arcane Evasion (350)
				{ 6, 31441 }, -- White Remedy Cape (350)
				{ 7, 31440 }, -- Cloak of Eternity (350)
				{ 8, 31438 }, -- Cloak of the Black Void (350)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 31456 }, -- Battlecast Hood (375)
				{ 2, 31455 }, -- Spellstrike Hood (375)
				{ 3, 31454 }, -- Whitemend Hood (375)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 41206 }, -- Mantle of Nimble Thought (375)
				{ 2, 41208 }, -- Swiftheal Mantle (375)
				{ 3, 26780 }, -- Soulcloth Shoulders (365)
				{ 4, 26761 }, -- Primal Mooncloth Shoulders (365)
				{ 5, 26756 }, -- Frozen Shadoweave Shoulders (355)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, 26762 }, -- Primal Mooncloth Robe (375)
				{ 2, 26758 }, -- Frozen Shadoweave Robe (375)
				{ 3, 26754 }, -- Spellfire Robe (375)
				{ 4, 26781 }, -- Soulcloth Vest (375)
				{ 5, 37884 }, -- Flameheart Vest (370)
				{ 6, 26784 }, -- Arcanoweave Robe (370)
				{ 7, 46130 }, -- Sunfire Robe (365)
				{ 8, 46131 }, -- Robe of Eternal Light (365)
				{ 9, 26778 }, -- Imbued Netherweave Tunic (360)
				{ 10, 26777 }, -- Imbued Netherweave Robe (360)
				{ 11, 36665 }, -- Netherflame Robe (355)
				{ 12, 26774 }, -- Netherweave Tunic (345)
				{ 13, 26773 }, -- Netherweave Robe (340)
				{ 16, 50644 }, -- Haliscan Jacket (250)
				{ 18, 44950 }, -- Green Winter Clothes (250)
				{ 19, 44958 }, -- Red Winter Clothes (250)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 40020 }, -- Soulguard Slippers (375)
				{ 2, 36318 }, -- Boots of the Long Road (375)
				{ 3, 36317 }, -- Boots of Blasting (375)
				{ 4, 26757 }, -- Frozen Shadoweave Boots (365)
				{ 5, 26783 }, -- Arcanoweave Boots (360)
				{ 6, 36668 }, -- Netherflame Boots (355)
				{ 7, 26776 }, -- Imbued Netherweave Boots (350)
				{ 8, 26772 }, -- Netherweave Boots (345)
				{ 16, 49677 }, -- Dress Shoes (250)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 46128 }, -- Sunfire Handwraps (365)
				{ 2, 46129 }, -- Hands of Eternal Light (365)
				{ 3, 26753 }, -- Spellfire Gloves (365)
				{ 4, 37883 }, -- Flameheart Gloves (360)
				{ 5, 26779 }, -- Soulcloth Gloves (355)
				{ 6, 26770 }, -- Netherweave Gloves (330)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 40023 }, -- Soulguard Leggings (375)
				{ 2, 31453 }, -- Battlecast Pants (375)
				{ 3, 31452 }, -- Spellstrike Pants (375)
				{ 4, 31451 }, -- Whitemend Pants (375)
				{ 5, 36669 }, -- Lifeblood Leggings (undefined)
				{ 6, 26775 }, -- Imbued Netherweave Pants (340)
				{ 7, 26771 }, -- Netherweave Pants (335)
				{ 16, 50647 }, -- Haliscan Pantaloons (245)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 40024 }, -- Soulguard Girdle (375)
				{ 2, 36316 }, -- Belt of the Long Road (375)
				{ 3, 36315 }, -- Belt of Blasting (375)
				{ 4, 31443 }, -- Girdle of Ruination (365)
				{ 5, 31442 }, -- Unyielding Girdle (365)
				{ 6, 31444 }, -- Black Belt of Knowledge (365)
				{ 7, 36667 }, -- Netherflame Belt (undefined)
				{ 8, 36670 }, -- Lifeblood Belt (undefined)
				{ 9, 26760 }, -- Primal Mooncloth Belt (355)
				{ 10, 26752 }, -- Spellfire Belt (355)
				{ 11, 26765 }, -- Netherweave Belt (320)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 41207 }, -- Swiftheal Wraps (375)
				{ 2, 41205 }, -- Bracers of Nimble Thought (375)
				{ 3, 40021 }, -- Soulguard Bracers (375)
				{ 4, 36672 }, -- Lifeblood Bracers (355)
				{ 5, 37882 }, -- Flameheart Bracers (350)
				{ 6, 31437 }, -- Blackstrike Bracers (350)
				{ 7, 31435 }, -- Bracers of Havok (350)
				{ 8, 31434 }, -- Unyielding Bracers (350)
				{ 9, 26782 }, -- Arcanoweave Bracers (350)
				{ 10, 26764 }, -- Netherweave Bracers (320)
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 26763 }, -- Primal Mooncloth Bag (375)
				{ 2, 26749 }, -- Imbued Netherweave Bag (340)
				{ 3, 26746 }, -- Netherweave Bag (320)
				{ 16, 50194 }, -- Mycah's Botanical Bag (375)
				{ 18, 26759 }, -- Ebon Shadowbag (375)
				{ 20, 26755 }, -- Spellfire Bag (375)
				{ 22, 31459 }, -- Bag of Jewels (340)
			}
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 31433 }, -- Golden Spellthread (375)
				{ 2, 31431 }, -- Silver Spellthread (335)
				{ 16, 31432 }, -- Runic Spellthread (375)
				{ 17, 31430 }, -- Mystic Spellthread (335)
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 36686 }, -- Shadowcloth (350)
				{ 2, 26751 }, -- Primal Mooncloth (350)
				{ 4, 26750 }, -- Bolt of Soulcloth (345)
				{ 6, 26747 }, -- Bolt of Imbued Netherweave (325)
				{ 7, 26745 }, -- Bolt of Netherweave (305)
				{ 16, 31373 }, -- Spellcloth (350)
				--{ 23, 31461 }, -- Heavy Netherweave Net (undefined)
				{ 21, 31460 }, -- Netherweave Net (300)
			}
		},
	}
}

data["LeatherworkingBC"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 42546 }, -- Cloak of Darkness (360)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, 35585 }, -- Windhawk Hauberk (385)
				{ 2, 35589 }, -- Primalstrike Vest (385)
				{ 3, 46136 }, -- Leather Chestguard of the Sun (365)
				{ 4, 46138 }, -- Carapace of Sun and Shadow (365)
				{ 5, 42731 }, -- Shadowprowler's Chestguard (365)
				{ 6, 32495 }, -- Heavy Clefthoof Vest (360)
				{ 7, 36078 }, -- Living Crystal Breastplate (350)
				{ 8, 36077 }, -- Primalstorm Breastplate (350)
				{ 9, 32481 }, -- Wild Draenish Vest (340)
				{ 10, 32473 }, -- Thick Draenic Vest (340)
			},
			[MAIL_DIFF] = {
				{ 1, 35575 }, -- Ebon Netherscale Breastplate (385)
				{ 2, 35580 }, -- Netherstrike Breastplate (385)
				{ 3, 46137 }, -- Embrace of the Phoenix (365)
				{ 4, 46139 }, -- Sun-Drenched Scale Chestguard (365)
				{ 5, 35574 }, -- Thick Netherscale Breastplate (365)
				{ 6, 32500 }, -- Felstalker Breastplate (360)
				{ 7, 36079 }, -- Golden Dragonstrike Breastplate (350)
				{ 8, 32465 }, -- Felscale Breastplate (345)
				{ 9, 32468 }, -- Scaled Draenic Vest (335)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 40003 }, -- Redeemed Soul Moccasins (375)
				{ 2, 36355 }, -- Boots of Natural Grace (375)
				{ 3, 36357 }, -- Boots of Utter Darkness (375)
				{ 4, 32497 }, -- Heavy Clefthoof Boots (355)
				{ 5, 32493 }, -- Fel Leather Boots (350)
				{ 6, 35536 }, -- Blastguard Boots (350)
				{ 7, 35534 }, -- Enchanted Clefthoof Boots (350)
				{ 8, 32472 }, -- Thick Draenic Boots (330)
				{ 9, 32478 }, -- Wild Draenish Boots (310)
			},
			[MAIL_DIFF] = {
				{ 1, 39997 }, -- Boots of Shackled Souls (375)
				{ 2, 36359 }, -- Hurricane Boots (375)
				{ 3, 36358 }, -- Boots of the Crimson Hawk (375)
				{ 4, 35567 }, -- Earthen Netherscale Boots (365)
				{ 5, 35528 }, -- Flamescale Boots (350)
				{ 6, 35527 }, -- Enchanted Felscale Boots (350)
				{ 7, 32503 }, -- Netherfury Boots (350)
				{ 8, 32469 }, -- Scaled Draenic Boots (345)
				{ 9, 32463 }, -- Felscale Boots (320)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 46134 }, -- Gloves of Immortal Dusk (365)
				{ 2, 46132 }, -- Leather Gauntlets of the Sun (365)
				{ 3, 35559 }, -- Cobrascale Gloves (365)
				{ 4, 35562 }, -- Gloves of the Living Touch (365)
				{ 5, 35563 }, -- Windslayer Wraps (365)
				{ 6, 35533 }, -- Enchanted Clefthoof Gloves (350)
				{ 7, 32490 }, -- Fel Leather Gloves (340)
				{ 8, 32479 }, -- Wild Draenish Gloves (320)
				{ 9, 32470 }, -- Thick Draenic Gloves (310)
			},
			[MAIL_DIFF] = {
				{ 1, 46135 }, -- Sun-Drenched Scale Gloves (365)
				{ 2, 46133 }, -- Fletcher's Gloves of the Phoenix (365)
				{ 3, 35568 }, -- Windstrike Gloves (365)
				{ 4, 35573 }, -- Netherdrake Gloves (365)
				{ 5, 35526 }, -- Enchanted Felscale Gloves (350)
				{ 6, 32467 }, -- Scaled Draenic Gloves (320)
				{ 7, 32462 }, -- Felscale Gloves (310)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 35558 }, -- Cobrascale Hood (365)
				{ 2, 35560 }, -- Windscale Hood (365)
				{ 3, 35561 }, -- Hood of Primal Life (365)
				{ 16, 32489 }, -- Stylin' Jungle Hat (350)
				{ 17, 32485 }, -- Stylin' Purple Hat (350)
			},
			[MAIL_DIFF] = {
				{ 1, 35564 }, -- Living Dragonscale Helm (365)
				{ 2, 35572 }, -- Netherdrake Helm (365)
				{ 16, 32488 }, -- Stylin' Crimson Hat (350)
				{ 17, 32487 }, -- Stylin' Adventure Hat (350)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 40005 }, -- Redeemed Soul Legguards (375)
				{ 2, 32496 }, -- Heavy Clefthoof Leggings (355)
				{ 3, 32494 }, -- Fel Leather Leggings (350)
				{ 4, 35535 }, -- Blastguard Pants (350)
				{ 5, 35532 }, -- Enchanted Clefthoof Leggings (350)
				{ 6, 32480 }, -- Wild Draenish Leggings (330)
				{ 7, 32471 }, -- Thick Draenic Pants (325)
				{ 16, 36075 }, -- Wildfeather Leggings (280)
				{ 17, 36074 }, -- Blackstorm Leggings (280)
			},
			[MAIL_DIFF] = {
				{ 1, 40001 }, -- Greaves of Shackled Souls (375)
				{ 2, 35529 }, -- Flamescale Leggings (350)
				{ 3, 35525 }, -- Enchanted Felscale Leggings (350)
				{ 4, 32502 }, -- Netherfury Leggings (340)
				{ 5, 32464 }, -- Felscale Pants (330)
				{ 6, 32466 }, -- Scaled Draenic Pants (310)
				{ 16, 36076 }, -- Dragonstrike Leggings (280)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 41160 }, -- Swiftstrike Shoulders (375)
				{ 2, 41157 }, -- Shoulderpads of Renewed Life (375)
			},
			[MAIL_DIFF] = {
				{ 1, 41162 }, -- Shoulders of Lightning Reflexes (375)
				{ 2, 41164 }, -- Living Earth Shoulders (375)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 35590 }, -- Primalstrike Belt (385)
				{ 2, 35587 }, -- Windhawk Belt (385)
				{ 3, 40006 }, -- Redeemed Soul Cinch (375)
				{ 4, 36349 }, -- Belt of Natural Power (375)
				{ 5, 36351 }, -- Belt of Deep Shadow (375)
				{ 6, 35537 }, -- Blastguard Belt (350)
			},
			[MAIL_DIFF] = {
				{ 1, 35582 }, -- Netherstrike Belt (385)
				{ 2, 35576 }, -- Ebon Netherscale Belt (385)
				{ 3, 40002 }, -- Waistguard of Shackled Souls (375)
				{ 4, 36353 }, -- Monsoon Belt (375)
				{ 5, 36352 }, -- Belt of the Black Eagle (375)
				{ 6, 35531 }, -- Flamescale Belt (350)
				{ 7, 32498 }, -- Felstalker Belt (350)
				{ 8, 32501 }, -- Netherfury Belt (340)
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, 35588 }, -- Windhawk Bracers (385)
				{ 2, 35591 }, -- Primalstrike Bracers (385)
				{ 3, 41158 }, -- Swiftstrike Bracers (375)
				{ 4, 41156 }, -- Bracers of Renewed Life (375)
				{ 5, 40004 }, -- Redeemed Soul Wristguards (375)
			},
			[MAIL_DIFF] = {
				{ 1, 35584 }, -- Netherstrike Bracers (385)
				{ 2, 35577 }, -- Ebon Netherscale Bracers (385)
				{ 3, 41163 }, -- Living Earth Bindings (375)
				{ 4, 41161 }, -- Bindings of Lightning Reflexes (375)
				{ 5, 40000 }, -- Bracers of Shackled Souls (375)
				{ 6, 32499 }, -- Felstalker Bracer (360)
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 35554 }, -- Nethercobra Leg Armor (365)
				{ 2, 35549 }, -- Cobrahide Leg Armor (335)
				{ 4, 35557 }, -- Nethercleft Leg Armor (365)
				{ 5, 35555 }, -- Clefthide Leg Armor (335)
				{ 7, 44970 }, -- Heavy Knothide Armor Kit (355)
				{ 8, 32456 }, -- Knothide Armor Kit (310)
				{ 10, 32458 }, -- Magister's Armor Kit (325)
				{ 11, 32457 }, -- Vindicator's Armor Kit (325)
				{ 13, 44770 }, -- Glove Reinforcements (355)
				{ 16, 35524 }, -- Arcane Armor Kit (340)
				{ 17, 35523 }, -- Nature Armor Kit (340)
				{ 18, 35522 }, -- Frost Armor Kit (340)
				{ 19, 35521 }, -- Flame Armor Kit (340)
				{ 20, 35520 }, -- Shadow Armor Kit (340)
			},
		},
		{
			name = AL["Drums"],
			[NORMAL_DIFF] = {
				{ 1, 351771 }, -- Greater Drums of Battle (375)
				{ 16, 35543 }, -- Drums of Battle (365)
				{ 3, 351770 }, -- Greater Drums of Panic (375)
				{ 18, 35538 }, -- Drums of Panic (370)
				{ 5, 351769 }, -- Greater Drums of Restoration (375)
				{ 20, 35539 }, -- Drums of Restoration (350)
				{ 7, 351768 }, -- Greater Drums of Speed (375)
				{ 22, 35544 }, -- Drums of Speed (345)
				{ 9, 351766 }, -- Greater Drums of War (375)
				{ 24, 35540 }, -- Drums of War (340)
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 45117 }, -- Bag of Many Hides (360)
				{ 3, 35530 }, -- Reinforced Mining Bag (325)
				{ 16, 44768 }, -- Netherscale Ammo Pouch (350)
				{ 17, 44343 }, -- Knothide Ammo Pouch (325)
				{ 19, 44359 }, -- Quiver of a Thousand Feathers (350)
				{ 20, 44344 }, -- Knothide Quiver (325)
				{ 22, 45100 }, -- Leatherworker's Satchel (310)
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 32455 }, -- Heavy Knothide Leather (325)
				{ 2, 32454 }, -- Knothide Leather (300)
				{ 4, 44953 }, -- Winter Boots (285)
				{ 16, 32461 }, -- Riding Crop (350)
				{ 18, 32482 }, -- Comfortable Insoles (300)

			},
		},
	}
}

data["JewelcraftingBC"] = {
	name = ALIL["Jewelcrafting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.JEWELCRAFTING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 41418 }, -- Crown of the Sea Witch (375)
				{ 2, 31077 }, -- Coronet of the Verdant Flame (370)
				{ 3, 31078 }, -- Circlet of Arcane Might (370)
				{ 4, 26920 }, -- Blood Crown (325)
				{ 5, 26906 }, -- Emerald Crown of Destruction (275)
				{ 6, 26878 }, -- Ruby Crown of Restoration (225)
				{ 7, 25321 }, -- Moonsoul Crown (150)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 31072 }, -- Embrace of the Dawn (365)
				{ 2, 46127 }, -- Hard Khorium Choker (365)
				{ 3, 46126 }, -- Amulet of Flowing Life (365)
				{ 4, 46125 }, -- Pendant of Sunfire (365)
				{ 5, 31076 }, -- Chain of the Twilight Owl (365)
				{ 6, 31070 }, -- Braided Eternium Chain (360)
				{ 7, 31071 }, -- Eye of the Night (360)
				{ 8, 31066 }, -- Pendant of the Null Rune (360)
				{ 9, 31065 }, -- Pendant of Shadow's End (360)
				{ 10, 31064 }, -- Pendant of Withering (360)
				{ 11, 31063 }, -- Pendant of Thawing (360)
				{ 12, 31062 }, -- Pendant of Frozen Flame (360)
				{ 13, 31068 }, -- Living Ruby Pendant (355)
				{ 14, 31067 }, -- Thick Felsteel Necklace (355)
				{ 15, 31051 }, -- Thick Adamantite Necklace (345)
				{ 16, 40514 }, -- Necklace of the Deep (340)
				{ 17, 26918 }, -- Arcanite Sword Pendant (315)
				{ 18, 26915 }, -- Necklace of the Diamond Tower (305)
				{ 19, 26911 }, -- Living Emerald Pendant (300)
				{ 20, 26908 }, -- Sapphire Pendant of Winter Night (290)
				{ 21, 26883 }, -- Ruby Pendant of Fire (260)
				{ 22, 26897 }, -- Opal Necklace of Impact (250)
				{ 23, 26876 }, -- Aquamarine Pendant of the Warrior (245)
				{ 24, 25622 }, -- Citrine Pendant of Golden Healing (190)
				{ 25, 25618 }, -- Jade Pendant of Blasting (160)
				{ 26, 25320 }, -- Heavy Golden Necklace of Battle (150)
				{ 27, 25614 }, -- Silver Rose Pendant (145)
				{ 28, 25498 }, -- Barbaric Iron Collar (140)
				{ 29, 25610 }, -- Pendant of the Agate Shield (120)
				{ 30, 38175 }, -- Bronze Torc (110)
				{ 101, 25339 }, -- Amulet of the Moon (110)
				{ 102, 36523 }, -- Brilliant Necklace (105)
				{ 103, 26927 }, -- Thick Bronze Necklace (80)
				{ 104, 26928 }, -- Ornate Tigerseye Necklace (60)
				{ 105, 32178 }, -- Malachite Pendant (50)
			}
		},
		{
			name = AL["Armor"].." - "..AL["Ring"],
			[NORMAL_DIFF] = {
				{ 1, 38504 }, -- The Natural Ward (375)
				{ 2, 46122 }, -- Loop of Forged Power (365)
				{ 3, 38503 }, -- The Frozen Eye (375)
				{ 4, 37855 }, -- Ring of Arcane Shielding (360)
				{ 5, 36526 }, -- Diamond Focus Ring (285)
				{ 6, 36525 }, -- Red Ring of Destruction (255)
				{ 7, 34959 }, -- Truesilver Commander's Ring (210)
				{ 8, 34955 }, -- Golden Ring of Power (190)
				{ 9, 36524 }, -- Heavy Jade Ring (135)
				{ 10, 37818 }, -- Bronze Band of Force (95)
				{ 11, 46123 }, -- Ring of Flowing Life (365)
				{ 12, 46124 }, -- Hard Khorium Band (365)
				{ 13, 31061 }, -- Blazing Eternium Band (365)
				{ 14, 31057 }, -- Arcane Khorium Band (365)
				{ 15, 31056 }, -- Khorium Band of Leaves (360)
				{ 16, 31060 }, -- Delicate Eternium Ring (355)
				{ 17, 31055 }, -- Khorium Inferno Band (355)
				{ 18, 31054 }, -- Khorium Band of Frost (355)
				{ 19, 31053 }, -- Khorium Band of Shadows (350)
				{ 20, 31058 }, -- Heavy Felsteel Ring (345)
				{ 21, 31052 }, -- Heavy Adamantite Ring (345)
				{ 22, 41415 }, -- The Black Pearl (340)
				{ 23, 41414 }, -- Brilliant Pearl Band (335)
				{ 24, 31050 }, -- Azure Moonstone Ring (330)
				{ 25, 31049 }, -- Golden Draenite Ring (320)
				{ 26, 31048 }, -- Fel Iron Blood Ring (320)
				{ 27, 26916 }, -- Band of Natural Fire (320)
				{ 28, 34961 }, -- Emerald Lion Ring (300)
				{ 29, 34960 }, -- Glowing Thorium Band (290)
				{ 30, 26907 }, -- Onslaught Ring (290)
				{ 101, 26910 }, -- Ring of Bitter Shadows (285)
				{ 102, 26903 }, -- Sapphire Signet (285)
				{ 103, 26902 }, -- Simple Opal Ring (280)
				{ 104, 26885 }, -- Truesilver Healing Ring (265)
				{ 105, 26896 }, -- Gem Studded Band (250)
				{ 106, 26887 }, -- The Aquamarine Ward (245)
				{ 107, 26874 }, -- Aquamarine Signet (235)
				{ 108, 25621 }, -- Citrine Ring of Rapid Healing (210)
				{ 109, 25620 }, -- Engraved Truesilver Ring (200)
				{ 110, 25619 }, -- The Jade Eye (170)
				{ 111, 25613 }, -- Golden Dragon Ring (165)
				{ 112, 25617 }, -- Blazing Citrine Ring (150)
				{ 113, 25318 }, -- Ring of Twilight Shadows (130)
				{ 114, 25323 }, -- Wicked Moonstone Ring (125)
				{ 115, 25305 }, -- Heavy Silver Ring (120)
				{ 116, 25317 }, -- Ring of Silver Might (110)
				{ 117, 25287 }, -- Gloom Band (100)
				{ 118, 25284 }, -- Simple Pearl Ring (90)
				{ 119, 25490 }, -- Solid Bronze Ring (80)
				{ 120, 25280 }, -- Elegant Silver Ring (80)
				{ 121, 25283 }, -- Inlaid Malachite Ring (60)
				{ 122, 32179 }, -- Tigerseye Band (50)
				{ 123, 26926 }, -- Heavy Copper Ring (35)
				{ 124, 26925 }, -- Woven Copper Ring (30)
				{ 125, 25493 }, -- Braided Copper Ring (30)
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 46779 }, -- Figurine - Seaspray Albatross (375)
				{ 2, 31082 }, -- Figurine - Talasite Owl (370)
				{ 3, 26909 }, -- Figurine - Emerald Owl (285)
				{ 4, 26872 }, -- Figurine - Jade Owl (225)
				{ 6, 46778 }, -- Figurine - Shadowsong Panther (375)
				{ 7, 31083 }, -- Figurine - Nightseye Panther (370)
				{ 8, 26875 }, -- Figurine - Black Pearl Panther (215)
				{ 16, 46775 }, -- Figurine - Empyrean Tortoise (375)
				{ 17, 31080 }, -- Figurine - Dawnstone Crab (370)
				{ 18, 26912 }, -- Figurine - Black Diamond Crab (300)
				{ 19, 26881 }, -- Figurine - Truesilver Crab (225)
				{ 10, 46776 }, -- Figurine - Khorium Boar (375)
				{ 11, 31079 }, -- Figurine - Felsteel Boar (370)
				{ 12, 26882 }, -- Figurine - Truesilver Boar (235)
				{ 21, 46777 }, -- Figurine - Crimson Serpent (375)
				{ 22, 31081 }, -- Figurine - Living Ruby Serpent (370)
				{ 23, 26900 }, -- Figurine - Ruby Serpent (260)
				{ 25, 26914 }, -- Figurine - Dark Iron Scorpid (300)
				{ 27, 26873 }, -- Figurine - Golden Hare (200)
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Fist Weapons"],
			[NORMAL_DIFF] = {
				{ 1, 25612 }, -- Heavy Iron Knuckles (125)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Meta"]),
			[NORMAL_DIFF] = {
				{ 1, 46601 }, -- Ember Skyfire Diamond (370)
				{ 2, 39963 }, -- Thundering Skyfire Diamond (365)
				{ 3, 44794 }, -- Chaotic Skyfire Diamond (365)
				{ 4, 32873 }, -- Swift Skyfire Diamond (365)
				{ 5, 32872 }, -- Mystical Skyfire Diamond (365)
				{ 6, 32874 }, -- Enigmatic Skyfire Diamond (365)
				{ 7, 32871 }, -- Destructive Skyfire Diamond (365)
				{ 16, 46597 }, -- Eternal Earthstorm Diamond (370)
				{ 17, 39961 }, -- Relentless Earthstorm Diamond (365)
				{ 18, 32868 }, -- Tenacious Earthstorm Diamond (365)
				{ 19, 32866 }, -- Powerful Earthstorm Diamond (365)
				{ 20, 32870 }, -- Insightful Earthstorm Diamond (365)
				{ 21, 32869 }, -- Brutal Earthstorm Diamond (365)
				{ 22, 32867 }, -- Bracing Earthstorm Diamond (365)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Red"]),
			[NORMAL_DIFF] = {
				{ 1, 42588 }, -- Kailee's Rose (360)
				{ 2, 39710 }, -- Teardrop Crimson Spinel (375)
				{ 3, 31087 }, -- Teardrop Living Ruby (350)
				{ 4, 28903 }, -- Teardrop Blood Garnet (300)
				{ 6, 42558 }, -- Don Julio's Heart (360)
				{ 7, 39711 }, -- Runed Crimson Spinel (375)
				{ 8, 31088 }, -- Runed Living Ruby (350)
				{ 9, 28906 }, -- Runed Blood Garnet (315)
				{ 11, 42589 }, -- Crimson Sun (360)
				{ 12, 39712 }, -- Bright Crimson Spinel (375)
				{ 13, 31089 }, -- Bright Living Ruby (350)
				{ 14, 34590 }, -- Bright Blood Garnet (305)
				{ 16, 39706 }, -- Delicate Crimson Spinel (375)
				{ 17, 31085 }, -- Delicate Living Ruby (350)
				{ 18, 28907 }, -- Delicate Blood Garnet (325)
				{ 20, 39705 }, -- Bold Crimson Spinel (375)
				{ 21, 31084 }, -- Bold Living Ruby (350)
				{ 22, 28905 }, -- Bold Blood Garnet (305)
				{ 24, 39713 }, -- Subtle Crimson Spinel (375)
				{ 25, 31090 }, -- Subtle Living Ruby (350)
				{ 27, 39714 }, -- Flashing Crimson Spinel (375)
				{ 28, 31091 }, -- Flashing Living Ruby (350)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Yellow"]),
			[NORMAL_DIFF] = {
				{ 1, 42591 }, -- Stone of Blades (360)
				{ 2, 39720 }, -- Smooth Lionseye (375)
				{ 3, 31097 }, -- Smooth Dawnstone (350)
				{ 4, 34069 }, -- Smooth Golden Draenite (325)
				{ 6, 42592 }, -- Blood of Amber (360)
				{ 7, 39722 }, -- Gleaming Lionseye (375)
				{ 8, 31099 }, -- Gleaming Dawnstone (350)
				{ 9, 28944 }, -- Gleaming Golden Draenite (305)
				{ 11, 42593 }, -- Facet of Eternity (360)
				{ 12, 39723 }, -- Thick Lionseye (375)
				{ 13, 31100 }, -- Thick Dawnstone (350)
				{ 14, 28947 }, -- Thick Golden Draenite (315)
				{ 16, 39721 }, -- Rigid Lionseye (375)
				{ 17, 31098 }, -- Rigid Dawnstone (350)
				{ 18, 28948 }, -- Rigid Golden Draenite (325)
				{ 20, 39725 }, -- Great Lionseye (375)
				{ 21, 39452 }, -- Great Dawnstone (350)
				{ 22, 39451 }, -- Great Golden Draenite (325)
				{ 24, 39719 }, -- Brilliant Lionseye (375)
				{ 25, 31096 }, -- Brilliant Dawnstone (350)
				{ 26, 28938 }, -- Brilliant Golden Draenite (300)
				{ 27, 47056 }, -- Quick Lionseye (375)
				{ 28, 46403 }, -- Quick Dawnstone (350)
				{ 29, 39724 }, -- Mystic Lionseye (375)
				{ 30, 31101 }, -- Mystic Dawnstone (350)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Blue"]),
			[NORMAL_DIFF] = {
				{ 1, 42590 }, -- Falling Star (360)
				{ 2, 39715 }, -- Solid Empyrean Sapphire (375)
				{ 3, 31092 }, -- Solid Star of Elune (350)
				{ 4, 28950 }, -- Solid Azure Moonstone (300)
				{ 6, 39718 }, -- Stormy Empyrean Sapphire (375)
				{ 7, 31095 }, -- Stormy Star of Elune (350)
				{ 8, 28955 }, -- Stormy Azure Moonstone (315)
				{ 17, 39716 }, -- Sparkling Empyrean Sapphire (375)
				{ 18, 31149 }, -- Sparkling Star of Elune (350)
				{ 19, 28953 }, -- Sparkling Azure Moonstone (305)
				{ 21, 39717 }, -- Lustrous Empyrean Sapphire (375)
				{ 22, 31094 }, -- Lustrous Star of Elune (350)
				{ 23, 28957 }, -- Lustrous Azure Moonstone (325)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Orange"]),
			[NORMAL_DIFF] = {
				{ 1, 39738 }, -- Wicked Pyrestone (375)
				{ 2, 39471 }, -- Wicked Noble Topaz (350)
				{ 3, 39467 }, -- Wicked Flame Spessarite (325)
				{ 5, 39737 }, -- Veiled Pyrestone (375)
				{ 6, 39470 }, -- Veiled Noble Topaz (350)
				{ 7, 39466 }, -- Veiled Flame Spessarite (325)
				{ 9, 39734 }, -- Potent Pyrestone (375)
				{ 10, 31107 }, -- Potent Noble Topaz (350)
				{ 11, 28915 }, -- Potent Flame Spessarite (325)
				{ 13, 47055 }, -- Reckless Pyrestone (375)
				{ 14, 46404 }, -- Reckless Noble Topaz (350)
				{ 16, 39735 }, -- Luminous Pyrestone (375)
				{ 17, 31108 }, -- Luminous Noble Topaz (350)
				{ 18, 28912 }, -- Luminous Flame Spessarite (305)
				{ 20, 39733 }, -- Inscribed Pyrestone (375)
				{ 21, 31106 }, -- Inscribed Noble Topaz (350)
				{ 22, 28910 }, -- Inscribed Flame Spessarite (300)
				{ 24, 39736 }, -- Glinting Pyrestone (375)
				{ 25, 31109 }, -- Glinting Noble Topaz (350)
				{ 26, 28914 }, -- Glinting Flame Spessarite (315)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Green"]),
			[NORMAL_DIFF] = {
				{ 1, 39739 }, -- Enduring Seaspray Emerald (375)
				{ 2, 31110 }, -- Enduring Talasite (350)
				{ 3, 28918 }, -- Enduring Deep Peridot (315)
				{ 5, 39740 }, -- Radiant Seaspray Emerald (375)
				{ 6, 31111 }, -- Radiant Talasite (350)
				{ 7, 28916 }, -- Radiant Deep Peridot (300)
				{ 9, 47054 }, -- Steady Seaspray Emerald (375)
				{ 10, 43493 }, -- Steady Talasite (350)
				{ 16, 39742 }, -- Jagged Seaspray Emerald (375)
				{ 17, 31113 }, -- Jagged Talasite (350)
				{ 18, 28917 }, -- Jagged Deep Peridot (305)
				{ 20, 39741 }, -- Dazzling Seaspray Emerald (375)
				{ 21, 31112 }, -- Dazzling Talasite (350)
				{ 22, 28924 }, -- Dazzling Deep Peridot (325)
				{ 24, 47053 }, -- Forceful Seaspray Emerald (375)
				{ 25, 46405 }, -- Forceful Talasite (350)
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Purple"]),
			[NORMAL_DIFF] = {
				{ 1, 39728 }, -- Shifting Shadowsong Amethyst (375)
				{ 2, 31103 }, -- Shifting Nightseye (350)
				{ 3, 28933 }, -- Shifting Shadow Draenite (315)
				{ 5, 39727 }, -- Sovereign Shadowsong Amethyst (375)
				{ 6, 31102 }, -- Sovereign Nightseye (350)
				{ 7, 28936 }, -- Sovereign Shadow Draenite (325)
				{ 9, 39729 }, -- Balanced Shadowsong Amethyst (375)
				{ 10, 39463 }, -- Balanced Nightseye (350)
				{ 11, 39455 }, -- Balanced Shadow Draenite (325)
				{ 13, 39730 }, -- Infused Shadowsong Amethyst (375)
				{ 14, 39462 }, -- Infused Nightseye (350)
				{ 15, 39458 }, -- Infused Shadow Draenite (325)
				{ 16, 39731 }, -- Glowing Nightseye (375)
				{ 17, 31104 }, -- Glowing Nightseye (350)
				{ 18, 28925 }, -- Glowing Shadow Draenite (300)
				{ 20, 39732 }, -- Royal Shadowsong Amethyst (375)
				{ 21, 31105 }, -- Royal Nightseye (350)
				{ 22, 28927 }, -- Royal Shadow Draenite (305)
				{ 24, 48789 }, -- Purified Shadowsong Amethyst (375)
				{ 25, 41429 }, -- Purified Shadow Pearl (350)
				{ 26, 41420 }, -- Purified Jaggal Pearl (325)
				{ 28, 46803 }, -- Regal Nightseye (350)
			}
		},
		{
			name = format(SPLIT_FORMAT, AL["Raw Gems"], AL["Classic"]),
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 12363 }, -- Arcane Crystal
				{ 2, 12800 }, --  Azerothian Diamond
				{ 3, 12364 }, --  Huge Emerald
				{ 4, 12361 }, --  Blue Sapphire
				{ 5, 12799 }, --  Large Opal
				{ 6, 7910 }, --  Star Ruby
				{ 7, 11382 }, --  Blood of the Mountain
				{ 8, 19774 }, --  Souldarite
				{ 9, 7909 }, --  Aquamarine
				{ 10, 23158 }, --  Solid Aquamarine
				{ 11, 23159 }, --  Sparkling Aquamarine
				{ 12, 13926 }, --  Golden Pearl
				{ 13, 3864 }, --  Citrine
				{ 14, 7971 }, --  Black Pearl
				{ 15, 1529 }, --  Jade
				{ 16, 1705 }, --  Lesser Moonstone
				{ 17, 1206 }, --  Moss Agate
				{ 18, 5500 }, --  Iridescent Pearl
				{ 19, 1210 }, --  Shadowgem
				{ 20, 5498 }, --  Small Lustrous Pearl
				{ 21, 818 }, --  Tigerseye
				{ 22, 774 }, --  Malachite
			}
		},
		{
			name = AL["Raw Gems"],
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 25867 }, --  Earthstorm Diamond
				{ 2, 25868 }, --  Skyfire Diamond
				{ 5, 32228 }, -- Empyrean Sapphire
				{ 6, 23438 }, --  Star of Elune
				{ 7, 23117 }, --  Azure Moonstone
				{ 9, 32249 }, --  Seaspray Emerald
				{ 10, 23437 }, --  Talasite
				{ 11, 23079 }, --  Deep Peridot
				{ 13, 32231 }, --  Pyrestone
				{ 14, 23439 }, --  Noble Topaz
				{ 15, 21929 }, --  Flame Spessarite
				{ 16, 24479 }, --  Shadow Pearl
				{ 17, 24478 }, --  Jaggal Pearl
				{ 20, 32230 }, --  Shadowsong Amethyst
				{ 21, 23441 }, --  Nightseye
				{ 22, 23107 }, --  Shadow Draenite
				{ 24, 32227 }, --  Crimson Spinel
				{ 25, 23436 }, --  Living Ruby
				{ 26, 23077 }, --  Blood Garnet
				{ 28, 32229 }, --  Lionseye
				{ 29, 23440 }, --  Dawnstone
				{ 30, 23112 }, --  Golden Draenite
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 38068 }, -- Mercurial Adamantite (325)
				{ 2, 26880 }, -- Thorium Setting (235)
				{ 3, 25615 }, -- Mithril Filigree (170)
				{ 4, 25278 }, -- Bronze Setting (70)
				{ 5, 25255 }, -- Delicate Copper Wire (20)
				{ 16, 47280 }, -- Brilliant Glass (350)
				{ 18, 32810 }, -- Primal Stone Statue (undefined)
				{ 19, 32809 }, -- Dense Stone Statue (225)
				{ 20, 32808 }, -- Solid Stone Statue (175)
				{ 21, 32807 }, -- Heavy Stone Statue (120)
				{ 22, 32801 }, -- Coarse Stone Statue (70)
				{ 23, 32259 }, -- Rough Stone Statue (30)
			}
		},
	}
}

data["MiningBC"] = {
	name = ALIL["Mining"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1, 46353 }, -- Smelt Hardened Khorium (375)
				{ 2, 29686 }, -- Smelt Hardened Adamantite (375)
				{ 3, 29361 }, -- Smelt Khorium (375)
				{ 4, 29360 }, -- Smelt Felsteel (355)
				{ 5, 29359 }, -- Smelt Eternium (350)
				{ 6, 29358 }, -- Smelt Adamantite (325)
				{ 7, 29356 }, -- Smelt Fel Iron (300)
				{ 16, 35751 }, -- Fire Sunder (300)
				{ 17, 35750 }, -- Earth Shatter (300)
			}
		},
	}
}

data["HerbalismBC"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.HERBALISM_LINK,
	items = {
		{
			name = AL["Master"],
			[NORMAL_DIFF] = {
				{ 1,  22793 }, -- Mana Thistle
				{ 2,  22792 }, -- Nightmare Vine
				{ 3,  22791, 22576 }, -- Netherbloom
				{ 4,  22790 }, -- Ancient Lichen
				{ 5,  22789 }, -- Terocone
				{ 6,  22787 }, -- Ragveil
				{ 7,  22786 }, -- Dreaming Glory
				{ 8,  22785, 22795 }, -- Felweed
				{ 16,  22794 }, -- Fel Lotus
				{ 17,  22575 }, -- Mote of Life
			}
		},
	}
}

data["CookingBC"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.COOKING_LINK,
	items = {
		{
			name = ALIL["Agility"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 33288 }, -- Warp Burger (325)
				{ 2, 33293 }, -- Grilled Mudfish (320)
			},
		},
		{
			name = ALIL["Strength"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 33287 }, -- Roasted Clefthoof (325)
			},
		},
		{
			name = ALIL["Attack Power"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 33284 }, -- Ravager Dog (300)
			},
		},
		{
			name = AL["Spell Damage"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 38868 }, -- Crunchy Serpent (335)
				{ 2, 33294 }, -- Poached Bluefish (320)
				{ 3, 33286 }, -- Blackened Basilisk (315)
			},
		},
		{
			name = ALIL["Critical Strike (Spell)"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 43707 }, -- Skullfish Soup (325)
			},
		},
		{
			name = ALIL["Bonus Healing"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 33295 }, -- Golden Fish Sticks (325)
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 42302 }, -- Fisherman's Feast (375)
				{ 2, 33296 }, -- Spicy Crawdad (350)
				{ 3, 38867 }, -- Mok'Nathal Shortribs (335)
				{ 4, 45022 }, -- Hot Apple Cider (325)
				{ 5, 33289 }, -- Talbuk Steak (325)
				{ 6, 36210 }, -- Clam Bar (300)
				{ 7, 33291 }, -- Feltail Delight (300)
				{ 8, 33279 }, -- Buzzard Bites (300)
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 33292 }, -- Blackened Sporefish (310)
			},
		},
		{
			name = ALIL["Hit"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 43765 }, -- Spicy Hot Talbuk (325)
			},
		},
		{
			name = AL["Resistance"],
			[NORMAL_DIFF] = {
				{ 1, 43761 }, -- Broiled Bloodfin (300)
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1, 42305 }, -- Hot Buttered Trout (375)
				{ 2, 42296 }, -- Stewed Trout (335)
				{ 3, 33290 }, -- Blackened Trout (300)
			},
		},
		{
			name = AL["Pet"],
			[NORMAL_DIFF] = {
				{ 1, 33285 }, -- Sporeling Snack (310)
				{ 2, 43772 }, -- Kibler's Bits (300)
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 46684 }, -- Charred Bear Kabobs (250)
				{ 2, 46688 }, -- Juicy Bear Burger (250)
				{ 4, 28267 }, -- Crunchy Spider Surprise (60)
				{ 5, 33278 }, -- Bat Bites (50)
				{ 16, 33277 }, -- Roasted Moongraze Tenderloin (1)
				{ 17, 33276 }, --Lynx Steak (1)
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 43779 }, -- Delicious Chocolate Cake (1)
				{ 3, 45695 }, -- Captain Rumsey's Lager (100)
				{ 16, 43758 }, -- Stormchops (300)
			},
		},
	}
}

data["FirstAidBC"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.FIRSTAID_LINK,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1, 27033 }, -- Heavy Netherweave Bandage (360)
				{ 2, 27032 }, -- Netherweave Bandage (330)
			}
		},
	}
}

data["FishingBC"] = {
	name = ALIL["Fishing"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.FISHING_LINK,
	items = {
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 6533 }, --  Aquadynamic Fish Attractor
				{ 2, 34861 }, -- Sharpened Fish Hook
				{ 3, 6532 }, --  Bright Baubles
				{ 4, 7307 }, --  Flesh Eating Worm
				{ 5, 6811 }, --  Aquadynamic Fish Lens
				{ 6, 6530 }, --  Nightcrawlers
				{ 16, 34109 }, -- Weather-Beaten Journal
				{ 18, 19971 }, -- High Test Eternium Fishing Line
				{ 19, 34836 }, -- Spun Truesilver Fishing Line
				{ 27, 27532 }, -- Master Fishing - The Art of Angling
				{ 28, 16082 }, -- Artisan Fishing - The Way of the Lure
				{ 29, 16083 }, -- Expert Fishing - The Bass and You
				{ 30, 46054 }, -- Journeyman Fishing - Fishing for Dummies
			}
		},
		{
			name = ALIL["Fishing Pole"],
			[NORMAL_DIFF] = {
				{ 1, 19970 }, -- Arcanite Fishing Pole
				{ 2, 19022 }, -- Nat Pagle's Extreme Angler FC-5000
				{ 3, 25978 }, -- Seth's Graphite Fishing Pole
				{ 4, 6367 }, -- Big Iron Fishing Pole
				{ 5, 6366 }, -- Darkwood Fishing Pole
				{ 6, 6365 }, -- Strong Fishing Pole
				{ 7, 12225 }, -- Blump Family Fishing Pole
				{ 8, 6256 }, -- Fishing Pole
			}
		},
		{
			name = AL["Fishes"],
			[NORMAL_DIFF] = {
				{ 1, 33823 }, -- Bloodfin Catfish
				{ 2, 33824 }, -- Crescent-Tail Skullfish
				{ 3, 27422 }, -- Barbed Gill Trout
				{ 4, 27435 }, -- Figluster's Mudfish
				{ 5, 27439 }, -- Furious Crawdad
				{ 6, 27438 }, -- Golden Darter
				{ 7, 27437 }, -- Icefin Bluefish
				{ 8, 27425 }, -- Spotted Feltail
				{ 9, 27429 }, -- Zangarian Sporefish
			}
		},
	}
}

data["RoguePoisonsBC"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ROGUE_POISONS_LINK,
	items = {
		{
			name = ALIL["Poisons"],
			[NORMAL_DIFF] = {
				{ 1, 26892 }, -- Instant Poison VII
				{ 2, 11343 }, -- Instant Poison VI
				{ 3, 11342 }, -- Instant Poison V
				{ 4, 11341 }, -- Instant Poison IV
				{ 5, 8691  }, -- Instant Poison III
				{ 6, 8687  }, -- Instant Poison II
				{ 7, 8681  }, -- Instant Poison
				{ 9, 27283 },  -- Wound Poison V
				{ 10, 13230 },  -- Wound Poison IV
				{ 11, 13229 },  -- Wound Poison III
				{ 12, 13228 }, -- Wound Poison II
				{ 13, 13220 }, -- Wound Poison
				{ 15, 3420  }, -- Crippling Poison
				{ 16, 27282 }, -- Deadly Poison VII
				{ 17, 26969 }, -- Deadly Poison VI
				{ 18, 25347 }, -- Deadly Poison V
				{ 19, 11358 }, -- Deadly Poison IV
				{ 20, 11357 }, -- Deadly Poison III
				{ 21, 2837  }, -- Deadly Poison II
				{ 22, 2835  }, -- Deadly Poison
				{ 26, 11400 }, -- Mind-numbing Poison III
				{ 27, 8694  }, -- Mind-numbing Poison II
				{ 28, 5763  }, -- Mind-numbing Poison
				{ 30, 26786  }, -- Anesthetic Poison
			}
		},
	}
}
