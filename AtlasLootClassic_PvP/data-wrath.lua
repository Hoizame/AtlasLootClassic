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
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.WRATH_VERSION_NUM)

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
local SET1_DIFF = data:AddDifficulty(format(AL["Savage %s"], ""), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Hateful %s"], ""), "set2", nil, 1)
local SET3_DIFF = data:AddDifficulty(format(AL["Deadly %s"], ""), "set3", nil, 1)

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

local _DUMMY_SET = {
	name = AL["Sets"],
	TableType = SET_ITTYPE,
	[SET1_DIFF] = {
		{ 1,    3000780 }, -- Warlock
		{ 3,    3000777 }, -- Priest / Heal
        { 4,    3000778 }, -- Priest / Shadow
        { 6,    3000776 }, -- Rogue
		{ 8,    3000772 }, -- Hunter
		{ 10,   3000780 }, -- Warrior / DD
        { 13,   3000768 }, -- Deathknight
		{ 16,   3000779 }, -- Mage
        { 18,   3000773 }, -- Druid / Heal
        { 19,   3000774 }, -- Druid / Owl
        { 20,   3000775 }, -- Druid / Feral
        { 22,   3000771 }, -- Shaman / Heal
        { 23,   3000769 }, -- Shaman / Ele
        { 24,   3000770 }, -- Shaman / Enh
        { 26,   3000767 }, -- Paladin / Heal
        { 27,   3000766 }, -- Paladin / DD
	},
	[SET2_DIFF] = {
		{ 1,    3001780 }, -- Warlock
		{ 3,    3001777 }, -- Priest / Heal
        { 4,    3001778 }, -- Priest / Shadow
        { 6,    3001776 }, -- Rogue
		{ 8,    3001772 }, -- Hunter
		{ 10,   3001780 }, -- Warrior / DD
        { 13,   3001768 }, -- Deathknight
		{ 16,   3001779 }, -- Mage
        { 18,   3001773 }, -- Druid / Heal
        { 19,   3001774 }, -- Druid / Owl
        { 20,   3001775 }, -- Druid / Feral
        { 22,   3001771 }, -- Shaman / Heal
        { 23,   3001769 }, -- Shaman / Ele
        { 24,   3001770 }, -- Shaman / Enh
        { 26,   3001767 }, -- Paladin / Heal
        { 27,   3001766 }, -- Paladin / DD
	},
	[SET3_DIFF] = {
		{ 1,    3002780 }, -- Warlock
		{ 3,    3002777 }, -- Priest / Heal
        { 4,    3002778 }, -- Priest / Shadow
        { 6,    3002776 }, -- Rogue
		{ 8,    3002772 }, -- Hunter
		{ 10,   3002780 }, -- Warrior / DD
        { 13,   3002768 }, -- Deathknight
		{ 16,   3002779 }, -- Mage
        { 18,   3002773 }, -- Druid / Heal
        { 19,   3002774 }, -- Druid / Owl
        { 20,   3002775 }, -- Druid / Feral
        { 22,   3002771 }, -- Shaman / Heal
        { 23,   3002769 }, -- Shaman / Ele
        { 24,   3002770 }, -- Shaman / Enh
        { 26,   3002767 }, -- Paladin / Heal
        { 27,   3002766 }, -- Paladin / DD
	},
}

data["PvPMountsWrath"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	CorrespondingFields = private.MOUNTS_LINK,
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
				{ 16,  46708 }, -- Deadly Gladiator's Frost Wyrm
				{ 17,  46171 }, -- Furious  Gladiator's Frost Wyrm
				{ 18,  47840 }, -- Relentless Gladiator's Frost Wyrm
				{ 19,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			},
			[HORDE_DIFF] = {
				{ 1, 19029  }, -- Horn of the Frostwolf Howler
				{ 3, 29469 }, -- Horn of the Black War Wolf
				{ 4, 29466 }, -- Black War Kodo
				{ 5, 29472 }, -- Whistle of the Black War Raptor
				{ 6, 29470 }, -- Red Skeletal Warhorse
				{ 7, 34129 }, -- Swift Warstrider
				{ 16,  46708 }, -- Deadly Gladiator's Frost Wyrm
				{ 17,  46171 }, -- Furious  Gladiator's Frost Wyrm
				{ 18,  47840 }, -- Relentless Gladiator's Frost Wyrm
				{ 19,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			},
		},
	},
}

data["ArenaS5PvP"] = {
	name = format(AL["Season %s"], "5"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET1_DIFF] = {
				{ 1,    3000780 }, -- Warlock
				{ 3,    3000777 }, -- Priest / Heal
				{ 4,    3000778 }, -- Priest / Shadow
				{ 6,    3000776 }, -- Rogue
				{ 8,    3000772 }, -- Hunter
				{ 10,   3000765 }, -- Warrior / DD
				{ 13,   3000768 }, -- Deathknight
				{ 16,   3000779 }, -- Mage
				{ 18,   3000773 }, -- Druid / Heal
				{ 19,   3000774 }, -- Druid / Owl
				{ 20,   3000775 }, -- Druid / Feral
				{ 22,   3000771 }, -- Shaman / Heal
				{ 23,   3000769 }, -- Shaman / Ele
				{ 24,   3000770 }, -- Shaman / Enh
				{ 26,   3000767 }, -- Paladin / Heal
				{ 27,   3000766 }, -- Paladin / DD
			},
			[SET2_DIFF] = {
				{ 1,    3001780 }, -- Warlock
				{ 3,    3001777 }, -- Priest / Heal
				{ 4,    3001778 }, -- Priest / Shadow
				{ 6,    3001776 }, -- Rogue
				{ 8,    3001772 }, -- Hunter
				{ 10,   3001765 }, -- Warrior / DD
				{ 13,   3001768 }, -- Deathknight
				{ 16,   3001779 }, -- Mage
				{ 18,   3001773 }, -- Druid / Heal
				{ 19,   3001774 }, -- Druid / Owl
				{ 20,   3001775 }, -- Druid / Feral
				{ 22,   3001771 }, -- Shaman / Heal
				{ 23,   3001769 }, -- Shaman / Ele
				{ 24,   3001770 }, -- Shaman / Enh
				{ 26,   3001767 }, -- Paladin / Heal
				{ 27,   3001766 }, -- Paladin / DD
			},
			[SET3_DIFF] = {
				{ 1,    3002780 }, -- Warlock
				{ 3,    3002777 }, -- Priest / Heal
				{ 4,    3002778 }, -- Priest / Shadow
				{ 6,    3002776 }, -- Rogue
				{ 8,    3002772 }, -- Hunter
				{ 10,   3002765 }, -- Warrior / DD
				{ 13,   3002768 }, -- Deathknight
				{ 16,   3002779 }, -- Mage
				{ 18,   3002773 }, -- Druid / Heal
				{ 19,   3002774 }, -- Druid / Owl
				{ 20,   3002775 }, -- Druid / Feral
				{ 22,   3002771 }, -- Shaman / Heal
				{ 23,   3002769 }, -- Shaman / Ele
				{ 24,   3002770 }, -- Shaman / Enh
				{ 26,   3002767 }, -- Paladin / Heal
				{ 27,   3002766 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[SET1_DIFF] = {
				{ 1, 42216 }, -- Savage Gladiator's Shanker
				{ 2, 42217 }, -- Savage Gladiator's Shiv
				{ 3, 42215 }, -- Savage Gladiator's Mutilator

				{ 5, 42222 }, -- Savage Gladiator's Pummeler
				{ 6, 42221 }, -- Savage Gladiator's Bonecracker

				{ 8, 42224 }, -- Savage Gladiator's Slicer
				{ 9, 42223 }, -- Savage Gladiator's Quickblade

				{ 11, 42206 }, -- Savage Gladiator's Cleaver
				{ 12, 42213 }, -- Savage Gladiator's Hacker
				{ 13, 42212 }, -- Savage Gladiator's Chopper

				{ 15, 42214 }, -- Savage Gladiator's Waraxe

				{ 16, 42343 }, -- Savage Gladiator's Spellblade
				{ 20, 42344 }, -- Savage Gladiator's Gavel

				{ 26, 42218 }, -- Savage Gladiator's Right Ripper
				{ 27, 42220 }, -- Savage Gladiator's Left Ripper
				{ 28, 42219 }, -- Savage Gladiator's Left Render
			},
			[SET2_DIFF] = {
				{ 1, 42241 }, -- Hateful Gladiator's Shanker
				{ 2, 42247 }, -- Hateful Gladiator's Shiv
				{ 3, 42254 }, -- Hateful Gladiator's Mutilator

				{ 5, 42274 }, -- Hateful Gladiator's Pummeler
				{ 6, 42279 }, -- Hateful Gladiator's Bonecracker

				{ 8, 42284 }, -- Hateful Gladiator's Slicer
				{ 9, 42289 }, -- Hateful Gladiator's Quickblade

				{ 11, 42207 }, -- Hateful Gladiator's Cleaver
				{ 12, 42226 }, -- Hateful Gladiator's Hacker
				{ 13, 42231 }, -- Hateful Gladiator's Chopper

				{ 15, 42236 }, -- Hateful Gladiator's Waraxe

				{ 16, 42345 }, -- Hateful Gladiator's Spellblade
				{ 20, 42351 }, -- Hateful Gladiator's Gavel

				{ 26, 42259 }, -- Hateful Gladiator's Right Ripper
				{ 27, 42269 }, -- Hateful Gladiator's Left Ripper
				{ 28, 42264 }, -- Hateful Gladiator's Left Render
			},
			[SET3_DIFF] = {
				{ 1, 42242 }, -- Deadly Gladiator's Shanker
				{ 2, 42248 }, -- Deadly Gladiator's Shiv
				{ 3, 42255 }, -- Deadly Gladiator's Mutilator

				{ 5, 42275 }, -- Deadly Gladiator's Pummeler
				{ 6, 42280 }, -- Deadly Gladiator's Bonecracker

				{ 8, 42285 }, -- Deadly Gladiator's Slicer
				{ 9, 42290 }, -- Deadly Gladiator's Quickblade

				{ 11, 42208 }, -- Deadly Gladiator's Cleaver
				{ 12, 42227 }, -- Deadly Gladiator's Hacker
				{ 13, 42232 }, -- Deadly Gladiator's Chopper

				{ 15, 42237 }, -- Deadly Gladiator's Waraxe

				{ 16, 42346 }, -- Deadly Gladiator's Spellblade
				{ 20, 42352 }, -- Deadly Gladiator's Gavel

				{ 26, 42260 }, -- Deadly Gladiator's Right Ripper
				{ 27, 42270 }, -- Deadly Gladiator's Left Ripper
				{ 28, 42265 }, -- Deadly Gladiator's Left Render
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[SET1_DIFF] = {
				{ 1, 42297 }, -- Savage Gladiator's Greatsword
				{ 3, 42294 }, -- Savage Gladiator's Decapitator
				{ 7, 42295 }, -- Savage Gladiator's Bonegrinder
				{ 10, 42296 }, -- Savage Gladiator's Pike
				{ 16, 44415 }, -- Savage Gladiator's War Staff
				{ 17, 42356 }, -- Savage Gladiator's Battle Staff
				{ 18, 44416 }, -- Savage Gladiator's Focus Staff
				{ 20, 42382 }, -- Savage Gladiator's Energy Staff
				{ 22, 42388 }, -- Savage Gladiator's Staff
			},
			[SET2_DIFF] = {
				{ 1, 42331 }, -- Hateful Gladiator's Greatsword
				{ 3, 42316 }, -- Hateful Gladiator's Decapitator
				{ 7, 42321 }, -- Hateful Gladiator's Bonegrinder
				{ 10, 42326 }, -- Hateful Gladiator's Pike
				{ 16, 44417 }, -- Hateful Gladiator's War Staff
				{ 17, 42359 }, -- Hateful Gladiator's Battle Staff
				{ 18, 44418 }, -- Hateful Gladiator's Focus Staff
				{ 20, 42383 }, -- Hateful Gladiator's Energy Staff
				{ 22, 42389 }, -- Hateful Gladiator's Staff
			},
			[SET3_DIFF] = {
				{ 1, 42332 }, -- Deadly Gladiator's Greatsword
				{ 3, 42317 }, -- Deadly Gladiator's Decapitator
				{ 7, 42322 }, -- Deadly Gladiator's Bonegrinder
				{ 10, 42327 }, -- Deadly Gladiator's Pike
				{ 16, 44419 }, -- Deadly Gladiator's War Staff
				{ 17, 42362 }, -- Deadly Gladiator's Battle Staff
				{ 18, 44420 }, -- Deadly Gladiator's Focus Staff
				{ 20, 42384 }, -- Deadly Gladiator's Energy Staff
				{ 22, 42390 }, -- Deadly Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[SET1_DIFF] = {
				{ 1, 42445 }, -- Savage Gladiator's Longbow
				{ 3, 42446 }, -- Savage Gladiator's Heavy Crossbow
				{ 5, 42447 }, -- Savage Gladiator's Rifle
				{ 7, 42444 }, -- Savage Gladiator's War Edge
				{ 16, 42448 }, -- Savage Gladiator's Touch of Defeat
				{ 17, 42511 }, -- Savage Gladiator's Baton of Light
				{ 18, 42517 }, -- Savage Gladiator's Piercing Touch
			},
			[SET2_DIFF] = {
				{ 1, 42489 }, -- Hateful Gladiator's Longbow
				{ 3, 42494 }, -- Hateful Gladiator's Heavy Crossbow
				{ 5, 42484 }, -- Hateful Gladiator's Rifle
				{ 7, 42449 }, -- Hateful Gladiator's War Edge
				{ 16, 42501 }, -- Hateful Gladiator's Touch of Defeat
				{ 17, 42512 }, -- Hateful Gladiator's Baton of Light
				{ 18, 42518 }, -- Hateful Gladiator's Piercing Touch
			},
			[SET3_DIFF] = {
				{ 1, 42490 }, -- Deadly Gladiator's Longbow
				{ 3, 42495 }, -- Deadly Gladiator's Heavy Crossbow
				{ 5, 42485 }, -- Deadly Gladiator's Rifle
				{ 7, 42450 }, -- Deadly Gladiator's War Edge
				{ 16, 42502 }, -- Deadly Gladiator's Touch of Defeat
				{ 17, 42513 }, -- Deadly Gladiator's Baton of Light
				{ 18, 42519 }, -- Deadly Gladiator's Piercing Touch
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[SET1_DIFF] = {
				{ 1, 42523 }, -- Savage Gladiator's Endgame
				{ 2, 42535 }, -- Savage Gladiator's Grimoire
				{ 16, 42529 }, -- Savage Gladiator's Reprieve
			},
			[SET2_DIFF] = {
				{ 1, 42524 }, -- Hateful Gladiator's Endgame
				{ 2, 42536 }, -- Hateful Gladiator's Grimoire
				{ 16, 42530 }, -- Hateful Gladiator's Reprieve
			},
			[SET3_DIFF] = {
				{ 1, 42525 }, -- Deadly Gladiator's Endgame
				{ 2, 42537 }, -- Deadly Gladiator's Grimoire
				{ 16, 42531 }, -- Deadly Gladiator's Reprieve
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Shields"],
			[SET1_DIFF] = {
				{ 1, 42556 }, -- Savage Gladiator's Shield Wall
				{ 16, 42568 }, -- Savage Gladiator's Redoubt
				{ 17, 42557 }, -- Savage Gladiator's Barrier
			},
			[SET2_DIFF] = {
				{ 1, 42558 }, -- Hateful Gladiator's Shield Wall
				{ 16, 42569 }, -- Hateful Gladiator's Redoubt
				{ 17, 42563 }, -- Hateful Gladiator's Barrier
			},
			[SET3_DIFF] = {
				{ 1, 42559 }, -- Deadly Gladiator's Shield Wall
				{ 16, 42570 }, -- Deadly Gladiator's Redoubt
				{ 17, 42564 }, -- Deadly Gladiator's Barrier
			},
		},
		{
			name = ALIL["Cloak"],
			[SET2_DIFF] = {
				{ 1, 42061 }, -- Hateful Gladiator's Cloak of Victory
				{ 2, 42060 }, -- Hateful Gladiator's Cloak of Triumph
				{ 16, 42057 }, -- Hateful Gladiator's Cloak of Ascendancy
				{ 17, 42056 }, -- Hateful Gladiator's Cloak of Subjugation
				{ 18, 42055 }, -- Hateful Gladiator's Cloak of Dominance
				{ 20, 42059 }, -- Hateful Gladiator's Cloak of Deliverance
				{ 21, 42058 }, -- Hateful Gladiator's Cloak of Salvation
			},
			[SET3_DIFF] = {
				{ 1, 42068 }, -- Deadly Gladiator's Cloak of Victory
				{ 2, 42067 }, -- Deadly Gladiator's Cloak of Triumph
				{ 16, 42064 }, -- Deadly Gladiator's Cloak of Ascendancy
				{ 17, 42063 }, -- Deadly Gladiator's Cloak of Subjugation
				{ 18, 42062 }, -- Deadly Gladiator's Cloak of Dominance
				{ 20, 42066 }, -- Deadly Gladiator's Cloak of Deliverance
				{ 21, 42065 }, -- Deadly Gladiator's Cloak of Salvation
			},
		},
		{
			name = ALIL["Relic"],
			[SET1_DIFF] = {
				{ 1, 42575 }, -- Savage Gladiator's Idol of Steadfastness
				{ 2, 42574 }, -- Savage Gladiator's Idol of Resolve
				{ 3, 42576 }, -- Savage Gladiator's Idol of Tenacity
				{ 5, 42612 }, -- Savage Gladiator's Libram of Justice
				{ 6, 42611 }, -- Savage Gladiator's Libram of Fortitude
				{ 16, 42595 }, -- Savage Gladiator's Totem of the Third Wind
				{ 17, 42594 }, -- Savage Gladiator's Totem of Survival
				{ 18, 42593 }, -- Savage Gladiator's Totem of Indomitability
				{ 20, 42618 }, -- Savage Gladiator's Sigil of Strife
			},
			[SET2_DIFF] = {
				{ 1, 42582 }, -- Hateful Gladiator's Idol of Steadfastness
				{ 2, 42587 }, -- Hateful Gladiator's Idol of Resolve
				{ 3, 42577 }, -- Hateful Gladiator's Idol of Tenacity
				{ 5, 42613 }, -- Hateful Gladiator's Libram of Justice
				{ 6, 42851 }, -- Hateful Gladiator's Libram of Fortitude
				{ 16, 42596 }, -- Hateful Gladiator's Totem of the Third Wind
				{ 17, 42601 }, -- Hateful Gladiator's Totem of Survival
				{ 18, 42606 }, -- Hateful Gladiator's Totem of Indomitability
				{ 20, 42619 }, -- Hateful Gladiator's Sigil of Strife
			},
			[SET3_DIFF] = {
				{ 1, 42583 }, -- Deadly Gladiator's Idol of Steadfastness
				{ 2, 42588 }, -- Deadly Gladiator's Idol of Resolve
				{ 3, 42578 }, -- Deadly Gladiator's Idol of Tenacity
				{ 5, 42614 }, -- Deadly Gladiator's Libram of Justice
				{ 6, 42852 }, -- Deadly Gladiator's Libram of Fortitude
				{ 16, 42597 }, -- Deadly Gladiator's Totem of the Third Wind
				{ 17, 42602 }, -- Deadly Gladiator's Totem of Survival
				{ 18, 42607 }, -- Deadly Gladiator's Totem of Indomitability
				{ 20, 42620 }, -- Deadly Gladiator's Sigil of Strife
			},
		},
		{
			name = ALIL["Neck"],
			[SET2_DIFF] = {
				{ 1, 42021 }, -- Hateful Gladiator's Pendant of Victory
				{ 2, 42020 }, -- Hateful Gladiator's Pendant of Triumph
				{ 16, 42024 }, -- Hateful Gladiator's Pendant of Ascendancy
				{ 17, 42023 }, -- Hateful Gladiator's Pendant of Subjugation
				{ 18, 42022 }, -- Hateful Gladiator's Pendant of Dominance
				{ 20, 42025 }, -- Hateful Gladiator's Pendant of Deliverance
				{ 21, 42026 }, -- Hateful Gladiator's Pendant of Salvation
			},
			[SET3_DIFF] = {
				{ 1, 42028 }, -- Deadly Gladiator's Pendant of Victory
				{ 2, 42027 }, -- Deadly Gladiator's Pendant of Triumph
				{ 16, 42030 }, -- Deadly Gladiator's Pendant of Ascendancy
				{ 17, 42031 }, -- Deadly Gladiator's Pendant of Subjugation
				{ 18, 42029 }, -- Deadly Gladiator's Pendant of Dominance
				{ 20, 42032 }, -- Deadly Gladiator's Pendant of Deliverance
				{ 21, 42033 }, -- Deadly Gladiator's Pendant of Salvation
			},
		},
		{
			name = ALIL["Finger"],
			[SET2_DIFF] = {
				{ 1, 42112 }, -- Hateful Gladiator's Band of Triumph
				{ 16, 42110 }, -- Hateful Gladiator's Band of Dominance
			},
			[SET3_DIFF] = {
				{ 1, 42115 }, -- Deadly Gladiator's Band of Victory
				{ 16, 42114 }, -- Deadly Gladiator's Band of Ascendancy
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 41879 }, -- Hateful Gladiator's Slippers of Salvation
				{ 2, 41877 }, -- Hateful Gladiator's Cord of Salvation
				{ 3, 41878 }, -- Hateful Gladiator's Cuffs of Salvation
				{ 5, 41901 }, -- Hateful Gladiator's Slippers of Dominance
				{ 6, 41896 }, -- Hateful Gladiator's Cord of Dominance
				{ 7, 41907 }, -- Hateful Gladiator's Cuffs of Dominance
				{ 16, 41884 }, -- Deadly Gladiator's Treads of Salvation
				{ 17, 41880 }, -- Deadly Gladiator's Cord of Salvation
				{ 18, 41892 }, -- Deadly Gladiator's Cuffs of Salvation
				{ 20, 41902 }, -- Deadly Gladiator's Treads of Dominance
				{ 21, 41897 }, -- Deadly Gladiator's Cord of Dominance
				{ 22, 41908 }, -- Deadly Gladiator's Cuffs of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 41331 },  -- Hateful Gladiator's Boots of Salvation
				{ 2, 41330 },  -- Hateful Gladiator's Belt of Salvation, Waist
				{ 3, 41332 },  -- Hateful Gladiator's Armwraps of Salvation
				{ 5, 41633 },  -- Hateful Gladiator's Boots of Dominance
				{ 6, 41628 },  -- Hateful Gladiator's Belt of Dominance, Waist
				{ 7, 41638 }, -- Hateful Gladiator's Armwraps of Dominance
				{ 9, 41828 },  -- Hateful Gladiator's Boots of Triumph
				{ 10, 41827 },  -- Hateful Gladiator's Belt of Triumph, Waist
				{ 11, 41830 }, -- Hateful Gladiator's Armwraps of Triumph
				{ 16, 41620 }, -- Deadly Gladiator's Boots of Salvation
				{ 17, 41616 }, -- Deadly Gladiator's Belt of Salvation, Waist
				{ 18, 41624 }, -- Deadly Gladiator's Armwraps of Salvation
				{ 20, 41634 }, -- Deadly Gladiator's Boots of Dominance
				{ 21, 41629 }, -- Deadly Gladiator's Belt of Dominance, Waist
				{ 22, 41639 }, -- Deadly Gladiator's Armwraps of Dominance
				{ 24, 41835 }, -- Deadly Gladiator's Boots of Triumph
				{ 25, 41831 }, -- Deadly Gladiator's Belt of Triumph, Waist
				{ 26, 41839 }, -- Deadly Gladiator's Armwraps of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 41049 }, -- Hateful Gladiator's Sabatons of Salvation
				{ 2, 41050 }, -- Hateful Gladiator's Waistguard of Salvation
				{ 3, 41047 }, -- Hateful Gladiator's Wristguards of Salvation
				{ 5, 41073 }, -- Hateful Gladiator's Sabatons of Dominance
				{ 6, 41068 }, -- Hateful Gladiator's Waistguard of Dominance
				{ 7, 41063 }, -- Hateful Gladiator's Wristguards of Dominance
				{ 9, 41228 }, -- Hateful Gladiator's Sabatons of Triumph
				{ 10, 41233 }, -- Hateful Gladiator's Waistguard of Triumph
				{ 11, 41223 }, -- Hateful Gladiator's Wristguards of Triumph
				{ 16, 41054 }, -- Deadly Gladiator's Sabatons of Salvation
				{ 17, 41048 }, -- Deadly Gladiator's Waistguard of Salvation
				{ 18, 41059 }, -- Deadly Gladiator's Wristguards of Salvation
				{ 20, 41074 }, -- Deadly Gladiator's Sabatons of Dominance
				{ 21, 41069 }, -- Deadly Gladiator's Waistguard of Dominance
				{ 22, 41064 }, -- Deadly Gladiator's Wristguards of Dominance
				{ 24, 41229 }, -- Deadly Gladiator's Sabatons of Triumph
				{ 25, 41234 }, -- Deadly Gladiator's Waistguard of Triumph
				{ 26, 41224 }, -- Deadly Gladiator's Wristguards of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 40878 }, -- Hateful Gladiator's Greaves of Triumph
				{ 2, 40877 }, -- Hateful Gladiator's Girdle of Triumph
				{ 3, 40887 }, -- Hateful Gladiator's Bracers of Triumph
				{ 5, 40973 }, -- Hateful Gladiator's Greaves of Salvation
				{ 6, 40966 }, -- Hateful Gladiator's Girdle of Salvation
				{ 7, 40972 }, -- Hateful Gladiator's Bracers of Salvation
				{ 16, 40880 }, -- Deadly Gladiator's Greaves of Triumph
				{ 17, 40879 }, -- Deadly Gladiator's Girdle of Triumph
				{ 18, 40888 }, -- Deadly Gladiator's Bracers of Triumph
				{ 20, 40975 }, -- Deadly Gladiator's Greaves of Salvation
				{ 21, 40974 }, -- Deadly Gladiator's Girdle of Salvation
				{ 22, 40982 }, -- Deadly Gladiator's Bracers of Salvation
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  46708 }, -- Deadly Gladiator's Frost Wyrm
			}
		}
	}
}

data["ArenaS6PvP"] = {
	name = format(AL["Season %s"], "6"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    3003780 }, -- Warlock
				{ 3,    3003777 }, -- Priest / Heal
				{ 4,    3003778 }, -- Priest / Shadow
				{ 6,    3003776 }, -- Rogue
				{ 8,    3003772 }, -- Hunter
				{ 10,   3003765 }, -- Warrior / DD
				{ 13,   3003768 }, -- Deathknight
				{ 16,   3003779 }, -- Mage
				{ 18,   3003773 }, -- Druid / Heal
				{ 19,   3003774 }, -- Druid / Owl
				{ 20,   3003775 }, -- Druid / Feral
				{ 22,   3003771 }, -- Shaman / Heal
				{ 23,   3003769 }, -- Shaman / Ele
				{ 24,   3003770 }, -- Shaman / Enh
				{ 26,   3003767 }, -- Paladin / Heal
				{ 27,   3003766 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 42243 }, -- Furious Gladiator's Shanker
				{ 2, 42249 }, -- Furious Gladiator's Shiv
				{ 3, 42256 }, -- Furious Gladiator's Mutilator

				{ 5, 42276 }, -- Furious Gladiator's Pummeler
				{ 6, 42281 }, -- Furious Gladiator's Bonecracker

				{ 8, 42286 }, -- Furious Gladiator's Slicer
				{ 9, 42291 }, -- Furious Gladiator's Quickblade

				{ 11, 42209 }, -- Furious Gladiator's Cleaver
				{ 12, 42228 }, -- Furious Gladiator's Hacker
				{ 13, 42233 }, -- Furious Gladiator's Chopper

				{ 15, 42238 }, -- Furious Gladiator's Waraxe

				{ 16, 42347 }, -- Furious Gladiator's Spellblade
				{ 20, 42353 }, -- Furious Gladiator's Gavel

				{ 26, 42261 }, -- Furious Gladiator's Right Ripper
				{ 27, 42271 }, -- Furious Gladiator's Left Ripper
				{ 28, 42266 }, -- Furious Gladiator's Left Render
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 45958 }, -- Furious Gladiator's Spike
				{ 2, 45962 }, -- Furious Gladiator's Dirk
				{ 3, 45967 }, -- Furious Gladiator's Eviscerator

				{ 5, 45959 }, -- Furious gladiator's Truncheon
				{ 6, 45964 }, -- Furious gladiator's Punisher

				{ 8, 45960 }, -- Furious gladiator's Longblade
				{ 9, 45965 }, -- Furious Gladiator's Swiftblade

				{ 11, 45957 }, -- Furious Gladiator's Handaxe
				{ 12, 45961 }, -- Furious Gladiator's Dicer
				{ 13, 45966 }, -- Furious Gladiator's Splitter

				{ 16, 45970 }, -- Furious Gladiator's Mageblade
				{ 20, 45971 }, -- Furious Gladiator's Salvation

				{ 26, 45969 }, -- Furious Gladiator's Grasp
				{ 27, 45963 }, -- Furious Gladiator's Left Razor
				{ 28, 45968 }, -- Furious Gladiator's Left Claw
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 42333 }, -- Furious Gladiator's Greatsword
				{ 3, 42318 }, -- Furious Gladiator's Decapitator
				{ 7, 42323 }, -- Furious Gladiator's Bonegrinder
				{ 10, 42328 }, -- Furious Gladiator's Pike
				{ 16, 44421 }, -- Furious Gladiator's War Staff
				{ 17, 42364 }, -- Furious Gladiator's Battle Staff
				{ 18, 44422 }, -- Furious Gladiator's Focus Staff
				{ 20, 42385 }, -- Furious Gladiator's Energy Staff
				{ 22, 42391 }, -- Furious Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 45950 }, -- Furious Gladiator's Claymore
				{ 3, 45948 }, -- Furious Gladiator's Sunderer
				{ 7, 45949 }, -- Furious Gladiator's Crusher
				{ 10, 45951 }, -- Furious Gladiator's Halberd
				{ 16, 45953 }, -- Furious Gladiator's Combat Staff
				{ 17, 45955 }, -- Furious Gladiator's Skirmish Staff
				{ 18, 45954 }, -- Furious Gladiator's Acute Staff
				{ 20, 45956 }, -- Furious Gladiator's Light Staff
				{ 22, 45952 }, -- Furious Gladiator's Greatstaff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 42491 }, -- Furious Gladiator's Longbow
				{ 3, 42496 }, -- Furious Gladiator's Heavy Crossbow
				{ 5, 42486 }, -- Furious Gladiator's Rifle
				{ 7, 42451 }, -- Furious Gladiator's War Edge
				{ 16, 42503 }, -- Furious Gladiator's Touch of Defeat
				{ 17, 42514 }, -- Furious Gladiator's Baton of Light
				{ 18, 42520 }, -- Furious Gladiator's Piercing Touch
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 45938 }, -- Furious Gladiator's Recurve
				{ 3, 45939 }, -- Furious Gladiator's Repeater
				{ 5, 45937 }, -- Furious Gladiator's Shotgun

			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[SET1_DIFF] = {
				{ 1, 42526 }, -- Furious Gladiator's Endgame
				{ 2, 42538 }, -- Furious Gladiator's Grimoire
				{ 16, 42532 }, -- Furious Gladiator's Reprieve
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 42560 }, -- Furious Gladiator's Shield Wall
				{ 16, 42571 }, -- Furious Gladiator's Redoubt
				{ 17, 42565 }, -- Furious Gladiator's Barrier
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 42075 }, -- Furious Gladiator's Cloak of Victory
				{ 2, 42074 }, -- Furious Gladiator's Cloak of Triumph
				{ 16, 42071 }, -- Furious Gladiator's Cloak of Ascendancy
				{ 17, 42079 }, -- Furious Gladiator's Cloak of Subjugation
				{ 18, 42069 }, -- Furious Gladiator's Cloak of Dominance
				{ 20, 42073 }, -- Furious Gladiator's Cloak of Deliverance
				{ 21, 42072 }, -- Furious Gladiator's Cloak of Salvation
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 42584 }, -- Furious Gladiator's Idol of Steadfastness
				{ 2, 42589 }, -- Furious Gladiator's Idol of Resolve
				{ 3, 42579 }, -- Furious Gladiator's Idol of Tenacity
				{ 5, 42615 }, -- Furious Gladiator's Libram of Justice
				{ 6, 42853 }, -- Furious Gladiator's Libram of Fortitude
				{ 16, 42598 }, -- Furious Gladiator's Totem of the Third Wind
				{ 17, 42603 }, -- Furious Gladiator's Totem of Survival
				{ 18, 42608 }, -- Furious Gladiator's Totem of Indomitability
				{ 20, 42621 }, -- Furious Gladiator's Sigil of Strife
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 42035 }, -- Furious Gladiator's Pendant of Victory
				{ 2, 42034 }, -- Furious Gladiator's Pendant of Triumph
				{ 3, 46373 }, -- Furious Gladiator's Pendant of Sundering
				{ 16, 42037 }, -- Furious Gladiator's Pendant of Ascendancy
				{ 17, 42038 }, -- Furious Gladiator's Pendant of Subjugation
				{ 18, 42036 }, -- Furious Gladiator's Pendant of Dominance
				{ 20, 42039 }, -- Furious Gladiator's Pendant of Deliverance
				{ 21, 42040 }, -- Furious Gladiator's Pendant of Salvation
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 42117 }, -- Furious Gladiator's Band of Triumph
				{ 16, 42116 }, -- Furious Gladiator's Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 41885 }, -- Furious Gladiator's Slippers of Salvation
				{ 2, 41881 }, -- Furious Gladiator's Cord of Salvation
				{ 3, 41893 }, -- Furious Gladiator's Cuffs of Salvation
				{ 5, 41903 }, -- Furious Gladiator's Slippers of Dominance
				{ 6, 41898 }, -- Furious Gladiator's Cord of Dominance
				{ 7, 41909 }, -- Furious Gladiator's Cuffs of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 41621 },  -- Furious Gladiator's Boots of Salvation
				{ 2, 41617 },  -- Furious Gladiator's Belt of Salvation, Waist
				{ 3, 41625 },  -- Furious Gladiator's Armwraps of Salvation
				{ 5, 41635 },  -- Furious Gladiator's Boots of Dominance
				{ 6, 41630 },  -- Furious Gladiator's Belt of Dominance, Waist
				{ 7, 41640 }, -- Furious Gladiator's Armwraps of Dominance
				{ 9, 41836 },  -- Furious Gladiator's Boots of Triumph
				{ 10, 41832 },  -- Furious Gladiator's Belt of Triumph, Waist
				{ 11, 41840 }, -- Furious Gladiator's Armwraps of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 41055 }, -- Furious Gladiator's Sabatons of Salvation
				{ 2, 41051 }, -- Furious Gladiator's Waistguard of Salvation
				{ 3, 41060 }, -- Furious Gladiator's Wristguards of Salvation
				{ 5, 41075 }, -- Furious Gladiator's Sabatons of Dominance
				{ 6, 41070 }, -- Furious Gladiator's Waistguard of Dominance
				{ 7, 41065 }, -- Furious Gladiator's Wristguards of Dominance
				{ 9, 41230 }, -- Furious Gladiator's Sabatons of Triumph
				{ 10, 41235 }, -- Furious Gladiator's Waistguard of Triumph
				{ 11, 41225 }, -- Furious Gladiator's Wristguards of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 40882 }, -- Furious Gladiator's Greaves of Triumph
				{ 2, 40881 }, -- Furious Gladiator's Girdle of Triumph
				{ 3, 40889 }, -- Furious Gladiator's Bracers of Triumph
				{ 5, 40977 }, -- Furious Gladiator's Greaves of Salvation
				{ 6, 40976 }, -- Furious Gladiator's Girdle of Salvation
				{ 7, 40983 }, -- Furious Gladiator's Bracers of Salvation
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  46171 }, -- Furious Gladiator's Frost Wyrm
			}
		}
	}
}

data["ArenaS7PvP"] = {
	name = format(AL["Season %s"], "7"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    3004780 }, -- Warlock
				{ 3,    3004777 }, -- Priest / Heal
				{ 4,    3004778 }, -- Priest / Shadow
				{ 6,    3004776 }, -- Rogue
				{ 8,    3004772 }, -- Hunter
				{ 10,   3004765 }, -- Warrior / DD
				{ 13,   3004768 }, -- Deathknight
				{ 16,   3004779 }, -- Mage
				{ 18,   3004773 }, -- Druid / Heal
				{ 19,   3004774 }, -- Druid / Owl
				{ 20,   3004775 }, -- Druid / Feral
				{ 22,   3004771 }, -- Shaman / Heal
				{ 23,   3004769 }, -- Shaman / Ele
				{ 24,   3004770 }, -- Shaman / Enh
				{ 26,   3004767 }, -- Paladin / Heal
				{ 27,   3004766 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 42244 }, -- Relentless Gladiator's Shanker
				{ 2, 42250 }, -- Relentless Gladiator's Shiv
				{ 3, 42257 }, -- Relentless Gladiator's Mutilator

				{ 5, 42277 }, -- Relentless Gladiator's Pummeler
				{ 6, 42282 }, -- Relentless Gladiator's Bonecracker

				{ 8, 42287 }, -- Relentless Gladiator's Slicer
				{ 9, 42292 }, -- Relentless Gladiator's Quickblade

				{ 11, 42210 }, -- Relentless Gladiator's Cleaver
				{ 12, 42229 }, -- Relentless Gladiator's Hacker
				{ 13, 42234 }, -- Relentless Gladiator's Chopper

				{ 16, 42348 }, -- Relentless Gladiator's Spellblade
				{ 20, 42354 }, -- Relentless Gladiator's Gavel

				{ 26, 42262 }, -- Relentless Gladiator's Right Ripper
				{ 27, 42272 }, -- Relentless Gladiator's Left Ripper
				{ 28, 42267 }, -- Relentless Gladiator's Left Render
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 48509 }, -- Relentless Gladiator's Spike
				{ 2, 48428 }, -- Relentless Gladiator's Dirk
				{ 3, 48442 }, -- Relentless Gladiator's Eviscerator

				{ 5, 48511 }, -- Relentless gladiator's Truncheon
				{ 6, 48435 }, -- Relentless gladiator's Punisher

				{ 8, 48513 }, -- Relentless gladiator's Longblade
				{ 9, 48438 }, -- Relentless Gladiator's Swiftblade

				{ 11, 48507 }, -- Relentless Gladiator's Handaxe
				{ 12, 48426 }, -- Relentless Gladiator's Dicer
				{ 13, 48440 }, -- Relentless Gladiator's Splitter

				{ 16, 48408 }, -- Relentless Gladiator's Mageblade
				{ 20, 48519 }, -- Relentless Gladiator's Salvation

				{ 26, 48515 }, -- Relentless Gladiator's Grasp
				{ 27, 48432 }, -- Relentless Gladiator's Left Razor
				{ 28, 48444 }, -- Relentless Gladiator's Left Claw
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 42334 }, -- Relentless Gladiator's Greatsword
				{ 3, 42319 }, -- Relentless Gladiator's Decapitator
				{ 7, 42324 }, -- Relentless Gladiator's Bonegrinder
				{ 10, 42329 }, -- Relentless Gladiator's Pike
				{ 16, 44422 }, -- Relentless Gladiator's War Staff
				{ 17, 42365 }, -- Relentless Gladiator's Battle Staff
				{ 20, 42386 }, -- Relentless Gladiator's Energy Staff
				{ 22, 42392 }, -- Relentless Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 48406 }, -- Relentless Gladiator's Claymore
				{ 3, 48402 }, -- Relentless Gladiator's Sunderer
				{ 7, 48404 }, -- Relentless Gladiator's Crusher
				{ 10, 48517 }, -- Relentless Gladiator's Halberd
				{ 16, 48414 }, -- Relentless Gladiator's Combat Staff
				{ 17, 48410 }, -- Relentless Gladiator's Skirmish Staff
				{ 18, 48412 }, -- Relentless Gladiator's Acute Staff
				{ 20, 48512 }, -- Relentless Gladiator's Light Staff
				{ 22, 48523 }, -- Relentless Gladiator's Greatstaff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 42492 }, -- Relentless Gladiator's Longbow
				{ 3, 42498 }, -- Relentless Gladiator's Heavy Crossbow
				{ 5, 42487 }, -- Relentless Gladiator's Rifle
				{ 7, 42483 }, -- Relentless Gladiator's War Edge
				{ 16, 42504 }, -- Relentless Gladiator's Touch of Defeat
				{ 17, 42515 }, -- Relentless Gladiator's Baton of Light
				{ 18, 42521 }, -- Relentless Gladiator's Piercing Touch
				{ 19, 42521 }, -- Relentless Gladiator's Wand of Alacrity
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 48420 }, -- Relentless Gladiator's Recurve
				{ 3, 48422 }, -- Relentless Gladiator's Repeater
				{ 5, 48424 }, -- Relentless Gladiator's Shotgun

			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[SET1_DIFF] = {
				{ 1, 42527 }, -- Relentless Gladiator's Endgame
				{ 2, 42539 }, -- Relentless Gladiator's Grimoire
				{ 16, 42533 }, -- Relentless Gladiator's Reprieve
				{ 17, 49187 }, -- Relentless Gladiator's Compendium
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 42561 }, -- Relentless Gladiator's Shield Wall
				{ 16, 42572 }, -- Relentless Gladiator's Redoubt
				{ 17, 42566 }, -- Relentless Gladiator's Barrier
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 42082 }, -- Relentless Gladiator's Cloak of Victory
				{ 2, 42081 }, -- Relentless Gladiator's Cloak of Triumph
				{ 16, 42078 }, -- Relentless Gladiator's Cloak of Ascendancy
				{ 17, 42077 }, -- Relentless Gladiator's Cloak of Subjugation
				{ 18, 42076 }, -- Relentless Gladiator's Cloak of Dominance
				{ 20, 42080 }, -- Relentless Gladiator's Cloak of Deliverance
				{ 21, 42079 }, -- Relentless Gladiator's Cloak of Salvation
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 42585 }, -- Relentless Gladiator's Idol of Steadfastness
				{ 2, 42591 }, -- Relentless Gladiator's Idol of Resolve
				{ 3, 42580 }, -- Relentless Gladiator's Idol of Tenacity
				{ 5, 42616 }, -- Relentless Gladiator's Libram of Justice
				{ 6, 42854 }, -- Relentless Gladiator's Libram of Fortitude
				{ 16, 42599 }, -- Relentless Gladiator's Totem of the Third Wind
				{ 17, 42604 }, -- Relentless Gladiator's Totem of Survival
				{ 18, 42609 }, -- Relentless Gladiator's Totem of Indomitability
				{ 20, 42622 }, -- Relentless Gladiator's Sigil of Strife
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 42042 }, -- Relentless Gladiator's Pendant of Victory
				{ 2, 42041 }, -- Relentless Gladiator's Pendant of Triumph
				{ 3, 46374 }, -- Relentless Gladiator's Pendant of Sundering
				{ 16, 42044 }, -- Relentless Gladiator's Pendant of Ascendancy
				{ 17, 42045 }, -- Relentless Gladiator's Pendant of Subjugation
				{ 18, 42043 }, -- Relentless Gladiator's Pendant of Dominance
				{ 20, 42046 }, -- Relentless Gladiator's Pendant of Deliverance
				{ 21, 42047 }, -- Relentless Gladiator's Pendant of Salvation
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 42118 }, -- Relentless Gladiator's Band of Ascendancy
				{ 16, 42119 }, -- Relentless Gladiator's Band of Victory
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 41886 }, -- Relentless Gladiator's Slippers of Salvation
				{ 2, 41882 }, -- Relentless Gladiator's Cord of Salvation
				{ 3, 41894 }, -- Relentless Gladiator's Cuffs of Salvation
				{ 5, 41904 }, -- Relentless Gladiator's Slippers of Dominance
				{ 6, 41899 }, -- Relentless Gladiator's Cord of Dominance
				{ 7, 41910 }, -- Relentless Gladiator's Cuffs of Dominance
				{ 9, 49183 }, -- Relentless Gladiator's Slippers of Alacrity
				{ 10, 49179 }, -- Relentless Gladiator's Cord of Alacrity
				{ 11, 49181 }, -- Relentless Gladiator's Cuffs of Alacrity

			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 41622 },  -- Relentless Gladiator's Boots of Salvation
				{ 2, 41618 },  -- Relentless Gladiator's Belt of Salvation, Waist
				{ 3, 41626 },  -- Relentless Gladiator's Armwraps of Salvation
				{ 5, 41636 },  -- Relentless Gladiator's Boots of Dominance
				{ 6, 41631 },  -- Relentless Gladiator's Belt of Dominance
				{ 7, 41641 }, -- Relentless Gladiator's Armwraps of Dominance
				{ 9, 41837 },  -- Relentless Gladiator's Boots of Triumph
				{ 10, 41833 },  -- Relentless Gladiator's Belt of Triumph
				{ 11, 41841 }, -- Relentless Gladiator's Armwraps of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 41056 }, -- Relentless Gladiator's Sabatons of Salvation
				{ 2, 41052 }, -- Relentless Gladiator's Waistguard of Salvation
				{ 3, 41061 }, -- Relentless Gladiator's Wristguards of Salvation
				{ 5, 41076 }, -- Relentless Gladiator's Sabatons of Dominance
				{ 6, 41071 }, -- Relentless Gladiator's Waistguard of Dominance
				{ 7, 41066 }, -- Relentless Gladiator's Wristguards of Dominance
				{ 9, 41231 }, -- Relentless Gladiator's Sabatons of Triumph
				{ 10, 41236 }, -- Relentless Gladiator's Waistguard of Triumph
				{ 11, 41226 }, -- Relentless Gladiator's Wristguards of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 40884 }, -- Relentless Gladiator's Greaves of Triumph
				{ 2, 40883 }, -- Relentless Gladiator's Girdle of Triumph
				{ 3, 40890 }, -- Relentless Gladiator's Bracers of Triumph
				{ 5, 40979 }, -- Relentless Gladiator's Greaves of Salvation
				{ 6, 40978 }, -- Relentless Gladiator's Girdle of Salvation
				{ 7, 40984 }, -- Relentless Gladiator's Bracers of Salvation
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  47840 }, -- Relentless Gladiator's Frost Wyrm
			}
		}
	}
}

data["ArenaS8PvP"] = {
	name = format(AL["Season %s"], "8"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,    3005780 }, -- Warlock
				{ 3,    3005777 }, -- Priest / Heal
				{ 4,    3005778 }, -- Priest / Shadow
				{ 6,    3005776 }, -- Rogue
				{ 8,    3005772 }, -- Hunter
				{ 10,   3005765 }, -- Warrior / DD
				{ 13,   3005768 }, -- Deathknight
				{ 16,   3005779 }, -- Mage
				{ 18,   3005773 }, -- Druid / Heal
				{ 19,   3005774 }, -- Druid / Owl
				{ 20,   3005775 }, -- Druid / Feral
				{ 22,   3005771 }, -- Shaman / Heal
				{ 23,   3005769 }, -- Shaman / Ele
				{ 24,   3005770 }, -- Shaman / Enh
				{ 26,   3005767 }, -- Paladin / Heal
				{ 27,   3005766 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 51517 }, -- Wrathful Gladiator's Shanker
				{ 2, 51441 }, -- Wrathful Gladiator's Shiv
				{ 3, 51527 }, -- Wrathful Gladiator's Mutilator

				{ 5, 51519 }, -- Wrathful Gladiator's Pummeler
				{ 6, 51445 }, -- Wrathful Gladiator's Bonecracker

				{ 8, 51521 }, -- Wrathful Gladiator's Slicer
				{ 9, 51447 }, -- Wrathful Gladiator's Quickblade

				{ 11, 51515 }, -- Wrathful Gladiator's Cleaver
				{ 12, 51439 }, -- Wrathful Gladiator's Hacker
				{ 13, 51525 }, -- Wrathful Gladiator's Chopper

				{ 16, 51397 }, -- Wrathful Gladiator's Spellblade
				{ 20, 51453 }, -- Wrathful Gladiator's Gavel

				{ 26, 51523 }, -- Wrathful Gladiator's Right Ripper
				{ 27, 51443 }, -- Wrathful Gladiator's Left Ripper
				{ 28, 51530 }, -- Wrathful Gladiator's Left Render
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 51518 }, -- Wrathful Gladiator's Spike
				{ 2, 51442 }, -- Wrathful Gladiator's Dirk
				{ 3, 51528 }, -- Wrathful Gladiator's Eviscerator

				{ 5, 51520 }, -- Wrathful gladiator's Truncheon
				{ 6, 51446 }, -- Wrathful gladiator's Punisher

				{ 8, 51522 }, -- Wrathful gladiator's Longblade
				{ 9, 51548 }, -- Wrathful Gladiator's Swiftblade

				{ 11, 51516 }, -- Wrathful Gladiator's Handaxe
				{ 12, 51540 }, -- Wrathful Gladiator's Dicer
				{ 13, 51526 }, -- Wrathful Gladiator's Splitter

				{ 16, 51399 }, -- Wrathful Gladiator's Mageblade
				{ 20, 51554 }, -- Wrathful Gladiator's Salvation

				{ 26, 51524 }, -- Wrathful Gladiator's Grasp
				{ 27, 51544 }, -- Wrathful Gladiator's Left Razor
				{ 28, 51529 }, -- Wrathful Gladiator's Left Claw
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[NORMAL_DIFF] = {
				{ 1, 51392 }, -- Wrathful Gladiator's Greatsword
				{ 3, 51388 }, -- Wrathful Gladiator's Decapitator
				{ 7, 51390 }, -- Wrathful Gladiator's Bonegrinder
				{ 10, 51480 }, -- Wrathful Gladiator's Pike
				{ 16, 51400 }, -- Wrathful Gladiator's War Staff
				{ 17, 51404 }, -- Wrathful Gladiator's Battle Staff
				{ 18, 51402 }, -- Wrathful Gladiator's Focus Staff
				{ 20, 51456 }, -- Wrathful Gladiator's Energy Staff
				{ 22, 51431 }, -- Wrathful Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 51393 }, -- Wrathful Gladiator's Claymore
				{ 3, 51389 }, -- Wrathful Gladiator's Sunderer
				{ 7, 51391 }, -- Wrathful Gladiator's Crusher
				{ 10, 51481 }, -- Wrathful Gladiator's Halberd
				{ 16, 51401 }, -- Wrathful Gladiator's Combat Staff
				{ 17, 51405 }, -- Wrathful Gladiator's Skirmish Staff
				{ 18, 51403 }, -- Wrathful Gladiator's Acute Staff
				{ 20, 51457 }, -- Wrathful Gladiator's Light Staff
				{ 22, 51432 }, -- Wrathful Gladiator's Greatstaff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[NORMAL_DIFF] = {
				{ 1, 51394 }, -- Wrathful Gladiator's Longbow
				{ 3, 51411 }, -- Wrathful Gladiator's Heavy Crossbow
				{ 5, 51449 }, -- Wrathful Gladiator's Rifle
				{ 7, 51535 }, -- Wrathful Gladiator's War Edge
				{ 16, 51410 }, -- Wrathful Gladiator's Touch of Defeat
				{ 17, 51532 }, -- Wrathful Gladiator's Baton of Light
				{ 18, 51531 }, -- Wrathful Gladiator's Piercing Touch
				{ 19, 51451 }, -- Wrathful Gladiator's Wand of Alacrity
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"].." - R2",
			[NORMAL_DIFF] = {
				{ 1, 51395 }, -- Wrathful Gladiator's Recurve
				{ 3, 51412 }, -- Wrathful Gladiator's Repeater
				{ 5, 51450 }, -- Wrathful Gladiator's Shotgun

			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[SET1_DIFF] = {
				{ 1, 51396 }, -- Wrathful Gladiator's Endgame
				{ 2, 51408 }, -- Wrathful Gladiator's Grimoire
				{ 16, 51409 }, -- Wrathful Gladiator's Reprieve
				{ 17, 51407 }, -- Wrathful Gladiator's Compendium
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 51533 }, -- Wrathful Gladiator's Shield Wall
				{ 16, 51455 }, -- Wrathful Gladiator's Redoubt
				{ 17, 51452 }, -- Wrathful Gladiator's Barrier
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 51356 }, -- Wrathful Gladiator's Cloak of Victory
				{ 2, 51354 }, -- Wrathful Gladiator's Cloak of Triumph
				{ 16, 51334 }, -- Wrathful Gladiator's Cloak of Ascendancy
				{ 17, 51332 }, -- Wrathful Gladiator's Cloak of Subjugation
				{ 18, 51330 }, -- Wrathful Gladiator's Cloak of Dominance
				{ 20, 51348 }, -- Wrathful Gladiator's Cloak of Deliverance
				{ 21, 51346 }, -- Wrathful Gladiator's Cloak of Salvation
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 51437 }, -- Wrathful Gladiator's Idol of Steadfastness
				{ 2, 51429 }, -- Wrathful Gladiator's Idol of Resolve
				{ 3, 51423 }, -- Wrathful Gladiator's Idol of Tenacity
				{ 5, 51472 }, -- Wrathful Gladiator's Libram of Justice
				{ 6, 51478 }, -- Wrathful Gladiator's Libram of Fortitude
				{ 16, 51501 }, -- Wrathful Gladiator's Totem of the Third Wind
				{ 17, 51513 }, -- Wrathful Gladiator's Totem of Survival
				{ 18, 51507 }, -- Wrathful Gladiator's Totem of Indomitability
				{ 20, 51417 }, -- Wrathful Gladiator's Sigil of Strife
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 51357 }, -- Wrathful Gladiator's Pendant of Victory
				{ 2, 51355 }, -- Wrathful Gladiator's Pendant of Triumph
				{ 3, 51353 }, -- Wrathful Gladiator's Pendant of Sundering
				{ 16, 51335 }, -- Wrathful Gladiator's Pendant of Ascendancy
				{ 17, 51333 }, -- Wrathful Gladiator's Pendant of Subjugation
				{ 18, 51331 }, -- Wrathful Gladiator's Pendant of Dominance
				{ 20, 51349 }, -- Wrathful Gladiator's Pendant of Deliverance
				{ 21, 51347 }, -- Wrathful Gladiator's Pendant of Salvation
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 51358 }, -- Wrathful Gladiator's Band of Triumph
				{ 16, 51336 }, -- Wrathful Gladiator's Band of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 51366 }, -- Wrathful Gladiator's Slippers of Salvation
				{ 2, 51365 }, -- Wrathful Gladiator's Cord of Salvation
				{ 3, 51367 }, -- Wrathful Gladiator's Cuffs of Salvation
				{ 5, 51328 }, -- Wrathful Gladiator's Slippers of Dominance
				{ 6, 51327 }, -- Wrathful Gladiator's Cord of Dominance
				{ 7, 51329 }, -- Wrathful Gladiator's Cuffs of Dominance
				{ 9, 51338 }, -- Wrathful Gladiator's Slippers of Alacrity
				{ 10, 51337 }, -- Wrathful Gladiator's Cord of Alacrity
				{ 11, 51339 }, -- Wrathful Gladiator's Cuffs of Alacrity

			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 51341 },  -- Wrathful Gladiator's Boots of Salvation
				{ 2, 51340 },  -- Wrathful Gladiator's Belt of Salvation
				{ 3, 51342 },  -- Wrathful Gladiator's Armwraps of Salvation
				{ 5, 51344 },  -- Wrathful Gladiator's Boots of Dominance
				{ 6, 51343 },  -- Wrathful Gladiator's Belt of Dominance
				{ 7, 51345 }, -- Wrathful Gladiator's Armwraps of Dominance
				{ 9, 51369 },  -- Wrathful Gladiator's Boots of Triumph
				{ 10, 51368 },  -- Wrathful Gladiator's Belt of Triumph
				{ 11, 51370 }, -- Wrathful Gladiator's Armwraps of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 51372 }, -- Wrathful Gladiator's Sabatons of Salvation
				{ 2, 51373 }, -- Wrathful Gladiator's Waistguard of Salvation
				{ 3, 51371 }, -- Wrathful Gladiator's Wristguards of Salvation
				{ 5, 51375 }, -- Wrathful Gladiator's Sabatons of Dominance
				{ 6, 51374 }, -- Wrathful Gladiator's Waistguard of Dominance
				{ 7, 51376 }, -- Wrathful Gladiator's Wristguards of Dominance
				{ 9, 51351 }, -- Wrathful Gladiator's Sabatons of Triumph
				{ 10, 51350 }, -- Wrathful Gladiator's Waistguard of Triumph
				{ 11, 51352 }, -- Wrathful Gladiator's Wristguards of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 51363 }, -- Wrathful Gladiator's Greaves of Triumph
				{ 2, 51362 }, -- Wrathful Gladiator's Girdle of Triumph
				{ 3, 51364 }, -- Wrathful Gladiator's Bracers of Triumph
				{ 5, 51360 }, -- Wrathful Gladiator's Greaves of Salvation
				{ 6, 51359 }, -- Wrathful Gladiator's Girdle of Salvation
				{ 7, 51361 }, -- Wrathful Gladiator's Bracers of Salvation
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			}
		}
	}
}

data["Wintergrasp"] = {
	MapID = 4197,
	ContentType = OPEN_WORLD_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = ALIL["Back"],
			[NORMAL_DIFF] = {
				{ 1, 51570 }, -- Titan-Forged Cloak of Ascendancy
				{ 2, 51571 }, -- Titan-Forged Cloak of Victory
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 51568 }, -- Titan-Forged Pendant of Ascendancy
				{ 2, 51569 }, -- Titan-Forged Pendant of Victory
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 48999 }, -- Titan-Forged Band of Ascendancy
				{ 2, 49000 }, -- Titan-Forged Band of Victory
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 44914 }, -- Anvil of Titans
				{ 2, 44912 }, -- Flow of Knowledge
				{ 4, 46083 }, -- Titan-Forged Rune of Accuracy
				{ 5, 46085 }, -- Titan-Forged Rune of Alacrity
				{ 6, 46081 }, -- Titan-Forged Rune of Audacity
				{ 7, 46084 }, -- Titan-Forged Rune of Cruelty
				{ 8, 46082 }, -- Titan-Forged Rune of Determination

				{ 19, 46086 }, -- Platinum Disks of Battle
				{ 20, 46088 }, -- Platinum Disks of Swiftness
				{ 21, 46087 }, -- Platinum Disks of Sorcery
			},
		},
		{ -- LakeWintergrasp2 / 1385
			name = ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 44910 }, -- Titan-Forged Hood of Dominance
				{ 2, 46065 }, -- Titan-Forged Raiment of Dominance
				{ 3, 46079 }, -- Titan-Forged Cord of Dominance
				{ 4, 44899 }, -- Titan-Forged Slippers of Dominance
				{ 6, 44909 }, -- Titan-Forged Hood of Salvation
				{ 7, 46066 }, -- Titan-Forged Raiment of Salvation
				{ 8, 46080 }, -- Titan-Forged Cord of Salvation
				{ 9, 44900 }, -- Titan-Forged Slippers of Salvation

				{ 16, 48997 }, -- Titan-Forged Cloth Trousers of Domination
				{ 18, 48991 }, -- Titan-Forged Cloth Leggings of Salvation
				{ 19, 48979 }, -- Titan-Forged Cuffs of Salvation

				{ 22, 51573 }, -- Titan-Forged Shoulderpads of Domination
				{ 23, 51572 }, -- Titan-Forged Shoulderpads of Salvation
			}
		},
		{ -- LakeWintergrasp3 / 1386
			name = ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 44907 }, -- Titan-Forged Leather Helm of Dominance
				{ 2, 46064 }, -- Titan-Forged Leather Chestguard of Dominance
				{ 3, 46076 }, -- Titan-Forged Belt of Dominance
				{ 4, 44891 }, -- Titan-Forged Boots of Dominance
				{ 6, 44906 }, -- Titan-Forged Leather Helm of Salvation
				{ 7, 46063 }, -- Titan-Forged Leather Chestguard of Salvation
				{ 8, 46077 }, -- Titan-Forged Belt of Salvation
				{ 9, 44892 }, -- Titan-Forged Boots of Salvation
				{ 11, 44908 }, -- Titan-Forged Leather Helm of Triumph
				{ 12, 46062 }, -- Titan-Forged Leather Tunic of Triumph
				{ 13, 46078 }, -- Titan-Forged Belt of Triumph
				{ 14, 44893 }, -- Titan-Forged Boots of Triumph

				{ 16, 48974 }, -- Titan-Forged Armwraps of Dominance
				{ 17, 48998 }, -- Titan-Forged Leather Legguards of Dominance
				{ 19, 48975 }, -- Titan-Forged Armwraps of Salvation
				{ 20, 48987 }, -- Titan-Forged Leather Legguards of Salvation
				{ 22, 48976 }, -- Titan-Forged Armwraps of Triumph
				{ 23, 48988 }, -- Titan-Forged Leather Legguards of Triumph

				{ 26, 51574 }, -- Titan-Forged Leather Spaulders of Dominance
				{ 27, 51575 }, -- Titan-Forged Leather Spaulders of Salvation
				{ 28, 51576 }, -- Titan-Forged Leather Spaulders of Triumph
			}
		},
		{ -- LakeWintergrasp4 / 1387
			name = ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 44904 }, -- Titan-Forged Mail Helm of Dominance
				{ 2, 46061 }, -- Titan-Forged Mail Armor of Domination
				{ 3, 46073 }, -- Titan-Forged Waistguard of Dominance
				{ 4, 44896 }, -- Titan-Forged Sabatons of Dominance
				{ 6, 44905 }, -- Titan-Forged Ringmail Helm of Salvation
				{ 7, 46060 }, -- Titan-Forged Ringmail of Salvation
				{ 8, 46074 }, -- Titan-Forged Waistguard of Salvation
				{ 9, 44897 }, -- Titan-Forged Sabatons of Salvation
				{ 11, 44903 }, -- Titan-Forged Chain Helm of Triumph
				{ 12, 46059 }, -- Titan-Forged Chain Armor of Triumph
				{ 13, 46075 }, -- Titan-Forged Waistguard of Triumph
				{ 14, 44898 }, -- Titan-Forged Sabatons of Triumph

				{ 16, 48980 }, -- Titan-Forged Wristguards of Dominance
				{ 17, 48990 }, -- Titan-Forged Mail Leggings of Dominance
				{ 19, 48981 }, -- Titan-Forged Wristguards of Salvation
				{ 20, 48994 }, -- Titan-Forged Mail Leggings of Salvation
				{ 22, 48982 }, -- Titan-Forged Wristguards of Triumph
				{ 23, 48983 }, -- Titan-Forged Mail Leggings of Triumph

				{ 26, 51578 }, -- Titan-Forged Shoulders of Dominance
				{ 27, 51579 }, -- Titan-Forged Shoulders of Salvation
				{ 28, 51577 }, -- Titan-Forged Shoulders of Triumph
			}
		},
		{ -- LakeWintergrasp5 / 1388
			name = ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 44901 }, -- Titan-Forged Plate Headcover of Salvation
				{ 2, 46057 }, -- Titan-Forged Chestguard of Salvation
				{ 3, 46071 }, -- Titan-Forged Girdle of Salvation
				{ 4, 44894 }, -- Titan-Forged Greaves of Salvation
				{ 6, 44902 }, -- Titan-Forged Plate Helm of Triumph
				{ 7, 46058 }, -- Titan-Forged Breastplate of Triumph
				{ 8, 46072 }, -- Titan-Forged Girdle of Triumph
				{ 9, 44895 }, -- Titan-Forged Greaves of Triumph


				{ 16, 48977 }, -- Titan-Forged Bracers of Salvation
				{ 17, 48992 }, -- Titan-Forged Plate Legplates of Salvation
				{ 19, 48978 }, -- Titan-Forged Bracers of Triumph
				{ 20, 48993 }, -- Titan-Forged Plate Legguards of Triumph

				{ 23, 51581 }, -- Titan-Forged Shoulderplates of Salvation
				{ 24, 51580 }, -- Titan-Forged Plate Shoulderplates of Triumph
			}
		},
		{	-- Gems
			name = ALIL["Gems"],
			[NORMAL_DIFF] = {
				{ 1, 44066 }, -- Kharmaa's Grace

				{ 3, 44081 }, -- Enigmatic Starflare Diamond
				{ 4, 44084 }, -- Forlorn Starflare Diamond
				{ 5, 44082 }, -- Impassive Starflare Diamond
				{ 6, 44076 }, -- Swift Starflare Diamond
				{ 7, 44078 }, -- Swift Starflare Diamond

				{ 18, 44087 }, -- Persistent Earthshatter Diamond
				{ 19, 44088 }, -- Powerful Earthshatter Diamond
				{ 20, 44089 }, -- Trenchant Earthshatter Diamond
			}
		},
		{	-- Gems
		name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 44075 }, -- Arcanum of Dominance
				{ 2, 44069 }, -- Arcanum of Triumph
				{ 16, 44068 }, -- Inscription of Dominance
				{ 17, 44067 }, -- Inscription of Triumph
			}
		},
		{ -- LakeWintergrasp6 / 1389
			name = AL["Recipe"],
			[NORMAL_DIFF] = {
				{ 1, 41730 }, -- Design: Durable Monarch Topaz
				{ 2, 41732 }, -- Design: Empowered Monarch Topaz
				{ 3, 41733 }, -- Design: Lucent Monarch Topaz
				{ 4, 41735 }, -- Design: Shattered Forest Emerald
				{ 5, 41739 }, -- Design: Opaque Forest Emerald
				{ 6, 41736 }, -- Design: Tense Forest Emerald
				{ 7, 41737 }, -- Design: Turbid Forest Emerald
				{ 8, 41738 }, -- Design: Steady Forest Emerald
				{ 9, 41734 }, -- Design: Resplendent Monarch Topaz
				{ 10, 41727 }, -- Design: Mystic Autumn's Glow
				{ 11, 41740 }, -- Design: Mysterious Twilight Opal
				{ 12, 41728 }, -- Design: Stormy Sky Sapphire
				{ 13, 41742 }, -- Design: Enigmatic Skyflare Diamond
				{ 14, 41743 }, -- Design: Forlorn Skyflare Diamond
				{ 15, 41744 }, -- Design: Impassive Skyflare Diamond
			}
		},
		{ -- LakeWintergrasp7 / 1390
			name = AL["Heirloom"],
			[NORMAL_DIFF] = {
				{ 1, 44107 }, -- Exquisite Sunderseer Mantle
				{ 3, 44103 }, -- Exceptional Stormshroud Shoulders
				{ 4, 44105 }, -- Lasting Feralheart Spaulders
				{ 6, 44102 }, -- Aged Pauldrons of The Five Thunders
				{ 7, 44101 }, -- Prized Beastmaster's Mantle
				{ 9, 44100 }, -- Pristine Lightforge Spaulders
				{ 10, 44099 }, -- Strengthened Stockade Pauldrons
				{ 12, AtlasLoot:GetRetByFaction(44097, 44098) }, -- Inherited Insignia of the Horde / Inherited Insignia of the Alliance
				{ 14, 44115 }, -- Wintergrasp Commendation
				{ 16, 44091 }, -- Sharpened Scarlet Kris
				{ 17, 44096 }, -- Battleworn Thrash Blade
				{ 18, 44092 }, -- Reforged Truesilver Champion
				{ 19, 44094 }, -- The Blessed Hammer of Grace
				{ 20, 44095 }, -- Grand Staff of Jordan
				{ 21, 44093 }, -- Upgraded Dwarven Hand Cannon
			}
		},
		{ -- Mounts
			name = ALIL["Mounts"],
			[NORMAL_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(44077, 43956) }, -- Reins of the Black War Mammoth
			}
		},
	},
}