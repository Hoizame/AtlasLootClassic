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
local data = AtlasLoot.ItemDB:Add(addonname, 1, 2)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
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
local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local ARENA_CONTENT = data:AddContentType(AL["Arena"], ATLASLOOT_PVP_COLOR)
local OPEN_WORLD_CONTENT = data:AddContentType(AL["Open World"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
local BLIZZARD_NYI = " |cff00ccff<NYI |T130946:12:20:0:0:32:16:4:28:0:16|t>|r"

data["ArenaS1PvP"] = {
	name = format(AL["Season %s"], "1"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    568 }, -- Warlock
				{ 2,    615 }, -- Warlock 2
				{ 4,    687 }, -- Priest / Heal
				{ 5,    581 }, -- Priest / Shadow
				{ 7,    577 }, -- Rogue
				{ 9,    586 }, -- Hunter
				{ 11,   567 }, -- Warrior
				{ 16,   579 }, -- Mage
				{ 18,   685 }, -- Druid / Heal
				{ 19,   585 }, -- Druid / Owl
				{ 20,   584 }, -- Druid / Feral
				{ 22,   580 }, -- Shaman / Heal
				{ 23,   686 }, -- Shaman / Ele
				{ 24,   578 }, -- Shaman / Enh
				{ 26,   690 }, -- Paladin / Heal
				{ 27,   582 }, -- Paladin / Prot
				{ 28,   583 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 28312 }, -- Gladiator's Shanker
				{ 2, 28310 }, -- Gladiator's Shiv

				{ 4, 28305 }, -- Gladiator's Pummeler
				{ 5, 28302 }, -- Gladiator's Bonecracker

				{ 7, 28295 }, -- Gladiator's Slicer
				{ 8, 28307 }, -- Gladiator's Quickblade

				{ 10, 28308 }, -- Gladiator's Cleaver
				{ 11, 28309 }, -- Gladiator's Hacker

				{ 13, 28313 }, -- Gladiator's Right Ripper
				{ 14, 28314 }, -- Gladiator's Left Ripper

				{ 16, 28297 }, -- Gladiator's Spellblade

				{ 19, 32450 }, -- Gladiator's Gavel
				{ 20, 32451 }, -- Gladiator's Salvation
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 24550 }, -- Gladiator's Greatsword

				{ 3, 28298 }, -- Gladiator's Decapitator

				{ 5, 28300 }, -- Gladiator's Painsaw

				{ 7, 28299 }, -- Gladiator's Bonegrinder
				{ 8, 28476 }, -- Gladiator's Maul

				{ 16, 24557 }, -- Gladiator's War Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 28294 }, -- Gladiator's Heavy Crossbow
				{ 3, 28319 }, -- Gladiator's War Edge

				{ 16, 28320 }, -- Gladiator's Touch of Defeat
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 28358 }, -- Gladiator's Shield Wall
				{ 16, 28346 }, -- Gladiator's Endgame
				{ 17, 32452 }, -- Gladiator's Repriev
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 33942 }, -- Gladiator's Idol of Steadfastness
				{ 2, 33945 }, -- Gladiator's Idol of Resolve
				{ 3, 28355 }, -- Gladiator's Idol of Tenacity
				{ 5, 28356 }, -- Gladiator's Libram of Justice
				{ 6, 33936 }, -- Gladiator's Libram of Fortitude
				{ 7, 33948 }, -- Gladiator's Libram of Vengeance
				{ 16, 28357 }, -- Gladiator's Totem of the Third Wind
				{ 17, 33951 }, -- Gladiator's Totem of Survival
				{ 18, 33939 }, -- Gladiator's Totem of Indomitability
			},
		},
	}
}

data["ArenaS2PvP"] = {
	name = format(AL["Season %s"], "2"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"]..BLIZZARD_NYI,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    702 }, -- Warlock
				{ 2,    704 }, -- Warlock 2
				{ 4,    705 }, -- Priest / Heal
				{ 5,    707 }, -- Priest / Shadow
				{ 7,    713 }, -- Rogue
				{ 9,    706 }, -- Hunter
				{ 11,   701 }, -- Warrior
				{ 16,   710 }, -- Mage
				{ 18,   709 }, -- Druid / Heal
				{ 19,   716 }, -- Druid / Owl
				{ 20,   711 }, -- Druid / Feral
				{ 22,   712 }, -- Shaman / Heal
				{ 23,   715 }, -- Shaman / Ele
				{ 24,   703 }, -- Shaman / Enh
				{ 26,   708 }, -- Paladin / Heal
				{ 27,   700 }, -- Paladin / Prot
				{ 28,   714 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 32044 }, -- Gladiator's Shanker
				{ 2, 32046 }, -- Gladiator's Shiv

				{ 4, 32026 }, -- Gladiator's Pummeler
				{ 5, 31958 }, -- Gladiator's Bonecracker

				{ 7, 32052 }, -- Gladiator's Slicer
				{ 8, 32027 }, -- Gladiator's Quickblade

				{ 10, 31965 }, -- Gladiator's Cleaver
				{ 11, 31985 }, -- Gladiator's Hacker

				{ 13, 32028 }, -- Gladiator's Right Ripper
				{ 14, 32003 }, -- Gladiator's Left Ripper

				{ 16, 32053 }, -- Gladiator's Spellblade

				{ 19, 32963 }, -- Gladiator's Gavel
				{ 20, 32964 }, -- Gladiator's Salvation
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 31984 }, -- Gladiator's Greatsword

				{ 3, 31966 }, -- Gladiator's Decapitator

				{ 5, 32025 }, -- Gladiator's Painsaw

				{ 7, 31959 }, -- Gladiator's Bonegrinder
				{ 8, 32014 }, -- Gladiator's Maul

				{ 16, 32055 }, -- Gladiator's War Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 31986 }, -- Gladiator's Heavy Crossbow
				{ 3, 32054 }, -- Gladiator's War Edge

				{ 16, 32962 }, -- Gladiator's Touch of Defeat
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 32045 }, -- Gladiator's Shield Wall
				{ 16, 31978 }, -- Gladiator's Endgame
				{ 17, 32961 }, -- Gladiator's Repriev
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 33943 }, -- Gladiator's Idol of Steadfastness
				{ 2, 33946 }, -- Gladiator's Idol of Resolve
				{ 3, 33076 }, -- Gladiator's Idol of Tenacity
				{ 5, 33077 }, -- Gladiator's Libram of Justice
				{ 6, 33937 }, -- Gladiator's Libram of Fortitude
				{ 7, 33949 }, -- Gladiator's Libram of Vengeance
				{ 16, 33078 }, -- Gladiator's Totem of the Third Wind
				{ 17, 33952 }, -- Gladiator's Totem of Survival
				{ 18, 33940 }, -- Gladiator's Totem of Indomitability
			},
		},
	}
}

data["ArenaS3PvP"] = {
	name = format(AL["Season %s"], "3"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"]..BLIZZARD_NYI,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    734 }, -- Warlock
				{ 2,    735 }, -- Warlock 2
				{ 4,    728 }, -- Priest / Heal
				{ 5,    729 }, -- Priest / Shadow
				{ 7,    730 }, -- Rogue
				{ 9,    723 }, -- Hunter
				{ 11,   736 }, -- Warrior
				{ 16,   724 }, -- Mage
				{ 18,   720 }, -- Druid / Heal
				{ 19,   722 }, -- Druid / Owl
				{ 20,   721 }, -- Druid / Feral
				{ 22,   733 }, -- Shaman / Heal
				{ 23,   731 }, -- Shaman / Ele
				{ 24,   732 }, -- Shaman / Enh
				{ 26,   725 }, -- Paladin / Heal
				{ 27,   727 }, -- Paladin / Prot
				{ 28,   726 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 33754 }, -- Gladiator's Shanker
				{ 2, 33756 }, -- Gladiator's Shiv
				{ 3, 33801 }, -- Vengeful Gladiator's Mutilator

				{ 5, 33733 }, -- Gladiator's Pummeler
				{ 6, 33662 }, -- Gladiator's Bonecracker

				{ 8, 33762 }, -- Gladiator's Slicer
				{ 9, 33734 }, -- Gladiator's Quickblade

				{ 11, 33669 }, -- Gladiator's Cleaver
				{ 12, 33689 }, -- Gladiator's Hacker
				{ 13, 34015 }, -- Vengeful Gladiator's Chopper

				{ 28, 33737 }, -- Gladiator's Right Ripper
				{ 29, 33705 }, -- Gladiator's Left Ripper
				{ 30, 34016 }, -- Vengeful Gladiator's Left Render

				{ 16, 33763 }, -- Gladiator's Spellblade

				{ 20, 33687 }, -- Gladiator's Gavel
				{ 21, 33743 }, -- Gladiator's Salvation
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 33688 }, -- Gladiator's Greatsword

				{ 3, 33670 }, -- Gladiator's Decapitator
				{ 4, 34014 }, -- Vengeful Gladiator's Waraxe

				{ 6, 33727 }, -- Gladiator's Painsaw

				{ 8, 33663 }, -- Gladiator's Bonegrinder
				{ 9, 32014 }, -- Gladiator's Maul

				{ 16, 33766 }, -- Gladiator's War Staff
				{ 17, 34540 }, -- Vengeful Gladiator's Battle Staff
				{ 19, 33716 }, -- Vengeful Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 34529 }, -- Vengeful Gladiator's Longbow
				{ 3, 33006 }, -- Gladiator's Heavy Crossbow
				{ 5, 34530 }, -- Vengeful Gladiator's Rifle
				{ 7, 33765 }, -- Gladiator's War Edge

				{ 16, 33764 }, -- Gladiator's Touch of Defeat
				{ 17, 34059 }, -- Vengeful Gladiator's Baton of Light
				{ 18, 34066 }, -- Vengeful Gladiator's Piercing Touch
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 33755 }, -- Vengeful Gladiator's Shield Wall
				{ 3, 33661 }, -- Vengeful Gladiator's Barrier
				{ 4, 33735 }, -- Vengeful Gladiator's Redoubt
				{ 16, 33681 }, -- Gladiator's Endgame
				{ 17, 33736 }, -- Gladiator's Reprieve
				{ 18, 34033 }, -- Vengeful Gladiator's Grimoire
			},
		},

		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 33944 }, -- Gladiator's Idol of Steadfastness
				{ 2, 33947 }, -- Gladiator's Idol of Resolve
				{ 3, 33841 }, -- Gladiator's Idol of Tenacity
				{ 5, 33842 }, -- Gladiator's Libram of Justice
				{ 6, 33938 }, -- Gladiator's Libram of Fortitude
				{ 7, 33950 }, -- Gladiator's Libram of Vengeance
				{ 16, 33843 }, -- Gladiator's Totem of the Third Wind
				{ 17, 33953 }, -- Gladiator's Totem of Survival
				{ 18, 33941 }, -- Gladiator's Totem of Indomitability
			},
		},
	}
}

data["ArenaS4PvP"] = {
	name = format(AL["Season %s"], "4"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"]..BLIZZARD_NYI,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				-- NYI
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 35093 }, -- Gladiator's Shanker
				{ 2, 35095 }, -- Gladiator's Shiv
				{ 3, 35058 }, -- Vengeful Gladiator's Mutilator

				{ 5, 35071 }, -- Gladiator's Pummeler
				{ 6, 34988 }, -- Gladiator's Bonecracker

				{ 8, 35101 }, -- Gladiator's Slicer
				{ 9, 35072 }, -- Gladiator's Quickblade

				{ 11, 34996 }, -- Gladiator's Cleaver
				{ 12, 35017 }, -- Gladiator's Hacker
				{ 13, 34995 }, -- Vengeful Gladiator's Chopper
				{ 14, 36737 }, -- Brutal Gladiator's Hatchet

				{ 28, 35076 }, -- Gladiator's Right Ripper
				{ 29, 35038 }, -- Gladiator's Left Ripper
				{ 30, 35037 }, -- Vengeful Gladiator's Left Render

				{ 16, 35102 }, -- Gladiator's Spellblade
				{ 17, 37739 }, -- Brutal Gladiator's Blade of Alacrity

				{ 20, 35014 }, -- Gladiator's Gavel
				{ 21, 35082 }, -- Gladiator's Salvation
				{ 22, 37740 }, -- Brutal Gladiator's Swift Judgement
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 35015 }, -- Gladiator's Greatsword

				{ 3, 34997 }, -- Gladiator's Decapitator
				{ 4, 35110 }, -- Vengeful Gladiator's Waraxe

				{ 6, 35064 }, -- Gladiator's Painsaw

				{ 8, 34989 }, -- Gladiator's Bonegrinder

				{ 16, 35109 }, -- Gladiator's War Staff
				{ 17, 34987 }, -- Vengeful Gladiator's Battle Staff
				{ 19, 35103 }, -- Vengeful Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 35047 }, -- Vengeful Gladiator's Longbow
				{ 3, 35018 }, -- Gladiator's Heavy Crossbow
				{ 5, 35075 }, -- Vengeful Gladiator's Rifle
				{ 7, 35108 }, -- Gladiator's War Edge

				{ 16, 35107 }, -- Gladiator's Touch of Defeat
				{ 17, 34985 }, -- Vengeful Gladiator's Baton of Light
				{ 18, 35065 }, -- Vengeful Gladiator's Piercing Touch
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 35094 }, -- Vengeful Gladiator's Shield Wall
				{ 3, 34986 }, -- Vengeful Gladiator's Barrier
				{ 4, 35073 }, -- Vengeful Gladiator's Redoubt
				{ 16, 35008 }, -- Gladiator's Endgame
				{ 17, 35074 }, -- Gladiator's Reprieve
				{ 18, 35016 }, -- Vengeful Gladiator's Grimoire
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 35020 }, -- Gladiator's Idol of Steadfastness
				{ 2, 35019 }, -- Gladiator's Idol of Resolve
				{ 3, 35021 }, -- Gladiator's Idol of Tenacity
				{ 5, 35040 }, -- Gladiator's Libram of Justice
				{ 6, 35039 }, -- Gladiator's Libram of Fortitude
				{ 7, 35041 }, -- Gladiator's Libram of Vengeance
				{ 16, 35106 }, -- Gladiator's Totem of the Third Wind
				{ 17, 35105 }, -- Gladiator's Totem of Survival
				{ 18, 35104 }, -- Gladiator's Totem of Indomitability
			},
		},
	}
}

data["HellfirePeninsulaPvP"] = {
	MapID = 3483,
	ContentType = OPEN_WORLD_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			MapID = 3483,
			[ALLIANCE_DIFF] = {
				{ 1, 24520 }, -- Honor Hold Favor
				{ 3, 24579 }, -- Mark of Honor Hold
				{ 16, 27830 }, -- Circlet of the Victor
				{ 17, 27785 }, -- Notched Deep Peridot
				{ 18, 27777 }, -- Stark Blood Garnet
			},
			[HORDE_DIFF] = {
				{ 1, 24522 }, -- Thrallmar Favor
				{ 3, 24581 }, -- Mark of Thrallmar
				{ 16, 27833 }, -- Band of the Victor
				{ 17, 27786 }, -- Barbed Deep Peridot
				{ 18, 28360 }, -- Mighty Blood Garnet
			},
		},
	},
}

data["NagrandPvP"] = {
	MapID = 3518,
	ContentType = OPEN_WORLD_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 28915, [PRICE_EXTRA_ITTYPE] = "HalaaBT:70:HalaaRT:15" }, -- Reins of the Dark Riding Talbuk
				{ 2, 27679, [PRICE_EXTRA_ITTYPE] = "HalaaBT:100" }, -- Sublime Mystic Dawnstone
				{ 3, 27649, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Hierophant's Leggings
				{ 4, 27648, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Dreamstalker Leggings
				{ 5, 27650, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Shadowstalker's Leggings
				{ 6, 27647, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Marksman's Legguards
				{ 7, 27652, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Stormbreaker's Leggings
				{ 8, 27654, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Avenger's Legplates
				{ 9, 27653, [PRICE_EXTRA_ITTYPE] = "HalaaBT:40:HalaaRT:2" }, -- Slayer's Leggings
				{ 11, 24208, [PRICE_EXTRA_ITTYPE] = "money:120000" }, -- Design: Mystic Dawnstone
				{ 14, 26045 }, -- Halaa Battle Token
				{ 16, 29228, [PRICE_EXTRA_ITTYPE] = "HalaaBT:100:HalaaRT:20" }, -- Reins of the Dark War Talbuk
				{ 17, 27680, [PRICE_EXTRA_ITTYPE] = "HalaaRT:8" }, -- Halaani Bag
				{ 18, 27638, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Hierophant's Sash
				{ 19, 27645, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Dreamstalker Sash
				{ 20, 27637, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Shadowstalker's Sash
				{ 21, 27646, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Marksman's Belt
				{ 22, 27643, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Stormbreaker's Girdle
				{ 23, 27644, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Avenger's Waistguard
				{ 24, 27639, [PRICE_EXTRA_ITTYPE] = "HalaaBT:20:HalaaRT:1" }, -- Slayer's Waistguard
				{ 26, 33783, [PRICE_EXTRA_ITTYPE] = "HalaaRT:4" }, -- Design: Steady Talasite
				{ 27, 32071, [PRICE_EXTRA_ITTYPE] = "HalaaRT:2" }, -- Recipe: Elixir of Ironskin
				{ 29, 26044 }, -- Halaa Research Token
			},
		},
		{
			MapID = 3518,
			[ALLIANCE_DIFF] = {
				{ 1, 30611 }, -- Halaani Razorshaft
				{ 2, 30612 }, -- Halaani Grimshot
				{ 3, 30615 }, -- Halaani Whiskey
				{ 16, 30598 }, -- Don Amancio's Heart
				{ 17, 30597 }, -- Halaani Claymore
				{ 18, 30599 }, -- Avenging Blades
			},
			[HORDE_DIFF] = {
				{ 1, 30611 }, -- Halaani Razorshaft
				{ 2, 30612 }, -- Halaani Grimshot
				{ 3, 30615 }, -- Halaani Whiskey
				{ 16, 30571 }, -- Don Rodrigo's Heart
				{ 17, 30570 }, -- Arkadian Claymore
				{ 18, 30568 }, -- The Sharp Cookie
			}
		}
	},
}

data["TerokkarPvP"] = {
	MapID = 3519,
	ContentType = OPEN_WORLD_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			MapID = 3519,
			[NORMAL_DIFF] = {
				{ 1, 28553, [PRICE_EXTRA_ITTYPE] = "SpiritShard:50" }, -- Band of the Exorcist
				{ 2, 28557, [PRICE_EXTRA_ITTYPE] = "SpiritShard:8" }, -- Swift Starfire Diamond
				{ 3, 28759, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Dreadweave Hood
				{ 4, 28574, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Dragonhide Helm
				{ 5, 28575, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Wyrmhide Helm
				{ 6, 28577, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Linked Helm
				{ 7, 28560, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Lamellar Helm
				{ 8, 28761, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Scaled Helm
				{ 10, 32947, [PRICE_EXTRA_ITTYPE] = "SpiritShard:2" }, -- Auchenai Healing Potion
				{ 12, 28558 }, -- Spirit Shard
				{ 16, 28555, [PRICE_EXTRA_ITTYPE] = "SpiritShard:50" }, -- Seal of the Exorcist
				{ 17, 28556, [PRICE_EXTRA_ITTYPE] = "SpiritShard:8" }, -- Swift Windfire Diamond
				{ 18, 28760, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Silk Hood
				{ 19, 28561, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Leather Helm
				{ 20, 28576, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Chain Helm
				{ 21, 28758, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Mail Helm
				{ 22, 28559, [PRICE_EXTRA_ITTYPE] = "SpiritShard:18" }, -- Exorcist's Plate Helm
				{ 25, 32948, [PRICE_EXTRA_ITTYPE] = "SpiritShard:2" }, -- Auchenai Mana Potion
			}
		}
	}
}

data["ZangarmarshPvP"] = {
	MapID = 3521,
	ContentType = OPEN_WORLD_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			MapID = 3521,
			[ALLIANCE_DIFF] = {
				{ 1, 27990, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Idol of Savagery
				{ 2, 27984, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Totem of Impact
				{ 3, 27929, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Terminal Edge
				{ 4, 27939, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Incendic Rod
				{ 5, 27983, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Libram of Zeal
				{ 6, 27930, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:15" }, -- Splintermark
				{ 8, 24579 }, -- Mark of Honor Hold
				{ 16, 27922, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:30" }, -- Mark of Defiance
				{ 17, 27920, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:30" }, -- Mark of Conquest
				{ 18, 27927, [PRICE_EXTRA_ITTYPE] = "MarkOfHonorHold:30" }, -- Mark of Vindication
			},
			[HORDE_DIFF] = {
				{ 1, 27990, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:5" }, -- Idol of Savagery
				{ 2, 27984, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:15" }, -- Totem of Impact
				{ 3, 27929, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:15" }, -- Terminal Edge
				{ 4, 27939, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:15" }, -- Incendic Rod
				{ 5, 27983, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:15" }, -- Libram of Zeal
				{ 6, 27930, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:15" }, -- Splintermark
				{ 8, 24581 }, -- Mark of Thrallmar
				{ 16, 27922, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:30" }, -- Mark of Defiance
				{ 17, 27920, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:30" }, -- Mark of Conquest
				{ 18, 27927, [PRICE_EXTRA_ITTYPE] = "MarkOfThrallmar:30" }, -- Mark of Vindication
			},
		}
	}
}
