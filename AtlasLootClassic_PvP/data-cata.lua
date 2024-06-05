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
local SET3_DIFF = data:AddDifficulty(format(AL["Vicious (Elite) %s"], ""), "set3", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
--local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local ARENA_CONTENT = data:AddContentType(AL["Arena"], ATLASLOOT_PVP_COLOR)
--local OPEN_WORLD_CONTENT = data:AddContentType(AL["Open World"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

--local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
--local BLIZZARD_NYI = " |cff00ccff<NYI |T130946:12:20:0:0:32:16:4:28:0:16|t>|r"

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
            {1, 4000910}, -- Warlock
            {3, 4000916}, -- Priest Healing
            {4, 4000915}, -- Priest Shadow
            {6, 4000914}, -- Rogue
            {8, 4000920}, -- Hunter
            {10, 4000909}, -- Warrior Melee
            {13, 4000924}, -- Death Knight Melee
            {16, 4000919}, -- Mage
            {18, 4000923}, -- Druid Resto
            {19, 4000921}, -- Druid Balance
            {20, 4000922}, -- Druid Feral
            {22, 4000913}, -- Shaman Resto
            {23, 4000911}, -- Shaman Elemental
            {24, 4000912}, -- Shaman Enhancement
            {26, 4000918}, -- Paladin Holy
            {27, 4000917} -- Paladin Melee
        },
        [SET2_DIFF] = {
            {1, 4001910}, -- Warlock
            {3, 4001916}, -- Priest Healing
            {4, 4001915}, -- Priest Shadow
            {6, 4001914}, -- Rogue
            {8, 4001920}, -- Hunter
            {10, 4001909}, -- Warrior Melee
            {13, 4001924}, -- Death Knight Melee
            {16, 4001919}, -- Mage
            {18, 4001923}, -- Druid Resto
            {19, 4001921}, -- Druid Balance
            {20, 4001922}, -- Druid Feral
            {22, 4001913}, -- Shaman Resto
            {23, 4001911}, -- Shaman Elemental
            {24, 4001912}, -- Shaman Enhancement
            {26, 4001918}, -- Paladin Holy
            {27, 4001917} -- Paladin Melee
        },
        [SET3_DIFF] = {
            {1, 4002910}, -- Warlock
            {3, 4002916}, -- Priest Healing
            {4, 4002915}, -- Priest Shadow
            {6, 4002914}, -- Rogue
            {8, 4002920}, -- Hunter
            {10, 4002909}, -- Warrior Melee
            {13, 4002924}, -- Death Knight Melee
            {16, 4002919}, -- Mage
            {18, 4002923}, -- Druid Resto
            {19, 4002921}, -- Druid Balance
            {20, 4002922}, -- Druid Feral
            {22, 4002913}, -- Shaman Resto
            {23, 4002911}, -- Shaman Elemental
            {24, 4002912}, -- Shaman Enhancement
            {26, 4002918}, -- Paladin Holy
            {27, 4002917} -- Paladin Melee
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["One-Handed"],
        [SET2_DIFF] = {
            { 1, 61324 }, -- Vicious Gladiator's Cleaver
            { 2, 61325 }, -- Vicious Gladiator's Hacker
            { 4, 61336 }, -- Vicious Gladiator's Bonecracker
            { 5, 61335 }, -- Vicious Gladiator's Pummeler
            { 7, 61345 }, -- Vicious Gladiator's Quickblade
            { 8, 61344 }, -- Vicious Gladiator's Slicer
            { 16, 61329 }, -- Vicious Gladiator's Spellblade
            { 17, 61338 }, -- Vicious Gladiator's Gavel
            { 19, 61327 }, -- Vicious Gladiator's Shanker
            { 20, 61328 }, -- Vicious Gladiator's Shiv
            { 22, 61333 }, -- Vicious Gladiator's Right Render
            { 23, 61330 }, -- Vicious Gladiator's Right Ripper
            { 25, 61332 }, -- Vicious Gladiator's Left Render
            { 26, 61331 }, -- Vicious Gladiator's Left Ripper
        },
        [SET3_DIFF] = {
            { 1, 67474 }, -- Vicious Gladiator's Cleaver
            { 2, 67473 }, -- Vicious Gladiator's Hacker
            { 4, 67470 }, -- Vicious Gladiator's Bonecracker
            { 5, 67471 }, -- Vicious Gladiator's Pummeler
            { 7, 67468 }, -- Vicious Gladiator's Quickblade
            { 8, 67469 }, -- Vicious Gladiator's Slicer
            { 16, 67457 }, -- Vicious Gladiator's Spellblade
            { 17, 67454 }, -- Vicious Gladiator's Gavel
            { 19, 67472 }, -- Vicious Gladiator's Shanker
            { 20, 67460 }, -- Vicious Gladiator's Shiv
            { 22, 67455 }, -- Vicious Gladiator's Right Render
            { 23, 67456 }, -- Vicious Gladiator's Right Ripper
            { 25, 67458 }, -- Vicious Gladiator's Left Render
            { 26, 67459 }, -- Vicious Gladiator's Left Ripper
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Two-Handed"],
        [SET2_DIFF] = {
            { 1, 61340 }, -- Vicious Gladiator's Pike
            { 2, 61343 }, -- Vicious Gladiator's Staff
            { 4, 61326 }, -- Vicious Gladiator's Decapitator
            { 5, 61339 }, -- Vicious Gladiator's Bonegrinder
            { 6, 61346 }, -- Vicious Gladiator's Greatsword
            { 16, 61341 }, -- Vicious Gladiator's Battle Staff
            { 17, 61342 }, -- Vicious Gladiator's Energy Staff
        },
        [SET3_DIFF] = {
            { 1, 67451 }, -- Vicious Gladiator's Pike
            { 2, 67448 }, -- Vicious Gladiator's Staff
            { 4, 67453 }, -- Vicious Gladiator's Decapitator
            { 5, 67452 }, -- Vicious Gladiator's Bonegrinder
            { 6, 67447 }, -- Vicious Gladiator's Greatsword
            { 16, 67449 }, -- Vicious Gladiator's Energy Staff
            { 17, 67450 }, -- Vicious Gladiator's Battle Staff
        },
    }, {
        name = AL["Weapons"] .. " - " .. AL["Ranged"],
        [SET2_DIFF] = {
            { 1, 61353 }, -- Vicious Gladiator's Longbow
            { 2, 61355 }, -- Vicious Gladiator's Heavy Crossbow
            { 3, 61354 }, -- Vicious Gladiator's Rifle
            { 5, 61348 }, -- Vicious Gladiator's Hatchet
            { 6, 61347 }, -- Vicious Gladiator's War Edge
            { 16, 61351 }, -- Vicious Gladiator's Baton of Light
            { 17, 61350 }, -- Vicious Gladiator's Touch of Defeat
        },
        [SET3_DIFF] = {
            { 1, 67461 }, -- Vicious Gladiator's Longbow
            { 2, 67462 }, -- Vicious Gladiator's Heavy Crossbow
            { 3, 67463 }, -- Vicious Gladiator's Rifle
            { 5, 67466 }, -- Vicious Gladiator's Hatchet
            { 6, 67467 }, -- Vicious Gladiator's War Edge
            { 16, 67464 }, -- Vicious Gladiator's Baton of Light
            { 17, 67465 }, -- Vicious Gladiator's Touch of Defeat
        },
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Off Hand"],
        [SET2_DIFF] = {
            { 1, 61357 }, -- Vicious Gladiator's Endgame
            { 2, 61358 }, -- Vicious Gladiator's Reprieve
        },
        [SET3_DIFF] = {
            { 1, 67478 }, -- Vicious Gladiator's Reprieve
            { 2, 67479 }, -- Vicious Gladiator's Endgame
        }
    }, {
        name = AL["Weapons"] .. " - " .. ALIL["Shields"],
        [SET2_DIFF] = {
            { 1, 61360 }, -- Vicious Gladiator's Barrier
            { 2, 61361 }, -- Vicious Gladiator's Redoubt
            { 3, 61359 }, -- Vicious Gladiator's Shield Wall
        },
        [SET3_DIFF] = {
            { 1, 67476 }, -- Vicious Gladiator's Barrier
            { 2, 67475 }, -- Vicious Gladiator's Redoubt
            { 3, 67477 }, -- Vicious Gladiator's Shield Wall
        },
    }, {
        name = ALIL["Cloak"],
        [SET2_DIFF] = {
            { 1, 60783 }, -- Vicious Gladiator's Cape of Cruelty
            { 2, 60779 }, -- Vicious Gladiator's Cape of Prowess
            { 4, 60776 }, -- Vicious Gladiator's Cloak of Alacrity
            { 5, 60778 }, -- Vicious Gladiator's Cloak of Prowess
            { 16, 60786 }, -- Vicious Gladiator's Drape of Diffusion
            { 17, 60788 }, -- Vicious Gladiator's Drape of Meditation
            { 18, 60787 }, -- Vicious Gladiator's Drape of Prowess
        },
    }, {
        name = ALIL["Relic"],
        [SET2_DIFF] = {
            { 1, 61391 }, -- Vicious Gladiator's Relic of Conquest
            { 2, 61388 }, -- Vicious Gladiator's Relic of Dominance
            { 3, 61389 }, -- Vicious Gladiator's Relic of Salvation
            { 4, 61390 }, -- Vicious Gladiator's Relic of Triumph
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
            { 1, 60673 }, -- Vicious Gladiator's Choker of Accuracy
            { 2, 60670 }, -- Vicious Gladiator's Choker of Proficiency
            { 5, 60669 }, -- Vicious Gladiator's Necklace of Proficiency
            { 6, 60668 }, -- Vicious Gladiator's Necklace of Prowess
            { 16, 60662 }, -- Vicious Gladiator's Pendant of Alacrity
            { 17, 60661 }, -- Vicious Gladiator's Pendant of Diffusion
            { 18, 60664 }, -- Vicious Gladiator's Pendant of Meditation
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
            { 1, 60651 }, -- Vicious Gladiator's Signet of Accuracy
            { 2, 60650 }, -- Vicious Gladiator's Signet of Cruelty
            { 4, 60658 }, -- Vicious Gladiator's Ring of Accuracy
            { 5, 60659 }, -- Vicious Gladiator's Ring of Cruelty
            { 16, 60647 }, -- Vicious Gladiator's Band of Accuracy
            { 17, 60645 }, -- Vicious Gladiator's Band of Cruelty
            { 18, 60649 }, -- Vicious Gladiator's Band of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
        [SET1_DIFF] = {
            { 1, 64862 }, -- Bloodthirsty Gladiator's Treads of Alacrity
            { 2, 64863 }, -- Bloodthirsty Gladiator's Treads of Cruelty
            { 3, 64864 }, -- Bloodthirsty Gladiator's Treads of Meditation
            { 5, 64720 }, -- Bloodthirsty Gladiator's Cord of Accuracy
            { 6, 64721 }, -- Bloodthirsty Gladiator's Cord of Cruelty
            { 7, 64722 }, -- Bloodthirsty Gladiator's Cord of Meditation
            { 16, 64723 }, -- Bloodthirsty Gladiator's Cuffs of Accuracy
            { 17, 64724 }, -- Bloodthirsty Gladiator's Cuffs of Meditation
            { 18, 64725 }, -- Bloodthirsty Gladiator's Cuffs of Prowess
        },
        [SET2_DIFF] = {
            { 1, 60630 }, -- Vicious Gladiator's Treads of Alacrity
            { 2, 60613 }, -- Vicious Gladiator's Treads of Cruelty
            { 3, 60636 }, -- Vicious Gladiator's Treads of Meditation
            { 5, 60626 }, -- Vicious Gladiator's Cord of Accuracy
            { 6, 60612 }, -- Vicious Gladiator's Cord of Cruelty
            { 7, 60637 }, -- Vicious Gladiator's Cord of Meditation
            { 16, 60628 }, -- Vicious Gladiator's Cuffs of Accuracy
            { 17, 60635 }, -- Vicious Gladiator's Cuffs of Meditation
            { 18, 60634 }, -- Vicious Gladiator's Cuffs of Prowess
        },
        [SET3_DIFF] = {
            { 1, 65599 }, -- Vicious Gladiator's Treads of Alacrity
            { 2, 65598 }, -- Vicious Gladiator's Treads of Cruelty
            { 3, 65600 }, -- Vicious Gladiator's Treads of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Leather"]),
        [SET1_DIFF] = {
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
        },
        [SET2_DIFF] = {
            { 1, 60593 }, -- Vicious Gladiator's Boots of Alacrity
            { 2, 60587 }, -- Vicious Gladiator's Boots of Cruelty
            { 3, 60607 }, -- Vicious Gladiator's Footguards of Alacrity
            { 4, 60581 }, -- Vicious Gladiator's Footguards of Meditation
            { 6, 60583 }, -- Vicious Gladiator's Belt of Cruelty
            { 7, 60580 }, -- Vicious Gladiator's Belt of Meditation
            { 8, 60589 }, -- Vicious Gladiator's Waistband of Accuracy
            { 9, 60586 }, -- Vicious Gladiator's Waistband of Cruelty
            { 16, 60591 }, -- Vicious Gladiator's Armwraps of Accuracy
            { 17, 60594 }, -- Vicious Gladiator's Armwraps of Alacrity
            { 18, 60582 }, -- Vicious Gladiator's Bindings of Meditation
            { 19, 60611 }, -- Vicious Gladiator's Bindings of Prowess
        },
        [SET3_DIFF] = {
            { 1, 65610 }, -- Vicious Gladiator's Boots of Alacrity
            { 2, 65609 }, -- Vicious Gladiator's Boots of Cruelty
            { 3, 65602 }, -- Vicious Gladiator's Footguards of Alacrity
            { 4, 65601 }, -- Vicious Gladiator's Footguards of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Mail"]),
        [SET1_DIFF] = {
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
        },
        [SET2_DIFF] = {
            { 1, 60557 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 2, 60567 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 3, 60554 }, -- Vicious Gladiator's Sabatons of Cruelty
            { 4, 60534 }, -- Vicious Gladiator's Sabatons of Meditation
            { 6, 60564 }, -- Vicious Gladiator's Links of Accuracy
            { 7, 60555 }, -- Vicious Gladiator's Links of Cruelty
            { 8, 60536 }, -- Vicious Gladiator's Waistguard of Cruelty
            { 9, 60533 }, -- Vicious Gladiator's Waistguard of Meditation
            { 16, 60535 }, -- Vicious Gladiator's Armbands of Meditation
            { 17, 60569 }, -- Vicious Gladiator's Armbands of Prowess
            { 18, 60565 }, -- Vicious Gladiator's Wristguards of Accuracy
            { 19, 60559 }, -- Vicious Gladiator's Wristguards of Alacrity
        },
        [SET3_DIFF] = {
            { 1, 65604 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 2, 65611 }, -- Vicious Gladiator's Sabatons of Alacrity
            { 3, 65603 }, -- Vicious Gladiator's Sabatons of Cruelty
            { 4, 65612 }, -- Vicious Gladiator's Sabatons of Meditation
        },
    }, {
        name = format(AL["Non Set '%s'"], ALIL["Plate"]),
        [SET1_DIFF] = {
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
        },
        [SET2_DIFF] = {
            { 1, 60516 }, -- Vicious Gladiator's Greaves of Alacrity
            { 2, 60540 }, -- Vicious Gladiator's Greaves of Meditation
            { 3, 60513 }, -- Vicious Gladiator's Warboots of Alacrity
            { 4, 60509 }, -- Vicious Gladiator's Warboots of Cruelty
            { 6, 60505 }, -- Vicious Gladiator's Clasp of Cruelty
            { 7, 60539 }, -- Vicious Gladiator's Clasp of Meditation
            { 8, 60508 }, -- Vicious Gladiator's Girdle of Cruelty
            { 9, 60521 }, -- Vicious Gladiator's Girdle of Prowess
            { 16, 60512 }, -- Vicious Gladiator's Armplates of Alacrity
            { 17, 60523 }, -- Vicious Gladiator's Armplates of Proficiency
            { 18, 60541 }, -- Vicious Gladiator's Bracers of Meditation
            { 19, 60520 }, -- Vicious Gladiator's Bracers of Prowess
        },
        [SET3_DIFF] = {
            { 1, 65605 }, -- Vicious Gladiator's Greaves of Alacrity
            { 2, 65606 }, -- Vicious Gladiator's Greaves of Meditation
            { 3, 65608 }, -- Vicious Gladiator's Warboots of Alacrity
            { 4, 65607 }, -- Vicious Gladiator's Warboots of Cruelty
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
            { 16, 64761 }, -- Bloodthirsty Gladiator's Insignia of Conquest
            { 17, 64762 }, -- Bloodthirsty Gladiator's Insignia of Dominance
            { 18, 64763 }, -- Bloodthirsty Gladiator's Insignia of Victory
            { 20, AtlasLoot:GetRetByFaction(64789, 64790) }, -- Bloodthirsty Gladiator's Medallion of Cruelty
            { 21, AtlasLoot:GetRetByFaction(64792, 64791) }, -- Bloodthirsty Gladiator's Medallion of Meditation
            { 22, AtlasLoot:GetRetByFaction(64794, 64793) }, -- Bloodthirsty Gladiator's Medallion of Tenacity
        },
        [SET2_DIFF] = {
            { 1, 61033 }, -- Vicious Gladiator's Badge of Conquest
            { 2, 61035 }, -- Vicious Gladiator's Badge of Dominance
            { 3, 61034 }, -- Vicious Gladiator's Badge of Victory
            { 5, 61026 }, -- Vicious Gladiator's Emblem of Cruelty
            { 6, 61031 }, -- Vicious Gladiator's Emblem of Meditation
            { 7, 61032 }, -- Vicious Gladiator's Emblem of Tenacity
            { 16, 61047 }, -- Vicious Gladiator's Insignia of Conquest
            { 17, 61045 }, -- Vicious Gladiator's Insignia of Dominance
            { 18, 61046 }, -- Vicious Gladiator's Insignia of Victory
            { 20, AtlasLoot:GetRetByFaction(60801, 60794) }, -- Vicious Gladiator's Medallion of Cruelty
            { 21, AtlasLoot:GetRetByFaction(60806, 60799) }, -- Vicious Gladiator's Medallion of Meditation
            { 22, AtlasLoot:GetRetByFaction(60807, 60800) }, -- Vicious Gladiator's Medallion of Tenacity
        },
    }, {
        name = AL["Gladiator Mount"],
        ExtraList = true,
        [NORMAL_DIFF] = {
            { 1, "ac6003" },
            { 2, 71339 },
        }
    }}
}

--[[ TODO: Later, beta first
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
]]
