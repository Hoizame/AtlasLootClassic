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
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(TRADE_SKILLS, ATLASLOOT_DUNGEON_COLOR)
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
				{ 12, 4508 }, --Discolored Healing Potion
				{ 13, 11458 }, --Wildvine Potion
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
				{ 2, 17575 }, --Greater Frost Protection Potion
				{ 3, 17576 }, --Greater Nature Protection Potion
				{ 4, 17577 }, --Greater Arcane Protection Potion
				{ 5, 17578 }, --Greater Shadow Protection Potion
				{ 7, 11453 }, --Magic Resistance Potion
				{ 8, 3174 }, --Elixir of Poison Resistance
				{ 16, 7257 }, --Fire Protection Potion
				{ 17, 7258 }, --Frost Protection Potion
				{ 18, 7259 }, --Nature Protection Potion
				{ 19, 7255 }, --Holy Protection Potion
				{ 20, 7256 }, --Shadow Protection Potion
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
				{ 1, 3451 }, --Mighty Troll
				{ 2, 24368 }, --Major Troll
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
				{ 23, 17573 }, --Greater Arcane Elixir
				{ 24, 11461 }, --Arcane Elixir
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
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 17632 }, --Alchemist's Stone
				{ 3, 11473 }, --Ghost Dye
				{ 5, 24266 }, --Gurubashi Mojo Madness
				{ 7, 11466 }, --Gift of Arthas
				{ 8, 3449 }, --Shadow Oil
				{ 9, 3454 }, --Frost Oil
				{ 10, 7837 }, --Fire Oil
				{ 16, 11459 }, --Philosophers' Stone
				{ 18, 11456 }, --Goblin Rocket Fuel
				{ 23, 7836 }, --Blackmouth Oil
				{ 24, 11451 }, --Oil of Immolation
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
			name = ALIL["Weapons"].." - "..ALIL["Daggers"],
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
			name = ALIL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, 20897 }, --Dark Iron Destroyer / 65
				{ 2, 16991 }, --Annihilator / 63
				{ 3, 16970 }, --Dawn / 55
				{ 4, 16969 }, --Ornate Thorium Handaxe / 55
				{ 5, 9995 }, --Blue Glittering Axe / 44
				{ 6, 9993 }, --Heavy Mithril Axe / 42
				{ 7, 21913 }, --Edge of Winter / 38
				{ 8, 2741 }, --Bronze Axe / 23
				{ 9, 3294 }, --Thick War Axe / 17
				{ 10, 2738 }, --Copper Axe / 9
				{ 16, 23653 }, --Nightfall / 70
				{ 17, 16994 }, --Arcanite Reaper / 63
				{ 18, 15294 }, --Dark Iron Sunderer / 57
				{ 19, 16971 }, --Huge Thorium Battleaxe / 56
				{ 20, 3500 }, --Shadow Crescent Axe / 40
				{ 21, 3498 }, --Massive Iron Axe / 37
				{ 22, 9987 }, --Bronze Battle Axe / 27
				{ 23, 3293 }, --Copper Battle Axe / 13
			}
		},
		{
			name = ALIL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, 23650 }, --Ebon Hand / 70
				{ 2, 16993 }, --Masterwork Stormhammer / 63
				{ 3, 27830 }, --Persuader / 63
				{ 4, 16984 }, --Volcanic Hammer / 58
				{ 5, 16983 }, --Serenity / 57
				{ 6, 10009 }, --Runed Mithril Hammer / 49
				{ 7, 10003 }, --The Shatterer / 47
				{ 8, 10001 }, --Big Black Mace / 46
				{ 9, 3297 }, --Mighty Iron Hammer / 30
				{ 10, 6518 }, --Iridescent Hammer / 28
				{ 11, 3296 }, --Heavy Bronze Mace / 25
				{ 12, 2740 }, --Bronze Mace / 22
				{ 13, 2737 }, --Copper Mace / 9
				{ 16, 21161 }, --Sulfuron Hammer / 67
				{ 17, 16988 }, --Hammer of the Titans / 63
				{ 18, 16973 }, --Enchanted Battlehammer / 56
				{ 19, 15292 }, --Dark Iron Pulverizer / 55
				{ 20, 3495 }, --Golden Iron Destroyer / 34
				{ 21, 3494 }, --Solid Iron Maul / 31
				{ 22, 9985 }, --Bronze Warhammer / 25
				{ 23, 7408 }, --Heavy Copper Maul / 16
			}
		},
		{
			name = ALIL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, 23652 }, --Blackguard / 70
				{ 2, 20890 }, --Dark Iron Reaver / 65
				{ 3, 27832 }, --Sageblade / 64
				{ 4, 16992 }, --Frostguard / 63
				{ 5, 16978 }, --Blazing Rapier / 56
				{ 6, 10007 }, --Phantom Blade / 49
				{ 7, 10005 }, --Dazzling Mithril Rapier / 48
				{ 8, 9997 }, --Wicked Mithril Blade / 45
				{ 9, 3493 }, --Jade Serpentblade / 35
				{ 10, 3492 }, --Hardened Iron Shortsword / 32
				{ 11, 2742 }, --Bronze Shortsword / 24
				{ 12, 2739 }, --Copper Shortsword / 9
				{ 16, 16990 }, --Arcanite Champion / 63
				{ 17, 16985 }, --Corruption / 58
				{ 18, 10015 }, --Truesilver Champion / 52
				{ 19, 3497 }, --Frost Tiger Blade / 40
				{ 20, 3496 }, --Moonsteel Broadsword / 36
				{ 21, 9986 }, --Bronze Greatsword / 26
				{ 22, 3292 }, --Heavy Copper Broadsword / 19
				{ 23, 9983 }, --Copper Claymore / 11
			}
		},
		{
			name = ALIL["Weapons"].." - "..ALIL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, 23639 }, --Blackfury / 66
				{ 2, 10011 }, --Blight / 50
			}
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Chest"],
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
			name = ALIL["Armor"].." - "..ALIL["Feet"],
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
			name = ALIL["Armor"].." - "..ALIL["Hand"],
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
			name = ALIL["Armor"].." - "..ALIL["Head"],
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
			name = ALIL["Armor"].." - "..ALIL["Legs"],
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
			name = ALIL["Armor"].." - "..ALIL["Shoulder"],
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
			name = ALIL["Armor"].." - "..ALIL["Waist"],
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
			name = ALIL["Armor"].." - "..ALIL["Wrist"],
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