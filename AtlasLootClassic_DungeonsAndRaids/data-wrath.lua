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
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 3, AtlasLoot.WRATH_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH")
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH")

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)


local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID20_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID25_CONTENT = data:AddContentType(AL["25 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_WrathoftheLichKing"

-- extra
local CLASS_NAME = AtlasLoot:GetColoredClassNames()

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_CAVERNS_OF_TIME = NAME_COLOR..AL["CoT"]..":|r %s" -- Caverns of Time
local NAME_NEXUS = NAME_COLOR..AL["Nexus"]..":|r %s" -- The Nexus
local NAME_AZJOL = NAME_COLOR..AL["Azjol"]..":|r %s" -- Azjol
local NAME_ULDUAR = NAME_COLOR..AL["Ulduar"]..":|r %s" -- Ulduar
local NAME_UTGARDE = NAME_COLOR..AL["Utgarde"]..":|r %s" -- Utgarde
local NAME_ICC = NAME_COLOR..AL["ICC"]..":|r %s" -- ICC
local NAME_AT = NAME_COLOR..AL["AT"]..":|r %s" -- Argent Tournament

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

-- format
local BONUS_LOOT_SPLIT = "%s - %s"


local KEYS = {	-- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
        { 1, "INV_Box_01", nil, AL["Normal"], nil },
		{ 2, 44582 }, -- Key to the Focusing Iris
        { 3, 45796 }, -- Celestial Planetarium Key
        { 4, 42482 }, -- The Violet Hold Key
		{ 16, "INV_Box_01", nil, AL["Heroic"], nil },
		{ 17, 44581 }, -- Heroic Key to the Focusing Iris
        { 18, 45798 }, -- Heroic Celestial Planetarium Key
    }
}

local T7_SET = {
	name = format(AL["Tier %s Sets"], "7"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[RAID10_DIFF] = {
		{ 1,    3100802 }, -- Warlock
		{ 3,    3100804 }, -- Priest / Heal
        { 4,    3100805 }, -- Priest / Shadow
        { 6,    3100801 }, -- Rogue
		{ 8,    3100794 }, -- Hunter
		{ 10,   3100787 }, -- Warrior / Prot
        { 11,   3100788 }, -- Warrior / DD
        { 13,   3100793 }, -- Deathknight / Prot
        { 14,   3100792 }, -- Deathknight / DD
		{ 16,   3100803 }, -- Mage
        { 18,   3100799 }, -- Druid / Heal
        { 19,   3100800 }, -- Druid / Owl
        { 20,   3100798 }, -- Druid / Feral
        { 22,   3100797 }, -- Shaman / Heal
        { 23,   3100796 }, -- Shaman / Ele
        { 24,   3100795 }, -- Shaman / Enh
        { 26,   3100790 }, -- Paladin / Heal
        { 27,   3100791 }, -- Paladin / Prot
        { 28,   3100789 }, -- Paladin / DD
	},
    [RAID25_DIFF] = {
        { 1,    3250802 }, -- Warlock
        { 3,    3250804 }, -- Priest / Heal
        { 4,    3250805 }, -- Priest / Shadow
        { 6,    3250801 }, -- Rogue
        { 8,    3250794 }, -- Hunter
        { 10,   3250787 }, -- Warrior / Prot
        { 11,   3250788 }, -- Warrior / DD
        { 13,   3250793 }, -- Deathknight / Prot
        { 14,   3250792 }, -- Deathknight / DD
        { 16,   3250803 }, -- Mage
        { 18,   3250799 }, -- Druid / Heal
        { 19,   3250800 }, -- Druid / Owl
        { 20,   3250798 }, -- Druid / Feral
        { 22,   3250797 }, -- Shaman / Heal
        { 23,   3250796 }, -- Shaman / Ele
        { 24,   3250795 }, -- Shaman / Enh
        { 26,   3250790 }, -- Paladin / Heal
        { 27,   3250791 }, -- Paladin / Prot
        { 28,   3250789 }, -- Paladin / DD
	},
}

local T8_SET = {
	name = format(AL["Tier %s Sets"], "8"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[RAID10_DIFF] = {
		{ 1,    3100837 }, -- Warlock
		{ 3,    3100833 }, -- Priest / Heal
        { 4,    3100832 }, -- Priest / Shadow
        { 6,    3100826 }, -- Rogue
		{ 8,    3100838 }, -- Hunter
		{ 10,   3100831 }, -- Warrior / Prot
        { 11,   3100830 }, -- Warrior / DD
        { 13,   3100835 }, -- Deathknight / Prot
        { 14,   3100834 }, -- Deathknight / DD
		{ 16,   3100836 }, -- Mage
		{ 18,   3100829 }, -- Druid / Heal
        { 19,   3100828 }, -- Druid / Owl
        { 20,   3100827 }, -- Druid / Feral
        { 22,   3100825 }, -- Shaman / Heal
        { 23,   3100824 }, -- Shaman / Ele
        { 24,   3100823 }, -- Shaman / Enh
		{ 26,   3100822 }, -- Paladin / Heal
        { 27,   3100821 }, -- Paladin / Prot
        { 28,   3100820 }, -- Paladin / DD
	},
    [RAID25_DIFF] = {
		{ 1,    3250837 }, -- Warlock
		{ 3,    3250833 }, -- Priest / Heal
        { 4,    3250832 }, -- Priest / Shadow
        { 6,    3250826 }, -- Rogue
		{ 8,    3250838 }, -- Hunter
		{ 10,   3250831 }, -- Warrior / Prot
        { 11,   3250830 }, -- Warrior / DD
        { 13,   3250835 }, -- Deathknight / Prot
        { 14,   3250834 }, -- Deathknight / DD
		{ 16,   3250836 }, -- Mage
		{ 18,   3250829 }, -- Druid / Heal
        { 19,   3250828 }, -- Druid / Owl
        { 20,   3250827 }, -- Druid / Feral
        { 22,   3250825 }, -- Shaman / Heal
        { 23,   3250824 }, -- Shaman / Ele
        { 24,   3250823 }, -- Shaman / Enh
		{ 26,   3250822 }, -- Paladin / Heal
        { 27,   3250821 }, -- Paladin / Prot
        { 28,   3250820 }, -- Paladin / DD
	},
}

local T9_SET = {
	name = format(AL["Tier %s Sets"], "9"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
        { -- horde
            { 1,    3000845 }, -- Warlock
            { 3,    3000848 }, -- Priest / Heal
            { 4,    3000850 }, -- Priest / Shadow
            { 6,    3000858 }, -- Rogue
            { 8,    3000860 }, -- Hunter
            { 10,   3000870 }, -- Warrior / Prot
            { 11,   3000868 }, -- Warrior / DD
            { 13,   3000874 }, -- Deathknight / Prot
            { 14,   3000872 }, -- Deathknight / DD
            { 16,   3000844 }, -- Mage
            { 18,   3000852 }, -- Druid / Heal
            { 19,   3000854 }, -- Druid / Owl
            { 20,   3000856 }, -- Druid / Feral
            { 22,   3000862 }, -- Shaman / Heal
            { 23,   3000863 }, -- Shaman / Ele
            { 24,   3000866 }, -- Shaman / Enh
            { 26,   3000876 }, -- Paladin / Heal
            { 27,   3000880 }, -- Paladin / Prot
            { 28,   3000878 }, -- Paladin / DD
        },
        { -- alli
            { 1,    3000846 }, -- Warlock
            { 3,    3000847 }, -- Priest / Heal
            { 4,    3000849 }, -- Priest / Shadow
            { 6,    3000857 }, -- Rogue
            { 8,    3000859 }, -- Hunter
            { 10,   3000869 }, -- Warrior / Prot
            { 11,   3000867 }, -- Warrior / DD
            { 13,   3000873 }, -- Deathknight / Prot
            { 14,   3000871 }, -- Deathknight / DD
            { 16,   3000843 }, -- Mage
            { 18,   3000851 }, -- Druid / Heal
            { 19,   3000853 }, -- Druid / Owl
            { 20,   3000855 }, -- Druid / Feral
            { 22,   3000861 }, -- Shaman / Heal
            { 23,   3000864 }, -- Shaman / Ele
            { 24,   3000865 }, -- Shaman / Enh
            { 26,   3000875 }, -- Paladin / Heal
            { 27,   3000879 }, -- Paladin / Prot
            { 28,   3000877 }, -- Paladin / DD
        }
    ),
    [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
        { -- horde
            { 1,    3250845 }, -- Warlock
            { 3,    3250848 }, -- Priest / Heal
            { 4,    3250850 }, -- Priest / Shadow
            { 6,    3250858 }, -- Rogue
            { 8,    3250860 }, -- Hunter
            { 10,   3250870 }, -- Warrior / Prot
            { 11,   3250868 }, -- Warrior / DD
            { 13,   3250874 }, -- Deathknight / Prot
            { 14,   3250872 }, -- Deathknight / DD
            { 16,   3250844 }, -- Mage
            { 18,   3250852 }, -- Druid / Heal
            { 19,   3250854 }, -- Druid / Owl
            { 20,   3250856 }, -- Druid / Feral
            { 22,   3250862 }, -- Shaman / Heal
            { 23,   3250863 }, -- Shaman / Ele
            { 24,   3250866 }, -- Shaman / Enh
            { 26,   3250876 }, -- Paladin / Heal
            { 27,   3250880 }, -- Paladin / Prot
            { 28,   3250878 }, -- Paladin / DD
        },
        { -- alli
            { 1,    3250846 }, -- Warlock
            { 3,    3250847 }, -- Priest / Heal
            { 4,    3250849 }, -- Priest / Shadow
            { 6,    3250857 }, -- Rogue
            { 8,    3250859 }, -- Hunter
            { 10,   3250869 }, -- Warrior / Prot
            { 11,   3250867 }, -- Warrior / DD
            { 13,   3250873 }, -- Deathknight / Prot
            { 14,   3250871 }, -- Deathknight / DD
            { 16,   3250843 }, -- Mage
            { 18,   3250851 }, -- Druid / Heal
            { 19,   3250853 }, -- Druid / Owl
            { 20,   3250855 }, -- Druid / Feral
            { 22,   3250861 }, -- Shaman / Heal
            { 23,   3250864 }, -- Shaman / Ele
            { 24,   3250865 }, -- Shaman / Enh
            { 26,   3250875 }, -- Paladin / Heal
            { 27,   3250879 }, -- Paladin / Prot
            { 28,   3250877 }, -- Paladin / DD
        }
    ),
    [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
        { -- horde
            { 1,    3251845 }, -- Warlock
            { 3,    3251848 }, -- Priest / Heal
            { 4,    3251850 }, -- Priest / Shadow
            { 6,    3251858 }, -- Rogue
            { 8,    3251860 }, -- Hunter
            { 10,   3251870 }, -- Warrior / Prot
            { 11,   3251868 }, -- Warrior / DD
            { 13,   3251874 }, -- Deathknight / Prot
            { 14,   3251872 }, -- Deathknight / DD
            { 16,   3251844 }, -- Mage
            { 18,   3251852 }, -- Druid / Heal
            { 19,   3251854 }, -- Druid / Owl
            { 20,   3251856 }, -- Druid / Feral
            { 22,   3251862 }, -- Shaman / Heal
            { 23,   3251863 }, -- Shaman / Ele
            { 24,   3251866 }, -- Shaman / Enh
            { 26,   3251876 }, -- Paladin / Heal
            { 27,   3251880 }, -- Paladin / Prot
            { 28,   3251878 }, -- Paladin / DD
        },
        { -- alli
            { 1,    3251846 }, -- Warlock
            { 3,    3251847 }, -- Priest / Heal
            { 4,    3251849 }, -- Priest / Shadow
            { 6,    3251857 }, -- Rogue
            { 8,    3251859 }, -- Hunter
            { 10,   3251869 }, -- Warrior / Prot
            { 11,   3251867 }, -- Warrior / DD
            { 13,   3251873 }, -- Deathknight / Prot
            { 14,   3251871 }, -- Deathknight / DD
            { 16,   3251843 }, -- Mage
            { 18,   3251851 }, -- Druid / Heal
            { 19,   3251853 }, -- Druid / Owl
            { 20,   3251855 }, -- Druid / Feral
            { 22,   3251861 }, -- Shaman / Heal
            { 23,   3251864 }, -- Shaman / Ele
            { 24,   3251865 }, -- Shaman / Enh
            { 26,   3251875 }, -- Paladin / Heal
            { 27,   3251879 }, -- Paladin / Prot
            { 28,   3251877 }, -- Paladin / DD
        }
    ),
}

local T10_SET = {
	name = format(AL["Tier %s Sets"], "10"),
	ExtraList = true,
	TableType = SET_ITTYPE,
	--ContentPhaseBC = 6,
	IgnoreAsSource = true,
	[VENDOR_DIFF] = {
		{ 1,    3000884 }, -- Warlock
		{ 3,    3000885 }, -- Priest / Heal
        { 4,    3000886 }, -- Priest / Shadow
        { 6,    3000890 }, -- Rogue
		{ 8,    3000891 }, -- Hunter
		{ 10,   3000896 }, -- Warrior / Prot
        { 11,   3000895 }, -- Warrior / DD
        { 13,   3000898 }, -- Deathknight / Prot
        { 14,   3000897 }, -- Deathknight / DD
		{ 16,   3000883 }, -- Mage
		{ 18,   3000887 }, -- Druid / Heal
        { 19,   3000888 }, -- Druid / Owl
        { 20,   3000889 }, -- Druid / Feral
        { 22,   3000892 }, -- Shaman / Heal
        { 23,   3000893 }, -- Shaman / Ele
        { 24,   3000894 }, -- Shaman / Enh
		{ 26,   3000899 }, -- Paladin / Heal
        { 27,   3000901 }, -- Paladin / Prot
        { 28,   3000900 }, -- Paladin / DD
	},
    [T10_1_DIFF] = {
		{ 1,    3250884 }, -- Warlock
		{ 3,    3250885 }, -- Priest / Heal
        { 4,    3250886 }, -- Priest / Shadow
        { 6,    3250890 }, -- Rogue
		{ 8,    3250891 }, -- Hunter
		{ 10,   3250896 }, -- Warrior / Prot
        { 11,   3250895 }, -- Warrior / DD
        { 13,   3250898 }, -- Deathknight / Prot
        { 14,   3250897 }, -- Deathknight / DD
		{ 16,   3250883 }, -- Mage
		{ 18,   3250887 }, -- Druid / Heal
        { 19,   3250888 }, -- Druid / Owl
        { 20,   3250889 }, -- Druid / Feral
        { 22,   3250892 }, -- Shaman / Heal
        { 23,   3250893 }, -- Shaman / Ele
        { 24,   3250894 }, -- Shaman / Enh
		{ 26,   3250899 }, -- Paladin / Heal
        { 27,   3250901 }, -- Paladin / Prot
        { 28,   3250900 }, -- Paladin / DD
	},
    [T10_2_DIFF] = {
		{ 1,    3251884 }, -- Warlock
		{ 3,    3251885 }, -- Priest / Heal
        { 4,    3251886 }, -- Priest / Shadow
        { 6,    3251890 }, -- Rogue
		{ 8,    3251891 }, -- Hunter
		{ 10,   3251896 }, -- Warrior / Prot
        { 11,   3251895 }, -- Warrior / DD
        { 13,   3251898 }, -- Deathknight / Prot
        { 14,   3251897 }, -- Deathknight / DD
		{ 16,   3251883 }, -- Mage
		{ 18,   3251887 }, -- Druid / Heal
        { 19,   3251888 }, -- Druid / Owl
        { 20,   3251889 }, -- Druid / Feral
        { 22,   3251892 }, -- Shaman / Heal
        { 23,   3251893 }, -- Shaman / Ele
        { 24,   3251894 }, -- Shaman / Enh
		{ 26,   3251899 }, -- Paladin / Heal
        { 27,   3251901 }, -- Paladin / Prot
        { 28,   3251900 }, -- Paladin / DD
	},
}

local WOTLK_DUNGEONMASTER_AC_TABLE = {	--[Northrend Dungeonmaster]
    AchievementID = 1288,
	TableType = AC_ITTYPE,
	ExtraList = true,
    IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1288 },
		{ 2, 477 },			{ 17, 478 },
		{ 3, 479 },			{ 18, 480 },
		{ 4, 481 },			{ 19, 482 },
		{ 5, 483 },			{ 20, 484 },
		{ 6, 485 },			{ 21, 486 },
		{ 7, 487 },			{ 22, 488 },
	},
}

local WOTLK_DUNGEON_HERO_AC_TABLE = {	--[Northrend Dungeon Hero]
    AchievementID = 1289,
	TableType = AC_ITTYPE,
	ExtraList = true,
    IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 1289 },
		{ 2, 489 },			{ 17, 490 },
		{ 3, 500 },			{ 18, 491 },
		{ 4, 492 },			{ 19, 493 },
		{ 5, 494 },			{ 20, 495 },
		{ 6, 496 },			{ 21, 497 },
		{ 7, 498 },			{ 22, 499 },
	},
}

local WOTLK_GLORY_OF_THE_HERO_AC_TABLE = {	--[Glory of the Hero]
    AchievementID = 2136,
	TableType = AC_ITTYPE,
	ExtraList = true,
    IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 2136, 44160 },
		{ 2, 1919 },			{ 17, 2150 },
		{ 3, 2036 },			{ 18, 2037 },
		{ 4, 1296 },			{ 19, 1297 },
		{ 5, 1860 },			{ 20, 1862 },
		{ 6, 2038 },			{ 21, 2056 },
		{ 7, 2151 },			{ 22, 2039 },
		{ 8, 2057 },			{ 23, 1816 },
		{ 9, 1865 },			{ 24, 2041 },
		{ 10, 2153 },			{ 25, 1864 },
		{ 11, 2152 },			{ 26, 2040 },
		{ 12, 2058 },			{ 27, 1866 },
		{ 13, 2154 },			{ 28, 2155 },
		{ 14, 1867 },			{ 29, 1834 },
		{ 15, 2042 },			{ 30, 1817 },
		{ 101, 1872 },			{ 116, 2043 },
		{ 102, 1873 },			{ 117, 2156 },
		{ 103, 2157 },			{ 118, 1871 },
		{ 104, 1868 },			{ 119, 2044 },
		{ 105, 2045 },			{ 120, 2046 },
	},
}

local WOTLK_NAXXRAMAS_AC_TABLE = {	--[Glory of the Raider]
	name = AL["Glory of the Raider"],
	TableType = AC_ITTYPE,
	ExtraList = true,
    IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[RAID10_DIFF] = {
		{ 1, 2137 },
		{ 2, 578 },			    { 17, 1858 },
		{ 3, 1856 },			{ 18, 1996 },
		{ 4, 1997 },			{ 19, 2178 },
		{ 5, 2180 },			{ 20, 622 },
		{ 6, 1874 },			{ 21, 1869 },
		{ 7, 2047 },			{ 22, 2051 },
		{ 8, 2146 },			{ 23, 2176 },
		{ 9, 2148 },			{ 24, 2184 },
        { 10, 2187 },
	},
    [RAID25_DIFF] = {
		{ 1, 2138 },
		{ 2, 579 },			    { 17, 1859 },
		{ 3, 1857 },			{ 18, 2139 },
		{ 4, 2140 },			{ 19, 2179 },
		{ 5, 2181 },			{ 20, 623  },
		{ 6, 1875 },			{ 21, 1870 },
		{ 7, 2048 },			{ 22, 2054 },
		{ 8, 2147 },			{ 23, 2177 },
		{ 9, 2149 },			{ 24, 2185 },
        { 10, 2186 },
	},
}

local WOTLK_ULDUAR_AC_TABLE = {	--[Glory of the Ulduar Raider]
	name = AL["Glory of the Ulduar Raider"],
	TableType = AC_ITTYPE,
	ExtraList = true,
    IgnoreAsSource = true,
	CoinTexture = "Achievement",
	[RAID10_DIFF] = {
		{ 1, 2957 },
		{ 2, 3056 },			{ 17, 2930 },
		{ 3, 2923 },			{ 18, 3058 },
		{ 4, 2941 },			{ 19, 2953 },
		{ 5, 3006 },			{ 20, 3182 },
		{ 6, 3176 },			{ 21, 3179 },
		{ 7, 3180 },			{ 22, 3181 },
		{ 8, 3158 }
	},
    [RAID25_DIFF] = {
		{ 1, 2958 },
		{ 2, 3057 },			{ 17, 2929 },
		{ 3, 2924 },			{ 18, 3059 },
		{ 4, 2944 },			{ 19, 2954 },
		{ 5, 3007 },			{ 20, 3184 },
		{ 6, 3183 },			{ 21, 3187 },
		{ 7, 3189 },			{ 22, 3188 },
		{ 8, 3163 }
	},
}

local WOTLK_ICC_AC_TABLE = {	--[Glory of the Icecrown Raider]
	name = AL["Glory of the Icecrown Raider"],
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[RAID10_DIFF] = {
		{ 1, 4602 },
		{ 2, 4534 },			{ 17, 4535 },
		{ 3, 4536 },			{ 18, 4537 },
		{ 4, 4538 },			{ 19, 4577 },
		{ 5, 4578 },			{ 20, 4582 },
		{ 6, 4539 },			{ 21, 4579 },
		{ 7, 4580 },			{ 22, 4601 },
	},
	[RAID10H_DIFF] = {
		{ 1, 4602 },
		{ 2, 4628 },			{ 17, 4629 },
		{ 3, 4630 },			{ 18, 4631 },
	},
    [RAID25_DIFF] = {
		{ 1, 4603 },
		{ 2, 4610 },			{ 17, 4611 },
		{ 3, 4612 },			{ 18, 4613 },
		{ 4, 4614 },			{ 19, 4615 },
		{ 5, 4616 },			{ 20, 4617 },
		{ 6, 4618 },			{ 21, 4619 },
		{ 7, 4620 },			{ 22, 4621 },
		{ 8, 4622 }
	},
	[RAID25H_DIFF] = {
		{ 1, 4603 },
		{ 2, 4632 },			{ 17, 4633 },
		{ 3, 4634 },			{ 18, 4635 },
	},
}

data["AhnKahet"] = {
    nameFormat = NAME_AZJOL,
	MapID = 4494,
    EncounterJournalID = 271,
	InstanceID = 619,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "AhnKahet",
	AtlasMapFile = {"AhnKahet"},
	LevelRange = {68, 73, 75},
	items = {
        { -- AhnkahetNadox / 15
            name = AL["Elder Nadox"],
            npcID = 29309,
            EncounterJournalID = 580,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35607 }, -- Ahn'kahar Handwraps
                { 2, 35608 }, -- Crawler-Emblem Belt
                { 3, 35606 }, -- Blade of Nadox
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37594 }, -- Elder Headpiece
                { 4, 37593 }, -- Sprinting Shoulderpads
                { 5, 37592 }, -- Brood Plague Helmet
                { 6, 37591 }, -- Nerubian Shield Ring
                { 16, "ac2038" },
            }
        },
        { -- AhnkahetTaldaram / 16
            name = AL["Prince Taldaram"],
            npcID = 29308,
            EncounterJournalID = 581,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35611 }, -- Gloves of the Blood Prince
                { 2, 35610 }, -- Slasher's Amulet
                { 3, 35609 }, -- Talisman of Scourge Command
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37613 }, -- Flame Sphere Bindings
                { 4, 37614 }, -- Gauntlets of the Plundering Geist
                { 5, 37612 }, -- Bonegrinder Breastplate
                { 6, 37595 }, -- Necklace of Taldaram
            }
        },
        { -- AhnkahetAmanitarHEROIC / 17
            name = AL["Amanitar"],
            npcID = 30258,
            EncounterJournalID = 583,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43287 }, -- Silken Bridge Handwraps
                { 4, 43286 }, -- Legguards of Swarming Attacks
                { 5, 43285 }, -- Amulet of the Spell Flinger
                { 6, 43284 }, -- Amanitar Skullbow
            }
        },
        { -- AhnkahetJedoga / 18
            name = AL["Jedoga Shadowseeker"],
            npcID = 29310,
            EncounterJournalID = 582,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 43278 }, -- Cloak of the Darkcaster
                { 2, 43279 }, -- Battlechest of the Twilight Cult
                { 3, 43277 }, -- Jedoga's Greatring
                { 16, 21524 }, -- Red Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43283 }, -- Subterranean Waterfall Shroud
                { 4, 43280 }, -- Faceguard of the Hammer Clan
                { 5, 43282 }, -- Shadowseeker's Pendant
                { 6, 43281 }, -- Edge of Oblivion
                { 16, 21524 }, -- Red Winter Hat
                { 18, "ac2056" },
            }
        },
        { -- AhnkahetVolazj / 19
            name = AL["Herald Volazj"],
            npcID = 29311,
            EncounterJournalID = 584,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 35612 }, -- Mantle of Echoing Bats
                { 2, 35613 }, -- Pyramid Embossed Belt
                { 3, 35614 }, -- Volazj's Sabatons
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37622 }, -- Skirt of the Old Kingdom
                { 4, 37623 }, -- Fiery Obelisk Handguards
                { 5, 37620 }, -- Bracers of the Herald
                { 6, 37619 }, -- Wand of Ahnkahet
                { 7, 37616 }, -- Kilt of the Forgotten One
                { 8, 37618 }, -- Greaves of Ancient Evil
                { 9, 37617 }, -- Staff of Sinister Claws
                { 10, 37615 }, -- Titanium Compound Bow
                { 16, 43102 }, -- Frozen Orb
                { 18, 41790 }, -- Design: Precise Scarlet Ruby
				{ 20, "ac1862" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35616 }, -- Spored Tendrils Spaulders
		        { 2, 35615 }, -- Glowworm Cavern Bindings
            },
            [HEROIC_DIFF] = {
                { 1, 37625 }, -- Web Winder Gloves
		        { 2, 37624 }, -- Stained-Glass Shard Ring
            }
        },
        KEYS,
        WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["AzjolNerub"] = {
    nameFormat = NAME_AZJOL,
	MapID = 4277,
    EncounterJournalID = 272,
	InstanceID = 601,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "AzjolNerub",
	AtlasMapFile = {"AzjolNerub"},
	LevelRange = {67, 72, 74},
	items = {
        { -- AzjolNerubKrikthir / 11
            name = AL["Krik'thir the Gatewatcher"],
            npcID = 28684,
            EncounterJournalID = 585,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35657 }, -- Exquisite Spider-Silk Footwraps
                { 2, 35656 }, -- Aura Focused Gauntlets
                { 3, 35655 }, -- Cobweb Machete
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37218 }, -- Stone-Worn Footwraps
                { 4, 37219 }, -- Custodian's Chestpiece
                { 5, 37217 }, -- Golden Limb Bands
                { 6, 37216 }, -- Facade Shield of Glyphs
                { 16, "ac1296" },
            }
        },
        { -- AzjolNerubHadronox / 12
            name = AL["Hadronox"],
            npcID = 28921,
            EncounterJournalID = 586,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35660 }, -- Spinneret Epaulets
                { 2, 35659 }, -- Treads of Aspiring Heights
                { 3, 35658 }, -- Life-Staff of the Web Lair
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37222 }, -- Egg Sac Robes
                { 4, 37230 }, -- Grotto Mist Gloves
                { 5, 37221 }, -- Hollowed Mandible Legplates
                { 6, 37220 }, -- Essence of Gossamer
                { 16, "ac1297" },
            }
        },
        { -- AzjolNerubAnubarak / 13
            name = AL["Anub'arak"],
            npcID = 29120,
            EncounterJournalID = 587,
            Level = 74,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35663 }, -- Charmed Silken Cord
                { 2, 35662 }, -- Wing Cover Girdle
                { 3, 35661 }, -- Signet of Arachnathid Command
                { 16, 43411 }, -- Anub'arak's Broken Husk
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37242 }, -- Sash of the Servant
                { 4, 37240 }, -- Flamebeard's Bracers
                { 5, 37241 }, -- Ancient Aligned Girdle
                { 6, 37238 }, -- Rod of the Fallen Monarch
                { 7, 37236 }, -- Insect Vestments
                { 8, 37237 }, -- Chitin Shell Greathelm
                { 9, 37232 }, -- Ring of the Traitor King
                { 10, 37235 }, -- Crypt Lord's Deft Blade
                { 16, 43102 }, -- Frozen Orb
                { 18, 41796 }, -- Design: Infused Twilight Opal
                { 20, "ac1860" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [HEROIC_DIFF] = {
                { 1, 37243 }, -- Treasure Seeker's Belt
                { 2, 37625 }, -- Web Winder Gloves
                { 3, 37624 }, -- Stained-Glass Shard Ring
            }
        },
        KEYS,
        WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["DrakTharonKeep"] = {
	MapID = 4196,
    EncounterJournalID = 273,
	InstanceID = 600,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DrakTharonKeep",
	AtlasMapFile = {"DrakTharonKeep"},
	LevelRange = {69, 74, 76},
	items = {
        { -- DrakTharonKeepTrollgore / 21
            name = AL["Trollgore"],
            npcID = 26630,
            EncounterJournalID = 588,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35620 }, -- Berserker's Horns
                { 2, 35619 }, -- Infection Resistant Legguards
                { 3, 35618 }, -- Troll Butcherer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37715 }, -- Cowl of the Dire Troll
                { 4, 37714 }, -- Batrider's Cord
                { 5, 37717 }, -- Legs of Physical Regeneration
                { 6, 37712 }, -- Terrace Defence Boots
                { 16, "ac2151" },
            }
        },
        { -- DrakTharonKeepNovos / 22
            name = AL["Novos the Summoner"],
            npcID = 26631,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35632 }, -- Robes of Novos
                { 2, 35631 }, -- Crystal Pendant of Warding
                { 3, 35630 }, -- Summoner's Stone Gavel
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37722 }, -- Breastplate of Undeath
                { 4, 37718 }, -- Temple Crystal Fragment
                { 5, 37721 }, -- Cursed Lich Blade
                { 16, "ac2057" },
            }
        },
        { -- DrakTharonKeepKingDred / 23
            name = AL["King Dred"],
            npcID = 27483,
            EncounterJournalID = 590,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35635 }, -- Stable Master's Breeches
                { 2, 35634 }, -- Scabrous-Hide Helm
                { 3, 35633 }, -- Staff of the Great Reptile
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37725 }, -- Savage Wound Wrap
                { 4, 37724 }, -- Handler's Arm Strap
                { 5, 37726 }, -- King Dred's Helm
                { 6, 37723 }, -- Incisor Fragment
                { 16, "ac2039" },
            }
        },
        { -- DrakTharonKeepTharonja / 24
            name = AL["The Prophet Tharon'ja"],
            npcID = 26632,
            EncounterJournalID = 591,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35638 }, -- Helmet of Living Flesh
                { 2, 35637 }, -- Muradin's Lost Greaves
                { 3, 35636 }, -- Tharon'ja's Aegis
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37798 }, -- Overlook Handguards
                { 4, 37791 }, -- Leggings of the Winged Serpent
                { 5, 37788 }, -- Limb Regeneration Bracers
                { 6, 37784 }, -- Keystone Great-Ring
                { 7, 37735 }, -- Ziggurat Imprinted Chestguard
                { 8, 37732 }, -- Spectral Seal of the Prophet
                { 9, 37734 }, -- Talisman of Troll Divinity
                { 10, 37733 }, -- Mojo Masked Crusher
                { 16, 43102 }, -- Frozen Orb
                { 18, 41795 }, -- Design: Timeless Forest Emerald
                { 20, "ac1658" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35641 }, -- Scytheclaw Boots
                { 2, 35640 }, -- Darkweb Bindings
                { 3, 35639 }, -- Brighthelm of Guarding
            },
            [HEROIC_DIFF] = {
                { 1, 37799 }, -- Reanimator's Cloak
                { 2, 37800 }, -- Aviary Guardsman's Hauberk
                { 3, 37801 }, -- Waistguard of the Risen Knight
            },
        },
        KEYS,
        WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["Gundrak"] = {
	MapID = 4416,
    EncounterJournalID = 274,
	InstanceID = 604,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Gundrak",
	AtlasMapFile = {"Gundrak"},
	LevelRange = {71, 76, 78},
	items = {
        { -- GundrakSladran / 34
            name = AL["Slad'ran"],
            npcID = 29304,
            EncounterJournalID = 592,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35584 }, -- Embroidered Gown of Zul'drak
                { 2, 35585 }, -- Cannibal's Legguards
                { 3, 35583 }, -- Witch Doctor's Wildstaff
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37629 }, -- Slithering Slippers
                { 4, 37628 }, -- Slad'ran's Coiled Cord
                { 5, 37627 }, -- Snake Den Spaulders
                { 6, 37626 }, -- Wand of Sseratus
                { 16, "ac2058" },
            }
        },
        { -- GundrakColossus / 35
            name = AL["Drakkari Colossus"],
            npcID = 29307,
            EncounterJournalID = 593,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35591 }, -- Shoulderguards of the Ice Troll
                { 2, 35592 }, -- Hauberk of Totemic Mastery
                { 3, 35590 }, -- Drakkari Hunting Bow
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37637 }, -- Living Mojo Belt
                { 4, 37636 }, -- Helm of Cheated Fate
                { 5, 37634 }, -- Bracers of the Divine Elemental
                { 6, 37635 }, -- Pauldrons of the Colossus
            }
        },
        { -- GundrakMoorabi / 36
            name = AL["Moorabi"],
            npcID = 29305,
            EncounterJournalID = 594,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35588 }, -- Forlorn Breastplate of War
                { 2, 35589 }, -- Arcane Focal Signet
                { 3, 35587 }, -- Frozen Scepter of Necromancy
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37630 }, -- Shroud of Moorabi
                { 4, 37633 }, -- Ground Tremor Helm
                { 5, 37632 }, -- Mojo Frenzy Greaves
                { 6, 37631 }, -- Fist of the Deity
                { 16, "ac2040" },
            }
        },
        { -- GundrakEckHEROIC / 37
            name = AL["Eck the Ferocious"],
            npcID = 29932,
            EncounterJournalID = 595,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43313 }, -- Leggings of the Ruins Dweller
                { 4, 43312 }, -- Gorloc Muddy Footwraps
                { 5, 43311 }, -- Helmet of the Shrine
                { 6, 43310 }, -- Engraved Chestplate of Eck
            }
        },
        { -- GundrakGaldarah / 38
            name = AL["Gal'darah"],
            npcID = 29306,
            EncounterJournalID = 596,
            Level = 76,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 43305 }, -- Shroud of Akali
                { 2, 43309 }, -- Amulet of the Stampede
                { 3, 43306 }, -- Gal'darah's Signet
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37643 }, -- Sash of Blood Removal
                { 4, 37644 }, -- Gored Hide Legguards
                { 5, 37645 }, -- Horn-Tipped Gauntlets
                { 6, 37642 }, -- Hemorrhaging Circle
                { 7, 37641 }, -- Arcane Flame Altar-Garb
                { 8, 37640 }, -- Boots of Transformation
                { 9, 37639 }, -- Grips of the Beast God
                { 10, 37638 }, -- Offering of Sacrifice
                { 16, 43102 }, -- Frozen Orb
				{ 18, "ac2152" },
				{ 19, "ac1864" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35594 }, -- Snowmelt Silken Cinch
		        { 2, 35593 }, -- Steel Bear Trap Bracers
                { 3, 37646 }, -- Burning Skull Pendant
            },
            [HEROIC_DIFF] = {
                { 1, 37647 }, -- Cloak of Bloodied Waters
                { 2, 37648 }, -- Belt of Tasseled Lanterns
                { 3, 37646 }, -- Burning Skull Pendant
            },
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["HallsofLightning"] = {
    nameFormat = NAME_ULDUAR,
	MapID = 4272,
    EncounterJournalID = 275,
	InstanceID = 602,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UlduarHallsofLightning",
	AtlasMapFile = {"UlduarHallsofLightning", "UlduarEnt"},
	LevelRange = {75, 79, 80},
	items = {
        { -- HallsofLightningBjarngrim / 45
            name = AL["General Bjarngrim"],
            npcID = 28586,
            EncounterJournalID = 597,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 36982 }, -- Mantle of Electrical Charges
                { 2, 36979 }, -- Bjarngrim Family Signet
                { 3, 36980 }, -- Hewn Sparring Quarterstaff
                { 4, 36981 }, -- Hardened Vrykul Throwing Axe
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37825 }, -- Traditionally Dyed Handguards
                { 4, 37818 }, -- Patroller's War-Kilt
                { 5, 37814 }, -- Iron Dwarf Smith Pauldrons
                { 6, 37826 }, -- The General's Steel Girdle
                { 16, "ac1834" },
            }
        },
        { -- HallsofLightningVolkhan / 46
            name = AL["Volkhan"],
            npcID = 28587,
            EncounterJournalID = 598,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 36983 }, -- Cape of Seething Steam
                { 2, 36985 }, -- Volkhan's Hood
                { 3, 36986 }, -- Kilt of Molten Golems
                { 4, 36984 }, -- Eternally Folded Blade
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37840 }, -- Shroud of Reverberation
                { 4, 37843 }, -- Giant-Hair Woven Gloves
                { 5, 37842 }, -- Belt of Vivacity
                { 6, 37841 }, -- Slag Footguards
                { 16, "ac2042" },
            }
        },
        { -- HallsofLightningIonar / 47
            name = AL["Ionar"],
            npcID = 28546,
            EncounterJournalID = 599,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 39536 }, -- Thundercloud Grasps
                { 2, 39657 }, -- Tornado Cuffs
                { 3, 39534 }, -- Pauldrons of the Lightning Revenant
                { 4, 39535 }, -- Ionar's Girdle
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37846 }, -- Charged-Bolt Grips
                { 4, 37845 }, -- Cord of Swirling Winds
                { 5, 37826 }, -- The General's Steel Girdle
                { 6, 37844 }, -- Winged Talisman
            }
        },
        { -- HallsofLightningLoken / 48
            name = AL["Loken"],
            npcID = 28923,
            EncounterJournalID = 600,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 36991 }, -- Raiments of the Titans
                { 2, 36996 }, -- Hood of the Furtive Assassin
                { 3, 36992 }, -- Leather-Braced Chain Leggings
                { 4, 36995 }, -- Fists of Loken
                { 5, 36988 }, -- Chaotic Spiral Amulet
                { 6, 36993 }, -- Seal of the Pantheon
                { 7, 36994 }, -- Projectile Activator
                { 8, 36989 }, -- Ancient Measuring Rod
                { 16, 41799 }, -- Design: Eternal Earthsiege Diamond
                { 18, 43151 }, -- Loken's Tongue
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37854 }, -- Woven Bracae Leggings
                { 4, 37853 }, -- Advanced Tooled-Leather Bands
                { 5, 37855 }, -- Mail Girdle of the Audient Earth
                { 6, 37852 }, -- Colossal Skull-Clad Cleaver
                { 7, 37851 }, -- Ornate Woolen Stola
                { 8, 37850 }, -- Flowing Sash of Order
                { 9, 37849 }, -- Planetary Helm
                { 10, 37848 }, -- Lightning Giant Staff
                { 16, 43102 }, -- Frozen Orb
                { 18, 41799 }, -- Design: Eternal Earthsiege Diamond
                { 20, "ac1867" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 36997 }, -- Sash of the Hardened Watcher
                { 2, 37000 }, -- Storming Vortex Bracers
                { 3, 36999 }, -- Boots of the Terrestrial Guardian
            },
            [HEROIC_DIFF] = {
                { 1, 37858 }, -- Awakened Handguards
                { 2, 37857 }, -- Helm of the Lightning Halls
                { 3, 37856 }, -- Librarian's Paper Cutter
            },
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["HallsofStone"] = {
    nameFormat = NAME_ULDUAR,
	MapID = 4264,
    EncounterJournalID = 277,
	InstanceID = 599,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UlduarHallsofStone",
	AtlasMapFile = {"UlduarHallsofStone", "UlduarEnt"},
	LevelRange = {72, 77, 79},
	items = {
        { -- HallsofStoneKrystallus / 41
            name = AL["Krystallus"],
            npcID = 27977,
            EncounterJournalID = 604,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35673 }, -- Leggings of Burning Gleam
                { 2, 35672 }, -- Hollow Geode Helm
                { 3, 35670 }, -- Brann's Lost Mining Helmet
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37652 }, -- Spaulders of Krystallus
                { 4, 37650 }, -- Shardling Legguards
                { 5, 37651 }, -- The Prospector's Prize
            }
        },
        { -- HallsofStoneMaiden / 40
            name = AL["Maiden of Grief"],
            npcID = 27975,
            EncounterJournalID = 605,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 38614 }, -- Embrace of Sorrow
                { 2, 38613 }, -- Chain of Fiery Orbs
                { 3, 38611 }, -- Ringlet of Repose
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 38616 }, -- Maiden's Girdle
                { 4, 38615 }, -- Lightning-Charged Gloves
                { 5, 38617 }, -- Woeful Band
                { 6, 38618 }, -- Hammer of Grief
                { 16, "ac1866" },
            }
        },
        { -- HallsofStoneTribunal / 42
            name = AL["The Tribunal of Ages"],
            npcID = 28234,
            EncounterJournalID = 606,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35677 }, -- Cosmos Vestments
                { 2, 35676 }, -- Constellation Leggings
                { 3, 35675 }, -- Linked Armor of the Sphere
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37655 }, -- Mantle of the Tribunal
                { 4, 37656 }, -- Raging Construct Bands
                { 5, 37654 }, -- Sabatons of the Ages
                { 6, 37653 }, -- Sword of Justice
                { 16, "ac2154" },
            }
        },
        { -- HallsofStoneSjonnir / 43
            name = AL["Sjonnir The Ironshaper"],
            npcID = 27978,
            EncounterJournalID = 607,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35679 }, -- Static Cowl
                { 2, 35678 }, -- Ironshaper's Legplates
                { 3, 35680 }, -- Amulet of Wills
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37669 }, -- Leggings of the Stone Halls
                { 4, 37668 }, -- Bands of the Stoneforge
                { 5, 37670 }, -- Sjonnir's Girdle
                { 6, 37667 }, -- The Fleshshaper
                { 7, 37666 }, -- Boots of the Whirling Mist
                { 8, 37658 }, -- Sun-Emblazoned Chestplate
                { 9, 37657 }, -- Spark of Life
                { 10, 37660 }, -- Forge Ember
                { 16, 43102 }, -- Frozen Orb
                { 18, 41792 }, -- Design: Deft Monarch Topaz
                { 20, "ac2155" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35682 }, -- Rune Giant Bindings
                { 2, 35683 }, -- Palladium Ring
                { 3, 35681 }, -- Unrelenting Blade
            },
            [HEROIC_DIFF] = {
                { 1, 37673 }, -- Dark Runic Mantle
                { 2, 37672 }, -- Patina-Coated Breastplate
                { 3, 37671 }, -- Refined Ore Gloves
            },
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["TheCullingOfStratholme"] = {
    nameFormat = NAME_CAVERNS_OF_TIME,
	MapID = 4100,
    EncounterJournalID = 279,
	InstanceID = 595,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "CoTOldStratholme",
	AtlasMapFile = {"CoTOldStratholme", "WL_CoTEnt"},
	LevelRange = {75, 79, 80},
	items = {
        { -- CoTStratholmeMeathook
            name = AL["Meathook"],
            npcID = 26529,
            EncounterJournalID = 611,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37083 }, -- Kilt of Sewn Flesh
                { 2, 37082 }, -- Slaughterhouse Sabatons
                { 3, 37079 }, -- Enchanted Wire Stitching
                { 4, 37081 }, -- Meathook's Slicer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37680 }, -- Belt of Unified Souls
                { 4, 37678 }, -- Bile-Cured Gloves
                { 5, 37679 }, -- Spaulders of the Abomination
                { 6, 37675 }, -- Legplates of Steel Implants
            }
        },
        { -- CoTStratholmeSalramm
            name = AL["Salramm the Fleshcrafter"],
            npcID = 26530,
            EncounterJournalID = 612,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37084 }, -- Flowing Cloak of Command
                { 2, 37095 }, -- Waistband of the Thuzadin
                { 3, 37088 }, -- Spiked Metal Cilice
                { 4, 37086 }, -- Tome of Salramm
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37684 }, -- Forgotten Shadow Hood
                { 4, 37682 }, -- Bindings of Dark Will
                { 5, 37683 }, -- Necromancer's Amulet
                { 6, 37681 }, -- Gavel of the Fleshcrafter
            }
        },
        { -- CoTStratholmeEpoch
            name = AL["Chrono-Lord Epoch"],
            npcID = 26532,
            EncounterJournalID = 613,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37106 }, -- Ouroboros Belt
                { 2, 37105 }, -- Treads of Altered History
                { 3, 37096 }, -- Necklace of the Chrono-Lord
                { 4, 37099 }, -- Sempiternal Staff
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37687 }, -- Gloves of Distorted Time
                { 4, 37686 }, -- Cracked Epoch Grasps
                { 5, 37688 }, -- Legplates of the Infinite Drakonid
                { 6, 37685 }, -- Mobius Band
            }
        },
        { -- CoTStratholmeMalGanis
            name = AL["Mal'Ganis"],
            npcID = 26533,
            EncounterJournalID = 614,
            -- Level = 0,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [NORMAL_DIFF] = {
                { 1, 37113 }, -- Demonic Fabric Bands
                { 2, 37114 }, -- Gloves of Northern Lordaeron
                { 3, 37110 }, -- Gauntlets of Dark Conversion
                { 4, 37109 }, -- Discarded Silver Hand Spaulders
                { 5, 37111 }, -- Soul Preserver
                { 6, 37108 }, -- Dreadlord's Blade
                { 7, 37112 }, -- Beguiling Scepter
                { 8, 37107 }, -- Leeka's Shield
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37696 }, -- Plague-Infected Bracers
                { 4, 37695 }, -- Legguards of Nature's Power
                { 5, 37694 }, -- Band of Guile
                { 6, 37693 }, -- Greed
                { 7, 43085 }, -- Royal Crest of Lordaeron
                { 8, 37691 }, -- Mantle of Deceit
                { 9, 37690 }, -- Pauldrons of Destiny
                { 10, 37689 }, -- Pendant of the Nathrezim
                { 11, 37692 }, -- Pierce's Pistol
                { 16, 43102 }, -- Frozen Orb
            }
        },
        { -- CoTStratholmeInfiniteCorruptorHEROIC
            name = AL["Infinite Corruptor"],
            npcID = 32273,
            Level = 82,
            -- DisplayIDs = {{0}},
            -- AtlasMapBossID = 0,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
		        { 3, 43951 }, -- Reins of the Bronze Drake
            }
        },
        { -- CoTHillsbradTrash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 37117 }, -- King's Square Bracers
                { 2, 37116 }, -- Epaulets of Market Row
                { 3, 37115 }, -- Crusader's Square Pauldrons
                { 16, "ac1872" },
            }
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["TheNexus"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4265,
    EncounterJournalID = 281,
	InstanceID = 576,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheNexus",
	AtlasMapFile = {"TheNexus"},
	LevelRange = {66, 71, 73},
	items = {
        { -- TheNexusKolurgStoutbeardHEROIC / 9
            name = AtlasLoot:GetRetByFaction(AL["Commander Kolurg"], AL["Commander Stoutbeard"]),
            npcID = AtlasLoot:GetRetByFaction(26798, 26796),
            EncounterJournalID = 833,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37728 }, -- Cloak of the Enemy
                { 4, 37731 }, -- Opposed Stasis Leggings
                { 5, 37730 }, -- Cleric's Linen Shoes
                { 6, 37729 }, -- Grips of Sculptured Icicles
            }
        },
        { -- TheNexusTelestra / 6
            name = AL["Grand Magus Telestra"],
            npcID = 26731,
            EncounterJournalID = 618,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35605 }, -- Belt of Draconic Runes
                { 2, 35604 }, -- Insulating Bindings
                { 3, 35617 }, -- Wand of Shimmering Scales
                { 16, 21524 }, -- Red Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37139 }, -- Spaulders of the Careless Thief
                { 4, 37138 }, -- Bands of Channeled Energy
                { 5, 37135 }, -- Arcane-Shielded Helm
                { 6, 37134 }, -- Telestra's Journal
                { 16, 21524 }, -- Red Winter Hat
                { 18, "ac2150" },
            }
        },
        { -- TheNexusAnomalus / 7
            name = AL["Anomalus"],
            npcID = 26763,
            EncounterJournalID = 619,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35599 }, -- Gauntlets of Serpent Scales
                { 2, 35600 }, -- Cleated Ice Boots
                { 3, 35598 }, -- Tome of the Lore Keepers
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 2, 37149 }, -- Helm of Anomalus
                { 3, 37144 }, -- Hauberk of the Arcane Wraith
                { 4, 37150 }, -- Rift Striders
                { 5, 37141 }, -- Amulet of Dazzling Light
                { 16, "ac2037" },
            }
        },
        { -- TheNexusOrmorok / 8
            name = AL["Ormorok the Tree-Shaper"],
            npcID = 26794,
            EncounterJournalID = 620,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35602 }, -- Chiseled Stalagmite Pauldrons
                { 2, 35603 }, -- Greaves of the Blue Flight
                { 3, 35601 }, -- Drakonid Arm Blade
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37153 }, -- Gloves of the Crystal Gardener
                { 4, 37155 }, -- Frozen Forest Kilt
                { 5, 37152 }, -- Girdle of Ice
                { 6, 37151 }, -- Band of Frosted Thorns
            }
        },
        { -- TheNexusKeristrasza / 10
            name = AL["Keristrasza"],
            npcID = 26723,
            EncounterJournalID = 621,
            Level = 73,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 35596 }, -- Attuned Crystalline Boots
                { 2, 35595 }, -- Glacier Sharpened Vileblade
                { 3, 35597 }, -- Band of Glittering Permafrost
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37172 }, -- Gloves of Glistening Runes
                { 4, 37170 }, -- Interwoven Scale Bracers
                { 5, 37171 }, -- Flame-Bathed Steel Girdle
                { 6, 37169 }, -- War Mace of Unrequited Love
                { 7, 37165 }, -- Crystal-Infused Tunic
                { 8, 37167 }, -- Dragon Slayer's Sabatons
                { 9, 37166 }, -- Sphere of Red Dragon's Blood
                { 10, 37162 }, -- Bulwark of the Noble Protector
                { 16, 43102 }, -- Frozen Orb
                { 18, 41794 }, -- Design: Deadly Monarch Topaz
                { 20, "ac2036" },
            }
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["TheOculus"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4228,
    EncounterJournalID = 282,
	InstanceID = 578,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheOculus",
	AtlasMapFile = {"TheOculus"},
	LevelRange = {75, 79, 80},
	items = {
        { -- OcuDrakos / 61
            name = AL["Drakos the Interrogator"],
            npcID = 27654,
            EncounterJournalID = 622,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 36945 }, -- Verdisa's Cuffs of Dreaming
                { 2, 36946 }, -- Runic Cage Chestpiece
                { 3, 36943 }, -- Timeless Beads of Eternos
                { 4, 36944 }, -- Lifeblade of Belgaristrasz
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37258 }, -- Drakewing Raiments
                { 4, 37256 }, -- Scaled Armor of Drakos
                { 5, 37257 }, -- Band of Torture
                { 6, 37255 }, -- The Interrogator
            }
        },
        { -- OcuCloudstrider / 63
            name = AL["Varos Cloudstrider"],
            npcID = 27447,
            EncounterJournalID = 623,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 36947 }, -- Centrifuge Core Cloak
                { 2, 36949 }, -- Gloves of the Azure-Lord
                { 3, 36948 }, -- Horned Helm of Varos
                { 4, 36950 }, -- Wing Commander's Breastplate
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37261 }, -- Gloves of Radiant Light
                { 4, 37262 }, -- Azure Ringmail Leggings
                { 5, 37263 }, -- Legplates of the Oculus Guardian
                { 6, 37260 }, -- Cloudstrider's Waraxe
            }
        },
        { -- OcuUrom / 62
            name = AL["Mage-Lord Urom"],
            npcID = 27655,
            EncounterJournalID = 624,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 36954 }, -- The Conjurer's Slippers
                { 2, 36951 }, -- Sidestepping Handguards
                { 3, 36953 }, -- Spaulders of Skillful Maneuvers
                { 4, 36952 }, -- Girdle of Obscuring
                { 16, 21525 }, -- Green Winter Hat
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37289 }, -- Sash of Phantasmal Images
                { 4, 37288 }, -- Catalytic Bands
                { 5, 37195 }, -- Band of Enchanted Growth
                { 6, 37264 }, -- Pendulum of Telluric Currents
                { 16, 21525 }, -- Green Winter Hat
            }
        },
        { -- OcuEregos / 64
            name = AL["Ley-Guardian Eregos"],
            npcID = 27656,
            EncounterJournalID = 625,
            Level = 82,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 36973 }, -- Vestments of the Scholar
                { 2, 36971 }, -- Headguard of Westrift
                { 3, 36969 }, -- Helm of the Ley-Guardian
                { 4, 36974 }, -- Eredormu's Ornamented Chestguard
                { 5, 36961 }, -- Dragonflight Great-Ring
                { 6, 36972 }, -- Tome of Arcane Phenomena
                { 7, 36962 }, -- Wyrmclaw Battleaxe
                { 8, 36975 }, -- Malygos's Favor
                { 16, 41798 }, -- Design: Bracing Earthsiege Diamond
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37361 }, -- Cuffs of Winged Levitation
                { 4, 37363 }, -- Gauntlets of Dragon Wrath
                { 5, 37362 }, -- Leggings of Protective Auras
                { 6, 37360 }, -- Staff of Draconic Combat
                { 7, 37291 }, -- Ancient Dragon Spirit Cape
                { 8, 37294 }, -- Crown of Unbridled Magic
                { 9, 37293 }, -- Mask of the Watcher
                { 10, 37292 }, -- Ley-Guardian's Legguards
                { 16, 43102 }, -- Frozen Orb
                { 18, 52676 }, -- Cache of the Ley-Guardian
				{ 20, "ac1868" },
				{ 22, "ac1871" },
				{ 23, "ac2046" },
				{ 24, "ac2045" },
				{ 25, "ac2044" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 36978 }, -- Ley-Whelphide Belt
                { 2, 36977 }, -- Bindings of the Construct
                { 3, 36976 }, -- Ring-Lord's Leggings
            },
            [HEROIC_DIFF] = {
                { 1, 37366 }, -- Drake-Champion's Bracers
                { 2, 37365 }, -- Bands of the Sky Ring
                { 3, 37290 }, -- Dragon Prow Amulet
                { 4, 37364 }, -- Frostbridge Orb
            }
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["VioletHold"] = {
	MapID = 4415,
	InstanceID = 608,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "VioletHold",
	AtlasMapFile = {"VioletHold"},
	LevelRange = {70, 75, 77},
	items = {
        { -- VioletHoldErekem / 26
            name = AL["Erekem"],
            npcID = 29315,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 43363 }, -- Screeching Cape
                { 2, 43375 }, -- Trousers of the Arakkoa
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43406 }, -- Cloak of the Gushing Wound
                { 4, 43405 }, -- Sabatons of Erekem
                { 5, 43407 }, -- Stormstrike Mace
            }
        },
        { -- VioletHoldZuramat / 27
            name = AL["Zuramat the Obliterator"],
            npcID = 29314,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 43353 }, -- Void Sentry Legplates
                { 2, 43358 }, -- Pendant of Shadow Beams
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43403 }, -- Shroud of Darkness
                { 4, 43402 }, -- The Obliterator Greaves
                { 5, 43404 }, -- Zuramat's Necklace
            }
        },
        { -- VioletHoldXevozz / 28
            name = AL["Xevozz"],
            npcID = 29266,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35644 }, -- Xevozz's Belt
                { 2, 35642 }, -- Riot Shield
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37867 }, -- Footwraps of Teleportation
                { 4, 37868 }, -- Girdle of the Ethereal
                { 5, 37861 }, -- Necklace of Arcane Spheres
            }
        },
        { -- VioletHoldIchoron / 29
            name = AL["Ichoron"],
            npcID = 29313,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 35647 }, -- Handguards of Rapid Pursuit
                { 2, 35643 }, -- Spaulders of Ichoron
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43401 }, -- Water-Drenched Robe
                { 4, 37862 }, -- Gauntlets of the Water Revenant
                { 5, 37869 }, -- Globule Signet
            }
        },
        { -- VioletHoldMoragg / 30
            name = AL["Moragg"],
            npcID = 29316,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 5,
            [NORMAL_DIFF] = {
                { 1, 43387 }, -- Shoulderplates of the Beholder
                { 2, 43382 }, -- Band of Eyes
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 43410 }, -- Moragg's Chestguard
                { 4, 43408 }, -- Solitare of Reflecting Beams
                { 5, 43409 }, -- Saliva Corroded Pike
            }
        },
        { -- VioletHoldLavanthor / 31
            name = AL["Lavanthor"],
            npcID = 29312,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 6,
            [NORMAL_DIFF] = {
                { 1, 35646 }, -- Lava Burn Gloves
                { 2, 35645 }, -- Prison Warden's Shotgun
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37870 }, -- Twin-Headed Boots
                { 4, 37872 }, -- Lavanthor's Talisman
                { 5, 37871 }, -- The Key
            }
        },
        { -- VioletHoldCyanigosa / 32
            name = AL["Cyanigosa"],
            npcID = 31134,
            Level = 75,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 7,
            [NORMAL_DIFF] = {
                { 1, 35650 }, -- Boots of the Portal Guardian
                { 2, 35651 }, -- Plate Claws of the Dragon
                { 3, 35649 }, -- Jailer's Baton
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37884 }, -- Azure Cloth Bindings
                { 4, 37886 }, -- Handgrips of the Savage Emissary
                { 5, 43500 }, -- Bolstered Legplates
                { 6, 37883 }, -- Staff of Trickery
                { 7, 37876 }, -- Cyanigosa's Leggings
                { 8, 37875 }, -- Spaulders of the Violet Hold
                { 9, 37874 }, -- Gauntlets of Capture
                { 10, 37873 }, -- Mark of the War Prisoner
                { 16, 43102 }, -- Frozen Orb
                { 18, 41791 }, -- Design: Thick Autumn's Glow
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35654 }, -- Bindings of the Bastille
                { 2, 35653 }, -- Dungeon Girdle
                { 3, 35652 }, -- Incessant Torch
            },
            [HEROIC_DIFF] = {
                { 1, 35654 }, -- Bindings of the Bastille
                { 2, 37890 }, -- Chain Gang Legguards
                { 3, 37891 }, -- Cast Iron Shackles
                { 4, 35653 }, -- Dungeon Girdle
                { 5, 37889 }, -- Prison Manifest
                { 6, 35652 }, -- Incessant Torch
            },
        },
        KEYS
    }
}

data["UtgardeKeep"] = {
    nameFormat = NAME_UTGARDE,
	MapID = 206,
    EncounterJournalID = 285,
	InstanceID = 574,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UtgardeKeep",
	AtlasMapFile = {"UtgardeKeep"},
	LevelRange = {65, 69, 72},
	items = {
        { -- UtgardeKeepKeleseth / 2
            name = AL["Prince Keleseth"],
            npcID = 23953,
            EncounterJournalID = 638,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 35572 }, -- Reinforced Velvet Helm
                { 2, 35571 }, -- Dragon Stabler's Gauntlets
                { 3, 35570 }, -- Keleseth's Blade of Evocation
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37180 }, -- Battlemap Hide Helm
                { 4, 37178 }, -- Strategist's Belt
                { 5, 37179 }, -- Infantry Assault Blade
                { 6, 37177 }, -- Wand of the San'layn
                { 16, "ac1919" },
            }
        },
        { -- UtgardeKeepSkarvald / 3
            name = AL["Skarvald the Constructor & Dalronn the Controller"],
            npcID = {24200, 24201},
            EncounterJournalID = 639,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 35575 }, -- Skarvald's Dragonskin Habergeon
                { 2, 35574 }, -- Chestplate of the Northern Lights
                { 3, 35573 }, -- Arm Blade of Augelmir
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37183 }, -- Bindings of the Tunneler
                { 4, 37184 }, -- Dalronn's Jerkin
                { 5, 37182 }, -- Helmet of the Constructor
                { 6, 37181 }, -- Dagger of Betrayal
            }
        },
        { -- UtgardeKeepIngvar / 4
            name = AL["Ingvar the Plunderer"],
            npcID = 23954,
            EncounterJournalID = 640,
            Level = 72,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 35577 }, -- Holistic Patchwork Breeches
                { 2, 35578 }, -- Overlaid Chain Spaulders
                { 3, 35576 }, -- Ingvar's Monolithic Cleaver
                { 16, 33330 }, -- Ingvar's Head
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37194 }, -- Sharp-Barbed Leather Belt
                { 4, 37193 }, -- Staggering Legplates
                { 5, 37192 }, -- Annhylde's Ring
                { 6, 37191 }, -- Drake-Mounted Crossbow
                { 7, 37189 }, -- Breeches of the Caller
                { 8, 37188 }, -- Plunderer's Helmet
                { 9, 37186 }, -- Unsmashable Heavy Band
                { 10, 37190 }, -- Enraged Feral Staff
                { 16, 43102 }, -- Frozen Orb
                { 18, 41793 }, -- Design: Fierce Monarch Topaz
                { 20, "ac1658" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 35580 }, -- Skein Woven Mantle
		        { 2, 35579 }, -- Vrykul Shackles
            },
            [HEROIC_DIFF] = {
                { 1, 37197 }, -- Tattered Castle Drape
		        { 2, 37196 }, -- Runecaster's Mantle
            },
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["UtgardePinnacle"] = {
    nameFormat = NAME_UTGARDE,
	MapID = 1196,
    EncounterJournalID = 286,
	InstanceID = 575,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UtgardePinnacle",
	AtlasMapFile = {"UtgardePinnacle"},
	LevelRange = {75, 79, 80},
	items = {
        { -- UPSorrowgrave / 58
            name = AL["Svala Sorrowgrave"],
            npcID = 26668,
            EncounterJournalID = 641,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 37043 }, -- Tear-Linked Gauntlets
                { 2, 37040 }, -- Svala's Bloodied Shackles
                { 3, 37037 }, -- Ritualistic Athame
                { 4, 37038 }, -- Brazier Igniter
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37370 }, -- Cuffs of the Trussed Hall
                { 4, 37369 }, -- Sorrowgrave's Breeches
                { 5, 37368 }, -- Silent Spectator Shoulderpads
                { 6, 37367 }, -- Echoing Stompers
                { 16, "ac2043" },
            }
        },
        { -- UPPalehoof / 59
            name = AL["Gortok Palehoof"],
            npcID = 26687,
            EncounterJournalID = 642,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 37048 }, -- Shroud of Resurrection
                { 2, 37052 }, -- Reanimated Armor
                { 3, 37051 }, -- Seal of Valgarde
                { 4, 37050 }, -- Trophy Gatherer
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37374 }, -- Ravenous Leggings of the Furbolg
                { 4, 37373 }, -- Massive Spaulders of the Jormungar
                { 5, 37376 }, -- Ferocious Pauldrons of the Rhino
                { 6, 37371 }, -- Ring of the Frenzied Wolvar
            }
        },
        { -- UPSkadi / 56
            name = AL["Skadi the Ruthless"],
            npcID = 26693,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 37055 }, -- Silken Amice of the Ymirjar
                { 2, 37057 }, -- Drake Rider's Tunic
                { 3, 37056 }, -- Harpooner's Striders
                { 4, 37053 }, -- Amulet of Deflected Blows
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37389 }, -- Crenelation Leggings
                { 4, 37379 }, -- Skadi's Iron Belt
                { 5, 37377 }, -- Netherbreath Spellblade
                { 6, 37384 }, -- Staff of Wayward Principles
                { 16, 44151 }, -- Reins of the Blue Proto-Drake
                { 18, "ac1873" },
                { 19, "ac2156" },
            }
        },
        { -- UPYmiron / 57
            name = AL["King Ymiron"],
            npcID = 26861,
            EncounterJournalID = 644,
            Level = 77,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 37067 }, -- Ceremonial Pyre Mantle
                { 2, 37062 }, -- Crown of Forgotten Kings
                { 3, 37066 }, -- Ancient Royal Legguards
                { 4, 37058 }, -- Signet of Ranulf
                { 5, 37064 }, -- Vestige of Haldor
                { 6, 37060 }, -- Jeweled Coronation Sword
                { 7, 37065 }, -- Ymiron's Blade
                { 8, 37061 }, -- Tor's Crest
                { 16, 41797 }, -- Design: Austere Earthsiege Diamond
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 37408 }, -- Girdle of Bane
                { 4, 37409 }, -- Gilt-Edged Leather Gauntlets
                { 5, 37407 }, -- Sovereign's Belt
                { 6, 37401 }, -- Red Sword of Courage
                { 7, 37398 }, -- Mantle of Discarded Ways
                { 8, 37395 }, -- Ornamented Plate Regalia
                { 9, 37397 }, -- Gold Amulet of Kings
                { 10, 37390 }, -- Meteorite Whetstone
                { 16, 43102 }, -- Frozen Orb
                { 18, 41797 }, -- Design: Austere Earthsiege Diamond
                { 20, "ac1790" },
				{ 21, "ac2157" },
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 37070 }, -- Tundra Wolf Boots
                { 2, 37069 }, -- Dragonflayer Seer's Bindings
                { 3, 37068 }, -- Berserker's Sabatons
            },
            [HEROIC_DIFF] = {
                { 1, 37587 }, -- Ymirjar Physician's Robe
                { 2, 37590 }, -- Bands of Fading Light
                { 3, 37410 }, -- Tracker's Balanced Knives
            },
        },
        KEYS,
		WOTLK_DUNGEONMASTER_AC_TABLE,
		WOTLK_DUNGEON_HERO_AC_TABLE,
		WOTLK_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["TrialoftheChampion"] = {
    nameFormat = NAME_AT,
	MapID = 4723,
    EncounterJournalID = 284,
	InstanceID = 650,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TrialOfTheChampion",
	AtlasMapFile = {"TrialOfTheChampion"},
	LevelRange = {75, 79, 80},
	items = {
        { -- TrialoftheChampionChampions / 213
            name = AL["Grand Champions"],
            npcID = {34705,34702,34701,34657,34703, 35572,35569,35571,35570,35617},
            EncounterJournalID = 834,
            ObjectID = 195709,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 47173 }, -- Bindings of the Wicked
                { 2, 47170 }, -- Belt of Fierce Competition
                { 3, 47174 }, -- Binding of the Tranquil Glade
                { 4, 47175 }, -- Scale Boots of the Outlander
                { 5, 47172 }, -- Helm of the Bested Gallant
                { 6, 47171 }, -- Legguards of Abandoned Fealty
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47249 }, -- Leggings of the Snowy Bramble
                { 4, 47248 }, -- Treads of Dismal Fortune
                { 5, 47250 }, -- Pauldrons of the Deafening Gale
                { 6, 47244 }, -- Chestguard of the Ravenous Fiend
                { 7, 47243 }, -- Mark of the Relentless
                { 8, 47493 }, -- Edge of Ruin
                { 16, 44990 }, -- Champion's Seal
            }
        },
        { -- TrialoftheChampionEadricthePure / 215
            name = AL["Eadric the Pure"],
            npcID = 35119,
            EncounterJournalID = 635,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 47181 }, -- Belt of the Churning Blaze
                { 2, 47185 }, -- Leggings of the Haggard Apprentice
                { 3, 47210 }, -- Mantle of Gnarled Overgrowth
                { 4, 47177 }, -- Gloves of the Argent Fanatic
                { 5, 47202 }, -- Leggings of Brazen Trespass
                { 6, 47178 }, -- Carapace of Grim Visions
                { 7, 47176 }, -- Breastplate of the Imperial Joust
                { 8, 47197 }, -- Gauntlets of the Stouthearted Crusader
                { 9, 47201 }, -- Boots of Heartfelt Repentance
                { 10, 47199 }, -- Greaves of the Grand Paladin
                { 11, 47200 }, -- Signet of Purity
                { 12, 47213 }, -- Abyssal Rune
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47501 }, -- Kurisu's Indecision
                { 4, 47496 }, -- Armbands of the Wary Lookout
                { 5, 47498 }, -- Gloves of Dismal Fortune
                { 6, 47504 }, -- Barkhide Treads
                { 7, 47497 }, -- Helm of the Crestfallen Challenger
                { 8, 47502 }, -- Majestic Silversmith Shoulderplates
                { 9, 47495 }, -- Legplates of Relentless Onslaught
                { 10, 47503 }, -- Legplates of the Argent Armistice
                { 11, 47494 }, -- Ancient Pendant of Arathor
                { 12, 47500 }, -- Peacekeeper Blade
                { 13, 47509 }, -- Mariel's Sorrow
                { 14, 47508 }, -- Aledar's Battlestar
                { 16, 44990 }, -- Champion's Seal
                { 18, "ac3803" },
            }
        },
        { -- TrialoftheChampionConfessorPaletress / 214
            name = AL["Argent Confessor Paletress"],
            npcID = 34928,
            EncounterJournalID = 636,
            Level = 80,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 47181 }, -- Belt of the Churning Blaze
                { 2, 47218 }, -- The Confessor's Binding
                { 3, 47185 }, -- Leggings of the Haggard Apprentice
                { 4, 47217 }, -- Gaze of the Somber Keeper
                { 5, 47177 }, -- Gloves of the Argent Fanatic
                { 6, 47178 }, -- Carapace of Grim Visions
                { 7, 47211 }, -- Wristguards of Ceaseless Regret
                { 8, 47176 }, -- Breastplate of the Imperial Joust
                { 9, 47212 }, -- Mercy's Hold
                { 10, 47219 }, -- Brilliant Hailstone Amulet
                { 11, 47213 }, -- Abyssal Rune
                { 12, 47214 }, -- Banner of Victory
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47498 }, -- Gloves of Dismal Fortune
                { 4, 47496 }, -- Armbands of the Wary Lookout
                { 5, 47245 }, -- Pauldrons of Concealed Loathing
                { 6, 47497 }, -- Helm of the Crestfallen Challenger
                { 7, 47514 }, -- Regal Aurous Shoulderplates
                { 8, 47510 }, -- Trueheart Girdle
                { 9, 47495 }, -- Legplates of Relentless Onslaught
                { 10, 47511 }, -- Plated Greaves of Providence
                { 11, 47494 }, -- Ancient Pendant of Arathor
                { 12, 47512 }, -- Sinner's Confession
                { 13, 47500 }, -- Peacekeeper Blade
                { 14, 47522 }, -- Marrowstrike
                { 16, 44990 }, -- Champion's Seal
                { 18, "ac3802" },
            }
        },

        { -- TrialoftheChampionBlackKnight / 216
            name = AL["The Black Knight"],
            npcID = 35451,
            EncounterJournalID = 637,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 4,
            [NORMAL_DIFF] = {
                { 1, 47232 }, -- Drape of the Undefeated
                { 2, 47226 }, -- Mantle of Inconsolable Fear
                { 3, 47230 }, -- Handwraps of Surrendered Hope
                { 4, 47221 }, -- Shoulderpads of the Infamous Knave
                { 5, 47231 }, -- Belt of Merciless Cruelty
                { 6, 47228 }, -- Leggings of the Bloodless Knight
                { 7, 47220 }, -- Helm of the Violent Fray
                { 8, 47229 }, -- Girdle of Arrogant Downfall
                { 9, 47227 }, -- Girdle of the Pallid Knight
                { 10, 47222 }, -- Uruka's Band of Zeal
                { 11, 47215 }, -- Tears of the Vanquished
                { 12, 47216 }, -- The Black Heart
            },
            [HEROIC_DIFF] = {
                { 1, 47241 }, -- Emblem of Triumph
                { 3, 47564 }, -- Gaze of the Unknown
                { 4, 47527 }, -- Embrace of Madness
                { 5, 47560 }, -- Boots of the Crackling Flame
                { 6, 47529 }, -- Mask of Distant Memory
                { 7, 47561 }, -- Gloves of the Dark Exile
                { 8, 47563 }, -- Girdle of the Dauntless Conqueror
                { 9, 47565 }, -- Vambraces of Unholy Command
                { 10, 47567 }, -- Gauntlets of Revelation
                { 11, 47562 }, -- Symbol of Redemption
                { 12, 47566 }, -- The Warlord's Depravity
                { 13, 47569 }, -- Spectral Kris
                { 14, 49682 }, -- Black Knight's Rondel
                { 15, 47568 }, -- True-aim Long Rifle
                { 16, 43102 }, -- Frozen Orb
                { 18, 44990 }, -- Champion's Seal
                { 20, "ac3804" },
            }
        },
        KEYS
    }
}

local ICC_DUNGEONS_TRASH = { -- Trash
    name = AL["Trash"],
    ExtraList = true,
    [NORMAL_DIFF] = {
        { 1, 49854 }, -- Mantle of Tattered Feathers
		{ 2, 49855 }, -- Plated Grips of Korth'azz
		{ 3, 49853 }, -- Titanium Links of Lore
		{ 4, 49852 }, -- Coffin Nail
    },
    [HEROIC_DIFF] = {
        { 1, 50318 }, -- Ghostly Wristwraps
		{ 2, 50315 }, -- Seven-Fingered Claws
		{ 3, 50319 }, -- Unsharpened Ice Razor
        { 4, 50051 }, -- Hammer of Purified Flame
		{ 5, 50050 }, -- Cudgel of Furious Justice
		{ 6, 50052 }, -- Lightborn Spire
        { 16, AtlasLoot:GetRetByFaction(50380, 50379) }, -- Battered Hilt
    },
}

data["ForgeOfSouls"] = {
    nameFormat = NAME_ICC,
	MapID = 4809,
    EncounterJournalID = 280,
	InstanceID = 632,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "FHTheForgeOfSouls",
	AtlasMapFile = {"FHTheForgeOfSouls", "IcecrownEnt"},
	LevelRange = {75, 79, 80},
	items = {
        { -- FoSBronjahm / 268
            name = AL["Bronjahm"],
            npcID = 36497,
            EncounterJournalID = 615,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49788 }, -- Cold Sweat Grips
                { 2, 49785 }, -- Bewildering Shoulderpads
                { 3, 49786 }, -- Robes of the Cheating Heart
                { 4, 49787 }, -- Seven Stormy Mornings
                { 5, 49784 }, -- Minister's Number One Legplates
                { 6, 49783 }, -- Lucky Old Sun
                { 16, 50317 }, -- Papa's New Bag
                { 17, 50316 }, -- Papa's Brand New Bag
            },
            [HEROIC_DIFF] = {
                { 1, 50193 }, -- Very Fashionable Shoulders
                { 2, 50197 }, -- Eyes of Bewilderment
                { 3, 50194 }, -- Weeping Gauntlets
                { 4, 50196 }, -- Love's Prisoner
                { 5, 50191 }, -- Nighttime
                { 6, 50169 }, -- Papa's Brand New Knife
                { 16, 50317 }, -- Papa's New Bag
                { 17, 50316 }, -- Papa's Brand New Bag
                { 19, "ac4522" },
            }
        },
        { -- FoSDevourer / 269
            name = AL["Devourer of Souls"],
            npcID = 36502,
            EncounterJournalID = 616,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49792 }, -- Accursed Crawling Cape
                { 2, 49796 }, -- Essence of Anger
                { 3, 49798 }, -- Soul Screaming Boots
                { 4, 49791 }, -- Lost Reliquary Chestguard
                { 5, 49797 }, -- Brace Guards of the Starless Night
                { 6, 49794 }, -- Legplates of Frozen Granite
                { 7, 49795 }, -- Sollerets of Suffering
                { 8, 49799 }, -- Coil of Missing Gems
                { 9, 49800 }, -- Spiteful Signet
                { 10, 49789 }, -- Heartshiver
                { 11, 49790 }, -- Blood Boil Lancet
                { 12, 49793 }, -- Tower of the Mouldering Corpse
            },
            [HEROIC_DIFF] = {
                { 1, 50213 }, -- Mord'rethar Robes
                { 2, 50206 }, -- Frayed Scoundrel's Cap
                { 3, 50212 }, -- Essence of Desire
                { 4, 50214 }, -- Helm of the Spirit Shock
                { 5, 50209 }, -- Essence of Suffering
                { 6, 50208 }, -- Pauldrons of the Devourer
                { 7, 50207 }, -- Black Spire Sabatons
                { 8, 50215 }, -- Recovered Reliquary Boots
                { 9, 50211 }, -- Arcane Loops of Anger
                { 10, 50198 }, -- Needle-Encrusted Scorpion
                { 11, 50203 }, -- Blood Weeper
                { 12, 50210 }, -- Seethe
                { 16, 43102 }, -- Frozen Orb
                { 18, "ac4523" },
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

data["PitOfSaron"] = {
    nameFormat = NAME_ICC,
	MapID = 4813,
    EncounterJournalID = 278,
	InstanceID = 658,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "FHPitOfSaron",
	AtlasMapFile = {"FHPitOfSaron", "IcecrownEnt"},
	LevelRange = {75, 79, 80},
	items = {
        { -- PoSGarfrost / 271
            name = AL["Forgemaster Garfrost"],
            npcID = 36494,
            EncounterJournalID = 608,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49805 }, -- Ice-Steeped Sandals
                { 2, 49806 }, -- Flayer's Black Belt
                { 3, 49804 }, -- Polished Mirror Helm
                { 4, 49803 }, -- Ring of Carnelian and Bone
                { 5, 49802 }, -- Garfrost's Two-Ton Hammer
                { 6, 49801 }, -- Unspeakable Secret
            },
            [HEROIC_DIFF] = {
                { 1, 50233 }, -- Spurned Val'kyr Shoulderguards
                { 2, 50234 }, -- Shoulderplates of Frozen Blood
                { 3, 50230 }, -- Malykriss Vambraces
                { 4, 50229 }, -- Legguards of the Frosty Depths
                { 5, 50228 }, -- Barbed Ymirheim Choker
                { 6, 50227 }, -- Surgeon's Needle
                { 16, "ac4524" },
            }
        },
        { -- PoSKrickIck / 272
            name = AL["Ick & Krick"],
            npcID = {36476,36477},
            EncounterJournalID = 609,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49809 }, -- Wristguards of Subterranean Moss
                { 2, 49810 }, -- Scabrous Zombie Leather Belt
                { 3, 49811 }, -- Black Dragonskin Breeches
                { 4, 49808 }, -- Bent Gold Belt
                { 5, 49812 }, -- Purloined Wedding Ring
                { 6, 49807 }, -- Krick's Beetle Stabber
            },
            [HEROIC_DIFF] = {
                { 1, 50266 }, -- Ancient Polar Bear Hide
                { 2, 50263 }, -- Braid of Salt and Fire
                { 3, 50264 }, -- Chewed Leather Wristguards
                { 4, 50265 }, -- Blackened Ghoul Skin Leggings
                { 5, 50235 }, -- Ick's Rotting Thumb
                { 6, 50262 }, -- Felglacier Bolter
            }
        },
        { -- PoSTyrannus / 273
            name = AL["Scourgelord Tyrannus"],
            npcID = 36658,
            EncounterJournalID = 610,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 49823 }, -- Cloak of the Fallen Cardinal
                { 2, 49825 }, -- Palebone Robes
                { 3, 49822 }, -- Rimewoven Silks
                { 4, 49817 }, -- Shaggy Wyrmleather Leggings
                { 5, 49824 }, -- Horns of the Spurned Val'kyr
                { 6, 49826 }, -- Shroud of Rime
                { 7, 49820 }, -- Gondria's Spectral Bracer
                { 8, 49819 }, -- Skeleton Lord's Cranium
                { 9, 49816 }, -- Scourgelord's Frigid Chestplate
                { 10, 49818 }, -- Painfully Sharp Choker
                { 11, 49821 }, -- Protector of Frigid Souls
                { 12, 49813 }, -- Rimebane Rifle
            },
            [HEROIC_DIFF] = {
                { 1, 50286 }, -- Prelate's Snowshoes
                { 2, 50269 }, -- Fleshwerk Leggings
                { 3, 50270 }, -- Belt of Rotted Fingernails
                { 4, 50283 }, -- Mudslide Boots
                { 5, 50272 }, -- Frost Wyrm Ribcage
                { 6, 50285 }, -- Icebound Bronze Cuirass
                { 7, 50284 }, -- Rusty Frozen Fingerguards
                { 8, 50271 }, -- Band of Stained Souls
                { 9, 50259 }, -- Nevermelting Ice Crystal
                { 10, 50268 }, -- Rimefang's Claw
                { 11, 50267 }, -- Tyrannical Beheader
                { 12, 50273 }, -- Engraved Gargoyle Femur
                { 16, 43102 },	-- Frozen Orb
				{ 18, "ac4525" },
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

data["HallsOfReflection"] = {
    nameFormat = NAME_ICC,
	MapID = 4820,
    EncounterJournalID = 276,
	InstanceID = 668,
    ContentType = DUNGEON_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "FHHallsOfReflection",
	AtlasMapFile = {"FHHallsOfReflection", "IcecrownEnt"},
	LevelRange = {75, 79, 80},
	items = {
        { -- HoRFalric / 275
            name = AL["Falric"],
            npcID = 38112,
            EncounterJournalID = 601,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 1,
            [NORMAL_DIFF] = {
                { 1, 49832 }, -- Eerie Runeblade Polisher
                { 2, 49828 }, -- Marwyn's Macabre Fingertips
                { 3, 49830 }, -- Fallen Sentry's Hood
                { 4, 49831 }, -- Muddied Boots of Brill
                { 5, 49829 }, -- Valonforth's Tarnished Pauldrons
                { 6, 49827 }, -- Ghoulslicer
            },
            [HEROIC_DIFF] = {
                { 1, 50292 }, -- Bracer of Worn Molars
                { 2, 50293 }, -- Spaulders of Black Betrayal
                { 3, 50295 }, -- Spiked Toestompers
                { 4, 50294 }, -- Chestpiece of High Treason
                { 5, 50290 }, -- Falric's Wrist-Chopper
                { 6, 50291 }, -- Soulsplinter
            }
        },
        { -- HoRMarwyn / 276
            name = AL["Marwyn"],
            npcID = 38113,
            EncounterJournalID = 602,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 2,
            [NORMAL_DIFF] = {
                { 1, 49834 }, -- Frayed Abomination Stitching Shoulders
                { 2, 49838 }, -- Carpal Tunnelers
                { 3, 49837 }, -- Mitts of Burning Hail
                { 4, 49836 }, -- Frostsworn Bone Leggings
                { 5, 49833 }, -- Splintered Icecrown Parapet
                { 6, 49835 }, -- Splintered Door of the Citadel
            },
            [HEROIC_DIFF] = {
                { 1, 50298 }, -- Sightless Crown of Ulmaas
                { 2, 50299 }, -- Suspiciously Soft Gloves
                { 3, 50300 }, -- Choking Hauberk
                { 4, 50297 }, -- Frostsworn Bone Chestpiece
                { 5, 50260 }, -- Ephemeral Snowflake
                { 6, 50296 }, -- Orca-Hunter's Harpoon
            }
        },
        { -- HoRLichKing / 277
            name = AL["Wrath of the Lich King"],
            npcID = 36954,
            EncounterJournalID = 603,
            Level = 80,
            -- DisplayIDs = {{0}},
            AtlasMapBossID = 3,
            [NORMAL_DIFF] = {
                { 1, 49842 }, -- Tapestry of the Frozen Throne
                { 2, 49849 }, -- Tattered Glacial-Woven Hood
                { 3, 49848 }, -- Grim Lasher Shoulderguards
                { 4, 49841 }, -- Blackened Geist Ribs
                { 5, 49847 }, -- Legguards of Untimely Demise
                { 6, 49851 }, -- Greathelm of the Silver Hand
                { 7, 49843 }, -- Crystalline Citadel Gauntlets
                { 8, 49846 }, -- Chilled Heart of the Glacier
                { 9, 49839 }, -- Mourning Malice
                { 10, 49840 }, -- Hate-Forged Cleaver
                { 11, 49845 }, -- Bone Golem Scapula
                { 12, 49844 }, -- Crypt Fiend Slayer
            },
            [HEROIC_DIFF] = {
                { 1, 50314 }, -- Strip of Remorse
                { 2, 50312 }, -- Chestguard of Broken Branches
                { 3, 50308 }, -- Blighted Leather Footpads
                { 4, 50304 }, -- Hoarfrost Gauntlets
                { 5, 50311 }, -- Second Helm of the Executioner
                { 6, 50305 }, -- Grinning Skull Boots
                { 7, 50310 }, -- Fossilized Ammonite Choker
                { 8, 50313 }, -- Oath of Empress Zoe
                { 9, 50306 }, -- The Lady's Promise
                { 10, 50309 }, -- Shriveled Heart
                { 11, 50302 }, -- Liar's Tongue
                { 12, 50303 }, -- Black Icicle
                { 16, 43102 },-- Frozen Orb
				{ 18, "ac4526" },
            }
        },
        ICC_DUNGEONS_TRASH,
        KEYS
    }
}

-- ## RAIDS

data["NaxxramasWrath"] = {
	MapID = 3456,
	InstanceID = AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM,533,nil),
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Naxxramas",
	AtlasMapFile = "Naxxramas",
	ContentType = RAID_CONTENT,
    -- LevelRange = {80, 80, 80},
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
            EncounterJournalID = 1601,
			Level = 999,
			DisplayIDs = {{15931}},
			AtlasMapBossID = "1",
            NameColor = BLUE,
			[RAID10_DIFF] = {
                { 1, 39192 }, -- Gloves of Dark Gestures
                { 2, 39190 }, -- Agonal Sash
                { 3, 39191 }, -- Splint-Bound Leggings
                { 4, 39189 }, -- Boots of Persistence
                { 5, 39188 }, -- Chivalric Chestguard
                { 6, 39139 }, -- Ravaging Sabatons
                { 7, 39146 }, -- Collar of Dissolution
                { 8, 39193 }, -- Band of Neglected Pleas
                { 9, 39141 }, -- Deflection Band
                { 10, 39140 }, -- Knife of Incision
            },
            [RAID25_DIFF] = {
                { 1, 39719 }, -- Mantle of the Locusts
                { 2, 39721 }, -- Sash of the Parlor
                { 3, 39720 }, -- Leggings of Atrophy
                { 4, 39722 }, -- Swarm Bindings
                { 5, 39701 }, -- Dawnwalkers
                { 6, 39702 }, -- Arachnoid Gold Band
                { 7, 39718 }, -- Corpse Scarab Handguards
                { 8, 39704 }, -- Pauldrons of Unnatural Death
                { 9, 39703 }, -- Rescinding Grips
                { 10, 39717 }, -- Inexorable Sabatons
                { 11, 39706 }, -- Sabatons of Sudden Reprisal
                { 12, 40071 }, -- Chains of Adoration
                { 13, 40065 }, -- Fool's Trial
                { 14, 40069 }, -- Heritage
                { 15, 40064 }, -- Thunderstorm Amulet
                { 16, 40080 }, -- Lost Jewel
                { 17, 40075 }, -- Ruthlessness
                { 18, 40107 }, -- Sand-Worn Band
                { 19, 40074 }, -- Strong-Handed Ring
                { 20, 39714 }, -- Webbed Death
                { 21, 40208 }, -- Cryptfiend's Bite
                { 22, 39716 }, -- Shield of Assimilation
                { 23, 39712 }, -- Gemmed Wand of the Nerubians
            },
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
            EncounterJournalID = 1602,
			Level = 999,
			DisplayIDs = {{15940}},
			AtlasMapBossID = "2",
            NameColor = BLUE,
			[RAID10_DIFF] = {
                { 1, 39216 }, -- Sash of Mortal Desire
                { 2, 39215 }, -- Boots of the Follower
                { 3, 39196 }, -- Boots of the Worshiper
                { 4, 39217 }, -- Avenging Combat Leggings
                { 5, 39194 }, -- Rusted-Link Spiked Gauntlets
                { 6, 39198 }, -- Frostblight Pauldrons
                { 7, 39195 }, -- Bracers of Lost Sentiments
                { 8, 39197 }, -- Gauntlets of the Master
                { 9, 39199 }, -- Watchful Eye
                { 10, 39200 }, -- Grieving Spellblade
                { 16, "ac1997" },
            },
            [RAID25_DIFF] = {
                { 1, 39732 }, -- Faerlina's Madness
                { 2, 39731 }, -- Punctilious Bindings
                { 3, 39733 }, -- Gloves of Token Respect
                { 4, 39735 }, -- Belt of False Dignity
                { 5, 39756 }, -- Tunic of Prejudice
                { 6, 39727 }, -- Dislocating Handguards
                { 7, 39724 }, -- Cult's Chestguard
                { 8, 39734 }, -- Atonement Greaves
                { 9, 39723 }, -- Fire-Scorched Greathelm
                { 10, 39725 }, -- Epaulets of the Grieving Servant
                { 11, 39729 }, -- Bracers of the Tyrant
                { 12, 39726 }, -- Callous-Hearted Gauntlets
                { 13, 40071 }, -- Chains of Adoration
                { 14, 40065 }, -- Fool's Trial
                { 15, 40069 }, -- Heritage
                { 16, 40064 }, -- Thunderstorm Amulet
                { 17, 40080 }, -- Lost Jewel
                { 18, 40075 }, -- Ruthlessness
                { 19, 40107 }, -- Sand-Worn Band
                { 20, 40108 }, -- Seized Beauty
                { 21, 40074 }, -- Strong-Handed Ring
                { 22, 39757 }, -- Idol of Worship
                { 23, 39728 }, -- Totem of Misery
                { 24, 39730 }, -- Widow's Fury
                { 26, "ac2140" },
            },
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
            EncounterJournalID = 1603,
			Level = 999,
			DisplayIDs = {{15928}},
			AtlasMapBossID = "3",
            NameColor = BLUE,
			[RAID10_DIFF] = {
                { 1, 39225 }, -- Cloak of Armed Strife
                { 2, 39230 }, -- Spaulders of the Monstrosity
                { 3, 39224 }, -- Leggings of Discord
                { 4, 39228 }, -- Web Cocoon Grips
                { 5, 39232 }, -- Pendant of Lost Vocations
                { 6, 39231 }, -- Timeworn Silken Band
                { 7, 39229 }, -- Embrace of the Spider
                { 8, 39226 }, -- Maexxna's Femur
                { 9, 39221 }, -- Wraith Spear
                { 10, 39233 }, -- Aegis of Damnation
                { 16, "ac1858" },
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40062 }, -- Digested Silken Robes
                { 7, 40060 }, -- Distorted Limbs
                { 8, 39768 }, -- Cowl of the Perished
                { 9, 40063 }, -- Mantle of Shattered Kinship
                { 10, 39765 }, -- Sinner's Bindings
                { 11, 39761 }, -- Infectious Skitterer Leggings
                { 12, 40061 }, -- Quivering Tunic
                { 13, 39762 }, -- Torn Web Wrapping
                { 14, 39760 }, -- Helm of Diminished Pride
                { 15, 39767 }, -- Undiminished Battleplate
                { 16, 39764 }, -- Bindings of the Hapless Prey
                { 17, 39759 }, -- Ablative Chitin Girdle
                { 18, 40257 }, -- Defender's Code
                { 19, 40255 }, -- Dying Curse
                { 20, 40258 }, -- Forethought Talisman
                { 21, 40256 }, -- Grim Toll
                { 22, 39766 }, -- Matriarch's Spawn
                { 23, 39763 }, -- Wraith Strike
                { 24, 39758 }, -- The Jawbone
                { 26, "ac1859" },
            },
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
            EncounterJournalID = 1604,
			Level = 999,
			DisplayIDs = {{16590}},
			AtlasMapBossID = "1",
            NameColor = PURPLE,
			[RAID10_DIFF] = {
                { 1, 39241 }, -- Dark Shroud of the Scourge
                { 2, 39242 }, -- Robes of Hoarse Breaths
                { 3, 39240 }, -- Noth's Curse
                { 4, 39237 }, -- Spaulders of Resumed Battle
                { 5, 39243 }, -- Handgrips of the Foredoomed
                { 6, 39236 }, -- Trespasser's Boots
                { 7, 39239 }, -- Chestplate of the Risen Soldier
                { 8, 39235 }, -- Bone-Framed Bracers
                { 9, 39234 }, -- Plague-Impervious Boots
                { 10, 39244 }, -- Ring of the Fated
            },
            [RAID25_DIFF] = {
                { 1, 40602 }, -- Robes of Mutation
                { 2, 40198 }, -- Bands of Impurity
                { 3, 40197 }, -- Gloves of the Fallen Wizard
                { 4, 40186 }, -- Thrusting Bands
                { 5, 40200 }, -- Belt of Potent Chanting
                { 6, 40193 }, -- Tunic of Masked Suffering
                { 7, 40196 }, -- Legguards of the Undisturbed
                { 8, 40184 }, -- Crippled Treads
                { 9, 40185 }, -- Shoulderguards of Opportunity
                { 10, 40188 }, -- Gauntlets of the Disobediant
                { 11, 40187 }, -- Poignant Sabatons
                { 12, 40071 }, -- Chains of Adoration
                { 13, 40065 }, -- Fool's Trial
                { 14, 40069 }, -- Heritage
                { 15, 40064 }, -- Thunderstorm Amulet
                { 16, 40080 }, -- Lost Jewel
                { 17, 40075 }, -- Ruthlessness
                { 18, 40107 }, -- Sand-Worn Band
                { 19, 40074 }, -- Strong-Handed Ring
                { 20, 40192 }, -- Accursed Spine
                { 21, 40191 }, -- Libram of Radiance
                { 22, 40189 }, -- Angry Dread
                { 23, 40190 }, -- Spinning Fate
            },
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
            EncounterJournalID = 1605,
			Level = 999,
			DisplayIDs = {{16309}},
			AtlasMapBossID = "2",
            NameColor = PURPLE,
			[RAID10_DIFF] = {
                { 1, 39252 }, -- Preceptor's Bindings
                { 2, 39254 }, -- Saltarello Shoes
                { 3, 39247 }, -- Cuffs of Dark Shadows
                { 4, 39248 }, -- Tunic of the Lost Pack
                { 5, 39251 }, -- Necrogenic Belt
                { 6, 39249 }, -- Shoulderplates of Bloodshed
                { 7, 39246 }, -- Amulet of Autopsy
                { 8, 39250 }, -- Ring of Holy Cleansing
                { 9, 39245 }, -- Demise
                { 10, 39255 }, -- Staff of the Plague Beast
                { 16, "ac1996" },
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40234 }, -- Heigan's Putrid Vestments
                { 7, 40236 }, -- Serene Echoes
                { 8, 40238 }, -- Gloves of the Dancing Bear
                { 9, 40205 }, -- Stalk-Skin Belt
                { 10, 40235 }, -- Helm of Pilgrimage
                { 11, 40209 }, -- Bindings of the Decrepit
                { 12, 40201 }, -- Leggings of Colossal Strides
                { 13, 40237 }, -- Eruption-Scared Boots
                { 14, 40203 }, -- Breastplate of Tormented Rage
                { 15, 40210 }, -- Chestguard of Bitter Charms
                { 16, 40204 }, -- Legguards of the Apostle
                { 17, 40206 }, -- Iron-Spring Jumpers
                { 18, 40257 }, -- Defender's Code
                { 19, 40255 }, -- Dying Curse
                { 20, 40258 }, -- Forethought Talisman
                { 21, 40256 }, -- Grim Toll
                { 22, 40207 }, -- Sigil of Awareness
                { 23, 40208 }, -- Cryptfiend's Bite
                { 24, 40233 }, -- The Undeath Carrier
                { 26, "ac2139" },
            },
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
            EncounterJournalID = 1606,
			Level = 999,
			DisplayIDs = {{16110}},
			AtlasMapBossID = "3",
            NameColor = PURPLE,
			[RAID10_DIFF] = {
                { 1, 39259 }, -- Fungi-Stained Coverings
                { 2, 39260 }, -- Helm of the Corrupted Mind
                { 3, 39258 }, -- Legplates of Inescapable Death
                { 4, 39257 }, -- Loatheb's Shadow
                { 5, 39256 }, -- Sulfur Stave
                { 16, 40622 }, -- Spaulders of the Lost Conqueror
                { 17, 40623 }, -- Spaulders of the Lost Protector
                { 18, 40624 }, -- Spaulders of the Lost Vanquisher
                { 20, "ac2182" },
            },
            [RAID25_DIFF] = {
                { 1, 40247 }, -- Cowl of Innocent Delight
                { 2, 40246 }, -- Boots of Impetuous Ideals
                { 3, 40249 }, -- Vest of Vitality
                { 4, 40243 }, -- Footwraps of Vile Deceit
                { 5, 40242 }, -- Grotesque Handgrips
                { 6, 40241 }, -- Girdle of Unity
                { 7, 40240 }, -- Greaves of Turbulence
                { 8, 40244 }, -- The Impossible Dream
                { 9, 40239 }, -- The Hand of Nerub
                { 10, 40245 }, -- Fading Glow
                { 16, 40637 }, -- Mantle of the Lost Conqueror
                { 17, 40638 }, -- Mantle of the Lost Protector
                { 18, 40639 }, -- Mantle of the Lost Vanquisher
                { 20, "ac2183" },
            },
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
            EncounterJournalID = 1607,
			Level = 999,
			DisplayIDs = {{16582}},
			AtlasMapBossID = "1",
            NameColor = _RED,
			[RAID10_DIFF] = {
                { 1, 39297 }, -- Cloak of Darkening
                { 2, 39310 }, -- Mantle of the Extensive Mind
                { 3, 39309 }, -- Leggings of the Instructor
                { 4, 39299 }, -- Rapid Attack Gloves
                { 5, 39308 }, -- Girdle of Lenience
                { 6, 39307 }, -- Iron Rings of Endurance
                { 7, 39306 }, -- Plated Gloves of Relief
                { 8, 39298 }, -- Waistguard of the Tutor
                { 9, 39311 }, -- Scepter of Murmuring Spirits
                { 10, 39296 }, -- Accursed Bow of the Elite
            },
            [RAID25_DIFF] = {
                { 1, 40325 }, -- Bindings of the Expansive Mind
                { 2, 40326 }, -- Boots of Forlorn Wishes
                { 3, 40305 }, -- Spaulders of Egotism
                { 4, 40319 }, -- Chestpiece of Suspicion
                { 5, 40323 }, -- Esteemed Bindings
                { 6, 40315 }, -- Shoulderpads of Secret Arts
                { 7, 40324 }, -- Bands of Mutual Respect
                { 8, 40327 }, -- Girdle of Recuperation
                { 9, 40306 }, -- Bracers of the Unholy Knight
                { 10, 40316 }, -- Gauntlets of Guiding Touch
                { 11, 40317 }, -- Girdle of Razuvious
                { 12, 40318 }, -- Legplates of Double Strikes
                { 13, 40320 }, -- Faithful Steel Sabatons
                { 14, 40071 }, -- Chains of Adoration
                { 15, 40065 }, -- Fool's Trial
                { 16, 40069 }, -- Heritage
                { 17, 40064 }, -- Thunderstorm Amulet
                { 18, 40080 }, -- Lost Jewel
                { 19, 40075 }, -- Ruthlessness
                { 20, 40107 }, -- Sand-Worn Band
                { 21, 40074 }, -- Strong-Handed Ring
                { 22, 40321 }, -- Idol of the Shooting Star
                { 23, 40322 }, -- Totem of Dueling
            },
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
            EncounterJournalID = 1608,
			Level = 999,
			DisplayIDs = {{16279}},
			AtlasMapBossID = "2",
            NameColor = _RED,
			[RAID10_DIFF] = {
                { 1, 39390 }, -- Resurgent Phantom Bindings
                { 2, 39386 }, -- Tunic of Dislocation
                { 3, 39391 }, -- Heinous Mail Chestguard
                { 4, 39379 }, -- Spectral Rider's Girdle
                { 5, 39345 }, -- Girdle of the Ascended Phantom
                { 6, 39369 }, -- Sabatons of Deathlike Gloom
                { 7, 39392 }, -- Veiled Amulet of Life
                { 8, 39389 }, -- Signet of the Malevolent
                { 9, 39388 }, -- Spirit-World Glass
                { 10, 39344 }, -- Slayer of the Lifeless
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40339 }, -- Gothik's Cowl
                { 7, 40338 }, -- Bindings of Yearning
                { 8, 40329 }, -- Hood of the Exodus
                { 9, 40341 }, -- Shackled Cinch
                { 10, 40333 }, -- Leggings of Fleeting Moments
                { 11, 40340 }, -- Helm of Unleashed Energy
                { 12, 40331 }, -- Leggings of Failed Escape
                { 13, 40328 }, -- Helm of Vital Protection
                { 14, 40334 }, -- Burdened Shoulderplates
                { 15, 40332 }, -- Abetment Bracers
                { 16, 40330 }, -- Bracers of Unrelenting Attack
                { 17, 40257 }, -- Defender's Code
                { 18, 40255 }, -- Dying Curse
                { 19, 40258 }, -- Forethought Talisman
                { 20, 40256 }, -- Grim Toll
                { 21, 40342 }, -- Idol of Awakening
                { 22, 40337 }, -- Libram of Resurgence
                { 23, 40336 }, -- Life and Death
                { 24, 40335 }, -- Touch of Horror
            },
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = {16064, 16065, 16062, 16063},
            EncounterJournalID = 1609,
			Level = 999,
			DisplayIDs = {{16155},{16153},{16139},{16154}},
			AtlasMapBossID = "3",
            NameColor = _RED,
			[RAID10_DIFF] = {
                { 1, 39396 }, -- Gown of Blaumeux
                { 2, 39397 }, -- Pauldrons of Havoc
                { 3, 39395 }, -- Thane's Tainted Greathelm
                { 4, 39393 }, -- Claymore of Ancient Power
                { 5, 39394 }, -- Charmed Cierge
                { 16, 40610 }, -- Chestguard of the Lost Conqueror
                { 17, 40611 }, -- Chestguard of the Lost Protector
                { 18, 40612 }, -- Chestguard of the Lost Vanquisher
                { 20, "ac2176" },
            },
            [RAID25_DIFF] = {
                { 1, 40349 }, -- Gloves of Peaceful Death
                { 2, 40344 }, -- Helm of the Grave
                { 3, 40352 }, -- Leggings of Voracious Shadows
                { 4, 40347 }, -- Zeliek's Gauntlets
                { 5, 40350 }, -- Urn of Lost Memories
                { 6, 40345 }, -- Broken Promise
                { 7, 40343 }, -- Armageddon
                { 8, 40348 }, -- Damnation
                { 9, 40346 }, -- Final Voyage
                { 16, 40625 }, -- Breastplate of the Lost Conqueror
                { 17, 40626 }, -- Breastplate of the Lost Protector
                { 18, 40627 }, -- Breastplate of the Lost Vanquisher
                { 20, "ac2177" },
            },
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
            EncounterJournalID = 1610,
			Level = 999,
			DisplayIDs = {{16174}},
			AtlasMapBossID = 1,
			[RAID10_DIFF] = {
                { 1, 39272 }, -- Drape of Surgery
                { 2, 39273 }, -- Sullen Cloth Boots
                { 3, 39275 }, -- Contagion Gloves
                { 4, 39274 }, -- Retcher's Shoulderpads
                { 5, 39267 }, -- Abomination Shoulderblades
                { 6, 39262 }, -- Gauntlets of Combined Strength
                { 7, 39261 }, -- Tainted Girdle of Mending
                { 8, 39271 }, -- Blade of Dormant Memories
                { 9, 39270 }, -- Hatestrike
                { 16, "ac1856" },
            },
            [RAID25_DIFF] = {
                { 1, 40271 }, -- Sash of Solitude
                { 2, 40269 }, -- Boots of Persuasion
                { 3, 40260 }, -- Belt of the Tortured
                { 4, 40270 }, -- Boots of Septic Wounds
                { 5, 40262 }, -- Gloves of Calculated Risk
                { 6, 40272 }, -- Girdle of the Gambit
                { 7, 40261 }, -- Crude Discolored Battlegrips
                { 8, 40263 }, -- Fleshless Girdle
                { 9, 40259 }, -- Waistguard of Divine Grace
                { 10, 40071 }, -- Chains of Adoration
                { 11, 40065 }, -- Fool's Trial
                { 12, 40069 }, -- Heritage
                { 13, 40064 }, -- Thunderstorm Amulet
                { 14, 40080 }, -- Lost Jewel
                { 15, 40075 }, -- Ruthlessness
                { 16, 40107 }, -- Sand-Worn Band
                { 17, 40074 }, -- Strong-Handed Ring
                { 18, 40273 }, -- Surplus Limb
                { 19, 40267 }, -- Totem of Hex
                { 20, 40268 }, -- Libram of Tolerance
                { 21, 40264 }, -- Split Greathammer
                { 22, 40266 }, -- Hero's Surrender
                { 23, 40265 }, -- Arrowsong
                { 25, "ac1857" },
            },
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
            EncounterJournalID = 1611,
			Level = 999,
			DisplayIDs = {{16035}},
			AtlasMapBossID = 2,
			[RAID10_DIFF] = {
                { 1, 39284 }, -- Miasma Mantle
                { 2, 39285 }, -- Handgrips of Turmoil
                { 3, 39283 }, -- Putrescent Bands
                { 4, 39279 }, -- Blistered Belt of Decay
                { 5, 39278 }, -- Bands of Anxiety
                { 6, 39280 }, -- Leggings of Innumerable Barbs
                { 7, 39282 }, -- Bone-Linked Amulet
                { 8, 39277 }, -- Sealing Ring of Grobbulus
                { 9, 39281 }, -- Infection Repulser
                { 10, 39276 }, -- The Skull of Ruin
            },
            [RAID25_DIFF] = {
                { 1, 40250 }, -- Aged Winter Cloak
                { 2, 40254 }, -- Cloak of Averted Crisis
                { 3, 40252 }, -- Cloak of the Shadowed Sun
                { 4, 40253 }, -- Shawl of the Old Maid
                { 5, 40251 }, -- Shroud of Luminosity
                { 6, 40287 }, -- Cowl of Vanity
                { 7, 40286 }, -- Mantle of the Corrupted
                { 8, 40351 }, -- Mantle of the Fatigued Sage
                { 9, 40289 }, -- Sympathetic Amice
                { 10, 40277 }, -- Tunic of Indulgence
                { 11, 40285 }, -- Desecrated Past
                { 12, 40288 }, -- Spaulders of Incoherence
                { 13, 40283 }, -- Fallout Impervious Tunic
                { 14, 40282 }, -- Slime Stream Bands
                { 15, 40275 }, -- Depraved Linked Belt
                { 16, 40279 }, -- Chestguard of the Exhausted
                { 17, 40274 }, -- Bracers of Liberation
                { 18, 40278 }, -- Girdle of Chivalry
                { 19, 40257 }, -- Defender's Code
                { 20, 40255 }, -- Dying Curse
                { 21, 40258 }, -- Forethought Talisman
                { 22, 40256 }, -- Grim Toll
                { 23, 40281 }, -- Twilight Mist
                { 24, 40280 }, -- Origin of Nightmares
                { 25, 40284 }, -- Plague Igniter
            },
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
            EncounterJournalID = 1612,
			Level = 999,
			DisplayIDs = {{16064}},
			AtlasMapBossID = 3,
			[RAID10_DIFF] = {
                { 1, 39272 }, -- Drape of Surgery
                { 2, 39284 }, -- Miasma Mantle
                { 3, 39396 }, -- Gown of Blaumeux
                { 4, 39309 }, -- Leggings of the Instructor
                { 5, 39237 }, -- Spaulders of Resumed Battle
                { 6, 39279 }, -- Blistered Belt of Decay
                { 7, 39191 }, -- Splint-Bound Leggings
                { 8, 39215 }, -- Boots of the Follower
                { 9, 39294 }, -- Arc-Scorched Helmet
                { 10, 39248 }, -- Tunic of the Lost Pack
                { 11, 39194 }, -- Rusted-Link Spiked Gauntlets
                { 12, 39251 }, -- Necrogenic Belt
                { 13, 39379 }, -- Spectral Rider's Girdle
                { 14, 39188 }, -- Chivalric Chestguard
                { 15, 39345 }, -- Girdle of the Ascended Phantom
                { 16, 39146 }, -- Collar of Dissolution
                { 17, 39232 }, -- Pendant of Lost Vocations
                { 18, 39193 }, -- Band of Neglected Pleas
                { 19, 39388 }, -- Spirit-World Glass
                { 20, 39200 }, -- Grieving Spellblade
                { 21, 39344 }, -- Slayer of the Lifeless
                { 22, 39281 }, -- Infection Repulser
                { 23, 39394 }, -- Charmed Cierge

                { 101, 40622 }, -- Spaulders of the Lost Conqueror
                { 102, 40623 }, -- Spaulders of the Lost Protector
                { 103, 40624 }, -- Spaulders of the Lost Vanquisher
                { 105, 40610 }, -- Chestguard of the Lost Conqueror
                { 106, 40611 }, -- Chestguard of the Lost Protector
                { 107, 40612 }, -- Chestguard of the Lost Vanquisher
                { 116, 40619 }, -- Leggings of the Lost Conqueror
                { 117, 40620 }, -- Leggings of the Lost Protector
                { 118, 40621 }, -- Leggings of the Lost Vanquisher
            },
            [RAID25_DIFF] = {
                { 1, 40247 }, -- Cowl of Innocent Delight
                { 2, 40289 }, -- Sympathetic Amice
                { 3, 40602 }, -- Robes of Mutation
                { 4, 39733 }, -- Gloves of Token Respect
                { 5, 40303 }, -- Wraps of the Persecuted
                { 6, 40326 }, -- Boots of Forlorn Wishes
                { 7, 40296 }, -- Cover of Silence
                { 8, 39768 }, -- Cowl of the Perished
                { 9, 40319 }, -- Chestpiece of Suspicion
                { 10, 40260 }, -- Belt of the Tortured
                { 11, 40205 }, -- Stalk-Skin Belt
                { 12, 40270 }, -- Boots of Septic Wounds
                { 13, 40193 }, -- Tunic of Masked Suffering
                { 14, 40209 }, -- Bindings of the Decrepit
                { 15, 40302 }, -- Benefactor's Gauntlets
                { 16, 39718 }, -- Corpse Scarab Handguards
                { 17, 40242 }, -- Grotesque Handgrips
                { 18, 39760 }, -- Helm of Diminished Pride
                { 19, 40185 }, -- Shoulderguards of Opportunity
                { 20, 40203 }, -- Breastplate of Tormented Rage
                { 21, 40332 }, -- Abetment Bracers
                { 22, 40188 }, -- Gauntlets of the Disobediant
                { 23, 40259 }, -- Waistguard of Divine Grace
                { 24, 40204 }, -- Legguards of the Apostle
                { 25, 39717 }, -- Inexorable Sabatons
                { 26, 40206 }, -- Iron-Spring Jumpers
                { 27, 40297 }, -- Sabatons of Endurance
                { 28, 40350 }, -- Urn of Lost Memories
                { 29, 40191 }, -- Libram of Radiance

                { 101, 40281 }, -- Twilight Mist
                { 102, 39714 }, -- Webbed Death
                { 103, 39730 }, -- Widow's Fury
                { 104, 40343 }, -- Armageddon
                { 105, 40239 }, -- The Hand of Nerub
                { 106, 40280 }, -- Origin of Nightmares
                { 107, 39716 }, -- Shield of Assimilation
                { 108, 40265 }, -- Arrowsong
                { 109, 40346 }, -- Final Voyage
                { 111, 40637 }, -- Mantle of the Lost Conqueror
                { 112, 40638 }, -- Mantle of the Lost Protector
                { 113, 40639 }, -- Mantle of the Lost Vanquisher
                { 116, 40625 }, -- Breastplate of the Lost Conqueror
                { 117, 40626 }, -- Breastplate of the Lost Protector
                { 118, 40627 }, -- Breastplate of the Lost Vanquisher
                { 120, 40634 }, -- Legplates of the Lost Conqueror
                { 121, 40635 }, -- Legplates of the Lost Protector
                { 122, 40636 }, -- Legplates of the Lost Vanquisher
            },
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
            EncounterJournalID = 1613,
			Level = 999,
			DisplayIDs = {{16137}},
			AtlasMapBossID = 4,
			[RAID10_DIFF] = {
                { 1, 39295 }, -- Cowl of Sheet Lightning
                { 2, 39294 }, -- Arc-Scorched Helmet
                { 3, 39293 }, -- Blackened Legplates of Feugen
                { 4, 39292 }, -- Repelling Charge
                { 5, 39291 }, -- Torment of the Banished
                { 16, 40619 }, -- Leggings of the Lost Conqueror
                { 17, 40620 }, -- Leggings of the Lost Protector
                { 18, 40621 }, -- Leggings of the Lost Vanquisher
                { 20, "ac2178" },
				{ 21, "ac2180" },
            },
            [RAID25_DIFF] = {
                { 1, 40303 }, -- Wraps of the Persecuted
                { 2, 40301 }, -- Cincture of Polarity
                { 3, 40296 }, -- Cover of Silence
                { 4, 40304 }, -- Headpiece of Fungal Bloom
                { 5, 40299 }, -- Pauldrons of the Abandoned
                { 6, 40302 }, -- Benefactor's Gauntlets
                { 7, 40298 }, -- Faceguard of the Succumbed
                { 8, 40294 }, -- Riveted Abomination Leggings
                { 9, 40297 }, -- Sabatons of Endurance
                { 10, 40300 }, -- Spire of Sunset
                { 16, 40634 }, -- Legplates of the Lost Conqueror
                { 17, 40635 }, -- Legplates of the Lost Protector
                { 18, 40636 }, -- Legplates of the Lost Vanquisher
                { 20, "ac2179" },
				{ 21, "ac2181" },
            },
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
            EncounterJournalID = 1614,
			Level = 999,
			DisplayIDs = {{16033}},
			AtlasMapBossID = "1",
            NameColor = GREEN,
			[RAID10_DIFF] = {
                { 1, 39415 }, -- Shroud of the Citadel
                { 2, 39404 }, -- Cloak of Mastery
                { 3, 39409 }, -- Cowl of Winged Fear
                { 4, 39408 }, -- Leggings of Sapphiron
                { 5, 39399 }, -- Helm of the Vast Legions
                { 6, 39405 }, -- Helmet of the Inner Sanctum
                { 7, 39403 }, -- Helm of the Unsubmissive
                { 8, 39398 }, -- Massive Skeletal Ribcage
                { 9, 39401 }, -- Circle of Death
                { 10, 39407 }, -- Circle of Life
                { 16, 44569 }, -- Key to the Focusing Iris
                { 18, "ac572" },
				{ 19, "ac2146" },
            },
            [RAID25_DIFF] = {
                { 1, 40381 }, -- Sympathy
                { 2, 40380 }, -- Gloves of Grandeur
                { 3, 40376 }, -- Legwraps of the Defeated Dragon
                { 4, 40362 }, -- Gloves of Fast Reactions
                { 5, 40379 }, -- Legguards of the Boneyard
                { 6, 40367 }, -- Boots of the Great Construct
                { 7, 40366 }, -- Platehelm of the Great Wyrm
                { 8, 40377 }, -- Noble Birthright Pauldrons
                { 9, 40365 }, -- Breastplate of Frozen Pain
                { 10, 40363 }, --  Bone-Inlaid Legguards
                { 11, 40378 }, -- Ceaseless Pity
                { 12, 40374 }, -- Cosmic Lights
                { 13, 40369 }, -- Icy Blast Amulet
                { 14, 40370 }, -- Gatekeeper
                { 15, 40375 }, -- Ring of Decaying Beauty
                { 16, 40371 }, -- Bandit's Insignia
                { 17, 40373 }, -- Extract of Necromatic Power
                { 18, 40372 }, -- Rune of Repulsion
                { 19, 40382 }, -- Soul of the Dead
                { 20, 40368 }, -- Murder
                { 22, 44577 }, -- Heroic Key to the Focusing Iris
                { 24, "ac573" },
				{ 25, "ac2147" },
            },
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
            EncounterJournalID = 1615,
			Level = 999,
			DisplayIDs = {{15945}},
			AtlasMapBossID = "2",
            NameColor = GREEN,
			[RAID10_DIFF] = {
                { 1, 39425 }, -- Cloak of the Dying
                { 2, 39421 }, -- Gem of Imprisoned Vassals
                { 3, 39416 }, -- Kel'Thuzad's Reach
                { 4, 39424 }, -- The Soulblade
                { 5, 39420 }, -- Anarchy
                { 6, 39417 }, -- Death's Bite
                { 7, 39423 }, -- Hammer of the Astral Plane
                { 8, 39422 }, -- Staff of the Plaguehound
                { 9, 39426 }, -- Wand of the Archlich
                { 10, 39419 }, -- Nerubian Conquerer
                { 16, 40616 }, -- Helm of the Lost Conqueror
                { 17, 40617 }, -- Helm of the Lost Protector
                { 18, 40618 }, -- Helm of the Lost Vanquisher
                { 20, "ac574" },
				{ 21, "ac1658" },
				{ 22, "ac2184" },
            },
            [RAID25_DIFF] = {
                { 1, 40405 }, -- Cape of the Unworthy Wizard
                { 2, 40403 }, -- Drape of the Deadly Foe
                { 3, 40398 }, -- Leggings of Mortal Arrogance
                { 4, 40387 }, -- Boundless Ambition
                { 5, 40399 }, -- Signet of Manifested Pain
                { 6, 40383 }, -- Calamity's Grasp
                { 7, 40386 }, -- Sinister Revenge
                { 8, 40396 }, -- The Turning Tide
                { 9, 40402 }, -- Last Laugh
                { 10, 40384 }, -- Betrayer of Humanity
                { 11, 40395 }, -- Torch of Holy Fire
                { 12, 40388 }, -- Journey's End
                { 13, 40401 }, -- Voice of Reason
                { 14, 40400 }, -- Wall of Terror
                { 15, 40385 }, -- Envoy of Mortality
                { 16, 40631 }, -- Crown of the Lost Conqueror
                { 17, 40632 }, -- Crown of the Lost Protector
                { 18, 40633 }, -- Crown of the Lost Vanquisher
                { 20, "ac575" },
				{ 21, "ac1658" },
				{ 22, "ac2185" },
            },
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[RAID10_DIFF] = {
                { 1, 39467 }, -- Minion Bracers
                { 2, 39472 }, -- Chain of Latent Energies
                { 3, 39470 }, -- Medallion of the Disgraced
                { 4, 39427 }, -- Omen of Ruin
                { 5, 39468 }, -- The Stray
                { 6, 39473 }, -- Contortion
            },
            [RAID25_DIFF] = {
                { 1, 40410 }, -- Shadow of the Ghoul
                { 2, 40409 }, -- Boots of the Escaped Captive
                { 3, 40414 }, -- Shoulderguards of the Undaunted
                { 4, 40412 }, -- Ousted Bead Necklace
                { 5, 40408 }, -- Haunting Call
                { 6, 40407 }, -- Silent Crusader
                { 7, 40406 }, -- Inevitable Defeat
            },
		},
        T7_SET,
        WOTLK_NAXXRAMAS_AC_TABLE,
	},
}

data["TheEyeOfEternity"] = {
    nameFormat = NAME_NEXUS,
	MapID = 4500,
	InstanceID = 616,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheEyeOfEternity",
	AtlasMapFile = {"TheEyeOfEternity"},
	-- LevelRange = {80, 80, 80},
	items = {
        { -- Malygos / 180
	        name = AL["Malygos"],
            npcID = 28859,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, 40526 }, -- Gown of the Spell-Weaver
                { 2, 40519 }, -- Footsteps of Malygos
                { 3, 40511 }, -- Focusing Energy Epaulets
                { 4, 40486 }, -- Necklace of the Glittering Chamber
                { 5, 40474 }, -- Surge Needle Ring
                { 6, 40491 }, -- Hailstorm
                { 7, 40488 }, -- Ice Spire Scepter
                { 8, 40489 }, -- Greatstaff of the Nexus
                { 9, 40497 }, -- Black Ice
                { 10, 40475 }, -- Barricade of Eternity
                { 16, 43952 }, -- Reins of the Azure Drake
                { 18, 44569 }, -- Key to the Focusing Iris
                { 19, 44650 }, -- Heart of Magic
            },
            [RAID25_DIFF] = {
                { 1, 40562 }, -- Hood of Rationality
                { 2, 40555 }, -- Mantle of Dissemination
                { 3, 40194 }, -- Blanketing Robes of Snow
                { 4, 40561 }, -- Leash of Heedless Magic
                { 5, 40560 }, -- Leggings of the Wanton Spellcaster
                { 6, 40558 }, -- Arcanic Tramplers
                { 7, 40594 }, -- Spaulders of Catatonia
                { 8, 40539 }, -- Chestguard of the Recluse
                { 9, 40541 }, -- Frosted Adroit Handguards
                { 10, 40566 }, -- Unravelling Strands of Sanity
                { 11, 40543 }, -- Blue Aspect Helm
                { 12, 40588 }, -- Tunic of the Artifact Guardian
                { 13, 40564 }, -- Winter Spectacle Gloves
                { 14, 40549 }, -- Boots of the Renewed Flight
                { 15, 40590 }, -- Elevated Lair Pauldrons
                { 16, 40589 }, -- Legplates of Sovereignty
                { 17, 40592 }, -- Boots of Healing Energies
                { 18, 40591 }, -- Melancholy Sabatons
                { 19, 40532 }, -- Living Ice Crystals
                { 20, 40531 }, -- Mark of Norgannon
                { 22, 43952 }, -- Reins of the Azure Drake
                { 24, 44577 }, -- Heroic Key to the Focusing Iris
                { 25, 44651 }, -- Heart of Magic
            }
        },
        KEYS
    }
}

data["ObsidianSanctum"] = {
	MapID = 4493,
	InstanceID = 615,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ObsidianSanctum",
	AtlasMapFile = {"ObsidianSanctum"},
	-- LevelRange = {80, 80, 80},
	items = {
        { -- CoTHillsbradDrake
            name = AL["Sartharion"],
            npcID = 28860,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 4,
            [RAID10_DIFF] = {
                { 1, 40428 }, -- Titan's Outlook
                { 2, 40427 }, -- Circle of Arcane Streams
                { 3, 40426 }, -- Signet of the Accord
                { 4, 40433 }, -- Wyrmrest Band
                { 5, 40430 }, -- Majestic Dragon Figurine
                { 6, 40429 }, -- Crimson Steel
                { 16, 40613 }, -- Gloves of the Lost Conqueror
                { 17, 40614 }, -- Gloves of the Lost Protector
                { 18, 40615 }, -- Gloves of the Lost Vanquisher
                { 20, 43345 }, -- Dragon Hide Bag
                { 21, 43347 }, -- Satchel of Spoils
            },
            [RAID25_DIFF] = {
                { 1, 40437 }, -- Concealment Shoulderpads
                { 2, 40439 }, -- Mantle of the Eternal Sentinel
                { 3, 40451 }, -- Hyaline Helm of the Sniper
                { 4, 40438 }, -- Council Chamber Epaulets
                { 5, 40453 }, -- Chestplate of the Great Aspects
                { 6, 40446 }, -- Dragon Brood Legguards
                { 7, 40433 }, -- Wyrmrest Band
                { 8, 40431 }, -- Fury of the Five Flights
                { 9, 40432 }, -- Illustration of the Dragon Soul
                { 10, 40455 }, -- Staff of Restraint
                { 16, 40628 }, -- Gauntlets of the Lost Conqueror
                { 17, 40629 }, -- Gauntlets of the Lost Protector
                { 18, 40630 }, -- Gauntlets of the Lost Vanquisher
                { 20, 43345 }, -- Dragon Hide Bag
                { 21, 43346 }, -- Large Satchel of Spoils
            }
        },
        { -- CoTHillsbradDrake
            name = format(BONUS_LOOT_SPLIT, AL["Sartharion"], AL["Bonus Loot"]),
            npcID = 28860,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, "INV_Box_01", nil, AL["One Drake Left"] },
                { 2, 43988 }, -- Gale-Proof Cloak
                { 3, 43990 }, -- Blade-Scarred Tunic
                { 4, 43991 }, -- Legguards of Composure
                { 5, 43989 }, -- Remembrance Girdle
                { 6, 43992 }, -- Volitant Amulet
                { 8, "INV_Box_01", nil, AL["Two Drakes Left"] },
                { 9, 43995 }, -- Enamored Cowl
                { 10, 43998 }, -- Chestguard of Flagrant Prowess
                { 11, 43996 }, -- Sabatons of Firmament
                { 12, 43994 }, -- Belabored Legplates
                { 13, 43993 }, -- Greatring of Collision
                { 16, "INV_Box_01", nil, AL["Three Drakes Left"] },
                { 17, 43986 }, -- Reins of the Black Drake
            },
            [RAID25_DIFF] = {
                { 1, "INV_Box_01", nil, AL["One Drake Left"] },
                { 2, 44002 }, -- The Sanctum's Flowing Vestments
                { 3, 44003 }, -- Upstanding Spaulders
                { 4, 44004 }, -- Bountiful Gauntlets
                { 5, 44000 }, -- Dragonstorm Breastplate
                { 7, "INV_Box_01", nil, AL["Two Drakes Left"] },
                { 8, 44005 }, -- Pennant Cloak
                { 9, 44008 }, -- Unsullied Cuffs
                { 10, 44007 }, -- Headpiece of Reconciliation
                { 11, 44011 }, -- Leggings of the Honored
                { 12, 44006 }, -- Obsidian Greathelm
                { 16, "INV_Box_01", nil, AL["Three Drakes Left"] },
                { 17, 43954 }, -- Reins of the Twilight Drake
            }
        },
        T7_SET
    }
}

data["Ulduar"] = {
	MapID = 4273,
    EncounterJournalID = 759,
	InstanceID = 603,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UlduarA",
	AtlasMapFile = {"UlduarA", "UlduarEnt"},
	--LoadDifficulty = NORMAL_DIFF,
	-- LevelRange = {80, 80, 80},
	items = {
        { -- UlduarLeviathan
            name = AL["Flame Leviathan"],
            NameColor = GREEN,
            npcID = 33113,
            EncounterJournalID = 1637,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, 45289 }, -- Lifespark Visage
                { 2, 45291 }, -- Combustion Bracers
                { 3, 45288 }, -- Firestrider Chestguard
                { 4, 45283 }, -- Flamewatch Armguards
                { 5, 45285 }, -- Might of the Leviathan
                { 6, 45292 }, -- Energy Siphon
                { 7, 45286 }, -- Pyrite Infuser
                { 8, 45284 }, -- Kinetic Ripper
                { 9, 45287 }, -- Firesoul
                { 10, 45282 }, -- Ironsoul
                { 16, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarFlameLeviathan10" },
                { 25, "ac3056", nil, nil, AL["Hard Mode"] },
                { 26, 45293 }, -- Handguards of Potent Cures
                { 27, 45300 }, -- Mantle of Fiery Vengeance
                { 28, 45295 }, -- Gilded Steel Legplates
                { 29, 45297 }, -- Shimmering Seal
                { 30, 45296 }, -- Twirling Blades
            },
            [RAID25_DIFF] = {
                { 1, 45117 }, -- Constructor's Handwraps
                { 2, 45119 }, -- Embrace of the Leviathan
                { 3, 45108 }, -- Mechanist's Bindings
                { 4, 45118 }, -- Steamworker's Goggles
                { 5, 45109 }, -- Gloves of the Fiery Behemoth
                { 6, 45107 }, -- Iron Riveted War Helm
                { 7, 45111 }, -- Mimiron's Inferno Couplings
                { 8, 45116 }, -- Freya's Choker of Warding
                { 9, 45113 }, -- Glowing Ring of Reclamation
                { 10, 45106 }, -- Strength of the Automaton
                { 11, 45112 }, -- The Leviathan's Coil
                { 12, 45115 }, -- Overcharged Fuel Rod
                { 13, 45114 }, -- Steamcaller's Totem
                { 14, 45110 }, -- Titanguard
                { 15, 45086 }, -- Rising Sun
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarFlameLeviathan25" },
                { 25, "ac3057", nil, nil, AL["Hard Mode"] },
                { 26, 45135 }, -- Boots of Fiery Resolution
                { 27, 45136 }, -- Shoulderpads of Dormant Energies
                { 28, 45134 }, -- Plated Leggings of Ruination
                { 29, 45133 }, -- Pendant of Fiery Havoc
                { 30, 45132 }, -- Golden Saronite Dragon
            }
        },
        { -- UlduarIgnis
            name = AL["Ignis the Furnace Master"],
            NameColor = GREEN,
            npcID = 33118,
            EncounterJournalID = 1638,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 2,
            [RAID10_DIFF] = {
                { 1, 45317 }, -- Shawl of the Caretaker
                { 2, 45318 }, -- Drape of Fuming Anger
                { 3, 45312 }, -- Gloves of Smoldering Touch
                { 4, 45316 }, -- Armbraces of the Vibrant Flame
                { 5, 45321 }, -- Pauldrons of Tempered Will
                { 6, 45310 }, -- Gauntlets of the Iron Furnace
                { 7, 45313 }, -- Furnace Stone
                { 8, 45314 }, -- Igniter Rod
                { 9, 45311 }, -- Relentless Edge
                { 10, 45309 }, -- Rifle of the Platinum Guard
                { 16, "ac2927" },
				{ 17, "ac2925" },
				{ 18, "ac2930" },
            },
            [RAID25_DIFF] = {
                { 1, 45186 }, -- Soot-Covered Mantle
                { 2, 45185 }, -- Flamewrought Cinch
                { 3, 45162 }, -- Flamestalker Boots
                { 4, 45164 }, -- Helm of the Furnace Master
                { 5, 45187 }, -- Wristguards of the Firetender
                { 6, 45167 }, -- Lifeforge Breastplate
                { 7, 45161 }, -- Girdle of Embers
                { 8, 45166 }, -- Charred Saronite Greaves
                { 9, 45157 }, -- Cindershard Ring
                { 10, 45168 }, -- Pyrelight Circle
                { 11, 45158 }, -- Heart of Iron
                { 12, 45169 }, -- Totem of the Dancing Flame
                { 13, 45165 }, -- Worldcarver
                { 14, 45171 }, -- Intensity
                { 15, 45170 }, -- Scepter of Creation
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "ac2928" },
				{ 19, "ac2926" },
				{ 20, "ac2929" },
            }
        },
        { -- UlduarRazorscale
            name = AL["Razorscale"],
            NameColor = GREEN,
            npcID = 33186,
            EncounterJournalID = 1639,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 3,
            [RAID10_DIFF] = {
                { 1, 45306 }, -- Binding of the Dragon Matriarch
                { 2, 45302 }, -- Treads of the Invader
                { 3, 45301 }, -- Bracers of the Smothering Inferno
                { 4, 45307 }, -- Ironscale Leggings
                { 5, 45299 }, -- Dragonsteel Faceplate
                { 6, 45305 }, -- Breastplate of the Afterlife
                { 7, 45304 }, -- Stormtempered Girdle
                { 8, 45303 }, -- Band of Draconic Guile
                { 9, 45308 }, -- Eye of the Broodmother
                { 10, 45298 }, -- Razorscale Talon
                { 16, "ac2919" },
				{ 17, "ac2923" },
            },
            [RAID25_DIFF] = {
                { 1, 45138 }, -- Drape of the Drakerider
                { 2, 45150 }, -- Collar of the Wyrmhunter
                { 3, 45146 }, -- Shackles of the Odalisque
                { 4, 45149 }, -- Bracers of the Broodmother
                { 5, 45141 }, -- Proto-hide Leggings
                { 6, 45151 }, -- Belt of the Fallen Wyrm
                { 7, 45143 }, -- Saronite Mesh Legguards
                { 8, 45140 }, -- Razorscale Shoulderguards
                { 9, 45139 }, -- Dragonslayer's Brace
                { 10, 45148 }, -- Living Flame
                { 11, 45510 }, -- Libram of Discord
                { 12, 45144 }, -- Sigil of Deflection
                { 13, 45142 }, -- Remorse
                { 14, 45147 }, -- Guiding Star
                { 15, 45137 }, -- Veranus' Bane
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "ac2921" },
				{ 19, "ac2924" },
            }
        },
        { -- UlduarXT-002 Deconstructor
            name = AL["XT-002 Deconstructor"],
            NameColor = GREEN,
            npcID = 33293,
            EncounterJournalID = 1640,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 4,
            [RAID10_DIFF] = {
                { 1, 45694 }, -- Conductive Cord
                { 2, 45677 }, -- Treacherous Shoulderpads
                { 3, 45686 }, -- Vest of the Glowing Crescent
                { 4, 45687 }, -- Helm of Veiled Energies
                { 5, 45679 }, -- Gloves of Taut Grip
                { 6, 45676 }, -- Chestplate of Vicious Potency
                { 7, 45680 }, -- Armbands of the Construct
                { 8, 45675 }, -- Power Enhancing Loop
                { 9, 45685 }, -- Plasma Foil
                { 10, 45682 }, -- Pulsing Spellshield
                { 16, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarXTDeconstructor10" },
                { 25, "ac3058", nil, nil, AL["Hard Mode"] },
                { 26, 45869 }, -- Fluxing Energy Coils
                { 27, 45867 }, -- Breastplate of the Stoneshaper
                { 28, 45871 }, -- Seal of Ulduar
                { 29, 45868 }, -- Aesir's Edge
                { 30, 45870 }, -- Magnetized Projectile Emitter
            },
            [RAID25_DIFF] = {
                { 1, 45253 }, -- Mantle of Wavering Calm
                { 2, 45258 }, -- Sandals of Rash Temperament
                { 3, 45260 }, -- Boots of Hasty Revival
                { 4, 45259 }, -- Quartz-studded Harness
                { 5, 45249 }, -- Brass-lined Boots
                { 6, 45251 }, -- Shoulderplates of the Deconstructor
                { 7, 45252 }, -- Horologist's Wristguards
                { 8, 45248 }, -- Clockwork Legplates
                { 9, 45250 }, -- Crazed Construct Ring
                { 10, 45247 }, -- Signet of the Earthshaker
                { 11, 45254 }, -- Sigil of the Vengeful Heart
                { 12, 45255 }, -- Thunderfall Totem
                { 13, 45246 }, -- Golem-Shard Sticker
                { 14, 45256 }, -- Twisted Visage
                { 15, 45257 }, -- Quartz Crystal Wand
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarXTDeconstructor25" },
                { 25, "ac3059", nil, nil, AL["Hard Mode"] },
                { 26, 45446 }, -- Grasps of Reason
                { 27, 45444 }, -- Gloves of the Steady Hand
                { 28, 45445 }, -- Breastplate of the Devoted
                { 29, 45443 }, -- Charm of Meticulous Timing
                { 30, 45442 }, -- Sorthalis, Hammer of the Watchers
            }
        },
        { -- UlduarIronCouncil
            name = AL["The Iron Council"],
            NameColor = BLUE,
            npcID = 32857,
            EncounterJournalID = 1641,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarB",
            AtlasMapBossID = 5,
            [RAID10_DIFF] = {
                { 1, 45322 }, -- Cloak of the Iron Council
                { 2, 45423 }, -- Runetouch Handwraps
                { 3, 45324 }, -- Leggings of Swift Reflexes
                { 4, 45378 }, -- Boots of the Petrified Forest
                { 5, 45329 }, -- Circlet of True Sight
                { 6, 45333 }, -- Belt of the Iron Servant
                { 7, 45330 }, -- Greaves of Iron Intensity
                { 8, 45418 }, -- Lady Maye's Sapphire Ring
                { 9, 45332 }, -- Stormtip
                { 10, 45331 }, -- Rune-Etched Nightblade
                { 16, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarCouncil10" },
                { 24, "ac2941", nil, nil, AL["Hard Mode"] },
                { 25, 45455 }, -- Belt of the Crystal Tree
                { 26, 45447 }, -- Watchful Eye
                { 27, 45456 }, -- Loop of the Agile
                { 28, 45449 }, -- The Masticator
                { 29, 45448 }, -- Perilous Bite
                { 30, 45506 }, -- Archivum Data Disc
            },
            [RAID25_DIFF] = {
                { 1, 45224 }, -- Drape of the Lithe
                { 2, 45240 }, -- Raiments of the Iron Council
                { 3, 45238 }, -- Overload Legwraps
                { 4, 45237 }, -- Phaelia's Vestments of the Sprouting Seed
                { 5, 45232 }, -- Runed Ironhide Boots
                { 6, 45227 }, -- Iron-studded Mantle
                { 7, 45239 }, -- Runeshaper's Gloves
                { 8, 45226 }, -- Ancient Iron Heaume
                { 9, 45225 }, -- Steelbreaker's Embrace
                { 10, 45228 }, -- Handguards of the Enclave
                { 11, 45193 }, -- Insurmountable Fervor
                { 12, 45236 }, -- Unblinking Eye
                { 13, 45235 }, -- Radiant Seal
                { 14, 45233 }, -- Rune Edge
                { 15, 45234 }, -- Rapture
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarCouncil25" },
                { 23, "ac2944", nil, nil, AL["Hard Mode"] },
                { 24, 45242 }, -- Drape of Mortal Downfall
                { 25, 45245 }, -- Shoulderpads of the Intruder
                { 26, 45244 }, -- Greaves of Swift Vengeance
                { 27, 45241 }, -- Belt of Colossal Rage
                { 28, 45243 }, -- Sapphire Amulet of Renewal
                { 29, 45607 }, -- Fang of Oblivion
                { 30, 45857 }, -- Archivum Data Disc
            }
        },
        { -- UlduarKologarn
            name = AL["Kologarn"],
            NameColor = BLUE,
            npcID = 32930,
            EncounterJournalID = 1642,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarB",
            AtlasMapBossID = 6,
            [RAID10_DIFF] = {
                { 1, 45704 }, -- Shawl of the Shattered Giant
                { 2, 45701 }, -- Greaves of the Earthbinder
                { 3, 45697 }, -- Shoulderguards of the Solemn Watch
                { 4, 45698 }, -- Sabatons of the Iron Watcher
                { 5, 45696 }, -- Mark of the Unyielding
                { 6, 45699 }, -- Pendant of the Piercing Glare
                { 7, 45702 }, -- Emerald Signet Ring
                { 8, 45703 }, -- Spark of Hope
                { 9, 45700 }, -- Stoneguard
                { 10, 45695 }, -- Spire of Withering Dreams
                { 16, "ac2953" },
				{ 17, "ac2955" },
				{ 18, "ac2959" },
				{ 19, "ac2951" },
            },
            [RAID25_DIFF] = {
                { 1, 45272 }, -- Robes of the Umbral Brute
                { 2, 45275 }, -- Bracers of Unleashed Magic
                { 3, 45273 }, -- Handwraps of Plentiful Recovery
                { 4, 45265 }, -- Shoulderpads of the Monolith
                { 5, 45274 }, -- Leggings of the Stoneweaver
                { 6, 45264 }, -- Decimator's Armguards
                { 7, 45269 }, -- Unfaltering Armguards
                { 8, 45268 }, -- Gloves of the Pythonic Guardian
                { 9, 45267 }, -- Saronite Plated Legguards
                { 10, 45262 }, -- Necklace of Unerring Mettle
                { 11, 45263 }, -- Wrathstone
                { 12, 45271 }, -- Ironmender
                { 13, 45270 }, -- Idol of the Crying Wind
                { 14, 45266 }, -- Malice
                { 15, 45261 }, -- Giant's Bane
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "ac2954" },
				{ 19, "ac2956" },
				{ 20, "ac2960" },
				{ 21, "ac2952" },
            }
        },
        { -- UlduarAlgalon
            name = AL["Algalon the Observer"],
            NameColor = BLUE,
            npcID = 32871,
            EncounterJournalID = 1650,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarB",
            AtlasMapBossID = 7,
            [RAID10_DIFF] = {
                { 1, 46042 },	-- Drape of the Messenger
				{ 2, 46045 },	-- Pulsar Gloves
				{ 3, 46050 },	-- Starlight Treads
				{ 4, 46043 },	-- Gloves of the Endless Dark
				{ 5, 46049 },	-- Zodiac Leggings
				{ 6, 46044 },	-- Observer's Mantle
				{ 7, 46037 },	-- Shoulderplates of the Celestial Watch
				{ 8, 46039 },	-- Breastplate of the Timeless
				{ 9, 46041 },	-- Starfall Girdle
				{ 10, 46047 },	-- Pendant of the Somber Witness
				{ 11, 46040 },	-- Strength of the Heavens
				{ 12, 46048 },	-- Band of Lights
				{ 13, 46046 },	-- Nebula Band
				{ 14, 46038 },	-- Dark Matter
				{ 15, 46051 },	-- Meteorite Crystal
				{ 16, 46052 },	-- Reply-Code Alpha
            },
            [RAID25_DIFF] = {
				{ 1, 45665 },	-- Pharos Gloves
				{ 2, 45619 },	-- Starwatcher's Binding
				{ 3, 45611 },	-- Solar Bindings
				{ 4, 45616 },	-- Star-beaded Clutch
				{ 5, 45610 },	-- Boundless Gaze
				{ 6, 45615 },	-- Planewalker Treads
				{ 7, 45594 },	-- Legplates of the Endless Void
				{ 8, 45599 },	-- Sabatons of Lifeless Night
				{ 9, 45609 },	-- Comet's Trail
				{ 10, 45620 },	-- Starshard Edge
				{ 11, 45607 },	-- Fang of Oblivion
				{ 12, 45612 },	-- Constellus
				{ 13, 45613 },	-- Dreambinder
				{ 14, 45587 },	-- Bulwark of Algalon
				{ 15, 45570 },	-- Skyforge Crossbow
                { 16, 45617 },	-- Cosmos
                { 18, 45038 },	-- Fragment of Val'anyr
				{ 20, 46053 },	-- Reply-Code Alpha
            }
        },
        { -- UlduarAuriaya
            name = AL["Auriaya"],
            npcID = 33515,
            EncounterJournalID = 1643,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarC",
            AtlasMapBossID = 8,
            [RAID10_DIFF] = {
                { 1, 45832 }, -- Mantle of the Preserver
                { 2, 45865 }, -- Raiments of the Corrupted
                { 3, 45864 }, -- Cover of the Keepers
                { 4, 45709 }, -- Nimble Climber's Belt
                { 5, 45711 }, -- Ironaya's Discarded Mantle
                { 6, 45712 }, -- Chestplate of Titanic Fury
                { 7, 45708 }, -- Archaedas' Lost Legplates
                { 8, 45866 }, -- Elemental Focus Stone
                { 9, 45707 }, -- Shieldwall of the Breaker
                { 10, 45713 }, -- Nurturing Touch
                { 16, "ac3006" },
                { 17, "ac3076" },
            },
            [RAID25_DIFF] = {
                { 1, 45319 }, -- Cloak of the Makers
                { 2, 45435 }, -- Cowl of the Absolute
                { 3, 45441 }, -- Sandals of the Ancient Keeper
                { 4, 45439 }, -- Unwavering Stare
                { 5, 45325 }, -- Gloves of the Stonereaper
                { 6, 45440 }, -- Amice of the Stoic Watch
                { 7, 45320 }, -- Shoulderplates of the Eternal
                { 8, 45334 }, -- Unbreakable Chestguard
                { 9, 45434 }, -- Greaves of the Rockmender
                { 10, 45326 }, -- Platinum Band of the Aesir
                { 11, 45438 }, -- Ring of the Faithful Servant
                { 12, 45436 }, -- Libram of the Resolute
                { 13, 45437 }, -- Runescribed Blade
                { 14, 45315 }, -- Stonerender
                { 15, 45327 }, -- Siren's Cry
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "ac3007" },
                { 19, "ac3077" },
            }
        },
        { -- UlduarHodir
            name = AL["Hodir"],
            npcID = 32845,
            EncounterJournalID = 1644,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarC",
            AtlasMapBossID = 9,
            [RAID10_DIFF] = {
                { 1, 45873 }, -- Winter's Frigid Embrace
                { 2, 45464 }, -- Cowl of Icy Breaths
                { 3, 45874 }, -- Signet of Winter
                { 4, 45458 }, -- Stormedge
                { 5, 45872 }, -- Avalanche
                { 9, "ac3182", nil, nil, AL["Hard Mode"] },
                { 10, 45888 }, -- Bitter Cold Armguards
                { 11, 45876 }, -- Shiver
                { 12, 45886 }, -- Icecore Staff
                { 13, 45887 }, -- Ice Layered Barrier
                { 14, 45877 }, -- The Boreal Guard
                { 15, 45786 }, -- Hodir's Sigil
                { 16, 45650 }, -- Leggings of the Wayward Conqueror
                { 17, 45651 }, -- Leggings of the Wayward Protector
                { 18, 45652 }, -- Leggings of the Wayward Vanquisher
                { 20, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarHodir10" },
            },
            [RAID25_DIFF] = {
                { 1, 45453 }, -- Winter's Icy Embrace
                { 2, 45454 }, -- Frost-bound Chain Bracers
                { 3, 45452 }, -- Frostplate Greaves
                { 4, 45451 }, -- Frozen Loop
                { 5, 45450 }, -- Northern Barrier
                { 8, "ac3184", nil, nil, AL["Hard Mode"] },
                { 9, 45461 }, -- Drape of Icy Intent
                { 10, 45462 }, -- Gloves of the Frozen Glade
                { 11, 45460 }, -- Bindings of Winter Gale
                { 12, 45459 }, -- Frigid Strength of Hodir
                { 13, 45612 }, -- Constellus
                { 14, 45457 }, -- Staff of Endless Winter
                { 15, 45815 }, -- Hodir's Sigil
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, 45632 }, -- Breastplate of the Wayward Conqueror
                { 19, 45633 }, -- Breastplate of the Wayward Protector
                { 20, 45634 }, -- Breastplate of the Wayward Vanquisher
                { 22, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarHodir25" },
            }
        },
        { -- UlduarThorim
            name = AL["Thorim"],
            npcID = 32865,
            EncounterJournalID = 1645,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarC",
            AtlasMapBossID = 10,
            [RAID10_DIFF] = {
                { 1, 45893 }, -- Guise of the Midgard Serpent
                { 2, 45927 }, -- Handwraps of Resonance
                { 3, 45894 }, -- Leggings of Unstable Discharge
                { 4, 45895 }, -- Belt of the Blood Pit
                { 5, 45892 }, -- Legacy of Thunder
                { 9, "ac3176", nil, nil, AL["Hard Mode"] },
                { 10, 45928 }, -- Gauntlets of the Thunder God
                { 11, 45933 }, -- Pendant of the Shallow Grave
                { 12, 45931 }, -- Mjolnir Runestone
                { 13, 45929 }, -- Sif's Remembrance
                { 14, 45930 }, -- Combatant's Bootblade
                { 15, 45784 }, -- Thorim's Sigil
                { 16, 45659 }, -- Spaulders of the Wayward Conqueror
                { 17, 45660 }, -- Spaulders of the Wayward Protector
                { 18, 45661 }, -- Spaulders of the Wayward Vanquisher
                { 20, "ac2971" },
                { 21, "ac2973" },
                { 22, "ac3176" },
                { 23, "ac2977" },
                { 24, "ac2975" },
            },
            [RAID25_DIFF] = {
                { 1, 45468 }, -- Leggings of Lost Love
                { 2, 45467 }, -- Belt of the Betrayed
                { 3, 45469 }, -- Sif's Promise
                { 4, 45466 }, -- Scale of Fates
                { 5, 45463 }, -- Vulmir, the Northern Tempest
                { 8, "ac3183", nil, nil, AL["Hard Mode"] },
                { 9, 45473 }, -- Embrace of the Gladiator
                { 10, 45474 }, -- Pauldrons of the Combatant
                { 11, 45472 }, -- Warhelm of the Champion
                { 12, 45471 }, -- Fate's Clutch
                { 13, 45570 }, -- Skyforge Crossbow
                { 14, 45470 }, -- Wisdom's Hold
                { 15, 45817 }, -- Thorim's Sigil
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, 45638 }, -- Crown of the Wayward Conqueror
                { 19, 45639 }, -- Crown of the Wayward Protector
                { 20, 45640 }, -- Crown of the Wayward Vanquisher
                { 22, "ac2972" },
                { 23, "ac2974" },
                { 24, "ac3183" },
                { 25, "ac2978" },
                { 26, "ac2976" },
            }
        },
        { -- UlduarFreya
            name = AL["Freya"],
            npcID = 32906,
            EncounterJournalID = 1646,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarC",
            AtlasMapBossID = 11,
            [RAID10_DIFF] = {
                { 1, 45940 }, -- Tunic of the Limber Stalker
                { 2, 45941 }, -- Chestguard of the Lasher
                { 3, 45935 }, -- Ironbark Faceguard
                { 4, 45936 }, -- Legplates of Flourishing Resolve
                { 5, 45934 }, -- Unraveling Reach
                { 9, "ac3179", nil, nil, AL["Hard Mode"] },
                { 10, 45943 }, -- Gloves of Whispering Winds
                { 11, 45945 }, -- Seed of Budding Carnage
                { 12, 45946 }, -- Fire Orchid Signet
                { 13, 45947 }, -- Serilas, Blood Blade of Invar One-Arm
                { 14, 45294 }, -- Petrified Ivy Sprig
                { 15, 45788 }, -- Freya's Sigil
                { 16, 45644 }, -- Gloves of the Wayward Conqueror
                { 17, 45645 }, -- Gloves of the Wayward Protector
                { 18, 45646 }, -- Gloves of the Wayward Vanquisher
                { 20, 46110 }, -- Alchemist's Cache
                { 22, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarFreya10" },
            },
            [RAID25_DIFF] = {
                { 1, 45483 }, -- Boots of the Servant
                { 2, 45482 }, -- Leggings of the Lifetender
                { 3, 45481 }, -- Gauntlets of Ruthless Reprisal
                { 4, 45480 }, -- Nymph Heart Charm
                { 5, 45479 }, -- The Lifebinder
                { 8, "ac3187", nil, nil, AL["Hard Mode"] },
                { 9, 45486 }, -- Drape of the Sullen Goddess
                { 10, 45488 }, -- Leggings of the Enslaved Idol
                { 11, 45487 }, -- Handguards of Revitalization
                { 12, 45485 }, -- Bronze Pendant of the Vanir
                { 13, 45484 }, -- Bladetwister
                { 14, 45613 }, -- Dreambinder
                { 15, 45814 }, -- Freya's Sigil
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, 45653 }, -- Legplates of the Wayward Conqueror
                { 19, 45654 }, -- Legplates of the Wayward Protector
                { 20, 45655 }, -- Legplates of the Wayward Vanquisher
                { 22, 46110 }, -- Alchemist's Cache
                { 24, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarFreya25" },
            }
        },
        { -- UlduarMimiron
            name = AL["Mimiron"],
            npcID = 33350,
            EncounterJournalID = 1647,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarD",
            AtlasMapBossID = 15,
            [RAID10_DIFF] = {
                { 1, 45973 }, -- Stylish Power Cape
                { 2, 45976 }, -- Static Charge Handwraps
                { 3, 45974 }, -- Shoulderguards of Assimilation
                { 4, 45975 }, -- Cable of the Metrognome
                { 5, 45972 }, -- Pulse Baton
                { 9, "ac3180", nil, nil, AL["Hard Mode"] },
                { 10, 45993 }, -- Mimiron's Flight Goggles
                { 11, 45989 }, -- Tempered Mercury Greaves
                { 12, 45982 }, -- Fused Alloy Legplates
                { 13, 45988 }, -- Greaves of the Iron Army
                { 14, 45990 }, -- Fusion Blade
                { 15, 45787 }, -- Mimiron's Sigil
                { 16, 45647 }, -- Helm of the Wayward Conqueror
                { 17, 45648 }, -- Helm of the Wayward Protector
                { 18, 45649 }, -- Helm of the Wayward Vanquisher
                { 20, "ac3180" },
				{ 21, "ac3138" },
				{ 22, "ac2989" },
            },
            [RAID25_DIFF] = {
                { 1, 45493 }, -- Asimov's Drape
                { 2, 45492 }, -- Malleable Steelweave Mantle
                { 3, 45491 }, -- Waistguard of the Creator
                { 4, 45490 }, -- Pandora's Plea
                { 5, 45489 }, -- Insanity's Grip
                { 8, "ac3189", nil, nil, AL["Hard Mode"] },
                { 9, 45496 }, -- Titanskin Cloak
                { 10, 45497 }, -- Crown of Luminescence
                { 11, 45663 }, -- Armbands of Bedlam
                { 12, 45495 }, -- Conductive Seal
                { 13, 45494 }, -- Delirium's Touch
                { 14, 45620 }, -- Starshard Edge
                { 15, 45816 }, -- Mimiron's Sigil
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, 45641 }, -- Gauntlets of the Wayward Conqueror
                { 19, 45642 }, -- Gauntlets of the Wayward Protector
                { 20, 45643 }, -- Gauntlets of the Wayward Vanquisher
                { 22, "ac3189" },
				{ 23, "ac2995" },
				{ 24, "ac3237" },
            }
        },
        { -- UlduarGeneralVezax
            name = AL["General Vezax"],
            NameColor = PURPLE,
            npcID = 33271,
            EncounterJournalID = 1648,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarE",
            AtlasMapBossID = 16,
            [RAID10_DIFF] = {
                { 1, 46014 }, -- Saronite Animus Cloak
                { 2, 46013 }, -- Underworld Mantle
                { 3, 46012 }, -- Vestments of the Piercing Light
                { 4, 46009 }, -- Bindings of the Depths
                { 5, 46346 }, -- Boots of Unsettled Prey
                { 6, 45997 }, -- Gauntlets of the Wretched
                { 7, 46008 }, -- Choker of the Abyss
                { 8, 46015 }, -- Pendant of Endless Despair
                { 9, 46010 }, -- Darkstone Ring
                { 10, 46011 }, -- Shadowbite
                { 11, 45996 }, -- Hoperender
                { 16, "ac3181" },
				{ 17, "ac2996" },
                { 25, "ac3181", nil, nil, AL["Hard Mode"] },
                { 26, 46032 }, -- Drape of the Faceless General
                { 27, 46034 }, -- Leggings of Profound Darkness
                { 28, 46036 }, -- Void Sabre
                { 29, 46035 }, -- Aesuga, Hand of the Ardent Champion
                { 30, 46033 }, -- Tortured Earth
            },
            [RAID25_DIFF] = {
                { 1, 45514 }, -- Mantle of the Unknowing
                { 2, 45508 }, -- Belt of the Darkspeaker
                { 3, 45512 }, -- Grips of the Unbroken
                { 4, 45504 }, -- Darkcore Leggings
                { 5, 45513 }, -- Boots of the Forgotten Depths
                { 6, 45502 }, -- Helm of the Faceless
                { 7, 45505 }, -- Belt of Clinging Hope
                { 8, 45501 }, -- Boots of the Underdweller
                { 9, 45503 }, -- Metallic Loop of the Sufferer
                { 10, 45515 }, -- Ring of the Vacant Eye
                { 11, 45507 }, -- The General's Heart
                { 12, 45509 }, -- Idol of the Corruptor
                { 13, 45145 }, -- Libram of the Sacred Shield
                { 14, 45498 }, -- Lotrafen, Spear of the Damned
                { 15, 45511 }, -- Scepter of Lost Souls
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, "ac3188" },
				{ 19, "ac2997" },
                { 25, "ac3188", nil, nil, AL["Hard Mode"] },
                { 26, 45520 }, -- Handwraps of the Vigilant
                { 27, 45519 }, -- Vestments of the Blind Denizen
                { 28, 45517 }, -- Pendulum of Infinity
                { 29, 45518 }, -- Flare of the Heavens
                { 30, 45516 }, -- Voldrethar, Dark Blade of Oblivion
            }
        },
        { -- UlduarGeneralVezax
            name = AL["Yogg-Saron"],
            NameColor = PURPLE,
            npcID = 33271,
            EncounterJournalID = 1648,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapFile = "UlduarE",
            AtlasMapBossID = 17,
            [RAID10_DIFF] = {
                { 1, 46030 }, -- Treads of the Dragon Council
                { 2, 46019 }, -- Leggings of the Insatiable
                { 3, 46028 }, -- Faceguard of the Eyeless Horror
                { 4, 46022 }, -- Pendant of a Thousand Maws
                { 5, 46021 }, -- Royal Seal of King Llane
                { 6, 46024 }, -- Kingsbane
                { 7, 46016 }, -- Abaddon
                { 8, 46031 }, -- Touch of Madness
                { 9, 46025 }, -- Devotion
                { 10, 46018 }, -- Deliverance
                { 12, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarYoggSaron10" },
                { 16, 45635 }, -- Chestguard of the Wayward Conqueror
                { 17, 45636 }, -- Chestguard of the Wayward Protector
                { 18, 45637 }, -- Chestguard of the Wayward Vanquisher
                { 22, "ac3158", nil, nil, AL["Hard Mode"] },
                { 23, 46068 }, -- Amice of Inconceivable Horror
                { 24, 46095 }, -- Soul-Devouring Cinch
                { 25, 46096 }, -- Signet of Soft Lament
                { 26, 46097 }, -- Caress of Insanity
                { 27, 46067 }, -- Hammer of Crushing Whispers
                { 29, "ac3159", nil, nil, AL["Hard Mode"] },
                { 30, 46312 }, -- Vanquished Clutches of Yogg-Saron
            },
            [RAID25_DIFF] = {
                { 1, 45529 }, -- Shawl of Haunted Memories
                { 2, 45532 }, -- Cowl of Dark Whispers
                { 3, 45523 }, -- Garona's Guise
                { 4, 45524 }, -- Chestguard of Insidious Intent
                { 5, 45531 }, -- Chestguard of the Fallen God
                { 6, 45525 }, -- Godbane Signet
                { 7, 45530 }, -- Sanity's Bond
                { 8, 45522 }, -- Blood of the Old God
                { 9, 45527 }, -- Soulscribe
                { 10, 45521 }, -- Earthshaper
                { 12, "SPECIAL_ACHIEVEMENT", nil, AL["Achievements"], nil, "AC_UlduarYoggSaron25" },
                { 16, 45038 }, -- Fragment of Val'anyr
                { 18, 45656 }, -- Mantle of the Wayward Conqueror
                { 19, 45657 }, -- Mantle of the Wayward Protector
                { 20, 45658 }, -- Mantle of the Wayward Vanquisher
                { 22, "ac3163", nil, nil, AL["Hard Mode"] },
                { 23, 45537 }, -- Treads of the False Oracle
                { 24, 45536 }, -- Legguards of Cunning Deception
                { 25, 45534 }, -- Seal of the Betrayed King
                { 26, 45535 }, -- Show of Faith
                { 27, 45533 }, -- Dark Edge of Depravity
                { 29, "ac3164", nil, nil, AL["Hard Mode"] },
                { 30, 45693 }, -- Mimiron's Head
            }
        },
        { -- Trash
            name = AL["Trash"],
            ExtraList = true,
            [RAID10_DIFF] = {
                { 1, 46341 },	-- Drape of the Spellweaver
				{ 2, 46347 },	-- Cloak of the Dormant Blaze
				{ 3, 46344 },	-- Iceshear Mantle
				{ 4, 46346 },	-- Boots of Unsettled Prey
				{ 5, 46345 },	-- Bracers of Righteous Reformation
				{ 6, 46340 },	-- Adamant Handguards
				{ 8, 46343 },	-- Fervor of the Protectorate
				{ 16, 46339 },	-- Mimiron's Repeater
				{ 17, 46351 },	-- Bloodcrush Cudgel
				{ 18, 46350 },	-- Pillar of Fortitude
				{ 19, 46342 },	-- Golemheart Longbow
            },
            [RAID25_DIFF] = {
                { 1, 45541 },	-- Shroud of Alteration
				{ 2, 45549 },	-- Grips of Chaos
				{ 3, 45547 },	-- Relic Hunter's Cord
				{ 4, 45548 },	-- Belt of the Sleeper
				{ 5, 45543 },	-- Shoulders of Misfortune
				{ 6, 45544 },	-- Leggings of the Tortured Earth
				{ 7, 45542 },	-- Greaves of the Stonewarder
				{ 9, 45540 },	-- Bladebearer's Signet
				{ 10, 45539 },	-- Pendant of Focused Energies
				{ 11, 45538 },	-- Titanstone Pendant
				{ 16, 45605 },	-- Daschal's Bite
            },
        },
        { -- Patterns
            name = AL["Patterns"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 45089 },	-- Plans: Battlelord's Plate Boots
				{ 2, 45088 },	-- Plans: Belt of the Titans
				{ 3, 45092 },	-- Plans: Indestructible Plate Girdle
				{ 4, 45090 },	-- Plans: Plate Girdle of Righteousness
				{ 5, 45093 },	-- Plans: Spiked Deathdealers
				{ 6, 45091 },	-- Plans: Treads of Destiny
				{ 8, 45100 },	-- Pattern: Belt of Arctic Life
				{ 9, 45094 },	-- Pattern: Belt of Dragons
				{ 10, 45096 },	-- Pattern: Blue Belt of Chaos
				{ 11, 45095 },	-- Pattern: Boots of Living Scale
				{ 12, 45101 },	-- Pattern: Boots of Wintry Endurance
				{ 13, 45098 },	-- Pattern: Death-warmed Belt
				{ 14, 45099 },	-- Pattern: Footpads of Silence
				{ 15, 45097 },	-- Pattern: Lightning Grounded Boots
				{ 16, 45104 },	-- Pattern: Cord of the White Dawn
				{ 17, 45102 },	-- Pattern: Sash of Ancient Power
				{ 18, 45105 },	-- Pattern: Savior's Slippers
				{ 19, 45103 },	-- Pattern: Spellslinger's Slippers
				{ 21, 46027 },	-- Formula: Enchant Weapon - Blade Ward
				{ 22, 46348 },	-- Formula: Enchant Weapon - Blood Draining
            },
        },
        T8_SET,
        WOTLK_ULDUAR_AC_TABLE,
    }
}

-- Trial of the Crusader / T9
data["TrialoftheCrusader"] = {
	EncounterJournalID = 757,
	InstanceID = 649,
	MapID = 4722,
    AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TrialOfTheCrusader",
    AtlasMapFile = "TrialOfTheCrusader",
	ContentType = RAID_CONTENT,
    -- LevelRange = {80, 80, 80},
	items = {
		{	--TrialoftheCrusader NorthrendBeasts
			name = AL["The Beasts of Northrend"],
			EncounterJournalID = 1618,
            [RAID10_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1, 47855 },	-- Icehowl Binding
                    { 2, 47857 },	-- Pauldrons of the Glacial Wilds
                    { 3, 47853 },	-- Acidmaw Treads
                    { 4, 47860 },	-- Pauldrons of the Spirit Walker
                    { 5, 47850 },	-- Bracers of the Northern Stalker
                    { 6, 47852 },	-- Dreadscale Bracers
                    { 7, 47851 },	-- Gauntlets of Mounting Anger
                    { 8, 47859 },	-- Belt of the Impaler
                    { 9, 47858 },	-- Girdle of the Frozen Reach
                    { 16, 47849 },	-- Collar of Unending Torment
                    { 17, 47854 },	-- Gormok's Band
                    { 19, 47856 },	-- Scepter of Imprisoned Souls
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                },
                { -- alli
                    { 1,  47617 },	-- Icehowl Cinch
                    { 2,  47613 },	-- Shoulderpads of the Glacial Wilds
                    { 3,  47608 },	-- Acidmaw Boots
                    { 4,  47616 },	-- Shoulderguards of the Spirit Walker
                    { 5,  47610 },	-- Armbands of the Northern Stalker
                    { 6,  47611 },	-- Dreadscale Armguards
                    { 7,  47609 },	-- Gauntlets of Rising Anger
                    { 8,  47615 },	-- Belt of the Frozen Reach
                    { 9,  47614 },	-- Girdle of the Impaler
                    { 16, 47607 },	-- Collar of Ceaseless Torment
                    { 17, 47578 },	-- Carnivorous Band
                    { 19, 47612 },	-- Rod of Imprisoned Souls
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                }
            ),
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47994 },	-- Icehowl Binding
                    { 2,  47996 },	-- Pauldrons of the Glacial Wilds
                    { 3,  47992 },	-- Acidmaw Treads
                    { 4,  47999 },	-- Pauldrons of the Spirit Walker
                    { 5,  47989 },	-- Bracers of the Northern Stalker
                    { 6,  47991 },	-- Dreadscale Bracers
                    { 7,  47990 },	-- Gauntlets of Mounting Anger
                    { 8,  47998 },	-- Belt of the Impaler
                    { 9,  47997 },	-- Girdle of the Frozen Reach
                    { 16, 47988 },	-- Collar of Unending Torment
                    { 17, 47993 },	-- Gormok's Band
                    { 19, 47995 },	-- Scepter of Imprisoned Souls
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                },
                { -- alli
                    { 1,  47921 },	-- Icehowl Cinch
                    { 2,  47923 },	-- Shoulderpads of the Glacial Wilds
                    { 3,  47919 },	-- Acidmaw Boots
                    { 4,  47926 },	-- Shoulderguards of the Spirit Walker
                    { 5,  47916 },	-- Armbands of the Northern Stalker
                    { 6,  47918 },	-- Dreadscale Armguards
                    { 7,  47917 },	-- Gauntlets of Rising Anger
                    { 8,  47924 },	-- Belt of the Frozen Reach
                    { 9,  47925 },	-- Girdle of the Impaler
                    { 16, 47915 },	-- Collar of Ceaseless Torment
                    { 17, 47920 },	-- Carnivorous Band
                    { 19, 47922 },	-- Rod of Imprisoned Souls
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                }
            ),
            [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47257 },	-- Cloak of the Untamed Predator
                    { 2,  47256 },	-- Drape of the Refreshing Winds
                    { 3,  47264 },	-- Flowing Robes of Ascent
                    { 4,  47258 },	-- Belt of the Tenebrous Mist
                    { 5,  47259 },	-- Legwraps of the Broken Beast
                    { 6,  47262 },	-- Boots of the Harsh Winter
                    { 7,  47251 },	-- Cuirass of Cruel Intent
                    { 8,  47265 },	-- Binding of the Ice Burrower
                    { 9,  47254 },	-- Hauberk of the Towering Monstrosity
                    { 10, 47253 },	-- Boneshatter Vambraces
                    { 11, 47263 },	-- Sabatons of the Courageous
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47252 },	-- Ring of the Violent Temperament
                    { 20, 47261 },	-- Barb of Tarasque
                    { 21, 47255 },	-- Stygian Bladebreaker
                    { 22, 47260 },	-- Forlorn Barrier
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                },
                { -- alli
                    { 1,  46970 },	-- Drape of the Untamed Predator
                    { 2,  46976 },	-- Shawl of the Refreshing Winds
                    { 3,  46992 },	-- Flowing Vestments of Ascent
                    { 4,  46972 },	-- Cord of the Tenebrous Mist
                    { 5,  46974 },	-- Leggings of the Broken Beast
                    { 6,  46988 },	-- Boots of the Unrelenting Storm
                    { 7,  46960 },	-- Breastplate of Cruel Intent
                    { 8,  46990 },	-- Belt of the Ice Burrower
                    { 9,  46962 },	-- Chestplate of the Towering Monstrosity
                    { 10, 46961 },	-- Boneshatter Armplates
                    { 11, 46985 },	-- Boots of the Courageous
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 46959 },	-- Band of the Violent Temperment
                    { 20, 46979 },	-- Blade of Tarasque
                    { 21, 46958 },	-- Steel Bladebreaker
                    { 22, 46963 },	-- Crystal Plated Vanguard
                    { 24, "ac3936" },
                    { 25, "ac3797" },
                }
            ),
			[RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47418 },	-- Cloak of the Untamed Predator
                    { 2,  47417 },	-- Drape of the Refreshing Winds
                    { 3,  47425 },	-- Flowing Robes of Ascent
                    { 4,  47419 },	-- Belt of the Tenebrous Mist
                    { 5,  47420 },	-- Legwraps of the Broken Beast
                    { 6,  47423 },	-- Boots of the Harsh Winter
                    { 7,  47412 },	-- Cuirass of Cruel Intent
                    { 8,  47426 },	-- Binding of the Ice Burrower
                    { 9,  47415 },	-- Hauberk of the Towering Monstrosity
                    { 10, 47414 },	-- Boneshatter Vambraces
                    { 11, 47424 },	-- Sabatons of the Courageous
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47413 },	-- Ring of the Violent Temperament
                    { 20, 47422 },	-- Barb of Tarasque
                    { 21, 47416 },	-- Stygian Bladebreaker
                    { 22, 47421 },	-- Forlorn Barrier
                    { 24, "ac3937" },
                    { 25, "ac3813" },
                },
                { -- alli
                    { 1,  46971 },	-- Drape of the Untamed Predator
                    { 2,  46977 },	-- Shawl of the Refreshing Winds
                    { 3,  46993 },	-- Flowing Vestments of Ascent
                    { 4,  46973 },	-- Cord of the Tenebrous Mist
                    { 5,  46975 },	-- Leggings of the Broken Beast
                    { 6,  46989 },	-- Boots of the Unrelenting Storm
                    { 7,  46965 },	-- Breastplate of Cruel Intent
                    { 8,  46991 },	-- Belt of the Ice Burrower
                    { 9,  46968 },	-- Chestplate of the Towering Monstrosity
                    { 10, 46967 },	-- Boneshatter Armplates
                    { 11, 46986 },	-- Boots of the Courageous
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 46966  },	-- Band of the Violent Temperment
                    { 20, 46980  },	-- Blade of Tarasque
                    { 21, 46969  },	-- Steel Bladebreaker
                    { 22, 46964  },	-- Crystal Plated Vanguard
                    { 24, "ac3937" },
                    { 25, "ac3813" },
                }
            ),
		},
        {	--TrialoftheCrusader LordJaraxxus
            name = AL["Lord Jaraxxus"],
            EncounterJournalID = 1619,
            [RAID10_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47861 },	-- Felspark Bracers
                    { 2,  47865 },	-- Legwraps of the Demonic Messenger
                    { 3,  47863 },	-- Belt of the Bloodhoof Emissary
                    { 4,  47866 },	-- Darkspear Ritual Binding
                    { 5,  49236 },	-- Sabatons of Tortured Space
                    { 6,  47867 },	-- Warsong Poacher's Greaves
                    { 7,  47869 },	-- Armplates of the Nether Lord
                    { 8,  47870 },	-- Belt of the Nether Champion
                    { 16, 47872 },	-- Fortitude of the Infernal
                    { 17, 47864 },	-- Pendant of Binding Elements
                    { 18, 47862 },	-- Firestorm Band
                    { 19, 47868 },	-- Planestalker Band
                    { 21, 47871 },	-- Orcish Deathblade
                    { 23, "ac3996" },
                },
                { -- alli
                    { 1,  47663 },	-- Felspark Bindings
                    { 2,  47620 },	-- Leggings of the Demonic Messenger
                    { 3,  47669 },	-- Belt of the Winter Solstice
                    { 4,  47621 },	-- Girdle of the Farseer
                    { 5,  49235 },	-- Boots of Tortured Space
                    { 6,  47683 },	-- Sentinel Scouting Greaves
                    { 7,  47680 },	-- Armguards of the Nether Lord
                    { 8,  47711 },	-- Girdle of the Nether Champion
                    { 16, 47619 },	-- Amulet of Binding Elements
                    { 17, 47679 },	-- Endurance of the Infernal
                    { 18, 47618 },	-- Firestorm Ring
                    { 19, 47703 },	-- Planestalker Signet
                    { 21, 47676 },	-- Dirk of the Night Watch
                    { 23, "ac3996" },
                }
            ),
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  48000 },	-- Felspark Bracers
                    { 2,  48004 },	-- Legwraps of the Demonic Messenger
                    { 3,  48002 },	-- Belt of the Bloodhoof Emissary
                    { 4,  48005 },	-- Darkspear Ritual Binding
                    { 5,  49237 },	-- Sabatons of Tortured Space
                    { 6,  48006 },	-- Warsong Poacher's Greaves
                    { 7,  48008 },	-- Armplates of the Nether Lord
                    { 8,  48009 },	-- Belt of the Nether Champion
                    { 16, 48011 },	-- Fortitude of the Infernal
                    { 17, 48003 },	-- Pendant of Binding Elements
                    { 18, 48001 },	-- Firestorm Band
                    { 19, 48007 },	-- Planestalker Band
                    { 21, 48010 },	-- Orcish Deathblade
                    { 23, "ac3996" },
                },
                { -- alli
                    { 1,  47927 },	-- Felspark Bindings
                    { 2,  47931 },	-- Leggings of the Demonic Messenger
                    { 3,  47929 },	-- Belt of the Winter Solstice
                    { 4,  47932 },	-- Girdle of the Farseer
                    { 5,  49238 },	-- Boots of Tortured Space
                    { 6,  47933 },	-- Sentinel Scouting Greaves
                    { 7,  47935 },	-- Armguards of the Nether Lord
                    { 8,  47937 },	-- Girdle of the Nether Champion
                    { 16, 47930 },	-- Amulet of Binding Elements
                    { 17, 47939 },	-- Endurance of the Infernal
                    { 18, 47928 },	-- Firestorm Ring
                    { 19, 47934 },	-- Planestalker Signet
                    { 21, 47938 },	-- Dirk of the Night Watch
                    { 23, "ac3996" },
                }
            ),
            [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1, 47275 },	-- Pride of the Demon Lord
                    { 2, 47274 },	-- Pants of the Soothing Touch
                    { 3, 47270 },	-- Vest of Calamitous Fate
                    { 4, 47277 },	-- Bindings of the Autumn Willow
                    { 5, 47280 },	-- Wristwraps of Cloudy Omen
                    { 6, 47268 },	-- Bloodbath Girdle
                    { 7, 47279 },	-- Leggings of Failing Light
                    { 8, 47273 },	-- Legplates of Feverish Dedication
                    { 9, 47269 },	-- Dawnbreaker Sabatons
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47272 },	-- Charge of the Eredar
                    { 19, 47278 },	-- Circle of the Darkmender
                    { 20, 47271 },	-- Solace of the Fallen
                    { 21, 47276 },	-- Talisman of Heedless Sins
                    { 23, 47266 },	-- Blood Fury
                    { 24, 47267 },	-- Death's Head Crossbow
                    { 26, "ac3997" },
                },
                { -- alli
                    { 1, 47042 },	-- Pride of the Eredar
                    { 2, 47051 },	-- Leggings of the Soothing Touch
                    { 3, 47000 },	-- Cuirass of Calamitous Fate
                    { 4, 47055 },	-- Bracers of the Autumn Willow
                    { 5, 47056 },	-- Bracers of Cloudy Omen
                    { 6, 46999 },	-- Bloodbath Belt
                    { 7, 47057 },	-- Legplates of Failing Light
                    { 8, 47052 },	-- Legguards of Feverish Dedication
                    { 9, 46997 },	-- Dawnbreaker Greaves
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47043 },	-- Charge of the Demon Lord
                    { 19, 47223 },	-- Ring of the Darkmender
                    { 20, 47041 },	-- Solace of the Defeated
                    { 21, 47053 },	-- Symbol of Transgression
                    { 23, 46996 },	-- Lionhead Slasher
                    { 24, 46994 },	-- Talonstrike
                    { 26, "ac3997" },
                }
            ),
            [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47436 },	-- Pride of the Demon Lord
                    { 2,  47435 },	-- Pants of the Soothing Touch
                    { 3,  47431 },	-- Vest of Calamitous Fate
                    { 4,  47438 },	-- Bindings of the Autumn Willow
                    { 5,  47441 },	-- Wristwraps of Cloudy Omen
                    { 6,  47429 },	-- Bloodbath Girdle
                    { 7,  47440 },	-- Leggings of Failing Light
                    { 8,  47434 },	-- Legplates of Feverish Dedication
                    { 9,  47430 },	-- Dawnbreaker Sabatons
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47433 },	-- Charge of the Eredar
                    { 19, 47439 },	-- Circle of the Darkmender
                    { 20, 47432 },	-- Solace of the Fallen
                    { 21, 47437 },	-- Talisman of Heedless Sins
                    { 23, 47427 },	-- Blood Fury
                    { 24, 47428 },	-- Death's Head Crossbow
                    { 26, "ac3997" },
                },
                { -- alli
                    { 1,  47063 },	-- Pride of the Eredar
                    { 2,  47062 },	-- Leggings of the Soothing Touch
                    { 3,  47004 },	-- Cuirass of Calamitous Fate
                    { 4,  47066 },	-- Bracers of the Autumn Willow
                    { 5,  47068 },	-- Bracers of Cloudy Omen
                    { 6,  47002 },	-- Bloodbath Belt
                    { 7,  47067 },	-- Legplates of Failing Light
                    { 8,  47061 },	-- Legguards of Feverish Dedication
                    { 9,  47003 },	-- Dawnbreaker Greaves
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47060 },	-- Charge of the Demon Lord
                    { 19, 47224 },	-- Ring of the Darkmender
                    { 20, 47059 },	-- Solace of the Defeated
                    { 21, 47064 },	-- Symbol of Transgression
                    { 23, 47001 },	-- Lionhead Slasher
                    { 24, 46995 },	-- Talonstrike
                    { 26, "ac3997" },
                }
            ),
        },
        {	--TrialoftheCrusader FactionChampions
            name = AL["Faction Champions"],
            [RAID10_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47873 },	-- Sunreaver Magus' Sandals
                    { 2,  47878 },	-- Sunreaver Assassin's Gloves
                    { 3,  47875 },	-- Sunreaver Ranger's Helm
                    { 4,  47876 },	-- Sunreaver Champion's Faceplate
                    { 5,  47877 },	-- Sunreaver Defender's Pauldrons
                    { 7,  47880 },	-- Binding Stone
                    { 8,  47882 },	-- Eitrigg's Oath
                    { 9,  47879 },	-- Fetish of Volatile Power
                    { 10, 47881 },	-- Vengeance of the Forsaken
                    { 16, 47874 },	-- Sunreaver Disciple's Blade
                    { 18, "ac3798" },
                },
                { -- alli
                    { 1,  47721 },	-- Sandals of the Silver Magus
                    { 2,  47719 },	-- Gloves of the Silver Assassin
                    { 3,  47718 },	-- Helm of the Silver Ranger
                    { 4,  47717 },	-- Faceplate of the Silver Champion
                    { 5,  47720 },	-- Pauldrons of the Silver Defender
                    { 7,  47728 },	-- Binding Light
                    { 8,  47727 },	-- Fervor of the Frostborn
                    { 9,  47726 },	-- Talisman of Volatile Power
                    { 10, 47725 },	-- Victor's Call
                    { 16, 47724 },	-- Blade of the Silver Disciple
                    { 18, "ac3798" },
                }
            ),
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  48012 },	-- Sunreaver Magus' Sandals
                    { 2,  48017 },	-- Sunreaver Assassin's Gloves
                    { 3,  48014 },	-- Sunreaver Ranger's Helm
                    { 4,  48015 },	-- Sunreaver Champion's Faceplate
                    { 5,  48016 },	-- Sunreaver Defender's Pauldrons
                    { 7,  48019 },	-- Binding Stone
                    { 8,  48021 },	-- Eitrigg's Oath
                    { 9,  48018 },	-- Fetish of Volatile Power
                    { 10, 48020 },	-- Vengeance of the Forsaken
                    { 16, 48013 },	-- Sunreaver Disciple's Blade
                    { 18, "ac3798" },
                },
                { -- alli
                    { 1,  47940 },	-- Sandals of the Silver Magus
                    { 2,  47945 },	-- Gloves of the Silver Assassin
                    { 3,  47942 },	-- Helm of the Silver Ranger
                    { 4,  47943 },	-- Faceplate of the Silver Champion
                    { 5,  47944 },	-- Pauldrons of the Silver Defender
                    { 7,  47947 },	-- Binding Light
                    { 8,  47949 },	-- Fervor of the Frostborn
                    { 9,  47946 },	-- Talisman of Volatile Power
                    { 10, 47948 },	-- Victor's Call
                    { 16, 47941 },	-- Blade of the Silver Disciple
                    { 18, "ac3798" },
                }
            ),
            [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47291 },	-- Shroud of Displacement
                    { 2,  47286 },	-- Belt of Biting Cold
                    { 3,  47293 },	-- Sandals of the Mourning Widow
                    { 4,  47292 },	-- Robes of the Shattered Fellowship
                    { 5,  47284 },	-- Icewalker Treads
                    { 6,  47281 },	-- Bracers of the Silent Massacre
                    { 7,  47289 },	-- Leggings of Concealed Hatred
                    { 8,  47295 },	-- Sabatons of Tremoring Earth
                    { 9,  47288 },	-- Chestplate of the Frostwolf Hero
                    { 10, 47294 },	-- Bracers of the Broken Bond
                    { 11, 47283 },	-- Belt of Bloodied Scars
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47282 },	-- Band of Callous Aggression
                    { 19, 47290 },	-- Juggernaut's Vitality
                    { 21, 47285 },	-- Dual-blade Butcher
                    { 22, 47287 },	-- Bastion of Resolve
                },
                { -- alli
                    { 1,  47089 },	-- Cloak of Displacement
                    { 2,  47081 },	-- Cord of Biting Cold
                    { 3,  47092 },	-- Boots of the Mourning Widow
                    { 4,  47094 },	-- Vestments of the Shattered Fellowship
                    { 5,  47071 },	-- Treads of the Icewalker
                    { 6,  47073 },	-- Bracers of the Untold Massacre
                    { 7,  47083 },	-- Legguards of Concealed Hatred
                    { 8,  47090 },	-- Boots of Tremoring Earth
                    { 9,  47082 },	-- Chestplate of the Frostborn Hero
                    { 10, 47093 },	-- Vambraces of the Broken Bond
                    { 11, 47072 },	-- Girdle of Bloodied Scars
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47070 },	-- Ring of Callous Aggression
                    { 19, 47080 },	-- Satrina's Impeding Scarab
                    { 21, 47069 },	-- Justicebringer
                    { 22, 47079 },	-- Bastion of Purity
                }
            ),
            [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47452 },	-- Shroud of Displacement
                    { 2,  47447 },	-- Belt of Biting Cold
                    { 3,  47454 },	-- Sandals of the Mourning Widow
                    { 4,  47453 },	-- Robes of the Shattered Fellowship
                    { 5,  47445 },	-- Icewalker Treads
                    { 6,  47442 },	-- Bracers of the Silent Massacre
                    { 7,  47450 },	-- Leggings of Concealed Hatred
                    { 8,  47456 },	-- Sabatons of Tremoring Earth
                    { 9,  47449 },	-- Chestplate of the Frostwolf Hero
                    { 10, 47455 },	-- Bracers of the Broken Bond
                    { 11, 47444 },	-- Belt of Bloodied Scars
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47443 },	-- Band of Callous Aggression
                    { 19, 47451 },	-- Juggernaut's Vitality
                    { 21, 47446 },	-- Dual-blade Butcher
                    { 22, 47448 },	-- Bastion of Resolve
                },
                { -- alli
                    { 1,  47095 },	-- Cloak of Displacement
                    { 2,  47084 },	-- Cord of Biting Cold
                    { 3,  47097 },	-- Boots of the Mourning Widow
                    { 4,  47096 },	-- Vestments of the Shattered Fellowship
                    { 5,  47077 },	-- Treads of the Icewalker
                    { 6,  47074 },	-- Bracers of the Untold Massacre
                    { 7,  47087 },	-- Legguards of Concealed Hatred
                    { 8,  47099 },	-- Boots of Tremoring Earth
                    { 9,  47086 },	-- Chestplate of the Frostborn Hero
                    { 10, 47098 },	-- Vambraces of the Broken Bond
                    { 11, 47076 },	-- Girdle of Bloodied Scars
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47075 },	-- Ring of Callous Aggression
                    { 19, 47088 },	-- Satrina's Impeding Scarab
                    { 21, 47078 },	-- Justicebringer
                    { 22, 47085 },	-- Bastion of Purity
                }
            ),
        },
        {	--TrialoftheCrusader TwinValkyrs
            name = AL["The Twin Val'kyr"],
            EncounterJournalID = 1622,
            [RAID10_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47889 },	-- Looming Shadow Wraps
                    { 2,  49232 },	-- Sandals of the Grieving Soul
                    { 3,  47891 },	-- Helm of the High Mesa
                    { 4,  47887 },	-- Vest of Shifting Shadows
                    { 5,  47893 },	-- Sen'jin Ritualist Gloves
                    { 6,  47885 },	-- Greaves of the Lingering Vortex
                    { 8,  47890 },	-- Darkbane Amulet
                    { 9,  47888 },	-- Band of the Twin Val'kyr
                    { 10, 47913 },	-- Lightbane Focus
                    { 16, 47886 },	-- Nemesis Blade
                    { 17, 47884 },	-- Edge of Agony
                    { 18, 47892 },	-- Illumination
                    { 19, 47883 },	-- Widebarrel Flintlock
                    { 21, "ac3799" },
                },
                { -- alli
                    { 1,  47745 },	-- Gloves of Looming Shadow
                    { 2,  49231 },	-- Boots of the Grieving Soul
                    { 3,  47746 },	-- Helm of the Snowy Grotto
                    { 4,  47739 },	-- Armor of Shifting Shadows
                    { 5,  47744 },	-- Gloves of the Azure Prophet
                    { 6,  47738 },	-- Sabatons of the Lingering Vortex
                    { 8,  47747 },	-- Darkbane Pendant
                    { 9,  47700 },	-- Loop of the Twin Val'kyr
                    { 10, 47742 },	-- Chalice of Benedictus
                    { 16, 47736 },	-- Icefall Blade
                    { 17, 47737 },	-- Reckoning
                    { 18, 47743 },	-- Enlightenment
                    { 19, 47740 },	-- The Diplomat
                    { 21, "ac3799" },
                }
            ),
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  48028 },	-- Looming Shadow Wraps
                    { 2,  49233 },	-- Sandals of the Grieving Soul
                    { 3,  48034 },	-- Helm of the High Mesa
                    { 4,  48026 },	-- Vest of Shifting Shadows
                    { 5,  48038 },	-- Sen'jin Ritualist Gloves
                    { 6,  48024 },	-- Greaves of the Lingering Vortex
                    { 8,  48030 },	-- Darkbane Amulet
                    { 9,  48027 },	-- Band of the Twin Val'kyr
                    { 10, 48032 },	-- Lightbane Focus
                    { 16, 48025 },	-- Nemesis Blade
                    { 17, 48023 },	-- Edge of Agony
                    { 18, 48036 },	-- Illumination
                    { 19, 48022 },	-- Widebarrel Flintlock
                    { 21, "ac3799" },
                },
                { -- alli
                    { 1,  47956 },	-- Gloves of Looming Shadow
                    { 2,  49234 },	-- Boots of the Grieving Soul
                    { 3,  47959 },	-- Helm of the Snowy Grotto
                    { 4,  47954 },	-- Armor of Shifting Shadows
                    { 5,  47961 },	-- Gloves of the Azure Prophet
                    { 6,  47952 },	-- Sabatons of the Lingering Vortex
                    { 8,  47957 },	-- Darkbane Pendant
                    { 9,  47955 },	-- Loop of the Twin Val'kyr
                    { 10, 47958 },	-- Chalice of Benedictus
                    { 16, 47953 },	-- Icefall Blade
                    { 17, 47951 },	-- Reckoning
                    { 18, 47960 },	-- Enlightenment
                    { 19, 47950 },	-- The Diplomat
                    { 21, "ac3799" },
                }
            ),
            [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47301 },	-- Skyweaver Vestments
                    { 2,  47306 },	-- Dark Essence Bindings
                    { 3,  47308 },	-- Belt of Pale Thorns
                    { 4,  47299 },	-- Belt of the Pitiless Killer
                    { 5,  47296 },	-- Greaves of Ruthless Judgment
                    { 6,  47310 },	-- Chestplate of the Frozen Lake
                    { 7,  47298 },	-- Armguards of the Shieldmaiden
                    { 8,  47304 },	-- Legplates of Ascension
                    { 10, 47307 },	-- Cry of the Val'kyr
                    { 11, 47305 },	-- Legionnaire's Gorget
                    { 12, 47297 },	-- The Executioner's Vice
                    { 13, 47303 },	-- Death's Choice
                    { 14, 47309 },	-- Mystifying Charm
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47300 },	-- Gouge of the Frigid Heart
                    { 19, 47302 },	-- Twin's Pact
                    { 21, "ac3815" },
                },
                { -- alli
                    { 1,  47126 },	-- Skyweaver Robes
                    { 2,  47141 },	-- Bindings of Dark Essence
                    { 3,  47107 },	-- Belt of the Merciless Killer
                    { 4,  47140 },	-- Cord of Pale Thorns
                    { 5,  47106 },	-- Sabatons of Ruthless Judgment
                    { 6,  47142 },	-- Breastplate of the Frozen Lake
                    { 7,  47108 },	-- Bracers of the Shieldmaiden
                    { 8,  47121 },	-- Legguards of Ascension
                    { 10, 47116 },	-- The Arbiter's Muse
                    { 11, 47105 },	-- The Executioner's Malice
                    { 12, 47139 },	-- Wail of the Val'kyr
                    { 13, 47115 },	-- Death's Verdict
                    { 14, 47138 },	-- Chalice of Searing Light
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47104 },	-- Twin Spike
                    { 19, 47114 },	-- Lupine Longstaff
                    { 21, "ac3815" },
                }
            ),
            [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47462 },	-- Skyweaver Vestments
                    { 2,  47467 },	-- Dark Essence Bindings
                    { 3,  47469 },	-- Belt of Pale Thorns
                    { 4,  47460 },	-- Belt of the Pitiless Killer
                    { 5,  47457 },	-- Greaves of Ruthless Judgment
                    { 6,  47471 },	-- Chestplate of the Frozen Lake
                    { 7,  47459 },	-- Armguards of the Shieldmaiden
                    { 8,  47465 },	-- Legplates of Ascension
                    { 10, 47468 },	-- Cry of the Val'kyr
                    { 11, 47466 },	-- Legionnaire's Gorget
                    { 12, 47458 },	-- The Executioner's Vice
                    { 13, 47464 },	-- Death's Choice
                    { 14, 47470 },	-- Mystifying Charm
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47461 },	-- Gouge of the Frigid Heart
                    { 19, 47463 },	-- Twin's Pact
                    { 21, "ac3815" },
                },
                { -- alli
                    { 1,  47129 },	-- Skyweaver Robes
                    { 2,  47143 },	-- Bindings of Dark Essence
                    { 3,  47112 },	-- Belt of the Merciless Killer
                    { 4,  47145 },	-- Cord of Pale Thorns
                    { 5,  47109 },	-- Sabatons of Ruthless Judgment
                    { 6,  47147 },	-- Breastplate of the Frozen Lake
                    { 7,  47111 },	-- Bracers of the Shieldmaiden
                    { 8,  47132 },	-- Legguards of Ascension
                    { 10, 47133 },	-- The Arbiter's Muse
                    { 11, 47110 },	-- The Executioner's Malice
                    { 12, 47144 },	-- Wail of the Val'kyr
                    { 13, 47131 },	-- Death's Verdict
                    { 14, 47146 },	-- Chalice of Searing Light
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47113 },	-- Twin Spike
                    { 19, 47130 },	-- Lupine Longstaff
                    { 21, "ac3815" },
                }
            ),
        },
        {	--TrialoftheCrusader Anubarak
            name = AL["Anub'arak"],
            EncounterJournalID = 1623,
            [RAID10_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47906 },	-- Robes of the Sleepless
                    { 2,  47909 },	-- Belt of the Eternal
                    { 3,  47904 },	-- Shoulderpads of the Snow Bandit
                    { 4,  47897 },	-- Helm of the Crypt Lord
                    { 5,  47901 },	-- Pauldrons of the Shadow Hunter
                    { 6,  47896 },	-- Stoneskin Chestplate
                    { 7,  47902 },	-- Legplates of Redeemed Blood
                    { 8,  47908 },	-- Sunwalker Legguards
                    { 10, 47899 },	-- Ardent Guard
                    { 11, 47903 },	-- Forsaken Bonecarver
                    { 12, 47898 },	-- Frostblade Hatchet
                    { 13, 47894 },	-- Mace of the Earthborn Chieftain
                    { 14, 47905 },	-- Blackhorn Bludgeon
                    { 16, 47911 },	-- Anguish
                    { 17, 47900 },	-- Perdition
                    { 18, 47910 },	-- Aegis of the Coliseum
                    { 19, 47895 },	-- Pride of the Kor'kron
                    { 20, 47907 },	-- Darkmaw Crossbow
                    { 24, "ac3917" },
                    { 25, "ac3800" },
                },
                { -- alli
                    { 1,  47838 },	-- Vestments of the Sleepless
                    { 2,  47837 },	-- Cinch of the Undying
                    { 3,  47832 },	-- Spaulders of the Snow Bandit
                    { 4,  47813 },	-- Helmet of the Crypt Lord
                    { 5,  47829 },	-- Pauldrons of the Timeless Hunter
                    { 6,  47811 },	-- Chestguard of the Warden
                    { 7,  47836 },	-- Legplates of the Immortal Spider
                    { 8,  47830 },	-- Legplates of the Silver Hand
                    { 10, 47810 },	-- Crusader's Glory
                    { 11, 47814 },	-- Westfall Saber
                    { 12, 47808 },	-- The Lion's Maw
                    { 13, 47809 },	-- Argent Resolve
                    { 14, 47816 },	-- The Grinder
                    { 16, 47834 },	-- Fordragon Blades
                    { 17, 47815 },	-- Cold Convergence
                    { 18, 47835 },	-- Bulwark of the Royal Guard
                    { 19, 47812 },	-- Vigilant Ward
                    { 20, 47741 },	-- Baelgun's Heavy Crossbow
                    { 24, "ac3917" },
                    { 25, "ac3800" },
                }
            ),
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  48051 },	-- Robes of the Sleepless
                    { 2,  48054 },	-- Belt of the Eternal
                    { 3,  48049 },	-- Shoulderpads of the Snow Bandit
                    { 4,  48042 },	-- Helm of the Crypt Lord
                    { 5,  48046 },	-- Pauldrons of the Shadow Hunter
                    { 6,  48041 },	-- Stoneskin Chestplate
                    { 7,  48047 },	-- Legplates of Redeemed Blood
                    { 8,  48053 },	-- Sunwalker Legguards
                    { 10, 48044 },	-- Ardent Guard
                    { 11, 48048 },	-- Forsaken Bonecarver
                    { 12, 48043 },	-- Frostblade Hatchet
                    { 13, 48039 },	-- Mace of the Earthborn Chieftain
                    { 14, 48050 },	-- Blackhorn Bludgeon
                    { 16, 48056 },	-- Anguish
                    { 17, 48045 },	-- Perdition
                    { 18, 48055 },	-- Aegis of the Coliseum
                    { 19, 48040 },	-- Pride of the Kor'kron
                    { 20, 48052 },	-- Darkmaw Crossbow
                    { 24, "ac3917" },
                    { 25, "ac3918" },
                    { 26, "ac3800" },
                },
                { -- alli
                    { 1,  47974 },	-- Vestments of the Sleepless
                    { 2,  47977 },	-- Cinch of the Undying
                    { 3,  47972 },	-- Spaulders of the Snow Bandit
                    { 4,  47965 },	-- Headpiece of the Crypt Lord
                    { 5,  47969 },	-- Pauldrons of the Timeless Hunter
                    { 6,  47964 },	-- Chestguard of the Warden
                    { 7,  47976 },	-- Legplates of the Immortal Spider
                    { 8,  47970 },	-- Legplates of the Silver Hand
                    { 10, 47967 },	-- Crusader's Glory
                    { 11, 47971 },	-- Westfall Saber
                    { 12, 47966 },	-- The Lion's Maw
                    { 13, 47962 },	-- Argent Resolve
                    { 14, 47973 },	-- The Grinder
                    { 16, 47979 },	-- Fordragon Blades
                    { 17, 47968 },	-- Cold Convergence
                    { 18, 47978 },	-- Bulwark of the Royal Guard
                    { 19, 47963 },	-- Vigilant Ward
                    { 20, 47975 },	-- Baelgun's Heavy Crossbow
                    { 24, "ac3917" },
                    { 25, "ac3918" },
                    { 26, "ac3800" },
                }
            ),
            [RAID25_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47328 },	-- Maiden's Adoration
                    { 2,  47320 },	-- Might of the Nerub
                    { 3,  47324 },	-- Bindings of the Ashen Saint
                    { 4,  47326 },	-- Handwraps of the Lifeless Touch
                    { 5,  47317 },	-- Breeches of the Deepening Void
                    { 6,  47321 },	-- Boots of the Icy Floe
                    { 7,  47313 },	-- Armbands of Dark Determination
                    { 8,  47318 },	-- Leggings of the Awakening
                    { 9,  47325 },	-- Cuirass of Flowing Elements
                    { 10, 47311 },	-- Waistguard of Deathly Dominion
                    { 11, 47319 },	-- Leggings of the Lurking Threat
                    { 12, 47330 },	-- Gauntlets of Bitter Reprisal
                    { 13, 47323 },	-- Girdle of the Forgotten Martyr
                    { 14, 47312 },	-- Greaves of the Saronite Citadel
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47315 },	-- Band of the Traitor King
                    { 19, 47327 },	-- Lurid Manifestation
                    { 20, 47316 },	-- Reign of the Dead
                    { 22, 47314 },	-- Hellscream Slicer
                    { 23, 47322 },	-- Suffering's End
                    { 24, 47329 },	-- Hellion Glaive
                    { 26, "ac3916" },
                    { 27, "ac3816" },
                },
                { -- alli
                    { 1,  47225 },	-- Maiden's Favor
                    { 2,  47183 },	-- Strength of the Nerub
                    { 3,  47203 },	-- Armbands of the Ashen Saint
                    { 4,  47235 },	-- Gloves of the Lifeless Touch
                    { 5,  47187 },	-- Leggings of the Deepening Void
                    { 6,  47194 },	-- Footpads of the Icy Floe
                    { 7,  47151 },	-- Bracers of Dark Determination
                    { 8,  47186 },	-- Legwraps of the Awakening
                    { 9,  47204 },	-- Chestguard of Flowing Elements
                    { 10, 47152 },	-- Belt of Deathly Dominion
                    { 11, 47184 },	-- Legguards of the Lurking Threat
                    { 12, 47234 },	-- Gloves of Bitter Reprisal
                    { 13, 47195 },	-- Belt of the Forgotten Martyr
                    { 14, 47150 },	-- Greaves of the 7th Legion
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47054 },	-- Band of Deplorable Violence
                    { 19, 47149 },	-- Signet of the Traitor King
                    { 20, 47182 },	-- Reign of the Unliving
                    { 22, 47148 },	-- Stormpike Cleaver
                    { 23, 47193 },	-- Misery's End
                    { 24, 47233 },	-- Archon Glaive
                    { 26, "ac3916" },
                    { 27, "ac3816" },
                }
            ),
            [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47490 },	-- Maiden's Adoration
                    { 2,  47481 },	-- Might of the Nerub
                    { 3,  47485 },	-- Bindings of the Ashen Saint
                    { 4,  47487 },	-- Handwraps of the Lifeless Touch
                    { 5,  47478 },	-- Breeches of the Deepening Void
                    { 6,  47482 },	-- Boots of the Icy Floe
                    { 7,  47474 },	-- Armbands of Dark Determination
                    { 8,  47479 },	-- Leggings of the Awakening
                    { 9,  47486 },	-- Cuirass of Flowing Elements
                    { 10, 47472 },	-- Waistguard of Deathly Dominion
                    { 11, 47480 },	-- Leggings of the Lurking Threat
                    { 12, 47492 },	-- Gauntlets of Bitter Reprisal
                    { 13, 47484 },	-- Girdle of the Forgotten Martyr
                    { 14, 47473 },	-- Greaves of the Saronite Citadel
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47476 },	-- Band of the Traitor King
                    { 19, 47489 },	-- Lurid Manifestation
                    { 20, 47477 },	-- Reign of the Dead
                    { 22, 47475 },	-- Hellscream Slicer
                    { 23, 47483 },	-- Suffering's End
                    { 24, 47491 },	-- Hellion Glaive
                    { 26, "ac3916" },
                    { 27, "ac3812" },
                    { 28, "ac3816" },
                },
                { -- alli
                    { 1,  47238 },	-- Maiden's Favor / Maiden's Adoration
                    { 2,  47192 },	-- Strength of the Nerub / Might of the Nerub
                    { 3,  47208 },	-- Armbands of the Ashen Saint / Bindings of the Ashen Saint
                    { 4,  47236 },	-- Gloves of the Lifeless Touch / Handwraps of the Lifeless Touch
                    { 5,  47189 },	-- Leggings of the Deepening Void / Breeches of the Deepening Void
                    { 6,  47205 },	-- Footpads of the Icy Floe / Boots of the Icy Floe
                    { 7,  47155 },	-- Bracers of Dark Determination / Armbands of Dark Determination
                    { 8,  47190 },	-- Legwraps of the Awakening / Leggings of the Awakening
                    { 9,  47209 },	-- Chestguard of Flowing Elements / Cuirass of Flowing Elements
                    { 10, 47153 },	-- Belt of Deathly Dominion / Waistguard of Deathly Dominion
                    { 11, 47191 },	-- Legguards of the Lurking Threat / Leggings of the Lurking Threat
                    { 12, 47240 },	-- Gloves of Bitter Reprisal / Gauntlets of Bitter Reprisal
                    { 13, 47207 },	-- Belt of the Forgotten Martyr / Girdle of the Forgotten Martyr
                    { 14, 47154 },	-- Greaves of the 7th Legion / Greaves of the Saronite Citadel
                    { 16, 47242 },	-- Trophy of the Crusade
                    { 18, 47237 },	-- Band of Deplorable Violence / Band of the Traitor King
                    { 19, 47157 },	-- Signet of the Traitor King / Lurid Manifestation
                    { 20, 47188 },	-- Reign of the Unliving / Reign of the Dead
                    { 22, 47156 },	-- Stormpike Cleaver / Hellscream Slicer
                    { 23, 47206 },	-- Misery's End / Suffering's End
                    { 24, 47239 },	-- Archon Glaive / Hellion Glaive
                    { 26, "ac3916" },
                    { 27, "ac3812" },
                    { 28, "ac3816" },
                }
            ),
        },
        {	-- Argent Crusade Tribute Chest
            name = format(AL["Argent Crusade Tribute Chest"]),
            --EncounterJournalID = 1623,
            [RAID10H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    headerLines = {1, 3, 8, 10},
                    { 1, "INV_Box_01", nil, format(AL["%s Attempts left"], "1-24"), nil },
                    { 2, 47242, [ATLASLOOT_IT_AMOUNT1] = 2 },	-- Trophy of the Crusade
                    { 17, 47556 },	-- Crusader Orb
                    { 3, "INV_Box_01", nil, format(AL["%s Attempts left"], "25-44"), format(AL["Includes the loot from %s"], "1-24"), },
                    { 4, 48703 }, --  The Facebreaker
                    { 5, 48699 }, --  Blood and Glory
                    { 6, 48693 }, --  Heartsmasher
                    { 7, 48701 }, --  Spellharvest
                    { 19, 48697 }, -- Frenzystrike Longbow
                    { 20, 48705 }, -- Attrition
                    { 21, 48695 }, -- Mor'kosh
                    { 8, "INV_Box_01", nil, format(AL["%s Attempts left"], "45-49"), format(AL["Includes the loot from %s"], "1-44") },
                    { 9, 47242, [ATLASLOOT_IT_AMOUNT1] = 2 },	-- Trophy of the Crusade
                    { 10, "INV_Box_01", nil, format(AL["%s Attempts left"], "50"), format(AL["Includes the loot from %s"], "1-49") },
                    { 11, 49046 }, -- Swift Horde Wolf
                    { 12, 48669 }, -- Cloak of the Triumphant Combatant
                    { 13, 48668 }, -- Cloak of Serrated Blades
                    { 14, 48670 }, -- Cloak of the Unflinching Guardian
                    { 27, 48666 }, -- Drape of the Sunreavers
                    { 28, 48667 }, -- Shawl of the Devout Crusader
                },
                { -- alli
                    headerLines = {1, 3, 8, 10},
                    { 1, "INV_Box_01", nil, format(AL["%s Attempts left"], "1-24"), nil },
                    { 2, 47242, [ATLASLOOT_IT_AMOUNT1] = 2 },	-- Trophy of the Crusade
                    { 17, 47556 },	-- Crusader Orb
                    { 3, "INV_Box_01", nil, format(AL["%s Attempts left"], "25-44"), format(AL["Includes the loot from %s"], "1-24"), },
                    { 4, 48712 }, --  The Spinebreaker
                    { 5, 48714 }, --  Honor of the Fallen
                    { 6, 48709 }, --  Heartcrusher
                    { 7, 48708 }, --  Spellstorm Blade
                    { 19, 48711 }, -- Rhok'shalla the Shadow's Bane
                    { 20, 48710 }, --  Paragon's Breadth
                    { 21, 48713 }, --  Lothar's Edge
                    { 8, "INV_Box_01", nil, format(AL["%s Attempts left"], "45-49"), format(AL["Includes the loot from %s"], "1-44") },
                    { 9, 47242, [ATLASLOOT_IT_AMOUNT1] = 2 },	-- Trophy of the Crusade
                    { 10, "INV_Box_01", nil, format(AL["%s Attempts left"], "50"), format(AL["Includes the loot from %s"], "1-49") },
                    { 11, 49044 }, -- Swift Alliance Steed
                    { 12, 48674 }, -- Cloak of the Victorious Combatant
                    { 13, 48673 }, -- Cloak of the Silver Covenant
                    { 14, 48675 }, -- Cloak of the Unmoving Guardian
                    { 27, 48671 }, -- Drape of Bitter Incantation
                    { 28, 48672 }, -- Shawl of Fervent Crusader
                }
            ),
            [RAID25H_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    headerLines = {1, 4, 9, 12},
                    { 1, "INV_Box_01", nil, format(AL["%s Attempts left"], "1-24"), nil },
                    { 2, 47557 }, -- Regalia of the Grand Conqueror
                    { 3, 47558 }, -- Regalia of the Grand Protector
                    { 17, 47559 }, -- Regalia of the Grand Vanquisher
                    { 4, "INV_Box_01", nil, format(AL["%s Attempts left"], "25-44"), format(AL["Includes the loot from %s"], "1-24"), },
                    { 5, 47513 }, -- Orgrim's Deflector
                    { 6, 47528 }, -- Cudgel of the Damned
                    { 7, 47518 }, -- Mortalis
                    { 8, 47520 }, -- Grievance
                    { 20, 47523 }, -- Fezzik's Autocannon
                    { 21, 47525 }, -- Sufferance
                    { 22, 47516 }, -- Fleshrender
                    { 9, "INV_Box_01", nil, format(AL["%s Attempts left"], "45-49"), format(AL["Includes the loot from %s"], "1-44") },
                    { 10, 47557 }, -- Regalia of the Grand Conqueror
                    { 11, 47558 }, -- Regalia of the Grand Protector
                    { 25, 47559 }, -- Regalia of the Grand Vanquisher
                    { 12, "INV_Box_01", nil, format(AL["%s Attempts left"], "50"), format(AL["Includes the loot from %s"], "1-49") },
                    { 13, 47548 }, -- Garrosh's Rage
                    { 14, 47546 }, -- Sylvanas' Cunning
                    { 15, 47550 }, -- Cairne's Endurance
                    { 28, 49098 }, -- Crusader's Black Warhorse
                    { 29, 47551 }, -- Aethas' Intensity
                    { 30, 47554 }, -- Lady Liadrin's Conviction
                },
                { -- alli
                    headerLines = {1, 4, 9, 12},
                    { 1, "INV_Box_01", nil, format(AL["%s Attempts left"], "1-24"), nil },
                    { 2, 47557 }, -- Regalia of the Grand Conqueror
                    { 3, 47558 }, -- Regalia of the Grand Protector
                    { 17, 47559 }, -- RRegalia of the Grand Vanquisher
                    { 4, "INV_Box_01", nil, format(AL["%s Attempts left"], "25-44"), format(AL["Includes the loot from %s"], "1-24"), },
                    { 5, 47506 }, -- Silverwing Defender
                    { 6, 47526 }, -- Remorseless
                    { 7, 47517 }, -- Blade of the Unbroken Covenant
                    { 8, 47519 }, -- Catastrophe
                    { 20, 47521 }, -- BRK-1000
                    { 21, 47524 }, -- Clemency
                    { 22, 47515 }, -- Decimation
                    { 9, "INV_Box_01", nil, format(AL["%s Attempts left"], "45-49"), format(AL["Includes the loot from %s"], "1-44") },
                    { 10, 47557 }, -- Regalia of the Grand Conqueror
                    { 11, 47558 }, -- Regalia of the Grand Protector
                    { 25, 47559 }, -- Regalia of the Grand Vanquisher
                    { 12, "INV_Box_01", nil, format(AL["%s Attempts left"], "50"), format(AL["Includes the loot from %s"], "1-49") },
                    { 13, 47547 }, -- Varian's Furor
                    { 14, 47545 }, -- Vereesa's Dexterity
                    { 15, 47549 }, -- Magni's Resolution
                    { 28, 49096 }, -- Crusader's White Warhorse
                    { 29, 47552 }, -- Jaina's Radiance
                    { 30, 47553 }, -- Bolvar's Devotion
                }
            ),
        },
        {	--TrialoftheCrusader NorthrendBeasts
            name = AL["Patterns"],
            ExtraList = true,
            [NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
                { -- horde
                    { 1,  47640 },	-- Plans: Breastplate of the White Knight (p2 450)
                    { 2,  47641 },	-- Plans: Saronite Swordbreakers (p2 450)
                    { 3,  47642 },	-- Plans: Sunforged Bracers (p2 450)
                    { 4,  47643 },	-- Plans: Sunforged Breastplate (p2 450)
                    { 5,  47644 },	-- Plans: Titanium Razorplate (p2 450)
                    { 6,  47645 },	-- Plans: Titanium Spikeguards (p2 450)
                    { 8,  47646 },	-- Pattern: Black Chitin Bracers (p7 450)
                    { 9,  47647 },	-- Pattern: Bracers of Swift Death (p7 450)
                    { 10, 47648 },	-- Pattern: Crusader's Dragonscale Bracers (p7 450)
                    { 11, 47649 },	-- Pattern: Crusader's Dragonscale Breastplate (p7 450)
                    { 12, 47650 },	-- Pattern: Ensorcelled Nerubian Breastplate (p7 450)
                    { 13, 47651 },	-- Pattern: Knightbane Carapace (p7 450)
                    { 14, 47652 },	-- Pattern: Lunar Eclipse Chestguard (p7 450)
                    { 15, 47653 },	-- Pattern: Moonshadow Armguards (p7 450)
                    { 16, 47639 },	-- Pattern: Bejeweled Wizard's Bracers (p8 450)
                    { 17, 47638 },	-- Pattern: Merlin's Robe (p8 450)
                    { 18, 47637 },	-- Pattern: Royal Moonshroud Bracers (p8 450)
                    { 19, 47636 },	-- Pattern: Royal Moonshroud Robe (p8 450)
                },
                { -- alli
                    { 1,  47622 },	-- Plans: Breastplate of the White Knight (p2 450)
                    { 2,  47623 },	-- Plans: Saronite Swordbreakers (p2 450)
                    { 3,  47627 },	-- Plans: Sunforged Bracers (p2 450)
                    { 4,  47626 },	-- Plans: Sunforged Breastplate (p2 450)
                    { 5,  47624 },	-- Plans: Titanium Razorplate (p2 450)
                    { 6,  47625 },	-- Plans: Titanium Spikeguards (p2 450)
                    { 8,  47629 },	-- Pattern: Black Chitin Bracers (p7 450)
                    { 9,  47635 },	-- Pattern: Bracers of Swift Death (p7 450)
                    { 10,  47631 },	-- Pattern: Crusader's Dragonscale Bracers (p7 450)
                    { 11, 47630 },	-- Pattern: Crusader's Dragonscale Breastplate (p7 450)
                    { 12, 47628 },	-- Pattern: Ensorcelled Nerubian Breastplate (p7 450)
                    { 13, 47634 },	-- Pattern: Knightbane Carapace (p7 450)
                    { 14, 47632 },	-- Pattern: Lunar Eclipse Chestguard (p7 450)
                    { 15, 47633 },	-- Pattern: Moonshadow Armguards (p7 450)
                    { 16, 47654 },	-- Pattern: Bejeweled Wizard's Bracers (p8 450)
                    { 17, 47655 },	-- Pattern: Merlin's Robe (p8 450)
                    { 18, 47656 },	-- Pattern: Royal Moonshroud Bracers (p8 450)
                    { 19, 47657 },	-- Pattern: Royal Moonshroud Robe (p8 450)
                }
            ),
        },
		T9_SET,
	}
}

data["WrathOnyxiasLair"] = {
	EncounterJournalID = 760,
	MapID = 2159,
    InstanceID = 249,
    AtlasModule = "Atlas_ClassicWoW",
	AtlasMapID = "OnyxiasLair",
    AtlasMapFile = "CL_OnyxiasLair",
	ContentType = RAID_CONTENT,
    -- LevelRange = {80, 80, 80},
	items = {
		{	--Onyxia
			name = AL["Onyxia"],
            npcID = 15956,
			EncounterJournalID = 1651,
            AtlasMapBossID = 3,
            DisplayIDs = {{8570}},
			Level = 999,
			[RAID10_DIFF] = {
                { 1, "SLOT_HEAD", nil, AL["Class Item drops"], nil, "WrathOnyxiaClassItems10" },
				{ 2, 49307 },	-- Fluttering Sapphiron Drape
                { 3, 49304 },	-- Sharpened Fang of the Mystics
				{ 4, 49437 },	-- Rusted Gutgore Ripper
				{ 5, 49298 },	-- Glinting Azuresong Mageblade
				{ 6, 49303 },	-- Gleaming Quel'Serrar
				{ 7, 49296 },	-- Singed Vis'kag the Bloodletter
				{ 8, 49299 },	-- Keen Obsidian Edged Blade
				{ 9, 49297 },	-- Empowered Deathbringer
				{ 10, 49302 },	-- Reclaimed Shadowstrike
				{ 11, 49301 },	-- Reclaimed Thunderstrike
				{ 12, 49305 },	-- Snub-Nose Blastershot Launcher
				{ 13, 49308 },	-- Antique Cornerstone Grimoire
                { 14, 49306 },	-- Eskhandar's Choker
				{ 15, 49309 },	-- Runed Ring of Binding
                { 16, 49636 },	-- Reins of the Onyxian Drake
				{ 18, 49463 },	-- Purified Shard of the Flame
				{ 19, 49310 },	-- Purified Shard of the Scale
                { 21, 49644 },	-- Head of Onyxia
				{ 22, 49295 },	-- Enlarged Onyxia Hide Backpack
				{ 23, 49294 },	-- Ashen Sack of Gems
				{ 27, "ac4396" },
				{ 28, "ac4403" },
				{ 29, "ac4402" },
				{ 30, "ac4404" },
			},
            [RAID25_DIFF] = {
                { 1, "SLOT_HEAD", nil, AL["Class Item drops"], nil, "WrathOnyxiaClassItems25" },
				{ 2, 49491 },	-- Fluttering Sapphiron Drape
				{ 3, 49494 },	-- Honed Fang of the Mystics
				{ 4, 49465 },	-- Tarnished Gutgore Ripper
				{ 5, 49499 },	-- Polished Azuresong Mageblade
				{ 6, 49495 },	-- Burnished Quel'Serrar
				{ 7, 49501 },	-- Tempered Vis'kag the Bloodletter
				{ 8, 49498 },	-- Sharpened Obsidian Edged Blade
				{ 9, 49500 },	-- Raging Deathbringer
				{ 10, 49496 },	-- Reinforced Shadowstrike
				{ 11, 49497 },	-- Reinforced Thunderstrike
				{ 12, 49493 },	-- Rifled Blastershot Launcher
				{ 13, 49490 },	-- Antediluvian Cornerstone Grimoire
                { 14, 49492 },	-- Eskhandar's Links
				{ 15, 49489 },	-- Signified Ring of Binding
                { 16, 49636 },	-- Reins of the Onyxian Drake
				{ 18, 49464 },	-- Purified Shard of the Flame
				{ 19, 49488 },	-- Purified Shard of the Scale
                { 21, 49644 },	-- Head of Onyxia
				{ 22, 49295 },	-- Enlarged Onyxia Hide Backpack
				{ 23, 49294 },	-- Ashen Sack of Gems
				{ 27, "ac4397" },
				{ 28, "ac4406" },
				{ 29, "ac4405" },
				{ 30, "ac4407" },
			},
		},
        T9_SET,
	}
}

-- Icecrown Citadel / T10
data["IcecrownCitadel"] = {
	EncounterJournalID = 758,
	MapID = 4812,
	InstanceID = 631,
    AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "IcecrownCitadelA",
    AtlasMapFile = {"IcecrownCitadelA", "IcecrownEnt"},
	ContentType = RAID_CONTENT,
    -- LevelRange = {80, 80, 80},
	items = {
		{	--ICC LordMarrowgar
			name = AL["Lord Marrowgar"],
			EncounterJournalID = 1624,
            AtlasMapBossID = 1,
			[RAID10_DIFF] = {
				{ 1, 50764 },	-- Shawl of Nerubian Silk
				{ 2, 50773 },	-- Cord of the Patronizing Practitioner
				{ 3, 50774 },	-- Coldwraith Bracers
				{ 4, 50762 },	-- Linked Scourge Vertebrae
				{ 5, 50775 },	-- Corrupted Silverplate Leggings
				{ 6, 50772 },	-- Ancient Skeletal Boots
				{ 8, 50763 },	-- Marrowgar's Scratching Choker
				{ 9, 50339 },	-- Sliver of Pure Ice
				{ 16, 50771 },	-- Frost Needle
				{ 17, 50761 },	-- Citadel Enforcer's Claymore
				{ 18, 50759 },	-- Bone Warden's Splitter
				{ 19, 50760 },	-- Bonebreaker Scepter
				{ 21, "ac4534" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51933 },	-- Shawl of Nerubian Silk
				{ 2, 51930 },	-- Cord of the Patronizing Practitioner
				{ 3, 51929 },	-- Coldwraith Bracers
				{ 4, 51935 },	-- Linked Scourge Vertebrae
				{ 5, 51928 },	-- Corrupted Silverplate Leggings
				{ 6, 51931 },	-- Ancient Skeletal Boots
				{ 8, 51934 },	-- Marrowgar's Scratching Choker
				{ 9, 50346 },	-- Sliver of Pure Ice
				{ 16, 51932 },	-- Frost Needle
				{ 17, 51936 },	-- Citadel Enforcer's Claymore
				{ 18, 51938 },	-- Bone Warden's Splitter
				{ 19, 51937 },	-- Bonebreaker Scepter
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4534" },
			},
			[RAID25_DIFF] = {
				{ 1, 49978 },	-- Crushing Coldwraith Belt
				{ 2, 49979 },	-- Handguards of Winter's Respite
				{ 3, 49950 },	-- Frostbitten Fur Boots
				{ 4, 49952 },	-- Snowserpent Mail Helm
				{ 5, 49980 },	-- Rusted Bonespike Pauldrons
				{ 6, 49951 },	-- Gendarme's Cuirass
				{ 7, 49960 },	-- Bracers of Dark Reckoning
				{ 8, 49964 },	-- Legguards of Lost Hope
				{ 10, 49975 },	-- Bone Sentinel's Amulet
				{ 11, 49949 },	-- Band of the Bone Colossus
				{ 12, 49977 },	-- Loop of the Endless Labyrinth
				{ 13, 49967 },	-- Marrowgar's Frigid Eye
				{ 16, 49968 },	-- Frozen Bonespike
				{ 17, 50415 },	-- Bryntroll, the Bone Arbiter
				{ 18, 49976 },	-- Bulwark of Smouldering Steel
				{ 20, 50274 },	-- Shadowfrost Shard
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4610" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50613 },	-- Crushing Coldwraith Belt
				{ 2, 50615 },	-- Handguards of Winter's Respite
				{ 3, 50607 },	-- Frostbitten Fur Boots
				{ 4, 50605 },	-- Snowserpent Mail Helm
				{ 5, 50617 },	-- Rusted Bonespike Pauldrons
				{ 6, 50606 },	-- Gendarme's Cuirass
				{ 7, 50611 },	-- Bracers of Dark Reckoning
				{ 8, 50612 },	-- Legguards of Lost Hope
				{ 10, 50609 },	-- Bone Sentinel's Amulet
				{ 11, 50604 },	-- Band of the Bone Colossus
				{ 12, 50614 },	-- Loop of the Endless Labyrinth
				{ 13, 50610 },	-- Marrowgar's Frigid Eye
				{ 16, 50608 },	-- Frozen Bonespike
				{ 17, 50709 },	-- Bryntroll, the Bone Arbiter
				{ 18, 50616 },	-- Bulwark of Smouldering Steel
				{ 20, 50274 },	-- Shadowfrost Shard
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4610" },
			},
		},
		{	--ICC LadyDeathwhisper
			name = AL["Lady Deathwhisper"],
			EncounterJournalID = 1625,
            AtlasMapBossID = 2,
			[RAID10_DIFF] = {
				{ 1, 50785 },	-- Bracers of Dark Blessings
				{ 2, 50782 },	-- Sister's Handshrouds
				{ 3, 50780 },	-- Chestguard of the Frigid Noose
				{ 4, 50778 },	-- Soulthief's Braided Belt
				{ 5, 50783 },	-- Boots of the Frozen Seed
				{ 6, 50777 },	-- Handgrips of Frost and Sleet
				{ 7, 50784 },	-- Deathspeaker Disciple's Belt
				{ 8, 50779 },	-- Deathspeaker Zealot's Helm
				{ 9, 50786 },	-- Ghoul Commander's Cuirass
				{ 16, 50342 },	-- Whispering Fanged Skull
				{ 18, 50776 },	-- Njorndar Bone Bow
				{ 19, 50781 },	-- Scourgelord's Baton
				{ 21, "ac4535" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51918 },	-- Bracers of Dark Blessings
				{ 2, 51921 },	-- Sister's Handshrouds
				{ 3, 51923 },	-- Chestguard of the Frigid Noose
				{ 4, 51925 },	-- Soulthief's Braided Belt
				{ 5, 51920 },	-- Boots of the Frozen Seed
				{ 6, 51926 },	-- Handgrips of Frost and Sleet
				{ 7, 51919 },	-- Deathspeaker Disciple's Belt
				{ 8, 51924 },	-- Deathspeaker Zealot's Helm
				{ 9, 51917 },	-- Ghoul Commander's Cuirass
				{ 16, 50343 },	-- Whispering Fanged Skull
				{ 18, 51927 },	-- Njorndar Bone Bow
				{ 19, 51922 },	-- Scourgelord's Baton
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4535" },
			},
			[RAID25_DIFF] = {
				{ 1, 49991 },	-- Shoulders of Mercy Killing
				{ 2, 49994 },	-- The Lady's Brittle Bracers
				{ 3, 49987 },	-- Cultist's Bloodsoaked Spaulders
				{ 4, 49996 },	-- Deathwhisper Chestpiece
				{ 5, 49988 },	-- Leggings of Northern Lights
				{ 6, 49993 },	-- Necrophotic Greaves
				{ 7, 49986 },	-- Broken Ram Skull Helm
				{ 8, 49995 },	-- Fallen Lord's Handguards
				{ 9, 49983 },	-- Blood-Soaked Saronite Stompers
				{ 11, 49989 },	-- Ahn'kahar Onyx Neckguard
				{ 12, 49985 },	-- Juggernaut Band
				{ 13, 49990 },	-- Ring of Maddening Whispers
				{ 16, 49982 },	-- Heartpierce
				{ 17, 49992 },	-- Nibelung
				{ 18, 50034 },	-- Zod's Repeating Longbow
				{ 20, 50274 },	-- Shadowfrost Shard
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4611" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50643 },	-- Shoulders of Mercy Killing
				{ 2, 50651 },	-- The Lady's Brittle Bracers
				{ 3, 50646 },	-- Cultist's Bloodsoaked Spaulders
				{ 4, 50649 },	-- Deathwhisper Raiment
				{ 5, 50645 },	-- Leggings of Northern Lights
				{ 6, 50652 },	-- Necrophotic Greaves
				{ 7, 50640 },	-- Broken Ram Skull Helm
				{ 8, 50650 },	-- Fallen Lord's Handguards
				{ 9, 50639 },	-- Blood-Soaked Saronite Stompers
				{ 11, 50647 },	-- Ahn'kahar Onyx Neckguard
				{ 12, 50642 },	-- Juggernaut Band
				{ 13, 50644 },	-- Ring of Maddening Whispers
				{ 16, 50641 },	-- Heartpierce
				{ 17, 50648 },	-- Nibelung
				{ 18, 50638 },	-- Zod's Repeating Longbow
				{ 20, 50274 },	-- Shadowfrost Shard
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4611" },
			},
		},
		{	--ICC GunshipBattle
			name = AL["Icecrown Gunship Battle"],
			EncounterJournalID = 1626,
            AtlasMapBossID = 3,
			[RAID10_DIFF] = {
				{ 1, 50791 },	-- Saronite Gargoyle Cloak
				{ 2, 50795 },	-- Cord of Dark Suffering
				{ 3, 50797 },	-- Ice-Reinforced Vrykul Helm
				{ 4, 50792 },	-- Pauldrons of Lost Hope
				{ 5, 50789 },	-- Icecrown Rampart Bracers
				{ 6, 50796 },	-- Bracers of Pale Illumination
				{ 7, 50788 },	-- Bone Drake's Enameled Boots
				{ 9, 50790 },	-- Abomination's Bloody Ring
				{ 10, 50340 },	-- Muradin's Spyglass
				{ 16, 50793 },	-- Midnight Sun
				{ 17, 50787 },	-- Frost Giant's Cleaver
				{ 18, 50794 },	-- Neverending Winter
				{ 20, "ac4536" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51912 },	-- Saronite Gargoyle Cloak
				{ 2, 51908 },	-- Cord of Dark Suffering
				{ 3, 51906 },	-- Ice-Reinforced Vrykul Helm
				{ 4, 51911 },	-- Pauldrons of Lost Hope
				{ 5, 51914 },	-- Icecrown Rampart Bracers
				{ 6, 51907 },	-- Bracers of Pale Illumination
				{ 7, 51915 },	-- Bone Drake's Enameled Boots
				{ 9, 51913 },	-- Abomination's Bloody Ring
				{ 10, 50345 },	-- Muradin's Spyglass
				{ 16, 51910 },	-- Midnight Sun
				{ 17, 51916 },	-- Frost Giant's Cleaver
				{ 18, 51909 },	-- Neverending Winter
				{ 20, 49908 },	-- Primordial Saronite
				{ 22, "ac4536" },
			},
			[RAID25_DIFF] = {
				{ 1, 49998 },	-- Shadowvault Slayer's Cloak
				{ 2, 50006 },	-- Corp'rethar Ceremonial Crown
				{ 3, 50011 },	-- Gunship Captain's Mittens
				{ 4, 50001 },	-- Ikfirus' Sack of Wonder
				{ 5, 50009 },	-- Boots of Unnatural Growth
				{ 6, 50000 },	-- Scourge Hunter's Vambraces
				{ 7, 50003 },	-- Boneguard Commander's Pauldrons
				{ 8, 50002 },	-- Polar Bear Claw Bracers
				{ 9, 50010 },	-- Waistband of Righteous Fury
				{ 11, 50274 },	-- Shadowfrost Shard
				{ 12, 49908 },	-- Primordial Saronite
				{ 16, 50005 },	-- Amulet of the Silent Eulogy
				{ 17, 50008 },	-- Ring of Rapid Ascent
				{ 18, 49999 },	-- Skeleton Lord's Circle
				{ 19, 50359 },	-- Althor's Abacus
				{ 20, 50352 },	-- Corpse Tongue Coin
				{ 22, 50411 },	-- Scourgeborne Waraxe
				{ 24, "ac4612" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50653 },	-- Shadowvault Slayer's Cloak
				{ 2, 50661 },	-- Corp'rethar Ceremonial Crown
				{ 3, 50663 },	-- Gunship Captain's Mittens
				{ 4, 50656 },	-- Ikfirus' Sack of Wonder
				{ 5, 50665 },	-- Boots of Unnatural Growth
				{ 6, 50655 },	-- Scourge Hunter's Vambraces
				{ 7, 50660 },	-- Boneguard Commander's Pauldrons
				{ 8, 50659 },	-- Polar Bear Claw Bracers
				{ 9, 50667 },	-- Waistband of Righteous Fury
				{ 11, 50274 },	-- Shadowfrost Shard
				{ 12, 49908 },	-- Primordial Saronite
				{ 16, 50658 },	-- Amulet of the Silent Eulogy
				{ 17, 50664 },	-- Ring of Rapid Ascent
				{ 18, 50657 },	-- Skeleton Lord's Circle
				{ 19, 50366 },	-- Althor's Abacus
				{ 20, 50349 },	-- Corpse Tongue Coin
				{ 22, 50654 },	-- Scourgeborne Waraxe
				{ 24, "ac4612" },
			},
		},
		{	--ICC Saurfang
			name = AL["Deathbringer Saurfang"],
			EncounterJournalID = 1628,
            AtlasMapBossID = 5,
			[RAID10_DIFF] = {
				{ 1, 50807 },	-- Thaumaturge's Crackling Cowl
				{ 2, 50804 },	-- Icecrown Spire Sandals
				{ 3, 50799 },	-- Scourge Stranglers
				{ 4, 50806 },	-- Leggings of Unrelenting Blood
				{ 5, 50800 },	-- Hauberk of a Thousand Cuts
				{ 6, 50801 },	-- Blade-Scored Carapace
				{ 7, 50802 },	-- Gargoyle Spit Bracers
				{ 8, 50808 },	-- Deathforged Legplates
				{ 16, 50809 },	-- Soulcleave Pendant
				{ 17, 50803 },	-- Saurfang's Cold-Forged Band
				{ 19, 50798 },	-- Ramaladni's Blade of Culling
				{ 20, 50805 },	-- Mag'hari Chieftain's Staff
				{ 22, "ac4537" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51896 },	-- Thaumaturge's Crackling Cowl
				{ 2, 51899 },	-- Icecrown Spire Sandals
				{ 3, 51904 },	-- Scourge Stranglers
				{ 4, 51897 },	-- Leggings of Unrelenting Blood
				{ 5, 51903 },	-- Hauberk of a Thousand Cuts
				{ 6, 51902 },	-- Blade-Scored Carapace
				{ 7, 51901 },	-- Gargoyle Spit Bracers
				{ 8, 51895 },	-- Deathforged Legplates
				{ 10, 51894 },	-- Soulcleave Pendant
				{ 11, 51900 },	-- Saurfang's Cold-Forged Band
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 51905 },	-- Ramaladni's Blade of Culling
				{ 21, 51898 },	-- Mag'hari Chieftain's Staff
				{ 23, 49908 },	-- Primordial Saronite
				{ 25, "ac4537" },
			},
			[RAID25_DIFF] = {
				{ 1, 50014 },	-- Greatcloak of the Turned Champion
				{ 2, 50333 },	-- Toskk's Maximized Wristguards
				{ 3, 50015 },	-- Belt of the Blood Nova
				{ 4, 50362 },	-- Deathbringer's Will
				{ 5, 50412 },	-- Bloodvenom Blade
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, "ac4613" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50668 },	-- Greatcloak of the Turned Champion
				{ 2, 50670 },	-- Toskk's Maximized Wristguards
				{ 3, 50671 },	-- Belt of the Blood Nova
				{ 4, 50363 },	-- Deathbringer's Will
				{ 5, 50672 },	-- Bloodvenom Blade
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52030 },	-- Conqueror's Mark of Sanctification
				{ 17, 52029 },	-- Protector's Mark of Sanctification
				{ 18, 52028 },	-- Vanquisher's Mark of Sanctification
				{ 20, 52027 },	-- Conqueror's Mark of Sanctification
				{ 21, 52026 },	-- Protector's Mark of Sanctification
				{ 22, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 24, "ac4613" },
			},
		},
		{	--ICC Festergut
			name = AL["Festergut"],
			EncounterJournalID = 1629,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 8,
			[RAID10_DIFF] = {
				{ 1, 50859 },	-- Cloak of Many Skins
				{ 2, 50988 },	-- Bloodstained Surgeon's Shoulderguards
				{ 3, 50990 },	-- Kilt of Untreated Wounds
				{ 4, 50985 },	-- Wrists of Septic Shock
				{ 5, 50858 },	-- Plague-Soaked Leather Leggings
				{ 6, 50812 },	-- Taldron's Long Neglected Boots
				{ 7, 50967 },	-- Festergut's Gaseous Gloves
				{ 8, 50811 },	-- Festering Fingerguards
				{ 16, 50852 },	-- Precious' Putrid Collar
				{ 17, 50986 },	-- Signet of Putrefaction
				{ 19, 50810 },	-- Gutbuster
				{ 20, 50966 },	-- Abracadaver
				{ 22, "ac4577" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51888 },	-- Cloak of Many Skins
				{ 2, 51883 },	-- Bloodstained Surgeon's Shoulderguards
				{ 3, 51882 },	-- Kilt of Untreated Wounds
				{ 4, 51885 },	-- Wrists of Septic Shock
				{ 5, 51889 },	-- Plague-Soaked Leather Leggings
				{ 6, 51891 },	-- Taldron's Long Neglected Boots
				{ 7, 51886 },	-- Festergut's Gaseous Gloves
				{ 8, 51892 },	-- Festering Fingerguards
				{ 16, 51890 },	-- Precious' Putrid Collar
				{ 17, 51884 },	-- Signet of Putrefaction
				{ 19, 51893 },	-- Gutbuster
				{ 20, 51887 },	-- Abracadaver
				{ 22, 49908 },	-- Primordial Saronite
				{ 24, "ac4577" },
			},
			[RAID25_DIFF] = {
				{ 1, 50063 },	-- Lingering Illness
				{ 2, 50056 },	-- Plaguebringer's Stained Pants
				{ 3, 50062 },	-- Plague Scientist's Boots
				{ 4, 50042 },	-- Gangrenous Leggings
				{ 5, 50041 },	-- Leather of Stitched Scourge Parts
				{ 6, 50059 },	-- Horrific Flesh Epaulets
				{ 7, 50038 },	-- Carapace of Forgotten Kings
				{ 8, 50064 },	-- Unclean Surgical Gloves
				{ 9, 50413 },	-- Nerub'ar Stalker's Cord
				{ 10, 50060 },	-- Faceplate of the Forgotten
				{ 11, 50037 },	-- Fleshrending Gauntlets
				{ 12, 50036 },	-- Belt of Broken Bones
				{ 16, 50061 },	-- Holiday's Grace
				{ 17, 50414 },	-- Might of Blight
				{ 19, 50035 },	-- Black Bruise
				{ 20, 50040 },	-- Distant Land
				{ 22, 50226 },	-- Festergut's Acidic Blood
				{ 24, 50274 },	-- Shadowfrost Shard
				{ 25, 49908 },	-- Primordial Saronite
				{ 27, "ac4615" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50702 },	-- Lingering Illness
				{ 2, 50694 },	-- Plaguebringer's Stained Pants
				{ 3, 50699 },	-- Plague Scientist's Boots
				{ 4, 50697 },	-- Gangrenous Leggings
				{ 5, 50696 },	-- Leather of Stitched Scourge Parts
				{ 6, 50698 },	-- Horrific Flesh Epaulets
				{ 7, 50689 },	-- Carapace of Forgotten Kings
				{ 8, 50703 },	-- Unclean Surgical Gloves
				{ 9, 50688 },	-- Nerub'ar Stalker's Cord
				{ 10, 50701 },	-- Faceplate of the Forgotten
				{ 11, 50690 },	-- Fleshrending Gauntlets
				{ 12, 50691 },	-- Belt of Broken Bones
				{ 16, 50700 },	-- Holiday's Grace
				{ 17, 50693 },	-- Might of Blight
				{ 19, 50692 },	-- Black Bruise
				{ 20, 50695 },	-- Distant Land
				{ 22, 50226 },	-- Festergut's Acidic Blood
				{ 24, 50274 },	-- Shadowfrost Shard
				{ 25, 49908 },	-- Primordial Saronite
				{ 27, "ac4615" },
			},
		},
		{	--ICC Rotface
			name = AL["Rotface"],
			EncounterJournalID = 1630,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 9,
			[RAID10_DIFF] = {
				{ 1, 51007 },	-- Ether-Soaked Bracers
				{ 2, 51005 },	-- Gloves of Broken Fingers
				{ 3, 51009 },	-- Chestguard of the Failed Experiment
				{ 4, 51002 },	-- Taldron's Short-Sighted Helm
				{ 5, 51006 },	-- Shuffling Shoes
				{ 6, 51000 },	-- Flesh-Shaper's Gurney Strap
				{ 8, 51008 },	-- Choker of Filthy Diamonds
				{ 9, 51001 },	-- Rotface's Rupturing Ring
				{ 16, 51003 },	-- Abomination Knuckles
				{ 17, 51004 },	-- Lockjaw
				{ 18, 50998 },	-- Shaft of Glacial Ice
				{ 20, "ac4538" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51872 },	-- Ether-Soaked Bracers
				{ 2, 51874 },	-- Gloves of Broken Fingers
				{ 3, 51870 },	-- Chestguard of the Failed Experiment
				{ 4, 51877 },	-- Taldron's Short-Sighted Helm
				{ 5, 51873 },	-- Shuffling Shoes
				{ 6, 51879 },	-- Flesh-Shaper's Gurney Strap
				{ 8, 51871 },	-- Choker of Filthy Diamonds
				{ 9, 51878 },	-- Rotface's Rupturing Ring
				{ 16, 51876 },	-- Abomination Knuckles
				{ 17, 51875 },	-- Lockjaw
				{ 18, 51881 },	-- Shaft of Glacial Ice
				{ 20, 49908 },	-- Primordial Saronite
				{ 22, "ac4538" },
			},
			[RAID25_DIFF] = {
				{ 1, 50019 },	-- Winding Sheet
				{ 2, 50032 },	-- Death Surgeon's Sleeves
				{ 3, 50026 },	-- Helm of the Elder Moon
				{ 4, 50021 },	-- Aldriana's Gloves of Secrecy
				{ 5, 50022 },	-- Dual-Bladed Pauldrons
				{ 6, 50030 },	-- Bloodsunder's Bracers
				{ 7, 50020 },	-- Raging Behemoth's Shoulderplates
				{ 8, 50024 },	-- Blightborne Warplate
				{ 9, 50027 },	-- Rot-Resistant Breastplate
				{ 11, 50023 },	-- Bile-Encrusted Medallion
				{ 12, 50025 },	-- Seal of Many Mouths
				{ 13, 50353 },	-- Dislodged Foreign Object
				{ 16, 50028 },	-- Trauma
				{ 17, 50016 },	-- Rib Spreader
				{ 18, 50033 },	-- Corpse-Impaling Spike
				{ 20, 50231 },	-- Rotface's Acidic Blood
				{ 22, 50274 },	-- Shadowfrost Shard
				{ 23, 49908 },	-- Primordial Saronite
				{ 25, "ac4614" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50677 },	-- Winding Sheet
				{ 2, 50686 },	-- Death Surgeon's Sleeves
				{ 3, 50679 },	-- Helm of the Elder Moon
				{ 4, 50675 },	-- Aldriana's Gloves of Secrecy
				{ 5, 50673 },	-- Dual-Bladed Pauldrons
				{ 6, 50687 },	-- Bloodsunder's Bracers
				{ 7, 50674 },	-- Raging Behemoth's Shoulderplates
				{ 8, 50681 },	-- Blightborne Warplate
				{ 9, 50680 },	-- Rot-Resistant Breastplate
				{ 11, 50682 },	-- Bile-Encrusted Medallion
				{ 12, 50678 },	-- Seal of Many Mouths
				{ 13, 50348 },	-- Dislodged Foreign Object
				{ 16, 50685 },	-- Trauma
				{ 17, 50676 },	-- Rib Spreader
				{ 18, 50684 },	-- Corpse-Impaling Spike
				{ 20, 50231 },	-- Rotface's Acidic Blood
				{ 22, 50274 },	-- Shadowfrost Shard
				{ 23, 49908 },	-- Primordial Saronite
				{ 25, "ac4614" },
			},
		},
		{	--ICC Putricide
			name = AL["Professor Putricide"],
			EncounterJournalID = 1631,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 10,
			[RAID10_DIFF] = {
				{ 1, 51020 },	-- Shoulders of Ruinous Senility
				{ 2, 51017 },	-- Cauterized Cord
				{ 3, 51013 },	-- Discarded Bag of Entrails
				{ 4, 51015 },	-- Shoulderpads of the Morbid Ritual
				{ 5, 51019 },	-- Rippling Flesh Kilt
				{ 6, 51014 },	-- Scalpel-Sharpening Shoulderguards
				{ 7, 51018 },	-- Chestplate of Septic Stitches
				{ 16, 51012 },	-- Infected Choker
				{ 17, 51016 },	-- Pendant of Split Veins
				{ 18, 50341 },	-- Unidentifiable Organ
				{ 20, 51011 },	-- Flesh-Carving Scalpel
				{ 21, 51010 },	-- The Facelifter
				{ 23, "ac4578" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51859 },	-- Shoulders of Ruinous Senility
				{ 2, 51862 },	-- Cauterized Cord
				{ 3, 51866 },	-- Discarded Bag of Entrails
				{ 4, 51864 },	-- Shoulderpads of the Morbid Ritual
				{ 5, 51860 },	-- Rippling Flesh Kilt
				{ 6, 51865 },	-- Scalpel-Sharpening Shoulderguards
				{ 7, 51861 },	-- Chestplate of Septic Stitches
				{ 9, 51867 },	-- Infected Choker
				{ 10, 51863 },	-- Pendant of Split Veins
				{ 11, 50344 },	-- Unidentifiable Organ
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 51868 },	-- Flesh-Carving Scalpel
				{ 21, 51869 },	-- The Facelifter
				{ 23, 49908 },	-- Primordial Saronite
				{ 25, "ac4578" },
			},
			[RAID25_DIFF] = {
				{ 1, 50067 },	-- Astrylian's Sutured Cinch
				{ 2, 50069 },	-- Professor's Bloodied Smock
				{ 3, 50351 },	-- Tiny Abomination in a Jar
				{ 4, 50179 },	-- Last Word
				{ 5, 50068 },	-- Rigormortis
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, "ac4616" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50707 },	-- Astrylian's Sutured Cinch
				{ 2, 50705 },	-- Professor's Bloodied Smock
				{ 3, 50706 },	-- Tiny Abomination in a Jar
				{ 4, 50708 },	-- Last Word
				{ 5, 50704 },	-- Rigormortis
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52030 },	-- Conqueror's Mark of Sanctification
				{ 17, 52029 },	-- Protector's Mark of Sanctification
				{ 18, 52028 },	-- Vanquisher's Mark of Sanctification
				{ 20, 52027 },	-- Conqueror's Mark of Sanctification
				{ 21, 52026 },	-- Protector's Mark of Sanctification
				{ 22, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 24, "ac4616" },
			},
		},
		{	--ICC Council
			name = AL["Blood Prince Council"],
			EncounterJournalID = 1632,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 11,
			[RAID10_DIFF] = {
				{ 1, 51382 },	-- Heartsick Mender's Cape
				{ 2, 51379 },	-- Bloodsoul Raiment
				{ 3, 51380 },	-- Pale Corpse Boots
				{ 4, 51023 },	-- Taldaram's Soft Slippers
				{ 5, 51325 },	-- Blood-Drinker's Girdle
				{ 6, 51383 },	-- Spaulders of the Blood Princes
				{ 7, 51025 },	-- Battle-Maiden's Legguards
				{ 9, 51381 },	-- Cerise Coiled Ring
				{ 10, 51024 },	-- Thrice Fanged Signet
				{ 16, 51021 },	-- Soulbreaker
				{ 17, 51022 },	-- Hersir's Greatspear
				{ 18, 51326 },	-- Wand of Ruby Claret
				{ 20, "ac4582" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51848 },	-- Heartsick Mender's Cape
				{ 2, 51851 },	-- Bloodsoul Raiment
				{ 3, 51850 },	-- Pale Corpse Boots
				{ 4, 51856 },	-- Taldaram's Soft Slippers
				{ 5, 51853 },	-- Blood-Drinker's Girdle
				{ 6, 51847 },	-- Spaulders of the Blood Princes
				{ 7, 51854 },	-- Battle-Maiden's Legguards
				{ 9, 51849 },	-- Cerise Coiled Ring
				{ 10, 51855 },	-- Thrice Fanged Signet
				{ 16, 51858 },	-- Soulbreaker
				{ 17, 51857 },	-- Hersir's Greatspear
				{ 18, 51852 },	-- Wand of Ruby Claret
				{ 20, 49908 },	-- Primordial Saronite
				{ 22, "ac4582" },
			},
			[RAID25_DIFF] = {
				{ 1, 50074 },	-- Royal Crimson Cloak
				{ 2, 50172 },	-- Sanguine Silk Robes
				{ 3, 50176 },	-- San'layn Ritualist Gloves
				{ 4, 50073 },	-- Geistlord's Punishment Sack
				{ 5, 50171 },	-- Shoulders of Frost-Tipped Thorns
				{ 6, 50177 },	-- Mail of Crimson Coins
				{ 7, 50071 },	-- Treads of the Wasteland
				{ 8, 50072 },	-- Landsoul's Horned Greathelm
				{ 9, 50175 },	-- Crypt Keeper's Bracers
				{ 10, 50075 },	-- Taldaram's Plated Fists
				{ 16, 50174 },	-- Incarnadine Band of Mending
				{ 17, 50170 },	-- Valanar's Other Signet Ring
				{ 19, 50184 },	-- Keleseth's Seducer
				{ 20, 49919 },	-- Cryptmaker
				{ 21, 50173 },	-- Shadow Silk Spindle
				{ 23, 50274 },	-- Shadowfrost Shard
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4617" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50718 },	-- Royal Crimson Cloak
				{ 2, 50717 },	-- Sanguine Silk Robes
				{ 3, 50722 },	-- San'layn Ritualist Gloves
				{ 4, 50713 },	-- Geistlord's Punishment Sack
				{ 5, 50715 },	-- Shoulders of Frost-Tipped Thorns
				{ 6, 50723 },	-- Mail of Crimson Coins
				{ 7, 50711 },	-- Treads of the Wasteland
				{ 8, 50712 },	-- Landsoul's Horned Greathelm
				{ 9, 50721 },	-- Crypt Keeper's Bracers
				{ 10, 50716 },	-- Taldaram's Plated Fists
				{ 16, 50720 },	-- Incarnadine Band of Mending
				{ 17, 50714 },	-- Valanar's Other Signet Ring
				{ 19, 50710 },	-- Keleseth's Seducer
				{ 20, 50603 },	-- Cryptmaker
				{ 21, 50719 },	-- Shadow Silk Spindle
				{ 23, 50274 },	-- Shadowfrost Shard
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4617" },
			},
		},
		{	--ICC Lanathel
			name = AL["Blood-Queen Lana'thel"],
			EncounterJournalID = 1633,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 12,
			[RAID10_DIFF] = {
				{ 1, 51554 },	-- Cowl of Malefic Repose
				{ 2, 51552 },	-- Shoulderpads of the Searing Kiss
				{ 3, 51550 },	-- Ivory-Inlaid Leggings
				{ 4, 51551 },	-- Chestguard of Siphoned Elements
				{ 5, 51386 },	-- Throatrender Handguards
				{ 6, 51556 },	-- Veincrusher Gauntlets
				{ 7, 51555 },	-- Tightening Waistband
				{ 16, 51548 },	-- Collar of Haughty Disdain
				{ 17, 51387 },	-- Seal of the Twilight Queen
				{ 19, 51384 },	-- Bloodsipper
				{ 20, 51385 },	-- Stakethrower
				{ 21, 51553 },	-- Lana'thel's Bloody Nail
				{ 23, "ac4539" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51837 },	-- Cowl of Malefic Repose
				{ 2, 51839 },	-- Shoulderpads of the Searing Kiss
				{ 3, 51841 },	-- Ivory-Inlaid Leggings
				{ 4, 51840 },	-- Chestguard of Siphoned Elements
				{ 5, 51844 },	-- Throatrender Handguards
				{ 6, 51835 },	-- Veincrusher Gauntlets
				{ 7, 51836 },	-- Tightening Waistband
				{ 9, 51842 },	-- Collar of Haughty Disdain
				{ 10, 51843 },	-- Seal of the Twilight Queen
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 51846 },	-- Bloodsipper
				{ 21, 51845 },	-- Stakethrower
				{ 22, 51838 },	-- Lana'thel's Bloody Nail
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4539" },
			},
			[RAID25_DIFF] = {
				{ 1, 50182 },	-- Blood Queen's Crimson Choker
				{ 2, 50180 },	-- Lana'thel's Chain of Flagellation
				{ 3, 50354 },	-- Bauble of True Blood
				{ 4, 50178 },	-- Bloodfall
				{ 5, 50181 },	-- Dying Light
				{ 6, 50065 },	-- Icecrown Glacial Wall
				{ 8, 50274 },	-- Shadowfrost Shard
				{ 9, 49908 },	-- Primordial Saronite
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, "ac4618" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50724 },	-- Blood Queen's Crimson Choker
				{ 2, 50728 },	-- Lana'thel's Chain of Flagellation
				{ 3, 50726 },	-- Bauble of True Blood
				{ 4, 50727 },	-- Bloodfall
				{ 5, 50725 },	-- Dying Light
				{ 6, 50729 },	-- Icecrown Glacial Wall
				{ 8, 50274 },	-- Shadowfrost Shard
				{ 9, 49908 },	-- Primordial Saronite
				{ 16, 52030 },	-- Conqueror's Mark of Sanctification
				{ 17, 52029 },	-- Protector's Mark of Sanctification
				{ 18, 52028 },	-- Vanquisher's Mark of Sanctification
				{ 20, 52027 },	-- Conqueror's Mark of Sanctification
				{ 21, 52026 },	-- Protector's Mark of Sanctification
				{ 22, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 24, "ac4618" },
			},
		},
		{	--ICC Valithria
			name = AL["Valithria Dreamwalker"],
			EncounterJournalID = 1634,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 14,
			[RAID10_DIFF] = {
				{ 1, 51584 },	-- Lich Wrappings
				{ 2, 51777 },	-- Leggings of the Refracted Mind
				{ 3, 51585 },	-- Sister Svalna's Spangenhelm
				{ 4, 51565 },	-- Skinned Whelp Shoulders
				{ 5, 51583 },	-- Stormbringer Gloves
				{ 6, 51566 },	-- Legguards of the Twisted Dream
				{ 7, 51586 },	-- Emerald Saint's Spaulders
				{ 8, 51563 },	-- Taiga Bindings
				{ 9, 51564 },	-- Ironrope Belt of Ymirjar
				{ 16, 51562 },	-- Oxheart
				{ 17, 51582 },	-- Sister Svalna's Aether Staff
				{ 18, 51561 },	-- Dreamhunter's Carbine
				{ 20, "ac4579" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51826 },	-- Lich Wrappings
				{ 2, 51823 },	-- Leggings of the Refracted Mind
				{ 3, 51825 },	-- Sister Svalna's Spangenhelm
				{ 4, 51830 },	-- Skinned Whelp Shoulders
				{ 5, 51827 },	-- Stormbringer Gloves
				{ 6, 51829 },	-- Legguards of the Twisted Dream
				{ 7, 51824 },	-- Emerald Saint's Spaulders
				{ 8, 51832 },	-- Taiga Bindings
				{ 9, 51831 },	-- Ironrope Belt of Ymirjar
				{ 16, 51833 },	-- Oxheart
				{ 17, 51828 },	-- Sister Svalna's Aether Staff
				{ 18, 51834 },	-- Dreamhunter's Carbine
				{ 20, 49908 },	-- Primordial Saronite
				{ 22, "ac4579" },
			},
			[RAID25_DIFF] = {
				{ 1, 50205 },	-- Frostbinder's Shredded Cape
				{ 2, 50418 },	-- Robe of the Waking Nightmare
				{ 3, 50417 },	-- Bracers of Eternal Dreaming
				{ 4, 50202 },	-- Snowstorm Helm
				{ 5, 50188 },	-- Anub'ar Stalker's Gloves
				{ 6, 50187 },	-- Coldwraith Links
				{ 7, 50199 },	-- Leggings of Dying Candles
				{ 8, 50192 },	-- Scourge Reaver's Legplates
				{ 9, 50416 },	-- Boots of the Funeral March
				{ 10, 50190 },	-- Grinning Skull Greatboots
				{ 16, 50195 },	-- Noose of Malachite
				{ 17, 50185 },	-- Devium's Eternally Cold Ring
				{ 18, 50186 },	-- Frostbrood Sapphire Ring
				{ 20, 50183 },	-- Lungbreaker
				{ 21, 50472 },	-- Nightmare Ender
				{ 23, 50274 },	-- Shadowfrost Shard
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4619" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50628 },	-- Frostbinder's Shredded Cape
				{ 2, 50629 },	-- Robe of the Waking Nightmare
				{ 3, 50630 },	-- Bracers of Eternal Dreaming
				{ 4, 50626 },	-- Snowstorm Helm
				{ 5, 50619 },	-- Anub'ar Stalker's Gloves
				{ 6, 50620 },	-- Coldwraith Links
				{ 7, 50623 },	-- Leggings of Dying Candles
				{ 8, 50624 },	-- Scourge Reaver's Legplates
				{ 9, 50632 },	-- Boots of the Funeral March
				{ 10, 50625 },	-- Grinning Skull Greatboots
				{ 16, 50627 },	-- Noose of Malachite
				{ 17, 50622 },	-- Devium's Eternally Cold Ring
				{ 18, 50618 },	-- Frostbrood Sapphire Ring
				{ 20, 50621 },	-- Lungbreaker
				{ 21, 50631 },	-- Nightmare Ender
				{ 23, 50274 },	-- Shadowfrost Shard
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4619" },
			},
		},
		{	--ICC Sindragosa
			name = AL["Sindragosa"],
			EncounterJournalID = 1635,
            AtlasMapFile = "IcecrownCitadelB",
            AtlasMapBossID = 15,
			[RAID10_DIFF] = {
				{ 1, 51790 },	-- Robes of Azure Downfall
				{ 2, 51783 },	-- Vambraces of the Frost Wyrm Queen
				{ 3, 51789 },	-- Icicle Shapers
				{ 4, 51792 },	-- Shoulderguards of Crystalline Bone
				{ 5, 51785 },	-- Wyrmwing Treads
				{ 6, 51782 },	-- Etched Dragonbone Girdle
				{ 7, 51786 },	-- Legplates of Aetheric Strife
				{ 8, 51787 },	-- Scourge Fanged Stompers
				{ 10, 142097, "pet1966" }, -- Skull of a Frozen Whelp -> Soulbroken Whelpling
				{ 16, 51779 },	-- Rimetooth Pendant
				{ 18, 51784 },	-- Splintershard
				{ 19, 51788 },	-- Bleak Coldarra Carver
				{ 20, 51791 },	-- Lost Pavise of the Blue Flight
				{ 22, "ac4580" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51813 },	-- Robes of Azure Downfall
				{ 2, 51820 },	-- Vambraces of the Frost Wyrm Queen
				{ 3, 51814 },	-- Icicle Shapers
				{ 4, 51811 },	-- Shoulderguards of Crystalline Bone
				{ 5, 51818 },	-- Wyrmwing Treads
				{ 6, 51821 },	-- Etched Dragonbone Girdle
				{ 7, 51817 },	-- Legplates of Aetheric Strife
				{ 8, 51816 },	-- Scourge Fanged Stompers
				{ 10, 51822 },	-- Rimetooth Pendant
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 51819 },	-- Splintershard
				{ 21, 51815 },	-- Bleak Coldarra Carver
				{ 22, 51812 },	-- Lost Pavise of the Blue Flight
				{ 24, 49908 },	-- Primordial Saronite
				{ 26, "ac4580" },
			},
			[RAID25_DIFF] = {
				{ 1, 50421 },	-- Sindragosa's Cruel Claw
				{ 2, 50424 },	-- Memory of Malygos
				{ 3, 50360 },	-- Phylactery of the Nameless Lich
				{ 4, 50361 },	-- Sindragosa's Flawless Fang
				{ 5, 50423 },	-- Sundial of Eternal Dusk
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, "ac4620" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50633 },	-- Sindragosa's Cruel Claw
				{ 2, 50636 },	-- Memory of Malygos
				{ 3, 50365 },	-- Phylactery of the Nameless Lich
				{ 4, 50364 },	-- Sindragosa's Flawless Fang
				{ 5, 50635 },	-- Sundial of Eternal Dusk
				{ 7, 50274 },	-- Shadowfrost Shard
				{ 8, 49908 },	-- Primordial Saronite
				{ 16, 52030 },	-- Conqueror's Mark of Sanctification
				{ 17, 52029 },	-- Protector's Mark of Sanctification
				{ 18, 52028 },	-- Vanquisher's Mark of Sanctification
				{ 20, 52027 },	-- Conqueror's Mark of Sanctification
				{ 21, 52026 },	-- Protector's Mark of Sanctification
				{ 22, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 24, "ac4620" },
			},
		},
		{	--ICC LichKing
			name = AL["The Lich King"],
			EncounterJournalID = 1636,
            AtlasMapFile = "IcecrownCitadelC",
            AtlasMapBossID = 16,
			[RAID10_DIFF] = {
				{ 1, 51801 },	-- Pugius, Fist of Defiance
				{ 2, 51803 },	-- Tel'thas, Dagger of the Blood King
				{ 3, 51800 },	-- Stormfury, Black Blade of the Betrayer
				{ 4, 51795 },	-- Troggbane, Axe of the Frostborne King
				{ 5, 51798 },	-- Valius, Gavel of the Lightbringer
				{ 6, 51796 },	-- Warmace of Menethil
				{ 7, 51799 },	-- Halion, Staff of Forgotten Love
				{ 8, 51797 },	-- Tainted Twig of Nordrassil
				{ 9, 51802 },	-- Windrunner's Heartseeker
				{ 16, "ac4530" },
				{ 17, "ac4601" },
				{ 18, "ac4581" },
			},
			[RAID10H_DIFF] = {
				{ 1, 51941 },	-- Pugius, Fist of Defiance
				{ 2, 51939 },	-- Tel'thas, Dagger of the Blood King
				{ 3, 51942 },	-- Stormfury, Black Blade of the Betrayer
				{ 4, 51947 },	-- Troggbane, Axe of the Frostborne King
				{ 5, 51944 },	-- Valius, Gavel of the Lightbringer
				{ 6, 51946 },	-- Warmace of Menethil
				{ 7, 51943 },	-- Halion, Staff of Forgotten Love
				{ 8, 51945 },	-- Tainted Twig of Nordrassil
				{ 9, 51940 },	-- Windrunner's Heartseeker
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 49908 },	-- Primordial Saronite
				{ 22, "ac4583" },
				{ 23, "ac4601" },
				{ 24, "ac4581" },
			},
			[RAID25_DIFF] = {
				{ 1, 50426 },	-- Heaven's Fall, Kryss of a Thousand Lies
				{ 2, 50427 },	-- Bloodsurge, Kel'Thuzad's Blade of Agony
				{ 3, 50070 },	-- Glorenzelg, High-Blade of the Silver Hand
				{ 4, 50012 },	-- Havoc's Call, Blade of Lordaeron Kings
				{ 5, 50428 },	-- Royal Scepter of Terenas II
				{ 6, 49997 },	-- Mithrios, Bronzebeard's Legacy
				{ 7, 50425 },	-- Oathbinder, Charge of the Ranger-General
				{ 8, 50429 },	-- Archus, Greatstaff of Antonidas
				{ 9, 49981 },	-- Fal'inrush, Defender of Quel'thalas
				{ 16, 52027 },	-- Conqueror's Mark of Sanctification
				{ 17, 52026 },	-- Protector's Mark of Sanctification
				{ 18, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 20, 50274 },	-- Shadowfrost Shard
				{ 21, 49908 },	-- Primordial Saronite
				{ 23, "ac4597" },
				{ 24, "ac4621" },
				{ 25, "ac4622" },
			},
			[RAID25H_DIFF] = {
				{ 1, 50736 },	-- Heaven's Fall, Kryss of a Thousand Lies
				{ 2, 50732 },	-- Bloodsurge, Kel'Thuzad's Blade of Agony
				{ 3, 50730 },	-- Glorenzelg, High-Blade of the Silver Hand
				{ 4, 50737 },	-- Havoc's Call, Blade of Lordaeron Kings
				{ 5, 50734 },	-- Royal Scepter of Terenas II
				{ 6, 50738 },	-- Mithrios, Bronzebeard's Legacy
				{ 7, 50735 },	-- Oathbinder, Charge of the Ranger-General
				{ 8, 50731 },	-- Archus, Greatstaff of Antonidas
				{ 9, 50733 },	-- Fal'inrush, Defender of Quel'thalas
				{ 12, 50818 },	-- Invincible's Reins
				{ 14, 50274 },	-- Shadowfrost Shard
				{ 15, 49908 },	-- Primordial Saronite
				{ 16, 52030 },	-- Conqueror's Mark of Sanctification
				{ 17, 52029 },	-- Protector's Mark of Sanctification
				{ 18, 52028 },	-- Vanquisher's Mark of Sanctification
				{ 20, 52027 },	-- Conqueror's Mark of Sanctification
				{ 21, 52026 },	-- Protector's Mark of Sanctification
				{ 22, 52025 },	-- Vanquisher's Mark of Sanctification
				{ 25, "ac4584" },
				{ 26, "ac4621" },
				{ 27, "ac4622" },
			},
		},
		{	--ICC Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[RAID25_DIFF] = {
				{ 1, 50449 },	-- Stiffened Corpse Shoulderpads
				{ 2, 50450 },	-- Leggings of Dubious Charms
				{ 3, 50451 },	-- Belt of the Lonely Noble
				{ 4, 50452 },	-- Wodin's Lucky Necklace
				{ 5, 50447 },	-- Harbinger's Bone Band
				{ 6, 50453 },	-- Ring of Rotting Sinew
				{ 7, 50444 },	-- Rowan's Rifle of Silver Bullets
			},
		},
		T10_SET,
		WOTLK_ICC_AC_TABLE,
	}
}

-- The Ruby Sanctum / T10
data["RubySanctum"] = {
	EncounterJournalID = 761,
	MapID = 4987,
    InstanceID = 724,
    AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RubySanctum",
    AtlasMapFile = {"RubySanctum"},
	ContentType = RAID_CONTENT,
    -- LevelRange = {80, 80, 80},
	items = {
		{	--Halion
            name = AL["Halion"],
			EncounterJournalID = 1652,
            AtlasMapBossID = 4,
			[RAID10_DIFF] = {
				{ 1, 53115 },	-- Abduction's Cover
				{ 2, 53118 },	-- Misbegotten Belt
				{ 3, 53114 },	-- Gloaming Sark
				{ 4, 53117 },	-- Changeling Gloves
				{ 5, 53113 },	-- Twilight Scale Shoulders
				{ 6, 53119 },	-- Boots of Divided Being
				{ 7, 53112 },	-- Bracers of the Heir
				{ 8, 53121 },	-- Surrogate Belt
				{ 9, 53111 },	-- Scion's Treads
				{ 16, 53103 },	-- Baltharus' Gift
				{ 17, 53116 },	-- Saviana's Tribute
				{ 18, 53110 },	-- Zarithrian's Offering
				{ 20, "ac4817" },
			},
			[RAID10H_DIFF] = {
				{ 1, 54556 },	-- Abduction's Cover
				{ 2, 54562 },	-- Misbegotten Belt
				{ 3, 54561 },	-- Gloaming Sark
				{ 4, 54560 },	-- Changeling Gloves
				{ 5, 54566 },	-- Twilight Scale Shoulders
				{ 6, 54558 },	-- Boots of Divided Being
				{ 7, 54559 },	-- Bracers of the Heir
				{ 8, 54565 },	-- Surrogate Belt
				{ 9, 54564 },	-- Scion's Treads
				{ 16, 54557 },	-- Baltharus' Gift
				{ 17, 54563 },	-- Saviana's Tribute
				{ 18, 54567 },	-- Zarithrian's Offering
				{ 20, "ac4818" },
			},
			[RAID25_DIFF] = {
				{ 1, 53489 },	-- Cloak of Burning Dusk
				{ 2, 53486 },	-- Bracers of Fiery Night
				{ 3, 53134 },	-- Phaseshifter's Bracers
				{ 4, 53126 },	-- Umbrage Armbands
				{ 5, 53488 },	-- Split Shape Belt
				{ 6, 53127 },	-- Returning Footfalls
				{ 7, 53125 },	-- Apocalypse's Advance
				{ 8, 53487 },	-- Foreshadow Steps
				{ 9, 53129 },	-- Treads of Impending Resurrection
				{ 16, 53132 },	-- Penumbra Pendant
				{ 17, 53490 },	-- Ring of Phased Regeneration
				{ 18, 53133 },	-- Signet of Twilight
				{ 19, 54572 },	-- Charred Twilight Scale
				{ 20, 54573 },	-- Glowing Twilight Scale
				{ 21, 54571 },	-- Petrified Twilight Scale
				{ 22, 54569 },	-- Sharpened Twilight Scale
				{ 24, "ac4815" },
			},
			[RAID25H_DIFF] = {
				{ 1, 54583 },	-- Cloak of Burning Dusk
				{ 2, 54582 },	-- Bracers of Fiery Night
				{ 3, 54584 },	-- Phaseshifter's Bracers
				{ 4, 54580 },	-- Umbrage Armbands
				{ 5, 54587 },	-- Split Shape Belt
				{ 6, 54577 },	-- Returning Footfalls
				{ 7, 54578 },	-- Apocalypse's Advance
				{ 8, 54586 },	-- Foreshadow Steps
				{ 9, 54579 },	-- Treads of Impending Resurrection
				{ 16, 54581 },	-- Penumbra Pendant
				{ 17, 54585 },	-- Ring of Phased Regeneration
				{ 18, 54576 },	-- Signet of Twilight
				{ 19, 54588 },	-- Charred Twilight Scale
				{ 20, 54589 },	-- Glowing Twilight Scale
				{ 21, 54591 },	-- Petrified Twilight Scale
				{ 22, 54590 },	-- Sharpened Twilight Scale
				{ 24, "ac4816" },
			},
		},
        T10_SET,
	}
}

local ROLE_DD = AL["Damage Dealer"]
data["VaultofArchavon"] = {
	MapID = 4603,
	InstanceID = 624,
    ContentType = RAID_CONTENT,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "VaultOfArchavon",
	AtlasMapFile = {"VaultOfArchavon"},
	-- LevelRange = {80, 80, 80},
	items = {
        { -- VaultofArchavonArchavon
            name = AL["Archavon the Stone Watcher"],
            npcID = 31125,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 1,
            [RAID10_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_A_WARLOCK_10" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_A_PRIEST_10_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_A_PRIEST_10_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_A_ROGUE_10" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_A_HUNTER_10" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_A_WARRIOR_10_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_A_WARRIOR_10_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_A_DEATHKNIGHT_10_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_A_DEATHKNIGHT_10_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_A_MAGE_10" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_A_DRUID_10_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_A_DRUID_10_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_A_DRUID_10_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_A_SHAMAN_10_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_A_SHAMAN_10_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_A_SHAMAN_10_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_A_PALADIN_10_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_A_PALADIN_10_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_A_PALADIN_10_D" },
            },
            [RAID25_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_A_WARLOCK_25" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_A_PRIEST_25_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_A_PRIEST_25_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_A_ROGUE_25" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_A_HUNTER_25" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_A_WARRIOR_25_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_A_WARRIOR_25_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_A_DEATHKNIGHT_25_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_A_DEATHKNIGHT_25_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_A_MAGE_25" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_A_DRUID_25_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_A_DRUID_25_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_A_DRUID_25_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_A_SHAMAN_25_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_A_SHAMAN_25_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_A_SHAMAN_25_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_A_PALADIN_25_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_A_PALADIN_25_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_A_PALADIN_25_D" },
            }
        },
        { -- VaultofArchavonEmalon
            name = AL["Emalon the Storm Watcher"],
            npcID = 33993,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 2,
            [RAID10_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_E_WARLOCK_10" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_E_PRIEST_10_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_E_PRIEST_10_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_E_ROGUE_10" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_E_HUNTER_10" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_E_WARRIOR_10_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_E_WARRIOR_10_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_E_DEATHKNIGHT_10_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_E_DEATHKNIGHT_10_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_E_MAGE_10" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_E_DRUID_10_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_E_DRUID_10_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_E_DRUID_10_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_E_SHAMAN_10_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_E_SHAMAN_10_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_E_SHAMAN_10_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_E_PALADIN_10_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_E_PALADIN_10_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_E_PALADIN_10_D" },
            },
            [RAID25_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_E_WARLOCK_25" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_E_PRIEST_25_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_E_PRIEST_25_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_E_ROGUE_25" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_E_HUNTER_25" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_E_WARRIOR_25_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_E_WARRIOR_25_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_E_DEATHKNIGHT_25_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_E_DEATHKNIGHT_25_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_E_MAGE_25" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_E_DRUID_25_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_E_DRUID_25_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_E_DRUID_25_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_E_SHAMAN_25_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_E_SHAMAN_25_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_E_SHAMAN_25_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_E_PALADIN_25_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_E_PALADIN_25_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_E_PALADIN_25_D" },
            }
        },
        { -- VaultofArchavonKoralon_Alliance
            name = AL["Koralon the Flame Watcher"],
            npcID = 35013,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 3,
            [RAID10_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                AtlasLoot:GetRetByFaction("VoA_KH_WARLOCK_10", "VoA_KA_WARLOCK_10") },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         AtlasLoot:GetRetByFaction("VoA_KH_PRIEST_10_H", "VoA_KA_PRIEST_10_H") },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       AtlasLoot:GetRetByFaction("VoA_KH_PRIEST_10_D", "VoA_KA_PRIEST_10_D") },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                AtlasLoot:GetRetByFaction("VoA_KH_ROGUE_10", "VoA_KA_ROGUE_10") },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                AtlasLoot:GetRetByFaction("VoA_KH_HUNTER_10", "VoA_KA_HUNTER_10") },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   AtlasLoot:GetRetByFaction("VoA_KH_WARRIOR_10_T", "VoA_KA_WARRIOR_10_T") },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            AtlasLoot:GetRetByFaction("VoA_KH_WARRIOR_10_D", "VoA_KA_WARRIOR_10_D") },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        AtlasLoot:GetRetByFaction("VoA_KH_DEATHKNIGHT_10_T", "VoA_KA_DEATHKNIGHT_10_T") },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            AtlasLoot:GetRetByFaction("VoA_KH_DEATHKNIGHT_10_D", "VoA_KA_DEATHKNIGHT_10_D") },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                AtlasLoot:GetRetByFaction("VoA_KH_MAGE_10", "VoA_KA_MAGE_10") },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  AtlasLoot:GetRetByFaction("VoA_KH_DRUID_10_H", "VoA_KA_DRUID_10_H") },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      AtlasLoot:GetRetByFaction("VoA_KH_DRUID_10_DR", "VoA_KA_DRUID_10_DR") },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        AtlasLoot:GetRetByFaction("VoA_KH_DRUID_10_D", "VoA_KA_DRUID_10_D") },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_10_H", "VoA_KA_SHAMAN_10_H") },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_10_DR", "VoA_KA_SHAMAN_10_DR") },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_10_D", "VoA_KA_SHAMAN_10_D") },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_10_T", "VoA_KA_PALADIN_10_T") },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_10_H", "VoA_KA_PALADIN_10_H") },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_10_D", "VoA_KA_PALADIN_10_D") },
                { 101, "SLOT_CLOTH",        nil, ALIL["Cloth"],         nil,  "VoA_K_CLOTH_10" },
                { 102, "SLOT_LEATHER",      nil, ALIL["Leather"],       nil,  "VoA_K_LEATHER_10" },
                { 103, "SLOT_MAIL",         nil, ALIL["Mail"],          nil,  "VoA_K_MAIL_10" },
                { 104, "SLOT_PLATE",        nil, ALIL["Plate"],         nil,  "VoA_K_PLATE_10" },
                { 106, "SLOT_BACK",         nil, ALIL["Back"],          nil,  "VoA_K_BACK_10" },
                { 107, "SLOT_NECK",         nil, ALIL["Neck"],          nil,  "VoA_K_NECK_10" },
                { 108, "SLOT_FINGER",       nil, ALIL["Finger"],        nil,  "VoA_K_FINGER_10" },
                { 116, AtlasLoot:GetRetByFaction(44083, 43959 ) }, -- Reins of the Grand Black War Mammoth
            },
            [RAID25_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                AtlasLoot:GetRetByFaction("VoA_KH_WARLOCK_25", "VoA_KA_WARLOCK_25") },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         AtlasLoot:GetRetByFaction("VoA_KH_PRIEST_25_H", "VoA_KA_PRIEST_25_H") },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       AtlasLoot:GetRetByFaction("VoA_KH_PRIEST_25_D", "VoA_KA_PRIEST_25_D") },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                AtlasLoot:GetRetByFaction("VoA_KH_ROGUE_25", "VoA_KA_ROGUE_25") },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                AtlasLoot:GetRetByFaction("VoA_KH_HUNTER_25", "VoA_KA_HUNTER_25") },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   AtlasLoot:GetRetByFaction("VoA_KH_WARRIOR_25_T", "VoA_KA_WARRIOR_25_T") },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            AtlasLoot:GetRetByFaction("VoA_KH_WARRIOR_25_D", "VoA_KA_WARRIOR_25_D") },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        AtlasLoot:GetRetByFaction("VoA_KH_DEATHKNIGHT_25_T", "VoA_KA_DEATHKNIGHT_25_T") },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            AtlasLoot:GetRetByFaction("VoA_KH_DEATHKNIGHT_25_D", "VoA_KA_DEATHKNIGHT_25_D") },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                AtlasLoot:GetRetByFaction("VoA_KH_MAGE_25", "VoA_KA_MAGE_25") },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  AtlasLoot:GetRetByFaction("VoA_KH_DRUID_25_H", "VoA_KA_DRUID_25_H") },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      AtlasLoot:GetRetByFaction("VoA_KH_DRUID_25_DR", "VoA_KA_DRUID_25_DR") },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        AtlasLoot:GetRetByFaction("VoA_KH_DRUID_25_D", "VoA_KA_DRUID_25_D") },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_25_H", "VoA_KA_SHAMAN_25_H") },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_25_DR", "VoA_KA_SHAMAN_25_DR") },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  AtlasLoot:GetRetByFaction("VoA_KH_SHAMAN_25_D", "VoA_KA_SHAMAN_25_D") },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_25_T", "VoA_KA_PALADIN_25_T") },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_25_H", "VoA_KA_PALADIN_25_H") },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  AtlasLoot:GetRetByFaction("VoA_KH_PALADIN_25_D", "VoA_KA_PALADIN_25_D") },
                { 101, "SLOT_CLOTH",        nil, ALIL["Cloth"],         nil,  "VoA_K_CLOTH_25" },
                { 102, "SLOT_LEATHER",      nil, ALIL["Leather"],       nil,  "VoA_K_LEATHER_25" },
                { 103, "SLOT_MAIL",         nil, ALIL["Mail"],          nil,  "VoA_K_MAIL_25" },
                { 104, "SLOT_PLATE",        nil, ALIL["Plate"],         nil,  "VoA_K_PLATE_25" },
                { 106, "SLOT_BACK",         nil, ALIL["Back"],          nil,  "VoA_K_BACK_25" },
                { 107, "SLOT_NECK",         nil, ALIL["Neck"],          nil,  "VoA_K_NECK_25" },
                { 108, "SLOT_FINGER",       nil, ALIL["Finger"],        nil,  "VoA_K_FINGER_25" },
                { 116, AtlasLoot:GetRetByFaction(44083, 43959 ) }, -- Reins of the Grand Black War Mammoth
            }
        },
        { -- VaultofArchavonEmalon
            name = AL["Toravon the Ice Watcher"],
            npcID = 38433,
            Level = 999,
            --DisplayIDs = {{17386}},
            AtlasMapBossID = 4,
            [RAID10_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_T_WARLOCK_10" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_T_PRIEST_10_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_T_PRIEST_10_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_T_ROGUE_10" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_T_HUNTER_10" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_T_WARRIOR_10_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_T_WARRIOR_10_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_T_DEATHKNIGHT_10_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_T_DEATHKNIGHT_10_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_T_MAGE_10" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_T_DRUID_10_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_T_DRUID_10_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_T_DRUID_10_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_T_SHAMAN_10_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_T_SHAMAN_10_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_T_SHAMAN_10_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_T_PALADIN_10_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_T_PALADIN_10_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_T_PALADIN_10_D" },
                { 101, "SLOT_CLOTH",        nil, ALIL["Cloth"],         nil,  "VoA_T_CLOTH_10" },
                { 102, "SLOT_LEATHER",      nil, ALIL["Leather"],       nil,  "VoA_T_LEATHER_10" },
                { 103, "SLOT_MAIL",         nil, ALIL["Mail"],          nil,  "VoA_T_MAIL_10" },
                { 104, "SLOT_PLATE",        nil, ALIL["Plate"],         nil,  "VoA_T_PLATE_10" },
                { 106, "SLOT_BACK",         nil, ALIL["Back"],          nil,  "VoA_T_BACK_10" },
                { 107, "SLOT_NECK",         nil, ALIL["Neck"],          nil,  "VoA_T_NECK_10" },
                { 108, "SLOT_FINGER",       nil, ALIL["Finger"],        nil,  "VoA_T_FINGER_10" },
                { 116, AtlasLoot:GetRetByFaction(44083, 43959 ) }, -- Reins of the Grand Black War Mammoth
            },
            [RAID25_DIFF] = {
                { 1, "CLASS_WARLOCK",       nil, CLASS_NAME["WARLOCK"],     nil,                "VoA_T_WARLOCK_25" },
                { 3, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Holy"],         "VoA_T_PRIEST_25_H" },
                { 4, "CLASS_PRIEST",        nil, CLASS_NAME["PRIEST"],      AL["Shadow"],       "VoA_T_PRIEST_25_D" },
                { 6, "CLASS_ROGUE",         nil, CLASS_NAME["ROGUE"],       nil,                "VoA_T_ROGUE_25" },
                { 8, "CLASS_HUNTER",        nil, CLASS_NAME["HUNTER"],      nil,                "VoA_T_HUNTER_25" },
                { 10, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     AL["Protection"],   "VoA_T_WARRIOR_25_T" },
                { 11, "CLASS_WARRIOR",      nil, CLASS_NAME["WARRIOR"],     ROLE_DD,            "VoA_T_WARRIOR_25_D" },
                { 13, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], AL["Blood"],        "VoA_T_DEATHKNIGHT_25_T" },
                { 14, "CLASS_DEATHKNIGHT",  nil, CLASS_NAME["DEATHKNIGHT"], ROLE_DD,            "VoA_T_DEATHKNIGHT_25_D" },
                { 16, "CLASS_MAGE",         nil, CLASS_NAME["MAGE"],        nil,                "VoA_T_MAGE_25" },
                { 18, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Restoration"],  "VoA_T_DRUID_25_H" },
                { 19, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Balance"],      "VoA_T_DRUID_25_DR" },
                { 20, "CLASS_DRUID",        nil, CLASS_NAME["DRUID"],       AL["Feral"],        "VoA_T_DRUID_25_D" },
                { 22, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Restoration"],  "VoA_T_SHAMAN_25_H" },
                { 23, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Elemental"],    "VoA_T_SHAMAN_25_DR" },
                { 24, "CLASS_SHAMAN",       nil, CLASS_NAME["SHAMAN"],      AL["Enhancement"],  "VoA_T_SHAMAN_25_D" },
                { 26, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Protection"],   "VoA_T_PALADIN_25_T" },
                { 27, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Holy"],         "VoA_T_PALADIN_25_H" },
                { 28, "CLASS_PALADIN",      nil, CLASS_NAME["PALADIN"],     AL["Retribution"],  "VoA_T_PALADIN_25_D" },
                { 101, "SLOT_CLOTH",        nil, ALIL["Cloth"],         nil,  "VoA_T_CLOTH_25" },
                { 102, "SLOT_LEATHER",      nil, ALIL["Leather"],       nil,  "VoA_T_LEATHER_25" },
                { 103, "SLOT_MAIL4",        nil, ALIL["Mail"],          nil,  "VoA_T_MAIL_25" },
                { 104, "SLOT_PLATE",        nil, ALIL["Plate"],         nil,  "VoA_T_PLATE_25" },
                { 106, "SLOT_BACK",         nil, ALIL["Back"],          nil,  "VoA_T_BACK_25" },
                { 107, "SLOT_NECK",         nil, ALIL["Neck"],          nil,  "VoA_T_NECK_25" },
                { 108, "SLOT_FINGER",       nil, ALIL["Finger"],        nil,  "VoA_T_FINGER_25" },
                { 116, AtlasLoot:GetRetByFaction(44083, 43959 ) }, -- Reins of the Grand Black War Mammoth
            }
        },
        KEYS
    }
}
