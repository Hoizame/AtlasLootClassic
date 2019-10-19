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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], {0.1, 0.3, 0.1, 1})

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]]--

local AD_INSIGNIA_FORMAT_BLUE, AD_INSIGNIA_FORMAT_EPIC = "|cff0070dd%d|r",  "|cffa335ee%d|r" -- format(AD_INSIGNIA_FORMAT, 30)
data["ArgentDawn"] = {
	FactionID = 529,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep8" },
				{ 2, 18182 }, -- Chromatic Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 27), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 27) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 6), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 6) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep7" },
				{ 2, 13810 }, -- Blessed Sunfruit
				{ 3, 13813 }, -- Blessed Sunfruit Juice
				{ 5,  19217 }, -- Pattern: Argent Shoulders
				{ 6,  19329 }, -- Pattern: Golden Mantle of the Dawn
				{ 7,  19205 }, -- Plans: Gloves of the Dawn
				{ 8,  19447 }, -- Formula: Enchant Bracer - Healing
				{ 10,  18171 }, -- Arcane Mantle of the Dawn
				{ 11,  18169 }, -- Flame Mantle of the Dawn
				{ 12,  18170 }, -- Frost Mantle of the Dawn
				{ 13,  18172 }, -- Nature Mantle of the Dawn
				{ 14, 18173 }, -- Shadow Mantle of the Dawn
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 45), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 45) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 7), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 7) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep6" },
				{ 2,  19216 }, -- Pattern: Argent Boots
				{ 3,  19328 }, -- Pattern: Dawn Treaders
				{ 4,  19203 }, -- Plans: Girdle of the Dawn
				{ 5,  19442 }, -- Formula: Powerful Anti-Venom
				{ 6,  19446 }, -- Formula: Enchant Bracer - Mana Regeneration
				{ 7, 13482 }, -- Recipe: Transmute Air to Fire
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 75), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 75) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 20), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 20) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f529rep5" },
				{ 2,  13724 }, -- Enriched Manna Biscuit
				{ 17,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 110), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 110) }, -- Insignia of the Dawn / Crusade
				{ 18,  22523, 22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 30), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 30) }, -- Insignia of the Dawn / Crusade
			},
		},
	},
}

data["Timbermaw"] = {
	FactionID = 576,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep8" },
				{ 2, 21326 }, -- Defender of the Timbermaw
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep7" },
				{ 2, 19218 }, -- Pattern: Mantle of the Timbermaw
				{ 3, 19327 }, -- Pattern: Timbermaw Brawlers
				{ 4, 19204 }, -- Plans: Heavy Timbermaw Boots
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep6" },
				{ 2,  16768 }, -- Furbolg Medicine Pouch
				{ 3,  16769 }, -- Furbolg Medicine Totem
				{ 4, 19202 }, -- Plans: Heavy Timbermaw Belt
				{ 5, 19326 }, -- Pattern: Might of the Timbermaw
				{ 6, 19215 }, -- Pattern: Wisdom of the Timbermaw
				{ 7, 19445 }, -- Formula: Enchant Weapon - Agility
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep5" },
				{ 2,  13484 }, -- Recipe: Transmute Earth to Water
				{ 3,  15754 }, -- Pattern: Warbear Woolies
				{ 4,  15742 }, -- Pattern: Warbear Harness
				{ 5,  22392 }, -- Formula: Enchant 2H Weapon - Agility
			},
		},
	},
}

data["ThoriumBrotherhood"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
				{ 2,  20040 }, -- Plans: Dark Iron Boots
				{ 3,  19210 }, -- Plans: Ebon Hand
				{ 4,  19211 }, -- Plans: Blackguard
				{ 5,  19212 }, -- Plans: Nightfall
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
				{ 2,  19220 }, -- Pattern: Flarecore Leggings
				{ 3,  19333 }, -- Pattern: Molten Belt
				{ 4,  19332 }, -- Pattern: Corehound Belt
				{ 5,  17053 }, -- Plans: Fiery Chain Shoulders
				{ 6,  19331 }, -- Pattern: Chromatic Gauntlets
				{ 7,  19207 }, -- Plans: Dark Iron Gauntlets
				{ 8,  17052 }, -- Plans: Dark Iron Leggings
				{ 9,  19208 }, -- Plans: Black Amnesty
				{ 10,  19209 }, -- Plans: Blackfury
				{ 11, 19449 }, -- Formula: Enchant Weapon - Mighty Intellect
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
				{ 2,  17017 }, -- Pattern: Flarecore Mantle
				{ 3,  19219 }, -- Pattern: Flarecore Robe
				{ 4,  19330 }, -- Pattern: Lava Belt
				{ 5,  17049 }, -- Plans: Fiery Chain Girdle
				{ 6,  17025 }, -- Pattern: Black Dragonscale Boots
				{ 7,  19206 }, -- Plans: Dark Iron Helm
				{ 8,  17059 }, -- Plans: Dark Iron Reaver
				{ 9,  17060 }, -- Plans: Dark Iron Destroyer
				{ 10,  19448 }, -- Formula: Enchant Weapon - Mighty Spirit
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
				{ 2,  17018 }, -- Pattern: Flarecore Gloves
				{ 3,  17023 }, -- Pattern: Molten Helm
				{ 4,  17022 }, -- Pattern: Corehound Boots
				{ 5,  17051 }, -- Plans: Dark Iron Bracers
				{ 6,  20761 }, -- Recipe: Transmute Elemental Fire
				{ 7,  19444 }, -- Formula: Enchant Weapon - Strength
			},
		},
	},
}

data["CenarionCircle"] = {
	FactionID = 609,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep8" },
				{ 2,  20382 }, -- Pattern: Dreamscale Breastplate
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep7" },
				{ 2,  22683 }, -- Pattern: Gaea's Embrace
				{ 3,  22312 }, -- Pattern: Satchel of Cenarius
				{ 4,  22774 }, -- Pattern: Sylvan Vest
				{ 5,  22771 }, -- Pattern: Bramblewood Helm
				{ 6,  20508 }, -- Pattern: Spitfire Breastplate
				{ 7,  20511 }, -- Pattern: Sandstalker Breastplate
				{ 8,  22766 }, -- Plans: Ironvine Breastplate
				{ 9,  22219 }, -- Plans: Jagged Obsidian Shield
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep6" },
				{ 2,  22773 }, -- Pattern: Sylvan Crown
				{ 3,  22770 }, -- Pattern: Bramblewood Boots
				{ 4,  20507 }, -- Pattern: Spitfire Gauntlets
				{ 5,  20510 }, -- Pattern: Sandstalker Gauntlets
				{ 6,  22767 }, -- Plans: Ironvine Gloves
				{ 7,  22214 }, -- Plans: Light Obsidian Belt
				{ 8,  20733 }, -- Formula: Enchant Cloak - Greater Nature Resistance
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f609rep5" },
				{ 2,  22772 }, -- Pattern: Sylvan Shoulders
				{ 3,  22310 }, -- Pattern: Cenarion Herb Bag
				{ 4,  22769 }, -- Pattern: Bramblewood Belt
				{ 5,  20506 }, -- Pattern: Spitfire Bracers
				{ 6,  20509 }, -- Pattern: Sandstalker Bracers
				{ 7,  22768 }, -- Plans: Ironvine Belt
				{ 8,  22209 }, -- Plans: Heavy Obsidian Belt
				{ 9,  20732 }, -- Formula: Enchant Cloak - Greater Fire Resistance
			},
		},
	},
}

data["ZandalarTribe"] = {
	FactionID = 270,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep8" },
				{ 2,  20013 }, -- Recipe: Living Action Potion
				{ 3,  20077 }, -- Zandalar Signet of Might
				{ 4,  20076 }, -- Zandalar Signet of Mojo
				{ 5,  20078 }, -- Zandalar Signet of Serenity
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep7" },
				{ 2,  19764 }, -- Pattern: Bloodvine Vest
				{ 3,  19769 }, -- Pattern: Primal Batskin Jerkin
				{ 4,  19772 }, -- Pattern: Blood Tiger Breastplate
				{ 5,  19776 }, -- Plans: Bloodsoul Breastplate
				{ 6,  19779 }, -- Plans: Darksoul Breastplate
				{ 7,  20011 }, -- Recipe: Mageblood Potion
				{ 17,  20080 }, -- Sheen of Zanza
				{ 18,  20079 }, -- Spirit of Zanza
				{ 19,  20081 }, -- Swiftness of Zanza
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep6" },
				{ 2,  19765 }, -- Pattern: Bloodvine Leggings
				{ 3,  20000 }, -- Schematic: Bloodvine Goggles
				{ 4,  19770 }, -- Pattern: Primal Batskin Gloves
				{ 5,  19773 }, -- Pattern: Blood Tiger Shoulders
				{ 6,  19777 }, -- Plans: Bloodsoul Shoulders
				{ 7,  19780 }, -- Plans: Darksoul Leggings
				{ 8,  20014 }, -- Recipe: Major Troll's Blood Potion
				{ 9,  20756 }, -- Formula: Brilliant Wizard Oil
				{ 10,  20031 }, -- Essence Mango
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep5" },
				{ 2,  19766 }, -- Pattern: Bloodvine Boots
				{ 3,  19771 }, -- Pattern: Primal Batskin Bracers
				{ 4,  20001 }, -- Schematic: Bloodvine Lens
				{ 5,  19778 }, -- Plans: Bloodsoul Gauntlets
				{ 6,  19781 }, -- Plans: Darksoul Shoulders
				{ 7,  20012 }, -- Recipe: Greater Dreamless Sleep
				{ 8,  20757 }, -- Formula: Brilliant Mana Oil
			},
		},
	},
}

data["BroodOfNozdormu"] = {
	FactionID = 910,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep8" },
				{ 2, 21210 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 3, 21205 }, --Signet Ring of the Bronze Dragonflight / 80
				{ 4, 21200 }, --Signet Ring of the Bronze Dragonflight / 80
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep7" },
				{ 2, 21209 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 3, 21204 }, --Signet Ring of the Bronze Dragonflight / 75
				{ 4, 21199 }, --Signet Ring of the Bronze Dragonflight / 75
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep6" },
				{ 2, 21208 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 2, 21203 }, --Signet Ring of the Bronze Dragonflight / 70
				{ 3, 21198 }, --Signet Ring of the Bronze Dragonflight / 70
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep5" },
				{ 2, 21207 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 3, 21202 }, --Signet Ring of the Bronze Dragonflight / 65
				{ 4, 21197 }, --Signet Ring of the Bronze Dragonflight / 65
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep4" },
				{ 2, 21206 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 3, 21201 }, --Signet Ring of the Bronze Dragonflight / 60
				{ 4, 21196 }, --Signet Ring of the Bronze Dragonflight / 60
			},
		},
	},
}

data["HydraxianWaterlords"] = {
	FactionID = 749,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep7" },
				{ 2, 22687 }, -- Pattern: Glacial Wrists
				{ 3, 22698 }, -- Pattern: Icy Scale Bracers
				{ 4, 22705 }, -- Plans: Icebane Bracers
				{ 5, 22695 }, -- Pattern: Polar Bracers
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep6" },
				{ 2, 17333 }, -- Aqual Quintessence
			},
		},
	},
}

data["BloodsailBuccaneers"] = {
	FactionID = 87,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f87rep5" },
				{ 2, 12185 }, -- Bloodsail Admiral's Hat
				{ 3, 22742 }, -- Bloodsail Shirt
				{ 4, 22743 }, -- Bloodsail Sash
				{ 5, 22745 }, -- Bloodsail Pants
			},
		},
	},
}

data["WintersaberTrainers"] = {
	FactionID = 589,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f589rep8", [ATLASLOOT_IT_ALLIANCE] = true },
				{ 2, 13086, [ATLASLOOT_IT_ALLIANCE] = true }, -- Reins of the Winterspring Frostsaber
			},
		},
	},
}
--[[
	data["Timbermaw"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep8" },
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep7" },
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep6" },
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
			},
		},
	},
}
]]


