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
if AtlasLoot:GameVersion_LT(AtlasLoot.BC_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.BC_VERSION_NUM)

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

local FACTIONS_HORDE_CONTENT, FACTIONS_ALLI_CONTENT
if UnitFactionGroup("player") == "Horde" then
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
else
    FACTIONS_ALLI_CONTENT = data:AddContentType(FACTION_ALLIANCE, ATLASLOOT_ALLIANCE_COLOR)
    FACTIONS_HORDE_CONTENT = data:AddContentType(FACTION_HORDE, ATLASLOOT_HORDE_COLOR)
end

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

--[[
data["DUMMY"] = {
	FactionID = 932,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep8" },

			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep7" },

			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep6" },

			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep5" },

			},
		},
	},
}
]]

data["TheAldor"] = {
	FactionID = 932,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep8" },
                { 2, 29123 }, -- Medallion of the Lightbearer
                { 3, 29124 }, -- Vindicator's Brand
                { 5, 28886, [PRICE_EXTRA_ITTYPE] = "holydust:8" }, -- Greater Inscription of Discipline
                { 6, 28887, [PRICE_EXTRA_ITTYPE] = "holydust:8" }, -- Greater Inscription of Faith
                { 7, 28888, [PRICE_EXTRA_ITTYPE] = "holydust:8" }, -- Greater Inscription of Vengeance
                { 8, 28889, [PRICE_EXTRA_ITTYPE] = "holydust:8" }, -- Greater Inscription of Warding
                { 10, 31779 }, -- Aldor Tabard
                { 17, 23602 }, -- Plans: Flamebane Helm
                { 19, 29702 }, -- Pattern: Blastguard Pants
                { 20, 29689 }, -- Pattern: Flamescale Leggings
                { 22, 24295 }, -- Pattern: Golden Spellthread
                { 23, 30844 }, -- Pattern: Flameheart Vest

			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep7" },
                { 2, 29127 }, -- Vindicator's Hauberk
                { 3, 29128 }, -- Lightwarden's Band
                { 4, 29130 }, -- Auchenai Staff
                { 17, 24177 }, -- Design: Pendant of Shadow's End
                { 19, 23604 }, -- Plans: Flamebane Breastplate
                { 21, 29703 }, -- Pattern: Blastguard Boots
                { 22, 29691 }, -- Pattern: Flamescale Boots
                { 23, 25721 }, -- Pattern: Vindicator's Armor Kit
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep6" },
                { 2, 29129 }, -- Anchorite's Robes
                { 4, 28881, [PRICE_EXTRA_ITTYPE] = "holydust:2" }, -- Inscription of Discipline
                { 5, 28878, [PRICE_EXTRA_ITTYPE] = "holydust:2" }, -- Inscription of Faith
                { 6, 28885, [PRICE_EXTRA_ITTYPE] = "holydust:2" }, -- Inscription of Vengeance
                { 7, 28882, [PRICE_EXTRA_ITTYPE] = "holydust:2" }, -- Inscription of Warding
                { 17, 23145 }, -- Design: Royal Shadow Draenite
                { 19, 23603 }, -- Plans: Flamebane Gloves
                { 21, 29704 }, -- Pattern: Blastguard Belt
                { 22, 29693 }, -- Pattern: Flamescale Belt
                { 24, 30843 }, -- Pattern: Flameheart Gloves
                { 25, 24293 }, -- Pattern: Silver Spellthread
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f932rep5" },
                { 17, 23149 }, -- Design: Gleaming Golden Draenite
                { 19, 23601 }, -- Plans: Flamebane Bracers
                { 21, 30842 }, -- Pattern: Flameheart Bracers
			},
		},
	},
}

data["TheScryers"] = {
	FactionID = 934,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f934rep8" },
                { 2, 29126 }, -- Seer's Signet
                { 3, 29125 }, -- Retainer's Blade
                { 5, 28910, [PRICE_EXTRA_ITTYPE] = "arcanerune:8" }, -- Greater Inscription of the Blade
                { 6, 28911, [PRICE_EXTRA_ITTYPE] = "arcanerune:8" }, -- Greater Inscription of the Knight
                { 7, 28912, [PRICE_EXTRA_ITTYPE] = "arcanerune:8" }, -- Greater Inscription of the Oracle
                { 8, 28909, [PRICE_EXTRA_ITTYPE] = "arcanerune:8" }, -- Greater Inscription of the Orb
                { 10, 31780 }, -- Scryers Tabard
                { 17, 23600 }, -- Plans: Enchanted Adamantite Leggings
                { 19, 29698 }, -- Pattern: Enchanted Clefthoof Leggings
                { 20, 29677 }, -- Pattern: Enchanted Felscale Leggings
                { 22, 24294 }, -- Pattern: Runic Spellthread
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f934rep7" },
                { 2, 29131 }, -- Retainer's Leggings
                { 3, 29134 }, -- Gauntlets of the Chosen
                { 4, 29132 }, -- Scryer's Bloodgem
                { 5, 29133 }, -- Seer's Cane
                { 17, 24176 }, -- Design: Pendant of Withering
                { 19, 22908 }, -- Recipe: Elixir of Major Firepower
                { 21, 23599 }, -- Plans: Enchanted Adamantite Breastplate
                { 23, 29700 }, -- Pattern: Enchanted Clefthoof Gloves
                { 24, 29684 }, -- Pattern: Enchanted Felscale Boots
                { 25, 25722 }, -- Pattern: Magister's Armor Kit
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f934rep6" },
                { 2, 28907, [PRICE_EXTRA_ITTYPE] = "arcanerune:2" }, -- Inscription of the Blade
                { 3, 28908, [PRICE_EXTRA_ITTYPE] = "arcanerune:2" }, -- Inscription of the Knight
                { 4, 28904, [PRICE_EXTRA_ITTYPE] = "arcanerune:2" }, -- Inscription of the Oracle
                { 5, 28903, [PRICE_EXTRA_ITTYPE] = "arcanerune:2" }, -- Inscription of the Orb
                { 17, 23143 }, -- Design: Dazzling Deep Peridot
                { 19, 23598 }, -- Plans: Enchanted Adamantite Boots
                { 21, 29701 }, -- Pattern: Enchanted Clefthoof Boots
                { 22, 29682 }, -- Pattern: Enchanted Felscale Gloves
                { 24, 24292 }, -- Pattern: Mystic Spellthread
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f934rep5" },
                { 17, 23133 }, -- Design: Runed Blood Garnet
                { 19, 23597 }, -- Plans: Enchanted Adamantite Belt
			},
		},
	},
}

data["TheShatar"] = {
	FactionID = 935,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f935rep8" },
                { 2, 29177 }, -- A'dal's Command
                { 3, 29175 }, -- Gavel of Pure Light
                { 4, 29176 }, -- Crest of the Sha'tar
                { 6, 31781 }, -- Sha'tar Tabard
                { 17, 33153 }, -- Formula: Enchant Gloves - Threat
                { 199, 31354 }, -- Recipe: Flask of the Titans
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f935rep7" },
                { 2, 29180 }, -- Blessed Scale Girdle
                { 3, 29179 }, -- Xi'ri's Gift
                { 5, 29191 }, -- Glyph of Power
				{ 7, 30634 }, -- Warpforged Key
                { 17, 24182 }, -- Design: Talasite Owl
                { 19, 28281 }, -- Formula: Enchant Weapon - Major Healing
                { 20, 22537 }, -- Formula: Enchant Ring - Healing Power
                { 22, 22915 }, -- Recipe: Transmute Primal Air to Fire
                { 23, 13517 }, -- Recipe: Alchemist's Stone
                { 25, 33159 }, -- Design: Blood of Amber
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f935rep6" },
                { 2, 29195 }, -- Glyph of Arcane Warding
                { 17, 30826 }, -- Design: Ring of Arcane Shielding
                { 18, 33155 }, -- Design: Kailee's Rose
                { 20, 28273 }, -- Formula: Enchant Gloves - Major Healing
                { 22, 29717 }, -- Pattern: Drums of Battle
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f935rep5" },
                { 17, 25904 }, -- Design: Insightful Earthstorm Diamond
			},
		},
	},
}

data["LowerCity"] = {
	FactionID = 1011,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1011rep8" },
                { 2, 30834 }, -- Shapeshifter's Signet
                { 3, 30832 }, -- Gavel of Unearthed Secrets
                { 4, 30830 }, -- Trident of the Outcast Tribe
                { 6, 31778 }, -- Lower City Tabard
                { 17, 33148 }, -- Formula: Enchant Cloak - Dodge
                { 19, 31357 }, -- Recipe: Flask of Chromatic Resistance
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1011rep7" },
                { 2, 30836 }, -- Leggings of the Skettis Exile
                { 3, 30835 }, -- Salvager's Hauberk
                { 4, 30841 }, -- Lower City Prayerbook
                { 6, 30846 }, -- Glyph of the Outcast
				{ 8, 30633 }, -- Auchenai Key
                { 17, 24179 }, -- Design: Felsteel Boar
                { 18, 24175 }, -- Design: Pendant of Thawing
                { 19, 33157 }, -- Design: Falling Star
                { 21, 22910 }, -- Recipe: Elixir of Major Shadow Power
                { 23, 34200 }, -- Pattern: Quiver of a Thousand Feathers
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1011rep6" },
                { 2, 29199 }, -- Glyph of Shadow Warding
                { 17, 22538 }, -- Formula: Enchant Ring - Stats
                { 19, 30833 }, -- Pattern: Cloak of Arcane Evasion

			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1011rep5" },
                { 17, 23138 }, -- Design: Potent Flame Spessarite
			},
		},
	},
}

data["KeepersOfTime"] = {
	FactionID = 989,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f989rep8" },
                { 2, 29183 }, -- Bindings of the Timewalker
                { 3, 29181 }, -- Timelapse Shard
                { 4, 29182 }, -- Riftmaker
                { 6, 31777 }, -- Keepers of Time Tabard
                { 17, 33152 }, -- Formula: Enchant Gloves - Superior Agility
                { 19, 31355 }, -- Recipe: Flask of Supreme Power
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f989rep7" },
                { 2, 29184 }, -- Timewarden's Leggings
                { 3, 29185 }, -- Continuum Blade
                { 5, 29186 }, -- Glyph of the Defender
				{ 7, 30635 }, -- Key of Time
                { 17, 24181 }, -- Design: Living Ruby Serpent
                { 18, 24174 }, -- Design: Pendant of Frozen Flame
                { 19, 33158 }, -- Design: Stone of Blades
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f989rep6" },
                { 2, 29198 }, -- Glyph of Frost Warding
                { 17, 28272 }, -- Formula: Enchant Gloves - Major Spellpower
                { 18, 22536 }, -- Formula: Enchant Ring - Spellpower
                { 20, 25910 }, -- Design: Enigmatic Skyfire Diamond
                { 21, 33160 }, -- Design: Facet of Eternity
                { 23, 29713 }, -- Pattern: Drums of Panic
			},
		},
	},
}

data["TheVioletEye"] = {
	FactionID = 967,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f967rep8" },
                { 2, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Assassin"], nil },
                { 3, 29283 }, -- Violet Signet of the Master Assassin
                { 5, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Mage"], nil },
                { 6, 29287 }, -- Violet Signet of the Archmage
                { 17, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Restorer"], nil },
                { 18, 29290 }, -- Violet Signet of the Grand Restorer
                { 20, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Protector"], nil },
                { 21, 29279 }, -- Violet Signet of the Great Protector
                { 23, 33124 }, -- Pattern: Cloak of Darkness
                { 25, 33165 }, -- Formula: Enchant Weapon - Greater Agility
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f967rep7" },
                { 2, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Assassin"], nil },
                { 3, 29282 }, -- Violet Signet
                { 5, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Mage"], nil },
                { 6, 29286 }, -- Violet Signet
                { 17, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Restorer"], nil },
                { 18, 29291 }, -- Violet Signet
                { 20, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Protector"], nil },
                { 21, 29278 }, -- Violet Signet
                { 8, 34581 }, -- Mysterious Arrow
                { 9, 34582 }, -- Mysterious Shell
                { 23, 31394 }, -- Plans: Iceguard Leggings
                { 24, 33205 }, -- Pattern: Shadowprowler's Chestguard
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f967rep6" },
                { 2, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Assassin"], nil },
                { 3, 29281 }, -- Violet Signet
                { 5, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Mage"], nil },
                { 6, 29285 }, -- Violet Signet
                { 17, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Restorer"], nil },
                { 18, 29289 }, -- Violet Signet
                { 20, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Protector"], nil },
                { 21, 29277 }, -- Violet Signet
                { 8, 31113 }, -- Violet Badge
                { 9, 29187 }, -- Inscription of Endurance
                { 23, 31395 }, -- Plans: Iceguard Helm
                { 24, 31393 }, -- Plans: Iceguard Breastplate
                { 25, 31401 }, -- Design: The Frozen Eye
                { 26, 33209 }, -- Recipe: Flask of Chromatic Wonder
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f967rep5" },
                { 2, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Assassin"], nil },
                { 3, 29280 }, -- Violet Signet
                { 5, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Mage"], nil },
                { 6, 29284 }, -- Violet Signet
                { 17, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Restorer"], nil },
                { 18, 29288 }, -- Violet Signet
                { 20, "INV_Jewelry_Ring_62", nil, AL["Path of the Violet Protector"], nil },
                { 21, 29276 }, -- Violet Signet
			},
		},
	},
}

data["TheScaleOfTheSands"] = {
	FactionID = 990,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
        { -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f990rep8" },
                { 2, 29301 }, -- Band of the Eternal Champion
                { 3, 29297 }, -- Band of the Eternal Defender
                { 17, 29305 }, -- Band of the Eternal Sage
                { 18, 29309 }, -- Band of the Eternal Restorer
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f990rep7" },
                { 2, 29300 }, -- Band of Eternity
                { 3, 29296 }, -- Band of Eternity
                { 17, 29304 }, -- Band of Eternity
                { 18, 29308 }, -- Band of Eternity
                { 5, 32292 }, -- Design: Rigid Lionseye
                { 6, 32308 }, -- Design: Wicked Pyrestone
                { 7, 32309 }, -- Design: Enduring Seaspray Emerald
                { 8, 32302 }, -- Design: Royal Shadowsong Amethyst
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f990rep6" },
                { 2, 29299 }, -- Band of Eternity
                { 3, 29295 }, -- Band of Eternity
                { 17, 29303 }, -- Band of Eternity
                { 18, 29306 }, -- Band of Eternity
                { 5, 31737 }, -- Timeless Arrow
		        { 20, 31735 }, -- Timeless Shell
                { 7, 35763 }, -- Design: Quick Lionseye
                { 8, 32306 }, -- Design: Glinting Pyrestone
                { 9, 32305 }, -- Design: Luminous Pyrestone
                { 10, 32304 }, -- Design: Potent Pyrestone
                { 11, 35762 }, -- Design: Reckless Pyrestone
                { 12, 32299 }, -- Design: Balanced Shadowsong Amethyst
                { 13, 32301 }, -- Design: Glowing Shadowsong Amethyst
                { 22, 32300 }, -- Design: Infused Shadowsong Amethyst
                { 23, 32311 }, -- Design: Dazzling Seaspray Emerald
                { 24, 35765 }, -- Design: Forceful Seaspray Emerald
                { 25, 32312 }, -- Design: Jagged Seaspray Emerald
                { 26, 32310 }, -- Design: Radiant Seaspray Emerald
                { 27, 35764 }, -- Design: Steady Seaspray Emerald
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f990rep5" },
                { 2, 29298 }, -- Band of Eternity
                { 3, 29294 }, -- Band of Eternity
                { 17, 29302 }, -- Band of Eternity
                { 18, 29307 }, -- Band of Eternity
                { 5, 32274 }, -- Design: Bold Crimson Spinel
                { 6, 32283 }, -- Design: Bright Crimson Spinel
                { 7, 32277 }, -- Design: Delicate Crimson Spinel
                { 8, 32282 }, -- Design: Runed Crimson Spinel
                { 9, 32284 }, -- Design: Subtle Crimson Spinel
                { 10, 32281 }, -- Design: Teardrop Crimson Spinel
                { 11, 32288 }, -- Design: Lustrous Empyrean Sapphire
                { 20, 32286 }, -- Design: Solid Empyrean Sapphire
                { 21, 32287 }, -- Design: Sparkling Empyrean Sapphire
                { 22, 32290 }, -- Design: Brilliant Lionseye
                { 23, 32293 }, -- Design: Gleaming Lionseye
                { 24, 32291 }, -- Design: Smooth Lionseye
                { 25, 32294 }, -- Design: Thick Lionseye
			},
		},
	},
}

data["CenarionExpedition"] = {
	FactionID = 942,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f942rep8" },
                { 2, 33999 }, -- Cenarion War Hippogryph
                { 4, 29170 }, -- Windcaller's Orb
                { 5, 29172 }, -- Ashyen's Gift
                { 6, 29171 }, -- Earthwarden
                { 8, 31804 }, -- Cenarion Expedition Tabard
                { 17, 31390 }, -- Plans: Wildguard Breastplate
                { 19, 31402 }, -- Design: The Natural Ward
                { 21, 33149 }, -- Formula: Enchant Cloak - Stealth
                { 23, 31356 }, -- Recipe: Flask of Distilled Wisdom
                { 24, 22922 }, -- Recipe: Major Nature Protection Potion
                { 26, 29721 }, -- Pattern: Nethercleft Leg Armor
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f942rep7" },
                { 2, 29174 }, -- Watcher's Cowl
                { 3, 31949 }, -- Warden's Arrow
                { 4, 29173 }, -- Strength of the Untamed
                { 6, 29192 }, -- Glyph of Ferocity
				{ 8, 30623 }, -- Reservoir Key
                { 17, 31392 }, -- Plans: Wildguard Helm
                { 18, 31391 }, -- Plans: Wildguard Leggings
                { 20, 24183 }, -- Design: Nightseye Panther
                { 22, 22918 }, -- Recipe: Transmute Primal Water to Air
                { 24, 28271 }, -- Formula: Enchant Gloves - Spell Strike
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f942rep6" },
                { 2, 25838 }, -- Warden's Hauberk
                { 3, 25836 }, -- Preserver's Cudgel
                { 4, 25835 }, -- Explorer's Walking Stick
                { 6, 29194 }, -- Glyph of Nature Warding
                { 17, 25735 }, -- Pattern: Heavy Clefthoof Vest
                { 18, 25736 }, -- Pattern: Heavy Clefthoof Leggings
                { 19, 29720 }, -- Pattern: Clefthide Leg Armor
                { 21, 25869 }, -- Recipe: Transmute Earthstorm Diamond
                { 22, 32070 }, -- Recipe: Earthen Elixir
                { 24, 23618 }, -- Plans: Adamantite Sharpening Stone
                { 25, 28632 }, -- Plans: Adamantite Weightstone
                { 26, 25526 }, -- Plans: Greater Rune of Warding
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f942rep5" },
                { 2, 24417 }, -- Scout's Arrow
                { 3, 24429 }, -- Expedition Flare
                { 17, 25737 }, -- Pattern: Heavy Clefthoof Boots
                { 19, 23814 }, -- Schematic: Green Smoke Flare
			},
		},
	},
}

data["TheConsortium"] = {
	FactionID = 933,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f933rep8" },
                { 2, 29122 }, -- Nether Runner's Cowl
                { 3, 29119 }, -- Haramad's Bargain
                { 4, 29121 }, -- Guile of Khoraazi
                { 6, 31776 }, -- Consortium Tabard
                { 17, 33622 }, -- Design: Relentless Earthstorm Diamond
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f933rep7" },
                { 2, 29117 }, -- Stormspire Vest
                { 3, 29116 }, -- Nomad's Leggings
                { 4, 29115 }, -- Consortium Blaster
                { 17, 24178 }, -- Design: Pendant of the Null Rune
                { 18, 25903 }, -- Design: Bracing Earthstorm Diamond
                { 19, 33156 }, -- Design: Crimson Sun
                { 20, 33305 }, -- Design: Don Julio's Heart
                { 22, 25734 }, -- Pattern: Fel Leather Leggings
                { 24, 22535 }, -- Formula: Enchant Ring - Striking
                { 26, 23874 }, -- Schematic: Elemental Seaforium Charge
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f933rep6" },
                { 2, 29457 }, -- Nethershard
                { 3, 29118 }, -- Smuggler's Ammo Pouch
                { 5, 29456 }, -- Gift of the Ethereal
                { 17, 25733 }, -- Pattern: Fel Leather Boots
                { 19, 24314 }, -- Pattern: Bag of Jewels
                { 21, 23134 }, -- Design: Delicate Blood Garnet
                { 22, 23155 }, -- Design: Lustrous Azure Moonstone
                { 23, 23150 }, -- Design: Thick Golden Draenite
                { 24, 25908 }, -- Design: Swift Skyfire Diamond
                { 25, 25902 }, -- Design: Powerful Earthstorm Diamond
                { 27, 22552 }, -- Formula: Enchant Weapon - Major Striking
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f933rep5" },
                { 17, 25732 }, -- Pattern: Fel Leather Gloves
                { 19, 28274 }, -- Formula: Enchant Cloak - Spell Penetration
                { 21, 23146 }, -- Design: Shifting Shadow Draenite
                { 22, 23136 }, -- Design: Luminous Flame Spessarite
			},
		},
	},
}

data["AshtongueDeathsworn"] = {
	FactionID = 1012,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1012rep8" },
                { 2, 32486 }, -- Ashtongue Talisman of Equilibrium
                { 3, 32487 }, -- Ashtongue Talisman of Swiftness
                { 4, 32488 }, -- Ashtongue Talisman of Insight
                { 5, 32489 }, -- Ashtongue Talisman of Zeal
                { 6, 32490 }, -- Ashtongue Talisman of Acumen
                { 7, 32492 }, -- Ashtongue Talisman of Lethality
                { 8, 32491 }, -- Ashtongue Talisman of Vision
                { 9, 32493 }, -- Ashtongue Talisman of Shadows
                { 10, 32485 }, -- Ashtongue Talisman of Valor
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1012rep7" },
                -- empty but keep in, looks better
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1012rep6" },
                { 17, 32443 }, -- Plans: Shadesteel Greaves
                { 18, 32441 }, -- Plans: Shadesteel Sabots
                { 20, 32433 }, -- Pattern: Redeemed Soul Moccasins
                { 21, 32434 }, -- Pattern: Redeemed Soul Wristguards
                { 22, 32431 }, -- Pattern: Greaves of Shackled Souls
                { 23, 32432 }, -- Pattern: Waistguard of Shackled Souls
                { 24, 32447 }, -- Pattern: Night's End
                { 25, 32439 }, -- Pattern: Soulguard Leggings
                { 26, 32437 }, -- Pattern: Soulguard Slippers
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1012rep5" },
                { 17, 32444 }, -- Plans: Shadesteel Girdle
                { 18, 32442 }, -- Plans: Shadesteel Bracers
                { 20, 32436 }, -- Pattern: Redeemed Soul Cinch
                { 21, 32435 }, -- Pattern: Redeemed Soul Legguards
                { 22, 32430 }, -- Pattern: Bracers of Shackled Souls
                { 23, 32429 }, -- Pattern: Boots of Shackled Souls
                { 24, 32440 }, -- Pattern: Soulguard Girdle
                { 25, 32438 }, -- Pattern: Soulguard Bracers
			},
		},
	},
}

data["ShatteredSunOffensive"] = {
	FactionID = 1077,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
    ContentPhaseBC = 5,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1077rep8" },
                { 2, 34676 }, -- Dawnforged Defender
                { 3, 34675 }, -- Sunward Crest
                { 4, 34678 }, -- Shattered Sun Pendant of Acumen
                { 5, 34679 }, -- Shattered Sun Pendant of Might
                { 6, 34680 }, -- Shattered Sun Pendant of Resolve
                { 7, 34677 }, -- Shattered Sun Pendant of Restoration
                { 9, 35221 }, -- Tabard of the Shattered Sun
                { 17, 35322 }, -- Design: Quick Dawnstone
                { 18, 35323 }, -- Design: Reckless Noble Topaz
                { 19, 35325 }, -- Design: Forceful Talasite
                { 20, 35247 }, -- Design: Flashing Crimson Spinel
                { 21, 35257 }, -- Design: Great Lionseye
                { 22, 35267 }, -- Design: Inscribed Pyrestone
                { 23, 35258 }, -- Design: Mystic Lionseye
                { 24, 37504 }, -- Design: Purified Shadowsong Amethyst
                { 25, 35242 }, -- Design: Shifting Shadowsong Amethyst
                { 26, 35243 }, -- Design: Sovereign Shadowsong Amethyst
                { 27, 35265 }, -- Design: Stormy Empyrean Sapphire
                { 28, 35270 }, -- Design: Veiled Pyrestone
                { 12, 35755 }, -- Recipe: Assassin's Alchemist Stone
                { 13, 35752 }, -- Recipe: Guardian's Alchemist Stone
                { 14, 35754 }, -- Recipe: Redeemer's Alchemist Stone
                { 15, 35753 }, -- Recipe: Sorcerer's Alchemist Stone
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1077rep7" },
                { 2, 34667 }, -- Archmage's Guile
                { 3, 34672 }, -- Inuuro's Blade
                { 4, 34666 }, -- The Sunbreaker
                { 5, 34671 }, -- K'iru's Presage
                { 6, 34670 }, -- Seeker's Gavel
                { 7, 34673 }, -- Legionfoe
                { 8, 34674 }, -- Truestrike Crossbow
                { 9, 34665 }, -- Bombardier's Blade
                { 11, 29193 }, -- Glyph of the Gladiator
                { 17, 35769 }, -- Design: Forceful Seaspray Emerald
                { 18, 35768 }, -- Design: Quick Lionseye
                { 19, 35767 }, -- Design: Reckless Pyrestone
                { 20, 35766 }, -- Design: Steady Seaspray Emerald
                { 21, 35252 }, -- Design: Enduring Seaspray Emerald
                { 22, 35259 }, -- Design: Rigid Lionseye
                { 23, 35241 }, -- Design: Royal Shadowsong Amethyst
                { 24, 35271 }, -- Design: Wicked Pyrestone
                { 25, 35708 }, -- Design: Regal Nightseye
                { 26, 35505 }, -- Design: Ember Skyfire Diamond
                { 27, 35502 }, -- Design: Eternal Earthstorm Diamond
                { 28, 35699 }, -- Design: Figurine - Seaspray Albatross
                { 29, 35698 }, -- Design: Figurine - Shadowsong Panther
                { 30, 35697 }, -- Design: Figurine - Crimson Serpent
                { 14, 35695 }, -- Design: Figurine - Empyrean Tortoise
                { 15, 35696 }, -- Design: Figurine - Khorium Boar
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1077rep6" },
                { 17, 35238 }, -- Design: Balanced Shadowsong Amethyst
                { 18, 35251 }, -- Design: Dazzling Seaspray Emerald
                { 19, 35266 }, -- Design: Glinting Pyrestone
                { 20, 35239 }, -- Design: Glowing Shadowsong Amethyst
                { 21, 35240 }, -- Design: Infused Shadowsong Amethyst
                { 22, 35253 }, -- Design: Jagged Seaspray Emerald
                { 23, 35268 }, -- Design: Luminous Pyrestone
                { 24, 35269 }, -- Design: Potent Pyrestone
                { 25, 35254 }, -- Design: Radiant Seaspray Emerald
                { 27, 35500 }, -- Formula: Enchant Chest - Defense
                { 28, 34872 }, -- Formula: Void Shatter
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1077rep5" },
                { 2, 34780 }, -- Naaru Ration
                { 17, 35244 }, -- Design: Bold Crimson Spinel
                { 18, 35254 }, -- Design: Radiant Seaspray Emerald
                { 19, 35255 }, -- Design: Brilliant Lionseye
                { 20, 35246 }, -- Design: Delicate Crimson Spinel
                { 21, 35256 }, -- Design: Gleaming Lionseye
                { 22, 35262 }, -- Design: Lustrous Empyrean Sapphire
                { 23, 35248 }, -- Design: Runed Crimson Spinel
                { 24, 35260 }, -- Design: Smooth Lionseye
                { 25, 35263 }, -- Design: Solid Empyrean Sapphire
                { 26, 35264 }, -- Design: Sparkling Empyrean Sapphire
                { 27, 35249 }, -- Design: Subtle Crimson Spinel
                { 28, 35250 }, -- Design: Teardrop Crimson Spinel
                { 29, 35261 }, -- Design: Thick Lionseye
			},
		},
	},
}

-- ## Second
data["ShatariSkyguard"] = {
	FactionID = 1031,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1031rep8" },
                { 2, 32770 }, -- Skyguard Silver Cross
                { 3, 32771 }, -- Airman's Ribbon of Gallantry
                { 5, 32445 }, -- Skyguard Tabard
                { 17, 38628 }, -- Nether Ray Fry
                { 19, 32319 }, -- Blue Riding Nether Ray
                { 20, 32314 }, -- Green Riding Nether Ray
                { 21, 32317 }, -- Red Riding Nether Ray
                { 22, 32316 }, -- Purple Riding Nether Ray
                { 23, 32318 }, -- Silver Riding Nether Ray
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1031rep7" },
                { 2, 32539 }, -- Skyguard's Drape
                { 3, 32538 }, -- Skywitch's Drape
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1031rep6" },
                { 2, 32721 }, -- Skyguard Rations
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1031rep5" },
                { 2, 32722 }, -- Enriched Terocone Juice
			},
		},
	},
}

data["Netherwing"] = {
	FactionID = 1015,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1015rep8" },
                { 2, 32858 }, -- Reins of the Azure Netherwing Drake
                { 3, 32859 }, -- Reins of the Cobalt Netherwing Drake
                { 4, 32857 }, -- Reins of the Onyx Netherwing Drake
                { 5, 32860 }, -- Reins of the Purple Netherwing Drake
                { 6, 32861 }, -- Reins of the Veridian Netherwing Drake
                { 7, 32862 }, -- Reins of the Violet Netherwing Drake
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1015rep7" },
                { 2, 32864 }, -- Commander's Badge
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1015rep6" },
                { 2, 32695 }, -- Captain's Badge
                { 3, 32863 }, -- Skybreaker Whip
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1015rep5" },
                { 2, 32694 }, -- Overseer's Badge
			},
		},
	},
}

data["Sporeggar"] = {
	FactionID = 970,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f970rep8" },
                { 2, 34478 }, -- Tiny Sporebat
                { 4, 31775 }, -- Sporeggar Tabard
                { 17, 22906 }, -- Recipe: Shrouding Potion
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f970rep7" },
                { 2, 29150 }, -- Hardened Stone Shard
                { 3, 29149 }, -- Sporeling's Firestick
                { 17, 22916 }, -- Recipe: Transmute Primal Earth to Water
                { 19, 38229 }, -- Pattern: Mycah's Botanical Bag
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f970rep6" },
                { 2, 25827 }, -- Muck-Covered Drape
                { 3, 25828 }, -- Petrified Lichen Guard
                { 4, 25550 }, -- Redcap Toadstool
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f970rep5" },
                { 2, 25548 }, -- Tallstalk Mushroom
                { 3, 24539 }, -- Marsh Lichen
                { 17, 27689 }, -- Recipe: Sporeling Snack
                { 18, 30156 }, -- Recipe: Clam Bar
			},
		},
	},
}

data["Ogrila"] = {
	FactionID = 1038,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f1038rep8" },
                { 2, 32647 }, -- Shard-bound Bracers
                { 3, 32648 }, -- Vortex Walking Boots
                { 4, 32651 }, -- Crystal Orb of Enlightenment
                { 5, 32645 }, -- Crystalline Crossbow
                { 7, 32828 }, -- Ogri'la Tabard
                { 17, 32569 }, -- Apexis Shard
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f1038rep7" },
                { 2, 32653 }, -- Apexis Cloak
                { 3, 32654 }, -- Crystalforged Trinket
                { 4, 32652 }, -- Ogri'la Aegis
                { 5, 32650 }, -- Cerulean Crystal Rod
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f1038rep6" },
                { 2, 32784 }, -- Red Ogre Brew
                { 3, 32783 }, -- Blue Ogre Brew
                { 17, 32572 }, -- Apexis Crystal
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f1038rep5" },
                { 2, 32910 }, -- Red Ogre Brew Special
                { 3, 32909 }, -- Blue Ogre Brew Special
			},
		},
	},
}

-- ## Horde
data["Tranquillien"] = {
	FactionID = 922,
	ContentType = FACTIONS_HORDE_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[HORDE_DIFF] = {
				{ 1, "f922rep8" },
                { 2, 22990 }, -- Tranquillien Champion's Cloak
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[HORDE_DIFF] = {
				{ 1, "f922rep7" },
                { 2, 22986 }, -- Apothecary's Robe
                { 3, 22987 }, -- Deathstalker's Vest
                { 4, 22985 }, -- Suncrown Hauberk
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[HORDE_DIFF] = {
				{ 1, "f922rep6" },
                { 2, 28155 }, -- Apothecary's Waistband
                { 3, 28158 }, -- Batskin Belt
                { 4, 28162 }, -- Tranquillien Defender's Girdle
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[HORDE_DIFF] = {
				{ 1, "f922rep5" },
                { 2, 22991 }, -- Apprentice Boots
                { 3, 22992 }, -- Bogwalker Boots
                { 4, 22993 }, -- Volunteer's Greaves
                { 5, 28164 }, -- Tranquillien Flamberge
			},
		},
	},
}

data["Thrallmar"] = {
	FactionID = 947,
	ContentType = FACTIONS_HORDE_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[HORDE_DIFF] = {
				{ 1, "f947rep8" },
                { 2, 29155 }, -- Stormcaller
                { 3, 29165 }, -- Warbringer
                { 4, 29152 }, -- Marksman's Bow
                { 6, 24004 }, -- Thrallmar Tabard
                { 17, 33151 }, -- Formula: Enchant Cloak - Subtlety
                { 19, 24002 }, -- Plans: Felsteel Shield Spike
                { 21, 31362 }, -- Pattern: Nethercobra Leg Armor
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[HORDE_DIFF] = {
				{ 1, "f947rep7" },
                { 2, 29168 }, -- Ancestral Band
                { 3, 29167 }, -- Blackened Spear
                { 4, 32882 }, -- Hellfire Shot
                { 6, 29190 }, -- Glyph of Renewal

				{ 8, 30637 }, -- Flamewrought Key

                { 17, 31358 }, -- Design: Dawnstone Crab
                { 19, 24003 }, -- Formula: Enchant Chest - Exceptional Stats
                { 21, 34201 }, -- Pattern: Netherscale Ammo Pouch
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[HORDE_DIFF] = {
				{ 1, "f947rep6" },
                { 2, 25824 }, -- Farseer's Band
                { 3, 25823 }, -- Grunt's Waraxe
                { 5, 29197 }, -- Glyph of Fire Warding

                { 17, 25739 }, -- Pattern: Felstalker Bracers
                { 18, 25740 }, -- Pattern: Felstalker Breastplate
                { 19, 31361 }, -- Pattern: Cobrahide Leg Armor
                { 21, 29232 }, -- Recipe: Transmute Skyfire Diamond
                { 22, 24001 }, -- Recipe: Elixir of Major Agility
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[HORDE_DIFF] = {
				{ 1, "f947rep5" },
                { 2, 24006 }, -- Grunt's Waterskin
                { 3, 24009 }, -- Dried Fruit Rations
                { 17, 25738 }, -- Pattern: Felstalker Belt
                { 19, 31359 }, -- Design: Enduring Deep Peridot
                { 21, 24000 }, -- Formula: Enchant Bracer - Superior Healing
			},
		},
	},
}

data["TheMaghar"] = {
	FactionID = 941,
	ContentType = FACTIONS_HORDE_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[HORDE_DIFF] = {
				{ 1, "f941rep8" },
                { 2, 29139 }, -- Ceremonial Cover
                { 3, 29135 }, -- Earthcaller's Headdress
                { 4, 29137 }, -- Hellscream's Will
                { 6, 31773 }, -- Mag'har Tabard
                { 17, 29102 }, -- Reins of the Cobalt War Talbuk
                { 18, 29104 }, -- Reins of the Silver War Talbuk
                { 19, 29105 }, -- Reins of the Tan War Talbuk
                { 20, 29103 }, -- Reins of the White War Talbuk
                { 21, 31829 }, -- Reins of the Cobalt Riding Talbuk
                { 22, 31831 }, -- Reins of the Silver Riding Talbuk
                { 23, 31833 }, -- Reins of the Tan Riding Talbuk
                { 24, 31835 }, -- Reins of the White Riding Talbuk
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[HORDE_DIFF] = {
				{ 1, "f941rep7" },
                { 2, 29147 }, -- Talbuk Hide Spaulders
                { 3, 29141 }, -- Tempest Leggings
                { 4, 29145 }, -- Band of Ancestral Spirits
                { 17, 25743 }, -- Pattern: Netherfury Boots
                { 19, 22917 }, -- Recipe: Transmute Primal Fire to Earth
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[HORDE_DIFF] = {
				{ 1, "f941rep6" },
                { 2, 29143 }, -- Clefthoof Hide Quiver
                { 17, 25742 }, -- Pattern: Netherfury Leggings
                { 18, 34174 }, -- Pattern: Drums of Restoration
                { 19, 34172 }, -- Pattern: Drums of Speed
                { 20, 29664 }, -- Pattern: Reinforced Mining Bag
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[HORDE_DIFF] = {
				{ 1, "f941rep5" },
                { 17, 25741 }, -- Pattern: Netherfury Belt
			},
		},
	},
}

-- ## Alliance
data["HonorHold"] = {
	FactionID = 946,
	ContentType = FACTIONS_ALLI_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f946rep8" },
                { 2, 29153 }, -- Blade of the Archmage
                { 3, 29156 }, -- Honor's Call
                { 4, 29151 }, -- Veteran's Musket
                { 6, 23999 }, -- Honor Hold Tabard
                { 17, 33150 }, -- Formula: Enchant Cloak - Subtlety
                { 19, 23619 }, -- Plans: Felsteel Shield Spike
                { 21, 29722 }, -- Pattern: Nethercobra Leg Armor
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[ALLIANCE_DIFF] = {
				{ 1, "f946rep7" },
                { 2, 29169 }, -- Ring of Convalescence
                { 3, 29166 }, -- Hellforged Halberd
                { 4, 32883 }, -- Felbane Slugs
                { 6, 29189 }, -- Glyph of Renewal

				{ 8, 30622 }, -- Flamewrought Key

                { 17, 24180 }, -- Design: Dawnstone Crab
                { 19, 22547 }, -- Formula: Enchant Chest - Exceptional Stats
                { 21, 34218 }, -- Pattern: Netherscale Ammo Pouch
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[ALLIANCE_DIFF] = {
				{ 1, "f946rep6" },
                { 2, 25826 }, -- Sage's Band
                { 3, 25825 }, -- Footman's Longsword
                { 5, 29196 }, -- Glyph of Fire Warding

                { 17, 29214 }, -- Pattern: Felstalker Bracers
                { 18, 29215 }, -- Pattern: Felstalker Breastplate
                { 19, 29719 }, -- Pattern: Cobrahide Leg Armor
                { 21, 25870 }, -- Recipe: Transmute Skyfire Diamond
                { 22, 22905 }, -- Recipe: Elixir of Major Agility
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[ALLIANCE_DIFF] = {
				{ 1, "f946rep5" },
                { 2, 24007 }, -- Footman's Waterskin
                { 3, 24008 }, -- Dried Mushroom Rations
                { 17, 29213 }, -- Pattern: Felstalker Belt
                { 19, 23142 }, -- Design: Enduring Deep Peridot
                { 21, 22531 }, -- Formula: Enchant Bracer - Superior Healing
			},
		},
	},
}

data["Kurenai"] = {
	FactionID = 978,
	ContentType = FACTIONS_ALLI_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f978rep8" },
                { 2, 29140 }, -- Cloak of the Ancient Spirits
                { 3, 29136 }, -- Far Seer's Helm
                { 4, 29138 }, -- Arechron's Gift
                { 6, 31774 }, -- Kurenai Tabard
                { 17, 29227 }, -- Reins of the Cobalt War Talbuk
                { 18, 29229 }, -- Reins of the Silver War Talbuk
                { 19, 29230 }, -- Reins of the Tan War Talbuk
                { 20, 29231 }, -- Reins of the White War Talbuk
                { 21, 31830 }, -- Reins of the Cobalt Riding Talbuk
                { 22, 31832 }, -- Reins of the Silver Riding Talbuk
                { 23, 31834 }, -- Reins of the Tan Riding Talbuk
                { 24, 31836 }, -- Reins of the White Riding Talbuk
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[ALLIANCE_DIFF] = {
				{ 1, "f978rep7" },
                { 2, 29148 }, -- Blackened Leather Spaulders
                { 3, 29142 }, -- Kurenai Kilt
                { 4, 29146 }, -- Band of Elemental Spirits
                { 17, 29218 }, -- Pattern: Netherfury Boots
                { 18, 30443 }, -- Recipe: Transmute Primal Fire to Earth
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[ALLIANCE_DIFF] = {
				{ 1, "f978rep6" },
                { 2, 29144 }, -- Worg Hide Quiver
                { 17, 29219 }, -- Pattern: Netherfury Leggings
                { 18, 34175 }, -- Pattern: Drums of Restoration
                { 19, 34173 }, -- Pattern: Drums of Speed
                { 20, 30444 }, -- Pattern: Reinforced Mining Bag
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[ALLIANCE_DIFF] = {
				{ 1, "f978rep5" },
                { 17, 29217 }, -- Pattern: Netherfury Belt
			},
		},
	},
}
