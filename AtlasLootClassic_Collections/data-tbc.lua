-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
	local d = C_Map.GetAreaInfo(id)
	return d or "GetAreaInfo"..id
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.BC_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.BC_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH")
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH")

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"


data["BadgeofJustice"] = {
	name = format(AL["'%s' Vendor"], AL["Badge of Justice"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 32089 }, -- Mana-Binders Cowl
				{ 2, 32090 }, -- Cowl of Naaru Blessings

				{ 4, 30762 }, -- Infernoweave Robe
				{ 5, 30764 }, -- Infernoweave Gloves
				{ 6, 30761 }, -- Infernoweave Leggings
				{ 7, 30763 }, -- Infernoweave Boots
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 32087 }, -- Mask of the Deceiver
				{ 2, 32088 }, -- Cowl of Beastly Rage

				{ 4, 30776 }, -- Inferno Hardened Chestguard
				{ 5, 30780 }, -- Inferno Hardened Gloves
				{ 6, 30778 }, -- Inferno Hardened Leggings
				{ 7, 30779 }, -- Inferno Hardened Boots
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 32085 }, -- Warpstalker Helm
				{ 2, 32086 }, -- Storm Master's Helmet

				{ 4, 30773 }, -- Inferno Forged Hauberk
				{ 5, 30774 }, -- Inferno Forged Gloves
				{ 6, 30770 }, -- Inferno Forged Boots
				{ 7, 30772 }, -- Inferno Forged Leggings
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 32083 }, -- Faceguard of Determination
				{ 2, 32084 }, -- Helmet of the Steadfast Champion

				{ 4, 30769,  }, -- Inferno Tempered Chestguard
				{ 5, 30767,  }, -- Inferno Tempered Gauntlets
				{ 6, 30766 }, -- Inferno Tempered Leggings
				{ 7, 30768 }, -- Inferno Tempered Boots
			},
		},
		{
			name = ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 29266 }, -- Azure-Shield of Coldarra
				{ 2, 29267 }, -- Light-Bearer's Faith Shield
				{ 3, 29268 }, -- Mazthoril Honor Shield
				{ 5, 29269 }, -- Sapphiron's Wing Bone
				{ 6, 29270 }, -- Flametongue Seal
				{ 7, 29271 }, -- Talisman of Kalecgos
				{ 8, 29272 }, -- Orb of the Soul-Eater
				{ 9, 29273 }, -- Khadgar's Knapsack
				{ 10, 29274 }, -- Tears of Heaven
				{ 16, 29275 }, -- Searing Sunblade
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 29368 }, -- Manasurge Pendant
				{ 2, 29374 }, -- Necklace of Eternal Hope
				{ 3, 29381 }, -- Choker of Vile Intent
				{ 4, 29386 }, -- Necklace of the Juggernaut
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 29369 }, -- Shawl of Shifting Probabilities
				{ 2, 29375 }, -- Bishop's Cloak
				{ 3, 29382 }, -- Blood Knight War Cloak
				{ 4, 29385 }, -- Farstrider Defender's Cloak
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 29367 }, -- Ring of Cryptic Dreams
				{ 2, 29373 }, -- Band of Halos
				{ 3, 29379 }, -- Ring of Arathi Warlords
				{ 4, 29384 }, -- Ring of Unyielding Force
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 29370 }, -- Icon of the Silver Crescent
				{ 2, 29376 }, -- Essence of the Martyr
				{ 3, 29383 }, -- Bloodlust Brooch
				{ 4, 29387 }, -- Gnomeregan Auto-Blocker 600
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 29388 }, -- Libram of Repentance
				{ 2, 29389 }, -- Totem of the Pulsing Earth
				{ 3, 29390 }, -- Everbloom Idol
			},
		},
	}
}

data["BadgeofJustice4"] = {
	name = format(AL["'%s %s' Vendor"], AL["Badge of Justice"], "P4"),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{1, 33588 },
				{2, 33586 },
				{3, 33291 },
				{4, 33584 },
				{6, 33589 },
				{7, 33587 },
				{8, 33585 },
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{1, 33972 },
				{2, 33973 },
				{3, 33566 },
				{4, 33578 },
				{5, 33974 },
				{6, 33559 },
				{7, 33577 },

				{9, 33287 },
				{10, 33557 },
				{11, 33552 },

				{16, 33579 }, -- bonus armor
				{17, 33580 }, -- bonus armor
				{18, 33583 }, -- bonus armor
				{19, 33582 }, -- bonus armor

				{21, 33540 },
				{22, 33539 },
				{23, 33538 },
				{24, 33222 },
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{1, 33970 },
				{2, 33965 },
				{3, 33535 },
				{4, 33524 },
				{5, 33536 },
				{6, 33537 },

				{8, 33529 },
				{9, 33528 },
				{10, 33280 },
				{11, 33527 },

				{16, 33532 },
				{17, 33531 },
				{18, 33386 },
				{19, 33530 },
				{20, 33324 },
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{1, 33810 },
				{2, 33514 },
				{3, 33513 },
				{4, 33331 },
				{5, 33512 },
				{6, 33501 },

				{8, 33520 },
				{9, 33519 },
				{10, 33518 },
				{11, 33207 },

				{16, 33522 },
				{17, 33516 },
				{18, 33517 },
				{19, 33279 },
				{20, 33524 },
				{21, 33515 },
				{22, 33523 },
			},
		},
		{
			name = ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 33334 },
				{ 2, 33325 },
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{1, 33296},
			},
		},
		{
			name = ALIL["Back"],
			[NORMAL_DIFF] = {
				{ 1, 33593 },
				{ 2, 35321 },
				{ 3, 33304 },
				{ 4, 35324 },
				{ 5, 33484 },
				{ 6, 33333 },
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{1, 35326 },
				{2, 34049 },
				{3, 34162 },
				{4, 34163 },
				{5, 33832 },
				{6, 34050 },
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Idols"] },
				{ 2, 33510 },
				{ 3, 33509 },
				{ 4, 33508 },
				{ 6, "INV_Box_01", nil, AL["Librams"] },
				{ 7, 33503 }, -- Libram of Divine Judgement
				{ 8, 33502 }, -- Libram of Mending
				{ 9, 33504 }, -- Libram of Divine Purpose
				{ 16, "INV_Box_01", nil, AL["Totems"] },
				{ 17, 33506 },
				{ 18, 33507 },
				{ 19, 33505 },
			},
		},
		{
			name = ALIL["Wand"],
			[NORMAL_DIFF] = {
				{ 1, 33192 }, -- Carved Witch Doctor Stick
			},
		},
	}
}

--copy/paste from Rootkit for P5 badge items - github issue #199
data["BadgeofJusticeP5"] = {
	name = format(AL["'%s %s' Vendor"], AL["Badge of Justice"], "P5"),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{1, 34926},
				{2, 34924},
				{3, 34925},
				{5, 34919},
				{6, 34917},
				{7, 34918},
				{9, 34938},
				{10, 34936},
				{11, 34937},
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{1, 34911}, --bonus armor
				{2, 34906},  --bonus armor
				{3, 34910}, --bonus armor
				{5, 34929}, -- AP
				{6, 34927}, -- AP
				{7, 34928}, --AP
				{16, 34902},  -- healing
				{17, 34901}, -- healing
				{18, 34900}, -- healing
				{20, 34904},  -- SP
				{21, 34903},  --SP
				{22, 34905},  -- SP
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{1, 34932}, -- Heal
				{2, 34931}, -- heal
				{3, 34930}, -- Heal
				{5, 34916}, -- AP
				{6, 34912}, -- AP
				{7, 34914}, -- AP
				{9, 34935}, -- SP
				{10, 34934}, -- SP
				{11, 34933}, -- SP
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{1, 34947}, -- DEF + SP
				{2, 34945}, -- Def + SP
				{3, 34946}, -- DEF + SP
				{5, 34941}, -- Def + Expertise
				{6, 34939}, -- Def
				{7, 34940}, -- Def + Expertise
				{16, 34923}, -- Healing
				{17, 34921}, -- Healing
				{18, 34922}, -- Healing
				{20, 34944}, -- STR + Haste
				{21, 34942}, -- STR + Haste
				{22, 34943}, -- STR + Haste
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
				{1, 34894},  -- 1H Dagger
				{2, 34949}, -- OH Dagger
				{3, 34952}, -- OH Dagger
				{4, 34950}, -- OH Fist 1.5
				{6, 34893}, -- MH Fist 2.5
				{7, 34951}, -- OH - Fist 2.5
				{16, 34891}, -- 2H Axe
				{18, 34892}, -- Crossbow
				{20, 34898}, -- Staff AP
				{22, 34895}, -- MH Dagger - SP
				{24, 34896}, -- MH Mace - Healing
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{1, 34887},
				{2, 34890},
				{3, 34889},
				{4, 34888},
			},
		},
		{
			name = ALIL["Gem"],
			[NORMAL_DIFF] = {
				{1, 32228},
				{2, 32249},
				{3, 32231},
				{4, 32230},
				{5, 32227},
				{6, 32229},
			},
		},
	}
}

data["BCCSunmote"] = {
	name = format(AL["'%s' Vendor"], AL["Sunmote"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 34405 }, -- Helm of Arcane Purity
				{ 3, 34393 }, -- Shoulderpads of Knowledge's Pursuit
				{ 5, 34399 }, -- Robes of Ghostly Hatred
				{ 7, 34406 }, -- Gloves of Tyri's Power
				{ 9, 34386 }, -- Pantaloons of Growing Strife
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				-- int
				{ 1, 34403 }, -- Cover of Ursoc the Mighty
				{ 3, 34391 }, -- Spaulders of Devastation
				{ 5, 34398 }, -- Utopian Tunic of Elune
				{ 7, 34407 }, -- Tranquil Moonlight Wraps
				{ 9, 34384 }, -- Breeches of Natural Splendor
				-- agi
				{ 16, 34404 }, -- Mask of the Fury Hunter
				{ 18, 34397 }, -- Bladed Chaos Tunic
				{ 20, 34392 }, -- Demontooth Shoulderpads
				{ 22, 34408 }, -- Gloves of the Forest Drifter
				{ 24, 34385 }, -- Leggings of the Immortal Beast
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 34402 }, -- Cover of Ursoc the Mighty
				{ 3, 34396 }, -- Garments of Crashing Shores
				{ 5, 34390 }, -- Erupting Epaulets
				{ 7, 34409 }, -- Gauntlets of the Ancient Frostwolf
				{ 9, 34383 }, -- Kilt of Spiritual Reconstruction
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				-- int
				{ 1, 34401 }, -- Helm of Uther's Resolve
				{ 3, 34389 }, -- Spaulders of the Thalassian Defender
				{ 5, 34395 }, -- Noble Judicator's Chestguard
				{ 7, 34382 }, -- Judicator's Legguards
				-- stam
				{ 16, 34400 }, -- Crown of Dath'Remar
				{ 18, 34388 }, -- Pauldrons of Berserking
				{ 20, 34394 }, -- Breastplate of Agony's Aversion
				{ 22, 34381 }, -- Felstrength Legplates
			},
		},
	}
}

data["WorldEpicsBC"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["One-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				{ 1, 31331 }, -- The Night Blade
				{ 3, 31332 }, -- Blinkstrike
				{ 16, 31336 }, -- Blade of Wizardry
				{ 18, 31342 }, -- The Ancient Scepter of Sue-Min
			}
		},
		{
			name = AL["Two-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				{ 1, 31318 }, -- Singing Crystal Axe
				{ 16, 31322 }, -- The Hammer of Destiny
				{ 18, 31334 }, -- Staff of Natural Fury
			}
		},
		{
			name = AL["Ranged Weapons"],
			[NORMAL_ITTYPE] = {
				{ 1, 31323 }, -- Don Santos' Famous Hunting Rifle
				{ 16, 34622 }, -- Spinesever
			}
		},
		{
			name = ALIL["Trinket"].." & "..ALIL["Finger"].." & "..ALIL["Neck"],
			[NORMAL_ITTYPE] = {
				{ 1, 31339 }, -- Lola's Eve
				{ 3, 31319 }, -- Band of Impenetrable Defenses
				{ 4, 31326 }, -- Truestrike Ring
				{ 16, 31338 }, -- Charlotte's Ivy
				{ 18, 31321 }, -- Choker of Repentance
			}
		},
		{
			name = AL["Equip"],
			[NORMAL_ITTYPE] = {
				{ 1, 31329 }, -- Lifegiving Cloak
				{ 3, 31340 }, -- Will of Edward the Odd
				{ 4, 31343 }, -- Kamaei's Cerulean Skirt
				{ 6, 31333 }, -- The Night Watchman
				{ 7, 31335 }, -- Pants of Living Growth
				{ 18, 31330 }, -- Lightning Crown
				{ 19, 31328 }, -- Leggings of Beast Mastery
				{ 21, 31320 }, -- Chestguard of Exile
			},
		},
	},
}

data["MountsBC"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["Faction Mounts"],
			[ALLIANCE_DIFF] = {
				{ 5, 29745 }, -- Great Blue Elekk
				{ 6, 29746 }, -- Great Green Elekk
				{ 7, 29747 }, -- Great Purple Elekk
				{ 20, 28481 }, -- Brown Elekk
				{ 21, 29743 }, -- Purple Elekk
				{ 22, 29744 }, -- Gray Elekk
				{ 9, 25527 }, -- Swift Red Gryphon
				{ 10, 25528 }, -- Swift Green Gryphon
				{ 11, 25529 }, -- Swift Purple Gryphon
				{ 12, 25473 }, -- Swift Blue Gryphon
				{ 24, 25470 }, -- Golden Gryphon
				{ 25, 25471 }, -- Ebon Gryphon
				{ 26, 25472 }, -- Snowy Gryphon
			},
			[HORDE_DIFF] = {
				{ 1, 29223 }, -- Swift Green Hawkstrider
				{ 2, 29224 }, -- Swift Purple Hawkstrider
				{ 3, 28936 }, -- Swift Pink Hawkstrider
				{ 16, 29220 }, -- Blue Hawkstrider
				{ 17, 29221 }, -- Black Hawkstrider
				{ 18, 29222 }, -- Purple Hawkstrider
				{ 19, 28927 }, -- Red Hawkstrider
				{ 6, 25531 }, -- Swift Green Windrider
				{ 7, 25532 }, -- Swift Yellow Windrider
				{ 8, 25533 }, -- Swift Purple Windrider
				{ 9, 25477 }, -- Swift Red Windrider
				{ 21, 25474 }, -- Tawny Windrider
				{ 22, 25475 }, -- Blue Windrider
				{ 23, 25476 }, -- Green Windrider
			},
		},
		{
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1,  35906 }, -- Reins of the Black War Elekk
				{ 2,  29228 }, -- Reins of the Dark War Talbuk
				{ 3,  28915 }, -- Reins of the Dark Riding Talbuk
				{ 16,  30609 }, -- Swift Nether Drake
				{ 17,  34092 }, -- Merciless Nether Drake
				{ 18,  37676 }, -- Vengeful Nether Drake
				{ 19,  43516 }, -- Brutal Nether Drake
			},
			[HORDE_DIFF] = {
				{ 1, 34129 }, -- Swift Warstrider
				{ 2, 29228 }, -- Reins of the Dark War Talbuk
				{ 3,  28915 }, -- Reins of the Dark Riding Talbuk
				{ 16,  30609 }, -- Swift Nether Drake
				{ 17,  34092 }, -- Merciless Nether Drake
				{ 18,  37676 }, -- Vengeful Nether Drake
				{ 19,  43516 }, -- Brutal Nether Drake
			},
		},
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 32768 }, -- Reins of the Raven Lord
				{ 3, 33809 }, -- Amani War Bear
				{ 16, 30480 }, -- Fiery Warhorse's Reins
				{ 18, 32458 }, -- Ashes of Al'ar
			},
		},
		{
			name = AL["Reputation"],
			[ALLIANCE_DIFF] = {
				{ 1, 29227 }, -- Reins of the Cobalt War Talbuk
				{ 2, 29229 }, -- Reins of the Silver War Talbuk
				{ 3, 29230 }, -- Reins of the Tan War Talbuk
				{ 4, 29231 }, -- Reins of the White War Talbuk
				{ 5, 31830 }, -- Reins of the Cobalt Riding Talbuk
				{ 6, 31832 }, -- Reins of the Silver Riding Talbuk
				{ 7, 31834 }, -- Reins of the Tan Riding Talbuk
				{ 8, 31836 }, -- Reins of the White Riding Talbuk
				{ 16, 33999 }, -- Cenarion War Hippogryph
				{ 18, 32319 }, -- Blue Riding Nether Ray
				{ 19, 32314 }, -- Green Riding Nether Ray
				{ 20, 32317 }, -- Red Riding Nether Ray
				{ 21, 32316 }, -- Purple Riding Nether Ray
				{ 22, 32318 }, -- Silver Riding Nether Ray
				{ 24, 32858 }, -- Reins of the Azure Netherwing Drake
				{ 25, 32859 }, -- Reins of the Cobalt Netherwing Drake
				{ 26, 32857 }, -- Reins of the Onyx Netherwing Drake
				{ 27, 32860 }, -- Reins of the Purple Netherwing Drake
				{ 28, 32861 }, -- Reins of the Veridian Netherwing Drake
				{ 29, 32862 }, -- Reins of the Violet Netherwing Drake
			},
			[HORDE_DIFF] = {
				{ 1, 29102 }, -- Reins of the Cobalt War Talbuk
				{ 2, 29104 }, -- Reins of the Silver War Talbuk
				{ 3, 29105 }, -- Reins of the Tan War Talbuk
				{ 4, 29103 }, -- Reins of the White War Talbuk
				{ 5, 31829 }, -- Reins of the Cobalt Riding Talbuk
				{ 6, 31831 }, -- Reins of the Silver Riding Talbuk
				{ 7, 31833 }, -- Reins of the Tan Riding Talbuk
				{ 8, 31835 }, -- Reins of the White Riding Talbuk
				{ 9, 31836 }, -- Reins of the White Riding Talbuk
				{ 16, 33999 }, -- Cenarion War Hippogryph
				{ 18, 32319 }, -- Blue Riding Nether Ray
				{ 19, 32314 }, -- Green Riding Nether Ray
				{ 20, 32317 }, -- Red Riding Nether Ray
				{ 21, 32316 }, -- Purple Riding Nether Ray
				{ 22, 32318 }, -- Silver Riding Nether Ray
				{ 24, 32858 }, -- Reins of the Azure Netherwing Drake
				{ 25, 32859 }, -- Reins of the Cobalt Netherwing Drake
				{ 26, 32857 }, -- Reins of the Onyx Netherwing Drake
				{ 27, 32860 }, -- Reins of the Purple Netherwing Drake
				{ 28, 32861 }, -- Reins of the Veridian Netherwing Drake
				{ 29, 32862 }, -- Reins of the Violet Netherwing Drake
			},
		},
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1, 34061 }, -- Turbo-Charged Flying Machine Control
				{ 2, 34060 }, -- Flying Machine Control
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 33225 }, -- Reins of the Swift Spectral Tiger
				{ 2, 33224 }, -- Reins of the Spectral Tiger
				{ 4, 38576 }, -- Big Battle Bear
				{ 16, 35226 }, -- X-51 Nether-Rocket X-TREME
				{ 17, 35225 }, -- X-51 Nether-Rocket
			},
		},
	},
}

data["CompanionsBC"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 33993 }, -- Mojo
				{ 3, 35504 }, -- Phoenix Hatchling
				{ 5, 34955 }, -- Scorched Stone
				{ 7, 34535 }, -- Azure Whelpling
				{ 8, 29960 }, -- Captured Firefly
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
				{ 1, 31760 }, -- Miniwing
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 34478 }, -- Tiny Sporebat
				{ 2, 38628 }, -- Nether Ray Fry
				{ 3, 29363 }, -- Mana Wyrmling
				{ 4, 29364 }, -- Brown Rabbit Crate
				{ 6, 29903 }, -- Yellow Moth Egg
				{ 7, 29904 }, -- White Moth Egg
				{ 8, 29902 }, -- Red Moth Egg
				{ 9, 29901 }, -- Blue Moth Egg
				{ 16, 29957 }, -- Silver Dragonhawk Hatchling
				{ 17, 29956 }, -- Red Dragonhawk Hatchling
				{ 18, 29953 }, -- Golden Dragonhawk Hatchling
				{ 19, 29958 }, -- Blue Dragonhawk Hatchling
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
				{ 1, 34425 }, -- Clockwork Rocket Bot
				{ 3, 33154 }, -- Sinister Squashling
				{ 5, 32233 }, -- Wolpertinger's Tankard
				{ 16, 32617 }, -- Sleepy Willy
				{ 17, 32622 }, -- Elekk Training Collar
				{ 18, 32616 }, -- Egbert's Egg
			},
		},
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 35350 }, -- Chuck's Bucket
				{ 2, 33818 }, -- Muckbreath's Bucket
				{ 3, 35349 }, -- Snarly's Bucket
				{ 4, 33816 }, -- Toothy's Bucket
			},
		},
		{ -- Unobtainable
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1, 34493 }, -- Dragon Kite
				{ 2, 32588 }, -- Banana Charm
				{ 3, 38050 }, -- Soul-Trader Beacon
				{ 4	, 34492 }, -- Rocket Chicken
				{ 6, 34519 }, -- Silver Pig Coin
				{ 7, 34518 }, -- Golden Pig Coin
				{ 8, 32498 }, -- Fortune Coin
				{ 9, 32465 }, -- Fortune Coin
				{ 16, 27445 }, -- Magical Crawdad Box
				{ 17, 31665 }, -- Toy RC Mortar Tank
				{ 19, 37297 }, -- Gold Medallion
				{ 20, 37298 }, -- Competitor's Souvenir
				{ 22, 39656 }, -- Tyrael's Hilt
				{ 24, 25535 }, -- Netherwhelp's Collar
				{ 25, 30360 }, -- Lurky's Egg
			},
		},
	},
}

data["TabardsBC"] = {
	name = ALIL["Tabard"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.TABARDS,
	items = {
		{
			name = AL["Factions"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 31779 },	-- Aldor Tabard
				{ 2, 31780 },	-- Scryers Tabard
				{ 4, 31804 },	-- Cenarion Expedition Tabard
				{ 5, 31776 },	-- Consortium Tabard
				{ 6, 31777 },	-- Keepers of Time Tabard
				{ 7, 31778 },	-- Lower City Tabard
				{ 8, 32828 },	-- Ogri'la Tabard
				{ 9, 31781 },	-- Sha'tar Tabard
				{ 10, 32445 },	-- Skyguard Tabard
				{ 11, 31775 },	-- Sporeggar Tabard
				{ 12, 35221 },	-- Tabard of the Shattered Sun
				{ 16, 23999 },	-- Honor Hold Tabard
				{ 17, 31774 },	-- Honor Hold Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 24004 },	-- Thrallmar Tabard
				{ 16, 31773 },	-- Mag'har Tabard
			},
		},
		{ -- Unobtainable Tabards
			name = AL["Unobtainable Tabards"],
			[NORMAL_DIFF] = {
				{ 1, 36941 }, -- Competitor's Tabard
				{ 16, 28788 }, -- Tabard of the Protector
			},
		},
	},
}

data["LegendarysBC"] = {
	name = AL["Legendarys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Legendarys"],
			[NORMAL_ITTYPE] = {
				{ 1,  34334 }, -- Thori'dal, the Stars' Fury

				{ 16,  32837 }, -- Warglaive of Azzinoth
				{ 17,  32838 }, -- Warglaive of Azzinoth
			},
		},
		{
			MapID = 3845,
			[NORMAL_ITTYPE] = {
				{ 1,  30312 }, -- Infinity Blade
				{ 2,  30311 }, -- Warp Slicer
				{ 3,  30317 }, -- Cosmic Infuser
				{ 4,  30316 }, -- Devastation
				{ 5,  30313 }, -- Staff of Disintegration
				{ 6,  30314 }, -- Phaseshift Bulwark
				{ 7,  30318 }, -- Netherstrand Longbow
				{ 8,  30319 }, -- Nether Spike
			},
		},
	},
}

data["ChildrensWeekBC"] = {
	name = AL["Childrens Week"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.CHILDRENS_WEEK,
	items = {
		{ -- ChildrensWeek
			name = AL["Childrens Week"],
			[NORMAL_DIFF] = {
				{ 1,  23007 }, -- Piglet's Collar
				{ 2,  23015 }, -- Rat Cage
				{ 3,  23002 }, -- Turtle Box
				{ 4,  23022 }, -- Curmudgeon's Payoff
				{ 6,  32616 }, -- Egbert's Egg
				{ 7,  32617 }, -- Sleepy Willy
				{ 8,  32622 }, -- Elekk Training Collar
			},
		},
	},
}

data["MidsummerFestivalBC"] = {
	name = AL["Midsummer Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.MIDSUMMER_FESTIVAL,
	items = {
		{ -- MidsummerFestivalTBC
			name = AL["Midsummer Festival"],
			[NORMAL_DIFF] = {
				{ 1,  23083 }, -- Captured Flame
				{ 2,  34686 }, -- Brazier of Dancing Flames
				{ 4,  23324 }, -- Mantle of the Fire Festival
				{ 5,  23323 }, -- Crown of the Fire Festival
				{ 6,  34683 }, -- Sandals of Summer
				{ 7,  34685 }, -- Vestment of Summer
				{ 9,  23247 }, -- Burning Blossom
				{ 10,  34599 }, -- Juggling Torch
				{ 11,  34684 }, -- Handful of Summer Petals
				{ 12,  23246 }, -- Fiery Festival Brew
				{ 16, 23215 }, -- Bag of Smorc Ingredients
				{ 17, 23211 }, -- Toasted Smorc
				{ 18,  23435 }, -- Elderberry Pie
				{ 19, 23327 }, -- Fire-toasted Bun
				{ 20, 23326 }, -- Midsummer Sausage
			},
		},
		{ -- CFRSlaveAhune
			name = C_Map_GetAreaInfo(3717).." - "..AL["Ahune"],
			[NORMAL_DIFF] = {
                { 1, 35514 }, -- Frostscythe of Lord Ahune
                { 2, 35494 }, -- Shroud of Winter's Chill
                { 3, 35495 }, -- The Frost Lord's War Cloak
                { 4, 35496 }, -- Icebound Cloak
                { 5, 35497 }, -- Cloak of the Frigid Winds
                { 7, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 34955 }, -- Scorched Stone
                { 19, 35557 }, -- Huge Snowball
			},
			[HEROIC_DIFF] = {
                { 1, 29434 }, -- Badge of Justice
                { 2, 35507 }, -- Amulet of Bitter Hatred
                { 3, 35508 }, -- Choker of the Arctic Flow
                { 4, 35509 }, -- Amulet of Glacial Tranquility
                { 5, 35511 }, -- Hailstone Pendant
                { 7, 35514 }, -- Frostscythe of Lord Ahune
                { 8, 35494 }, -- Shroud of Winter's Chill
                { 9, 35495 }, -- The Frost Lord's War Cloak
                { 10, 35496 }, -- Icebound Cloak
                { 11, 35497 }, -- Cloak of the Frigid Winds
                { 13, 35723 }, -- Shards of Ahune
                { 22, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 24, 34955 }, -- Scorched Stone
                { 25, 35557 }, -- Huge Snowball
			},
		},
	},
}

data["HalloweenBC"] = {
	name = AL["Hallow's End"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.BC_VERSION_NUM,
	CorrespondingFields = private.HALLOWEEN,
	items = {
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  20400 }, -- Pumpkin Bag
				{ 3,  18633 }, -- Styleen's Sour Suckerpop
				{ 4,  18632 }, -- Moonbrook Riot Taffy
				{ 5,  18635 }, -- Bellara's Nutterbar
				{ 6,  20557 }, -- Hallow's End Pumpkin Treat
				{ 8,  20389 }, -- Candy Corn
				{ 9,  20388 }, -- Lollipop
				{ 10, 20390 }, -- Candy Bar
			},
		},
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 20410 }, -- Hallowed Wand - Bat
				{ 2, 20409 }, -- Hallowed Wand - Ghost
				{ 3, 20399 }, -- Hallowed Wand - Leper Gnome
				{ 4, 20398 }, -- Hallowed Wand - Ninja
				{ 5, 20397 }, -- Hallowed Wand - Pirate
				{ 6, 20413 }, -- Hallowed Wand - Random
				{ 7, 20411 }, -- Hallowed Wand - Skeleton
				{ 8, 20414 }, -- Hallowed Wand - Wisp
			},
		},
		{ -- Halloween3
			name = AL["Hallow's End"].." - "..AL["Masks"],
			[NORMAL_DIFF] = {
				{ 1,  20561 }, -- Flimsy Male Dwarf Mask
				{ 2,  20391 }, -- Flimsy Male Gnome Mask
				{ 3,  20566 }, -- Flimsy Male Human Mask
				{ 4,  20564 }, -- Flimsy Male Nightelf Mask
				{ 5,  20570 }, -- Flimsy Male Orc Mask
				{ 6,  20572 }, -- Flimsy Male Tauren Mask
				{ 7,  20568 }, -- Flimsy Male Troll Mask
				{ 8,  20573 }, -- Flimsy Male Undead Mask
				{ 16, 20562 }, -- Flimsy Female Dwarf Mask
				{ 17, 20392 }, -- Flimsy Female Gnome Mask
				{ 18, 20565 }, -- Flimsy Female Human Mask
				{ 19, 20563 }, -- Flimsy Female Nightelf Mask
				{ 20, 20569 }, -- Flimsy Female Orc Mask
				{ 21, 20571 }, -- Flimsy Female Tauren Mask
				{ 22, 20567 }, -- Flimsy Female Troll Mask
				{ 23, 20574 }, -- Flimsy Female Undead Mask
			},
		},
		{ -- SMHeadlessHorseman
			name = C_Map_GetAreaInfo(796).." - "..AL["Headless Horseman"],
			[NORMAL_DIFF] = {
                { 1, 34075 }, -- Ring of Ghoulish Delight
                { 2, 34073 }, -- The Horseman's Signet Ring
                { 3, 34074 }, -- Witches Band
                { 5, 33808 }, -- The Horseman's Helm
                { 6, 38175 }, -- The Horseman's Blade
                { 8, 33292 }, -- Hallowed Helm
                { 10, 34068 }, -- Weighted Jack-o'-Lantern
                { 12, 33277 }, -- Tome of Thomas Thomson
                { 16, 37012 }, -- The Horseman's Reins
                { 18, 33182 }, -- Swift Flying Broom        280% flying
                { 19, 33176 }, -- Flying Broom              60% flying
                { 21, 33184 }, -- Swift Magic Broom         100% ground
                { 22, 37011 }, -- Magic Broom               60% ground
                { 24, 33154 }, -- Sinister Squashling
			},
		},
	},
}
