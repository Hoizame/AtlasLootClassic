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
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then
    return
end
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
local SET1_DIFF = data:AddDifficulty(format(AL["Bloodthirsty %s"], ""), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Vicious %s"], ""), "set2", nil, 1)
local SET3_DIFF = data:AddDifficulty(format(AL["Vicious %s"], ""), "set3", nil, 1)

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
    [SET1_DIFF] = {{1, 3000780}, -- Warlock
    {3, 3000777}, -- Priest / Heal
    {4, 3000778}, -- Priest / Shadow
    {6, 3000776}, -- Rogue
    {8, 3000772}, -- Hunter
    {10, 3000780}, -- Warrior / DD
    {13, 3000768}, -- Deathknight
    {16, 3000779}, -- Mage
    {18, 3000773}, -- Druid / Heal
    {19, 3000774}, -- Druid / Owl
    {20, 3000775}, -- Druid / Feral
    {22, 3000771}, -- Shaman / Heal
    {23, 3000769}, -- Shaman / Ele
    {24, 3000770}, -- Shaman / Enh
    {26, 3000767}, -- Paladin / Heal
    {27, 3000766} -- Paladin / DD
    },
    [SET2_DIFF] = {{1, 3001780}, -- Warlock
    {3, 3001777}, -- Priest / Heal
    {4, 3001778}, -- Priest / Shadow
    {6, 3001776}, -- Rogue
    {8, 3001772}, -- Hunter
    {10, 3001780}, -- Warrior / DD
    {13, 3001768}, -- Deathknight
    {16, 3001779}, -- Mage
    {18, 3001773}, -- Druid / Heal
    {19, 3001774}, -- Druid / Owl
    {20, 3001775}, -- Druid / Feral
    {22, 3001771}, -- Shaman / Heal
    {23, 3001769}, -- Shaman / Ele
    {24, 3001770}, -- Shaman / Enh
    {26, 3001767}, -- Paladin / Heal
    {27, 3001766} -- Paladin / DD
    },
    [SET3_DIFF] = {{1, 3002780}, -- Warlock
    {3, 3002777}, -- Priest / Heal
    {4, 3002778}, -- Priest / Shadow
    {6, 3002776}, -- Rogue
    {8, 3002772}, -- Hunter
    {10, 3002780}, -- Warrior / DD
    {13, 3002768}, -- Deathknight
    {16, 3002779}, -- Mage
    {18, 3002773}, -- Druid / Heal
    {19, 3002774}, -- Druid / Owl
    {20, 3002775}, -- Druid / Feral
    {22, 3002771}, -- Shaman / Heal
    {23, 3002769}, -- Shaman / Ele
    {24, 3002770}, -- Shaman / Enh
    {26, 3002767}, -- Paladin / Heal
    {27, 3002766} -- Paladin / DD
    }
}

data["PvPMountsCata"] = {
    name = ALIL["Mounts"],
    ContentType = GENERAL_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    CorrespondingFields = private.MOUNTS_LINK,
    items = {{ -- PvPMountsPvP
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
        [SET3_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = ALIL["Cloak"],
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = ALIL["Relic"],
        [SET1_DIFF] = {
        },
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = ALIL["Neck"],
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
        }
    }, {
        name = ALIL["Finger"],
        [SET2_DIFF] = {
        },
        [SET3_DIFF] = {
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
        [NORMAL_QUEST_DISPLAY_DIFF] = {
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
