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
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, 2)

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
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)


data["AlchemyBC"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "Alchemy",
	},
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
	CorrespondingFields = {
		[1] = "Blacksmithing",
	},
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
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[PLATE_DIFF] = {
				{ 1, 41135 }, -- Dawnsteel Shoulders (375)
				{ 2, 41133 }, -- Swiftsteel Shoulders (375)
				{ 3, 42662 }, -- Ragesteel Shoulders (365)
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
	CorrespondingFields = {
		[1] = "Enchanting",
	},
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
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 46594 }, -- Enchant Chest - Defense (360)
				{ 2, 33992 }, -- Enchant Chest - Major Resilience (345)
				{ 3, 27960 }, -- Enchant Chest - Exceptional Stats (345)
				{ 4, 33990 }, -- Enchant Chest - Major Spirit (330)
				{ 5, 27958 }, -- Enchant Chest - Exceptional Mana (325)
				{ 6, 27957 }, -- Enchant Chest - Exceptional Health (325)
				{ 7, 33991 }, -- Enchant Chest - Restore Mana Prime (310)
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
				{ 9, 42613 }, -- Nexus Transformation (295)
				{ 10, 28021 }, -- Arcane Dust (undefined)
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
	CorrespondingFields = {
		[1] = "Engineering",
	},
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
			name = AL["Fireworks"],
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
				{ 1, 30547 }, -- Elemental Seaforium Charge (350)
				{ 2, 39973 }, -- Frost Grenades (345)
				{ 3, 30560 }, -- Super Sapper Charge (340)
				{ 4, 30311 }, -- Adamantite Grenade (335)
				{ 5, 30558 }, -- The Bigger One (325)
				{ 6, 30310 }, -- Fel Iron Bomb (320)
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
				{ 7, 36955 }, -- Ultrasafe Transporter - Toshley's Station (350)
				{ 8, 36954 }, -- Dimensional Ripper - Area 52 (350)
				{ 10, 30573 }, -- Gnomish Tonk Controller (undefined)
				{ 11, 30561 }, -- Goblin Tonk Controller (undefined)
				{ 13, 30552 }, -- Mana Potion Injector (345)
				{ 14, 30551 }, -- Healing Potion Injector (330)
				{ 16, 30548 }, -- Zapthrottle Mote Extractor (305)
				{ 18, 44391 }, -- Field Repair Bot 110G (360)
				{ 20, 30549 }, -- Critter Enlarger (undefined)
			}
		},
	}
}

data["TailoringBC"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "Tailoring",
	},
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
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 31456 }, -- Battlecast Hood (375)
				{ 2, 31455 }, -- Spellstrike Hood (375)
				{ 3, 31454 }, -- Whitemend Hood (375)
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
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 31433 }, -- Golden Spellthread (375)
				{ 2, 31431 }, -- Silver Spellthread (335)
				{ 4, 36686 }, -- Shadowcloth (350)
				{ 6, 26751 }, -- Primal Mooncloth (350)
				{ 8, 26750 }, -- Bolt of Soulcloth (345)
				{ 9, 26747 }, -- Bolt of Imbued Netherweave (325)
				{ 10, 26745 }, -- Bolt of Netherweave (305)
				{ 16, 31432 }, -- Runic Spellthread (375)
				{ 17, 31430 }, -- Mystic Spellthread (335)
				{ 19, 31373 }, -- Spellcloth (350)
				{ 23, 31461 }, -- Heavy Netherweave Net (undefined)
				{ 24, 31460 }, -- Netherweave Net (300)
			}
		},
	}
}

data["LeatherworkingBC"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "Leatherworking",
	},
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 22927 }, --Hide of the Wild / 62 / 320
				{ 2, 22928 }, --Shifting Cloak / 62 / 320
				{ 3, 22926 }, --Chromatic Cloak / 62 / 320
				{ 4, 19093 }, --Onyxia Scale Cloak / 60 / 320
				{ 5, 10574 }, --Wild Leather Cloak / 50 / 270
				{ 6, 10562 }, --Big Voodoo Cloak / 48 / 260
				{ 7, 7153 }, --Guardian Cloak / 37 / 205
				{ 8, 9198 }, --Frost Leather Cloak / 36 / 200
				{ 9, 3760 }, --Hillman's Cloak / 30 / 170
				{ 10, 2168 }, --Dark Leather Cloak / 22 / 135
				{ 11, 9070 }, --Black Whelp Cloak / 20 / 125
				{ 12, 7953 }, --Deviate Scale Cloak / 18 / 120
				{ 13, 2159 }, --Fine Leather Cloak / 15 / 105
				{ 14, 2162 }, --Embossed Leather Cloak / 13 / 90
				{ 15, 9058 }, --Handstitched Leather Cloak / 9 / 40
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, 28219 }, --Polar Tunic / 80 / 320
				{ 2, 24121 }, --Primal Batskin Jerkin / 65 / 320
				{ 3, 24124 }, --Blood Tiger Breastplate / 65 / 320
				{ 4, 19102 }, --Runic Leather Armor / 62 / 320
				{ 5, 19104 }, --Frostsaber Tunic / 62 / 320
				{ 6, 19098 }, --Wicked Leather Armor / 61 / 320
				{ 7, 19095 }, --Living Breastplate / 60 / 320
				{ 8, 19086 }, --Ironfeather Breastplate / 58 / 310
				{ 9, 19081 }, --Chimeric Vest / 58 / 310
				{ 10, 19076 }, --Volcanic Breastplate / 57 / 305
				{ 11, 19079 }, --Stormshroud Armor / 57 / 305
				{ 12, 19068 }, --Warbear Harness / 55 / 295
				{ 13, 10647 }, --Feathered Breastplate / 50 / 270
				{ 14, 10544 }, --Wild Leather Vest / 45 / 245
				{ 15, 10520 }, --Big Voodoo Robe / 43 / 235
				{ 16, 10499 }, --Nightscape Tunic / 41 / 225
				{ 17, 6661 }, --Barbaric Harness / 38 / 210
				{ 18, 3773 }, --Guardian Armor / 35 / 195
				{ 19, 9197 }, --Green Whelp Armor / 35 / 195
				{ 20, 9196 }, --Dusky Leather Armor / 35 / 195
				{ 21, 6704 }, --Thick Murloc Armor / 34 / 190
				{ 22, 4096 }, --Raptor Hide Harness / 33 / 185
				{ 23, 3772 }, --Green Leather Armor / 31 / 175
				{ 24, 2166 }, --Toughened Leather Armor / 24 / 145
				{ 25, 24940 }, --Black Whelp Tunic / 20 / 125
				{ 26, 3762 }, --Hillman's Leather Vest / 20 / 125
				{ 27, 2169 }, --Dark Leather Tunic / 20 / 125
				{ 28, 6703 }, --Murloc Scale Breastplate / 19 / 125
				{ 29, 8322 }, --Moonglow Vest / 18 / 115
				{ 30, 3761 }, --Fine Leather Tunic / 17 / 115
				{ 101, 2163 }, --White Leather Jerkin / 13 / 90
				{ 102, 2160 }, --Embossed Leather Vest / 12 / 70
				{ 103, 7126 }, --Handstitched Leather Vest / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 28222 }, --Icy Scale Breastplate / 80 / 320
				{ 2, 24703 }, --Dreamscale Breastplate / 68 / 320
				{ 3, 24851 }, --Sandstalker Breastplate / 62 / 320
				{ 4, 24848 }, --Spitfire Breastplate / 62 / 320
				{ 5, 19054 }, --Red Dragonscale Breastplate / 61 / 320
				{ 6, 19085 }, --Black Dragonscale Breastplate / 58 / 310
				{ 7, 19077 }, --Blue Dragonscale Breastplate / 57 / 305
				{ 8, 19051 }, --Heavy Scorpid Vest / 53 / 285
				{ 9, 19050 }, --Green Dragonscale Breastplate / 52 / 280
				{ 10, 10650 }, --Dragonscale Breastplate / 51 / 275
				{ 11, 10525 }, --Tough Scorpid Breastplate / 44 / 240
				{ 12, 10511 }, --Turtle Scale Breastplate / 42 / 230
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 28473 }, --Bramblewood Boots / 70 / 320
				{ 2, 22922 }, --Mongoose Boots / 62 / 320
				{ 3, 20853 }, --Corehound Boots / 59 / 315
				{ 4, 23705 }, --Dawn Treaders / 58 / 310
				{ 5, 19063 }, --Chimeric Boots / 55 / 295
				{ 6, 19066 }, --Frostsaber Boots / 55 / 295
				{ 7, 10566 }, --Wild Leather Boots / 49 / 265
				{ 8, 10558 }, --Nightscape Boots / 47 / 255
				{ 9, 9207 }, --Dusky Boots / 40 / 220
				{ 10, 9208 }, --Swift Boots / 40 / 220
				{ 11, 2167 }, --Dark Leather Boots / 20 / 125
				{ 12, 2158 }, --Fine Leather Boots / 18 / 120
				{ 13, 2161 }, --Embossed Leather Boots / 15 / 85
				{ 14, 2149 }, --Handstitched Leather Boots / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 20855 }, --Black Dragonscale Boots / 61 / 320
				{ 2, 10554 }, --Tough Scorpid Boots / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 28220 }, --Polar Gloves / 80 / 320
				{ 2, 24122 }, --Primal Batskin Gloves / 65 / 320
				{ 3, 23704 }, --Timbermaw Brawlers / 64 / 320
				{ 4, 26279 }, --Stormshroud Gloves / 62 / 320
				{ 5, 19087 }, --Frostsaber Gloves / 59 / 315
				{ 6, 19084 }, --Devilsaur Gauntlets / 58 / 310
				{ 7, 19055 }, --Runic Leather Gauntlets / 54 / 290
				{ 8, 19053 }, --Chimeric Gloves / 53 / 285
				{ 9, 19049 }, --Wicked Leather Gauntlets / 52 / 280
				{ 10, 10630 }, --Gauntlets of the Sea / 46 / 250
				{ 11, 22711 }, --Shadowskin Gloves / 40 / 210
				{ 12, 7156 }, --Guardian Gloves / 38 / 210
				{ 13, 21943 }, --Gloves of the Greatfather / 38 / 210
				{ 14, 3771 }, --Barbaric Gloves / 30 / 170
				{ 15, 9149 }, --Heavy Earthen Gloves / 29 / 170
				{ 16, 3764 }, --Hillman's Leather Gloves / 29 / 170
				{ 17, 9148 }, --Pilferer's Gloves / 28 / 165
				{ 18, 3770 }, --Toughened Leather Gloves / 27 / 160
				{ 19, 9146 }, --Herbalist's Gloves / 27 / 160
				{ 20, 3765 }, --Dark Leather Gloves / 26 / 155
				{ 21, 9145 }, --Fletcher's Gloves / 25 / 150
				{ 22, 9074 }, --Nimble Leather Gloves / 24 / 145
				{ 23, 9072 }, --Red Whelp Gloves / 24 / 145
				{ 24, 7954 }, --Deviate Scale Gloves / 21 / 130
				{ 25, 2164 }, --Fine Leather Gloves / 15 / 105
				{ 26, 3756 }, --Embossed Leather Gloves / 13 / 85
			},
			[MAIL_DIFF] = {
				{ 1, 28223 }, --Icy Scale Gauntlets / 80 / 320
				{ 2, 23708 }, --Chromatic Gauntlets / 70 / 320
				{ 3, 24847 }, --Spitfire Gauntlets / 62 / 320
				{ 4, 24850 }, --Sandstalker Gauntlets / 62 / 320
				{ 5, 24655 }, --Green Dragonscale Gauntlets / 56 / 300
				{ 6, 19064 }, --Heavy Scorpid Gauntlet / 55 / 295
				{ 7, 10542 }, --Tough Scorpid Gloves / 45 / 245
				{ 8, 10619 }, --Dragonscale Gauntlets / 45 / 245
				{ 9, 10509 }, --Turtle Scale Gloves / 41 / 225
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 28472 }, --Bramblewood Helm / 70 / 320
				{ 2, 20854 }, --Molten Helm / 60 / 320
				{ 3, 19082 }, --Runic Leather Headband / 58 / 310
				{ 4, 19071 }, --Wicked Leather Headband / 56 / 300
				{ 5, 10632 }, --Helm of Fire / 50 / 270
				{ 6, 10621 }, --Wolfshead Helm / 45 / 245
				{ 7, 10546 }, --Wild Leather Helmet / 45 / 245
				{ 8, 10531 }, --Big Voodoo Mask / 44 / 240
				{ 9, 10507 }, --Nightscape Headband / 41 / 225
				{ 10, 10490 }, --Comfortable Leather Hat / 40 / 220
			},
			[MAIL_DIFF] = {
				{ 1, 19088 }, --Heavy Scorpid Helm / 59 / 315
				{ 2, 10570 }, --Tough Scorpid Helm / 50 / 270
				{ 3, 10552 }, --Turtle Scale Helm / 46 / 250
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 19097 }, --Devilsaur Leggings / 60 / 320
				{ 2, 19091 }, --Runic Leather Pants / 60 / 320
				{ 3, 19083 }, --Wicked Leather Pants / 58 / 310
				{ 4, 19074 }, --Frostsaber Leggings / 57 / 305
				{ 5, 19080 }, --Warbear Woolies / 57 / 305
				{ 6, 19078 }, --Living Leggings / 57 / 305
				{ 7, 19073 }, --Chimeric Leggings / 56 / 300
				{ 8, 19067 }, --Stormshroud Pants / 55 / 295
				{ 9, 19059 }, --Volcanic Leggings / 54 / 290
				{ 10, 10572 }, --Wild Leather Leggings / 50 / 270
				{ 11, 10560 }, --Big Voodoo Pants / 47 / 260
				{ 12, 10548 }, --Nightscape Pants / 46 / 250
				{ 13, 7149 }, --Barbaric Leggings / 34 / 190
				{ 14, 9195 }, --Dusky Leather Leggings / 33 / 185
				{ 15, 7147 }, --Guardian Pants / 32 / 180
				{ 16, 7135 }, --Dark Leather Pants / 23 / 140
				{ 17, 7133 }, --Fine Leather Pants / 21 / 130
				{ 18, 9068 }, --Light Leather Pants / 19 / 125
				{ 19, 3759 }, --Embossed Leather Pants / 15 / 105
				{ 20, 9064 }, --Rugged Leather Pants / 11 / 65
				{ 21, 2153 }, --Handstitched Leather Pants / 10 / 45
			},
			[MAIL_DIFF] = {
				{ 1, 19107 }, --Black Dragonscale Leggings / 62 / 320
				{ 2, 24654 }, --Blue Dragonscale Leggings / 60 / 320
				{ 3, 19075 }, --Heavy Scorpid Leggings / 57 / 305
				{ 4, 19060 }, --Green Dragonscale Leggings / 54 / 290
				{ 5, 10568 }, --Tough Scorpid Leggings / 49 / 265
				{ 6, 10556 }, --Turtle Scale Leggings / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 24125 }, --Blood Tiger Shoulders / 65 / 320
				{ 2, 23706 }, --Golden Mantle of the Dawn / 64 / 320
				{ 3, 19103 }, --Runic Leather Shoulders / 62 / 320
				{ 4, 19101 }, --Volcanic Shoulders / 61 / 320
				{ 5, 19090 }, --Stormshroud Shoulders / 59 / 315
				{ 6, 19061 }, --Living Shoulders / 54 / 290
				{ 7, 19062 }, --Ironfeather Shoulders / 54 / 290
				{ 8, 10529 }, --Wild Leather Shoulders / 44 / 240
				{ 9, 10516 }, --Nightscape Shoulders / 42 / 230
				{ 10, 7151 }, --Barbaric Shoulders / 35 / 195
				{ 11, 3769 }, --Dark Leather Shoulders / 28 / 165
				{ 12, 9147 }, --Earthen Leather Shoulders / 27 / 160
				{ 13, 3768 }, --Hillman's Shoulders / 26 / 155
			},
			[MAIL_DIFF] = {
				{ 1, 19100 }, --Heavy Scorpid Shoulders / 61 / 320
				{ 2, 19094 }, --Black Dragonscale Shoulders / 60 / 320
				{ 3, 19089 }, --Blue Dragonscale Shoulders / 59 / 315
				{ 4, 10564 }, --Tough Scorpid Shoulders / 48 / 260
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 23709 }, --Corehound Belt / 70 / 320
				{ 2, 23710 }, --Molten Belt / 70 / 320
				{ 3, 28474 }, --Bramblewood Belt / 70 / 320
				{ 4, 23707 }, --Lava Belt / 66 / 320
				{ 5, 22921 }, --Girdle of Insight / 62 / 320
				{ 6, 19092 }, --Wicked Leather Belt / 60 / 320
				{ 7, 23703 }, --Might of the Timbermaw / 58 / 310
				{ 8, 19072 }, --Runic Leather Belt / 56 / 300
				{ 9, 3779 }, --Barbaric Belt / 40 / 220
				{ 10, 9206 }, --Dusky Belt / 39 / 215
				{ 11, 3778 }, --Gem-studded Leather Belt / 37 / 205
				{ 12, 3775 }, --Guardian Belt / 34 / 190
				{ 13, 4097 }, --Raptor Hide Belt / 33 / 185
				{ 14, 3774 }, --Green Leather Belt / 32 / 180
				{ 15, 3767 }, --Hillman's Belt / 25 / 145
				{ 16, 3766 }, --Dark Leather Belt / 25 / 150
				{ 17, 7955 }, --Deviate Scale Belt / 23 / 140
				{ 18, 6702 }, --Murloc Scale Belt / 18 / 120
				{ 19, 3763 }, --Fine Leather Belt / 16 / 110
				{ 20, 3753 }, --Handstitched Leather Belt / 10 / 55
			},
			[MAIL_DIFF] = {
				{ 1, 19070 }, --Heavy Scorpid Belt / 56 / 300
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, 28221 }, --Polar Bracers / 80 / 320
				{ 2, 24123 }, --Primal Batskin Bracers / 65 / 320
				{ 3, 19065 }, --Runic Leather Bracers / 55 / 295
				{ 4, 19052 }, --Wicked Leather Bracers / 53 / 285
				{ 5, 3777 }, --Guardian Leather Bracers / 39 / 215
				{ 6, 9202 }, --Green Whelp Bracers / 38 / 210
				{ 7, 6705 }, --Murloc Scale Bracers / 38 / 210
				{ 8, 9201 }, --Dusky Bracers / 37 / 205
				{ 9, 3776 }, --Green Leather Bracers / 36 / 200
				{ 10, 23399 }, --Barbaric Bracers / 32 / 175
				{ 11, 9065 }, --Light Leather Bracers / 14 / 100
				{ 12, 9059 }, --Handstitched Leather Bracers / 9 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 28224 }, --Icy Scale Bracers / 80 / 320
				{ 2, 24849 }, --Sandstalker Bracers / 62 / 320
				{ 3, 22923 }, --Swift Flight Bracers / 62 / 320
				{ 4, 24846 }, --Spitfire Bracers / 62 / 320
				{ 5, 19048 }, --Heavy Scorpid Bracers / 51 / 275
				{ 6, 10533 }, --Tough Scorpid Bracers / 44 / 240
				{ 7, 10518 }, --Turtle Scale Bracers / 42 / 230
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 14932 }, --Thick Leather Ammo Pouch / 45 / 245
				{ 2, 9194 }, --Heavy Leather Ammo Pouch / 35 / 170
				{ 3, 9062 }, --Small Leather Ammo Pouch / 5 / 60
				{ 5, 14930 }, --Quickdraw Quiver / 45 / 245
				{ 6, 9193 }, --Heavy Quiver / 35 / 170
				{ 7, 9060 }, --Light Leather Quiver / 5 / 60
				{ 16, 5244 }, --Kodo Hide Bag / 5 / 70
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 22331 }, --Rugged Leather / 50 / 250
				{ 2, 20650 }, --Thick Leather / 40 / 200
				{ 3, 20649 }, --Heavy Leather / 30 / 150
				{ 4, 20648 }, --Medium Leather / 20 / 100
				{ 5, 2881 }, --Light Leather / 10 / 20
				{ 7, 22727 }, --Core Armor Kit / 60 / 320
				{ 8, 19058 }, --Rugged Armor Kit / 50 / 250
				{ 9, 10487 }, --Thick Armor Kit / 40 / 220
				{ 10, 3780 }, --Heavy Armor Kit / 30 / 170
				{ 11, 2165 }, --Medium Armor Kit / 15 / 115
				{ 12, 2152 }, --Light Armor Kit / 5 / 30
				{ 16, 19047 }, --Cured Rugged Hide / 50 / 250
				{ 17, 10482 }, --Cured Thick Hide / 40 / 200
				{ 18, 3818 }, --Cured Heavy Hide / 30 / 160
				{ 19, 3817 }, --Cured Medium Hide / 20 / 115
				{ 20, 3816 }, --Cured Light Hide / 10 / 55
				{ 22, 23190 }, --Heavy Leather Ball / 1 / 150
			},
		},
	}
}

data["MiningBC"] = {
	name = ALIL["Mining"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "Mining",
	},
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
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = {
		[1] = "Herbalism",
	},
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
		{
			name = AL["Artisan"],
			[NORMAL_DIFF] = {
				{ 1,  13467 }, -- Icecap
				{ 2,  13466 }, -- Plaguebloom
				{ 3,  13465 }, -- Mountain Silversage
				{ 4,  13463 }, -- Dreamfoil
				{ 5,  13464 }, -- Golden Sansam
				{ 6, 8846 }, -- Gromsblood
				{ 7, 8845 }, -- Ghost Mushroom
				{ 8, 8839 }, -- Blindweed
				{ 9, 8838 }, -- Sungrass
				{ 16,  13468 }, -- Black Lotus
				{ 18,  19727 }, -- Blood Scythe
				{ 19,  19726 }, -- Bloodvine
			}
		},
		{
			name = AL["Expert"],
			[NORMAL_DIFF] = {
				{ 1, 8836 }, -- Arthas' Tears
				{ 2, 8831, 8153 }, -- Purple Lotus
				{ 3, 4625 }, -- Firebloom
				{ 4, 3819 }, -- Wintersbite
				{ 5, 3358 }, -- Khadgar's Whisker
				{ 6, 3821 }, -- Goldthorn
				{ 7, 3818 }, -- Fadeleaf
				--{ 17, 8153 }, -- Wildvine
			}
		},
		{
			name = AL["Journeyman"],
			[NORMAL_DIFF] = {
				{ 1, 3357 }, -- Liferoot
				{ 2, 3356 }, -- Kingsblood
				{ 3, 3369 }, -- Grave Moss
				{ 4, 3355 }, -- Wild Steelbloom
				{ 5, 2453 }, -- Bruiseweed
				{ 6, 3820 }, -- Stranglekelp
			}
		},
		{
			name = AL["Apprentice"],
			[NORMAL_DIFF] = {
				{ 1,  2450, 2452 }, -- Briarthorn
				{ 2,  785, 2452 }, -- Mageroyal
				{ 3,  2449 }, -- Earthroot
				{ 4,  765 }, -- Silverleaf
				{ 5,  2447 }, -- Peacebloom
				--{ 16,  2452 }, -- Swiftthistle
			}
		},
	}
}

data["CookingBC"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "Cooking",
	},
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
			name = ALIL["Hit"],
			[NORMAL_DIFF] = {
				{ 1, 43765 }, -- Spicy Hot Talbuk (325)
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 33292 }, -- Blackened Sporefish (310)
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
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 43779 }, -- Delicious Chocolate Cake (1)
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
	CorrespondingFields = {
		[1] = "FirstAid",
	},
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

data["RoguePoisonsBC"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = {
		[1] = "RoguePoisons",
	},
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