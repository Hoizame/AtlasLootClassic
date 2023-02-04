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
local data = AtlasLoot.ItemDB:Add(addonname, 1, 0)

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

data["TierSets"] = {
	name = AL["Tier Sets"],
	ContentType = SET_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- T1
			name = format(AL["Tier %s Sets"], "1"),
			CoinTexture = "CLASSIC",
			[NORMAL_DIFF] = {
				{ 1, 203 }, -- Warlock
				{ 3, 202 }, -- Priest
				{ 16, 201 }, -- Mage
				{ 5, 204 }, -- Rogue
				{ 20, 205 }, -- Druid
				{ 7, 206 }, -- Hunter
				{ 9, 209 }, -- Warrior
				{ 22, 207 }, -- Shaman
				{ 24, 208 }, -- Paladin
			},
		},
		{ -- T2
			name = format(AL["Tier %s Sets"], "2"),
			CoinTexture = "CLASSIC",
			[NORMAL_DIFF] = {
				{ 1, 212 }, -- Warlock
				{ 3, 211 }, -- Priest
				{ 16, 210 }, -- Mage
				{ 5, 213 }, -- Rogue
				{ 20, 214 }, -- Druid
				{ 7, 215 }, -- Hunter
				{ 9, 218 }, -- Warrior
				{ 22, 216 }, -- Shaman
				{ 24, 217 }, -- Paladin
			},
		},
		{ -- T2.5
			name = format(AL["Tier %s Sets"], "2.5"),
			CoinTexture = "CLASSIC",
			[NORMAL_DIFF] = {
				{ 1, 499 }, -- Warlock
				{ 3, 507 }, -- Priest
				{ 16, 503 }, -- Mage
				{ 5, 497 }, -- Rogue
				{ 20, 493 }, -- Druid
				{ 7, 509 }, -- Hunter
				{ 9, 496 }, -- Warrior
				{ 22, 501 }, -- Shaman
				{ 24, 505 }, -- Paladin
			},
		},
		{ -- T3
			name = format(AL["Tier %s Sets"], "3"),
			CoinTexture = "CLASSIC",
			[NORMAL_DIFF] = {
				{ 1, 529 }, -- Warlock
				{ 3, 525 }, -- Priest
				{ 16, 526 }, -- Mage
				{ 5, 524 }, -- Rogue
				{ 20, 521 }, -- Druid
				{ 7, 530 }, -- Hunter
				{ 9, 523 }, -- Warrior
				{ 22, 527 }, -- Shaman
				{ 24, 528 }, -- Paladin
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { -- T4
			name = format(AL["Tier %s Sets"], "4"),
			CoinTexture = "BC",
			[NORMAL_DIFF] = {
				{ 1,    645 }, -- Warlock
				{ 3,    663 }, -- Priest / Heal
				{ 4,    664 }, -- Priest / Shadow
				{ 6,    621 }, -- Rogue
				{ 8,    651 }, -- Hunter
				{ 10,    654 }, -- Warrior / Prot
				{ 11,    655 }, -- Warrior / DD
				{ 16,   648 }, -- Mage
				{ 18,   638 }, -- Druid / Heal
				{ 19,   639 }, -- Druid / Owl
				{ 20,   640 }, -- Druid / Feral
				{ 22,   631 }, -- Shaman / Heal
				{ 23,   632 }, -- Shaman / Ele
				{ 24,   633 }, -- Shaman / Enh
				{ 26,   624 }, -- Paladin / Heal
				{ 27,   625 }, -- Paladin / Prot
				{ 28,   626 }, -- Paladin / DD
			},
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { -- T5
			name = format(AL["Tier %s Sets"], "5"),
			CoinTexture = "BC",
			[NORMAL_DIFF] = {
				{ 1,    646 }, -- Warlock
				{ 3,    665 }, -- Priest / Heal
				{ 4,    666 }, -- Priest / Shadow
				{ 6,    622 }, -- Rogue
				{ 8,    652 }, -- Hunter
				{ 10,    656 }, -- Warrior / Prot
				{ 11,    657 }, -- Warrior / DD
				{ 16,   649 }, -- Mage
				{ 18,   642 }, -- Druid / Heal
				{ 19,   643 }, -- Druid / Owl
				{ 20,   641 }, -- Druid / Feral
				{ 22,   634 }, -- Shaman / Heal
				{ 23,   635 }, -- Shaman / Ele
				{ 24,   636 }, -- Shaman / Enh
				{ 26,   627 }, -- Paladin / Heal
				{ 27,   628 }, -- Paladin / Prot
				{ 28,   629 }, -- Paladin / DD
			},
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, {
			name = format(AL["Tier %s Sets"], "6"),
			CoinTexture = "BC",
			[NORMAL_DIFF] = {
				{ 1,    670 }, -- Warlock
				{ 3,    675 }, -- Priest / Heal
				{ 4,    674 }, -- Priest / Shadow
				{ 6,    668 }, -- Rogue
				{ 8,    669 }, -- Hunter
				{ 10,    673 }, -- Warrior / Prot
				{ 11,    672 }, -- Warrior / DD
				{ 16,   671 }, -- Mage
				{ 18,   678 }, -- Druid / Heal
				{ 19,   677 }, -- Druid / Owl
				{ 20,   676 }, -- Druid / Feral
				{ 22,   683 }, -- Shaman / Heal
				{ 23,   684 }, -- Shaman / Ele
				{ 24,   682 }, -- Shaman / Enh
				{ 26,   681 }, -- Paladin / Heal
				{ 27,   679 }, -- Paladin / Prot
				{ 28,   680 }, -- Paladin / DD
			},
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = format(AL["Tier %s Sets"], "7"),
			CoinTexture = "WRATH",
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
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = format(AL["Tier %s Sets"], "8"),
			CoinTexture = "WRATH",
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
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = format(AL["Tier %s Sets"], "9"),
			CoinTexture = "WRATH",
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
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = format(AL["Tier %s Sets"], "10"),
			CoinTexture = "WRATH",
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
		}),
	},
}

data["DungeonSets"] = {
	name = AL["Dungeon Sets"],
	ContentType = SET_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- T0 / D1
			name = format(AL["Dungeon Set %s"], "1"),
			[NORMAL_DIFF] = {
				{ 1, 183 }, -- Warlock
				{ 3, 182 }, -- Priest
				{ 16, 181 }, -- Mage
				{ 5, 184 }, -- Rogue
				{ 20, 185 }, -- Druid
				{ 7, 186 }, -- Hunter
				{ 9, 189 }, -- Warrior
				{ 22, 187 }, -- Shaman
				{ 24, 188 }, -- Paladin
			},
		},
		{ -- T0.5 / D2
			name = format(AL["Dungeon Set %s"], "2"),
			[NORMAL_DIFF] = {
				{ 1, 518 }, -- Warlock
				{ 3, 514 }, -- Priest
				{ 16, 517 }, -- Mage
				{ 5, 512 }, -- Rogue
				{ 20, 513 }, -- Druid
				{ 7, 515 }, -- Hunter
				{ 9, 511 }, -- Warrior
				{ 22, 519 }, -- Shaman
				{ 24, 516 }, -- Paladin
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { -- T0.5 / D2
			name = format(AL["Dungeon Set %s"], "3"),
			[NORMAL_DIFF] = {
				{ 1, 658 },
				{ 2, 647 },
				{ 3, 644 },
				{ 4, 662 },
				{ 6, 659 },
				{ 7, 637 },
				{ 8, 620 },
				{ 16, 650 },
				{ 17, 660 },
				{ 18, 630 },
				{ 20, 623 },
				{ 21, 661 },
				{ 22, 653 },
			},
		}),
	}
}

data["ZGSets"] = {
	name = format(AL["%s Sets"], C_Map_GetAreaInfo(1977)),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	ContentPhase = 4,
	items = {
		{
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(1977)),
			[ALLIANCE_DIFF] = {
				{ 1,  481 }, -- Warlock
				{ 3,  480 }, -- Priest
				{ 16, 482 }, -- Mage
				{ 5,  478 }, -- Rogue
				{ 20, 479 }, -- Druid
				{ 7,  477 }, -- Hunter
				{ 9,  474 }, -- Warrior
				{ 24, 475 }, -- Paladin
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, 476 }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
		{ -- Misc
			name = format(AL["%s Sets"], AL["Misc"]),
			[NORMAL_DIFF] = {
				-- Swords
				{ 1,  461 }, -- Warblade of the Hakkari
				{ 3,  463 }, -- Primal Blessing
				-- Rings
				{ 16,  466 }, -- Major Mojo Infusion
				{ 17,  462 }, -- Zanzil's Concentration
				{ 18,  465 }, -- Prayer of the Primal
				{ 19,  464 }, -- Overlord's Resolution
			},
		},
	},
}

data["AQSets"] = {
	name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428)),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	ContentPhase = 5,
	items = {
		{ -- AQ20
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 20"),
			[ALLIANCE_DIFF] = {
				{ 1,  500 }, -- Warlock
				{ 3,  508 }, -- Priest
				{ 16, 504 }, -- Mage
				{ 5,  498 }, -- Rogue
				{ 20, 494 }, -- Druid
				{ 7,  510 }, -- Hunter
				{ 9,  495 }, -- Warrior
				{ 24, 506 }, -- Paladin
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, 502 }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
		{ -- AQ40
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 40"),
			[ALLIANCE_DIFF] = {
				{ 1,  499 }, -- Warlock
				{ 3,  507 }, -- Priest
				{ 16, 503 }, -- Mage
				{ 5,  497 }, -- Rogue
				{ 20, 493 }, -- Druid
				{ 7,  509 }, -- Hunter
				{ 9,  496 }, -- Warrior
				{ 24, 505 }, -- Paladin
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, 501 }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
	},
}

data["MiscSets"] = {
	name = format(AL["%s Sets"], AL["Misc"]),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Cloth
			name = ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1,  421 }, -- Bloodvine Garb / 65
				{ 2,  520 }, -- Ironweave Battlesuit / 61-63
				{ 3,  122 }, -- Necropile Raiment / 61
				{ 4,  81 }, -- Twilight Trappings / 61
				{ 5,  492 }, -- Twilight Trappings / 60
				{ 16,  536 }, -- Regalia of Undead Cleansing / 63
			},
		},
		{ -- Leather
			name = ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1,  442 }, -- Blood Tiger Harness / 65
				{ 2,  441 }, -- Primal Batskin / 65
				{ 3,  121 }, -- Cadaverous Garb / 61
				{ 4,  142 }, -- Stormshroud Armor / 55-62
				{ 5,  141 }, -- Volcanic Armor / 54-61
				{ 6,  143 }, -- Devilsaur Armor / 58-60
				{ 7,  144 }, -- Ironfeather Armor / 54-58
				{ 8,  534 }, -- Undead Slayer's Armor / 63
				{ 9,  161 }, -- Defias Leather / 18-24
				{ 10,  162 }, -- Embrace of the Viper / 19-23
				{ 16,  221 }, -- Garb of Thero-shan / 32-42
			},
		},
		{ -- Mail
			name = ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1,  443 }, -- Bloodsoul Embrace / 65
				{ 2,  123 }, -- Bloodmail Regalia / 61
				{ 3,  489 }, -- Black Dragon Mail / 58-62
				{ 4,  491 }, -- Blue Dragon Mail / 57-60
				{ 5,  1 }, -- The Gladiator / 57
				{ 6,  490 }, -- Green Dragon Mail / 52-56
				{ 7,  163 }, -- Chain of the Scarlet Crusade / 35-43
				{ 16,  535 }, -- Garb of the Undead Slayer / 63
			},
		},
		{ -- Plate
			name = ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1,  444 }, -- The Darksoul / 65
				{ 2,  124 }, -- Deathbone Guardian / 61
				{ 3,  321 }, -- Imperial Plate / 53-61
				{ 16,  533 }, -- Battlegear of Undead Slaying / 63
			},
		},
		{ -- Misc
			name = format(AL["%s Sets"], AL["Misc"]),
			[NORMAL_DIFF] = {
				-- Fist weapons
				{ 1,  261 }, -- Spirit of Eskhandar
				-- Swords
				{ 3,  41 }, -- Dal'Rend's Arms
				-- Dagger / Mace
				{ 5,  65 }, -- Spider's Kiss
				-- Trinket
				{ 16,  241 }, -- Shard of the Gods / 60
			},
		},
	},
}

data["WorldEpics"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["One-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Mace
				{ 1, 2243 }, -- Hand of Edward the Odd
				{ 2, 810 }, -- Hammer of the Northern Wind
				{ 3, 868 }, -- Ardent Custodian
				-- Axe
				{ 7, 811 }, -- Axe of the Deep Woods
				{ 8, 871 }, -- Flurry Axe
				-- Sword
				{ 16, 1728 }, -- Teebu's Blazing Longsword
				{ 17, 20698 }, -- Elemental Attuned Blade
				{ 18, 2244 }, -- Krol Blade
				{ 19, 809 }, -- Bloodrazor
				{ 20, 869 }, -- Dazzling Longsword
				-- Dagger
				{ 22, 14555 }, -- Alcor's Sunrazor
				{ 23, 2163 }, -- Shadowblade
				{ 24, 2164 }, -- Gut Ripper
			},
		},
		{
			name = AL["Two-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Axe
				{ 1, 2801 }, -- Blade of Hanna
				{ 2, 647 }, -- Destiny
				{ 3, 2291 }, -- Kang the Decapitator
				{ 4, 870 }, -- Fiery War Axe
				-- Mace
				{ 6, 2915 }, -- Taran Icebreaker
				-- Sword
				{ 16, 1263 }, -- Brain Hacker
				{ 17, 1982 }, -- Nightblade
				-- Staff
				{ 21, 944 }, -- Elemental Mage Staff
				{ 22, 812 }, -- Glowing Brightwood Staff
				{ 23, 943 }, -- Warden Staff
				{ 24, 873 }, -- Staff of Jordan
			},
		},
		{
			name = AL["Ranged Weapons"].." & "..ALIL["Shield"],
			[NORMAL_ITTYPE] = {
				-- Bow
				{ 1, 2824 }, -- Hurricane
				{ 2, 2825 }, -- Bow of Searing Arrows
				-- Gun
				{ 4, 2099 }, -- Dwarven Hand Cannon
				{ 5, 2100 }, -- Precisely Calibrated Boomstick
				-- Shield
				{ 16, 1168 }, -- Skullflame Shield
				{ 17, 1979 }, -- Wall of the Dead
				{ 18, 1169 }, -- Blackskull Shield
				{ 19, 1204 }, -- The Green Tower
			},
		},
		{
			name = ALIL["Trinket"].." & "..ALIL["Finger"].." & "..ALIL["Neck"],
			[NORMAL_ITTYPE] = {
				-- Trinket
				{ 1, 14557 }, -- The Lion Horn of Stormwind
				{ 2, 833 }, -- Lifestone
				-- Neck
				{ 6,  14558 }, -- Lady Maye's Pendant
				{ 7,  1443 }, -- Jeweled Amulet of Cainwyn
				{ 8,  1315 }, -- Lei of Lilies
				--Finger
				{ 16,  2246 }, -- Myrmidon's Signet
				{ 17,  942 }, -- Freezing Band
				{ 18,  1447 }, -- Ring of Saviors
				{ 19,  1980 }, -- Underworld Band
			},
		},
		{
			name = AL["Equip"],
			[NORMAL_ITTYPE] = {
				-- Cloth
				{ 1,  3075 }, -- Eye of Flame
				{ 2,  940 }, -- Robes of Insight
				-- Mail
				{ 4,  2245 }, -- Helm of Narv
				{ 5,  17007 }, -- Stonerender Gauntlets
				{ 6,  14551 }, -- Edgemaster's Handguards
				{ 7,  1981 }, -- Icemail Jerkin
				-- Back
				{ 9,  3475 }, -- Cloak of Flames
				-- Leather
				{ 16,  14553 }, -- Sash of Mercy
				{ 17,  867 }, -- Gloves of Holy Might
				-- Plate
				{ 19,  14554 }, -- Cloudkeeper Legplates
				{ 20,  14552 }, -- Stockade Pauldrons
				{ 21,  14549 }, -- Boots of Avoidance
			},
		},
	},
}

data["Mounts"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["Faction Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,  18785 }, -- Swift White Ram
				{ 2,  18786 }, -- Swift Brown Ram
				{ 3,  18787 }, -- Swift Gray Ram
				{ 16,  5873 }, -- White Ram
				{ 17,  5872 }, -- Brown Ram
				{ 18,  5864 }, -- Gray Ram
				{ 5,  18772 }, -- Swift Green Mechanostrider
				{ 6,  18773 }, -- Swift White Mechanostrider
				{ 7,  18774 }, -- Swift Yellow Mechanostrider
				{ 20,  13321 }, -- Green Mechanostrider
				{ 21,  13322 }, -- Unpainted Mechanostrider
				{ 22,  8563 }, -- Red Mechanostrider
				{ 23,  8595 }, -- Blue Mechanostrider
				{ 10,  18776 }, -- Swift Palomino
				{ 11,  18777 }, -- Swift Brown Steed
				{ 12,  18778 }, -- Swift White Steed
				{ 25,  2414 }, -- Pinto Bridle
				{ 26,  5656 }, -- Brown Horse Bridle
				{ 27,  5655 }, -- Chestnut Mare Bridle
				{ 28,  2411 }, -- Black Stallion Bridle
				{ 101,  18902 }, -- Reins of the Swift Stormsaber
				{ 102,  18767 }, -- Reins of the Swift Mistsaber
				{ 103,  18766 }, -- Reins of the Swift Frostsaber
				{ 116,  8632 }, -- Reins of the Spotted Frostsaber
				{ 117,  8631 }, -- Reins of the Striped Frostsaber
				{ 118,  8629 }, -- Reins of the Striped Nightsaber
			},
			[HORDE_DIFF] = {
				{ 1,  18798 }, -- Horn of the Swift Gray Wolf
				{ 2,  18797 }, -- Horn of the Swift Timber Wolf
				{ 3,  18796 }, -- Horn of the Swift Brown Wolf
				{ 16,  5668 }, -- Horn of the Brown Wolf
				{ 17,  5665 }, -- Horn of the Dire Wolf
				{ 18,  1132 }, -- Horn of the Timber Wolf
				{ 5,  18795 }, -- Great Gray Kodo
				{ 6,  18794 }, -- Great Brown Kodo
				{ 7,  18793 }, -- Great White Kodo
				{ 20,  15290 }, -- Brown Kodo
				{ 21,  15277 }, -- Gray Kodo
				{ 9,  18790 }, -- Swift Orange Raptor
				{ 10,  18789 }, -- Swift Olive Raptor
				{ 11,  18788 }, -- Swift Blue Raptor
				{ 24,  8592 }, -- Whistle of the Violet Raptor
				{ 25,  8591 }, -- Whistle of the Turquoise Raptor
				{ 26,  8588 }, -- Whistle of the Emerald Raptor
				{ 13,  18791 }, -- Purple Skeletal Warhorse
				{ 14,  13334 }, -- Green Skeletal Warhorse
				{ 28,  13333 }, -- Brown Skeletal Horse
				{ 29,  13332 }, -- Blue Skeletal Horse
				{ 30,  13331 }, -- Red Skeletal Horse
			},
		},
		{ -- PvPMountsPvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1,  19030 }, -- Stormpike Battle Charger
				{ 3,  GetForVersion(18244,29467) }, -- Black War Ram
				{ 4,  GetForVersion(18243,29465) }, -- Black Battlestrider
				{ 5,  GetForVersion(18241,29468) }, -- Black War Steed Bridle
				{ 6,  GetForVersion(18242,29471) }, -- Reins of the Black War Tiger
			},
			[HORDE_DIFF] = {
				{ 1, 19029 }, -- Horn of the Frostwolf Howler
				{ 3, GetForVersion(18245,29469) }, -- Horn of the Black War Wolf
				{ 4, GetForVersion(18247,29466) }, -- Black War Kodo
				{ 5, GetForVersion(18246,29472) }, -- Whistle of the Black War Raptor
				{ 6, GetForVersion(18248,29470) }, -- Red Skeletal Warhorse
			},
		},
		{ -- Drops
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 13335 }, -- Deathcharger's Reins
				{ 3, 19872 }, -- Swift Razzashi Raptor
				{ 5, 19902 }, -- Swift Zulian Tiger
			},
		},
		{ -- Reputation
			name = AL["Reputation"],
			[ALLIANCE_DIFF] = {
				{ 1, 13086 }, -- Reins of the Winterspring Frostsaber
			}
		},
		{
			name = ALIL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 21176 }, -- Black Qiraji Resonating Crystal
				{ 3, 23720 }, -- Riding Turtle
			},
		},
		{ -- AQ40
			MapID = 3428,
			[NORMAL_DIFF] = {
				{ 1, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 2, 21323 }, -- Green Qiraji Resonating Crystal
				{ 3, 21321 }, -- Red Qiraji Resonating Crystal
				{ 4, 21324 }, -- Yellow Qiraji Resonating Crystal
			},
		},
	},
}

data["Companions"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1, 15996 }, -- Lifelike Mechanical Toad
				{ 2, 11826 }, -- Lil' Smoky
				{ 3, 4401 }, -- Mechanical Squirrel Box
				{ 4, 11825 }, -- Pet Bombling
				{ 5, 21277 }, -- Tranquil Mechanical Yeti
			},
		},
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 8494 }, -- Parrot Cage (Hyacinth Macaw)
				{ 2, 8492 }, -- Parrot Cage (Green Wing Macaw)
				{ 4, 8498 }, -- Tiny Emerald Whelpling
				{ 5, 8499 }, -- Tiny Crimson Whelpling
				{ 6, 10822 }, -- Dark Whelpling
				{ 8, 8490 }, -- Cat Carrier (Siamese)
				{ 9, 8491 }, -- Cat Carrier (Black Tabby)
				{ 16, 20769 }, -- Disgusting Oozeling
				{ 17, 11110 }, -- Chicken Egg
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
				{ 1, 12264 }, -- Worg Carrier
				{ 2, 11474 }, -- Sprite Darter Egg
				{ 3, 12529 }, -- Smolderweb Carrier
				{ 4, 10398 }, -- Mechanical Chicken
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 11023 }, -- Ancona Chicken
				{ 2, 10393 }, -- Cockroach
				{ 3, 10394 }, -- Prairie Dog Whistle
				{ 4, 10392 }, -- Crimson Snake
				{ 5, 8497 }, -- Rabbit Crate (Snowshoe)
				{ 7, 10360 }, -- Black Kingsnake
				{ 8, 10361 }, -- Brown Snake
				{ 10, 8500 }, -- Great Horned Owl
				{ 11, 8501 }, -- Hawk Owl
				{ 16, 8485 }, -- Cat Carrier (Bombay)
				{ 17, 8486 }, -- Cat Carrier (Cornish Rex)
				{ 18, 8487 }, -- Cat Carrier (Orange Tabby)
				{ 19, 8490 }, -- Cat Carrier (Siamese)
				{ 20, 8488 }, -- Cat Carrier (Silver Tabby)
				{ 21, 8489 }, -- Cat Carrier (White Kitten)
				{ 23, 8496 }, -- Parrot Cage (Cockatiel)
				{ 24, 8495 }, -- Parrot Cage (Senegal)
				{ 26, 11026 }, -- Tree Frog Box
				{ 27, 11027 }, -- Wood Frog Box
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
				{ 1, 21305 }, -- Red Helper Box
				{ 2, 21301 }, -- Green Helper Box
				{ 3, 21308 }, -- Jingling Bell
				{ 4, 21309 }, -- Snowman Kit
				{ 16, 22235 }, -- Truesilver Shafted Arrow
				{ 18, 23083 }, -- Captured Flame
				{ 20, 23015 }, -- Rat Cage
				{ 21, 22781 }, -- Polar Bear Collar
				{ 22, 23007 }, -- Piglet's Collar
				{ 23, 23002 }, -- Turtle Box
			},
		},
		{ -- Unobtainable
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1, 13582 }, -- Zergling Leash
				{ 2, 13584 }, -- Diablo Stone
				{ 3, 13583 }, -- Panda Collar
				{ 16, 22780 }, -- White Murloc Egg
				{ 17, 22114 }, -- Pink Murloc Egg
				{ 18, 20651 }, -- Orange Murloc Egg
				{ 19, 20371 }, -- Blue Murloc Egg
			},
		},
	},
}

data["Tabards"] = {
	name = ALIL["Tabard"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.TABARDS,
	items = {
		{
			name = ALIL["Tabard"],
			[NORMAL_DIFF] = {
				{ 1, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		{ -- Faction
			name = AL["Capitals"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 45579 },	-- Darnassus Tabard
				{ 2, 45577 },	-- Ironforge Tabard
				{ 3, 45578 },	-- Gnomeregan Tabard
				{ 4, 45574 },	-- Stormwind Tabard
				{ 16, 45580 },	-- Exodar Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 17, 64882 }),	-- Gilneas Tabard
			},
			[HORDE_DIFF] = {
				{ 1, 45582 },	-- Darkspear Tabard
				{ 2, 45581 },	-- Orgrimmar Tabard
				{ 3, 45584 },	-- Thunder Bluff Tabard
				{ 4, 45583 },	-- Undercity Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 16, 45585 }),	-- Silvermoon City Tabard
			},
		},
		{
			name = format("%s - %s", AL["Factions"], AL["Classic"]),
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 43154 }, -- Tabard of the Argent Crusade
			},
		},
		{ -- PvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1, 15196 },	-- Private's Tabard
				{ 2, 15198 },	-- Knight's Colors
				{ 16, 19506 },	-- Silverwing Battle Tabard
				{ 17, 19032 },	-- Stormpike Battle Tabard
				{ 18, 20132 },	-- Arathor Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1, 15197 },	-- Scout's Tabard
				{ 2, 15199 },	-- Stone Guard's Herald
				{ 16, 19505 },	-- Warsong Battle Tabard
				{ 17, 19031 },	-- Frostwolf Battle Tabard
				{ 18, 20131 },	-- Battle Tabard of the Defilers
			},
		},
		{ -- PvP
			name = AL["Arena"],
			[NORMAL_DIFF] = {
				{ 1, 45983 },	-- Furious Gladiator's Tabard
				{ 2, 49086, },	-- Relentless Gladiator's Tabard
				{ 3, 51534 },	-- Wrathful Gladiator's Tabard
			},
		},
		{ -- Unobtainable Tabards
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1, 19160 },	-- Contest Winner's Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 3, 36941 }), -- Competitor's Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 5, 28788 }), -- Tabard of the Protector
				{ 16, "INV_Box_01", nil, AL["Card Game Tabards"], nil },
				{ 17, 38312 },	-- Tabard of Brilliance
				{ 18, 23705 },	-- Tabard of Flame
				{ 19, 23709 },	-- Tabard of Frost
				{ 20, 38313 },	-- Tabard of Fury
				{ 21, 38309 },	-- Tabard of Nature
				{ 22, 38310 },	-- Tabard of the Arcane
				{ 23, 38314 },	-- Tabard of the Defender
				{ 24, 38311 },	-- Tabard of the Void
			},
		},
	},
}

data["Legendarys"] = {
	name = AL["Legendarys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Legendarys"],
			[NORMAL_ITTYPE] = {
				{ 1,  19019 }, -- Thunderfury, Blessed Blade of the Windseeker

				{ 3,  22631 }, -- Atiesh, Greatstaff of the Guardian / Priest
				{ 4,  22589 }, -- Atiesh, Greatstaff of the Guardian / Mage
				{ 5,  22630 }, -- Atiesh, Greatstaff of the Guardian / Warlock
				{ 6,  22632 }, -- Atiesh, Greatstaff of the Guardian / Druid

				{ 16,  17182 }, -- Sulfuras, Hand of Ragnaros

				{ 18,  21176 }, -- Black Qiraji Resonating Crystal
			},
		},
		{
			name = ALIL["Quest Item"],
			[NORMAL_ITTYPE] = {
				{ 1,  19018 }, -- Dormant Wind Kissed Blade
				{ 2,  19017 }, -- Essence of the Firelord
				{ 3,  19016 }, -- Vessel of Rebirth
				{ 4,  18564 }, -- Bindings of the Windseeker / Right
				{ 5,  18563 }, -- Bindings of the Windseeker / Left
				{ 7,  17204 }, -- Eye of Sulfuras
				{ 9,  17771 }, -- Elementium Bar
				{ 16,  22736 }, -- Andonisus, Reaper of Souls
				{ 17,  22737 }, -- Atiesh, Greatstaff of the Guardian
				{ 18,  22733 }, -- Staff Head of Atiesh
				{ 19,  22734 }, -- Base of Atiesh
				{ 20,  22727 }, -- Frame of Atiesh
				{ 21,  22726 }, -- Splinter of Atiesh
			},
		},
		{
			name = AL["Unobtainable"],
			[NORMAL_ITTYPE] = {
				{ 1,  17782 }, -- Talisman of Binding Shard
				{ 16,  20221 }, -- Foror's Fabled Steed
			},
		},
	},
}

data["Darkmoon"] = {
	FactionID = 909,
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 3,
	items = {
		{ -- Exalted
			name = GetFactionInfoByID(909),
			[NORMAL_DIFF] = {
				{ 1,  19491, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Amulet of the Darkmoon
				{ 2,  19426, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Orb of the Darkmoon
				{ 4,  19293, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Last Year's Mutton
				{ 5,  19291, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Darkmoon Storage Box
				{ 7,  9249, 19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Schematic: Steam Tonk Controller
				{ 8,  19296, 19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Greater Darkmoon Prize
				{ 10,  19297, 19182, [ATLASLOOT_IT_AMOUNT2] = 12 }, -- Lesser Darkmoon Prize
				{ 12,  19292, 19182, [ATLASLOOT_IT_AMOUNT2] = 10 }, -- Last Month's Mutton
				{ 14,  19298, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Minor Darkmoon Prize
				{ 15,  19295, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Darkmoon Flower
			},
		},
		{
			name = AL["Classic"],
			[NORMAL_DIFF] = {
				{ 1,  19228 }, -- Darkmoon Card: Blue Dragon
				{ 2,  19267 }, -- Darkmoon Card: Maelstrom
				{ 3,  19257 }, -- Darkmoon Card: Heroism
				{ 4,  19277 }, -- Darkmoon Card: Twisting Nether
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, {
			name = AL["BC"],
			[NORMAL_DIFF] = {
				{ 1,  31907 }, -- Darkmoon Card: Vengeance
				{ 2,  31890 }, -- Darkmoon Card: Crusade
				{ 3,  31891 }, -- Darkmoon Card: Wrath
				{ 4,  31914 }, -- Darkmoon Card: Madness
			},
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = AL["Wrath"],
			[NORMAL_DIFF] = {
				{ 1, 44276 },	-- Chaos Deck
				{ 2, 44259 },	-- Prisms Deck
				{ 3, 44294 },	-- Undeath Deck
				{ 4, 44326 },	-- Nobles Deck
			},
		}),
	},
}

data["GurubashiArena"] = {
	name = AL["Gurubashi Arena"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- GurubashiArena
			name = AL["Gurubashi Arena"],
			[NORMAL_DIFF] = {
				{ 1,  18709 }, -- Arena Wristguards
				{ 2,  18710 }, -- Arena Bracers
				{ 3,  18711 }, -- Arena Bands
				{ 4,  18712 }, -- Arena Vambraces
				{ 16, 18706 }, -- Arena Master
			},
		},
	},
}

data["FishingExtravaganza"] = {
	name = AL["Stranglethorn Fishing Extravaganza"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- FishingExtravaganza
			name = AL["Stranglethorn Fishing Extravaganza"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["First Prize"] },
				{ 2,  19970 }, -- Arcanite Fishing Pole
				{ 3,  19979 }, -- Hook of the Master Angler
				{ 5, "INV_Box_01", nil, AL["Rare Fish"] },
				{ 6,  19805 }, -- Keefer's Angelfish
				{ 7,  19803 }, -- Brownell's Blue Striped Racer
				{ 8,  19806 }, -- Dezian Queenfish
				{ 9,  19808 }, -- Rockhide Strongfish
				{ 20, "INV_Box_01", nil, AL["Rare Fish Rewards"] },
				{ 21, 19972 }, -- Lucky Fishing Hat
				{ 22, 19969 }, -- Nat Pagle's Extreme Anglin' Boots
				{ 23, 19971 }, -- High Test Eternium Fishing Line
			},
		},
	},
}

data["LunarFestival"] = {
	name = AL["Lunar Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- LunarFestival1
			name = AL["Lunar Festival"],
			[NORMAL_DIFF] = {
				{ 1,  21100 }, -- Coin of Ancestry
				{ 3,  21157 }, -- Festive Green Dress
				{ 4,  21538 }, -- Festive Pink Dress
				{ 5,  21539 }, -- Festive Purple Dress
				{ 6,  21541 }, -- Festive Black Pant Suit
				{ 7,  21544 }, -- Festive Blue Pant Suit
				{ 8,  21543 }, -- Festive Teal Pant Suit
			},
		},
		{
			name = AL["Lunar Festival Fireworks Pack"],
			[NORMAL_DIFF] = {
				{ 1, 21558 }, -- Small Blue Rocket
				{ 2, 21559 }, -- Small Green Rocket
				{ 3, 21557 }, -- Small Red Rocket
				{ 4, 21561 }, -- Small White Rocket
				{ 5, 21562 }, -- Small Yellow Rocket
				{ 7, 21537 }, -- Festival Dumplings
				{ 8, 21713 }, -- Elune's Candle
				{ 16, 21589 }, -- Large Blue Rocket
				{ 17, 21590 }, -- Large Green Rocket
				{ 18, 21592 }, -- Large Red Rocket
				{ 19, 21593 }, -- Large White Rocket
				{ 20, 21595 }, -- Large Yellow Rocket
			}
		},
		{
			name = AL["Lucky Red Envelope"],
			[NORMAL_DIFF] = {
				{ 1, 21540 }, -- Elune's Lantern
				{ 2, 21536 }, -- Elune Stone
				{ 16, 21744 }, -- Lucky Rocket Cluster
				{ 17, 21745 }, -- Elder's Moonstone
			}
		},
		{ -- LunarFestival2
			name = AL["Plans"],
			[NORMAL_DIFF] = {
				{ 1,  21722 }, -- Pattern: Festival Dress
				{ 3,  21738 }, -- Schematic: Firework Launcher
				{ 5,  21724 }, -- Schematic: Small Blue Rocket
				{ 6,  21725 }, -- Schematic: Small Green Rocket
				{ 7,  21726 }, -- Schematic: Small Red Rocket
				{ 9, 21727 }, -- Schematic: Large Blue Rocket
				{ 10, 21728 }, -- Schematic: Large Green Rocket
				{ 11, 21729 }, -- Schematic: Large Red Rocket
				{ 16, 21723 }, -- Pattern: Festive Red Pant Suit
				{ 18, 21737 }, -- Schematic: Cluster Launcher
				{ 20, 21730 }, -- Schematic: Blue Rocket Cluster
				{ 21, 21731 }, -- Schematic: Green Rocket Cluster
				{ 22, 21732 }, -- Schematic: Red Rocket Cluster
				{ 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
				{ 25, 21734 }, -- Schematic: Large Green Rocket Cluster
				{ 26, 21735 }, -- Schematic: Large Red Rocket Cluster
			},
		},
	},
}

data["Valentineday"] = {
	name = AL["Love is in the Air"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Valentineday
			name = AL["Love is in the Air"],
			[NORMAL_DIFF] = {
				{ 1,  22206 }, -- Bouquet of Red Roses
				{ 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
				{ 4,  22279 }, -- Lovely Black Dress
				{ 5,  22235 }, -- Truesilver Shafted Arrow
				{ 6,  22200 }, -- Silver Shafted Arrow
				{ 7,  22261 }, -- Love Fool
				{ 8,  22218 }, -- Handful of Rose Petals
				{ 9,  21813 }, -- Bag of Candies
				{ 11, "INV_Box_02", nil, AL["Box of Chocolates"] },
				{ 12, 22237 }, -- Dark Desire
				{ 13, 22238 }, -- Very Berry Cream
				{ 14, 22236 }, -- Buttermilk Delight
				{ 15, 22239 }, -- Sweet Surprise
				{ 16, 22276 }, -- Lovely Red Dress
				{ 17, 22278 }, -- Lovely Blue Dress
				{ 18, 22280 }, -- Lovely Purple Dress
				{ 19, 22277 }, -- Red Dinner Suit
				{ 20, 22281 }, -- Blue Dinner Suit
				{ 21, 22282 }, -- Purple Dinner Suit
			},
		},
	},
}
data["Noblegarden"] = {
	name = AL["Noblegarden"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Noblegarden
			name = AL["Brightly Colored Egg"],
			[NORMAL_DIFF] = {
				{ 1,  19028 }, -- Elegant Dress
				{ 2,  6833 }, -- White Tuxedo Shirt
				{ 3,  6835 }, -- Black Tuxedo Pants
				{ 16,  7807 }, -- Candy Bar
				{ 17,  7808 }, -- Chocolate Square
				{ 18,  7806 }, -- Lollipop
			},
		},
	},
}

data["ChildrensWeek"] = {
	name = AL["Childrens Week"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ChildrensWeek
			name = AL["Childrens Week"],
			[NORMAL_DIFF] = {
				{ 1,  23007 }, -- Piglet's Collar
				{ 2,  23015 }, -- Rat Cage
				{ 3,  23002 }, -- Turtle Box
				{ 4,  23022 }, -- Curmudgeon's Payoff
			},
		},
	},
}

data["MidsummerFestival"] = {
	name = AL["Midsummer Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- MidsummerFestival
			name = AL["Midsummer Festival"],
			[NORMAL_DIFF] = {
				{ 1,  23379 }, -- Cinder Bracers
				{ 3,  23323 }, -- Crown of the Fire Festival
				{ 4,  23324 }, -- Mantle of the Fire Festival
				{ 6,  23083 }, -- Captured Flame
				{ 7,  23247 }, -- Burning Blossom
				{ 8,  23246 }, -- Fiery Festival Brew
				{ 9,  23435 }, -- Elderberry Pie
				{ 10, 23327 }, -- Fire-toasted Bun
				{ 11, 23326 }, -- Midsummer Sausage
				{ 12, 23211 }, -- Toasted Smorc
			},
		},
	},
}

data["HarvestFestival"] = {
	name = AL["Harvest Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- HarvestFestival
			name = AL["Harvest Festival"],
			[NORMAL_DIFF] = {
				{ 1,  19697 }, -- Bounty of the Harvest
				{ 2,  20009 }, -- For the Light!
				{ 3,  20010 }, -- The Horde's Hellscream
				{ 16,  19995 }, -- Harvest Boar
				{ 17,  19996 }, -- Harvest Fish
				{ 18,  19994 }, -- Harvest Fruit
				{ 19,  19997 }, -- Harvest Nectar
			},
		},
	},
}

data["Halloween"] = {
	name = AL["Hallow's End"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
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
	},
}

data["WinterVeil"] = {
	name = AL["Feast of Winter Veil"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Winterviel1
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  21525 }, -- Green Winter Hat
				{ 2,  21524 }, -- Red Winter Hat
				{ 16,  17712 }, -- Winter Veil Disguise Kit
				{ 17,  17202 }, -- Snowball
				{ 18,  21212 }, -- Fresh Holly
				{ 19,  21519 }, -- Mistletoe
			},
		},
		{
			name = AL["Gaily Wrapped Present"],
			[NORMAL_DIFF] = {
				{ 1, 21301 }, -- Green Helper Box
				{ 2, 21308 }, -- Jingling Bell
				{ 3, 21305 }, -- Red Helper Box
				{ 4, 21309 }, -- Snowman Kit
			},
		},
		{
			name = AL["Festive Gift"],
			[NORMAL_DIFF] = {
				{ 1, 21328 }, -- Wand of Holiday Cheer
			},
		},
		{
			name = AL["Smokywood Pastures Special Gift"],
			[NORMAL_DIFF] = {
				{ 1, 17706 }, -- Plans: Edge of Winter
				{ 2, 17725 }, -- Formula: Enchant Weapon - Winter's Might
				{ 3, 17720 }, -- Schematic: Snowmaster 9000
				{ 4, 17722 }, -- Pattern: Gloves of the Greatfather
				{ 5, 17709 }, -- Recipe: Elixir of Frost Power
				{ 6, 17724 }, -- Pattern: Green Holiday Shirt
				{ 16, 21325 }, -- Mechanical Greench
				{ 17, 21213 }, -- Preserved Holly
			},
		},
		{
			name = AL["Gently Shaken Gift"],
			[NORMAL_DIFF] = {
				{ 1, 21235 }, -- Winter Veil Roast
				{ 2, 21241 }, -- Winter Veil Eggnog
			},
		},
		{
			name = AL["Smokywood Pastures"],
			[NORMAL_DIFF] = {
				{ 1,  17201 }, -- Recipe: Egg Nog
				{ 2,  17200 }, -- Recipe: Gingerbread Cookie
				{ 3,  17344 }, -- Candy Cane
				{ 4,  17406 }, -- Holiday Cheesewheel
				{ 5,  17407 }, -- Graccu's Homemade Meat Pie
				{ 6,  17408 }, -- Spicy Beefstick
				{ 7,  17404 }, -- Blended Bean Brew
				{ 8,  17405 }, -- Green Garden Tea
				{ 9, 17196 }, -- Holiday Spirits
				{ 10, 17403 }, -- Steamwheedle Fizzy Spirits
				{ 11, 17402 }, -- Greatfather's Winter Ale
				{ 12, 17194 }, -- Holiday Spices
				{ 16, 17303 }, -- Blue Ribboned Wrapping Paper
				{ 17, 17304 }, -- Green Ribboned Wrapping Paper
				{ 18, 17307 }, -- Purple Ribboned Wrapping Paper
			},
		},
	},
}

data["ElementalInvasions"] = {
	name = AL["Elemental Invasions"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 2.5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ElementalInvasion
			name = AL["Elemental Invasions"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Baron Charr"] },
				{ 2,  18671 }, -- Baron Charr's Sceptre
				{ 3,  19268 }, -- Ace of Elementals
				{ 4,  18672 }, -- Elemental Ember
				{ 6, "INV_Box_01", nil, AL["Princess Tempestria"] },
				{ 7,  18678 }, -- Tempestria's Frozen Necklace
				{ 8,  19268 }, -- Ace of Elementals
				{ 9,  21548 }, -- Pattern: Stormshroud Gloves
				{ 10, 18679 }, -- Frigid Ring
				{ 16, "INV_Box_01", nil, AL["Avalanchion"] },
				{ 17, 18673 }, -- Avalanchion's Stony Hide
				{ 18, 19268 }, -- Ace of Elementals
				{ 19, 18674 }, -- Hardened Stone Band
				{ 21, "INV_Box_01", nil, AL["The Windreaver"] },
				{ 22, 18676 }, -- Sash of the Windreaver
				{ 23, 19268 }, -- Ace of Elementals
				{ 24, 21548 }, -- Pattern: Stormshroud Gloves
				{ 25, 18677 }, -- Zephyr Cloak
			},
		},
	},
}

data["SilithusAbyssal"] = {
	name = AL["Silithus Abyssal"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 4,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- AbyssalDukes
			name = AL["Abyssal Dukes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["The Duke of Cynders"] },
				{ 2,  20665 }, -- Abyssal Leather Leggings
				{ 3,  20666 }, -- Hardened Steel Warhammer
				{ 4,  20514 }, -- Abyssal Signet
				{ 5,  20664 }, -- Abyssal Cloth Sash
				{ 8, "INV_Box_01", nil, AL["The Duke of Fathoms"] },
				{ 9,  20668 }, -- Abyssal Mail Legguards
				{ 10, 20669 }, -- Darkstone Claymore
				{ 11, 20514 }, -- Abyssal Signet
				{ 12, 20667 }, -- Abyssal Leather Belt
				{ 16, "INV_Box_01", nil, AL["The Duke of Zephyrs"] },
				{ 17, 20674 }, -- Abyssal Cloth Pants
				{ 18, 20675 }, -- Soulrender
				{ 19, 20514 }, -- Abyssal Signet
				{ 20, 20673 }, -- Abyssal Plate Girdle
				{ 23, "INV_Box_01", nil, AL["The Duke of Shards"] },
				{ 24, 20671 }, -- Abyssal Plate Legplates
				{ 25, 20672 }, -- Sparkling Crystal Wand
				{ 26, 20514 }, -- Abyssal Signet
				{ 27, 20670 }, -- Abyssal Mail Clutch
			},
		},
		{ -- AbyssalLords
			name = AL["Abyssal Lords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Prince Skaldrenox"] },
				{ 2,  20682 }, -- Elemental Focus Band
				{ 3,  20515 }, -- Abyssal Scepter
				{ 4,  20681 }, -- Abyssal Leather Bracers
				{ 5,  20680 }, -- Abyssal Mail Pauldrons
				{ 7, "INV_Box_01", nil, AL["Lord Skwol"] },
				{ 8,  20685 }, -- Wavefront Necklace
				{ 9,  20515 }, -- Abyssal Scepter
				{ 10, 20684 }, -- Abyssal Mail Armguards
				{ 11, 20683 }, -- Abyssal Plate Epaulets
				{ 16, "INV_Box_01", nil, AL["High Marshal Whirlaxis"] },
				{ 17, 20691 }, -- Windshear Cape
				{ 18, 20515 }, -- Abyssal Scepter
				{ 19, 20690 }, -- Abyssal Cloth Wristbands
				{ 20, 20689 }, -- Abyssal Leather Shoulders
				{ 22, "INV_Box_01", nil, AL["Baron Kazum"] },
				{ 23, 20688 }, -- Earthen Guard
				{ 24, 20515 }, -- Abyssal Scepter
				{ 25, 20686 }, -- Abyssal Cloth Amice
				{ 26, 20687 }, -- Abyssal Plate Vambraces
			},
		},
		{ -- AbyssalTemplars
			name = AL["Abyssal Templars"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Crimson Templar"] },
				{ 2,  20657 }, -- Crystal Tipped Stiletto
				{ 3,  20655 }, -- Abyssal Cloth Handwraps
				{ 4,  20656 }, -- Abyssal Mail Sabatons
				{ 5,  20513 }, -- Abyssal Crest
				{ 7, "INV_Box_01", nil, AL["Azure Templar"] },
				{ 8,  20654 }, -- Amethyst War Staff
				{ 9,  20653 }, -- Abyssal Plate Gauntlets
				{ 10, 20652 }, -- Abyssal Cloth Slippers
				{ 11, 20513 }, -- Abyssal Crest
				{ 16, "INV_Box_01", nil, AL["Hoary Templar"] },
				{ 17, 20660 }, -- Stonecutting Glaive
				{ 18, 20659 }, -- Abyssal Mail Handguards
				{ 19, 20658 }, -- Abyssal Leather Boots
				{ 20, 20513 }, -- Abyssal Crest
				{ 22, "INV_Box_01", nil, AL["Earthen Templar"] },
				{ 23, 20663 }, -- Deep Strike Bow
				{ 24, 20661 }, -- Abyssal Leather Gloves
				{ 25, 20662 }, -- Abyssal Plate Greaves
				{ 26, 20513 }, -- Abyssal Crest
			},
		},
	},
}

data["AQOpening"] = {
	name = AL["AQ opening"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["AQ opening"],
			[NORMAL_DIFF] = {
				{ 1,  21138 }, -- Red Scepter Shard
				{ 2,  21529 }, -- Amulet of Shadow Shielding
				{ 3,  21530 }, -- Onyx Embedded Leggings
				{ 5,  21139 }, -- Green Scepter Shard
				{ 6,  21531 }, -- Drake Tooth Necklace
				{ 7,  21532 }, -- Drudge Boots
				{ 9,  21137 }, -- Blue Scepter Shard
				{ 10, 21517 }, -- Gnomish Turban of Psychic Might
				{ 11, 21527 }, -- Darkwater Robes
				{ 12, 21526 }, -- Band of Icy Depths
				{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
				{ 16, 21175 }, -- The Scepter of the Shifting Sands
				{ 17, 21176 }, -- Black Qiraji Resonating Crystal
				{ 18, 21523 }, -- Fang of Korialstrasz
				{ 19, 21521 }, -- Runesword of the Red
				{ 20, 21522 }, -- Shadowsong's Sorrow
				{ 21, 21520 }, -- Ravencrest's Legacy
			},
		},
	},
}

data["ScourgeInvasion"] = {
	name = AL["Scourge Invasion"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 6,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.SCOURGE_INVASION,
	items = {
		{ -- ScourgeInvasionEvent1
			name = AL["Scourge Invasion"],
			[NORMAL_DIFF] = {
				{ 1,  23123 }, -- Blessed Wizard Oil
				{ 2,  23122 }, -- Consecrated Sharpening Stone
				{ 3,  22999 }, -- Tabard of the Argent Dawn
				{ 4,  22484 }, -- Necrotic Rune
				{ 7,  23085 }, -- Robe of Undead Cleansing
				{ 8,  23091 }, -- Bracers of Undead Cleansing
				{ 9,  23084 }, -- Gloves of Undead Cleansing
				{ 12, 23089 }, -- Tunic of Undead Slaying
				{ 13, 23093 }, -- Wristwraps of Undead Slaying
				{ 14, 23081 }, -- Handwraps of Undead Slaying
				{ 16, 23194 }, -- Lesser Mark of the Dawn
				{ 17, 23195 }, -- Mark of the Dawn
				{ 18, 23196 }, -- Greater Mark of the Dawn
				{ 22, 23088 }, -- Chestguard of Undead Slaying
				{ 23, 23092 }, -- Wristguards of Undead Slaying
				{ 24, 23082 }, -- Handguards of Undead Slaying
				{ 27, 23087 }, -- Breastplate of Undead Slaying
				{ 28, 23090 }, -- Bracers of Undead Slaying
				{ 29, 23078 }, -- Gauntlets of Undead Slaying
			},
		},
		{
			name = C_Map_GetAreaInfo(2017).." - "..AL["Balzaphon"],
			[NORMAL_DIFF] = {
				{ 1,  23126 }, -- Waistband of Balzaphon
				{ 2,  23125 }, -- Chains of the Lich
				{ 3,  23124 }, -- Staff of Balzaphon
			}
		},
		{
			name = C_Map_GetAreaInfo(2057).." - "..AL["Lord Blackwood"],
			[NORMAL_DIFF] = {
				{ 1,  23132 }, -- Lord Blackwood's Blade
				{ 2,  23156 }, -- Blackwood's Thigh
				{ 3,  23139 }, -- Lord Blackwood's Buckler
			}
		},
		{
			name = C_Map_GetAreaInfo(2557).." - "..AL["Revanchion"],
			[NORMAL_DIFF] = {
				{ 1, 23127 }, -- Cloak of Revanchion
				{ 2, 23129 }, -- Bracers of Mending
				{ 3, 23128 }, -- The Shadow's Grasp
			}
		},
		{
			name = AL["Scarlet Monastery - Graveyard"].." - "..AL["Scorn"],
			[NORMAL_DIFF] = {
				{ 1, 23169 }, -- Scorn's Icy Choker
				{ 2, 23170 }, -- The Frozen Clutch
				{ 3, 23168 }, -- Scorn's Focal Dagger
			}
		},
		{
			name = C_Map_GetAreaInfo(209).." - "..AL["Sever"],
			[NORMAL_DIFF] = {
				{ 1, 23173 }, -- Abomination Skin Leggings
				{ 2, 23171 }, -- The Axe of Severing
			}
		},
		{
			name = C_Map_GetAreaInfo(722).." - "..AL["Lady Falther'ess"],
			[NORMAL_DIFF] = {
				{ 1, 23178 }, -- Mantle of Lady Falther'ess
				{ 2, 23177 }, -- Lady Falther'ess' Finger
			}
		},
	},
}
