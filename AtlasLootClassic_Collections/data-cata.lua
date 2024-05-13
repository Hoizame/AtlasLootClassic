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
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)


local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
--local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
--local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

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
local AC_ITTYPE = data:AddItemTableType("Item", "Achievement")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
--local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

data["CookingCata"] = {
	name = format(AL["'%s' Recipes"], ALIL["Cooking"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	items = {
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Recipe"],
			[NORMAL_DIFF] = {
			},
		},
	}
}

data["JusticePoints"] = {
	name = format(AL["'%s' Vendor"], AL["Justice Points"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Shield"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Off Hand"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Token"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Misc"],
			[NORMAL_DIFF] = {
			},
		},
	}
}

data["ValorPoints"] = {
	name = format(AL["'%s' Vendor"], AL["ValorPoints"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Token"],
			[NORMAL_DIFF] = {
			},
		},
	}
}

-- shared!
data["WorldEpicsCata"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["World Epics"],
			[NORMAL_ITTYPE] = {
			},
		},
	},
}

data["MountsCata"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["PvP"],
			[NORMAL_DIFF] = {
			},
		},
		{ -- Drops
			name = AL["Drops"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Achievements"] ,
			TableType = AC_ITTYPE,
			[NORMAL_DIFF] = {
			},
		},
	},
}

data["CompanionsCata"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Achievements"],
			TableType = AC_ITTYPE,
			[NORMAL_DIFF] = {
			},
		},
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
			},
		},
		{ -- Misc
			name = AL["Misc"],
			[NORMAL_DIFF] = {
			},
		},
	},
}

data["TabardsCata"] = {
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
				{ 1, 43155 },	-- Tabard of the Ebon Blade
				{ 2, 43157 },	-- Tabard of the Kirin Tor
				{ 3, 43156 },	-- Tabard of the Wyrmrest Accord
			},
		},
	},
}

data["LegendariesCata"] = {
	name = AL["Legendaries"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Lengendaries"],
			[NORMAL_ITTYPE] = {
				{ 1, 71086, "ac5839" }, -- Dragonwrath, Tarecgosa's Rest
				{ 16, 77949, "ac6181" }, -- Golad, Twilight of Aspects
				{ 17, 77950, "ac6181" }, -- 	Tiriosh, Nightmare of Ages
			},
		},
	},
}

data["HeirloomCata"] = {
	name = AL["Heirloom"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CATA_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_ITTYPE] = {
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_ITTYPE] = {
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_ITTYPE] = {
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_ITTYPE] = {
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_ITTYPE] = {
			},
		},
	},
}
