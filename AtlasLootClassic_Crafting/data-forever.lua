-- If we are on a SoD realm, ignore everything in this file
if C_Seasons and C_Seasons.GetActiveSeason and C_Seasons.GetActiveSeason() == 2 then return end

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

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

data["Alchemy"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ALCHEMY_LINK,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 1293559 }, -- Flask of Natural Accuracy / 60
				{ 2, 1293560 }, -- Flask of Natural Aggression / 60
				{ 3, 1293561 }, -- Flask of Natural Precision / 60
				{ 4, 1293562 }, -- Flask of Natural Swiftness / 60
				{ 5, 17638 }, -- Flask of Chromatic Resistance / 60
				{ 6, 17636 }, -- Flask of Distilled Wisdom / 60
				{ 7, 17634 }, -- Flask of Petrification / 60
				{ 8, 17637 }, -- Flask of Supreme Power / 60
				{ 9, 17635 }, -- Flask of the Titans / 60
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 22430 }, -- Refined Scale of Onyxia / 60
				{ 2, 1317279 }, -- Legionite Bar / 60
				{ 3, 17187 }, -- Arcanite Bar / 55
				{ 4, 17562 }, -- Essence of Air / 55
				{ 5, 17560 }, -- Essence of Earth / 55
				{ 6, 17565 }, -- Essence of Earth / 55
				{ 7, 17559 }, -- Essence of Fire / 55
				{ 8, 17564 }, -- Essence of Undeath / 55
				{ 9, 17561 }, -- Essence of Water / 55
				{ 10, 17563 }, -- Essence of Water / 55
				{ 11, 17566 }, -- Living Essence / 55
				{ 12, 11480 }, -- Truesilver Bar / 50
				{ 13, 11479 }, -- Gold Bar / 30
				{ 14, 25146 }, -- Elemental Fire / 25
			},
		},
		{
			name = AL["Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1, 24366 }, -- Greater Dreamless Sleep Potion / 60
				{ 2, 17580 }, -- Major Mana Potion / 59
				{ 3, 1251745 }, -- Superior Mender's Potion / 55
				{ 4, 1250782 }, -- Greater Cleric's Elixir / 55
				{ 5, 1250790 }, -- Greater Mageblood Elixir / 55
				{ 6, 1251742 }, -- Lesser Mender's Potion / 55
				{ 7, 1251741 }, -- Minor Mender's Potion / 55
				{ 8, 17553 }, -- Superior Mana Potion / 51
				{ 9, 24365 }, -- Mageblood Elixir / 50
				{ 10, 15833 }, -- Dreamless Sleep Potion / 45
				{ 11, 1250781 }, -- Cleric's Elixir / 45
				{ 12, 11448 }, -- Greater Mana Potion / 41
				{ 13, 3452 }, -- Mana Potion / 32
				{ 14, 1251747 }, -- Major Mender's Potion / 25
				{ 15, 1251744 }, -- Greater Mender's Potion / 25
				{ 16, 1250780 }, -- Lesser Cleric's Elixir / 25
				{ 17, 1250789 }, -- Lesser Mageblood Elixir / 25
				{ 18, 3173 }, -- Lesser Mana Potion / 24
				{ 19, 2331 }, -- Minor Mana Potion / 15
				{ 20, 1251743 }, -- Mender's Potion / 5
				{ 21, 1250779 }, -- Minor Cleric's Elixir / 5
				{ 22, 1250788 }, -- Minor Mageblood Elixir / 5
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17577 }, -- Greater Arcane Protection Potion / 58
				{ 2, 17574 }, -- Greater Fire Protection Potion / 58
				{ 3, 17575 }, -- Greater Frost Protection Potion / 58
				{ 4, 17579 }, -- Greater Holy Protection Potion / 58
				{ 5, 17576 }, -- Greater Nature Protection Potion / 58
				{ 6, 17578 }, -- Greater Shadow Protection Potion / 58
				{ 7, 1251748 }, -- Potion of Venomous Blood / 55
				{ 8, 1250778 }, -- Elixir of the Phalanx / 55
				{ 9, 3174 }, -- Potion of Poison Cleansing / 55
				{ 10, 11453 }, -- Magic Resistance Potion / 42
				{ 11, 7259 }, -- Nature Protection Potion / 38
				{ 12, 7258 }, -- Frost Protection Potion / 38
				{ 13, 7257 }, -- Fire Protection Potion / 33
				{ 14, 7256 }, -- Shadow Protection Potion / 27
				{ 15, 3172 }, -- Minor Magic Resistance Potion / 22
				{ 16, 7255 }, -- Holy Protection Potion / 20
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 1231583 }, -- Major Discolored Healing Potion / 70
				{ 2, 24367 }, -- Living Action Potion / 57
				{ 3, 17572 }, -- Purification Potion / 57
				{ 4, 17570 }, -- Greater Stoneshield Potion / 56
				{ 5, 1251740 }, -- Major Frenzy Potion / 55
				{ 6, 1251753 }, -- Potion of Beast Slaying / 55
				{ 7, 1251752 }, -- Potion of Elemental Purging / 55
				{ 8, 1251739 }, -- Superior Frenzy Potion / 55
				{ 9, 1251733 }, -- Superior Spellblasting Potion / 55
				{ 10, 1251732 }, -- Greater Spellblasting Potion / 55
				{ 11, 1251737 }, -- Frenzy Potion / 55
				{ 12, 17552 }, -- Mighty Rage Potion / 51
				{ 13, 3175 }, -- Limited Invulnerability Potion / 50
				{ 14, 11464 }, -- Invisibility Potion / 47
				{ 15, 1244421 }, -- Distilled Firewater / 45
				{ 16, 1251751 }, -- Dragonfire Potion / 45
				{ 17, 1244648 }, -- Superior Discolored Healing Potion / 45
				{ 18, 1250776 }, -- Draught of Predatory Senses / 45
				{ 19, 1251738 }, -- Greater Frenzy Potion / 45
				{ 20, 1251736 }, -- Lesser Frenzy Potion / 45
				{ 21, 1251729 }, -- Minor Spellblasting Potion / 45
				{ 22, 4942 }, -- Lesser Stoneshield Potion / 43
				{ 23, 11452 }, -- Restorative Potion / 42
				{ 24, 6618 }, -- Great Rage Potion / 35
				{ 25, 11447 }, -- Draught of Water Walking / 34
				{ 26, 3448 }, -- Lesser Invisibility Potion / 33
				{ 27, 1244647 }, -- Greater Discolored Healing Potion / 31
				{ 28, 6624 }, -- Free Action Potion / 30
				{ 29, 1251750 }, -- Disorienting Smog Potion / 25
				{ 30, 1251735 }, -- Minor Frenzy Potion / 25
				{ 101, 1244646 }, -- Discolored Healing Potion / 22
				{ 102, 7841 }, -- Swim Speed Potion / 20
				{ 103, 2335 }, -- Swiftness Potion / 15
				{ 104, 6617 }, -- Rage Potion / 14
				{ 105, 1244645 }, -- Lesser Discolored Healing Potion / 13
				{ 106, 1251734 }, -- Major Spellblasting Potion / 5
				{ 107, 1251749 }, -- Caustic Smog Potion / 5
				{ 108, 1251731 }, -- Spellblasting Potion / 5
				{ 109, 1251730 }, -- Lesser Spellblasting Potion / 5
			},
		},
		{
			name = AL["Stat Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 24368 }, -- Major Troll's Blood Elixir / 58
				{ 2, 17573 }, -- Greater Arcane Elixir / 57
				{ 3, 1250800 }, -- Elixir of the Grizzly / 55
				{ 4, 1250785 }, -- Elixir of Wicked Regeneration / 55
				{ 5, 1250786 }, -- Elixir of the Owl / 55
				{ 6, 1250787 }, -- Elixir of Sages / 55
				{ 7, 1250797 }, -- Elixir of the Whale / 55
				{ 8, 1250784 }, -- Elixir of Greater Fortitude / 55
				{ 9, 1250796 }, -- Elixir of Greater Spirit / 55
				{ 10, 17554 }, -- Elixir of Greater Defense / 53
				{ 11, 11472 }, -- Elixir of Greater Strength / 48
				{ 12, 11467 }, -- Elixir of Greater Agility / 48
				{ 13, 11461 }, -- Arcane Elixir / 47
				{ 14, 11465 }, -- Elixir of Greater Intellect / 47
				{ 15, 1250783 }, -- Elixir of Fortitude / 45
				{ 16, 1250798 }, -- Elixir of Strength / 45
				{ 17, 1250802 }, -- Elixir of Intellect / 45
				{ 18, 1250795 }, -- Elixir of Spirit / 45
				{ 19, 11450 }, -- Elixir of Defense / 39
				{ 20, 11449 }, -- Elixir of Agility / 37
				{ 21, 3451 }, -- Troll's Blood Elixir / 36
				{ 22, 3188 }, -- Elixir of Ogre Strength / 30
				{ 23, 2333 }, -- Elixir of Lesser Agility / 28
				{ 24, 3177 }, -- Elixir of Lesser Defense / 26
				{ 25, 3176 }, -- Lesser Troll's Blood Elixir / 25
				{ 26, 1250801 }, -- Elixir of Lesser Intellect / 25
				{ 27, 1250794 }, -- Elixir of Lesser Spirit / 25
				{ 28, 3171 }, -- Elixir of Wisdom / 20
				{ 29, 3230 }, -- Elixir of Minor Agility / 12
				{ 30, 3170 }, -- Minor Troll's Blood Elixir / 8
				{ 101, 7183 }, -- Elixir of Minor Defense / 5
				{ 102, 2329 }, -- Elixir of Minor Strength / 5
				{ 103, 1250793 }, -- Elixir of Minor Spirit / 5
				{ 104, 1245250 }, -- Elixir of Minor Force / 5
			},
		},
		{
			name = AL["Special Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 17571 }, -- Elixir of the Mongoose / 56
				{ 2, 17557 }, -- Elixir of Brute Force / 55
				{ 3, 1250792 }, -- Elixir of Nature Power / 55
				{ 4, 1250777 }, -- Elixir of Cunning / 55
				{ 5, 1250799 }, -- Elixir of Ferocity / 55
				{ 6, 26277 }, -- Elixir of Holy Power / 50
				{ 7, 11476 }, -- Elixir of Shadow Power / 50
				{ 8, 11477 }, -- Potion of Demon Slaying / 50
				{ 9, 17555 }, -- Elixir of the Sages / 44
				{ 10, 21923 }, -- Elixir of Frost Power / 38
				{ 11, 439960 }, -- Lesser Arcane Elixir / 38
				{ 12, 3450 }, -- Elixir of Lesser Fortitude / 35
				{ 13, 7845 }, -- Elixir of Fire Power / 28
				{ 14, 1250791 }, -- Lesser Arcane Elixir / 25
				{ 15, 426607 }, -- Elixir of Coalesced Regret / 25
				{ 16, 8240 }, -- Elixir of Giant Growth / 18
				{ 17, 2334 }, -- Elixir of Minor Fortitude / 12
				{ 18, 1245246 }, -- Minor Arcane Elixir / 5
			},
		},
		{
			name = AL["Misc Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 11478 }, -- Draught of Detect Demon / 50
				{ 2, 11468 }, -- Draught of Dream Vision / 48
				{ 3, 11460 }, -- Draught of Detect Undead / 46
				{ 4, 22808 }, -- Draught of Greater Water Breathing / 45
				{ 5, 12609 }, -- Catseye Draught / 40
				{ 6, 3453 }, -- Draught of Detect Lesser Invisibility / 39
				{ 7, 7179 }, -- Draught of Water Breathing / 18
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 24266 }, -- Gurubashi Mojo Madness / 315
				{ 2, 1263078 }, -- Alchemy Laboratory / 60
				{ 3, 1249632 }, -- Viridian Dye / 60
				{ 4, 17632 }, -- Alchemists' Stone / 50
				{ 5, 17551 }, -- Stonescale Oil / 50
				{ 6, 11473 }, -- Ghost Dye / 49
				{ 7, 11466 }, -- Gift of Arthas / 48
				{ 8, 11459 }, -- Philosopher's Stone / 45
				{ 9, 1249631 }, -- Magenta Dye / 45
				{ 10, 11456 }, -- Goblin Rocket Fuel / 42
				{ 11, 11451 }, -- Oil of Immolation / 41
				{ 12, 3454 }, -- Frost Oil / 40
				{ 13, 3449 }, -- Shadow Oil / 34
				{ 14, 1263005 }, -- Fermenter / 28
				{ 15, 7837 }, -- Fire Oil / 25
				{ 16, 1249630 }, -- Cerulean Dye / 25
				{ 17, 1249633 }, -- Sulfuric Acid / 25
				{ 18, 7836 }, -- Blackmouth Oil / 15
				{ 19, 1230564 }, -- Mana Well / 4
			},
		},
	},
}

data["Blacksmithing"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.BLACKSMITHING_LINK,
	items = {
		{
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1, 23638 }, -- Black Amnesty / 66
				{ 2, 16995 }, -- Heartseeker / 63
				{ 3, 1252365 }, -- Bold Dirk / 59
				{ 4, 10013 }, -- Ebon Shiv / 51
				{ 5, 1252360 }, -- Mithril Stiletto / 47
				{ 6, 15973 }, -- Searing Golden Blade / 39
				{ 7, 15972 }, -- Glinting Steel Dagger / 36
				{ 8, 3295 }, -- Deadly Bronze Poniard / 25
				{ 9, 6517 }, -- Pearl-handled Dagger / 23
				{ 10, 3491 }, -- Big Bronze Knife / 20
				{ 11, 8880 }, -- Copper Dagger / 11
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 20897 }, -- Dark Iron Destroyer / 65
				{ 3, 16991 }, -- Annihilator / 63
				{ 4, 16970 }, -- Dawn's Edge / 55
				{ 5, 16969 }, -- Ornate Thorium Handaxe / 55
				{ 6, 9995 }, -- Blue Glittering Axe / 44
				{ 7, 9993 }, -- Heavy Mithril Axe / 42
				{ 8, 21913 }, -- Edge of Winter / 38
				{ 9, 2741 }, -- Bronze Axe / 23
				{ 10, 3294 }, -- Thick War Axe / 17
				{ 11, 2738 }, -- Copper Axe / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 23653 }, -- Nightfall / 70
				{ 18, 1306534 }, -- Forest Defender's Axe / 65
				{ 19, 16994 }, -- Arcanite Reaper / 63
				{ 20, 1252366 }, -- Stormcarver / 63
				{ 21, 15294 }, -- Dark Iron Sunderer / 57
				{ 22, 16971 }, -- Huge Thorium Battleaxe / 56
				{ 23, 16965 }, -- Bleakwood Hew / 54
				{ 24, 1252361 }, -- Charged Mithril Battleaxe / 48
				{ 25, 3500 }, -- Shadow Crescent Axe / 40
				{ 26, 3498 }, -- Massive Iron Axe / 37
				{ 27, 9987 }, -- Bronze Battle Axe / 27
				{ 28, 3293 }, -- Copper Battle Axe / 13
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 23650 }, -- Ebon Hand / 70
				{ 3, 1306535 }, -- Greenhammer / 65
				{ 4, 27830 }, -- Persuader / 63
				{ 5, 16993 }, -- Masterwork Stormhammer / 63
				{ 6, 16984 }, -- Volcanic Hammer / 58
				{ 7, 16983 }, -- Serenity / 57
				{ 8, 10009 }, -- Runed Mithril Hammer / 49
				{ 9, 10003 }, -- The Shatterer / 47
				{ 10, 10001 }, -- Big Black Mace / 46
				{ 11, 1252355 }, -- Iron Morningstar / 38
				{ 12, 3297 }, -- Mighty Iron Hammer / 30
				{ 13, 6518 }, -- Iridescent Hammer / 28
				{ 14, 3296 }, -- Heavy Bronze Mace / 25
				{ 15, 2740 }, -- Bronze Mace / 22
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 21161 }, -- Sulfuron Hammer / 67
				{ 18, 16988 }, -- Hammer of the Titans / 63
				{ 19, 16973 }, -- Enchanted Battlehammer / 56
				{ 20, 1252362 }, -- Thorium Greatmace / 55
				{ 21, 15292 }, -- Dark Iron Pulverizer / 55
				{ 22, 16967 }, -- Inlaid Thorium Hammer / 54
				{ 23, 1252357 }, -- Mithril Warhammer / 43
				{ 24, 3495 }, -- Golden Iron Destroyer / 34
				{ 25, 3494 }, -- Solid Iron Maul / 31
				{ 26, 9985 }, -- Bronze Warhammer / 25
				{ 27, 7408 }, -- Heavy Copper Maul / 16
				{ 101, 2737 }, -- Copper Mace / 9
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2, 23652 }, -- Blackguard / 70
				{ 3, 20890 }, -- Dark Iron Reaver / 65
				{ 4, 1306533 }, -- Ironwood Blade / 65
				{ 5, 27832 }, -- Sageblade / 64
				{ 6, 16992 }, -- Frostguard / 63
				{ 7, 16978 }, -- Blazing Rapier / 56
				{ 8, 10007 }, -- Phantom Blade / 49
				{ 9, 10005 }, -- Dazzling Mithril Rapier / 48
				{ 10, 9997 }, -- Wicked Mithril Blade / 45
				{ 11, 1252356 }, -- Mithril Shortsword / 41
				{ 12, 3493 }, -- Jade Serpentblade / 35
				{ 13, 3492 }, -- Hardened Iron Shortsword / 32
				{ 14, 2742 }, -- Bronze Shortsword / 24
				{ 15, 2739 }, -- Copper Shortsword / 10
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 16990 }, -- Arcanite Champion / 63
				{ 18, 16985 }, -- Corruption / 58
				{ 19, 10015 }, -- Truesilver Champion / 52
				{ 20, 16960 }, -- Thorium Greatsword / 52
				{ 21, 1252359 }, -- Mithril Claymore / 45
				{ 22, 3497 }, -- Frost Tiger Blade / 40
				{ 23, 3496 }, -- Moonsteel Broadsword / 36
				{ 24, 9986 }, -- Bronze Greatsword / 26
				{ 25, 3292 }, -- Heavy Copper Broadsword / 19
				{ 26, 9983 }, -- Copper Claymore / 11
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, 23639 }, -- Blackfury / 66
				{ 2, 1252368 }, -- Legionite Glaive / 63
				{ 3, 16987 }, -- Darkspear / 60
				{ 4, 1252364 }, -- Thorium Poleaxe / 57
				{ 5, 10011 }, -- Blight / 50
				{ 6, 1252354 }, -- Steel Spear / 37
				{ 7, 1252352 }, -- Bronze Dory / 25
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Fist Weapons"],
			[NORMAL_DIFF] = {
				{ 1, 1252367 }, -- Bagh Nakh / 63
				{ 2, 16986 }, -- Blood Talon / 60
				{ 3, 1252363 }, -- Thorium Cestus / 55
				{ 4, 1317964 }, -- Arcanite Blacksmith Hammer / 54
				{ 5, 1252358 }, -- Mithril Claws / 45
				{ 6, 1317963 }, -- Mithril Blacksmith Hammer / 39
				{ 7, 1252353 }, -- Iron Fists / 31
				{ 8, 1317962 }, -- Cracked Blacksmith Hammer / 22
				{ 9, 1252351 }, -- Brass Knuckles / 21
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[MAIL_DIFF] = {
				{ 1, 16659 }, -- Radiant Circlet / 59
				{ 2, 9961 }, -- Mithril Coif / 46
				{ 3, 1252286 }, -- Hard Gold Coif / 40
				{ 4, 3503 }, -- Golden Scale Coif / 38
				{ 5, 1301534 }, -- Azure Skyforged Helm / 35
				{ 6, 1301526 }, -- Cloudy Skyforged Helm / 35
				{ 7, 9814 }, -- Barbaric Iron Helm / 35
				{ 8, 3502 }, -- Green Iron Helm / 34
				{ 9, 1252250 }, -- Acolyte's Chain Helm / 30
				{ 10, 1252251 }, -- Crusader's Chain Helm / 30
				{ 11, 1252248 }, -- Guard's Chain Helm / 30
				{ 12, 1252249 }, -- Protector's Chain Helm / 30
				{ 13, 1252247 }, -- Veteran's Chain Helm / 30
				{ 14, 1252280 }, -- Acolyte's Silvered Chain Helm / 25
				{ 15, 1252281 }, -- Crusader's Silvered Chain Helm / 25
				{ 16, 1252278 }, -- Guard's Silvered Chain Helm / 25
				{ 17, 1252279 }, -- Protector's Silvered Chain Helm / 25
				{ 18, 1252277 }, -- Veteran's Silvered Chain Helm / 25
			},
			[PLATE_DIFF] = {
				{ 1, 23636 }, -- Dark Iron Helm / 66
				{ 2, 24913 }, -- Darkrune Helm / 63
				{ 3, 1252346 }, -- Enriched Thorium Helm / 63
				{ 4, 16742 }, -- Enchanted Thorium Helm / 62
				{ 5, 16729 }, -- Lionheart Helm / 61
				{ 6, 1252348 }, -- Stalwart Helm / 61
				{ 7, 16726 }, -- Runic Plate Helm / 61
				{ 8, 16724 }, -- Whitesoul Helm / 60
				{ 9, 1252342 }, -- Blessed Plate Helm / 60
				{ 10, 16658 }, -- Imperial Plate Helm / 59
				{ 11, 16653 }, -- Thorium Helm / 56
				{ 12, 9980 }, -- Ornate Mithril Helm / 49
				{ 13, 1252292 }, -- Shining Mithril Helm / 48
				{ 14, 9970 }, -- Heavy Mithril Helm / 47
				{ 15, 9935 }, -- Steel Plate Helm / 43
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[MAIL_DIFF] = {
				{ 1, 24137 }, -- Bloodsoul Shoulders / 65
				{ 2, 20873 }, -- Fiery Chain Shoulders / 62
				{ 3, 9966 }, -- Mithril Plate Shoulders / 47
				{ 4, 1252288 }, -- Hard Gold Pauldrons / 40
				{ 5, 1301535 }, -- Azure Skyforged Pauldrons / 35
				{ 6, 1301527 }, -- Cloudy Skyforged Pauldrons / 35
				{ 7, 3505 }, -- Golden Scale Shoulders / 35
				{ 8, 9811 }, -- Barbaric Iron Shoulders / 32
				{ 9, 3504 }, -- Green Iron Shoulders / 32
				{ 10, 1252235 }, -- Sterling Silver Shoulders / 27
				{ 11, 3330 }, -- Silvered Bronze Shoulders / 25
				{ 12, 3328 }, -- Rough Bronze Shoulders / 22
			},
			[PLATE_DIFF] = {
				{ 1, 24141 }, -- Darksoul Shoulders / 65
				{ 2, 16664 }, -- Runic Plate Shoulders / 60
				{ 3, 16660 }, -- Dawnbringer Shoulders / 58
				{ 4, 15295 }, -- Dark Iron Shoulders / 58
				{ 5, 16646 }, -- Imperial Plate Shoulders / 53
				{ 6, 1252335 }, -- Blessed Plate Pauldrons / 52
				{ 7, 1252329 }, -- Justicar's Pauldrons / 47
				{ 8, 1252325 }, -- Officer's Pauldrons / 47
				{ 9, 1252328 }, -- Prefect's Pauldrons / 47
				{ 10, 1252326 }, -- Sentinel's Pauldrons / 47
				{ 11, 1252327 }, -- Warder's Pauldrons / 47
				{ 12, 9952 }, -- Ornate Mithril Shoulders / 45
				{ 13, 1252290 }, -- Shining Mithril Pauldrons / 45
				{ 14, 9926 }, -- Heavy Mithril Shoulder / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[MAIL_DIFF] = {
				{ 1, 27590 }, -- Obsidian Mail Tunic / 72
				{ 2, 24136 }, -- Bloodsoul Breastplate / 65
				{ 3, 15293 }, -- Dark Iron Mail / 56
				{ 4, 16648 }, -- Radiant Breastplate / 54
				{ 5, 9916 }, -- Steel Breastplate / 40
				{ 6, 3511 }, -- Golden Scale Cuirass / 40
				{ 7, 3508 }, -- Green Iron Hauberk / 36
				{ 8, 1252282 }, -- Hard Gold Cuirass / 34
				{ 9, 9813 }, -- Barbaric Iron Breastplate / 32
				{ 10, 1252236 }, -- Sterling Silver Breastplate / 30
				{ 11, 2675 }, -- Shining Silver Breastplate / 29
				{ 12, 1252270 }, -- Acolyte's Silvered Chain Shirt / 27
				{ 13, 1252271 }, -- Crusader's Silvered Chain Shirt / 27
				{ 14, 1252268 }, -- Guard's Silvered Chain Shirt / 27
				{ 15, 1252269 }, -- Protector's Silvered Chain Shirt / 27
				{ 16, 1252267 }, -- Veteran's Silvered Chain Shirt / 27
				{ 17, 2673 }, -- Silvered Bronze Breastplate / 26
				{ 18, 2670 }, -- Rough Bronze Cuirass / 23
				{ 19, 8367 }, -- Ironforge Breastplate / 20
				{ 20, 1252240 }, -- Acolyte's Chain Shirt / 20
				{ 21, 1252241 }, -- Crusader's Chain Shirt / 20
				{ 22, 1252238 }, -- Guard's Chain Shirt / 20
				{ 23, 1252239 }, -- Protector's Chain Shirt / 20
				{ 24, 1252237 }, -- Veteran's Chain Shirt / 20
				{ 25, 2667 }, -- Runed Copper Breastplate / 18
				{ 26, 8366 }, -- Ironforge Chain / 16
				{ 27, 1301445 }, -- Azure Skyforged Chainmail / 12
				{ 28, 1301421 }, -- Cloudy Skyforged Chainmail / 12
				{ 29, 3321 }, -- Copper Chain Vest / 10
				{ 30, 12260 }, -- Rough Copper Vest / 10
			},
			[PLATE_DIFF] = {
				{ 1, 28242 }, -- Icebane Breastplate / 80
				{ 2, 27587 }, -- Thick Obsidian Breastplate / 72
				{ 3, 24139 }, -- Darksoul Breastplate / 65
				{ 4, 24914 }, -- Darkrune Breastplate / 63
				{ 5, 16745 }, -- Enchanted Thorium Breastplate / 63
				{ 6, 1252344 }, -- Enriched Thorium Breastplate / 62
				{ 7, 16731 }, -- Runic Breastplate / 62
				{ 8, 1252350 }, -- Breastplate of Salvation / 61
				{ 9, 1252343 }, -- Blessed Plate Chest / 61
				{ 10, 16663 }, -- Imperial Plate Chest / 60
				{ 11, 15296 }, -- Dark Iron Plate / 59
				{ 12, 16642 }, -- Thorium Armor / 50
				{ 13, 9974 }, -- Truesilver Breastplate / 49
				{ 14, 9972 }, -- Ornate Mithril Breastplate / 48
				{ 15, 9959 }, -- Heavy Mithril Breastplate / 46
				{ 16, 1252289 }, -- Shining Mithril Breastplate / 45
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[MAIL_DIFF] = {
				{ 1, 16656 }, -- Radiant Boots / 58
				{ 2, 1252299 }, -- Justicar's Boots / 45
				{ 3, 1252295 }, -- Officer's Boots / 45
				{ 4, 1252298 }, -- Prefect's Boots / 45
				{ 5, 1252296 }, -- Sentinel's Boots / 45
				{ 6, 1252297 }, -- Warder's Boots / 45
				{ 7, 3515 }, -- Golden Scale Boots / 40
				{ 8, 3513 }, -- Polished Steel Boots / 37
				{ 9, 9818 }, -- Barbaric Iron Boots / 36
				{ 10, 1252283 }, -- Hard Gold Boots / 35
				{ 11, 3334 }, -- Green Iron Boots / 29
				{ 12, 3331 }, -- Silvered Bronze Boots / 26
				{ 13, 1252232 }, -- Sterling Silver Boots / 25
				{ 14, 1252255 }, -- Acolyte's Boots / 22
				{ 15, 1252256 }, -- Crusader's Boots / 22
				{ 16, 1252253 }, -- Guard's Boots / 22
				{ 17, 1252254 }, -- Protector's Boots / 22
				{ 18, 1252252 }, -- Veteran's Boots / 22
				{ 19, 7817 }, -- Rough Bronze Boots / 18
				{ 20, 1252229 }, -- Gemmed Copper Boots / 15
				{ 21, 1252231 }, -- Glowing Copper Boots / 15
				{ 22, 1252230 }, -- Strange Copper Boots / 15
				{ 23, 1301450 }, -- Azure Skyforged Greaves / 11
				{ 24, 1301426 }, -- Cloudy Skyforged Greaves / 11
				{ 25, 3319 }, -- Copper Chain Boots / 10
				{ 26, 1302598 }, -- Rough Copper Chain Boots / 10
			},
			[PLATE_DIFF] = {
				{ 1, 24399 }, -- Dark Iron Boots / 70
				{ 2, 1306537 }, -- Depleted Thorium Sabatons / 65
				{ 3, 16665 }, -- Runic Plate Boots / 60
				{ 4, 16657 }, -- Imperial Plate Boots / 59
				{ 5, 1297143 }, -- Clutchlord's Stompers / 58
				{ 6, 1297140 }, -- Goregasher Stompers / 58
				{ 7, 16652 }, -- Thorium Boots / 56
				{ 8, 1252314 }, -- Justicar's Sabatons / 52
				{ 9, 1252310 }, -- Officer's Sabatons / 52
				{ 10, 1252313 }, -- Prefect's Sabatons / 52
				{ 11, 1252311 }, -- Sentinel's Sabatons / 52
				{ 12, 1252312 }, -- Warder's Sabatons / 52
				{ 13, 1252336 }, -- Blessed Plate Boots / 52
				{ 14, 9979 }, -- Ornate Mithril Boots / 49
				{ 15, 9968 }, -- Heavy Mithril Boots / 47
				{ 16, 1252291 }, -- Shining Mithril Boots / 45
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[MAIL_DIFF] = {
				{ 1, 27589 }, -- Black Grasp of the Destroyer / 70
				{ 2, 24138 }, -- Bloodsoul Gauntlets / 65
				{ 3, 16654 }, -- Radiant Gloves / 57
				{ 4, 1252304 }, -- Justicar's Gloves / 55
				{ 5, 1252300 }, -- Officer's Gloves / 55
				{ 6, 1252303 }, -- Prefect's Gloves / 55
				{ 7, 1252301 }, -- Sentinel's Gloves / 55
				{ 8, 1252302 }, -- Warder's Gloves / 55
				{ 9, 9942 }, -- Mithril Plate Gloves / 44
				{ 10, 439120 }, -- Golden Scale Gauntlets / 41
				{ 11, 11643 }, -- Golden Scale Gauntlets / 41
				{ 12, 1252287 }, -- Hard Gold Gauntlet / 40
				{ 13, 9820 }, -- Barbaric Iron Gloves / 37
				{ 14, 3336 }, -- Green Iron Gauntlets / 30
				{ 15, 8368 }, -- Ironforge Gauntlets / 28
				{ 16, 3333 }, -- Silvered Bronze Gauntlets / 27
				{ 17, 1252234 }, -- Sterling Silver Gauntlet / 26
				{ 18, 1252260 }, -- Acolyte's Gloves / 20
				{ 19, 1252261 }, -- Crusader's Gloves / 20
				{ 20, 1252258 }, -- Guard's Gloves / 20
				{ 21, 1252259 }, -- Protector's Gloves / 20
				{ 22, 1252257 }, -- Veteran's Gloves / 20
				{ 23, 3325 }, -- Gemmed Copper Gauntlets / 15
				{ 24, 3323 }, -- Runed Copper Gauntlets / 12
				{ 25, 1301447 }, -- Azure Skyforged Gauntlets / 11
				{ 26, 1301423 }, -- Cloudy Skyforged Gauntlets / 11
			},
			[PLATE_DIFF] = {
				{ 1, 28243 }, -- Icebane Gauntlets / 80
				{ 2, 23637 }, -- Dark Iron Gauntlets / 70
				{ 3, 1306538 }, -- Heavy Thorium Gauntlets / 65
				{ 4, 24912 }, -- Darkrune Gauntlets / 63
				{ 5, 16741 }, -- Stronghold Gauntlets / 62
				{ 6, 23633 }, -- Gloves of the Dawn / 61
				{ 7, 1297141 }, -- Clutchlord's Grips / 58
				{ 8, 1297138 }, -- Goregasher Grips / 58
				{ 9, 16655 }, -- Fiery Plate Gauntlets / 58
				{ 10, 1252338 }, -- Imperial Plate Gauntlets / 57
				{ 11, 1252337 }, -- Blessed Plate Gauntlet / 54
				{ 12, 1252294 }, -- Shining Mithril Gauntlet / 49
				{ 13, 9954 }, -- Truesilver Gauntlets / 45
				{ 14, 9950 }, -- Ornate Mithril Gloves / 44
				{ 15, 9928 }, -- Heavy Mithril Gauntlet / 41
				{ 16, 1252319 }, -- Justicar's Gauntlet / 40
				{ 17, 1252315 }, -- Officer's Gauntlet / 40
				{ 18, 1252318 }, -- Prefect's Gauntlet / 40
				{ 19, 1252316 }, -- Sentinel's Gauntlet / 40
				{ 20, 1252317 }, -- Warder's Gauntlet / 40
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[MAIL_DIFF] = {
				{ 1, 16725 }, -- Radiant Leggings / 61
				{ 2, 9957 }, -- Orcish War Leggings / 42
				{ 3, 9931 }, -- Mithril Plate Pants / 42
				{ 4, 1252285 }, -- Hard Gold Leggings / 38
				{ 5, 3507 }, -- Golden Scale Leggings / 34
				{ 6, 3506 }, -- Green Iron Leggings / 31
				{ 7, 12259 }, -- Silvered Bronze Leggings / 31
				{ 8, 1252275 }, -- Acolyte's Silvered Chain Leggings / 30
				{ 9, 1252276 }, -- Crusader's Silvered Chain Leggings / 30
				{ 10, 1252273 }, -- Guard's Silvered Chain Leggings / 30
				{ 11, 1252274 }, -- Protector's Silvered Chain Leggings / 30
				{ 12, 1252272 }, -- Veteran's Silvered Chain Leggings / 30
				{ 13, 1252233 }, -- Sterling Silver Leggings / 26
				{ 14, 1252245 }, -- Acolyte's Chain Leggings / 25
				{ 15, 1252246 }, -- Crusader's Chain Leggings / 25
				{ 16, 1252243 }, -- Guard's Chain Leggings / 25
				{ 17, 1252244 }, -- Protector's Chain Leggings / 25
				{ 18, 1252242 }, -- Veteran's Chain Leggings / 25
				{ 19, 2668 }, -- Rough Bronze Leggings / 21
				{ 20, 3324 }, -- Runed Copper Pants / 13
				{ 21, 1301449 }, -- Azure Skyforged Legguards / 12
				{ 22, 1301425 }, -- Cloudy Skyforged Legguards / 12
				{ 23, 2662 }, -- Copper Chain Pants / 10
			},
			[PLATE_DIFF] = {
				{ 1, 24140 }, -- Darksoul Leggings / 65
				{ 2, 1306539 }, -- Azerothium Legplates / 65
				{ 3, 16744 }, -- Enchanted Thorium Leggings / 63
				{ 4, 1252345 }, -- Enriched Thorium Leggings / 63
				{ 5, 16732 }, -- Runic Plate Leggings / 62
				{ 6, 1252347 }, -- Champion's Legplates / 61
				{ 7, 1252349 }, -- Martyr's Legplates / 61
				{ 8, 16730 }, -- Imperial Plate Leggings / 61
				{ 9, 20876 }, -- Dark Iron Leggings / 60
				{ 10, 27829 }, -- Titanic Leggings / 60
				{ 11, 16662 }, -- Thorium Leggings / 60
				{ 12, 1252340 }, -- Blessed Plate Leggings / 59
				{ 13, 1252293 }, -- Shining Mithril Pants / 49
				{ 14, 9945 }, -- Ornate Mithril Pants / 44
				{ 15, 9933 }, -- Heavy Mithril Pants / 42
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[MAIL_DIFF] = {
				{ 1, 27588 }, -- Light Obsidian Belt / 68
				{ 2, 20872 }, -- Fiery Chain Girdle / 59
				{ 3, 16645 }, -- Radiant Belt / 52
				{ 4, 1252309 }, -- Justicar's Belt / 35
				{ 5, 1252305 }, -- Officer's Belt / 35
				{ 6, 1252308 }, -- Prefect's Belt / 35
				{ 7, 1252306 }, -- Sentinel's Belt / 35
				{ 8, 1252307 }, -- Warder's Belt / 35
				{ 9, 2666 }, -- Runed Copper Belt / 18
				{ 10, 1252265 }, -- Acolyte's Chain Belt / 17
				{ 11, 1252266 }, -- Crusader's Chain Belt / 17
				{ 12, 1252263 }, -- Guard's Chain Belt / 17
				{ 13, 1252264 }, -- Protector's Chain Belt / 17
				{ 14, 1252262 }, -- Veteran's Chain Belt / 17
				{ 15, 2661 }, -- Copper Chain Belt / 11
				{ 16, 1301448 }, -- Azure Skyforged Chain / 10
				{ 17, 1301424 }, -- Cloudy Skyforged Chain / 10
			},
			[PLATE_DIFF] = {
				{ 1, 27585 }, -- Heavy Obsidian Belt / 68
				{ 2, 1252341 }, -- Blessed Plate Belt / 59
				{ 3, 1297142 }, -- Clutchlord's Support / 58
				{ 4, 1297139 }, -- Goregasher Support / 58
				{ 5, 23632 }, -- Girdle of the Dawn / 58
				{ 6, 1252324 }, -- Justicar's Waistguard / 55
				{ 7, 1252320 }, -- Officer's Waistguard / 55
				{ 8, 1252323 }, -- Prefect's Waistguard / 55
				{ 9, 1252321 }, -- Sentinel's Waistguard / 55
				{ 10, 1252322 }, -- Warder's Waistguard / 55
				{ 11, 16647 }, -- Imperial Plate Belt / 53
				{ 12, 16643 }, -- Thorium Belt / 50
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[MAIL_DIFF] = {
				{ 1, 9937 }, -- Mithril Plate Bracers / 43
				{ 2, 7223 }, -- Golden Scale Bracers / 37
				{ 3, 1252284 }, -- Hard Gold Bracers / 37
				{ 4, 3501 }, -- Green Iron Bracers / 33
				{ 5, 2672 }, -- Patterned Bronze Bracers / 25
				{ 6, 2671 }, -- Rough Bronze Bracers / 23
				{ 7, 2664 }, -- Runed Copper Bracers / 19
				{ 8, 1301446 }, -- Azure Skyforged Wristguards / 10
				{ 9, 1301422 }, -- Cloudy Skyforged Wristguards / 10
				{ 10, 2663 }, -- Copper Bracers / 7
			},
			[PLATE_DIFF] = {
				{ 1, 28244 }, -- Icebane Bracers / 80
				{ 2, 20874 }, -- Dark Iron Bracers / 59
				{ 3, 1252339 }, -- Blessed Plate Bracers / 57
				{ 4, 16649 }, -- Imperial Plate Bracers / 54
				{ 5, 16644 }, -- Thorium Bracers / 51
				{ 6, 1252334 }, -- Justicar's Wristguards / 50
				{ 7, 1252330 }, -- Officer's Wristguards / 50
				{ 8, 1252333 }, -- Prefect's Wristguards / 50
				{ 9, 1252331 }, -- Sentinel's Wristguards / 50
				{ 10, 1252332 }, -- Warder's Wristguards / 50
			},
		},
		{
			name = ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 27586 }, -- Jagged Obsidian Shield / 70
				{ 2, 1306536 }, -- Evergreen Shield / 65
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 22757 }, -- Elemental Sharpening Stone / 60
				{ 2, 16651 }, -- Thorium Shield Spike / 55
				{ 3, 16641 }, -- Dense Sharpening Stone / 45
				{ 4, 16640 }, -- Dense Weightstone / 45
				{ 5, 9964 }, -- Mithril Spurs / 43
				{ 6, 9939 }, -- Mithril Shield Spike / 43
				{ 7, 435910 }, -- Low-Background Truesilver Plates / 40
				{ 8, 7224 }, -- Steel Weapon Chain / 38
				{ 9, 9918 }, -- Solid Sharpening Stone / 35
				{ 10, 9921 }, -- Solid Weightstone / 35
				{ 11, 7222 }, -- Iron Counterweight / 33
				{ 12, 7221 }, -- Iron Shield Spike / 30
				{ 13, 430397 }, -- Blackfathom Sharpening Stone / 25
				{ 14, 2674 }, -- Heavy Sharpening Stone / 25
				{ 15, 3117 }, -- Heavy Weightstone / 25
				{ 16, 2665 }, -- Coarse Sharpening Stone / 15
				{ 17, 3116 }, -- Coarse Weightstone / 15
				{ 18, 2660 }, -- Rough Sharpening Stone / 5
				{ 19, 3115 }, -- Rough Weightstone / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 1263073 }, -- Master Forge / 60
				{ 2, 19669 }, -- Arcanite Skeleton Key / 55
				{ 3, 20201 }, -- Arcanite Rod / 55
				{ 4, 16639 }, -- Dense Grinding Stone / 45
				{ 5, 11454 }, -- Inlaid Mithril Cylinder / 42
				{ 6, 14380 }, -- Truesilver Rod / 40
				{ 7, 19668 }, -- Truesilver Skeleton Key / 40
				{ 8, 9920 }, -- Solid Grinding Stone / 35
				{ 9, 14379 }, -- Golden Rod / 30
				{ 10, 19667 }, -- Golden Skeleton Key / 30
				{ 11, 8768 }, -- Iron Buckle / 30
				{ 12, 1263041 }, -- Anvil / 28
				{ 13, 3337 }, -- Heavy Grinding Stone / 25
				{ 14, 7818 }, -- Silver Rod / 20
				{ 15, 19666 }, -- Silver Skeleton Key / 20
				{ 16, 3326 }, -- Coarse Grinding Stone / 20
				{ 17, 3320 }, -- Rough Grinding Stone / 10
				{ 18, 1245287 }, -- Copper Rod / 5
				{ 19, 1230171 }, -- Sharpening Wheel / 4
			},
		},
	}
}

data["Enchanting"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENCHANTING_LINK,
	items = {
		{
			name = AL["Oil"],
			[NORMAL_DIFF] = {
				{ 1, 25130 }, -- Brilliant Mana Oil / 55
				{ 2, 25129 }, -- Brilliant Wizard Oil / 55
				{ 3, 25128 }, -- Wizard Oil / 50
				{ 4, 25127 }, -- Lesser Mana Oil / 50
				{ 5, 25126 }, -- Lesser Wizard Oil / 40
				{ 6, 25125 }, -- Minor Mana Oil / 30
				{ 7, 25124 }, -- Minor Wizard Oil / 15
			},
		},
		{
			name = ALIL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 1306520 }, -- Torch of Light / 65
				{ 2, 1248650 }, -- Brilliant Wand / 60
				{ 3, 1248515 }, -- Greater Eternal Wand / 60
				{ 4, 1248505 }, -- Lesser Eternal Wand / 54
				{ 5, 1248509 }, -- Dreambough Wand / 48
				{ 6, 1248461 }, -- Twisted Nether Wand / 42
				{ 7, 14810 }, -- Greater Mystic Wand / 35
				{ 8, 439134 }, -- Greater Mystic Wand / 35
				{ 9, 14809 }, -- Lesser Mystic Wand / 31
				{ 10, 14807 }, -- Greater Magic Wand / 23
				{ 11, 14293 }, -- Lesser Magic Wand / 15
				{ 12, 1245321 }, -- Novice's Practice Wand / 6
			},
		},
		{
			name = AL["Relics & Off-Hands"],
			[NORMAL_DIFF] = {
				{ 1, 1249154 }, -- Totem of Thunder / 65
				{ 2, 1306524 }, -- Idol of Swiftness / 65
				{ 3, 1306525 }, -- Idol of the Ursine Twins / 65
				{ 4, 1306522 }, -- Libram of Infusion / 65
				{ 5, 1306521 }, -- Steadfast Libram / 65
				{ 6, 1306523 }, -- Totem of Urgency / 65
				{ 7, 1249128 }, -- Idol of the Dream / 60
				{ 8, 1249152 }, -- Libram of Holy Alacrity / 60
				{ 9, 1249114 }, -- Dormant Heart of the Mountain / 55
				{ 10, 1249107 }, -- Frozen Heart of the Mountain / 55
				{ 11, 1249112 }, -- Molten Heart of the Mountain / 55
				{ 12, 1249064 }, -- Dreamstaff / 50
				{ 13, 1249061 }, -- Radiant Staff / 50
				{ 14, 1249069 }, -- Truesilver Conduit / 50
				{ 15, 1249070 }, -- Twisting Essence Jar / 50
				{ 16, 1249006 }, -- Libram of Invocation / 45
				{ 17, 1248974 }, -- Talons of Wrath / 45
				{ 18, 1249015 }, -- Totem of Ancestral Protection / 45
				{ 19, 1248703 }, -- Glimmering Staff / 30
				{ 20, 1248745 }, -- Orb of Mystic Insight / 30
				{ 21, 1248748 }, -- Orb of Souls / 30
				{ 22, 1248739 }, -- Soulstaff / 30
				{ 23, 1248752 }, -- Mystic Mushroom / 25
				{ 24, 1248755 }, -- Polished Driftwood Icon / 25
				{ 25, 1248754 }, -- Tenets of the Silver Hand / 25
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 463866 }, -- Enchanted Sigil: Flowing Waters / 60
				{ 2, 1263082 }, -- Arcane Forge / 60
				{ 3, 20051 }, -- Runed Arcanite Rod / 58
				{ 4, 471400 }, -- Magnificent Trollshine / 55
				{ 5, 17181 }, -- Enchanted Leather / 55
				{ 6, 17180 }, -- Enchanted Thorium Bar / 55
				{ 7, 463869 }, -- Conductive Shield Coating / 50
				{ 8, 439156 }, -- Enchanted Sigil: Innovation / 40
				{ 9, 13702 }, -- Runed Truesilver Rod / 40
				{ 10, 13628 }, -- Runed Golden Rod / 30
				{ 11, 1263056 }, -- Arcane Salvager / 28
				{ 12, 7795 }, -- Runed Silver Rod / 20
				{ 13, 448624 }, -- Scroll of Spatial Mending / 15
				{ 14, 1245320 }, -- Mote of Magic / 5
				{ 15, 7421 }, -- Runed Copper Rod / 5
				{ 16, 1230643 }, -- Enchanted Lute / 4
			},
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20031 }, -- Spell #20031
				{ 2, 20032 }, -- Spell #20032
				{ 3, 20034 }, -- Spell #20034
				{ 4, 22749 }, -- Spell #22749
				{ 5, 22750 }, -- Spell #22750
				{ 6, 23803 }, -- Spell #23803
				{ 7, 23804 }, -- Spell #23804
				{ 8, 20033 }, -- Spell #20033
				{ 9, 23799 }, -- Spell #23799
				{ 10, 23800 }, -- Spell #23800
				{ 11, 20029 }, -- Spell #20029
				{ 12, 13898 }, -- Spell #13898
				{ 13, 13943 }, -- Spell #13943
				{ 14, 13915 }, -- Spell #13915
				{ 15, 13693 }, -- Spell #13693
				{ 16, 21931 }, -- Spell #21931
				{ 17, 13653 }, -- Spell #13653
				{ 18, 13655 }, -- Spell #13655
				{ 19, 13503 }, -- Spell #13503
				{ 20, 7786 }, -- Spell #7786
				{ 21, 7788 }, -- Spell #7788
			},
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20035 }, -- Spell #20035
				{ 2, 20036 }, -- Spell #20036
				{ 3, 20030 }, -- Spell #20030
				{ 4, 27837 }, -- Spell #27837
				{ 5, 13937 }, -- Spell #13937
				{ 6, 13695 }, -- Spell #13695
				{ 7, 13529 }, -- Spell #13529
				{ 8, 13380 }, -- Spell #13380
				{ 9, 7745 }, -- Spell #7745
				{ 10, 7793 }, -- Spell #7793
			},
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25081 }, -- Spell #25081
				{ 2, 25082 }, -- Spell #25082
				{ 3, 25083 }, -- Spell #25083
				{ 4, 25084 }, -- Spell #25084
				{ 5, 25086 }, -- Spell #25086
				{ 6, 20015 }, -- Spell #20015
				{ 7, 20014 }, -- Spell #20014
				{ 8, 13882 }, -- Spell #13882
				{ 9, 13746 }, -- Spell #13746
				{ 10, 13794 }, -- Spell #13794
				{ 11, 13657 }, -- Spell #13657
				{ 12, 13635 }, -- Spell #13635
				{ 13, 13522 }, -- Spell #13522
				{ 14, 7861 }, -- Spell #7861
				{ 15, 13421 }, -- Spell #13421
				{ 16, 13419 }, -- Spell #13419
				{ 17, 7771 }, -- Spell #7771
				{ 18, 7454 }, -- Spell #7454
			},
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20025 }, -- Spell #20025
				{ 2, 20028 }, -- Spell #20028
				{ 3, 20026 }, -- Spell #20026
				{ 4, 13941 }, -- Spell #13941
				{ 5, 13917 }, -- Spell #13917
				{ 6, 13858 }, -- Spell #13858
				{ 7, 13700 }, -- Spell #13700
				{ 8, 13663 }, -- Spell #13663
				{ 9, 13640 }, -- Spell #13640
				{ 10, 13626 }, -- Spell #13626
				{ 11, 13607 }, -- Spell #13607
				{ 12, 13538 }, -- Spell #13538
				{ 13, 7857 }, -- Spell #7857
				{ 14, 7776 }, -- Spell #7776
				{ 15, 7748 }, -- Spell #7748
				{ 16, 7426 }, -- Spell #7426
				{ 17, 7443 }, -- Spell #7443
				{ 18, 7420 }, -- Spell #7420
			},
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20023 }, -- Spell #20023
				{ 2, 20024 }, -- Spell #20024
				{ 3, 20020 }, -- Spell #20020
				{ 4, 13935 }, -- Spell #13935
				{ 5, 13890 }, -- Spell #13890
				{ 6, 13836 }, -- Spell #13836
				{ 7, 13687 }, -- Spell #13687
				{ 8, 13644 }, -- Spell #13644
				{ 9, 13637 }, -- Spell #13637
				{ 10, 7863 }, -- Spell #7863
				{ 11, 7867 }, -- Spell #7867
			},
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 25072 }, -- Spell #25072
				{ 2, 25073 }, -- Spell #25073
				{ 3, 25074 }, -- Spell #25074
				{ 4, 25078 }, -- Spell #25078
				{ 5, 25079 }, -- Spell #25079
				{ 6, 25080 }, -- Spell #25080
				{ 7, 20013 }, -- Spell #20013
				{ 8, 20012 }, -- Spell #20012
				{ 9, 13947 }, -- Spell #13947
				{ 10, 13948 }, -- Spell #13948
				{ 11, 13868 }, -- Spell #13868
				{ 12, 13887 }, -- Spell #13887
				{ 13, 13841 }, -- Spell #13841
				{ 14, 13815 }, -- Spell #13815
				{ 15, 13698 }, -- Spell #13698
				{ 16, 13612 }, -- Spell #13612
				{ 17, 13617 }, -- Spell #13617
				{ 18, 13620 }, -- Spell #13620
			},
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20016 }, -- Spell #20016
				{ 2, 20017 }, -- Spell #20017
				{ 3, 13933 }, -- Spell #13933
				{ 4, 13905 }, -- Spell #13905
				{ 5, 13817 }, -- Spell #13817
				{ 6, 13689 }, -- Spell #13689
				{ 7, 13659 }, -- Spell #13659
				{ 8, 13631 }, -- Spell #13631
				{ 9, 13485 }, -- Spell #13485
				{ 10, 13464 }, -- Spell #13464
				{ 11, 13378 }, -- Spell #13378
			},
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 20011 }, -- Spell #20011
				{ 2, 23802 }, -- Spell #23802
				{ 3, 20010 }, -- Spell #20010
				{ 4, 23801 }, -- Spell #23801
				{ 5, 20009 }, -- Spell #20009
				{ 6, 20008 }, -- Spell #20008
				{ 7, 13945 }, -- Spell #13945
				{ 8, 13939 }, -- Spell #13939
				{ 9, 13931 }, -- Spell #13931
				{ 10, 13846 }, -- Spell #13846
				{ 11, 13822 }, -- Spell #13822
				{ 12, 13661 }, -- Spell #13661
				{ 13, 13646 }, -- Spell #13646
				{ 14, 13648 }, -- Spell #13648
				{ 15, 13642 }, -- Spell #13642
				{ 16, 13622 }, -- Spell #13622
				{ 17, 13536 }, -- Spell #13536
				{ 18, 13501 }, -- Spell #13501
				{ 19, 7859 }, -- Spell #7859
				{ 20, 7779 }, -- Spell #7779
				{ 21, 7782 }, -- Spell #7782
				{ 22, 7766 }, -- Spell #7766
				{ 23, 7457 }, -- Spell #7457
				{ 24, 7428 }, -- Spell #7428
				{ 25, 7418 }, -- Spell #7418
			},
		},
	}
}

data["Engineering"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENGINEERING_LINK,
	items = {
		{
			name = AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 22797 }, -- Force Reactive Disk / 65
				{ 2, 1266942 }, -- EZ-Thro Magnetic Displacer / 60
				{ 3, 1266941 }, -- SAF-T Nitro Boosts / 60
				{ 4, 1266943 }, -- SAF-T Teleport / 60
				{ 5, 19819 }, -- Voice Amplification Modulator / 58
				{ 6, 1266923 }, -- SAF-T Disposable Parachute / 50
				{ 7, 12905 }, -- Gnomish Rocket Boots / 45
				{ 8, 8895 }, -- Goblin Rocket Boots / 45
				{ 9, 12616 }, -- Parachute Cloak / 45
				{ 10, 12903 }, -- Gnomish Harm Prevention Belt / 43
				{ 11, 1308180 }, -- Clanking Cord / 35
				{ 12, 1308179 }, -- Gizmo Girdle / 35
				{ 13, 1308178 }, -- Whimsical Waistwrap / 35
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 24356 }, -- Bloodvine Goggles / 65
				{ 2, 24357 }, -- Bloodvine Lens / 65
				{ 3, 19825 }, -- Master Engineer's Goggles / 58
				{ 4, 19794 }, -- Spellpower Goggles Xtreme Plus / 54
				{ 5, 12622 }, -- Green Lens / 49
				{ 6, 12758 }, -- Goblin Rocket Helmet / 47
				{ 7, 12907 }, -- Gnomish Mind Control Cap / 47
				{ 8, 12617 }, -- Deepdive Helmet / 46
				{ 9, 12618 }, -- Rose Colored Goggles / 46
				{ 10, 1308184 }, -- Bent Goggles / 45
				{ 11, 1308186 }, -- Dented Goggles / 45
				{ 12, 1308183 }, -- Floppy Goggles / 45
				{ 13, 1308185 }, -- Stuckbutton Goggles / 45
				{ 14, 12607 }, -- Catseye Ultra Goggles / 44
				{ 15, 12615 }, -- Spellpower Goggles Xtreme / 43
				{ 16, 12897 }, -- Gnomish Goggles / 42
				{ 17, 12594 }, -- Fire Goggles / 41
				{ 18, 12718 }, -- Goblin Construction Helmet / 41
				{ 19, 12717 }, -- Goblin Mining Helmet / 41
				{ 20, 3966 }, -- Craftsman's Monocle / 37
				{ 21, 12587 }, -- Bright-Eye Goggles / 35
				{ 22, 3956 }, -- Green Tinted Goggles / 30
				{ 23, 3940 }, -- Shadow Goggles / 24
				{ 24, 3934 }, -- Flying Tiger Goggles / 20
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 19830 }, -- Arcanite Dragonling / 60
				{ 2, 1266937 }, -- Gnomish Poultryizer / 60
				{ 3, 23082 }, -- Ultra-Flash Shadow Reflector / 60
				{ 4, 1266934 }, -- EZ and SAF Field Transporter: Mt. Hyjal / 60
				{ 5, 1266932 }, -- EZ-Thro Field Transporter: Gadgetzan / 60
				{ 6, 1266933 }, -- SAF-T Emergency Ripper: Everlook / 60
				{ 7, 23081 }, -- Hyper-Radiant Flame Reflector / 58
				{ 8, 23486 }, -- Dimensional Ripper - Everlook / 55
				{ 9, 23079 }, -- Major Recombobulator / 55
				{ 10, 23078 }, -- Goblin Jumper Cables XL / 53
				{ 11, 23489 }, -- Ultrasafe Transporter: Gadgetzan / 52
				{ 12, 23077 }, -- Gyrofreeze Ice Reflector / 52
				{ 13, 12624 }, -- Mithril Mechanical Dragonling / 50
				{ 14, 12759 }, -- Gnomish Death Ray / 48
				{ 15, 12908 }, -- Goblin Dragon Gun / 48
				{ 16, 12906 }, -- Gnomish Battle Chicken / 46
				{ 17, 12755 }, -- Goblin Bomb Dispenser / 46
				{ 18, 12902 }, -- Gnomish Net-o-Matic Projector / 42
				{ 19, 12899 }, -- Gnomish Shrink Ray / 41
				{ 20, 12716 }, -- Goblin Mortar / 41
				{ 21, 13240 }, -- Goblin Mortar / 41
				{ 22, 1266919 }, -- Emergency Field Cloak / 40
				{ 23, 3971 }, -- Gnomish Cloaking Device / 40
				{ 24, 3969 }, -- Mechanical Dragonling / 40
				{ 25, 1266915 }, -- EZ-Thro Bronze Mortar / 39
				{ 26, 9273 }, -- Goblin Jumper Cables / 33
				{ 27, 3952 }, -- Minor Recombobulator / 28
				{ 28, 9269 }, -- Gnomish Universal Remote / 25
			},
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 1306546 }, -- SAF-T Ultra Precision Scope / 65
				{ 2, 22793 }, -- Biznicks 247x128 Accurascope / 60
				{ 3, 12620 }, -- Sniper Scope / 48
				{ 4, 12597 }, -- Deadly Scope / 42
				{ 5, 3979 }, -- Accurate Scope / 36
				{ 6, 3978 }, -- Standard Scope / 22
				{ 7, 3977 }, -- Crude Scope / 12
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 22795 }, -- Core Marksman Rifle / 65
				{ 2, 1306547 }, -- Hyper Deluxe Sniper Rifle Mk XVII / 65
				{ 3, 19833 }, -- Flawless Arcanite Rifle / 61
				{ 4, 19796 }, -- Dark Iron Rifle / 55
				{ 5, 19792 }, -- Thorium Rifle / 52
				{ 6, 12614 }, -- Mithril Heavy-bore Rifle / 44
				{ 7, 12595 }, -- Mithril Blunderbuss / 41
				{ 8, 3954 }, -- Moonsight Rifle / 29
				{ 9, 3949 }, -- Silver-plated Shotgun / 26
				{ 10, 3939 }, -- Lovingly Crafted Boomstick / 24
				{ 11, 3936 }, -- Deadly Blunderbuss / 21
				{ 12, 3925 }, -- Rough Boomstick / 10
			},
		},
		{
			name = ALIL["Projectile"].." - "..ALIL["Bullet"],
			[NORMAL_DIFF] = {
				{ 1, 1293849 }, -- Swiftfeather Arrow / 65
				{ 2, 1293850 }, -- Swiftstrike Shot / 65
				{ 3, 19800 }, -- Thorium Shells / 57
				{ 4, 1266928 }, -- EZ-Thro Shell / 57
				{ 5, 12621 }, -- Mithril Gyro-Shot / 49
				{ 6, 12719 }, -- Explosive Arrow / 42
				{ 7, 12596 }, -- Hi-Impact Mithril Slugs / 42
				{ 8, 3947 }, -- Crafted Solid Shot / 35
				{ 9, 3930 }, -- Crafted Heavy Shot / 20
				{ 10, 3920 }, -- Crafted Light Shot / 10
			},
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 1266935 }, -- Ultrasafe Rechargeable Battery / 60
				{ 2, 19815 }, -- Delicate Arcanite Converter / 58
				{ 3, 1266926 }, -- SAF-T Tube / 55
				{ 4, 19791 }, -- Thorium Widget / 52
				{ 5, 23071 }, -- Truesilver Transformer / 50
				{ 6, 19788 }, -- Dense Blasting Powder / 50
				{ 7, 1266921 }, -- EZ-Thro Tru-Trigger / 48
				{ 8, 1249634 }, -- Sandpaper / 45
				{ 9, 12599 }, -- Mithril Casing / 43
				{ 10, 1266917 }, -- SAF-T Casing / 43
				{ 11, 435956 }, -- Polished Truesilver Gears / 40
				{ 12, 12591 }, -- Unstable Trigger / 40
				{ 13, 19795 }, -- Thorium Tube / 39
				{ 14, 12589 }, -- Mithril Tube / 39
				{ 15, 1266914 }, -- EZ-Thro Fireproof Fuse / 39
				{ 16, 12585 }, -- Solid Blasting Powder / 35
				{ 17, 3961 }, -- Gyrochronatom / 34
				{ 18, 3958 }, -- Iron Strut / 32
				{ 19, 12584 }, -- Gold Power Core / 30
				{ 20, 3953 }, -- Bronze Framework / 29
				{ 21, 1266909 }, -- No Slip SAF-T Padding / 29
				{ 22, 3945 }, -- Heavy Blasting Powder / 25
				{ 23, 3942 }, -- Whirring Bronze Gizmo / 25
				{ 24, 3938 }, -- Bronze Tube / 21
				{ 25, 3973 }, -- Silver Contact / 18
				{ 26, 1266907 }, -- EZ-Thro Wrap / 15
				{ 27, 3929 }, -- Coarse Blasting Powder / 15
				{ 28, 3926 }, -- Copper Modulator / 13
				{ 29, 3924 }, -- Copper Tube / 10
				{ 30, 3922 }, -- Handful of Copper Bolts / 8
				{ 101, 1266893 }, -- SAF-T Tabs / 5
				{ 102, 3918 }, -- Rough Blasting Powder / 5
			},
		},
		{
			name = AL["Fireworks"],
			[NORMAL_DIFF] = {
				{ 1, 26443 }, -- Cluster Launcher / 295
				{ 2, 26426 }, -- Large Blue Rocket Cluster / 275
				{ 3, 26427 }, -- Large Green Rocket Cluster / 275
				{ 4, 1319163 }, -- Large Purple Rocket Cluster / 275
				{ 5, 26428 }, -- Large Red Rocket Cluster / 275
				{ 6, 1319164 }, -- Large White Rocket Cluster / 275
				{ 7, 1319165 }, -- Large Yellow Rocket Cluster / 275
				{ 8, 23507 }, -- Snake Burst Firework / 50
				{ 9, 26442 }, -- Firework Launcher / 245
				{ 10, 26423 }, -- Blue Rocket Cluster / 225
				{ 11, 26424 }, -- Green Rocket Cluster / 225
				{ 12, 1319160 }, -- Purple Rocket Cluster / 225
				{ 13, 26425 }, -- Red Rocket Cluster / 225
				{ 14, 1319161 }, -- White Rocket Cluster / 225
				{ 15, 1319162 }, -- Yellow Rocket Cluster / 225
				{ 16, 26420 }, -- Large Blue Rocket / 175
				{ 17, 26421 }, -- Large Green Rocket / 175
				{ 18, 1319157 }, -- Large Purple Rocket / 175
				{ 19, 26422 }, -- Large Red Rocket / 175
				{ 20, 1319158 }, -- Large White Rocket / 175
				{ 21, 1319159 }, -- Large Yellow Rocket / 175
				{ 22, 26416 }, -- Small Blue Rocket / 125
				{ 23, 26417 }, -- Small Green Rocket / 125
				{ 24, 1319154 }, -- Small Purple Rocket / 125
				{ 25, 26418 }, -- Small Red Rocket / 125
				{ 26, 1319155 }, -- Small White Rocket / 125
				{ 27, 1319156 }, -- Small Yellow Rocket / 125
				{ 28, 23067 }, -- Blue Firework / 20
				{ 29, 23068 }, -- Green Firework / 20
				{ 30, 23066 }, -- Red Firework / 20
			},
		},
		{
			name = AL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 19831 }, -- Arcane Bomb / 60
				{ 2, 1266930 }, -- EZ-Thro Dark Bomb / 60
				{ 3, 1266931 }, -- EZ-Thro Mana Bomb / 60
				{ 4, 19799 }, -- Dark Iron Bomb / 57
				{ 5, 1317961 }, -- Satchel of Dark Iron Bombs / 57
				{ 6, 1266929 }, -- EZ-Thro Thorium Grenade / 57
				{ 7, 19790 }, -- Thorium Grenade / 52
				{ 8, 1317270 }, -- Unsanctified Grenade / 52
				{ 9, 1266927 }, -- SAF-T Clever Dynamite / 50
				{ 10, 1266922 }, -- Tru-Trigger Frag Bomb / 48
				{ 11, 1266918 }, -- SAF-T Bomb / 48
				{ 12, 12619 }, -- Hi-Explosive Bomb / 47
				{ 13, 1317960 }, -- Satchel of Iron Bombs / 46
				{ 14, 23070 }, -- Dense Dynamite / 45
				{ 15, 12754 }, -- The Big One / 45
				{ 16, 12603 }, -- Mithril Frag Bomb / 43
				{ 17, 3967 }, -- Big Iron Bomb / 43
				{ 18, 12760 }, -- Goblin Sapper Charge / 41
				{ 19, 1266916 }, -- EZ-Thro Grenade / 40
				{ 20, 23069 }, -- Ez-Thro Dynamite II / 40
				{ 21, 3968 }, -- Goblin Land Mine / 39
				{ 22, 8243 }, -- Flash Bomb / 37
				{ 23, 3962 }, -- Iron Grenade / 35
				{ 24, 12586 }, -- Solid Dynamite / 35
				{ 25, 1266911 }, -- SAF-T Jumbo Dynamite / 35
				{ 26, 1266910 }, -- SAF-T Bronze Bomb / 34
				{ 27, 1317959 }, -- Satchel of Bronze Bombs / 33
				{ 28, 3950 }, -- Big Bronze Bomb / 33
				{ 29, 1266908 }, -- EZ-Thro Copper Bomb XL / 31
				{ 30, 3955 }, -- Explosive Sheep / 30
				{ 101, 3946 }, -- Heavy Dynamite / 30
				{ 102, 3941 }, -- Small Bronze Bomb / 29
				{ 103, 3937 }, -- Large Copper Bomb / 26
				{ 104, 8339 }, -- Ez-Thro Dynamite / 25
				{ 105, 1266905 }, -- SAF-T Dynamite / 25
				{ 106, 3931 }, -- Coarse Dynamite / 20
				{ 107, 1266906 }, -- SAF-T Copper Bomb / 19
				{ 108, 1317958 }, -- Satchel of Copper Bombs / 18
				{ 109, 3923 }, -- Rough Copper Bomb / 14
				{ 110, 3919 }, -- Rough Dynamite / 10
			},
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 19793 }, -- Lifelike Mechanical Toad / 53
				{ 2, 1266920 }, -- Compact Critter Carrier / 45
				{ 3, 15633 }, -- Lil' Smoky / 41
				{ 4, 15628 }, -- Pet Bombling / 41
				{ 5, 1266913 }, -- Shafety Sheep / 35
				{ 6, 3928 }, -- Mechanical Squirrel Box / 15
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 1266938 }, -- Ultralight Goblin Glider / 320
				{ 2, 1266936 }, -- Dimensional Transporter - Mt. Hyjal / 60
				{ 3, 1266939 }, -- Gnomish Weather Machine NYI / 60
				{ 4, 1266940 }, -- Stealthman 52 / 60
				{ 5, 22704 }, -- Field Repair Bot 74A / 60
				{ 6, 26011 }, -- Tranquil Mechanical Yeti / 60
				{ 7, 1263083 }, -- Anarchist's Workbench / 60
				{ 8, 28327 }, -- Steam Tonk Controller / 55
				{ 9, 19814 }, -- Masterwork Target Dummy / 55
				{ 10, 1266925 }, -- Loot-A-Rang / 55
				{ 11, 23080 }, -- Powerful Seaforium Charge / 55
				{ 12, 1226209 }, -- Tinkerbox: Magnetic Displacement / 270
				{ 13, 1226208 }, -- Tinkerbox: Nitro Boosts / 270
				{ 14, 1226207 }, -- Tinkerbox: Teleport / 270
				{ 15, 23096 }, -- Gnomish Alarm-O-Bot / 53
				{ 16, 1226206 }, -- Tinkerbox / 260
				{ 17, 1228088 }, -- Pop-Up Shrub / 255
				{ 18, 19567 }, -- Salt Shaker / 50
				{ 19, 23129 }, -- World Enlarger / 50
				{ 20, 1266924 }, -- Gnomish Army Knife / 50
				{ 21, 12715 }, -- Recipe: Goblin Rocket Fuel / 42
				{ 22, 431362 }, -- Soul Vessel / 205
				{ 23, 12900 }, -- Mobile Alarm / 41
				{ 24, 12895 }, -- Plans: Inlaid Mithril Cylinder / 40
				{ 25, 3972 }, -- Large Seaforium Charge / 40
				{ 26, 15255 }, -- Mechanical Repair Kit / 40
				{ 27, 1286792 }, -- Centaur Banner Deployment Device / 190
				{ 28, 21940 }, -- Snowmaster 9000 / 38
				{ 29, 3965 }, -- Advanced Target Dummy / 37
				{ 30, 3963 }, -- Compact Harvest Reaper Kit / 35
				{ 101, 12590 }, -- Gyromatic Micro-Adjustor / 35
				{ 102, 1266912 }, -- SAF-T Bell / 35
				{ 103, 3960 }, -- Portable Bronze Mortar / 33
				{ 104, 3959 }, -- Discombobulator Ray / 32
				{ 105, 3957 }, -- Ice Deflector / 31
				{ 106, 9271 }, -- Aquadynamic Fish Attractor / 30
				{ 107, 1286796 }, -- Hoof-Shaped Foot Pedal / 150
				{ 108, 1263034 }, -- Repair Bot / 28
				{ 109, 6458 }, -- Ornate Spyglass / 27
				{ 110, 424641 }, -- Shredder Autosalvage Unit / 135
				{ 111, 3944 }, -- Flame Deflector / 25
				{ 112, 3933 }, -- Small Seaforium Charge / 20
				{ 113, 8334 }, -- Practice Lock / 20
				{ 114, 3932 }, -- Target Dummy / 17
				{ 115, 1302161 }, -- Harvester Override Signalcaster / 15
				{ 116, 7430 }, -- Arclight Spanner / 10
				{ 117, 1230656 }, -- Reagent Bot / 4
			},
		},
	}
}

data["Tailoring"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 28208 }, -- Glacial Cloak / 80
				{ 2, 28210 }, -- Gaea's Embrace / 70
				{ 3, 1306544 }, -- Cloak of Earth and Sky / 65
				{ 4, 1306543 }, -- Fel Cape / 65
				{ 5, 22870 }, -- Cloak of Warding / 62
				{ 6, 18422 }, -- Cloak of Fire / 55
				{ 7, 18420 }, -- Brightcloth Cloak / 55
				{ 8, 18418 }, -- Cindercloth Cloak / 55
				{ 9, 18409 }, -- Runecloth Cloak / 53
				{ 10, 3862 }, -- Icy Cloak / 40
				{ 11, 3861 }, -- Long Silken Cloak / 37
				{ 12, 8789 }, -- Crimson Silk Cloak / 36
				{ 13, 8786 }, -- Azure Silk Cloak / 35
				{ 14, 3844 }, -- Heavy Woolen Cloak / 21
				{ 15, 6521 }, -- Pearl-clasped Cloak / 19
				{ 16, 2402 }, -- Woolen Cape / 16
				{ 17, 2397 }, -- Reinforced Linen Cape / 12
				{ 18, 2387 }, -- Linen Cloak / 6
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 28481 }, -- Sylvan Crown / 70
				{ 2, 18452 }, -- Mooncloth Circlet / 62
				{ 3, 1257494 }, -- Earthenweave Crown / 61
				{ 4, 1257493 }, -- Ghostweave Hood / 61
				{ 5, 18450 }, -- Wizardweave Turban / 61
				{ 6, 18444 }, -- Runecloth Headband / 59
				{ 7, 18442 }, -- Felcloth Hood / 58
				{ 8, 12092 }, -- Dreamweave Circlet / 50
				{ 9, 12086 }, -- Shadoweave Mask / 49
				{ 10, 12081 }, -- Admiral's Hat / 48
				{ 11, 12084 }, -- Red Mageweave Headband / 48
				{ 12, 12083 }, -- Stormcloth Headband / 48
				{ 13, 12072 }, -- Black Mageweave Headband / 46
				{ 14, 12059 }, -- White Bandit Mask / 43
				{ 15, 1257433 }, -- Earthen Silk Hood / 37
				{ 16, 1301540 }, -- Azure Stormsewn Cowl / 35
				{ 17, 1301532 }, -- Cloudy Stormsewn Cowl / 35
				{ 18, 3858 }, -- Shadow Hood / 34
				{ 19, 3857 }, -- Enchanter's Cowl / 33
				{ 20, 8762 }, -- Silk Headband / 32
				{ 21, 1257415 }, -- Filigreed Flame Circlet / 30
				{ 22, 1257417 }, -- Filigreed Pearly Circlet / 30
				{ 23, 1257413 }, -- Filigreed Pristine Circlet / 30
				{ 24, 1257416 }, -- Filigreed Shadow Circlet / 30
				{ 25, 1257418 }, -- Filigreed Shining Circlet / 30
				{ 26, 1257414 }, -- Filigreed Silky Circlet / 30
				{ 27, 8760 }, -- Azure Silk Hood / 29
				{ 28, 1257402 }, -- Flame Circlet / 25
				{ 29, 1257404 }, -- Pearly Circlet / 25
				{ 30, 1257400 }, -- Pristine Circlet / 25
				{ 101, 1257403 }, -- Shadow Circlet / 25
				{ 102, 1257405 }, -- Shining Circlet / 25
				{ 103, 1257401 }, -- Silky Circlet / 25
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 28482 }, -- Sylvan Shoulders / 70
				{ 2, 18453 }, -- Felcloth Shoulders / 62
				{ 3, 20848 }, -- Flarecore Mantle / 61
				{ 4, 23665 }, -- Argent Shoulders / 61
				{ 5, 23663 }, -- Mantle of the Timbermaw / 61
				{ 6, 18448 }, -- Mooncloth Shoulders / 61
				{ 7, 18449 }, -- Runecloth Shoulders / 61
				{ 8, 1257489 }, -- Ghostweave Mantle / 59
				{ 9, 1257485 }, -- Earthenweave Mantle / 57
				{ 10, 12087 }, -- Stormcloth Shoulders / 49
				{ 11, 1257452 }, -- Netherflame Shoulders / 47
				{ 12, 1257451 }, -- Netherfroth Shoulders / 47
				{ 13, 1257450 }, -- Nethergeld Shoulders / 47
				{ 14, 1257455 }, -- Netherlight Shoulders / 47
				{ 15, 1257453 }, -- Netherpearl Shoulders / 47
				{ 16, 1257454 }, -- Nethershine Shoulders / 47
				{ 17, 12078 }, -- Red Mageweave Shoulders / 47
				{ 18, 12076 }, -- Shadoweave Shoulders / 47
				{ 19, 12074 }, -- Black Mageweave Shoulders / 46
				{ 20, 1257442 }, -- Earthen Silk Shoulders / 41
				{ 21, 8795 }, -- Azure Shoulders / 38
				{ 22, 8793 }, -- Crimson Silk Shoulders / 38
				{ 23, 8774 }, -- Green Silken Shoulders / 36
				{ 24, 1301541 }, -- Azure Stormsewn Epaulets / 35
				{ 25, 1301533 }, -- Cloudy Stormsewn Epaulets / 35
				{ 26, 435848 }, -- Invoker's Mantle / 30
				{ 27, 3849 }, -- Reinforced Woolen Shoulders / 24
				{ 28, 3848 }, -- Double-Stitched Woolen Shoulders / 22
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, 28207 }, -- Glacial Vest / 80
				{ 2, 28480 }, -- Sylvan Vest / 70
				{ 3, 23666 }, -- Flarecore Robe / 66
				{ 4, 24091 }, -- Bloodvine Vest / 65
				{ 5, 1306540 }, -- Robes of Fiery Devastation / 65
				{ 6, 18457 }, -- Robe of the Archmage / 62
				{ 7, 18458 }, -- Robe of the Void / 62
				{ 8, 18456 }, -- Truefaith Vestments / 62
				{ 9, 22902 }, -- Mooncloth Robe / 61
				{ 10, 18451 }, -- Felcloth Robe / 61
				{ 11, 18447 }, -- Mooncloth Vest / 60
				{ 12, 18446 }, -- Wizardweave Robe / 60
				{ 13, 1257486 }, -- Earthenweave Vest / 59
				{ 14, 18436 }, -- Robe of Winter Night / 57
				{ 15, 18416 }, -- Ghostweave Vest / 55
				{ 16, 18414 }, -- Brightcloth Robe / 54
				{ 17, 18408 }, -- Cindercloth Vest / 52
				{ 18, 18406 }, -- Runecloth Robe / 52
				{ 19, 18407 }, -- Runecloth Tunic / 52
				{ 20, 18404 }, -- Frostweave Robe / 51
				{ 21, 18403 }, -- Frostweave Tunic / 51
				{ 22, 44950 }, -- Green Winter Clothes / 250
				{ 23, 44958 }, -- Red Winter Clothes / 250
				{ 24, 12077 }, -- Simple Black Dress / 47
				{ 25, 12070 }, -- Dreamweave Vest / 45
				{ 26, 12069 }, -- Cindercloth Robe / 45
				{ 27, 12068 }, -- Stormcloth Vest / 45
				{ 28, 26403 }, -- Festival Dress / 220
				{ 29, 26407 }, -- Festival Suit / 220
				{ 30, 12056 }, -- Red Mageweave Vest / 43
				{ 101, 12055 }, -- Shadoweave Robe / 43
				{ 102, 12050 }, -- Black Mageweave Robe / 42
				{ 103, 12048 }, -- Black Mageweave Vest / 41
				{ 104, 8802 }, -- Crimson Silk Robe / 41
				{ 105, 8770 }, -- Robe of Power / 38
				{ 106, 8791 }, -- Crimson Silk Vest / 37
				{ 107, 12093 }, -- Tuxedo Jacket / 35
				{ 108, 12091 }, -- White Wedding Dress / 35
				{ 109, 8764 }, -- Earthen Vest / 34
				{ 110, 8784 }, -- Green Silk Armor / 33
				{ 111, 3859 }, -- Azure Silk Vest / 30
				{ 112, 6692 }, -- Robes of Arcana / 30
				{ 113, 1257408 }, -- Flame Gown / 27
				{ 114, 1257410 }, -- Pearly Gown / 27
				{ 115, 1257406 }, -- Pristine Gown / 27
				{ 116, 1257409 }, -- Shadow Gown / 27
				{ 117, 1257411 }, -- Shining Gown / 27
				{ 118, 1257407 }, -- Silky Gown / 27
				{ 119, 6690 }, -- Lesser Wizard's Robe / 27
				{ 120, 7643 }, -- Greater Adept's Robe / 23
				{ 121, 8467 }, -- White Woolen Dress / 22
				{ 122, 2403 }, -- Gray Woolen Robe / 21
				{ 123, 7639 }, -- Blue Overalls / 20
				{ 124, 1257378 }, -- Filigreed Flame Gown / 20
				{ 125, 1257380 }, -- Filigreed Pearly Gown / 20
				{ 126, 1257376 }, -- Filigreed Pristine Gown / 20
				{ 127, 1257379 }, -- Filigreed Shadow Gown / 20
				{ 128, 1257381 }, -- Filigreed Shining Gown / 20
				{ 129, 1257377 }, -- Filigreed Silky Gown / 20
				{ 130, 7636 }, -- Green Woolen Robe / 18
				{ 201, 2399 }, -- Green Woolen Vest / 17
				{ 202, 7633 }, -- Blue Linen Robe / 14
				{ 203, 2395 }, -- Barbaric Linen Vest / 14
				{ 204, 1301463 }, -- Azure Stormsewn Vest / 12
				{ 205, 1301439 }, -- Cloudy Stormsewn Vest / 12
				{ 206, 7630 }, -- Blue Linen Vest / 12
				{ 207, 7629 }, -- Red Linen Vest / 12
				{ 208, 7623 }, -- Brown Linen Robe / 10
				{ 209, 2389 }, -- Red Linen Robe / 10
				{ 210, 7624 }, -- White Linen Robe / 10
				{ 211, 8465 }, -- Simple Dress / 10
				{ 212, 2385 }, -- Brown Linen Vest / 8
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 24093 }, -- Bloodvine Boots / 65
				{ 2, 1306542 }, -- Rime-encrusted Boots / 65
				{ 3, 24903 }, -- Runed Stygian Boots / 63
				{ 4, 1257490 }, -- Ghostweave Boots / 60
				{ 5, 1297125 }, -- Swarmtender's Footpads / 58
				{ 6, 1297122 }, -- Venomspew Footpads / 58
				{ 7, 23664 }, -- Argent Boots / 58
				{ 8, 18437 }, -- Felcloth Boots / 57
				{ 9, 19435 }, -- Mooncloth Boots / 56
				{ 10, 18423 }, -- Runecloth Boots / 56
				{ 11, 1257482 }, -- Black Sandals / 55
				{ 12, 1257481 }, -- Fiery Sandals / 55
				{ 13, 1257480 }, -- Frothing Sandals / 55
				{ 14, 1257479 }, -- Gilded Sandals / 55
				{ 15, 1257483 }, -- Golden Sandals / 55
				{ 16, 1257484 }, -- Radiant Sandals / 55
				{ 17, 1257472 }, -- Earthenweave Boots / 54
				{ 18, 12090 }, -- Stormcloth Boots / 50
				{ 19, 12088 }, -- Cindercloth Boots / 49
				{ 20, 12082 }, -- Shadoweave Boots / 48
				{ 21, 12073 }, -- Black Mageweave Boots / 46
				{ 22, 1257432 }, -- Earthen Silk Slippers / 36
				{ 23, 3860 }, -- Boots of the Enchanter / 35
				{ 24, 1257429 }, -- Black Slippers / 35
				{ 25, 1257428 }, -- Fiery Slippers / 35
				{ 26, 1257427 }, -- Frothing Slippers / 35
				{ 27, 1257426 }, -- Gilded Slippers / 35
				{ 28, 1257430 }, -- Golden Slippers / 35
				{ 29, 1257431 }, -- Radiant Slippers / 35
				{ 30, 8778 }, -- Boots of Darkness / 28
				{ 101, 3856 }, -- Spider Silk Slippers / 28
				{ 102, 3855 }, -- Spidersilk Boots / 25
				{ 103, 3847 }, -- Red Woolen Boots / 20
				{ 104, 2401 }, -- Woolen Boots / 19
				{ 105, 1257372 }, -- Flame Boots / 17
				{ 106, 1257374 }, -- Pearly Boots / 17
				{ 107, 1257370 }, -- Pristine Boots / 17
				{ 108, 1257373 }, -- Shadow Boots / 17
				{ 109, 1257375 }, -- Shining Boots / 17
				{ 110, 1257371 }, -- Silky Boots / 17
				{ 111, 3845 }, -- Soft-soled Linen Boots / 16
				{ 112, 2386 }, -- Linen Boots / 13
				{ 113, 1301469 }, -- Azure Stormsewn Shoes / 11
				{ 114, 1301444 }, -- Cloudy Stormsewn Shoes / 11
				{ 115, 12045 }, -- Simple Linen Boots / 9
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 28205 }, -- Glacial Gloves / 80
				{ 2, 20849 }, -- Flarecore Gloves / 62
				{ 3, 18454 }, -- Gloves of Spell Mastery / 62
				{ 4, 22867 }, -- Felcloth Gloves / 62
				{ 5, 22868 }, -- Inferno Gloves / 62
				{ 6, 22869 }, -- Mooncloth Gloves / 62
				{ 7, 1297123 }, -- Swarmtender's Gloves / 58
				{ 8, 1297120 }, -- Venomspew Gloves / 58
				{ 9, 18417 }, -- Runecloth Gloves / 55
				{ 10, 1257476 }, -- Black Gloves / 55
				{ 11, 1257475 }, -- Fiery Gloves / 55
				{ 12, 1257474 }, -- Frothing Gloves / 55
				{ 13, 1257473 }, -- Gilded Gloves / 55
				{ 14, 1257477 }, -- Golden Gloves / 55
				{ 15, 1257478 }, -- Radiant Gloves / 55
				{ 16, 18415 }, -- Brightcloth Gloves / 54
				{ 17, 18412 }, -- Cindercloth Gloves / 54
				{ 18, 18413 }, -- Ghostweave Gloves / 54
				{ 19, 18411 }, -- Frostweave Gloves / 53
				{ 20, 1257463 }, -- Earthenweave Gloves / 52
				{ 21, 12067 }, -- Dreamweave Gloves / 45
				{ 22, 12066 }, -- Red Mageweave Gloves / 45
				{ 23, 12071 }, -- Shadoweave Gloves / 45
				{ 24, 12063 }, -- Stormcloth Gloves / 44
				{ 25, 12053 }, -- Black Mageweave Gloves / 43
				{ 26, 8804 }, -- Crimson Silk Gloves / 42
				{ 27, 1257439 }, -- Black Handwraps / 40
				{ 28, 1257438 }, -- Fiery Handwraps / 40
				{ 29, 1257437 }, -- Frothing Handwraps / 40
				{ 30, 1257436 }, -- Gilded Handwraps / 40
				{ 101, 1257440 }, -- Golden Handwraps / 40
				{ 102, 1257441 }, -- Radiant Handwraps / 40
				{ 103, 1257434 }, -- Earthen Silk Gloves / 39
				{ 104, 8782 }, -- Truefaith Gloves / 30
				{ 105, 3854 }, -- Azure Silk Gloves / 29
				{ 106, 8780 }, -- Hands of Darkness / 29
				{ 107, 3852 }, -- Gloves of Meditation / 26
				{ 108, 3868 }, -- Phoenix Gloves / 25
				{ 109, 1257384 }, -- Flame Gloves / 20
				{ 110, 1257386 }, -- Pearly Gloves / 20
				{ 111, 1257382 }, -- Pristine Gloves / 20
				{ 112, 1257385 }, -- Shadow Gloves / 20
				{ 113, 1257387 }, -- Shining Gloves / 20
				{ 114, 1257383 }, -- Silky Gloves / 20
				{ 115, 3843 }, -- Heavy Woolen Gloves / 17
				{ 116, 1301465 }, -- Azure Stormsewn Handwraps / 11
				{ 117, 1301441 }, -- Cloudy Stormsewn Handwraps / 11
				{ 118, 3840 }, -- Heavy Linen Gloves / 10
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 23667 }, -- Flarecore Leggings / 70
				{ 2, 24092 }, -- Bloodvine Leggings / 65
				{ 3, 24901 }, -- Runed Stygian Leggings / 63
				{ 4, 18440 }, -- Mooncloth Leggings / 58
				{ 5, 18439 }, -- Brightcloth Pants / 58
				{ 6, 1257488 }, -- Earthenweave Leggings / 58
				{ 7, 18441 }, -- Ghostweave Pants / 58
				{ 8, 18438 }, -- Runecloth Pants / 57
				{ 9, 18434 }, -- Cindercloth Pants / 56
				{ 10, 18424 }, -- Frostweave Pants / 56
				{ 11, 18419 }, -- Felcloth Pants / 55
				{ 12, 18421 }, -- Wizardweave Leggings / 55
				{ 13, 12062 }, -- Stormcloth Pants / 44
				{ 14, 12060 }, -- Red Mageweave Pants / 43
				{ 15, 12052 }, -- Shadoweave Pants / 42
				{ 16, 12049 }, -- Black Mageweave Leggings / 41
				{ 17, 8799 }, -- Crimson Silk Pantaloons / 39
				{ 18, 12089 }, -- Tuxedo Pants / 35
				{ 19, 1257425 }, -- Earthen Leggings / 35
				{ 20, 1257421 }, -- Flame Leggings / 30
				{ 21, 1257423 }, -- Pearly Leggings / 30
				{ 22, 1257419 }, -- Pristine Leggings / 30
				{ 23, 1257422 }, -- Shadow Leggings / 30
				{ 24, 1257424 }, -- Shining Leggings / 30
				{ 25, 1257420 }, -- Silky Leggings / 30
				{ 26, 8758 }, -- Azure Silk Pants / 28
				{ 27, 3851 }, -- Phoenix Pants / 25
				{ 28, 1257396 }, -- Filigreed Flame Leggings / 25
				{ 29, 1257398 }, -- Filigreed Pearly Leggings / 25
				{ 30, 1257394 }, -- Filigreed Pristine Leggings / 25
				{ 101, 1257397 }, -- Filigreed Shadow Leggings / 25
				{ 102, 1257399 }, -- Filigreed Shining Leggings / 25
				{ 103, 1257395 }, -- Filigreed Silky Leggings / 25
				{ 104, 3850 }, -- Heavy Woolen Pants / 22
				{ 105, 12047 }, -- Colorful Kilt / 19
				{ 106, 12046 }, -- Simple Kilt / 15
				{ 107, 3842 }, -- Handstitched Linen Britches / 14
				{ 108, 1301468 }, -- Azure Stormsewn Leggings / 12
				{ 109, 1301443 }, -- Cloudy Stormsewn Leggings / 12
				{ 110, 3914 }, -- Brown Linen Pants / 10
				{ 111, 12044 }, -- Simple Linen Pants / 7
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Body"],
			[NORMAL_DIFF] = {
				{ 1, 12080 }, -- Pink Mageweave Shirt / 47
				{ 2, 12075 }, -- Lavender Mageweave Shirt / 46
				{ 3, 12061 }, -- Orange Mageweave Shirt / 43
				{ 4, 12085 }, -- Tuxedo Shirt / 205
				{ 5, 12064 }, -- Orange Martial Shirt / 40
				{ 6, 3873 }, -- Black Swashbuckler's Shirt / 40
				{ 7, 21945 }, -- Green Holiday Shirt / 40
				{ 8, 3872 }, -- Rich Purple Silk Shirt / 37
				{ 9, 8489 }, -- Red Swashbuckler's Shirt / 35
				{ 10, 3871 }, -- Formal White Shirt / 34
				{ 11, 8483 }, -- White Swashbuckler's Shirt / 32
				{ 12, 3870 }, -- Dark Silk Shirt / 31
				{ 13, 3869 }, -- Bright Yellow Shirt / 27
				{ 14, 7892 }, -- Stylish Blue Shirt / 25
				{ 15, 7893 }, -- Stylish Green Shirt / 25
				{ 16, 3866 }, -- Stylish Red Shirt / 22
				{ 17, 2406 }, -- Gray Woolen Shirt / 20
				{ 18, 2396 }, -- Green Linen Shirt / 14
				{ 19, 2394 }, -- Blue Linen Shirt / 10
				{ 20, 2392 }, -- Red Linen Shirt / 10
				{ 21, 3915 }, -- Brown Linen Shirt / 7
				{ 22, 2393 }, -- White Linen Shirt / 7
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 1306541 }, -- Mana-infused Cord / 65
				{ 2, 24902 }, -- Runed Stygian Belt / 63
				{ 3, 22866 }, -- Belt of the Archmage / 62
				{ 4, 1297124 }, -- Swarmtender's Cord / 58
				{ 5, 1297121 }, -- Venomspew Cord / 58
				{ 6, 23662 }, -- Wisdom of the Timbermaw / 58
				{ 7, 18410 }, -- Ghostweave Belt / 53
				{ 8, 1257469 }, -- Black Waistcord / 52
				{ 9, 1257468 }, -- Fiery Waistcord / 52
				{ 10, 1257467 }, -- Frothing Waistcord / 52
				{ 11, 1257466 }, -- Gilded Waistcord / 52
				{ 12, 1257470 }, -- Golden Waistcord / 52
				{ 13, 1257471 }, -- Radiant Waistcord / 52
				{ 14, 1257464 }, -- Earthenweave Cord / 52
				{ 15, 1257462 }, -- Ghostweave Cord / 52
				{ 16, 18402 }, -- Runecloth Belt / 51
				{ 17, 1257447 }, -- Black Cord / 45
				{ 18, 1257446 }, -- Fiery Cord / 45
				{ 19, 1257445 }, -- Frothing Cord / 45
				{ 20, 1257444 }, -- Gilded Cord / 45
				{ 21, 1257448 }, -- Golden Cord / 45
				{ 22, 1257449 }, -- Radiant Cord / 45
				{ 23, 3864 }, -- Star Belt / 40
				{ 24, 8797 }, -- Earthen Silk Belt / 39
				{ 25, 3863 }, -- Spider Belt / 36
				{ 26, 8766 }, -- Azure Silk Belt / 35
				{ 27, 8772 }, -- Crimson Silk Belt / 35
				{ 28, 435841 }, -- Invoker's Cord / 30
				{ 29, 1257390 }, -- Flame Sash / 22
				{ 30, 1257392 }, -- Pearly Sash / 22
				{ 101, 1257388 }, -- Pristine Sash / 22
				{ 102, 1257391 }, -- Shadow Sash / 22
				{ 103, 1257393 }, -- Shining Sash / 22
				{ 104, 1257389 }, -- Silky Sash / 22
				{ 105, 1257368 }, -- Novice Arcanist's Sash / 15
				{ 106, 1257369 }, -- Novice Ardent's Sash / 15
				{ 107, 1301466 }, -- Azure Stormsewn Cord / 10
				{ 108, 1301442 }, -- Cloudy Stormsewn Cord / 10
				{ 109, 8776 }, -- Linen Belt / 9
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 28209 }, -- Glacial Wrists / 80
				{ 2, 22759 }, -- Flarecore Wraps / 64
				{ 3, 1257491 }, -- Earthenweave Cuffs / 60
				{ 4, 1257487 }, -- Runecloth Cuffs / 59
				{ 5, 1257458 }, -- Netherflame Cuffs / 50
				{ 6, 1257457 }, -- Netherfroth Cuffs / 50
				{ 7, 1257456 }, -- Nethergeld Cuffs / 50
				{ 8, 1257461 }, -- Netherlight Cuffs / 50
				{ 9, 1257459 }, -- Netherpearl Cuffs / 50
				{ 10, 1257460 }, -- Nethershine Cuffs / 50
				{ 11, 1257435 }, -- Earthen Silk Cuffs / 40
				{ 12, 428424 }, -- Phoenix Bindings / 30
				{ 13, 3841 }, -- Green Linen Bracers / 12
				{ 14, 1301464 }, -- Azure Stormsewn Cuffs / 10
				{ 15, 1301440 }, -- Cloudy Stormsewn Cuffs / 10
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 1306545 }, -- Felblood Soul Bag / 65
				{ 2, 27660 }, -- Big Bag of Enchantment / 65
				{ 3, 27725 }, -- Satchel of Cenarius / 65
				{ 4, 18455 }, -- Bottomless Bag / 62
				{ 5, 1257495 }, -- Bottomless Reagent Bag / 62
				{ 6, 26087 }, -- Core Felcloth Bag / 60
				{ 7, 461727 }, -- Leather-Reinforced Runecloth Bag / 60
				{ 8, 1227724 }, -- Crimson Dawnwoven Bag / 300
				{ 9, 18445 }, -- Mooncloth Bag / 60
				{ 10, 1257492 }, -- Mooncloth Reagent Bag / 60
				{ 11, 26086 }, -- Felcloth Bag / 57
				{ 12, 27724 }, -- Cenarion Herb Bag / 55
				{ 13, 27659 }, -- Enchanted Runecloth Bag / 55
				{ 14, 1227723 }, -- Crusader's Knapsack / 260
				{ 15, 26085 }, -- Soul Pouch / 52
				{ 16, 18405 }, -- Runecloth Bag / 52
				{ 17, 1257465 }, -- Runecloth Reagent Bag / 52
				{ 18, 27658 }, -- Enchanted Mageweave Pouch / 45
				{ 19, 12079 }, -- Red Mageweave Bag / 35
				{ 20, 12065 }, -- Mageweave Bag / 35
				{ 21, 1257443 }, -- Mageweave Reagent Bag / 35
				{ 22, 6695 }, -- Black Silk Pack / 25
				{ 23, 6693 }, -- Green Silk Pack / 25
				{ 24, 3813 }, -- Small Silk Pack / 25
				{ 25, 1257412 }, -- Silk Reagent Bag / 25
				{ 26, 6688 }, -- Red Woolen Bag / 15
				{ 27, 3758 }, -- Green Woolen Bag / 15
				{ 28, 3757 }, -- Woolen Bag / 15
				{ 29, 1257017 }, -- Woolen Reagent Bag / 15
				{ 30, 6686 }, -- Red Linen Bag / 5
				{ 101, 3755 }, -- Linen Bag / 5
				{ 102, 1257013 }, -- Linen Reagent Bag / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 1263080 }, -- Loom / 60
				{ 2, 22813 }, -- Gordok Ogre Suit / 55
				{ 3, 18560 }, -- Mooncloth / 55
				{ 4, 18401 }, -- Bolt of Runecloth / 55
				{ 5, 3865 }, -- Bolt of Mageweave / 45
				{ 6, 435827 }, -- Hyperconductive Arcano-Filament / 40
				{ 7, 3839 }, -- Bolt of Silk Cloth / 35
				{ 8, 1263032 }, -- Spinning Wheel / 28
				{ 9, 2964 }, -- Bolt of Woolen Cloth / 25
				{ 10, 2963 }, -- Bolt of Linen Cloth / 10
				{ 11, 1229504 }, -- Faction Banner / 4
				{ 12, 1263425 }, -- Faction Banner / 4
			},
		},
	}
}

data["Leatherworking"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 22926 }, -- Chromatic Cloak / 62
				{ 2, 22927 }, -- Hide of the Wild / 62
				{ 3, 22928 }, -- Shifting Cloak / 62
				{ 4, 19093 }, -- Onyxia Scale Cloak / 60
				{ 5, 10574 }, -- Wild Leather Cloak / 50
				{ 6, 10562 }, -- Big Voodoo Cloak / 48
				{ 7, 10550 }, -- Nightscape Cloak / 46
				{ 8, 7153 }, -- Guardian Cloak / 37
				{ 9, 9198 }, -- Frost Leather Cloak / 36
				{ 10, 3760 }, -- Hillman's Cloak / 30
				{ 11, 2168 }, -- Dark Leather Cloak / 22
				{ 12, 9070 }, -- Black Whelp Cloak / 20
				{ 13, 7953 }, -- Deviate Scale Cloak / 18
				{ 14, 2159 }, -- Fine Leather Cloak / 15
				{ 15, 2162 }, -- Embossed Leather Cloak / 13
				{ 16, 9058 }, -- Handstitched Leather Cloak / 9
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, 28219 }, -- Polar Tunic / 80
				{ 2, 24124 }, -- Blood Tiger Breastplate / 65
				{ 3, 24121 }, -- Primal Batskin Jerkin / 65
				{ 4, 19104 }, -- Frostsaber Tunic / 62
				{ 5, 19102 }, -- Runic Leather Armor / 62
				{ 6, 1255015 }, -- Dawn Armor / 61
				{ 7, 1255014 }, -- Timbermaw Tunic / 61
				{ 8, 19098 }, -- Wicked Leather Armor / 61
				{ 9, 19095 }, -- Living Breastplate / 60
				{ 10, 19086 }, -- Ironfeather Breastplate / 58
				{ 11, 1255024 }, -- Blue Suede Armor / 58
				{ 12, 19081 }, -- Chimeric Vest / 58
				{ 13, 19079 }, -- Stormshroud Armor / 57
				{ 14, 19076 }, -- Volcanic Breastplate / 57
				{ 15, 1255030 }, -- Tooled Leather Armor / 56
				{ 16, 19068 }, -- Warbear Harness / 55
				{ 17, 10647 }, -- Feathered Breastplate / 50
				{ 18, 10544 }, -- Wild Leather Vest / 45
				{ 19, 10520 }, -- Big Voodoo Robe / 43
				{ 20, 10499 }, -- Nightscape Tunic / 41
				{ 21, 6661 }, -- Barbaric Harness / 38
				{ 22, 9196 }, -- Dusky Leather Armor / 35
				{ 23, 9197 }, -- Green Whelp Armor / 35
				{ 24, 3773 }, -- Guardian Armor / 35
				{ 25, 6704 }, -- Thick Murloc Armor / 34
				{ 26, 4096 }, -- Raptor Hide Harness / 33
				{ 27, 3772 }, -- Green Leather Armor / 31
				{ 28, 1255102 }, -- Brawler's Leather Tunic / 27
				{ 29, 1255100 }, -- Defender's Leather Tunic / 27
				{ 30, 1255098 }, -- Stormrider's Leather Tunic / 27
				{ 101, 1255099 }, -- Totemic Leather Tunic / 27
				{ 102, 1255101 }, -- Trapper's Leather Tunic / 27
				{ 103, 1255097 }, -- Wisdom's Leather Tunic / 27
				{ 104, 2166 }, -- Toughened Leather Armor / 24
				{ 105, 24940 }, -- Black Whelp Tunic / 20
				{ 106, 2169 }, -- Dark Leather Tunic / 20
				{ 107, 3762 }, -- Hillman's Leather Vest / 20
				{ 108, 1255136 }, -- Brawler's Leather Armor / 20
				{ 109, 1255134 }, -- Defender's Leather Armor / 20
				{ 110, 1255132 }, -- Stormrider's Leather Armor / 20
				{ 111, 1255133 }, -- Totemic Leather Armor / 20
				{ 112, 1255135 }, -- Trapper's Leather Armor / 20
				{ 113, 1255131 }, -- Wisdom's Leather Armor / 20
				{ 114, 6703 }, -- Murloc Scale Breastplate / 19
				{ 115, 8322 }, -- Moonglow Vest / 18
				{ 116, 3761 }, -- Fine Leather Tunic / 17
				{ 117, 2163 }, -- White Leather Jerkin / 13
				{ 118, 1301451 }, -- Azure Gustwoven Harness / 12
				{ 119, 1301457 }, -- Azure Windraveled Jerkin / 12
				{ 120, 1301427 }, -- Cloudy Gustwoven Harness / 12
				{ 121, 1301433 }, -- Cloudy Windraveled Jerkin / 12
				{ 122, 2160 }, -- Embossed Leather Vest / 12
				{ 123, 7126 }, -- Handstitched Leather Vest / 10
			},
			[MAIL_DIFF] = {
				{ 1, 28222 }, -- Icy Scale Breastplate / 80
				{ 2, 24703 }, -- Dreamscale Breastplate / 68
				{ 3, 16746 }, -- Invulnerable Mail / 63
				{ 4, 19106 }, -- Onyxia Scale Breastplate / 62
				{ 5, 24851 }, -- Sandstalker Breastplate / 62
				{ 6, 24848 }, -- Spitfire Breastplate / 62
				{ 7, 19054 }, -- Red Dragonscale Breastplate / 61
				{ 8, 1254974 }, -- Supple Scorpid Vest / 59
				{ 9, 19085 }, -- Black Dragonscale Breastplate / 58
				{ 10, 19077 }, -- Blue Dragonscale Breastplate / 57
				{ 11, 1254975 }, -- Charged Scorpid Vest / 57
				{ 12, 16650 }, -- Wildthorn Mail / 54
				{ 13, 19051 }, -- Heavy Scorpid Vest / 53
				{ 14, 19050 }, -- Green Dragonscale Breastplate / 52
				{ 15, 10650 }, -- Dragonscale Breastplate / 51
				{ 16, 10525 }, -- Tough Scorpid Breastplate / 44
				{ 17, 10511 }, -- Turtle Scale Breastplate / 42
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 28473 }, -- Bramblewood Boots / 70
				{ 2, 22922 }, -- Mongoose Boots / 62
				{ 3, 23629 }, -- Heavy Timbermaw Boots / 61
				{ 4, 20853 }, -- Corehound Boots / 59
				{ 5, 1297128 }, -- Bileblister Boots / 58
				{ 6, 1297131 }, -- Hivethrasher's Boots / 58
				{ 7, 23705 }, -- Dawn Treaders / 58
				{ 8, 44953 }, -- Winter Boots / 285
				{ 9, 1255028 }, -- Wicked Leather Boots / 57
				{ 10, 19063 }, -- Chimeric Boots / 55
				{ 11, 19066 }, -- Frostsaber Boots / 55
				{ 12, 1255042 }, -- Tooled Leather Boots / 53
				{ 13, 1255043 }, -- Mender's Leather Boots / 52
				{ 14, 1255047 }, -- Prowler's Leather Boots / 52
				{ 15, 1255046 }, -- Skulker's Leather Boots / 52
				{ 16, 1255044 }, -- Skycaller's Leather Boots / 52
				{ 17, 1255045 }, -- Warden's Leather Boots / 52
				{ 18, 1255048 }, -- Blue Suede Shoes / 52
				{ 19, 10566 }, -- Wild Leather Boots / 49
				{ 20, 10558 }, -- Nightscape Boots / 47
				{ 21, 1255060 }, -- Mender's Leather Shoes / 45
				{ 22, 1255064 }, -- Prowler's Leather Shoes / 45
				{ 23, 1255063 }, -- Skulker's Leather Shoes / 45
				{ 24, 1255061 }, -- Skycaller's Leather Shoes / 45
				{ 25, 1255062 }, -- Warden's Leather Shoes / 45
				{ 26, 9207 }, -- Dusky Boots / 40
				{ 27, 9208 }, -- Swift Boots / 40
				{ 28, 1255103 }, -- Hillman's Leather Boots / 27
				{ 29, 1255121 }, -- Brawler's Leather Boots / 22
				{ 30, 1255119 }, -- Defender's Leather Boots / 22
				{ 101, 1255117 }, -- Stormrider's Leather Boots / 22
				{ 102, 1255118 }, -- Totemic Leather Boots / 22
				{ 103, 1255120 }, -- Trapper's Leather Boots / 22
				{ 104, 1255116 }, -- Wisdom's Leather Boots / 22
				{ 105, 2167 }, -- Dark Leather Boots / 20
				{ 106, 2158 }, -- Fine Leather Boots / 18
				{ 107, 2161 }, -- Embossed Leather Boots / 15
				{ 108, 1255146 }, -- Black Whelp Slippers / 15
				{ 109, 1255145 }, -- Dark Leather Boots / 15
				{ 110, 1255143 }, -- Moonglow Boots / 15
				{ 111, 1255144 }, -- Murloc Scale Shoes / 15
				{ 112, 1301456 }, -- Azure Gustwoven Boots / 11
				{ 113, 1301462 }, -- Azure Windraveled Footwraps / 11
				{ 114, 1301432 }, -- Cloudy Gustwoven Boots / 11
				{ 115, 1301438 }, -- Cloudy Windraveled Footwraps / 11
				{ 116, 2149 }, -- Handstitched Leather Boots / 8
			},
			[MAIL_DIFF] = {
				{ 1, 20855 }, -- Black Dragonscale Boots / 61
				{ 2, 1299917 }, -- Spiritcaller Boots / 61
				{ 3, 1254971 }, -- Charged Scorpid Boots / 61
				{ 4, 1254972 }, -- Supple Scorpid Sabatons / 61
				{ 5, 1297137 }, -- Broodwatcher's Treaders / 58
				{ 6, 1297134 }, -- Scalegut Treaders / 58
				{ 7, 1254979 }, -- Heavy Scorpid Boots / 56
				{ 8, 1254994 }, -- Mender's Mail Sabatons / 52
				{ 9, 1254995 }, -- Skirmisher's Mail Sabatons / 52
				{ 10, 1254996 }, -- Skycaller's Mail Sabatons / 52
				{ 11, 1254997 }, -- Stalker's Mail Sabatons / 52
				{ 12, 1254999 }, -- Supple Scorpid Boots / 51
				{ 13, 10554 }, -- Tough Scorpid Boots / 47
				{ 14, 1255008 }, -- Mender's Mail Boots / 45
				{ 15, 1255009 }, -- Skirmisher's Mail Boots / 45
				{ 16, 1255010 }, -- Skycaller's Mail Boots / 45
				{ 17, 1255011 }, -- Stalker's Mail Boots / 45
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 28220 }, -- Polar Gloves / 80
				{ 2, 24122 }, -- Primal Batskin Gloves / 65
				{ 3, 26279 }, -- Stormshroud Gloves / 62
				{ 4, 23704 }, -- Timbermaw Brawlers / 61
				{ 5, 19087 }, -- Frostsaber Gloves / 59
				{ 6, 1297126 }, -- Bileblister Claws / 58
				{ 7, 1297129 }, -- Hivethrasher's Claws / 58
				{ 8, 19084 }, -- Devilsaur Gauntlets / 58
				{ 9, 1255027 }, -- Tooled Leather Gauntlets / 57
				{ 10, 1255036 }, -- Mender's Leather Gauntlets / 55
				{ 11, 1255040 }, -- Prowler's Leather Gauntlets / 55
				{ 12, 1255039 }, -- Skulker's Leather Gauntlets / 55
				{ 13, 1255037 }, -- Skycaller's Leather Gauntlets / 55
				{ 14, 1255038 }, -- Warden's Leather Gauntlets / 55
				{ 15, 19055 }, -- Runic Leather Gauntlets / 54
				{ 16, 1255041 }, -- Blue Suede Gloves / 53
				{ 17, 19053 }, -- Chimeric Gloves / 53
				{ 18, 19049 }, -- Wicked Leather Gauntlets / 52
				{ 19, 10630 }, -- Gauntlets of the Sea / 46
				{ 20, 1255065 }, -- Mender's Leather Gloves / 40
				{ 21, 1255071 }, -- Prowler's Leather Gloves / 40
				{ 22, 1255067 }, -- Skirmisher's Leather Gloves / 40
				{ 23, 1255070 }, -- Skulker's Leather Gloves / 40
				{ 24, 1255066 }, -- Skycaller's Leather Gloves / 40
				{ 25, 1255069 }, -- Stalker's Leather Gloves / 40
				{ 26, 1255068 }, -- Warden's Leather Gloves / 40
				{ 27, 22711 }, -- Shadowskin Gloves / 40
				{ 28, 21943 }, -- Gloves of the Greatfather / 38
				{ 29, 7156 }, -- Guardian Gloves / 38
				{ 30, 3771 }, -- Barbaric Gloves / 30
				{ 101, 9149 }, -- Heavy Earthen Gloves / 29
				{ 102, 3764 }, -- Hillman's Leather Gloves / 29
				{ 103, 9148 }, -- Pilferer's Gloves / 28
				{ 104, 3770 }, -- Toughened Leather Gloves / 27
				{ 105, 9146 }, -- Herbalist's Gloves / 27
				{ 106, 3765 }, -- Dark Leather Gloves / 26
				{ 107, 9145 }, -- Fletcher's Gloves / 25
				{ 108, 9074 }, -- Nimble Leather Gloves / 24
				{ 109, 9072 }, -- Red Whelp Gloves / 24
				{ 110, 7954 }, -- Deviate Scale Gloves / 21
				{ 111, 1255130 }, -- Brawler's Leather Gloves / 20
				{ 112, 1255128 }, -- Defender's Leather Gloves / 20
				{ 113, 1255126 }, -- Stormrider's Leather Gloves / 20
				{ 114, 1255127 }, -- Totemic Leather Gloves / 20
				{ 115, 1255129 }, -- Trapper's Leather Gloves / 20
				{ 116, 1255125 }, -- Wisdom's Leather Gloves / 20
				{ 117, 2164 }, -- Fine Leather Gloves / 15
				{ 118, 3756 }, -- Embossed Leather Gloves / 13
				{ 119, 1301453 }, -- Azure Gustwoven Gloves / 11
				{ 120, 1301459 }, -- Azure Windraveled Mitts / 11
				{ 121, 1301429 }, -- Cloudy Gustwoven Gloves / 11
				{ 122, 1301435 }, -- Cloudy Windraveled Mitts / 11
			},
			[MAIL_DIFF] = {
				{ 1, 28223 }, -- Icy Scale Gauntlets / 80
				{ 2, 23708 }, -- Chromatic Gauntlets / 70
				{ 3, 1306531 }, -- Mourning Handguards / 65
				{ 4, 24850 }, -- Sandstalker Gauntlets / 62
				{ 5, 24847 }, -- Spitfire Gauntlets / 62
				{ 6, 1299915 }, -- Spiritcaller Gloves / 61
				{ 7, 16661 }, -- Storm Gauntlets / 59
				{ 8, 1297135 }, -- Broodwatcher's Clenchers / 58
				{ 9, 1297132 }, -- Scalegut Clenchers / 58
				{ 10, 24655 }, -- Green Dragonscale Gauntlets / 56
				{ 11, 1254977 }, -- Charged Scorpid Gauntlets / 56
				{ 12, 19064 }, -- Heavy Scorpid Gauntlet / 55
				{ 13, 1254986 }, -- Mender's Mail Gauntlets / 55
				{ 14, 1254987 }, -- Skirmisher's Mail Gauntlets / 55
				{ 15, 1254988 }, -- Skycaller's Mail Gauntlets / 55
				{ 16, 1254989 }, -- Stalker's Mail Gauntlets / 55
				{ 17, 10619 }, -- Dragonscale Gauntlets / 45
				{ 18, 10542 }, -- Tough Scorpid Gloves / 45
				{ 19, 439118 }, -- Turtle Scale Gloves / 41
				{ 20, 10509 }, -- Turtle Scale Gloves / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 28472 }, -- Bramblewood Helm / 70
				{ 2, 1306527 }, -- Outlaw's Collar / 65
				{ 3, 1255016 }, -- Living Crown / 61
				{ 4, 1255013 }, -- Warbear Helm / 61
				{ 5, 1255017 }, -- Blue Suede Hat / 61
				{ 6, 20854 }, -- Molten Helm / 60
				{ 7, 19082 }, -- Runic Leather Headband / 58
				{ 8, 1255025 }, -- Tooled Leather Crown / 58
				{ 9, 19071 }, -- Wicked Leather Headband / 56
				{ 10, 10632 }, -- Helm of Fire / 50
				{ 11, 10621 }, -- Wolfshead Helm / 45
				{ 12, 10546 }, -- Wild Leather Helmet / 45
				{ 13, 10531 }, -- Big Voodoo Mask / 44
				{ 14, 10507 }, -- Nightscape Headband / 41
				{ 15, 10490 }, -- Comfortable Leather Hat / 40
				{ 16, 1301536 }, -- Azure Gustwoven Hood / 35
				{ 17, 1301538 }, -- Azure Windraveled Cover / 35
				{ 18, 1301528 }, -- Cloudy Gustwoven Hood / 35
				{ 19, 1301530 }, -- Cloudy Windraveled Cover / 35
				{ 20, 1255093 }, -- Brawler's Leather Helm / 30
				{ 21, 1255091 }, -- Defender's Leather Helm / 30
				{ 22, 1255089 }, -- Stormrider's Leather Helm / 30
				{ 23, 1255090 }, -- Totemic Leather Helm / 30
				{ 24, 1255092 }, -- Trapper's Leather Helm / 30
				{ 25, 1255088 }, -- Wisdom's Leather Helm / 30
				{ 26, 1255109 }, -- Brawler's Leather Hood / 25
				{ 27, 1255107 }, -- Defender's Leather Hood / 25
				{ 28, 1255105 }, -- Stormrider's Leather Hood / 25
				{ 29, 1255106 }, -- Totemic Leather Hood / 25
				{ 30, 1255108 }, -- Trapper's Leather Hood / 25
				{ 101, 1255104 }, -- Wisdom's Leather Hood / 25
			},
			[MAIL_DIFF] = {
				{ 1, 1254968 }, -- Black Dragonscale Helm / 61
				{ 2, 1254969 }, -- Blue Dragonscale Helm / 61
				{ 3, 16728 }, -- Helm of the Great Chief / 61
				{ 4, 19088 }, -- Heavy Scorpid Helm / 59
				{ 5, 1254976 }, -- Supple Scorpid Helm / 57
				{ 6, 1254992 }, -- Charged Scorpid Helm / 53
				{ 7, 10570 }, -- Tough Scorpid Helm / 50
				{ 8, 10552 }, -- Turtle Scale Helm / 46
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 1306528 }, -- Elderwild Pants / 65
				{ 2, 1255012 }, -- Ironfeather Leggings / 61
				{ 3, 1255018 }, -- Tooled Leather Pants / 61
				{ 4, 19097 }, -- Devilsaur Leggings / 60
				{ 5, 19091 }, -- Runic Leather Pants / 60
				{ 6, 19083 }, -- Wicked Leather Pants / 58
				{ 7, 19078 }, -- Living Leggings / 57
				{ 8, 19080 }, -- Warbear Woolies / 57
				{ 9, 19074 }, -- Frostsaber Leggings / 57
				{ 10, 1255029 }, -- Blue Suede Pants / 56
				{ 11, 19073 }, -- Chimeric Leggings / 56
				{ 12, 19067 }, -- Stormshroud Pants / 55
				{ 13, 19059 }, -- Volcanic Leggings / 54
				{ 14, 10572 }, -- Wild Leather Leggings / 50
				{ 15, 10560 }, -- Big Voodoo Pants / 47
				{ 16, 10548 }, -- Nightscape Pants / 46
				{ 17, 7149 }, -- Barbaric Leggings / 34
				{ 18, 9195 }, -- Dusky Leather Leggings / 33
				{ 19, 7147 }, -- Guardian Pants / 32
				{ 20, 1255087 }, -- Brawler's Leather Legguards / 30
				{ 21, 1255085 }, -- Defender's Leather Kilt / 30
				{ 22, 1255083 }, -- Stormrider's Leather Kilt / 30
				{ 23, 1255084 }, -- Totemic Leather Leggings / 30
				{ 24, 1255086 }, -- Trapper's Leather Legguards / 30
				{ 25, 1255082 }, -- Wisdom's Leather Leggings / 30
				{ 26, 1255115 }, -- Brawler's Leather Pants / 25
				{ 27, 1255113 }, -- Defender's Leather Pants / 25
				{ 28, 1255111 }, -- Stormrider's Leather Pants / 25
				{ 29, 1255112 }, -- Totemic Leather Pants / 25
				{ 30, 1255114 }, -- Trapper's Leather Pants / 25
				{ 101, 1255110 }, -- Wisdom's Leather Pants / 25
				{ 102, 7135 }, -- Dark Leather Pants / 23
				{ 103, 7133 }, -- Fine Leather Pants / 21
				{ 104, 9068 }, -- Light Leather Pants / 19
				{ 105, 3759 }, -- Embossed Leather Pants / 15
				{ 106, 1301455 }, -- Azure Gustwoven Trousers / 12
				{ 107, 1301461 }, -- Azure Windraveled Pants / 12
				{ 108, 1301431 }, -- Cloudy Gustwoven Trousers / 12
				{ 109, 1301437 }, -- Cloudy Windraveled Pants / 12
				{ 110, 9064 }, -- Rugged Leather Pants / 11
				{ 111, 2153 }, -- Handstitched Leather Pants / 10
			},
			[MAIL_DIFF] = {
				{ 1, 19107 }, -- Black Dragonscale Leggings / 62
				{ 2, 1254967 }, -- Pristine Scorpid Leggings / 61
				{ 3, 1254970 }, -- Red Dragonscale Leggings / 61
				{ 4, 1299914 }, -- Spiritcaller Kilt / 61
				{ 5, 24654 }, -- Blue Dragonscale Leggings / 60
				{ 6, 1254973 }, -- Charged Scorpid Leggings / 59
				{ 7, 19075 }, -- Heavy Scorpid Leggings / 57
				{ 8, 19060 }, -- Green Dragonscale Leggings / 54
				{ 9, 1254993 }, -- Supple Scorpid Leggings / 53
				{ 10, 10568 }, -- Tough Scorpid Leggings / 49
				{ 11, 10556 }, -- Turtle Scale Leggings / 47
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 24125 }, -- Blood Tiger Shoulders / 65
				{ 2, 19103 }, -- Runic Leather Shoulders / 62
				{ 3, 23706 }, -- Golden Mantle of the Dawn / 61
				{ 4, 19101 }, -- Volcanic Shoulders / 61
				{ 5, 1255020 }, -- Tooled Leather Epaulets / 60
				{ 6, 19090 }, -- Stormshroud Shoulders / 59
				{ 7, 1255023 }, -- Wicked Leather Shoulder / 59
				{ 8, 1255026 }, -- Blue Suede Shoulder / 57
				{ 9, 19062 }, -- Ironfeather Shoulders / 54
				{ 10, 19061 }, -- Living Shoulders / 54
				{ 11, 1255055 }, -- Mender's Leather Shoulder / 47
				{ 12, 1255059 }, -- Prowler's Leather Shoulder / 47
				{ 13, 1255058 }, -- Skulker's Leather Shoulder / 47
				{ 14, 1255056 }, -- Skycaller's Leather Shoulder / 47
				{ 15, 1255057 }, -- Warden's Leather Shoulder / 47
				{ 16, 10529 }, -- Wild Leather Shoulders / 44
				{ 17, 10516 }, -- Nightscape Shoulders / 42
				{ 18, 1301537 }, -- Azure Gustwoven Spaulders / 35
				{ 19, 1301539 }, -- Azure Windraveled Drapes / 35
				{ 20, 1301529 }, -- Cloudy Gustwoven Spaulders / 35
				{ 21, 1301531 }, -- Cloudy Windraveled Drapes / 35
				{ 22, 7151 }, -- Barbaric Shoulders / 35
				{ 23, 3769 }, -- Dark Leather Shoulders / 28
				{ 24, 9147 }, -- Earthen Leather Shoulders / 27
				{ 25, 3768 }, -- Hillman's Shoulders / 26
			},
			[MAIL_DIFF] = {
				{ 1, 1306529 }, -- Eternity Pauldrons / 65
				{ 2, 1299916 }, -- Spiritcaller Mantle / 61
				{ 3, 19100 }, -- Heavy Scorpid Shoulders / 61
				{ 4, 19094 }, -- Black Dragonscale Shoulders / 60
				{ 5, 19089 }, -- Blue Dragonscale Shoulders / 59
				{ 6, 1254981 }, -- Supple Scorpid Shoulder / 56
				{ 7, 1254990 }, -- Charged Scorpid Shoulder / 55
				{ 8, 10564 }, -- Tough Scorpid Shoulders / 48
				{ 9, 1255004 }, -- Mender's Mail Shoulder / 47
				{ 10, 1255005 }, -- Skirmisher's Mail Shoulder / 47
				{ 11, 1255006 }, -- Skycaller's Mail Shoulder / 47
				{ 12, 1255007 }, -- Stalker's Mail Shoulder / 47
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 23709 }, -- Corehound Belt / 70
				{ 2, 23710 }, -- Molten Belt / 70
				{ 3, 28474 }, -- Bramblewood Belt / 70
				{ 4, 23707 }, -- Lava Belt / 66
				{ 5, 1306526 }, -- Elderwild Waistcord / 65
				{ 6, 22921 }, -- Girdle of Insight / 62
				{ 7, 19092 }, -- Wicked Leather Belt / 60
				{ 8, 1255021 }, -- Blue Suede Belt / 59
				{ 9, 1297127 }, -- Bileblister Girdle / 58
				{ 10, 1297130 }, -- Hivethrasher's Girdle / 58
				{ 11, 23628 }, -- Heavy Timbermaw Belt / 58
				{ 12, 23703 }, -- Might of the Timbermaw / 58
				{ 13, 19072 }, -- Runic Leather Belt / 56
				{ 14, 1255031 }, -- Mender's Leather Waistguard / 55
				{ 15, 1255035 }, -- Prowler's Leather Waistguard / 55
				{ 16, 1255034 }, -- Skulker's Leather Waistguard / 55
				{ 17, 1255032 }, -- Skycaller's Leather Waistguard / 55
				{ 18, 1255033 }, -- Warden's Leather Waistguard / 55
				{ 19, 1255049 }, -- Tooled Leather Belt / 52
				{ 20, 3779 }, -- Barbaric Belt / 40
				{ 21, 9206 }, -- Dusky Belt / 39
				{ 22, 3778 }, -- Gem-studded Leather Belt / 37
				{ 23, 1255075 }, -- Mender's Leather Belt / 35
				{ 24, 1255081 }, -- Prowler's Leather Belt / 35
				{ 25, 1255077 }, -- Skirmisher's Leather Belt / 35
				{ 26, 1255080 }, -- Skulker's Leather Belt / 35
				{ 27, 1255076 }, -- Skycaller's Leather Belt / 35
				{ 28, 1255079 }, -- Stalker's Leather Belt / 35
				{ 29, 1255078 }, -- Warden's Leather Belt / 35
				{ 30, 3775 }, -- Guardian Belt / 34
				{ 101, 4097 }, -- Raptor Hide Belt / 33
				{ 102, 3774 }, -- Green Leather Belt / 32
				{ 103, 3766 }, -- Dark Leather Belt / 25
				{ 104, 3767 }, -- Hillman's Belt / 25
				{ 105, 7955 }, -- Deviate Scale Belt / 23
				{ 106, 6702 }, -- Murloc Scale Belt / 18
				{ 107, 1255142 }, -- Brawler's Leather Belt / 17
				{ 108, 1255140 }, -- Defender's Leather Belt / 17
				{ 109, 1255138 }, -- Stormrider's Leather Belt / 17
				{ 110, 1255139 }, -- Totemic Leather Belt / 17
				{ 111, 1255141 }, -- Trapper's Leather Belt / 17
				{ 112, 1255137 }, -- Wisdom's Leather Belt / 17
				{ 113, 3763 }, -- Fine Leather Belt / 16
				{ 114, 1301454 }, -- Azure Gustwoven Belt / 10
				{ 115, 1301460 }, -- Azure Windraveled Strap / 10
				{ 116, 1301430 }, -- Cloudy Gustwoven Belt / 10
				{ 117, 1301436 }, -- Cloudy Windraveled Strap / 10
				{ 118, 3753 }, -- Handstitched Leather Belt / 10
			},
			[MAIL_DIFF] = {
				{ 1, 1297136 }, -- Broodwatcher's Belt / 58
				{ 2, 1297133 }, -- Scalegut Belt / 58
				{ 3, 19070 }, -- Heavy Scorpid Belt / 56
				{ 4, 1254978 }, -- Supple Scorpid Belt / 56
				{ 5, 1254982 }, -- Mender's Mail Belt / 55
				{ 6, 1254983 }, -- Skirmisher's Mail Belt / 55
				{ 7, 1254984 }, -- Skycaller's Mail Belt / 55
				{ 8, 1254985 }, -- Stalker's Mail Belt / 55
				{ 9, 1254998 }, -- Charged Scorpid Belt / 51
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, 28221 }, -- Polar Bracers / 80
				{ 2, 24123 }, -- Primal Batskin Bracers / 65
				{ 3, 1255019 }, -- Blue Suede Bracers / 60
				{ 4, 1255022 }, -- Tooled Leather Bracers / 59
				{ 5, 19065 }, -- Runic Leather Bracers / 55
				{ 6, 19052 }, -- Wicked Leather Bracers / 53
				{ 7, 1255050 }, -- Mender's Leather Bracers / 50
				{ 8, 1255054 }, -- Prowler's Leather Bracers / 50
				{ 9, 1255053 }, -- Skulker's Leather Bracers / 50
				{ 10, 1255051 }, -- Skycaller's Leather Bracers / 50
				{ 11, 1255052 }, -- Warden's Leather Bracers / 50
				{ 12, 3777 }, -- Guardian Leather Bracers / 39
				{ 13, 9202 }, -- Green Whelp Bracers / 38
				{ 14, 6705 }, -- Murloc Scale Bracers / 38
				{ 15, 9201 }, -- Dusky Bracers / 37
				{ 16, 3776 }, -- Green Leather Bracers / 36
				{ 17, 23399 }, -- Barbaric Bracers / 32
				{ 18, 9065 }, -- Light Leather Bracers / 14
				{ 19, 1301452 }, -- Azure Gustwoven Bracers / 10
				{ 20, 1301458 }, -- Azure Windraveled Armguards / 10
				{ 21, 1301428 }, -- Cloudy Gustwoven Bracers / 10
				{ 22, 1301434 }, -- Cloudy Windraveled Armguards / 10
				{ 23, 9059 }, -- Handstitched Leather Bracers / 9
			},
			[MAIL_DIFF] = {
				{ 1, 28224 }, -- Icy Scale Bracers / 80
				{ 2, 1306530 }, -- Tranquil Wristguards / 65
				{ 3, 24849 }, -- Sandstalker Bracers / 62
				{ 4, 24846 }, -- Spitfire Bracers / 62
				{ 5, 22923 }, -- Swift Flight Bracers / 62
				{ 6, 1254980 }, -- Charged Scorpid Bracers / 56
				{ 7, 1254991 }, -- Supple Scorpid Bracers / 55
				{ 8, 19048 }, -- Heavy Scorpid Bracers / 51
				{ 9, 1255000 }, -- Mender's Mail Bracers / 50
				{ 10, 1255001 }, -- Skirmisher's Mail Bracers / 50
				{ 11, 1255002 }, -- Skycaller's Mail Bracers / 50
				{ 12, 1255003 }, -- Stalker's Mail Bracers / 50
				{ 13, 10533 }, -- Tough Scorpid Bracers / 44
				{ 14, 10518 }, -- Turtle Scale Bracers / 42
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 14930 }, -- Quickdraw Quiver / 45
				{ 2, 14932 }, -- Thick Leather Ammo Pouch / 45
				{ 3, 9194 }, -- Heavy Leather Ammo Pouch / 35
				{ 4, 9193 }, -- Heavy Quiver / 35
				{ 5, 5244 }, -- Kodo Hide Bag / 5
				{ 6, 9060 }, -- Light Leather Quiver / 5
				{ 7, 9062 }, -- Small Leather Ammo Pouch / 5
				{ 8, 1302604 }, -- Light Leather Reagent Bag / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 1306532 }, -- Wild Leather Armor Kit / 65
				{ 2, 22727 }, -- Core Armor Kit / 60
				{ 3, 1263079 }, -- Sewing Machine / 60
				{ 4, 22815 }, -- Gordok Ogre Suit / 55
				{ 5, 1254965 }, -- Forceful Rugged Armor Kit / 50
				{ 6, 1254966 }, -- Mystic Rugged Armor Kit / 50
				{ 7, 19047 }, -- Cured Rugged Hide / 50
				{ 8, 19058 }, -- Rugged Armor Kit / 50
				{ 9, 22331 }, -- Rugged Leather / 50
				{ 10, 1255073 }, -- Forceful Thick Armor Kit / 40
				{ 11, 1255074 }, -- Mystic Thick Armor Kit / 40
				{ 12, 435819 }, -- Faintly Glowing Leather / 40
				{ 13, 10487 }, -- Thick Armor Kit / 40
				{ 14, 10482 }, -- Cured Thick Hide / 40
				{ 15, 20650 }, -- Thick Leather / 40
				{ 16, 1255095 }, -- Forceful Heavy Armor Kit / 30
				{ 17, 1255096 }, -- Mystic Heavy Armor Kit / 30
				{ 18, 3780 }, -- Heavy Armor Kit / 30
				{ 19, 3818 }, -- Cured Heavy Hide / 30
				{ 20, 20649 }, -- Heavy Leather / 30
				{ 21, 1263031 }, -- Tanning Rack / 28
				{ 22, 23190 }, -- Heavy Leather Ball / 125
				{ 23, 3817 }, -- Cured Medium Hide / 20
				{ 24, 20648 }, -- Medium Leather / 20
				{ 25, 1255123 }, -- Forceful Medium Armor Kit / 15
				{ 26, 1255124 }, -- Mystic Medium Armor Kit / 15
				{ 27, 2165 }, -- Medium Armor Kit / 15
				{ 28, 3816 }, -- Cured Light Hide / 10
				{ 29, 2881 }, -- Light Leather / 10
				{ 30, 2152 }, -- Light Armor Kit / 5
				{ 101, 1229432 }, -- Camp Tent / 4
			},
		},
	}
}

data["Mining"] = {
	name = ALIL["Mining"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1, 22967 }, -- Elementium Bar / 60
				{ 2, 1306126 }, -- Heavy Thorium Bar / 60
				{ 3, 1263071 }, -- Molten Foundry / 60
				{ 4, 1249637 }, -- Azerothium Bar / 55
				{ 5, 16153 }, -- Thorium Bar / 50
				{ 6, 10098 }, -- Truesilver Bar / 50
				{ 7, 14891 }, -- Dark Iron Bar / 50
				{ 8, 10097 }, -- Mithril Bar / 40
				{ 9, 3569 }, -- Steel Bar / 35
				{ 10, 3308 }, -- Gold Bar / 30
				{ 11, 3307 }, -- Iron Bar / 30
				{ 12, 1262975 }, -- Rock Garden / 28
				{ 13, 2659 }, -- Bronze Bar / 20
				{ 14, 3304 }, -- Tin Bar / 20
				{ 15, 2658 }, -- Silver Bar / 10
				{ 16, 2657 }, -- Copper Bar / 10
				{ 17, 1230161 }, -- Lodestone / 4
			},
		},
	}
}

data["Herbalism"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.HERBALISM_LINK,
	items = {
		{
			name = AL["Artisan"],
			[NORMAL_DIFF] = {
				{ 1,  13467 }, -- Icecap
				{ 2,  13466 }, -- Plaguebloom
				{ 3,  13465 }, -- Mountain Silversage
				{ 4,  13463 }, -- Dreamfoil
				{ 5,  13464 }, -- Golden Sansam
				{ 6,  8846 }, -- Gromsblood
				{ 7,  8845 }, -- Ghost Mushroom
				{ 8,  8839 }, -- Blindweed
				{ 9,  8838 }, -- Sungrass
				{ 10, 13468 }, -- Black Lotus
				{ 11, 19727 }, -- Blood Scythe
				{ 12, 19726 }, -- Bloodvine
				{ 16, 248822 }, -- Death Lotus
				{ 17, 249274 }, -- Stranglevine
				{ 18, 248821 }, -- Demonsage
				{ 19, 248823 }, -- Marefoil
				{ 20, 234012 }, -- Hive Thistle
				{ 21, 279947 }, -- Seed Hybridizer
			},
		},
		{
			name = AL["Expert"],
			[NORMAL_DIFF] = {
				{ 1,  8836 }, -- Arthas' Tears
				{ 2,  8831, 8153 }, -- Purple Lotus (Wildvine)
				{ 3,  4625 }, -- Firebloom
				{ 4,  3819 }, -- Wintersbite
				{ 5,  3358 }, -- Khadgar's Whisker
				{ 6,  3821 }, -- Goldthorn
				{ 7,  3818 }, -- Fadeleaf
				{ 16, 249424 }, -- Rosecap
				{ 17, 268418 }, -- Scarce Herb Seeds
				{ 18, 268417 }, -- Unusual Herb Seeds
			},
		},
		{
			name = AL["Journeyman"],
			[NORMAL_DIFF] = {
				{ 1,  3357 }, -- Liferoot
				{ 2,  3356 }, -- Kingsblood
				{ 3,  3369 }, -- Grave Moss
				{ 4,  3355 }, -- Wild Steelbloom
				{ 5,  2453 }, -- Bruiseweed
				{ 6,  3820 }, -- Stranglekelp
				{ 16, 249399 }, -- Frilled Lichen
				{ 17, 268416 }, -- Uncommon Herb Seeds
				{ 18, 279964 }, -- Greenhouse
			},
		},
		{
			name = AL["Apprentice"],
			[NORMAL_DIFF] = {
				{ 1,  2450, 2452 }, -- Briarthorn (Swiftthistle)
				{ 2,  785,  2452 }, -- Mageroyal (Swiftthistle)
				{ 3,  2449 }, -- Earthroot
				{ 4,  765 }, -- Silverleaf
				{ 5,  2447 }, -- Peacebloom
				{ 16, 268415 }, -- Commonplace Herb Seeds
				{ 17, 279962 }, -- Incense Candle
			},
		},
	},
}
data["Cooking"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.COOKING_LINK,
	items = {
		{
			name = ALIL["Stamina"],
			[NORMAL_DIFF] = {
				{ 1, 25659 }, -- Dirge's Kickin' Chimaerok Chops / 55
				{ 2, 18246 }, -- Mightfish Steak / 55
				{ 3, 18239 }, -- Cooked Glossy Mightfish / 45
			},
		},
		{
			name = ALIL["Intellect"],
			[NORMAL_DIFF] = {
				{ 1, 22761 }, -- Runn Tum Tuber Surprise / 45
			},
		},
		{
			name = ALIL["Agility"],
			[NORMAL_DIFF] = {
				{ 1, 18240 }, -- Grilled Squid / 45
			},
		},
		{
			name = ALIL["Strength"],
			[NORMAL_DIFF] = {
				{ 1, 24801 }, -- Smoked Desert Dumplings / 55
			},
		},
		{
			name = ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 18242 }, -- Hot Smoked Bass / 45
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 1225759 }, -- Filet o' Flank / 65
				{ 2, 1225760 }, -- Sunrise Omelette / 65
				{ 3, 1250146 }, -- Flank au Poivre / 55
				{ 4, 1250144 }, -- Bat Hachee / 55
				{ 5, 1250147 }, -- Bear Bruscitti / 55
				{ 6, 1250143 }, -- Soaring Pamplona / 55
				{ 7, 1250152 }, -- Prehistoric Pulled Raptor / 55
				{ 8, 1250145 }, -- Savory Turtle Stew / 55
				{ 9, 15933 }, -- Monster Omelet / 45
				{ 10, 22480 }, -- Tender Wolf Steak / 45
				{ 11, 21175 }, -- Spider Sausage / 45
				{ 12, 1250153 }, -- Raptor Rouladen / 45
				{ 13, 1250142 }, -- Savory Stag Sliders / 45
				{ 14, 15861 }, -- Jungle Stew / 45
				{ 15, 15915 }, -- Spiced Chili Crab / 35
				{ 16, 15910 }, -- Heavy Kodo Stew / 35
				{ 17, 4094 }, -- Barbecued Buzzard Wing / 35
				{ 18, 7213 }, -- Giant Clam Scorcho / 35
				{ 19, 15856 }, -- Hot Wolf Ribs / 35
				{ 20, 1250151 }, -- Bear Brisket / 35
				{ 21, 1295834 }, -- Plain Ol' Paletusk / 35
				{ 22, 1250155 }, -- Giant Scrambled Eggs / 35
				{ 23, 3399 }, -- Tasty Lion Steak / 35
				{ 24, 1250150 }, -- Raging Raptor Ribs / 35
				{ 25, 24418 }, -- Heavy Crocolisk Stew / 35
				{ 26, 15865 }, -- Mystery Stew / 25
				{ 27, 15855 }, -- Roast Raptor / 25
				{ 28, 3400 }, -- Soothing Turtle Bisque / 25
				{ 29, 3398 }, -- Hot Lion Chops / 25
				{ 30, 3376 }, -- Curiously Tasty Omelet / 25
				{ 101, 6500 }, -- Goblin Deviled Clams / 25
				{ 102, 15853 }, -- Lean Wolf Steak / 25
				{ 103, 3373 }, -- Crocolisk Gumbo / 25
				{ 104, 3377 }, -- Gooey Spider Cake / 25
				{ 105, 6419 }, -- Lean Venison / 25
				{ 106, 2549 }, -- Seasoned Wolf Kabob / 25
				{ 107, 15863 }, -- Carrion Surprise / 15
				{ 108, 3397 }, -- Big Bear Steak / 15
				{ 109, 6418 }, -- Crispy Lizard Tail / 15
				{ 110, 2547 }, -- Redridge Goulash / 15
				{ 111, 3370 }, -- Crocolisk Steak / 15
				{ 112, 2546 }, -- Dry Pork Ribs / 15
				{ 113, 2544 }, -- Crab Cake / 15
				{ 114, 1250154 }, -- Twice-Spiced Raptor Slice / 15
				{ 115, 3371 }, -- Blood Sausage / 15
				{ 116, 2541 }, -- Coyote Steak / 15
				{ 117, 6415 }, -- Fillet of Frenzy / 15
				{ 118, 2542 }, -- Goretusk Liver Pie / 15
				{ 119, 1250157 }, -- Breakfast Omelette / 15
				{ 120, 1270635 }, -- Pincer Bites / 15
				{ 121, 1270633 }, -- Skywall Souffle / 15
				{ 122, 3372 }, -- Murloc Fin Soup / 10
				{ 123, 6499 }, -- Boiled Clams / 10
				{ 124, 6416 }, -- Strider Stew / 10
				{ 125, 21144 }, -- Egg Nog / 10
				{ 126, 6414 }, -- Roasted Kodo Meat / 10
				{ 127, 2795 }, -- Beer Basted Boar Ribs / 10
				{ 128, 6412 }, -- Kaldorei Spider Kabob / 10
				{ 129, 2539 }, -- Spiced Wolf Meat / 10
				{ 130, 15935 }, -- Crispy Bat Wing / 10
				{ 201, 21143 }, -- Gingerbread Cookie / 10
				{ 202, 8604 }, -- Herb Baked Egg / 10
				{ 203, 1250156 }, -- Tasty Raptor Bites / 10
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 25954 }, -- Sagefish Delight / 55
				{ 2, 18243 }, -- Nightfin Soup / 45
				{ 3, 25704 }, -- Smoked Sagefish / 20
			},
		},
		{
			name = ALIL["Health Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18244 }, -- Poached Sunscale Salmon / 45
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1, 470359 }, -- Darkclaw Bisque / 55
				{ 2, 18247 }, -- Baked Salmon / 55
				{ 3, 18245 }, -- Lobster Stew / 55
				{ 4, 1247741 }, -- Spinefin Halibut / 55
				{ 5, 1250158 }, -- Clam Linguine / 55
				{ 6, 470370 }, -- Smoked Redgill / 45
				{ 7, 18241 }, -- Filet of Redgill / 45
				{ 8, 18238 }, -- Spotted Yellowtail / 45
				{ 9, 20626 }, -- Undermine Clam Chowder / 45
				{ 10, 1319313 }, -- Plated Armorfish / 45
				{ 11, 1295805 }, -- Briny Seafood Stew / 35
				{ 12, 20916 }, -- Mithril Head Trout / 35
				{ 13, 7828 }, -- Rockscale Cod / 35
				{ 14, 7755 }, -- Bristle Whisker Catfish / 25
				{ 15, 6417 }, -- Dig Rat Stew / 25
				{ 16, 2548 }, -- Succulent Pork Ribs / 25
				{ 17, 6501 }, -- Clam Chowder / 15
				{ 18, 2543 }, -- Westfall Stew / 15
				{ 19, 7754 }, -- Loch Frenzy Delight / 15
				{ 20, 7753 }, -- Longjaw Mud Snapper / 15
				{ 21, 7827 }, -- Rainbow Fin Albacore / 15
				{ 22, 2545 }, -- Cooked Crab Claw / 10
				{ 23, 8607 }, -- Smoked Bear Meat / 10
				{ 24, 6413 }, -- Scorpid Surprise / 10
				{ 25, 7751 }, -- Brilliant Smallfish / 10
				{ 26, 2538 }, -- Charred Wolf Meat / 10
				{ 27, 2540 }, -- Roasted Boar Meat / 10
				{ 28, 7752 }, -- Slitherskin Mackerel / 10
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 1225763 }, -- Grand Lobster Banquet / 65
				{ 2, 1225762 }, -- Specklefin Feast / 65
				{ 3, 1225758 }, -- Prowler Steak / 65
				{ 4, 1263067 }, -- Iron Oven / 60
				{ 5, 1294014 }, -- Sweetpaw Jam / 60
				{ 6, 1249962 }, -- Sage's Tea / 55
				{ 7, 1250148 }, -- Steaming Stag Steak / 55
				{ 8, 1249968 }, -- Wicked Smoothie / 55
				{ 9, 1250149 }, -- Swiftstrike Steak / 55
				{ 10, 1249961 }, -- Sunny Tea / 45
				{ 11, 1249967 }, -- Spicy Smoothie / 45
				{ 12, 1291341 }, -- Expert Campfire Kit / 40
				{ 13, 15906 }, -- Dragonbreath Chili / 35
				{ 14, 13028 }, -- Goldthorn Tea / 35
				{ 15, 1249960 }, -- Triage Tea / 35
				{ 16, 1249966 }, -- Calcified Smoothie / 35
				{ 17, 1262978 }, -- Cookie's Feast / 28
				{ 18, 1249959 }, -- Root Tea / 25
				{ 19, 1249965 }, -- Mrrggl Smrrthle / 25
				{ 20, 1283400 }, -- Journeyman Campfire Kit / 18
				{ 21, 9513 }, -- Thistle Tea / 15
				{ 22, 1249958 }, -- Royal Tea / 15
				{ 23, 1249964 }, -- Slimy Smoothie / 15
				{ 24, 8238 }, -- Savory Deviate Delight / 10
				{ 25, 1252566 }, -- Savory Whimsyfin Delight / 10
				{ 26, 1249957 }, -- Peace Tea / 5
				{ 27, 1249963 }, -- Venomous Smoothie / 5
				{ 28, 1229737 }, -- Basic Campfire Kit / 4
			},
		},
	}
}

data["FirstAid"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.FIRSTAID_LINK,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1, 470349 }, -- Dense Runecloth Bandage / 70
				{ 2, 30021 }, -- Crystal Infused Bandage / 60
				{ 3, 1263001 }, -- Plague Doctor's Laboratory / 60
				{ 4, 23787 }, -- Powerful Anti-Venom / 58
				{ 5, 1259345 }, -- Powerful Poultice / 58
				{ 6, 18630 }, -- Heavy Runecloth Bandage / 58
				{ 7, 1259349 }, -- Surgical Tourniquet / 58
				{ 8, 1244436 }, -- Major Healing Potion / 55
				{ 9, 18629 }, -- Runecloth Bandage / 52
				{ 10, 10841 }, -- Heavy Mageweave Bandage / 240
				{ 11, 1244435 }, -- Superior Healing Potion / 45
				{ 12, 10840 }, -- Mageweave Bandage / 210
				{ 13, 1259341 }, -- Potent Anti-Venom / 36
				{ 14, 1259344 }, -- Superior Poultice / 36
				{ 15, 1259348 }, -- Leather Tourniquet / 36
				{ 16, 7929 }, -- Heavy Silk Bandage / 180
				{ 17, 1244434 }, -- Greater Healing Potion / 31
				{ 18, 7928 }, -- Silk Bandage / 150
				{ 19, 1262996 }, -- Toxin Study / 28
				{ 20, 1259343 }, -- Clever Poultice / 26
				{ 21, 7935 }, -- Strong Anti-Venom / 26
				{ 22, 3278 }, -- Heavy Wool Bandage / 115
				{ 23, 1244433 }, -- Healing Potion / 22
				{ 24, 1259347 }, -- Woolen Tourniquet / 21
				{ 25, 1259342 }, -- Simple Poultice / 16
				{ 26, 7934 }, -- Anti-Venom / 16
				{ 27, 3277 }, -- Wool Bandage / 80
				{ 28, 1244432 }, -- Lesser Healing Potion / 13
				{ 29, 3276 }, -- Heavy Linen Bandage / 50
				{ 30, 3275 }, -- Linen Bandage / 30
				{ 101, 1244431 }, -- Minor Healing Potion / 5
				{ 102, 1230117 }, -- First Aid Kit / 4
			},
		},
	}
}

data["Fishing"] = {
	name = ALIL["Fishing"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.FISHING_LINK,
	items = {
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 279966 }, -- Fishing Hut
				{ 2, 279965 }, -- Fishing Rack
				{ 3, 259846 }, -- Wide-Brimmed Fishing Hat
				{ 4, 273636 }, -- Chef's Knife
				{ 5, 19971 }, -- High Test Eternium Fishing Line
				{ 6, 6533 }, -- Aquadynamic Fish Attractor
				{ 7, 6532 }, -- Bright Baubles
				{ 8, 7307 }, -- Flesh Eating Worm
				{ 9, 6811 }, -- Aquadynamic Fish Lens
				{ 10, 6530 }, -- Nightcrawlers
				{ 11, 279967 }, -- Fish Bowl
				{ 12, 276272 }, -- Master Angler's Fishing Hat
				{ 13, 258530 }, -- Lucky Lure
				{ 15, 16083 }, -- Expert Fishing - The Bass and You
			},
		},
		{
			name = ALIL["Fishing Pole"],
			[NORMAL_DIFF] = {
				{ 1, 19970 }, -- Arcanite Fishing Pole
				{ 2, 19022 }, -- Nat Pagle's Extreme Angler FC-5000
				{ 3, 276203 }, -- Primitive Fishing Pole
				{ 4, 6367 }, -- Big Iron Fishing Pole
				{ 5, 6365 }, -- Strong Fishing Pole
				{ 6, 12225 }, -- Blump Family Fishing Pole
				{ 7, 6256 }, -- Fishing Pole
			},
		},
		{
			name = AL["Fishes"],
			[NORMAL_DIFF] = {
				{ 1, 13888 }, -- Darkclaw Lobster
				{ 2, 13890 }, -- Raw Plated Armorfish
				{ 3, 13889 }, -- Raw Whitescale Salmon
				{ 4, 13754 }, -- Raw Glossy Mightfish
				{ 5, 13759 }, -- Raw Nightfin Snapper
				{ 6, 13758 }, -- Raw Redgill
				{ 7, 4603 }, -- Raw Spotted Yellowtail
				{ 8, 13756 }, -- Raw Summer Bass
				{ 9, 13760 }, -- Raw Sunscale Salmon
				{ 10, 7974 }, -- Zesty Clam Meat
				{ 11, 21153 }, -- Raw Greater Sagefish
				{ 12, 8365 }, -- Raw Mithril Head Trout
				{ 13, 6362 }, -- Raw Rockscale Cod
				{ 14, 6308 }, -- Raw Bristle Whisker Catfish
				{ 15, 21071 }, -- Raw Sagefish
				{ 16, 251524 }, -- Whimsyfin
				{ 17, 6317 }, -- Raw Loch Frenzy
				{ 18, 6289 }, -- Raw Longjaw Mud Snapper
				{ 19, 6361 }, -- Raw Rainbow Fin Albacore
				{ 20, 6291 }, -- Raw Brilliant Smallfish
				{ 21, 6303 }, -- Raw Slitherskin Mackerel
			},
		},
	},
}
data["RoguePoisons"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ROGUE_POISONS_LINK,
	items = {
		{
			name = ALIL["Poisons"],
			[NORMAL_DIFF] = {
				{ 1, 11343 }, -- Instant Poison VI / 60
				{ 2, 439503 }, -- Atrophic Poison / 60
				{ 3, 25347 }, -- Deadly Poison V / 60
				{ 4, 439505 }, -- Numbing Poison / 60
				{ 5, 1214168 }, -- Occult Poison II / 60
				{ 6, 439500 }, -- Sebacious Poison / 60
				{ 7, 13230 }, -- Wound Poison IV / 56
				{ 8, 11358 }, -- Deadly Poison IV / 54
				{ 9, 458822 }, -- Occult Poison I / 54
				{ 10, 11342 }, -- Instant Poison V / 52
				{ 11, 11400 }, -- Mind-numbing Poison III / 52
				{ 12, 3421 }, -- Crippling Poison II / 50
				{ 13, 13229 }, -- Wound Poison III / 48
				{ 14, 11357 }, -- Deadly Poison III / 46
				{ 15, 11341 }, -- Instant Poison IV / 44
				{ 16, 13228 }, -- Wound Poison II / 40
				{ 17, 2837 }, -- Deadly Poison II / 38
				{ 18, 8694 }, -- Mind-numbing Poison II / 38
				{ 19, 8691 }, -- Instant Poison III / 36
				{ 20, 6510 }, -- Blinding Powder / 34
				{ 21, 13220 }, -- Wound Poison / 32
				{ 22, 2835 }, -- Deadly Poison / 30
				{ 23, 8687 }, -- Instant Poison II / 28
				{ 24, 5763 }, -- Mind-numbing Poison / 24
				{ 25, 3420 }, -- Crippling Poison / 20
				{ 26, 8681 }, -- Instant Poison / 20
			},
		},
	}
}

data["MageScrolls"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["MAGE"].colorStr, ALIL["MAGE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.MAGE_SCROLLS_LINK,
	items = {
		{
			name = AL["Weapon Imbues"],
			[NORMAL_DIFF] = {
				{ 1, 277500 }, -- Scroll of Imbue Greater Flame / 55
				{ 2, 277501 }, -- Scroll of Imbue Greater Frost / 55
				{ 3, 277502 }, -- Scroll of Imbue Precision / 55
				{ 4, 277503 }, -- Scroll of Imbue Spellbreak / 55
				{ 5, 277494 }, -- Scroll of Imbue Accuracy / 40
				{ 6, 277496 }, -- Scroll of Imbue Balefrost / 40
				{ 7, 277497 }, -- Scroll of Imbue Flame / 40
				{ 8, 277498 }, -- Scroll of Imbue Manablade / 40
				{ 9, 277495 }, -- Scroll of Imbue Quickening / 40
				{ 10, 277487 }, -- Scroll of Imbue Baleflame / 25
				{ 11, 277485 }, -- Scroll of Imbue Frost / 25
				{ 12, 277488 }, -- Scroll of Imbue Iceknife / 25
				{ 13, 277489 }, -- Scroll of Imbue Spark / 25
				{ 14, 277486 }, -- Scroll of Imbue Striking / 25
				{ 15, 275067 }, -- Scroll of Imbue Chillknife / 15
				{ 16, 274947 }, -- Scroll of Imbue Lesser Flame / 15
			},
		},
		{
			name = AL["Buffs & Combat"],
			[NORMAL_DIFF] = {
				{ 1, 277504 }, -- Scroll of Wit / 55
				{ 2, 277499 }, -- Scroll of Greater Cryoblast / 55
				{ 3, 217496 }, -- Scroll of the Blade / 40
				{ 4, 277491 }, -- Scroll of Rebuke Elemental / 40
				{ 5, 277490 }, -- Scroll of the Saber / 25
				{ 6, 211954 }, -- Scroll of Arcane Accuracy I / 25
				{ 7, 211957 }, -- Scroll of Arcane Power I / 25
				{ 8, 211955 }, -- Scroll of Arcane Protection - Fire I / 25
				{ 9, 211956 }, -- Scroll of Arcane Protection - Frost I / 25
				{ 10, 211953 }, -- Scroll of Arcane Recovery I / 25
				{ 11, 217495 }, -- Scroll of Cryoblast / 25
			},
		},
		{
			name = AL["Familiars & Utility"],
			[NORMAL_DIFF] = {
				{ 1, 223171 }, -- Scroll of Geomancy / 45
				{ 2, 277493 }, -- Scroll of Cat Familiar / 40
				{ 3, 277492 }, -- Scroll of Khadgar's Unlocking / 40
				{ 4, 213548 }, -- Scroll of Liminal Passage / 40
				{ 5, 277484 }, -- Scroll of Confuse Beast / 25
				{ 6, 277483 }, -- Scroll of Frog Familiar / 25
				{ 7, 213550 }, -- Scroll of Polymorph: Odd Melon / 25
				{ 8, 213549 }, -- Scroll of Arcane Angling / 15
				{ 9, 215257 }, -- Scroll of Comprehension / 15
				{ 10, 213551 }, -- Scroll of Controlled Displacement / 15
				{ 11, 213564 }, -- Scroll of Minor Evocation / 15
				{ 12, 275069 }, -- Scroll of Rat Familiar / 15
				{ 13, 211800 }, -- Scroll of Reintegration / 15
			},
		},
		{
			name = AL["Deciphering Scrolls"],
			[NORMAL_DIFF] = {
				{ 1, 230903 }, -- Scroll: Essence of Fire / 71
				{ 2, 230947 }, -- Scroll: Essence of Frost / 71
				{ 3, 230946 }, -- Scroll: SEENECS FO ROFTS / 71
				{ 4, 231304 }, -- Scroll: SERELS PATALIS GNEMIND / 71
				{ 5, 281015 }, -- Scroll: DOST OREM / 50
				{ 6, 281016 }, -- Scroll: FORGOT HOOF THUD / 50
				{ 7, 281017 }, -- Scroll: KEEP CLEF FOCI / 50
				{ 8, 281018 }, -- Scroll: RARE SERVICHI RADAR / 50
				{ 9, 216879 }, -- Mysterious Troll Scroll / 40
				{ 10, 213545 }, -- Scroll: PEATCHY ATTAX / 30
				{ 11, 213546 }, -- Scroll: SHOOBEEDOOP / 30
				{ 12, 213547 }, -- Scroll: THAW WORDS / 30
				{ 13, 213544 }, -- Scroll: TOPAZ YORAK / 30
				{ 14, 213543 }, -- Scroll: UPDOG / 30
				{ 15, 211854 }, -- Scroll: OMIT KESA / 20
				{ 16, 211855 }, -- Scroll: STHENIC LUNATE / 20
				{ 17, 211853 }, -- Scroll: VOCE WELL / 20
				{ 18, 211784 }, -- Scroll: WUBBA WUBBA / 20
				{ 19, 211786 }, -- Scroll: CHAP BALK WELLES / 10
				{ 20, 211785 }, -- Scroll: CWAL / 10
				{ 21, 211780 }, -- Scroll: KWYJIBO / 10
				{ 22, 211787 }, -- Scroll: LOWER PING WHOMEVER / 10
			},
		},
	},
}
