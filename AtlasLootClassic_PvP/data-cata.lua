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
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then
    return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

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
local SET1_DIFF = data:AddDifficulty(format(AL["Bloodthirsty %s"], ""), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Vicious %s"], ""), "set2", nil, 1)
local SET3_DIFF = data:AddDifficulty(format(AL["Elite Vicious %s"], ""), "set3", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local ARENA_CONTENT = data:AddContentType(AL["Arena"], ATLASLOOT_PVP_COLOR)
--local OPEN_WORLD_CONTENT = data:AddContentType(AL["Open World"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
local BLIZZARD_NYI = " |cff00ccff<NYI |T130946:12:20:0:0:32:16:4:28:0:16|t>|r"

data["PvPMountsCata"] = {
    name = ALIL["Mounts"],
    ContentType = GENERAL_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    CorrespondingFields = private.MOUNTS_LINK,
    items = {{ -- PvPMountsCata
        name = ALIL["Mounts"],
        [NORMAL_DIFF] = {
            {1, 72140}, -- Vicious War Wolf
            {2, 71339}, -- Vicious Gladiator's Twilight Drake
            {3, 70910}, -- Ruthless Gladiator's Twilight Drake
        },
    }}
}

data["ArenaS9PvP"] = {
    name = format(AL["Season %s"], "9"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    items = {{
        name = AL["Sets"],
        TableType = SET_ITTYPE,
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [SET1_DIFF] = {
            { 1, 64717 }, -- Bloodthirsty Gladiator's Cleaver
            { 2, 64758 }, -- Bloodthirsty Gladiator's Hacker
            { 4, 64700 }, -- Bloodthirsty Gladiator's Bonecracker
            { 5, 64816 }, -- Bloodthirsty Gladiator's Pummeler
            { 7, 64817 }, -- Bloodthirsty Gladiator's Quickblade
            { 8, 64858 }, -- Bloodthirsty Gladiator's Slicer
            { 16, 64859 }, -- Bloodthirsty Gladiator's Spellblade
            { 17, 64752 }, -- Bloodthirsty Gladiator's Gavel
            { 19, 64848 }, -- Bloodthirsty Gladiator's Shanker
            { 20, 64850 }, -- Bloodthirsty Gladiator's Shiv
            { 22, 64825 }, -- Bloodthirsty Gladiator's Right Render
            { 23, 64826 }, -- Bloodthirsty Gladiator's Right Ripper
            { 25, 64774 }, -- Bloodthirsty Gladiator's Left Render
            { 26, 64775 }, -- Bloodthirsty Gladiator's Left Ripper
        },
        [SET2_DIFF] = {
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [SET1_DIFF] = {
            { 1, 64810 }, -- Bloodthirsty Gladiator's Pike
            { 2, 64860 }, -- Bloodthirsty Gladiator's Staff
            { 4, 64726 }, -- Bloodthirsty Gladiator's Decapitator
            { 5, 64701 }, -- Bloodthirsty Gladiator's Bonegrinder
            { 6, 64755 }, -- Bloodthirsty Gladiator's Greatsword
            { 16, 64695 }, -- Bloodthirsty Gladiator's Battle Staff
            { 17, 64744 }, -- Bloodthirsty Gladiator's Energy Staff
        },
        [SET2_DIFF] = {
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [SET1_DIFF] = {
            { 1, 64783 }, -- Bloodthirsty Gladiator's Longbow
            { 2, 64760 }, -- Bloodthirsty Gladiator's Heavy Crossbow
            { 3, 64824 }, -- Bloodthirsty Gladiator's Rifle
            { 5, 64759 }, -- Bloodthirsty Gladiator's Hatchet
            { 6, 64871 }, -- Bloodthirsty Gladiator's War Edge
            { 16, 64694 }, -- Bloodthirsty Gladiator's Baton of Light
            { 17, 64861 }, -- Bloodthirsty Gladiator's Touch of Defeat
        },
        [SET2_DIFF] = {
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [SET1_DIFF] = {
            { 1, 64743 }, -- Bloodthirsty Gladiator's Endgame
            { 2, 64823 }, -- Bloodthirsty Gladiator's Reprieve
        },
        [SET2_DIFF] = {
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [SET1_DIFF] = {
            { 1, 64693 }, -- Bloodthirsty Gladiator's Barrier
            { 2, 64818 }, -- Bloodthirsty Gladiator's Redoubt
            { 3, 64849 }, -- Bloodthirsty Gladiator's Shield Wall
        },
        [SET2_DIFF] = {
        },
    }, {
        name = ALIL["Cloak"],
        [SET1_DIFF] = {
            { 1, 64706 }, -- Bloodthirsty Gladiator's Cape of Cruelty
            { 2, 64707 }, -- Bloodthirsty Gladiator's Cape of Prowess
            { 4, 64718 }, -- Bloodthirsty Gladiator's Cloak of Alacrity
            { 5, 64719 }, -- Bloodthirsty Gladiator's Cloak of Prowess
            { 16, 64732 }, -- Bloodthirsty Gladiator's Drape of Diffusion
            { 17, 64733 }, -- Bloodthirsty Gladiator's Drape of Meditation
            { 18, 64734 }, -- Bloodthirsty Gladiator's Drape of Prowess
        },
        [SET2_DIFF] = {
        },
    }, {
        name = ALIL["Relic"],
        [SET1_DIFF] = {
            { 1, 64819 }, -- Bloodthirsty Gladiator's Relic of Conquest
            { 2, 64820 }, -- Bloodthirsty Gladiator's Relic of Dominance
            { 3, 64821 }, -- Bloodthirsty Gladiator's Relic of Salvation
            { 4, 64822 }, -- Bloodthirsty Gladiator's Relic of Triumph
        },
        [SET2_DIFF] = {
        },
    }, {
        name = ALIL["Neck"],
        [SET1_DIFF] = {
            { 1, 64713 }, -- Bloodthirsty Gladiator's Choker of Accuracy
            { 2, 64714 }, -- Bloodthirsty Gladiator's Choker of Proficiency
            { 5, 64800 }, -- Bloodthirsty Gladiator's Necklace of Proficiency
            { 6, 64801 }, -- Bloodthirsty Gladiator's Necklace of Prowess
            { 16, 64807 }, -- Bloodthirsty Gladiator's Pendant of Alacrity
            { 17, 64808 }, -- Bloodthirsty Gladiator's Pendant of Diffusion
            { 18, 64809 }, -- Bloodthirsty Gladiator's Pendant of Meditation
        },
        [SET2_DIFF] = {
        },
    }, {
        name = ALIL["Finger"],
        [SET1_DIFF] = {
            { 1, 64851 }, -- Bloodthirsty Gladiator's Signet of Accuracy
            { 2, 64852 }, -- Bloodthirsty Gladiator's Signet of Cruelty
            { 4, 64832 }, -- Bloodthirsty Gladiator's Ring of Accuracy
            { 5, 64833 }, -- Bloodthirsty Gladiator's Ring of Cruelty
            { 16, 64690 }, -- Bloodthirsty Gladiator's Band of Accuracy
            { 17, 64691 }, -- Bloodthirsty Gladiator's Band of Cruelty
            { 18, 64692 }, -- Bloodthirsty Gladiator's Band of Meditation


        },
        [SET2_DIFF] = {
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [NORMAL_DIFF] = {
            { 1, 64862 }, -- Bloodthirsty Gladiator's Treads of Alacrity
            { 2, 64863 }, -- Bloodthirsty Gladiator's Treads of Cruelty
            { 3, 64864 }, -- Bloodthirsty Gladiator's Treads of Meditation
            { 5, 64720 }, -- Bloodthirsty Gladiator's Cord of Accuracy
            { 6, 64721 }, -- Bloodthirsty Gladiator's Cord of Cruelty
            { 7, 64722 }, -- Bloodthirsty Gladiator's Cord of Meditation
            { 16, 64723 }, -- Bloodthirsty Gladiator's Cuffs of Accuracy
            { 17, 64724 }, -- Bloodthirsty Gladiator's Cuffs of Meditation
            { 18, 64725 }, -- Bloodthirsty Gladiator's Cuffs of Prowess
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [NORMAL_DIFF] = {
            { 1, 64702 }, -- Bloodthirsty Gladiator's Boots of Alacrity
            { 2, 64703 }, -- Bloodthirsty Gladiator's Boots of Cruelty
            { 3, 64750 }, -- Bloodthirsty Gladiator's Footguards of Alacrity
            { 4, 64751 }, -- Bloodthirsty Gladiator's Footguards of Meditation
            { 6, 64696 }, -- Bloodthirsty Gladiator's Belt of Cruelty
            { 7, 64697 }, -- Bloodthirsty Gladiator's Belt of Meditation
            { 8, 64865 }, -- Bloodthirsty Gladiator's Waistband of Accuracy
            { 9, 64866 }, -- Bloodthirsty Gladiator's Waistband of Cruelty
            { 16, 64685 }, -- Bloodthirsty Gladiator's Armwraps of Accuracy
            { 17, 64686 }, -- Bloodthirsty Gladiator's Armwraps of Alacrity
            { 18, 64698 }, -- Bloodthirsty Gladiator's Bindings of Meditation
            { 19, 64699 }, -- Bloodthirsty Gladiator's Bindings of Prowess
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [NORMAL_DIFF] = {
            { 1, 64835 }, -- Bloodthirsty Gladiator's Sabatons of Alacrity
            { 2, 64834 }, -- Bloodthirsty Gladiator's Sabatons of Alacrity
            { 3, 64836 }, -- Bloodthirsty Gladiator's Sabatons of Cruelty
            { 4, 64837 }, -- Bloodthirsty Gladiator's Sabatons of Meditation
            { 6, 64781 }, -- Bloodthirsty Gladiator's Links of Accuracy
            { 7, 64782 }, -- Bloodthirsty Gladiator's Links of Cruelty
            { 8, 64867 }, -- Bloodthirsty Gladiator's Waistguard of Cruelty
            { 9, 64868 }, -- Bloodthirsty Gladiator's Waistguard of Meditation
            { 16, 64681 }, -- Bloodthirsty Gladiator's Armbands of Meditation
            { 17, 64682 }, -- Bloodthirsty Gladiator's Armbands of Prowess
            { 18, 64872 }, -- Bloodthirsty Gladiator's Wristguards of Accuracy
            { 19, 64873 }, -- Bloodthirsty Gladiator's Wristguards of Alacrity
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [NORMAL_DIFF] = {
            { 1, 64756 }, -- Bloodthirsty Gladiator's Greaves of Alacrity
            { 2, 64757 }, -- Bloodthirsty Gladiator's Greaves of Meditation
            { 3, 64869 }, -- Bloodthirsty Gladiator's Warboots of Alacrity
            { 4, 64870 }, -- Bloodthirsty Gladiator's Warboots of Cruelty
            { 6, 64715 }, -- Bloodthirsty Gladiator's Clasp of Cruelty
            { 7, 64716 }, -- Bloodthirsty Gladiator's Clasp of Meditation
            { 8, 64753 }, -- Bloodthirsty Gladiator's Girdle of Cruelty
            { 9, 64754 }, -- Bloodthirsty Gladiator's Girdle of Prowess
            { 16, 64683 }, -- Bloodthirsty Gladiator's Armplates of Alacrity
            { 17, 64684 }, -- Bloodthirsty Gladiator's Armplates of Proficiency
            { 18, 64704 }, -- Bloodthirsty Gladiator's Bracers of Meditation
            { 19, 64705 }, -- Bloodthirsty Gladiator's Bracers of Prowess
        }
    }, {
        name = ALIL["Trinket"],
        [SET1_DIFF] = {
            { 1, 64687 }, -- Bloodthirsty Gladiator's Badge of Conquest
            { 2, 64688 }, -- Bloodthirsty Gladiator's Badge of Dominance
            { 3, 64689 }, -- Bloodthirsty Gladiator's Badge of Victory
            { 5, 64740 }, -- Bloodthirsty Gladiator's Emblem of Cruelty
            { 6, 64741 }, -- Bloodthirsty Gladiator's Emblem of Meditation
            { 7, 64742 }, -- Bloodthirsty Gladiator's Emblem of Tenacity
            { 9, 64761 }, -- Bloodthirsty Gladiator's Insignia of Conquest
            { 10, 64762 }, -- Bloodthirsty Gladiator's Insignia of Dominance
            { 11, 64763 }, -- Bloodthirsty Gladiator's Insignia of Victory
            { 16, 69787 }, -- Bloodthirsty Gladiator's Mark of Cruelty
            { 17, 69789 }, -- Bloodthirsty Gladiator's Mark of Meditation
            { 18, 69788 }, -- Bloodthirsty Gladiator's Mark of Tenacity
            { 20, AtlasLoot:GetRetByFaction(64789, 64790) }, -- Bloodthirsty Gladiator's Medallion of Cruelty
            { 21, AtlasLoot:GetRetByFaction(64792, 64791) }, -- Bloodthirsty Gladiator's Medallion of Meditation
            { 22, AtlasLoot:GetRetByFaction(64794, 64793) }, -- Bloodthirsty Gladiator's Medallion of Tenacity
            { 24, 69790 }, -- Bloodthirsty Gladiator's Symbol of Cruelty
            { 25, 69792 }, -- Bloodthirsty Gladiator's Symbol of Meditation
            { 26, 69791 }, -- Bloodthirsty Gladiator's Symbol of Tenacity
        }
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
            { 1, "ac6003" },
            { 2, 71339 },
        }
    }}
}

data["ArenaS10PvP"] = {
    name = format(AL["Season %s"], "10"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    items = {{
        name = AL["Sets"],
        TableType = SET_ITTYPE,
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Cloak"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Relic"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Neck"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Finger"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
        }
    }}
}

data["ArenaS11PvP"] = {
    name = format(AL["Season %s"], "11"),
    ContentType = ARENA_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    items = {{
        name = AL["Sets"],
        TableType = SET_ITTYPE,
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"] .. " - R2",
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Cloak"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Relic"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Neck"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = ALIL["Finger"],
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [NORMAL_DIFF] = {
        }
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
        }
    }}
}
