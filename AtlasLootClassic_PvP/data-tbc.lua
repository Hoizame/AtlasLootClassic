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

local PVP_INSIGNIA = {	-- Insignias
	name = AL["Insignia"],
	NORMAL_ITTYPE = ICON_ITTYPE,
	ExtraList = true,
	[ALLIANCE_DIFF] = {
		{ 1, 37864, [PRICE_EXTRA_ITTYPE] = "honorA:40000" }, -- Medallion of the Alliance
		{ 3, 28235, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 4, 28237, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 5, 28238, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 6, 28236, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 7, 30349, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 8, 28234, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 9, 30351, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 10, 30348, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance
		{ 11, 30350, [PRICE_EXTRA_ITTYPE] = "honorA:8000" }, -- Medallion of the Alliance


		--{ 2, 25829, [PRICE_EXTRA_ITTYPE] = "honorA:22950:pvpEye:10" }, -- Talisman of the Alliance
		--{ 16, 28246 }, -- Band of Triumph
		--{ 17, 28247 }, -- Band of Dominance
	},
	[HORDE_DIFF] = {
		{ 1, 37865, [PRICE_EXTRA_ITTYPE] = "honorH:40000" }, -- Medallion of the Horde
		{ 3, 28241, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 4, 28243, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 5, 28239, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 6, 28242, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 7, 30346, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 8, 28240, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 9, 30345, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 10, 30343, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde
		{ 11, 30344, [PRICE_EXTRA_ITTYPE] = "honorH:8000" }, -- Medallion of the Horde

		--{ 2, 24551, [PRICE_EXTRA_ITTYPE] = "honorH:22950:pvpEye:10" }, -- Talisman of the Horde
		--{ 16, 28246 }, -- Band of Triumph
		--{ 17, 28247 }, -- Band of Dominance
	},
}

local PVP_GEMS = {	-- Insignias
	name = ALIL["Gems"],
	NORMAL_ITTYPE = ICON_ITTYPE,
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1, 28118, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Runed Ornate Ruby
		{ 2, 28362, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Bold Ornate Ruby

		{ 4, 28119, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Smooth Ornate Dawnstone
		{ 5, 28120, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Gleaming Ornate Dawnstone

		{ 16, 28123, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Potent Ornate Topaz
		{ 17, 28363, [PRICE_EXTRA_ITTYPE] = "honor:8500" }, -- Inscribed Ornate Topaz
	},
}

data["BCCHonorSet"] = {
	name = AL["Honor"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			name = ALIL["Sets"],
			TableType = SET_ITTYPE,
			[ALLIANCE_DIFF] = {
				{ 1,    591 }, -- Warlock
				{ 4,    691 }, -- Priest / Heal
				{ 5,    597 }, -- Priest / Shadow
				{ 7,    605 }, -- Rogue
				{ 9,    595 }, -- Hunter
				{ 11,   590 }, -- Warrior
				{ 16,   599 }, -- Mage
				{ 18,   688 }, -- Druid / Heal
				{ 19,   609 }, -- Druid / Owl
				{ 20,   601 }, -- Druid / Feral
				{ 22,   603 }, -- Shaman / Heal
				{ 23,   695 }, -- Shaman / Ele
				{ 24,   593 }, -- Shaman / Enh
				{ 26,   693 }, -- Paladin / Heal
				{ 27,   589 }, -- Paladin / Prot
				{ 28,   607 }, -- Paladin / DD
			},
			[HORDE_DIFF] = {
				{ 1,    592 }, -- Warlock
				{ 4,    692 }, -- Priest / Heal
				{ 5,    598 }, -- Priest / Shadow
				{ 7,    606 }, -- Rogue
				{ 9,    596 }, -- Hunter
				{ 11,   588 }, -- Warrior
				{ 16,   600 }, -- Mage
				{ 18,   689 }, -- Druid / Heal
				{ 19,   610 }, -- Druid / Owl
				{ 20,   602 }, -- Druid / Feral
				{ 22,   604 }, -- Shaman / Heal
				{ 23,   696 }, -- Shaman / Ele
				{ 24,   594 }, -- Shaman / Enh
				{ 26,   694 }, -- Paladin / Heal
				{ 27,   587 }, -- Paladin / Prot
				{ 28,   608 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[ALLIANCE_DIFF] = {
				{ 1, 28954 }, -- Grand Marshal's Shanker
				{ 2, 28955 }, -- Grand Marshal's Shiv

				{ 4, 28951 }, -- Grand Marshal's Pummeler
				{ 5, 28950 }, -- Grand Marshal's Bonecracker

				{ 7, 28956 }, -- Grand Marshal's Slicer
				{ 8, 28952 }, -- Grand Marshal's Quickblade

				{ 10, 28944 }, -- Grand Marshal's Cleaver
				{ 11, 28946 }, -- Grand Marshal's Hacker

				{ 13, 28953 }, -- Grand Marshal's Right Ripper
				{ 14, 28947 }, -- Grand Marshal's Left Ripper

				{ 16, 28957 }, -- Grand Marshal's Spellblade
			},
			[HORDE_DIFF] = {
				{ 1, 28929 }, -- High Warlord's Shanker
				{ 2, 28930 }, -- High Warlord's Shiv

				{ 4, 28925 }, -- High Warlord's Pummeler
				{ 5, 28924 }, -- High Warlord's Bonecracker

				{ 7, 28937 }, -- High Warlord's Slicer
				{ 8, 28926 }, -- High Warlord's Quickblade

				{ 10, 28920 }, -- High Warlord's Cleaver
				{ 11, 28921 }, -- High Warlord's Hacker

				{ 13, 28928 }, -- High Warlord's Right Ripper
				{ 14, 28922 }, -- High Warlord's Left Ripper

				{ 16, 28931 }, -- High Warlord's Spellblade
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[ALLIANCE_DIFF] = {
				{ 1, 28943 }, -- Grand Marshal's Warblade

				{ 3, 28945 }, -- Grand Marshal's Decapitator

				{ 5, 28949 }, -- Grand Marshal's Painsaw

				{ 7, 28942 }, -- Grand Marshal's Bonegrinder
				{ 8, 28948 }, -- Grand Marshal's Maul

				{ 16, 28959 }, -- Grand Marshal's War Staff
			},
			[HORDE_DIFF] = {
				{ 1, 28293 }, -- High Warlord's Claymore

				{ 3, 28918 }, -- High Warlord's Decapitator

				{ 5, 28923 }, -- High Warlord's Painsaw

				{ 7, 28917 }, -- High Warlord's Bonegrinder
				{ 8, 28919 }, -- High Warlord's Maul

				{ 16, 28935 }, -- High Warlord's War Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[ALLIANCE_DIFF] = {
				{ 1, 28960 }, -- Grand Marshal's Heavy Crossbow
			},
			[HORDE_DIFF] = {
				{ 1, 28933 }, -- High Warlord's Heavy Crossbow
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[ALLIANCE_DIFF] = {
				{ 1, 28940 }, -- Grand Marshal's Barricade
				{ 16, 28941 }, -- Grand Marshal's Battletome
			},
			[HORDE_DIFF] = {
				{ 1, 28939 }, -- High Warlord's Barricade
				{ 16, 28938 }, -- High Warlord's Battletome
			},
		},
		{
			name = ALIL["Back"],
			[ALLIANCE_DIFF] = {
				{ 1, 28377 }, -- Sergeant's Heavy Cloak
				{ 2, 28378 }, --Sergeant's Heavy Cloak
			},
			[HORDE_DIFF] = {
				{ 1, 28377 }, -- Sergeant's Heavy Cloak
				{ 2, 28378 }, --Sergeant's Heavy Cloak
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
	},
}

data["BCCReputationSet"] = {
	name = AL["Reputation"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			name = ALIL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    738 }, -- Warlock
				{ 4,    739 }, -- Priest / Heal
				{ 5,    740 }, -- Priest / Shadow
				{ 7,    745 }, -- Rogue
				{ 9,    749 }, -- Hunter
				{ 11,   750 }, -- Warrior
				{ 16,   741 }, -- Mage
				{ 18,   744 }, -- Druid / Heal
				{ 19,   743 }, -- Druid / Owl
				{ 20,   742 }, -- Druid / Feral
				{ 22,   747 }, -- Shaman / Heal
				{ 23,   746 }, -- Shaman / Ele
				{ 24,   748 }, -- Shaman / Enh
				{ 26,   751 }, -- Paladin / Heal
				{ 27,   752 }, -- Paladin / DD
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
	},
}

data["PvPMountsBCC"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	CorrespondingFields = {
		[1] = "Mounts",
	},
	items = {
		{ -- PvPMountsPvP
			name = ALIL["Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,  19030 }, -- Stormpike Battle Charger
				{ 3,  29467 }, -- Black War Ram
				{ 4,  29465 }, -- Black Battlestrider
				{ 5,  29468 }, -- Black War Steed Bridle
				{ 6,  29471 }, -- Reins of the Black War Tiger
				{ 7,  35906 }, -- Reins of the Black War Elekk
				{ 16,  30609 }, -- Swift Nether Drake
				{ 17,  37676 }, -- Vengeful Nether Drake
				{ 18,  34092 }, -- Merciless Nether Drake
				--{ 19,  43516 }, -- Brutal Nether Drake NYI
			},
			[HORDE_DIFF] = {
				{ 1, 19029  }, -- Horn of the Frostwolf Howler
				{ 3, 29469 }, -- Horn of the Black War Wolf
				{ 4, 29466 }, -- Black War Kodo
				{ 5, 29472 }, -- Whistle of the Black War Raptor
				{ 6, 29470 }, -- Red Skeletal Warhorse
				{ 7, 34129 }, -- Swift Warstrider
				{ 16,  30609 }, -- Swift Nether Drake
				{ 17,  37676 }, -- Vengeful Nether Drake
				{ 18,  34092 }, -- Merciless Nether Drake
				--{ 19,  43516 }, -- Brutal Nether Drake NYI
			},
		},
	},
}

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
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 28244 }, -- Pendant of Triumph
				{ 2, 28245 }, -- Pendant of Dominance
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 28246 }, -- Band of Triumph
				{ 2, 28247 }, -- Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[HORDE_DIFF] = {
				{ 1, 28411 }, -- General's Silk Cuffs
				{ 2, 28409 }, -- General's Silk Belt
				{ 3, 28410 }, -- General's Silk Footguards

				{ 5, 28405 }, -- General's Dreadweave Cuffs
				{ 6, 28404 }, -- General's Dreadweave Belt
				{ 7, 28402 }, -- General's Dreadweave Stalkers

				{ 9, 32973 }, -- General's Mooncloth Cuffs
				{ 10, 32974 }, -- General's Mooncloth Belt
				{ 11, 32975 }, -- General's Mooncloth Slippers
			},
			[ALLIANCE_DIFF] = {
				{ 1, 29002 }, -- Marshal's Silk Cuffs
				{ 2, 28409 }, -- Marshal's Silk Belt
				{ 3, 29003 }, -- Marshal's Silk Footguards

				{ 5, 28981 }, -- Marshal's Dreadweave Cuffs
				{ 6, 28980 }, -- Marshal's Dreadweave Belt
				{ 7, 28982 }, -- Marshal's Dreadweave Stalkers

				{ 9, 32977 }, -- Marshal's Mooncloth Cuffs
				{ 10, 32976 }, -- Marshal's Mooncloth Belt
				{ 11, 32978 }, -- Marshal's Mooncloth Slippers
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[HORDE_DIFF] = {
				{ 1, 28445 }, -- General's Dragonhide Bracers
				{ 2, 28443 }, -- General's Dragonhide Belt
				{ 3, 28444 }, -- General's Dragonhide Boots

				{ 5, 28424 }, -- General's Leather Bracers
				{ 6, 28423 }, -- General's Leather Belt
				{ 7, 28422 }, -- General's Leather Boots

				{ 16, 31598 }, -- General's Kodohide Bracers
				{ 17, 31594 }, -- General's Kodohide Belt
				{ 18, 31595 }, -- General's Kodohide Boots

				{ 20, 28448 }, -- General's Wyrmhide Bracers
				{ 21, 28446 }, -- General's Wyrmhide Belt
				{ 22, 28447 }, -- General's Wyrmhide Boots
			},
			[ALLIANCE_DIFF] = {
				{ 1, 28978 }, -- Marshal's Dragonhide Bracers
				{ 2, 28976 }, -- Marshal's Dragonhide Belt
				{ 3, 28977 }, -- Marshal's Dragonhide Boots

				{ 5, 28988 }, -- Marshal's Leather Bracers
				{ 6, 28986 }, -- Marshal's Leather Belt
				{ 7, 28987 }, -- Marshal's Leather Boots

				{ 16, 31599 }, -- Marshal's Kodohide Bracers
				{ 17, 31596 }, -- Marshal's Kodohide Belt
				{ 18, 31597 }, -- Marshal's Kodohide Boots

				{ 20, 29006 }, -- Marshal's Wyrmhide Bracers
				{ 21, 29004 }, -- Marshal's Wyrmhide Belt
				{ 22, 29005 }, -- Marshal's Wyrmhide Boots
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[HORDE_DIFF] = {
				{ 1, 32991 }, -- General's Ringmail Bracers
				{ 2, 32992 }, -- General's Ringmail Girdle
				{ 3, 32993 }, -- General's Ringmail Sabatons

				{ 5, 28638 }, -- General's Mail Bracers
				{ 6, 28639 }, -- General's Mail Girdle
				{ 7, 28640 }, -- General's Mail Sabatons

				{ 16, 28605 }, -- General's Linked Bracers
				{ 17, 28629 }, -- General's Linked Girdle
				{ 18, 28630 }, -- General's Linked Sabatons

				{ 20, 28451 }, -- General's Chain Bracers
				{ 21, 28450 }, -- General's Chain Girdle
				{ 22, 28449 }, -- General's Chain Sabatons
			},
			[ALLIANCE_DIFF] = {
				{ 1, 32994 }, -- Marshal's Ringmail Bracers
				{ 2, 32995 }, -- Marshal's Ringmail Girdle
				{ 3, 32996 }, -- Marshal's Ringmail Sabatons

				{ 5, 28992 }, -- Marshal's Mail Bracers
				{ 6, 28993 }, -- Marshal's Mail Girdle
				{ 7, 28994 }, -- Marshal's Mail Sabatons

				{ 16, 28989 }, -- Marshal's Linked Bracers
				{ 17, 28990 }, -- Marshal's Linked Girdle
				{ 18, 28991 }, -- Marshal's Linked Sabatons

				{ 20, 28973 }, -- Marshal's Chain Bracers
				{ 21, 28974 }, -- Marshal's Chain Girdle
				{ 22, 28975 }, -- Marshal's Chain Sabatons
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[HORDE_DIFF] = {
				{ 1, 28646 }, -- General's Scaled Bracers
				{ 2, 28644 }, -- General's Scaled Belt
				{ 3, 28645 }, -- General's Scaled Greaves

				{ 5, 28381 }, -- General's Plate Bracers
				{ 6, 28385 }, -- General's Plate Belt
				{ 7, 28383 }, -- General's Plate Greaves

				{ 16, 32983 }, -- General's Ornamented Bracers
				{ 17, 32982 }, -- General's Ornamented Belt
				{ 18, 32984 }, -- General's Ornamented Greaves

				{ 20, 28643 }, -- General's Lamellar Bracers
				{ 21, 28641 }, -- General's Lamellar Belt
				{ 22, 28642 }, -- General's Lamellar Greaves
			},
			[ALLIANCE_DIFF] = {
				{ 1, 28999 }, -- Marshal's Scaled Bracers
				{ 2, 28998 }, -- Marshal's Scaled Belt
				{ 3, 29000 }, -- Marshal's Scaled Greaves

				{ 5, 28996 }, -- Marshal's Plate Bracers
				{ 6, 28995 }, -- Marshal's Plate Belt
				{ 7, 28997 }, -- Marshal's Plate Greaves

				{ 16, 32986 }, -- Marshal's Ornamented Bracers
				{ 17, 32985 }, -- Marshal's Ornamented Belt
				{ 18, 32987 }, -- Marshal's Ornamented Greaves

				{ 20, 28984 }, -- Marshal's Lamellar Bracers
				{ 21, 28983 }, -- Marshal's Lamellar Belt
				{ 22, 28985 }, -- Marshal's Lamellar Greaves
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  30609 }, -- Swift Nether Drake
			}
		}
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
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 33066 }, -- Veteran's Pendant of Triumph
				{ 2, 33068 }, -- Veteran's Pendant of Salvation
				{ 3, 33065 }, -- Veteran's Pendant of Dominance
				{ 4, 33067 }, -- Veteran's Pendant of Conquest
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 33057 }, -- Veteran's Band of Triumph
				{ 2, 33064 }, -- Veteran's Band of Salvation
				{ 3, 33056 }, -- Veteran's Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 32820 }, -- Veteran's Silk Cuffs
				{ 2, 32807 }, -- Veteran's Silk Belt
				{ 3, 32795 }, -- Veteran's Silk Footguards

				{ 5, 32811 }, -- Veteran's Dreadweave Cuffs
				{ 6, 32799 }, -- Veteran's Dreadweave Belt
				{ 7, 32787 }, -- Veteran's Dreadweave Stalkers

				{ 9, 32980 }, -- Veteran's Mooncloth Cuffs
				{ 10, 32979 }, -- Veteran's Mooncloth Belt
				{ 11, 32981 }, -- Veteran's Mooncloth Slippers
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 32810 }, -- Veteran's Dragonhide Bracers
				{ 2, 32798 }, -- Veteran's Dragonhide Belt
				{ 3, 32786 }, -- Veteran's Dragonhide Boots

				{ 5, 32814 }, -- Veteran's Leather Bracers
				{ 6, 32802 }, -- Veteran's Leather Belt
				{ 7, 32790 }, -- Veteran's Leather Boots

				{ 16, 32812 }, -- Veteran's Kodohide Bracers
				{ 17, 32800 }, -- Veteran's Kodohide Belt
				{ 18, 32788 }, -- Veteran's Kodohide Boots

				{ 20, 32821 }, -- Veteran's Wyrmhide Bracers
				{ 21, 32808 }, -- Veteran's Wyrmhide Belt
				{ 22, 32796 }, -- Veteran's Wyrmhide Boots
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 32997 }, -- Veteran's Ringmail Bracers
				{ 2, 32998 }, -- Veteran's Ringmail Girdle
				{ 3, 32999 }, -- Veteran's Ringmail Sabatons

				{ 5, 32817 }, -- Veteran's Mail Bracers
				{ 6, 32804 }, -- Veteran's Mail Girdle
				{ 7, 32792 }, -- Veteran's Mail Sabatons

				{ 16, 32816 }, -- Veteran's Linked Bracers
				{ 17, 32803 }, -- Veteran's Linked Girdle
				{ 18, 32791 }, -- Veteran's Linked Sabatons

				{ 20, 32809 }, -- Veteran's Chain Bracers
				{ 21, 32797 }, -- Veteran's Chain Girdle
				{ 22, 32785 }, -- Veteran's Chain Sabatons
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 32819 }, -- Veteran's Scaled Bracers
				{ 2, 32806 }, -- Veteran's Scaled Belt
				{ 3, 32794 }, -- Veteran's Scaled Greaves

				{ 5, 32818 }, -- Veteran's Plate Bracers
				{ 6, 32805 }, -- Veteran's Plate Belt
				{ 7, 32793 }, -- Veteran's Plate Greaves

				{ 16, 32989 }, -- Veteran's Ornamented Bracers
				{ 17, 32988 }, -- Veteran's Ornamented Belt
				{ 18, 32990 }, -- Veteran's Ornamented Greaves

				{ 20, 32813 }, -- Veteran's Lamellar Bracers
				{ 21, 32801 }, -- Veteran's Lamellar Belt
				{ 22, 32789 }, -- Veteran's Lamellar Greaves
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  37676 }, -- Vengeful Nether Drake
			}
		}
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
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 33923 }, -- Vindicator's Pendant of Triumph
				{ 2, 35319 }, -- Vindicator's Pendant of Subjugation
				{ 3, 33922 }, -- Vindicator's Pendant of Salvation
				{ 4, 35317 }, -- Vindicator's Pendant of Reprieve
				{ 5, 33921 }, -- Vindicator's Pendant of Dominance
				{ 6, 33920 }, -- Vindicator's Pendant of Conquest
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 33919 }, -- Vindicator's Band of Triumph
				{ 2, 35320 }, -- Vindicator's Band of Subjugation
				{ 3, 33918 }, -- Vindicator's Band of Salvation
				{ 4, 33853 }, -- Vindicator's Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 33913 }, -- Vindicator's Silk Cuffs
				{ 2, 33912 }, -- Vindicator's Silk Belt
				{ 3, 33914 }, -- Vindicator's Silk Footguards

				{ 5, 33883 }, -- Vindicator's Dreadweave Cuffs
				{ 6, 33882 }, -- Vindicator's Dreadweave Belt
				{ 7, 33884 }, -- Vindicator's Dreadweave Stalkers

				{ 9, 33901 }, -- Vindicator's Mooncloth Cuffs
				{ 10, 33900 }, -- Vindicator's Mooncloth Belt
				{ 11, 33902 }, -- Vindicator's Mooncloth Slippers
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 33881 }, -- Vindicator's Dragonhide Bracers
				{ 2, 33879 }, -- Vindicator's Dragonhide Belt
				{ 3, 33880 }, -- Vindicator's Dragonhide Boots

				{ 5, 33893 }, -- Vindicator's Leather Bracers
				{ 6, 33891 }, -- Vindicator's Leather Belt
				{ 7, 33892 }, -- Vindicator's Leather Boots

				{ 16, 33887 }, -- Vindicator's Kodohide Bracers
				{ 17, 33885 }, -- Vindicator's Kodohide Belt
				{ 18, 33886 }, -- Vindicator's Kodohide Boots

				{ 20, 33917 }, -- Vindicator's Wyrmhide Bracers
				{ 21, 33915 }, -- Vindicator's Wyrmhide Belt
				{ 22, 33916 }, -- Vindicator's Wyrmhide Boots
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 33906 }, -- Vindicator's Ringmail Bracers
				{ 2, 33907 }, -- Vindicator's Ringmail Girdle
				{ 3, 33908 }, -- Vindicator's Ringmail Sabatons

				{ 5, 33897 }, -- Vindicator's Mail Bracers
				{ 6, 33898 }, -- Vindicator's Mail Girdle
				{ 7, 33899 }, -- Vindicator's Mail Sabatons

				{ 16, 33894 }, -- Vindicator's Linked Bracers
				{ 17, 33895 }, -- Vindicator's Linked Girdle
				{ 18, 33896 }, -- Vindicator's Linked Sabatons

				{ 20, 33876 }, -- Vindicator's Chain Bracers
				{ 21, 33877 }, -- Vindicator's Chain Girdle
				{ 22, 33878 }, -- Vindicator's Chain Sabatons
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 33910 }, -- Vindicator's Scaled Bracers
				{ 2, 33909 }, -- Vindicator's Scaled Belt
				{ 3, 33911 }, -- Vindicator's Scaled Greaves

				{ 5, 33813 }, -- Vindicator's Plate Bracers
				{ 6, 33811 }, -- Vindicator's Plate Belt
				{ 7, 33812 }, -- Vindicator's Plate Greaves

				{ 16, 33904 }, -- Vindicator's Ornamented Bracers
				{ 17, 33903 }, -- Vindicator's Ornamented Belt
				{ 18, 33905 }, -- Vindicator's Ornamented Greaves

				{ 20, 33889 }, -- Vindicator's Lamellar Bracers
				{ 21, 33888 }, -- Vindicator's Lamellar Belt
				{ 22, 33890 }, -- Vindicator's Lamellar Greaves
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  34092 }, -- Merciless Nether Drake
			}
		}
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
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 35135 }, -- Guardian's Pendant of Triumph
				{ 2, 37928 }, -- Guardian's Pendant of Subjugation
				{ 3, 35134 }, -- Guardian's Pendant of Salvation
				{ 4, 37929 }, -- Guardian's Pendant of Reprieve
				{ 5, 35133 }, -- Guardian's Pendant of Dominance
				{ 6, 35132 }, -- Guardian's Pendant of Conquest
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 35131 }, -- Guardian's Band of Triumph
				{ 2, 37927 }, -- Guardian's Band of Subjugation
				{ 3, 35130 }, -- Guardian's Band of Salvation
				{ 4, 35129 }, -- Guardian's Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 35179 }, -- Guardian's Silk Cuffs
				{ 2, 35164 }, -- Guardian's Silk Belt
				{ 3, 35149 }, -- Guardian's Silk Footguards

				{ 5, 35168 }, -- Guardian's Dreadweave Cuffs
				{ 6, 35153 }, -- Guardian's Dreadweave Belt
				{ 7, 35138 }, -- Guardian's Dreadweave Stalkers

				{ 9, 35174 }, -- Guardian's Mooncloth Cuffs
				{ 10, 35159 }, -- Guardian's Mooncloth Belt
				{ 11, 35144 }, -- Guardian's Mooncloth Slippers
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 35167 }, -- Guardian's Dragonhide Bracers
				{ 2, 35152 }, -- Guardian's Dragonhide Belt
				{ 3, 35137 }, -- Guardian's Dragonhide Boots

				{ 5, 35171 }, -- Guardian's Leather Bracers
				{ 6, 35156 }, -- Guardian's Leather Belt
				{ 7, 35141 }, -- Guardian's Leather Boots

				{ 16, 35169 }, -- Guardian's Kodohide Bracers
				{ 17, 35154 }, -- Guardian's Kodohide Belt
				{ 18, 35139 }, -- Guardian's Kodohide Boots

				{ 20, 35180 }, -- Guardian's Wyrmhide Bracers
				{ 21, 35165 }, -- Guardian's Wyrmhide Belt
				{ 22, 35150 }, -- Guardian's Wyrmhide Boots
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 35177 }, -- Guardian's Ringmail Bracers
				{ 2, 35162 }, -- Guardian's Ringmail Girdle
				{ 3, 35147 }, -- Guardian's Ringmail Sabatons

				{ 5, 35173 }, -- Guardian's Mail Bracers
				{ 6, 35158 }, -- Guardian's Mail Girdle
				{ 7, 35143 }, -- Guardian's Mail Sabatons

				{ 16, 35172 }, -- Guardian's Linked Bracers
				{ 17, 35157 }, -- Guardian's Linked Girdle
				{ 18, 35142 }, -- Guardian's Linked Sabatons

				{ 20, 35166 }, -- Guardian's Chain Bracers
				{ 21, 35151 }, -- Guardian's Chain Girdle
				{ 22, 35136 }, -- Guardian's Chain Sabatons
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 35178 }, -- Guardian's Scaled Bracers
				{ 2, 35163 }, -- Guardian's Scaled Belt
				{ 3, 35148 }, -- Guardian's Scaled Greaves

				{ 5, 35176 }, -- Guardian's Plate Bracers
				{ 6, 35161 }, -- Guardian's Plate Belt
				{ 7, 35146 }, -- Guardian's Plate Greaves

				{ 16, 35175 }, -- Guardian's Ornamented Bracers
				{ 17, 35160 }, -- Guardian's Ornamented Belt
				{ 18, 35145 }, -- Guardian's Ornamented Greaves

				{ 20, 35170 }, -- Guardian's Lamellar Bracers
				{ 21, 35155 }, -- Guardian's Lamellar Belt
				{ 22, 35140 }, -- Guardian's Lamellar Greaves
			},
		},
		PVP_INSIGNIA,
		PVP_GEMS,
		{
			name = AL["Gladiator Mount"]..BLIZZARD_NYI,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  43516 }, -- Brutal Nether Drake NYI
			}
		}
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
				{ 1, 28553 }, -- Band of the Exorcist
				{ 2, 28557}, -- Swift Starfire Diamond
				{ 3, 28759 }, -- Exorcist's Dreadweave Hood
				{ 4, 28574 }, -- Exorcist's Dragonhide Helm
				{ 5, 28575 }, -- Exorcist's Wyrmhide Helm
				{ 6, 28577 }, -- Exorcist's Linked Helm
				{ 7, 28560 }, -- Exorcist's Lamellar Helm
				{ 8, 28761 }, -- Exorcist's Scaled Helm
				{ 10, 32947 }, -- Auchenai Healing Potion
				{ 12, 28558 }, -- Spirit Shard
				{ 16, 28555 }, -- Seal of the Exorcist
				{ 17, 28556 }, -- Swift Windfire Diamond
				{ 18, 28760 }, -- Exorcist's Silk Hood
				{ 19, 28561 }, -- Exorcist's Leather Helm
				{ 20, 28576 }, -- Exorcist's Chain Helm
				{ 21, 28758 }, -- Exorcist's Mail Helm
				{ 22, 28559 }, -- Exorcist's Plate Helm
				{ 25, 32948 }, -- Auchenai Mana Potion
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
