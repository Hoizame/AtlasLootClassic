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
local data = AtlasLoot.ItemDB:Add(addonname, 1)

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
--local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
--local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

data["Alchemy"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 17635 }, --Flask of the Titans
				{ 2, 17636 }, --Flask of Distilled Wisdom
				{ 3, 17637 }, --Flask of Supreme Power
				{ 4, 17638 }, --Flask of Chromatic Resistance
				{ 16, 17634 }, --Flask of Petrification
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 17560 }, --Transmute: Fire to Earth
				{ 2, 17565 }, --Transmute: Life to Earth
				{ 4, 17561 }, --Transmute: Earth to Water
				{ 5, 17563 }, --Transmute: Undeath to Water
				{ 7, 17562 }, --Transmute: Water to Air
				{ 9, 17564 }, --Transmute: Water to Undeath
				{ 11, 17566 }, --Transmute: Earth to Life
				{ 13, 17559 }, --Transmute: Air to Fire
				{ 16, 17187 }, --Transmute: Arcanite
				{ 17, 11479 }, --Transmute: Iron to Gold
				{ 18, 11480 }, --Transmute: Mithril to Truesilver
				{ 20, 25146 }, --Transmute: Elemental Fire
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17556 }, --Major Healing Potion
				{ 2, 11457 }, --Superior Healing Potion
				{ 3, 7181 }, --Greater Healing Potion
				{ 4, 3447 }, --Healing Potion
				{ 5, 2337 }, --Lesser Healing Potion
				{ 6, 2330 }, --Minor Healing Potion
				{ 8, 2332 }, --Minor Rejuvenation Potion
				{ 10, 24366 }, --Greater Dreamless Sleep Potion
				{ 12, 11458 }, --Wildvine Potion
				{ 13, 4508 }, --Discolored Healing Potion
				{ 16, 17580 }, --Major Mana Potion
				{ 17, 17553 }, --Superior Mana Potion
				{ 18, 11448 }, --Greater Mana Potion
				{ 19, 3452 }, --Mana Potion
				{ 20, 3173 }, --Lesser Mana Potion
				{ 21, 2331 }, --Minor Mana Potion
				{ 23, 22732 }, --Major Rejuvenation Potion
				{ 25, 15833 }, --Dreamless Sleep Potion
				{ 27, 24365 }, --Mageblood Potion
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17574 }, --Greater Fire Protection Potion
				{ 2, 17576 }, --Greater Nature Protection Potion
				{ 3, 17575 }, --Greater Frost Protection Potion
				{ 4, 17578 }, --Greater Shadow Protection Potion
				{ 5, 17577 }, --Greater Arcane Protection Potion
				{ 7, 11453 }, --Magic Resistance Potion
				{ 8, 3174 }, --Elixir of Poison Resistance
				{ 16, 7257 }, --Fire Protection Potion
				{ 17, 7259 }, --Nature Protection Potion
				{ 18, 7258 }, --Frost Protection Potion
				{ 19, 7256 }, --Shadow Protection Potion
				{ 20, 7255 }, --Holy Protection Potion
				{ 22, 3172 }, --Minor Magic Resistance Potion
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 11464 }, --Invisibility Potion
				{ 2, 2335 }, --Swiftness Potion
				{ 3, 6624 }, --Free Action Potion
				{ 4, 3175 }, --Limited Invulnerability Potion
				{ 5, 24367 }, --Living Action Potion
				{ 6, 7841 }, --Swim Speed Potion
				{ 8, 17572 }, --Purification Potion
				{ 10, 17552 }, --Mighty Rage Potion
				{ 11, 6618 }, --Great Rage Potion
				{ 12, 6617 }, --Rage Potion
				{ 16, 3448 }, --Lesser Invisibility Potion
				{ 23, 11452 }, --Restorative Potion
				{ 25, 17570 }, --Greater Stoneshield Potion
				{ 26, 4942 }, --Lesser Stoneshield Potion
			},
		},
		{
			name = AL["Stat Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 24368 }, --Mighty Troll
				{ 2, 3451 }, --Major Troll
				{ 3, 3176 }, --Strong Troll
				{ 4, 3170 }, --Weak Troll
				{ 6, 17554 }, --Elixir of Superior Defense
				{ 7, 11450 }, --Elixir of Greater Defense
				{ 8, 3177 }, --Elixir of Defense
				{ 9, 7183 }, --Elixir of Minor Defense
				{ 11, 11472 }, --Elixir of Giants
				{ 12, 3188 }, --Elixir of Ogre
				{ 13, 2329 }, --Elixir of Lion
				{ 16, 11467 }, --Elixir of Greater Agility
				{ 17, 11449 }, --Elixir of Agility
				{ 18, 2333 }, --Elixir of Lesser Agility
				{ 19, 3230 }, --Elixir of Minor Agility
				{ 21, 11465 }, --Elixir of Greater Intellect
				{ 22, 3171 }, --Elixir of Wisdom
				{ 24, 17573 }, --Greater Arcane Elixir
				{ 25, 11461 }, --Arcane Elixir
			},
		},
		{
			name = AL["Special Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 26277 }, --Elixir of Greater Firepower
				{ 2, 17555 }, --Elixir of the Sages
				{ 5, 3450 }, --Elixir of Fortitude
				{ 7, 17557 }, --Elixir of Brute Force
				{ 8, 17571 }, --Elixir of the Mongoose
				{ 10, 11477 }, --Elixir of Demonslaying
				{ 16, 7845 }, --Elixir of Firepower
				{ 17, 21923 }, --Elixir of Frost Power
				{ 18, 11476 }, --Elixir of Shadow Power
				{ 20, 2334 }, --Elixir of Minor Fortitude
				{ 22, 8240 }, --Elixir of Giant Growth
			},
		},
		{
			name = AL["Misc Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 11478 }, --Elixir of Detect Demon
				{ 2, 12609 }, --Catseye Elixir
				{ 4, 22808 }, --Elixir of Greater Water Breathing
				{ 6, 11468 }, --Elixir of Dream Vision

				{ 16, 11460 }, --Elixir of Detect Undead
				{ 17, 3453 }, --Elixir of Detect Lesser Invisibility
				{ 19, 7179 }, --Elixir of Water Breathing
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 17632 }, --Alchemist's Stone
				{ 3, 11473 }, --Ghost Dye
				{ 5, 24266 }, --Gurubashi Mojo Madness
				{ 7, 11466 }, --Gift of Arthas
				{ 8, 3449 }, --Shadow Oil
				{ 9, 3454 }, --Frost Oil
				{ 10, 11451 }, --Oil of Immolation
				{ 16, 11459 }, --Philosophers' Stone
				{ 18, 11456 }, --Goblin Rocket Fuel
				{ 23, 7836 }, --Blackmouth Oil
				{ 24, 7837 }, --Fire Oil
				{ 25, 17551 }, --Stonescale Oil
			},
		},
	},
}

data["Blacksmithing"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1, 23638 }, --Black Amnesty / 66
				{ 2, 16995 }, --Heartseeker / 63
				{ 3, 10013 }, --Ebon Shiv / 51
				{ 4, 15973 }, --Searing Golden Blade / 39
				{ 5, 15972 }, --Glinting Steel Dagger / 36
				{ 6, 3295 }, --Deadly Bronze Poniard / 25
				{ 7, 6517 }, --Pearl-handled Dagger / 23
				{ 8, 3491 }, --Big Bronze Knife / 20
				{ 9, 8880 }, --Copper Dagger / 11
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 20897 }, --Dark Iron Destroyer / 65
				{ 3, 16991 }, --Annihilator / 63
				{ 4, 16970 }, --Dawn / 55
				{ 5, 16969 }, --Ornate Thorium Handaxe / 55
				{ 6, 9995 }, --Blue Glittering Axe / 44
				{ 7, 9993 }, --Heavy Mithril Axe / 42
				{ 8, 21913 }, --Edge of Winter / 38
				{ 9, 2741 }, --Bronze Axe / 23
				{ 10, 3294 }, --Thick War Axe / 17
				{ 11, 2738 }, --Copper Axe / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 23653 }, --Nightfall / 70
				{ 18, 16994 }, --Arcanite Reaper / 63
				{ 19, 15294 }, --Dark Iron Sunderer / 57
				{ 20, 16971 }, --Huge Thorium Battleaxe / 56
				{ 21, 3500 }, --Shadow Crescent Axe / 40
				{ 22, 3498 }, --Massive Iron Axe / 37
				{ 23, 9987 }, --Bronze Battle Axe / 27
				{ 24, 3293 }, --Copper Battle Axe / 13
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 23650 }, --Ebon Hand / 70
				{ 3, 16993 }, --Masterwork Stormhammer / 63
				{ 4, 27830 }, --Persuader / 63
				{ 5, 16984 }, --Volcanic Hammer / 58
				{ 6, 16983 }, --Serenity / 57
				{ 7, 10009 }, --Runed Mithril Hammer / 49
				{ 8, 10003 }, --The Shatterer / 47
				{ 9, 10001 }, --Big Black Mace / 46
				{ 10, 3297 }, --Mighty Iron Hammer / 30
				{ 11, 6518 }, --Iridescent Hammer / 28
				{ 12, 3296 }, --Heavy Bronze Mace / 25
				{ 13, 2740 }, --Bronze Mace / 22
				{ 14, 2737 }, --Copper Mace / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 21161 }, --Sulfuron Hammer / 67
				{ 18, 16988 }, --Hammer of the Titans / 63
				{ 19, 16973 }, --Enchanted Battlehammer / 56
				{ 20, 15292 }, --Dark Iron Pulverizer / 55
				{ 21, 3495 }, --Golden Iron Destroyer / 34
				{ 22, 3494 }, --Solid Iron Maul / 31
				{ 23, 9985 }, --Bronze Warhammer / 25
				{ 24, 7408 }, --Heavy Copper Maul / 16
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2, 23652 }, --Blackguard / 70
				{ 3, 20890 }, --Dark Iron Reaver / 65
				{ 4, 27832 }, --Sageblade / 64
				{ 5, 16992 }, --Frostguard / 63
				{ 6, 16978 }, --Blazing Rapier / 56
				{ 7, 10007 }, --Phantom Blade / 49
				{ 8, 10005 }, --Dazzling Mithril Rapier / 48
				{ 9, 9997 }, --Wicked Mithril Blade / 45
				{ 10, 3493 }, --Jade Serpentblade / 35
				{ 11, 3492 }, --Hardened Iron Shortsword / 32
				{ 12, 2742 }, --Bronze Shortsword / 24
				{ 13, 2739 }, --Copper Shortsword / 9
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 16990 }, --Arcanite Champion / 63
				{ 18, 16985 }, --Corruption / 58
				{ 19, 10015 }, --Truesilver Champion / 52
				{ 20, 3497 }, --Frost Tiger Blade / 40
				{ 21, 3496 }, --Moonsteel Broadsword / 36
				{ 22, 9986 }, --Bronze Greatsword / 26
				{ 23, 3292 }, --Heavy Copper Broadsword / 19
				{ 24, 9983 }, --Copper Claymore / 11
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, 23639 }, --Blackfury / 66
				{ 2, 10011 }, --Blight / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[MAIL_DIFF] = {
				{ 1, 27590 }, --Obsidian Mail Tunic / 72
				{ 2, 24136 }, --Bloodsoul Breastplate / 65
				{ 3, 16746 }, --Invulnerable Mail / 63
				{ 4, 15293 }, --Dark Iron Mail / 56
				{ 5, 16650 }, --Wildthorn Mail / 54
				{ 6, 16648 }, --Radiant Breastplate / 54
				{ 7, 3511 }, --Golden Scale Cuirass / 40
				{ 8, 9916 }, --Steel Breastplate / 40
				{ 9, 3508 }, --Green Iron Hauberk / 36
				{ 10, 9813 }, --Barbaric Iron Breastplate / 32
				{ 11, 2675 }, --Shining Silver Breastplate / 29
				{ 12, 2673 }, --Silvered Bronze Breastplate / 26
				{ 13, 2670 }, --Rough Bronze Cuirass / 23
				{ 14, 8367 }, --Ironforge Breastplate / 20
				{ 15, 2667 }, --Runed Copper Breastplate / 18
				{ 16, 3321 }, --Copper Chain Vest / 10
				{ 17, 12260 }, --Rough Copper Vest / 7
			},
			[PLATE_DIFF] = {
				{ 1, 28242 }, --Icebane Breastplate / 80
				{ 2, 27587 }, --Thick Obsidian Breastplate / 72
				{ 3, 28461 }, --Ironvine Breastplate / 70
				{ 4, 24139 }, --Darksoul Breastplate / 65
				{ 5, 24914 }, --Darkrune Breastplate / 63
				{ 6, 16745 }, --Enchanted Thorium Breastplate / 63
				{ 7, 16731 }, --Runic Breastplate / 62
				{ 8, 16663 }, --Imperial Plate Chest / 60
				{ 9, 15296 }, --Dark Iron Plate / 59
				{ 10, 16667 }, --Demon Forged Breastplate / 57
				{ 11, 16642 }, --Thorium Armor / 50
				{ 12, 9974 }, --Truesilver Breastplate / 49
				{ 13, 9972 }, --Ornate Mithril Breastplate / 48
				{ 14, 9959 }, --Heavy Mithril Breastplate / 46
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[MAIL_DIFF] = {
				{ 1, 23629 }, --Heavy Timbermaw Boots / 64
				{ 2, 16656 }, --Radiant Boots / 58
				{ 3, 3515 }, --Golden Scale Boots / 40
				{ 4, 3513 }, --Polished Steel Boots / 37
				{ 5, 9818 }, --Barbaric Iron Boots / 36
				{ 6, 3334 }, --Green Iron Boots / 29
				{ 7, 3331 }, --Silvered Bronze Boots / 26
				{ 8, 7817 }, --Rough Bronze Boots / 18
				{ 9, 3319 }, --Copper Chain Boots / 9
			},
			[PLATE_DIFF] = {
				{ 1, 24399 }, --Dark Iron Boots / 70
				{ 2, 16657 }, --Imperial Plate Boots / 59
				{ 3, 16652 }, --Thorium Boots / 56
				{ 4, 9979 }, --Ornate Mithril Boots / 49
				{ 5, 9968 }, --Heavy Mithril Boots / 47
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[MAIL_DIFF] = {
				{ 1, 27589 }, --Black Grasp of the Destroyer / 70
				{ 2, 24138 }, --Bloodsoul Gauntlets / 65
				{ 3, 16661 }, --Storm Gauntlets / 59
				{ 4, 16654 }, --Radiant Gloves / 57
				{ 5, 11643 }, --Golden Scale Gauntlets / 41
				{ 6, 9820 }, --Barbaric Iron Gloves / 37
				{ 7, 3336 }, --Green Iron Gauntlets / 30
				{ 8, 3333 }, --Silvered Bronze Gauntlets / 27
				{ 9, 3325 }, --Gemmed Copper Gauntlets / 15
				{ 10, 3323 }, --Runed Copper Gauntlets / 12
			},
			[PLATE_DIFF] = {
				{ 1, 28243 }, --Icebane Gauntlets / 80
				{ 2, 23637 }, --Dark Iron Gauntlets / 70
				{ 3, 28462 }, --Ironvine Gloves / 70
				{ 4, 23633 }, --Gloves of the Dawn / 64
				{ 5, 24912 }, --Darkrune Gauntlets / 63
				{ 6, 16741 }, --Stronghold Gauntlets / 62
				{ 7, 16655 }, --Fiery Plate Gauntlets / 58
				{ 8, 9954 }, --Truesilver Gauntlets / 45
				{ 9, 9950 }, --Ornate Mithril Gloves / 44
				{ 10, 9928 }, --Heavy Mithril Gauntlet / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[MAIL_DIFF] = {
				{ 1, 16728 }, --Helm of the Great Chief / 61
				{ 2, 16659 }, --Radiant Circlet / 59
				{ 3, 9961 }, --Mithril Coif / 46
				{ 4, 3503 }, --Golden Scale Coif / 38
				{ 5, 9814 }, --Barbaric Iron Helm / 35
				{ 6, 3502 }, --Green Iron Helm / 34
			},
			[PLATE_DIFF] = {
				{ 1, 23636 }, --Dark Iron Helm / 66
				{ 2, 24913 }, --Darkrune Helm / 63
				{ 3, 16742 }, --Enchanted Thorium Helm / 62
				{ 4, 16729 }, --Lionheart Helm / 61
				{ 5, 16726 }, --Runic Plate Helm / 61
				{ 6, 16724 }, --Whitesoul Helm / 60
				{ 7, 16658 }, --Imperial Plate Helm / 59
				{ 8, 16653 }, --Thorium Helm / 56
				{ 9, 9980 }, --Ornate Mithril Helm / 49
				{ 10, 9970 }, --Heavy Mithril Helm / 47
				{ 11, 9935 }, --Steel Plate Helm / 43
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[MAIL_DIFF] = {
				{ 1, 16725 }, --Radiant Leggings / 61
				{ 2, 9931 }, --Mithril Scale Pants / 42
				{ 3, 9957 }, --Orcish War Leggings / 42
				{ 4, 3507 }, --Golden Scale Leggings / 34
				{ 5, 3506 }, --Green Iron Leggings / 31
				{ 6, 12259 }, --Silvered Bronze Leggings / 31
				{ 7, 2668 }, --Rough Bronze Leggings / 21
				{ 8, 3324 }, --Runed Copper Pants / 13
				{ 9, 2662 }, --Copper Chain Pants / 9
			},
			[PLATE_DIFF] = {
				{ 1, 24140 }, --Darksoul Leggings / 65
				{ 2, 16744 }, --Enchanted Thorium Leggings / 63
				{ 3, 16732 }, --Runic Plate Leggings / 62
				{ 4, 16730 }, --Imperial Plate Leggings / 61
				{ 5, 16662 }, --Thorium Leggings / 60
				{ 6, 20876 }, --Dark Iron Leggings / 60
				{ 7, 27829 }, --Titanic Leggings / 60
				{ 8, 9945 }, --Ornate Mithril Pants / 44
				{ 9, 9933 }, --Heavy Mithril Pants / 42
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[MAIL_DIFF] = {
				{ 1, 24137 }, --Bloodsoul Shoulders / 65
				{ 2, 20873 }, --Fiery Chain Shoulders / 62
				{ 3, 9966 }, --Mithril Scale Shoulders / 47
				{ 4, 3505 }, --Golden Scale Shoulders / 35
				{ 5, 9811 }, --Barbaric Iron Shoulders / 32
				{ 6, 3504 }, --Green Iron Shoulders / 32
				{ 7, 3330 }, --Silvered Bronze Shoulders / 25
				{ 8, 3328 }, --Rough Bronze Shoulders / 22
			},
			[PLATE_DIFF] = {
				{ 1, 24141 }, --Darksoul Shoulders / 65
				{ 2, 16664 }, --Runic Plate Shoulders / 60
				{ 3, 15295 }, --Dark Iron Shoulders / 58
				{ 4, 16660 }, --Dawnbringer Shoulders / 58
				{ 5, 16646 }, --Imperial Plate Shoulders / 53
				{ 6, 9952 }, --Ornate Mithril Shoulder / 45
				{ 7, 9926 }, --Heavy Mithril Shoulder / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[MAIL_DIFF] = {
				{ 1, 27588 }, --Light Obsidian Belt / 68
				{ 2, 20872 }, --Fiery Chain Girdle / 59
				{ 3, 23628 }, --Heavy Timbermaw Belt / 58
				{ 4, 16645 }, --Radiant Belt / 52
				{ 5, 2666 }, --Runed Copper Belt / 18
				{ 6, 2661 }, --Copper Chain Belt / 11
			},
			[PLATE_DIFF] = {
				{ 1, 28463 }, --Ironvine Belt / 70
				{ 2, 27585 }, --Heavy Obsidian Belt / 68
				{ 3, 23632 }, --Girdle of the Dawn / 58
				{ 4, 16647 }, --Imperial Plate Belt / 53
				{ 5, 16643 }, --Thorium Belt / 50
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[MAIL_DIFF] = {
				{ 1, 9937 }, --Mithril Scale Bracers / 43
				{ 2, 7223 }, --Golden Scale Bracers / 37
				{ 3, 3501 }, --Green Iron Bracers / 33
				{ 4, 2672 }, --Patterned Bronze Bracers / 25
				{ 5, 2664 }, --Runed Copper Bracers / 19
				{ 6, 2663 }, --Copper Bracers / 7
			},
			[PLATE_DIFF] = {
				{ 1, 28244 }, --Icebane Bracers / 80
				{ 2, 20874 }, --Dark Iron Bracers / 59
				{ 3, 16649 }, --Imperial Plate Bracers / 54
				{ 4, 16644 }, --Thorium Bracers / 51
			},
		},
		{
			name = ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 27586 }, --Jagged Obsidian Shield / 70
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 9964 }, --Mithril Spurs / 43

				{ 3, 7224 }, --Steel Weapon Chain / 38
				{ 18, 7222 }, --Iron Counterweight / 33

				{ 5, 16651 }, --Thorium Shield Spike / 55
				{ 6, 9939 }, --Mithril Shield Spike / 43
				{ 20, 7221 }, --Iron Shield Spike / 30


				{ 8, 22757 }, --Elemental Sharpening Stone / 60
				{ 9, 16641 }, --Dense Sharpening Stone / 45
				{ 10, 9918 }, --Solid Sharpening Stone / 35
				{ 11, 2674 }, --Heavy Sharpening Stone / 25
				{ 12, 2665 }, --Coarse Sharpening Stone / 15
				{ 13, 2660 }, --Rough Sharpening Stone / 5

				{ 24, 16640 }, --Dense Weightstone / 45
				{ 25, 9921 }, --Solid Weightstone / 35
				{ 26, 3117 }, --Heavy Weightstone / 25
				{ 27, 3116 }, --Coarse Weightstone / 15
				{ 28, 3115 }, --Rough Weightstone / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 20201 }, --Arcanite Rod / 55
				{ 2, 14380 }, --Truesilver Rod / 40
				{ 16, 14379 }, --Golden Rod / 30
				{ 17, 7818 }, --Silver Rod / 20
				{ 4, 19669 }, --Arcanite Skeleton Key / 55
				{ 5, 19668 }, --Truesilver Skeleton Key / 40
				{ 19, 19667 }, --Golden Skeleton Key / 30
				{ 20, 19666 }, --Silver Skeleton Key / 20
				{ 7, 11454 }, --Inlaid Mithril Cylinder / 42
				{ 22, 8768 }, --Iron Buckle / 30
				{ 9, 16639 }, --Dense Grinding Stone / 45
				{ 10, 9920 }, --Solid Grinding Stone / 35
				{ 11, 3337 }, --Heavy Grinding Stone / 25
				{ 24, 3326 }, --Coarse Grinding Stone / 20
				{ 25, 3320 }, --Rough Grinding Stone / 10
			},
		},
	}
}

data["Enchanting"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Oil"],
			[NORMAL_DIFF] = {
				{ 1, 25130 }, --Brilliant Mana Oil / 310
				{ 2, 25129 }, --Brilliant Wizard Oil / 310
				{ 3, 25128 }, --Wizard Oil / 285
				{ 4, 25127 }, --Lesser Mana Oil / 260
				{ 5, 25126 }, --Lesser Wizard Oil / 210
				{ 6, 25125 }, --Minor Mana Oil / 160
				{ 7, 25124 }, --Minor Wizard Oil / 55
			}
		},
		{
			name = ALIL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 14810 }, --Greater Mystic Wand / 195
				{ 2, 14809 }, --Lesser Mystic Wand / 175
				{ 3, 14807 }, --Greater Magic Wand / 110
				{ 4, 14293 }, --Lesser Magic Wand / 75
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 20051 }, --Runed Arcanite Rod / 310
				{ 2, 13702 }, --Runed Truesilver Rod / 220
				{ 3, 13628 }, --Runed Golden Rod / 175
				{ 4, 7795 }, --Runed Silver Rod / 130
				{ 5, 7421 }, --Runed Copper Rod / 5
				{ 16, 15596 }, --Smoking Heart of the Mountain / 285
				{ 18, 17181 }, --Enchanted Leather / 250
				{ 20, 17180 }, --Enchanted Thorium / 250
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 23804 }, --Enchant Weapon - Mighty Intellect / 320
				{ 2, 20034 }, --Enchant Weapon - Crusader / 320
				{ 3, 20032 }, --Enchant Weapon - Lifestealing / 320
				{ 4, 22749 }, --Enchant Weapon - Spell Power / 320
				{ 5, 22750 }, --Enchant Weapon - Healing Power / 320
				{ 6, 23803 }, --Enchant Weapon - Mighty Spirit / 320
				{ 7, 20031 }, --Enchant Weapon - Superior Striking / 320
				{ 8, 20033 }, --Enchant Weapon - Unholy Weapon / 315
				{ 9, 23799 }, --Enchant Weapon - Strength / 310
				{ 10, 23800 }, --Enchant Weapon - Agility / 310
				{ 11, 20029 }, --Enchant Weapon - Icy Chill / 305
				{ 12, 13898 }, --Enchant Weapon - Fiery Weapon / 285
				{ 13, 13943 }, --Enchant Weapon - Greater Striking / 265
				{ 14, 13915 }, --Enchant Weapon - Demonslaying / 250
				{ 15, 13693 }, --Enchant Weapon - Striking / 215
				{ 16, 21931 }, --Enchant Weapon - Winter / 210
				{ 17, 13653 }, --Enchant Weapon - Lesser Beastslayer / 195
				{ 18, 13655 }, --Enchant Weapon - Lesser Elemental Slayer / 195
				{ 19, 13503 }, --Enchant Weapon - Lesser Striking / 165
				{ 20, 7788 }, --Enchant Weapon - Minor Striking / 120
				{ 21, 7786 }, --Enchant Weapon - Minor Beastslayer / 120
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20035 }, --Enchant 2H Weapon - Major Spirit / 320
				{ 2, 20036 }, --Enchant 2H Weapon - Major Intellect / 320
				{ 3, 20030 }, --Enchant 2H Weapon - Superior Impact / 315
				{ 4, 27837 }, --Enchant 2H Weapon - Agility / 310
				{ 5, 13937 }, --Enchant 2H Weapon - Greater Impact / 260
				{ 6, 13695 }, --Enchant 2H Weapon - Impact / 220
				{ 7, 13529 }, --Enchant 2H Weapon - Lesser Impact / 170
				{ 8, 13380 }, --Enchant 2H Weapon - Lesser Spirit / 135
				{ 9, 7745 }, --Enchant 2H Weapon - Minor Impact / 130
				{ 10, 7793 }, --Enchant 2H Weapon - Lesser Intellect / 130
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25086 }, --Enchant Cloak - Dodge / 320
				{ 2, 25081 }, --Enchant Cloak - Greater Fire Resistance / 320
				{ 3, 25082 }, --Enchant Cloak - Greater Nature Resistance / 320
				{ 4, 25084 }, --Enchant Cloak - Subtlety / 320
				{ 5, 25083 }, --Enchant Cloak - Stealth / 320
				{ 6, 20015 }, --Enchant Cloak - Superior Defense / 305
				{ 7, 20014 }, --Enchant Cloak - Greater Resistance / 285
				{ 8, 13882 }, --Enchant Cloak - Lesser Agility / 245
				{ 9, 13794 }, --Enchant Cloak - Resistance / 225
				{ 10, 13746 }, --Enchant Cloak - Greater Defense / 225
				{ 11, 13657 }, --Enchant Cloak - Fire Resistance / 195
				{ 12, 13635 }, --Enchant Cloak - Defense / 175
				{ 13, 13522 }, --Enchant Cloak - Lesser Shadow Resistance / 160
				{ 14, 7861 }, --Enchant Cloak - Lesser Fire Resistance / 150
				{ 15, 13421 }, --Enchant Cloak - Lesser Protection / 140
				{ 16, 13419 }, --Enchant Cloak - Minor Agility / 135
				{ 17, 7771 }, --Enchant Cloak - Minor Protection / 110
				{ 18, 7454 }, --Enchant Cloak - Minor Resistance / 95
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20025 }, --Enchant Chest - Greater Stats / 320
				{ 2, 20028 }, --Enchant Chest - Major Mana / 310
				{ 3, 20026 }, --Enchant Chest - Major Health / 295
				{ 4, 13941 }, --Enchant Chest - Stats / 265
				{ 5, 13917 }, --Enchant Chest - Superior Mana / 250
				{ 6, 13858 }, --Enchant Chest - Superior Health / 240
				{ 7, 13700 }, --Enchant Chest - Lesser Stats / 220
				{ 8, 13663 }, --Enchant Chest - Greater Mana / 205
				{ 9, 13640 }, --Enchant Chest - Greater Health / 180
				{ 10, 13626 }, --Enchant Chest - Minor Stats / 175
				{ 11, 13607 }, --Enchant Chest - Mana / 170
				{ 12, 13538 }, --Enchant Chest - Lesser Absorption / 165
				{ 13, 7857 }, --Enchant Chest - Health / 145
				{ 14, 7776 }, --Enchant Chest - Lesser Mana / 115
				{ 15, 7748 }, --Enchant Chest - Lesser Health / 105
				{ 16, 7426 }, --Enchant Chest - Minor Absorption / 90
				{ 17, 7443 }, --Enchant Chest - Minor Mana / 80
				{ 18, 7420 }, --Enchant Chest - Minor Health / 70
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20023 }, --Enchant Boots - Greater Agility / 315
				{ 2, 20024 }, --Enchant Boots - Spirit / 295
				{ 3, 20020 }, --Enchant Boots - Greater Stamina / 280
				{ 4, 13935 }, --Enchant Boots - Agility / 255
				{ 5, 13890 }, --Enchant Boots - Minor Speed / 245
				{ 6, 13836 }, --Enchant Boots - Stamina / 235
				{ 7, 13687 }, --Enchant Boots - Lesser Spirit / 210
				{ 8, 13644 }, --Enchant Boots - Lesser Stamina / 190
				{ 9, 13637 }, --Enchant Boots - Lesser Agility / 180
				{ 10, 7867 }, --Enchant Boots - Minor Agility / 150
				{ 11, 7863 }, --Enchant Boots - Minor Stamina / 150
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25080 }, --Enchant Gloves - Superior Agility / 320
				{ 2, 25073 }, --Enchant Gloves - Shadow Power / 320
				{ 3, 25074 }, --Enchant Gloves - Frost Power / 320
				{ 4, 25072 }, --Enchant Gloves - Threat / 320
				{ 5, 25079 }, --Enchant Gloves - Healing Power / 320
				{ 6, 25078 }, --Enchant Gloves - Fire Power / 320
				{ 7, 20013 }, --Enchant Gloves - Greater Strength / 315
				{ 8, 20012 }, --Enchant Gloves - Greater Agility / 290
				{ 9, 13948 }, --Enchant Gloves - Minor Haste / 270
				{ 10, 13947 }, --Enchant Gloves - Riding Skill / 270
				{ 11, 13868 }, --Enchant Gloves - Advanced Herbalism / 245
				{ 12, 13887 }, --Enchant Gloves - Strength / 245
				{ 13, 13841 }, --Enchant Gloves - Advanced Mining / 235
				{ 14, 13815 }, --Enchant Gloves - Agility / 230
				{ 15, 13698 }, --Enchant Gloves - Skinning / 220
				{ 16, 13617 }, --Enchant Gloves - Herbalism / 170
				{ 17, 13620 }, --Enchant Gloves - Fishing / 170
				{ 18, 13612 }, --Enchant Gloves - Mining / 170
			}
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20016 }, --Enchant Shield - Superior Spirit / 300
				{ 2, 20017 }, --Enchant Shield - Greater Stamina / 285
				{ 3, 13933 }, --Enchant Shield - Frost Resistance / 255
				{ 4, 13905 }, --Enchant Shield - Greater Spirit / 250
				{ 5, 13817 }, --Enchant Shield - Stamina / 230
				{ 6, 13689 }, --Enchant Shield - Lesser Block / 215
				{ 7, 13659 }, --Enchant Shield - Spirit / 200
				{ 8, 13631 }, --Enchant Shield - Lesser Stamina / 175
				{ 9, 13485 }, --Enchant Shield - Lesser Spirit / 155
				{ 10, 13464 }, --Enchant Shield - Lesser Protection / 140
				{ 11, 13378 }, --Enchant Shield - Minor Stamina / 130
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 23802 }, --Enchant Bracer - Healing Power / 320
				{ 2, 20011 }, --Enchant Bracer - Superior Stamina / 320
				{ 3, 20010 }, --Enchant Bracer - Superior Strength / 315
				{ 4, 23801 }, --Enchant Bracer - Mana Regeneration / 310
				{ 5, 20009 }, --Enchant Bracer - Superior Spirit / 290
				{ 6, 20008 }, --Enchant Bracer - Greater Intellect / 275
				{ 7, 13945 }, --Enchant Bracer - Greater Stamina / 265
				{ 8, 13939 }, --Enchant Bracer - Greater Strength / 260
				{ 9, 13931 }, --Enchant Bracer - Deflection / 255
				{ 10, 13846 }, --Enchant Bracer - Greater Spirit / 240
				{ 11, 13822 }, --Enchant Bracer - Intellect / 230
				{ 12, 13661 }, --Enchant Bracer - Strength / 200
				{ 13, 13648 }, --Enchant Bracer - Stamina / 190
				{ 14, 13646 }, --Enchant Bracer - Lesser Deflection / 190
				{ 15, 13642 }, --Enchant Bracer - Spirit / 185
				{ 16, 13622 }, --Enchant Bracer - Lesser Intellect / 175
				{ 17, 13536 }, --Enchant Bracer - Lesser Strength / 165
				{ 18, 13501 }, --Enchant Bracer - Lesser Stamina / 155
				{ 19, 7859 }, --Enchant Bracer - Lesser Spirit / 145
				{ 20, 7779 }, --Enchant Bracer - Minor Agility / 115
				{ 21, 7782 }, --Enchant Bracer - Minor Strength / 115
				{ 22, 7766 }, --Enchant Bracer - Minor Spirit / 105
				{ 23, 7457 }, --Enchant Bracer - Minor Stamina / 100
				{ 24, 7428 }, --Enchant Bracer - Minor Deflect / 80
				{ 25, 7418 }, --Enchant Bracer - Minor Health / 70
			}
		},
	}
}

data["Engineering"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 22797 }, --Force Reactive Disk / 65
				{ 3, 12903 }, --Gnomish Harm Prevention Belt / 43
				{ 5, 8895 }, --Goblin Rocket Boots / 45
				{ 16, 19819 }, --Voice Amplification Modulator / 58
				{ 18, 12616 }, --Parachute Cloak / 45
				{ 20, 12905 }, --Gnomish Rocket Boots / 45
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 24357 }, --Bloodvine Lens / 65
				{ 2, 24356 }, --Bloodvine Goggles / 65
				{ 3, 19825 }, --Master Engineer / 58
				{ 4, 19794 }, --Spellpower Goggles Xtreme Plus / 54
				{ 5, 12622 }, --Green Lens / 49
				{ 6, 12758 }, --Goblin Rocket Helmet / 47
				{ 7, 12907 }, --Gnomish Mind Control Cap / 47
				{ 8, 12618 }, --Rose Colored Goggles / 46
				{ 9, 12617 }, --Deepdive Helmet / 46
				{ 10, 12607 }, --Catseye Ultra Goggles / 44
				{ 11, 12615 }, --Spellpower Goggles Xtreme / 43
				{ 12, 12897 }, --Gnomish Goggles / 42
				{ 13, 12594 }, --Fire Goggles / 41
				{ 14, 12717 }, --Goblin Mining Helmet / 41
				{ 15, 12718 }, --Goblin Construction Helmet / 41
				{ 16, 3966 }, --Craftsman / 37
				{ 17, 12587 }, --Bright-Eye Goggles / 35
				{ 18, 3956 }, --Green Tinted Goggles / 30
				{ 19, 3940 }, --Shadow Goggles / 24
				{ 20, 3934 }, --Flying Tiger Goggles / 20
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 19830 }, --Arcanite Dragonling / 60
				{ 2, 23082 }, --Ultra-Flash Shadow Reflector / 60
				{ 3, 23081 }, --Hyper-Radiant Flame Reflector / 58
				{ 4, 23486 }, --Dimensional Ripper - Everlook / 55
				{ 5, 23079 }, --Major Recombobulator / 55
				{ 6, 23078 }, --Goblin Jumper Cables XL / 53
				{ 7, 23077 }, --Gyrofreeze Ice Reflector / 52
				{ 8, 23489 }, --Ultrasafe Transporter: Gadgetzan / 52
				{ 9, 12624 }, --Mithril Mechanical Dragonling / 50
				{ 10, 12908 }, --Goblin Dragon Gun / 48
				{ 11, 12759 }, --Gnomish Death Ray / 48
				{ 12, 12906 }, --Gnomish Battle Chicken / 46
				{ 13, 12755 }, --Goblin Bomb Dispenser / 46
				{ 14, 12902 }, --Gnomish Net-o-Matic Projector / 42
				{ 15, 12899 }, --Gnomish Shrink Ray / 41
				{ 16, 3969 }, --Mechanical Dragonling / 40
				{ 17, 3971 }, --Gnomish Cloaking Device / 40
				{ 18, 9273 }, --Goblin Jumper Cables / 33
				{ 19, 3952 }, --Minor Recombobulator / 28
				{ 20, 9269 }, --Gnomish Universal Remote / 25
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 22793 }, --Biznicks 247x128 Accurascope / 60
				{ 2, 12620 }, --Sniper Scope / 48
				{ 3, 12597 }, --Deadly Scope / 42
				{ 4, 3979 }, --Accurate Scope / 36
				{ 5, 3978 }, --Standard Scope / 22
				{ 6, 3977 }, --Crude Scope / 12
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 22795 }, --Core Marksman Rifle / 65
				{ 2, 19833 }, --Flawless Arcanite Rifle / 61
				{ 3, 19796 }, --Dark Iron Rifle / 55
				{ 4, 19792 }, --Thorium Rifle / 52
				{ 5, 12614 }, --Mithril Heavy-bore Rifle / 44
				{ 6, 12595 }, --Mithril Blunderbuss / 41
				{ 7, 3954 }, --Moonsight Rifle / 29
				{ 8, 3949 }, --Silver-plated Shotgun / 26
				{ 9, 3939 }, --Lovingly Crafted Boomstick / 24
				{ 10, 3936 }, --Deadly Blunderbuss / 21
				{ 11, 3925 }, --Rough Boomstick / 10
			}
		},
		{
			name = ALIL["Projectile"].." - "..ALIL["Bullet"],
			[NORMAL_DIFF] = {
				{ 1, 19800 }, --Thorium Shells / 57
				{ 2, 12621 }, --Mithril Gyro-Shot / 49
				{ 3, 12596 }, --Hi-Impact Mithril Slugs / 42
				{ 4, 3947 }, --Crafted Solid Shot / 35
				{ 5, 3930 }, --Crafted Heavy Shot / 20
				{ 6, 3920 }, --Crafted Light Shot / 10
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 19815 }, --Delicate Arcanite Converter / 58
				{ 2, 19791 }, --Thorium Widget / 52
				{ 3, 19788 }, --Dense Blasting Powder / 50
				{ 4, 23071 }, --Truesilver Transformer / 50
				{ 5, 12599 }, --Mithril Casing / 43
				{ 6, 12591 }, --Unstable Trigger / 40
				{ 7, 19795 }, --Thorium Tube / 39
				{ 8, 12589 }, --Mithril Tube / 39
				{ 9, 12585 }, --Solid Blasting Powder / 35
				{ 10, 3961 }, --Gyrochronatom / 34
				{ 11, 3958 }, --Iron Strut / 32
				{ 12, 12584 }, --Gold Power Core / 30
				{ 13, 3953 }, --Bronze Framework / 29
				{ 14, 3945 }, --Heavy Blasting Powder / 25
				{ 15, 3942 }, --Whirring Bronze Gizmo / 25
				{ 16, 3938 }, --Bronze Tube / 21
				{ 17, 3973 }, --Silver Contact / 18
				{ 18, 3926 }, --Copper Modulator / 13
				{ 19, 3929 }, --Coarse Blasting Powder / 15
				{ 20, 3924 }, --Copper Tube / 10
				{ 21, 3922 }, --Handful of Copper Bolts / 8
				{ 22, 3918 }, --Rough Blasting Powder / 5
			}
		},
		{
			name = AL["Fireworks"],
			[NORMAL_DIFF] = {
				{ 16, 26443 }, --Cluster Launcher / 1
				{ 1, 26442 }, --Firework Launcher / 1
				{ 3, 26418 }, --Small Red Rocket / 1
				{ 4, 26417 }, --Small Green Rocket / 1
				{ 5, 26416 }, --Small Blue Rocket / 1
				{ 7, 26425 }, --Red Rocket Cluster / 1
				{ 8, 26424 }, --Green Rocket Cluster / 1
				{ 9, 26423 }, --Blue Rocket Cluster / 1
				{ 12, 23066 }, --Red Firework / 20
				{ 13, 23068 }, --Green Firework / 20
				{ 14, 23067 }, --Blue Firework / 20
				{ 18, 26422 }, --Large Red Rocket / 1
				{ 19, 26421 }, --Large Green Rocket / 1
				{ 20, 26420 }, --Large Blue Rocket / 1
				{ 22, 26428 }, --Large Red Rocket Cluster / 1
				{ 23, 26427 }, --Large Green Rocket Cluster / 1
				{ 24, 26426 }, --Large Blue Rocket Cluster / 1
				{ 27, 23507 }, --Snake Burst Firework / 50
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 19831 }, --Arcane Bomb / 60
				{ 2, 19799 }, --Dark Iron Bomb / 57
				{ 3, 19790 }, --Thorium Grenade / 55
				{ 4, 23070 }, --Dense Dynamite / 45
				{ 5, 12619 }, --Hi-Explosive Bomb / 47
				{ 6, 12754 }, --The Big One / 45
				{ 7, 3968 }, --Goblin Land Mine / 39
				{ 8, 12603 }, --Mithril Frag Bomb / 43
				{ 9, 12760 }, --Goblin Sapper Charge / 41
				{ 10, 23069 }, --Ez-Thro Dynamite II / 40
				{ 11, 3967 }, --Big Iron Bomb / 43
				{ 12, 8243 }, --Flash Bomb / 37
				{ 13, 3962 }, --Iron Grenade / 35
				{ 14, 12586 }, --Solid Dynamite / 35
				{ 15, 3955 }, --Explosive Sheep / 30
				{ 16, 3950 }, --Big Bronze Bomb / 33
				{ 17, 3946 }, --Heavy Dynamite / 30
				{ 18, 3941 }, --Small Bronze Bomb / 29
				{ 19, 8339 }, --Ez-Thro Dynamite / 25
				{ 20, 3937 }, --Large Copper Bomb / 26
				{ 21, 3931 }, --Coarse Dynamite / 20
				{ 22, 3923 }, --Rough Copper Bomb / 14
				{ 23, 3919 }, --Rough Dynamite / 10
			}
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 19793 }, --Lifelike Mechanical Toad / 53
				{ 2, 15633 }, --Lil / 41
				{ 3, 15628 }, --Pet Bombling / 41
				{ 4, 3928 }, --Mechanical Squirrel Box / 15
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 23080 }, --Powerful Seaforium Charge / 52
				{ 2, 3972 }, --Large Seaforium Charge / 40
				{ 3, 3933 }, --Small Seaforium Charge / 20
				{ 5, 22704 }, --Field Repair Bot 74A / 60
				{ 6, 15255 }, --Mechanical Repair Kit / 40
				{ 8, 19814 }, --Masterwork Target Dummy / 55
				{ 9, 3965 }, --Advanced Target Dummy / 37
				{ 10, 3932 }, --Target Dummy / 17
				{ 12, 28327 }, --Steam Tonk Controller / 55
				{ 13, 9271 }, --Aquadynamic Fish Attractor / 30
				{ 15, 12715 }, --Recipe: Goblin Rocket Fuel / 42
				{ 16, 3957 }, --Ice Deflector / 31
				{ 17, 3944 }, --Flame Deflector / 25
				{ 19, 23129 }, --World Enlarger / 50
				{ 20, 12590 }, --Gyromatic Micro-Adjustor / 35
				{ 21, 3959 }, --Discombobulator Ray / 32
				{ 22, 26011 }, --Tranquil Mechanical Yeti / 60
				{ 23, 23096 }, --Gnomish Alarm-O-Bot / 53
				{ 24, 19567 }, --Salt Shaker / 50
				{ 25, 21940 }, --SnowMaster 9000 / 38
				{ 26, 3963 }, --Compact Harvest Reaper Kit / 35
				{ 27, 3960 }, --Portable Bronze Mortar / 33
				{ 28, 6458 }, --Ornate Spyglass / 27
				{ 29, 8334 }, --Practice Lock / 20
				{ 30, 12895 }, --Plans: Inlaid Mithril Cylinder / 40
			}
		},
	}
}

data["Tailoring"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 28208 }, --Glacial Cloak / 80
				{ 2, 28210 }, --Gaea's Embrace / 70
				{ 3, 22870 }, --Cloak of Warding / 62
				{ 4, 18418 }, --Cindercloth Cloak / 55
				{ 5, 18420 }, --Brightcloth Cloak / 55
				{ 6, 18422 }, --Cloak of Fire / 55
				{ 7, 18409 }, --Runecloth Cloak / 53
				{ 8, 3862 }, --Icy Cloak / 40
				{ 9, 3861 }, --Long Silken Cloak / 37
				{ 10, 8789 }, --Crimson Silk Cloak / 36
				{ 11, 8786 }, --Azure Silk Cloak / 35
				{ 12, 3844 }, --Heavy Woolen Cloak / 21
				{ 13, 6521 }, --Pearl-clasped Cloak / 19
				{ 14, 2402 }, --Woolen Cape / 16
				{ 15, 2397 }, --Reinforced Linen Cape / 12
				{ 16, 2387 }, --Linen Cloak / 6
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, 28207 }, --Glacial Vest / 80
				{ 2, 28480 }, --Sylvan Vest / 70
				{ 3, 23666 }, --Flarecore Robe / 66
				{ 4, 24091 }, --Bloodvine Vest / 65
				{ 5, 18457 }, --Robe of the Archmage / 62
				{ 6, 18456 }, --Truefaith Vestments / 62
				{ 7, 18458 }, --Robe of the Void / 62
				{ 8, 22902 }, --Mooncloth Robe / 61
				{ 9, 18451 }, --Felcloth Robe / 61
				{ 10, 18446 }, --Wizardweave Robe / 60
				{ 11, 18447 }, --Mooncloth Vest / 60
				{ 12, 18436 }, --Robe of Winter Night / 57
				{ 13, 18416 }, --Ghostweave Vest / 55
				{ 14, 18414 }, --Brightcloth Robe / 54
				{ 15, 18408 }, --Cindercloth Vest / 52
				{ 16, 18407 }, --Runecloth Tunic / 52
				{ 17, 18406 }, --Runecloth Robe / 52
				{ 18, 18404 }, --Frostweave Robe / 51
				{ 19, 18403 }, --Frostweave Tunic / 51
				{ 20, 12077 }, --Simple Black Dress / 47
				{ 21, 12070 }, --Dreamweave Vest / 45
				{ 22, 12069 }, --Cindercloth Robe / 45
				{ 23, 12056 }, --Red Mageweave Vest / 43
				{ 24, 12055 }, --Shadoweave Robe / 43
				{ 25, 12050 }, --Black Mageweave Robe / 42
				{ 26, 12048 }, --Black Mageweave Vest / 41
				{ 27, 8802 }, --Crimson Silk Robe / 41
				{ 28, 8770 }, --Robe of Power / 38
				{ 29, 8791 }, --Crimson Silk Vest / 37
				{ 30, 12091 }, --White Wedding Dress / 35
				{ 101, 12093 }, --Tuxedo Jacket / 35
				{ 102, 8764 }, --Earthen Vest / 34
				{ 103, 8784 }, --Green Silk Armor / 33
				{ 104, 6692 }, --Robes of Arcana / 30
				{ 105, 3859 }, --Azure Silk Vest / 30
				{ 106, 6690 }, --Lesser Wizard's Robe / 27
				{ 107, 7643 }, --Greater Adept's Robe / 23
				{ 108, 8467 }, --White Woolen Dress / 22
				{ 109, 2403 }, --Gray Woolen Robe / 21
				{ 110, 7639 }, --Blue Overalls / 20
				{ 111, 2399 }, --Green Woolen Vest / 17
				{ 112, 2395 }, --Barbaric Linen Vest / 14
				{ 113, 7633 }, --Blue Linen Robe / 14
				{ 114, 7629 }, --Red Linen Vest / 12
				{ 115, 7630 }, --Blue Linen Vest / 12
				{ 116, 8465 }, --Simple Dress / 10
				{ 117, 7624 }, --White Linen Robe / 10
				{ 118, 2389 }, --Red Linen Robe / 10
				{ 119, 7623 }, --Brown Linen Robe / 10
				{ 120, 2385 }, --Brown Linen Vest / 8
				{ 121, 26407 }, --Festival Suit / 1
				{ 122, 26403 }, --Festival Dress / 1
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 24093 }, --Bloodvine Boots / 65
				{ 2, 24903 }, --Runed Stygian Boots / 63
				{ 3, 23664 }, --Argent Boots / 58
				{ 4, 18437 }, --Felcloth Boots / 57
				{ 5, 19435 }, --Mooncloth Boots / 56
				{ 6, 18423 }, --Runecloth Boots / 56
				{ 7, 12088 }, --Cindercloth Boots / 49
				{ 8, 12082 }, --Shadoweave Boots / 48
				{ 9, 12073 }, --Black Mageweave Boots / 46
				{ 10, 3860 }, --Boots of the Enchanter / 35
				{ 11, 3856 }, --Spider Silk Slippers / 28
				{ 12, 3855 }, --Spidersilk Boots / 25
				{ 13, 3847 }, --Red Woolen Boots / 20
				{ 14, 2401 }, --Woolen Boots / 19
				{ 15, 3845 }, --Soft-soled Linen Boots / 16
				{ 16, 2386 }, --Linen Boots / 13
				{ 17, 12045 }, --Simple Linen Boots / 9
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 28205 }, --Glacial Gloves / 80
				{ 2, 22869 }, --Mooncloth Gloves / 62
				{ 3, 22867 }, --Felcloth Gloves / 62
				{ 4, 20849 }, --Flarecore Gloves / 62
				{ 5, 22868 }, --Inferno Gloves / 62
				{ 6, 18454 }, --Gloves of Spell Mastery / 62
				{ 7, 18417 }, --Runecloth Gloves / 55
				{ 8, 18415 }, --Brightcloth Gloves / 54
				{ 9, 18413 }, --Ghostweave Gloves / 54
				{ 10, 18412 }, --Cindercloth Gloves / 54
				{ 11, 18411 }, --Frostweave Gloves / 53
				{ 12, 12071 }, --Shadoweave Gloves / 45
				{ 13, 12066 }, --Red Mageweave Gloves / 45
				{ 14, 12067 }, --Dreamweave Gloves / 45
				{ 15, 12053 }, --Black Mageweave Gloves / 43
				{ 16, 8804 }, --Crimson Silk Gloves / 42
				{ 17, 8782 }, --Truefaith Gloves / 30
				{ 18, 8780 }, --Hands of Darkness / 29
				{ 19, 3854 }, --Azure Silk Gloves / 29
				{ 20, 3852 }, --Gloves of Meditation / 26
				{ 21, 3868 }, --Phoenix Gloves / 25
				{ 22, 3843 }, --Heavy Woolen Gloves / 17
				{ 23, 3840 }, --Heavy Linen Gloves / 10
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 28481 }, --Sylvan Crown / 70
				{ 2, 18452 }, --Mooncloth Circlet / 62
				{ 3, 18450 }, --Wizardweave Turban / 61
				{ 4, 18444 }, --Runecloth Headband / 59
				{ 5, 18442 }, --Felcloth Hood / 58
				{ 6, 12092 }, --Dreamweave Circlet / 50
				{ 7, 12086 }, --Shadoweave Mask / 49
				{ 8, 12084 }, --Red Mageweave Headband / 48
				{ 9, 12081 }, --Admiral's Hat / 48
				{ 10, 12072 }, --Black Mageweave Headband / 46
				{ 11, 12059 }, --White Bandit Mask / 43
				{ 12, 3858 }, --Shadow Hood / 34
				{ 13, 3857 }, --Enchanter's Cowl / 33
				{ 14, 8762 }, --Silk Headband / 32
				{ 15, 8760 }, --Azure Silk Hood / 29
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 23667 }, --Flarecore Leggings / 70
				{ 2, 24092 }, --Bloodvine Leggings / 65
				{ 3, 24901 }, --Runed Stygian Leggings / 63
				{ 4, 18440 }, --Mooncloth Leggings / 58
				{ 5, 18439 }, --Brightcloth Pants / 58
				{ 6, 18441 }, --Ghostweave Pants / 58
				{ 7, 18438 }, --Runecloth Pants / 57
				{ 8, 18424 }, --Frostweave Pants / 56
				{ 9, 18434 }, --Cindercloth Pants / 56
				{ 10, 18419 }, --Felcloth Pants / 55
				{ 11, 18421 }, --Wizardweave Leggings / 55
				{ 12, 12060 }, --Red Mageweave Pants / 43
				{ 13, 12052 }, --Shadoweave Pants / 42
				{ 14, 12049 }, --Black Mageweave Leggings / 41
				{ 15, 8799 }, --Crimson Silk Pantaloons / 39
				{ 16, 12089 }, --Tuxedo Pants / 35
				{ 17, 8758 }, --Azure Silk Pants / 28
				{ 18, 3851 }, --Phoenix Pants / 25
				{ 19, 12047 }, --Colorful Kilt / 24
				{ 20, 3850 }, --Heavy Woolen Pants / 22
				{ 21, 12046 }, --Simple Kilt / 15
				{ 22, 3842 }, --Handstitched Linen Britches / 14
				{ 23, 3914 }, --Brown Linen Pants / 10
				{ 24, 12044 }, --Simple Linen Pants / 7
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Body"],
			[NORMAL_DIFF] = {
				{ 1, 12085 }, --Tuxedo Shirt / 1 / 245
				{ 2, 12080 }, --Pink Mageweave Shirt / 47 / 240
				{ 3, 12075 }, --Lavender Mageweave Shirt / 46 / 235
				{ 4, 12064 }, --Orange Martial Shirt / 40 / 225
				{ 5, 12061 }, --Orange Mageweave Shirt / 43 / 220
				{ 6, 3873 }, --Black Swashbuckler's Shirt / 40 / 210
				{ 7, 21945 }, --Green Holiday Shirt / 40 / 200
				{ 8, 3872 }, --Rich Purple Silk Shirt / 37 / 195
				{ 9, 8489 }, --Red Swashbuckler's Shirt / 35 / 185
				{ 10, 3871 }, --Formal White Shirt / 34 / 180
				{ 11, 8483 }, --White Swashbuckler's Shirt / 32 / 170
				{ 12, 3870 }, --Dark Silk Shirt / 31 / 165
				{ 13, 7893 }, --Stylish Green Shirt / 25 / 145
				{ 14, 3869 }, --Bright Yellow Shirt / 27 / 145
				{ 15, 7892 }, --Stylish Blue Shirt / 25 / 145
				{ 16, 3866 }, --Stylish Red Shirt / 22 / 135
				{ 17, 2406 }, --Gray Woolen Shirt / 20 / 110
				{ 18, 2396 }, --Green Linen Shirt / 14 / 95
				{ 19, 2394 }, --Blue Linen Shirt / 10 / 65
				{ 20, 2392 }, --Red Linen Shirt / 10 / 65
				{ 21, 2393 }, --White Linen Shirt / 7 / 35
				{ 22, 3915 }, --Brown Linen Shirt / 7 / 35
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 28482 }, --Sylvan Shoulders / 70 / 315
				{ 2, 23663 }, --Mantle of the Timbermaw / 64 / 315
				{ 3, 23665 }, --Argent Shoulders / 64 / 315
				{ 4, 18453 }, --Felcloth Shoulders / 62 / 315
				{ 5, 20848 }, --Flarecore Mantle / 61 / 315
				{ 6, 18449 }, --Runecloth Shoulders / 61 / 315
				{ 7, 18448 }, --Mooncloth Shoulders / 61 / 315
				{ 8, 12078 }, --Red Mageweave Shoulders / 47 / 250
				{ 9, 12076 }, --Shadoweave Shoulders / 47 / 250
				{ 10, 12074 }, --Black Mageweave Shoulders / 46 / 245
				{ 11, 8793 }, --Crimson Silk Shoulders / 38 / 210
				{ 12, 8795 }, --Azure Shoulders / 38 / 210
				{ 13, 8774 }, --Green Silken Shoulders / 36 / 200
				{ 14, 3849 }, --Reinforced Woolen Shoulders / 24 / 145
				{ 15, 3848 }, --Double-stitched Woolen Shoulders / 22 / 135
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 24902 }, --Runed Stygian Belt / 63 / 315
				{ 2, 22866 }, --Belt of the Archmage / 62 / 315
				{ 3, 23662 }, --Wisdom of the Timbermaw / 58 / 305
				{ 4, 18410 }, --Ghostweave Belt / 53 / 280
				{ 5, 18402 }, --Runecloth Belt / 51 / 270
				{ 6, 3864 }, --Star Belt / 40 / 220
				{ 7, 8797 }, --Earthen Silk Belt / 39 / 215
				{ 8, 3863 }, --Spider Belt / 36 / 200
				{ 9, 8772 }, --Crimson Silk Belt / 35 / 195
				{ 10, 8766 }, --Azure Silk Belt / 35 / 195
				{ 11, 8776 }, --Linen Belt / 9 / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 28209 }, --Glacial Wrists / 80 / 315
				{ 2, 22759 }, --Flarecore Wraps / 64 / 320
				{ 3, 3841 }, --Green Linen Bracers / 12 / 85
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 18455 }, --Bottomless Bag / 62 / 315
				{ 2, 18445 }, --Mooncloth Bag / 60 / 315
				{ 3, 18405 }, --Runecloth Bag / 52 / 275
				{ 4, 12079 }, --Red Mageweave Bag / 35 / 250
				{ 5, 12065 }, --Mageweave Bag / 35 / 240
				{ 6, 6695 }, --Black Silk Pack / 25 / 205
				{ 7, 6693 }, --Green Silk Pack / 25 / 195
				{ 8, 3813 }, --Small Silk Pack / 25 / 170
				{ 9, 6688 }, --Red Woolen Bag / 15 / 140
				{ 10, 3758 }, --Green Woolen Bag / 15 / 120
				{ 11, 3757 }, --Woolen Bag / 15 / 105
				{ 12, 6686 }, --Red Linen Bag / 5 / 95
				{ 13, 3755 }, --Linen Bag / 5 / 70
				{ 16, 27725 }, --Satchel of Cenarius / 65 / 315
				{ 17, 27724 }, --Cenarion Herb Bag / 55 / 290
				{ 19, 27660 }, --Big Bag of Enchantment / 65 / 315
				{ 20, 27659 }, --Enchanted Runecloth Bag / 55 / 290
				{ 21, 27658 }, --Enchanted Mageweave Pouch / 45 / 240
				{ 23, 26087 }, --Core Felcloth Bag / 60 / 315
				{ 24, 26086 }, --Felcloth Bag / 57 / 300
				{ 25, 26085 }, --Soul Pouch / 52 / 275
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 18560 }, --Mooncloth / 55 / 290
				{ 2, 18401 }, --Bolt of Runecloth / 55 / 255
				{ 3, 3865 }, --Bolt of Mageweave / 45 / 180
				{ 4, 3839 }, --Bolt of Silk Cloth / 35 / 135
				{ 5, 2964 }, --Bolt of Woolen Cloth / 25 / 90
				{ 6, 2963 }, --Bolt of Linen Cloth / 10 / 25
			}
		},
	}
}

data["Leatherworking"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
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

data["Mining"] = {
	name = ALIL["Mining"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1, 22967 }, --Smelt Elementium / 310
				{ 2, 16153 }, --Smelt Thorium / 250
				{ 3, 10098 }, --Smelt Truesilver / 230
				{ 4, 14891 }, --Smelt Dark Iron / 230
				{ 5, 10097 }, --Smelt Mithril / 175
				{ 6, 3308 }, --Smelt Gold / 170
				{ 7, 3569 }, --Smelt Steel / 165
				{ 8, 3307 }, --Smelt Iron / 130
				{ 9, 2658 }, --Smelt Silver / 100
				{ 10, 2659 }, --Smelt Bronze / 65
				{ 11, 3304 }, --Smelt Tin / 50
				{ 12, 2657 }, --Smelt Copper / 25
			}
		},
	}
}

data["Herbalism"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
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

data["Cooking"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = ALIL["Stamina"],
			[NORMAL_DIFF] = {
				{ 1, 25659 }, --Dirge / 325
				{ 2, 18246 }, --Mightfish Steak / 315
				{ 3, 18239 }, --Cooked Glossy Mightfish / 265
			},
		},
		{
			name = ALIL["Intellect"],
			[NORMAL_DIFF] = {
				{ 1, 22761 }, --Runn Tum Tuber Surprise / 315
			},
		},
		{
			name = ALIL["Agility"],
			[NORMAL_DIFF] = {
				{ 1, 18240 }, --Grilled Squid / 280
			},
		},
		{
			name = ALIL["Strength"],
			[NORMAL_DIFF] = {
				{ 1, 24801 }, --Smoked Desert Dumplings / 325
			},
		},
		{
			name = ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 18242 }, --Hot Smoked Bass / 280
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 15933 }, --Monster Omelet / 265
				{ 2, 22480 }, --Tender Wolf Steak / 265
				{ 3, 15915 }, --Spiced Chili Crab / 265
				{ 4, 15910 }, --Heavy Kodo Stew / 240
				{ 5, 21175 }, --Spider Sausage / 240
				{ 6, 15855 }, --Roast Raptor / 215
				{ 7, 15863 }, --Carrion Surprise / 215
				{ 8, 4094 }, --Barbecued Buzzard Wing / 215
				{ 9, 7213 }, --Giant Clam Scorcho / 215
				{ 10, 15861 }, --Jungle Stew / 215
				{ 11, 15856 }, --Hot Wolf Ribs / 215
				{ 12, 3400 }, --Soothing Turtle Bisque / 215
				{ 13, 15865 }, --Mystery Stew / 215
				{ 14, 3399 }, --Tasty Lion Steak / 190
				{ 15, 3398 }, --Hot Lion Chops / 175
				{ 16, 3376 }, --Curiously Tasty Omelet / 170
				{ 17, 15853 }, --Lean Wolf Steak / 165
				{ 18, 6500 }, --Goblin Deviled Clams / 165
				{ 19, 24418 }, --Heavy Crocolisk Stew / 160
				{ 20, 3373 }, --Crocolisk Gumbo / 160
				{ 21, 3397 }, --Big Bear Steak / 150
				{ 22, 3377 }, --Gooey Spider Cake / 150
				{ 23, 6419 }, --Lean Venison / 150
				{ 24, 6418 }, --Crispy Lizard Tail / 140
				{ 25, 2549 }, --Seasoned Wolf Kabob / 140
				{ 26, 2547 }, --Redridge Goulash / 135
				{ 27, 3372 }, --Murloc Fin Soup / 130
				{ 28, 3370 }, --Crocolisk Steak / 120
				{ 29, 2546 }, --Dry Pork Ribs / 120
				{ 30, 2544 }, --Crab Cake / 115
				{ 101, 3371 }, --Blood Sausage / 100
				{ 102, 6416 }, --Strider Stew / 90
				{ 103, 2542 }, --Goretusk Liver Pie / 90
				{ 104, 2541 }, --Coyote Steak / 90
				{ 105, 6499 }, --Boiled Clams / 90
				{ 106, 6415 }, --Fillet of Frenzy / 90
				{ 107, 21144 }, --Egg Nog / 75
				{ 108, 6414 }, --Roasted Kodo Meat / 75
				{ 109, 2795 }, --Beer Basted Boar Ribs / 60
				{ 110, 2539 }, --Spiced Wolf Meat / 50
				{ 111, 6412 }, --Kaldorei Spider Kabob / 50
				{ 112, 15935 }, --Crispy Bat Wing / 45
				{ 113, 8604 }, --Herb Baked Egg / 45
				{ 114, 21143 }, --Gingerbread Cookie / 45
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18243 }, --Nightfin Soup / 290
				{ 2, 25954 }, --Sagefish Delight / 215
				{ 3, 25704 }, --Smoked Sagefish / 120
			},
		},
		{
			name = ALIL["Health Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18244 }, --Poached Sunscale Salmon / 290
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1, 18245 }, --Lobster Stew / 315
				{ 2, 18238 }, --Spotted Yellowtail / 315
				{ 3, 18247 }, --Baked Salmon / 265
				{ 4, 6501 }, --Clam Chowder / 265
				{ 5, 18241 }, --Filet of Redgill / 265
				{ 6, 20916 }, --Mithril Headed Trout / 215
				{ 7, 13028 }, --Goldthorn Tea / 215
				{ 8, 7828 }, --Rockscale Cod / 190
				{ 9, 7755 }, --Bristle Whisker Catfish / 140
				{ 10, 20626 }, --Undermine Clam Chowder / 130
				{ 11, 2548 }, --Succulent Pork Ribs / 130
				{ 12, 6417 }, --Dig Rat Stew / 130
				{ 13, 2545 }, --Cooked Crab Claw / 125
				{ 14, 2543 }, --Westfall Stew / 115
				{ 15, 7827 }, --Rainbow Fin Albacore / 90
				{ 16, 7754 }, --Loch Frenzy Delight / 90
				{ 17, 7753 }, --Longjaw Mud Snapper / 90
				{ 18, 8607 }, --Smoked Bear Meat / 80
				{ 19, 6413 }, --Scorpid Surprise / 60
				{ 20, 7752 }, --Slitherskin Mackerel / 45
				{ 21, 2538 }, --Charred Wolf Meat / 45
				{ 22, 7751 }, --Brilliant Smallfish / 45
				{ 23, 2540 }, --Roasted Boar Meat / 45
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 15906 }, --Dragonbreath Chili / 240
				{ 2, 8238 }, --Savory Deviate Delight / 125
				{ 3, 9513 }, --Thistle Tea / 100
			},
		},
	}
}

data["FirstAid"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1, 18630 }, --Heavy Runecloth Bandage / 290
				{ 2, 18629 }, --Runecloth Bandage / 260
				{ 3, 10841 }, --Heavy Mageweave Bandage / 240
				{ 4, 10840 }, --Mageweave Bandage / 210
				{ 5, 7929 }, --Heavy Silk Bandage / 180
				{ 6, 7928 }, --Silk Bandage / 150
				{ 7, 3278 }, --Heavy Wool Bandage / 115
				{ 8, 3277 }, --Wool Bandage / 80
				{ 9, 3276 }, --Heavy Linen Bandage / 50
				{ 10, 3275 }, --Linen Bandage / 30
				{ 16, 23787 }, --Powerful Anti-Venom / 300
				{ 17, 7935 }, --Strong Anti-Venom / 130
				{ 18, 7934 }, --Anti-Venom / 80
			}
		},
	}
}

data["RoguePoisons"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = ALIL["Poisons"],
			[NORMAL_DIFF] = {
				{ 1, 11343 }, -- Instant Poison VI
				{ 2, 11342 }, -- Instant Poison V
				{ 3, 11341 }, -- Instant Poison IV
				{ 4, 8691  }, -- Instant Poison III
				{ 5, 8687  }, -- Instant Poison II
				{ 6, 8681  }, -- Instant Poison
				{ 8, 13230 },  -- Wound Poison IV
				{ 9, 13229 },  -- Wound Poison III
				{ 10, 13228 }, -- Wound Poison II
				{ 11, 13220 }, -- Wound Poison
				{ 13, 3420  }, -- Crippling Poison
				{ 17, 25347 }, -- Deadly Poison V
				{ 18, 11358 }, -- Deadly Poison IV
				{ 19, 11357 }, -- Deadly Poison III
				{ 20, 2837  }, -- Deadly Poison II
				{ 21, 2835  }, -- Deadly Poison
				{ 24, 11400 }, -- Mind-numbing Poison III
				{ 25, 8694  }, -- Mind-numbing Poison II
				{ 26, 5763  }, -- Mind-numbing Poison
				{ 28, 6510  }, -- Blinding Powder
			}
		},
	}
}