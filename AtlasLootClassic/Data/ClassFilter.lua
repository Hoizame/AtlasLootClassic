local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local ClassFilter = {}
AtlasLoot.Data.ClassFilter = ClassFilter
local AL = AtlasLoot.Locales
local Requirements = AtlasLoot.Data.Requirements

-- ## WoW
local GetItemInfoInstant = GetItemInfoInstant

-- ## lua
local wipe = table.wipe
local format = string.format
local bit_band = bit.band

-- ## data
local CLASS_BITS = ALPrivate.CLASS_BITS
local CLASS_SORT = ALPrivate.CLASS_SORT
local CLASS_NAME_TO_ID = ALPrivate.CLASS_NAME_TO_ID
local C = CLASS_BITS
local db

-- ## Filter settings
local FILTER_DATA = {
    -- https://wowpedia.fandom.com/wiki/Enum.InventoryType
    -- true = all classes are allowed
    itemEquipLoc = {
        [""] = true,                        -- empty
        ["INVTYPE_NON_EQUIP"] = true,		-- Non-equippable
        ["INVTYPE_HEAD"] = true,				-- Head
        ["INVTYPE_NECK"] = true,				-- Neck
        ["INVTYPE_SHOULDER"] = true,			-- Shoulder
        ["INVTYPE_BODY"] = true,				-- Shirt
        ["INVTYPE_CHEST"] = true,			-- Chest
        ["INVTYPE_WAIST"] = true,			-- Waist
        ["INVTYPE_LEGS"] = true,				-- Legs
        ["INVTYPE_FEET"] = true,				-- Feet
        ["INVTYPE_WRIST"] = true,			-- Wrist
        ["INVTYPE_HAND"] = true,				-- Hands
        ["INVTYPE_FINGER"] = true,			-- Finger
        ["INVTYPE_TRINKET"] = true,			-- Trinket
        ["INVTYPE_WEAPON"] = true,			-- One-Hand
        ["INVTYPE_SHIELD"] = true,			-- Off Hand
        ["INVTYPE_RANGED"] = true,			-- Ranged
        ["INVTYPE_CLOAK"] = true,			-- Back
        ["INVTYPE_2HWEAPON"] = true,			-- Two-Hand
        ["INVTYPE_BAG"] = true,				-- Bag
        ["INVTYPE_TABARD"] = true,			-- Tabard
        ["INVTYPE_ROBE"] = true,				-- Chest
        ["INVTYPE_WEAPONMAINHAND"] = true,	-- Main Hand
        ["INVTYPE_WEAPONOFFHAND"] = true,	-- Off Hand
        ["INVTYPE_HOLDABLE"] = true,			-- Held In Off-hand
        ["INVTYPE_AMMO"] = true,				-- Ammo
        ["INVTYPE_THROWN"] = true,			-- Thrown
        ["INVTYPE_RANGEDRIGHT"] = true,		-- Ranged
        ["INVTYPE_QUIVER"] = C.HUNTER,			-- Quiver
        ["INVTYPE_RELIC"] = C.SHAMAN + C.PALADIN + C.DRUID,			-- Relic
    },
    itemClass = {
        [10] 			                    = true, -- Moneys
        [LE_ITEM_CLASS_CONSUMABLE] 			= true,
        [LE_ITEM_CLASS_CONTAINER] 			= true,
        [LE_ITEM_CLASS_WEAPON] 				= true,
        [LE_ITEM_CLASS_GEM] 				= true,
        [LE_ITEM_CLASS_ARMOR] 				= true,
        [LE_ITEM_CLASS_REAGENT] 			= true,
        [LE_ITEM_CLASS_PROJECTILE] 			= true,
        [LE_ITEM_CLASS_TRADEGOODS] 			= true,
        [LE_ITEM_CLASS_ITEM_ENHANCEMENT] 	= true,
        [LE_ITEM_CLASS_RECIPE] 				= true,
        [LE_ITEM_CLASS_QUIVER] 				= C.HUNTER,
        [LE_ITEM_CLASS_QUESTITEM] 			= true,
        [LE_ITEM_CLASS_KEY] 				= true,
        [LE_ITEM_CLASS_MISCELLANEOUS] 		= true,
    },
    itemSubClass = {
        [10] = {
            [0] = true, -- Money
        },
        [LE_ITEM_CLASS_CONSUMABLE] = {
            [0] = true, -- Explosives and Devices
            [1] = true, -- Potion
            [2] = true, -- Elixir
            [3] = true, -- Flask
            [4] = true, -- Scroll (OBSOLETE)
            [5] = true, -- Food & Drink
            [6] = true, -- Item Enhancement (OBSOLETE)
            [7] = true, -- Bandage
            [8] = true, -- Other
            [9] = true, -- Vantus Runes
        },
        [LE_ITEM_CLASS_CONTAINER] = {
            [0] = true, -- Bag
            [1] = true, -- Soul Bag
            [2] = true, -- Herb Bag
            [3] = true, -- Enchanting Bag
            [4] = true, -- Engineering Bag
            [5] = true, -- Gem Bag
            [6] = true, -- Mining Bag
            [7] = true, -- Leatherworking Bag
            [8] = true, -- Inscription Bag
            [9] = true, -- Tackle Box
            [10] = true, -- Cooking Bag
        },
        [LE_ITEM_CLASS_WEAPON] = {
            [LE_ITEM_WEAPON_AXE1H] 		    = C.HUNTER + C.PALADIN + C.SHAMAN + C.WARRIOR + C.DEATHKNIGHT + AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, C.ROGUE, 0), -- One-Handed Axes
            [LE_ITEM_WEAPON_AXE2H] 		    = C.HUNTER + C.PALADIN + C.SHAMAN + C.WARRIOR + C.DEATHKNIGHT, -- Two-Handed Axes
            [LE_ITEM_WEAPON_BOWS] 		    = C.HUNTER + C.ROGUE + C.WARRIOR, -- Bows
            [LE_ITEM_WEAPON_GUNS] 		    = C.HUNTER + C.ROGUE + C.WARRIOR, -- Guns
            [LE_ITEM_WEAPON_MACE1H] 		= C.DRUID + C.PALADIN + C.PRIEST + C.ROGUE + C.SHAMAN + C.WARRIOR + C.DEATHKNIGHT, -- One-Handed Maces
            [LE_ITEM_WEAPON_MACE2H] 		= C.DRUID + C.PALADIN + C.SHAMAN + C.WARRIOR + C.DEATHKNIGHT, -- Two-Handed Maces
            [LE_ITEM_WEAPON_POLEARM] 		= C.DRUID + C.HUNTER + C.PALADIN + C.WARRIOR + C.DEATHKNIGHT, -- Polearms
            [LE_ITEM_WEAPON_SWORD1H] 		= C.HUNTER + C.MAGE + C.PALADIN + C.ROGUE + C.WARLOCK + C.WARRIOR + C.DEATHKNIGHT, -- One-Handed Swords
            [LE_ITEM_WEAPON_SWORD2H] 		= C.HUNTER + C.PALADIN + C.WARRIOR, -- Two-Handed Swords
            [LE_ITEM_WEAPON_WARGLAIVE] 	    = true, -- Warglaives
            [LE_ITEM_WEAPON_STAFF] 		    = C.DRUID + C.MAGE + C.PRIEST + C.SHAMAN, -- Staves
            --[LE_ITEM_WEAPON_BEARCLAW] 	= true, -- Bear Claws
            --[LE_ITEM_WEAPON_CATCLAW] 		= true, -- CatClaws 
            [LE_ITEM_WEAPON_UNARMED]		= C.DRUID + C.ROGUE + C.SHAMAN + C.WARRIOR + C.HUNTER, -- Fist Weapons
            [LE_ITEM_WEAPON_GENERIC] 		= true, -- Miscellaneous
            [LE_ITEM_WEAPON_DAGGER] 		= C.DRUID + C.HUNTER + C.MAGE + C.PRIEST + C.ROGUE + C.SHAMAN + C.WARLOCK + C.WARRIOR, -- Daggers
            [LE_ITEM_WEAPON_THROWN] 		= C.ROGUE + C.WARRIOR, -- Thrown
            --[17] -- ignore
            [LE_ITEM_WEAPON_CROSSBOW] 	    = C.HUNTER + C.ROGUE + C.WARRIOR, -- Crossbows
            [LE_ITEM_WEAPON_WAND] 		    = C.MAGE + C.PRIEST + C.WARLOCK, -- Wands
            [LE_ITEM_WEAPON_FISHINGPOLE] 	= true, -- Fishing Poles
        },
        [LE_ITEM_CLASS_GEM] = {
            [1] = true, -- Blue
            [2] = true, -- Yellow
            [3] = true, -- Purple
            [4] = true, -- Green
            [5] = true, -- Orange
            [6] = true, -- Meta
            --[7] = true, -- Simple
            [8] = true, -- Prismatic
        },
        [LE_ITEM_CLASS_ARMOR] = {
            [LE_ITEM_ARMOR_GENERIC] 	= true, -- Miscellaneous
            [LE_ITEM_ARMOR_CLOTH] 	    = C.PRIEST + C.MAGE + C.WARLOCK, -- Cloth
            [LE_ITEM_ARMOR_LEATHER] 	= C.DRUID + C.ROGUE, -- Leather
            [LE_ITEM_ARMOR_MAIL] 	    = C.HUNTER + C.SHAMAN, -- Mail
            [LE_ITEM_ARMOR_PLATE] 	    = C.WARRIOR + C.PALADIN + C.DEATHKNIGHT, -- Plate
            [LE_ITEM_ARMOR_COSMETIC]    = true, -- Cosmetic
            [LE_ITEM_ARMOR_SHIELD] 	    = C.WARRIOR + C.PALADIN + C.SHAMAN, -- Shields
            [LE_ITEM_ARMOR_LIBRAM] 	    = C.PALADIN, -- Librams
            [LE_ITEM_ARMOR_IDOL] 	    = C.DRUID, -- Idols
            [LE_ITEM_ARMOR_TOTEM] 	    = C.SHAMAN, -- Totems
            --[LE_ITEM_ARMOR_SIGIL] 	    = true, -- Sigils (DK)
            [LE_ITEM_ARMOR_RELIC] 	    = C.SHAMAN + C.PALADIN + C.DRUID, -- Relic
        },
        [LE_ITEM_CLASS_REAGENT] = {
            [0] = true, -- Reagent
            [1] = true, -- Keystone
            [2] = true, -- Context Token
        },
        [LE_ITEM_CLASS_PROJECTILE] = {
            [0] = true, -- Wand
            [1] = true, -- Bolt
            [2] = C.HUNTER + C.ROGUE + C.WARRIOR, -- Arrow
            [3] = C.HUNTER + C.ROGUE + C.WARRIOR, -- Bullet
            [4] = C.HUNTER + C.ROGUE + C.WARRIOR, -- Thrown
        },
        [LE_ITEM_CLASS_TRADEGOODS] = {
            [0] = true, -- Trade Goods (OBSOLETE)
            [1] = true, -- Parts
            [2] = true, -- Explosives (OBSOLETE)
            [3] = true, -- Devices (OBSOLETE)
            [4] = true, -- Jewelcrafting
            [5] = true, -- Cloth
            [6] = true, -- Leather
            [7] = true, -- Metal & Stone
            [8] = true, -- Cooking
            [9] = true, -- Herb
            [10] = true, -- Elemental
            [11] = true, -- Other
            [12] = true, -- Enchanting
            [13] = true, -- Materials (OBSOLETE)
            [14] = true, -- Item Enchantment (OBSOLETE)
            [15] = true, -- Weapon Enchantment - Obsolete
            [16] = true, -- Inscription
            [17] = true, -- Explosives and Devices (OBSOLETE)
        },
        [LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {
            [0] = true, -- Head
            [1] = true, -- Neck
            [2] = true, -- Shoulder
            [3] = true, -- Cloak
            [4] = true, -- Chest
            [5] = true, -- Wrist
            [6] = true, -- Hands
            [7] = true, -- Waist
            [8] = true, -- Legs
            [9] = true, -- Feet
            [10] = true, -- Finger
            [11] = true, -- Weapon
            [12] = true, -- Two-Handed Weapon
            [13] = true, -- Shield/Off-hand
            [14] = true, -- Misc
        },
        [LE_ITEM_CLASS_RECIPE] = {
            [LE_ITEM_RECIPE_BOOK] 			    = true, -- Book
            [LE_ITEM_RECIPE_LEATHERWORKING] 	= true, -- Leatherworking
            [LE_ITEM_RECIPE_TAILORING] 		    = true, -- Tailoring
            [LE_ITEM_RECIPE_ENGINEERING] 	    = true, -- Engineering
            [LE_ITEM_RECIPE_BLACKSMITHING] 	    = true, -- Blacksmithing
            [LE_ITEM_RECIPE_COOKING] 		    = true, -- Cooking
            [LE_ITEM_RECIPE_ALCHEMY] 		    = true, -- Alchemy
            [LE_ITEM_RECIPE_FIRST_AID] 		    = true, -- First Aid
            [LE_ITEM_RECIPE_ENCHANTING] 		= true, -- Enchanting
            [LE_ITEM_RECIPE_FISHING] 		    = true, -- Fishing
            [LE_ITEM_RECIPE_JEWELCRAFTING] 	    = true, -- Jewelcrafting
            [LE_ITEM_RECIPE_INSCRIPTION] 	    = true, -- Inscription
        },
        [LE_ITEM_CLASS_QUIVER] = {
            [0] = C.HUNTER, -- Quiver(OBSOLETE)
            [1] = true, -- Bolt(OBSOLETE)
            [2] = C.HUNTER, -- Quiver
            [3] = C.HUNTER, -- Ammo Pouch
        },
        [LE_ITEM_CLASS_QUESTITEM] = {
            [0] = true, -- Quest
        },
        [LE_ITEM_CLASS_KEY] = {
            [0] = true, -- Quest
            [1] = true, -- Lockpick
        },
        [LE_ITEM_CLASS_MISCELLANEOUS] = {
            [LE_ITEM_MISCELLANEOUS_JUNK] 			    = true, -- Junk
            [LE_ITEM_MISCELLANEOUS_REAGENT] 			= true, -- Reagent
            [LE_ITEM_MISCELLANEOUS_COMPANION_PET] 	    = true, -- Companion Pets
            [LE_ITEM_MISCELLANEOUS_HOLIDAY] 			= true, -- Holiday
            [LE_ITEM_MISCELLANEOUS_OTHER] 			    = true, -- Other
            [LE_ITEM_MISCELLANEOUS_MOUNT] 			    = true, -- Mount
            --[LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] 	= true, -- Mount Equipment
        },
    }
}
local LINKED_STATS = {
    ["ITEM_MOD_HEALTH"] = "ITEM_MOD_HEALTH_SHORT",
    ["ITEM_MOD_AGILITY"] = "ITEM_MOD_AGILITY_SHORT",
    ["ITEM_MOD_STRENGTH"] = "ITEM_MOD_STRENGTH_SHORT",
    ["ITEM_MOD_SPIRIT"] = "ITEM_MOD_SPIRIT_SHORT",
    ["ITEM_MOD_STAMINA"] = "ITEM_MOD_STAMINA_SHORT",
    ["ITEM_MOD_INTELLECT"] = "ITEM_MOD_INTELLECT_SHORT",
    ["ITEM_MOD_MANA"] = "ITEM_MOD_MANA_SHORT",

    ["ITEM_MOD_HEALTH_REGEN"] = "ITEM_MOD_HEALTH_REGEN_SHORT",
    ["ITEM_MOD_HEALTH_REGENERATION"] = "ITEM_MOD_HEALTH_REGEN_SHORT",
    ["ITEM_MOD_HEALTH_REGEN"] = "ITEM_MOD_HEALTH_REGEN_SHORT",

    ["ITEM_MOD_HIT_RATING"] = "ITEM_MOD_HIT_RATING_SHORT",
    ["ITEM_MOD_HIT_MELEE_RATING"] = "ITEM_MOD_HIT_MELEE_RATING_SHORT",
    ["ITEM_MOD_HIT_RANGED_RATING"] = "ITEM_MOD_HIT_RANGED_RATING_SHORT",
    ["ITEM_MOD_HIT_SPELL_RATING"] = "ITEM_MOD_HIT_SPELL_RATING_SHORT",

    ["ITEM_MOD_CRIT_RATING"] = "ITEM_MOD_CRIT_RATING_SHORT",
    ["ITEM_MOD_CRIT_MELEE_RATING"] = "ITEM_MOD_CRIT_MELEE_RATING_SHORT",
    ["ITEM_MOD_CRIT_RANGED_RATING"] = "ITEM_MOD_CRIT_RANGED_RATING_SHORT",
    ["ITEM_MOD_CRIT_SPELL_RATING"] = "ITEM_MOD_CRIT_SPELL_RATING_SHORT",

    ["ITEM_MOD_ATTACK_POWER"] = "ITEM_MOD_ATTACK_POWER_SHORT",
    ["ITEM_MOD_MELEE_ATTACK_POWER"] = "ITEM_MOD_MELEE_ATTACK_POWER_SHORT",
    ["ITEM_MOD_RANGED_ATTACK_POWER"] = "ITEM_MOD_RANGED_ATTACK_POWER_SHORT",
    ["ITEM_MOD_FERAL_ATTACK_POWER"] = "ITEM_MOD_FERAL_ATTACK_POWER_SHORT",

    ["ITEM_MOD_SPELL_POWER"] = "ITEM_MOD_SPELL_POWER_SHORT",
    ["ITEM_MOD_SPELL_HEALING"] = "ITEM_MOD_SPELL_HEALING_DONE_SHORT",
    ["ITEM_MOD_SPELL_DAMAGE"] = "ITEM_MOD_SPELL_DAMAGE_DONE_SHORT",
    ["ITEM_MOD_SPELL_DAMAGE_DONE"] = "ITEM_MOD_SPELL_DAMAGE_DONE_SHORT",
    ["ITEM_MOD_SPELL_HEALING_DONE"] = "ITEM_MOD_SPELL_HEALING_DONE_SHORT",

    ["ITEM_MOD_DEFENSE_SKILL_RATING"] = "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT",
    ["ITEM_MOD_DODGE_RATING"] = "ITEM_MOD_DODGE_RATING_SHORT",
    ["ITEM_MOD_PARRY_RATING"] = "ITEM_MOD_PARRY_RATING_SHORT",
    ["ITEM_MOD_EXTRA_ARMOR"] = "ITEM_MOD_EXTRA_ARMOR_SHORT",

    ["ITEM_MOD_ARMOR_PENETRATION_RATING"] = "ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT",
    ["ITEM_MOD_SPELL_PENETRATION"] = "ITEM_MOD_SPELL_PENETRATION_SHORT",

    ["ITEM_MOD_MANA_REGENERATION"] = "ITEM_MOD_MANA_REGENERATION_SHORT",
    ["ITEM_MOD_HEALTH_REGENERATION"] = "ITEM_MOD_HEALTH_REGENERATION_SHORT",

    ["ITEM_MOD_RESILIENCE_RATING"] = "ITEM_MOD_RESILIENCE_RATING_SHORT",
}
for k,v in pairs(LINKED_STATS) do LINKED_STATS[v] = v end

local STAT_LIST = {
    {
        name = AL["Main"],
        --"ITEM_MOD_HEALTH_SHORT", -- Health
        "ITEM_MOD_AGILITY_SHORT", -- Agility
        "ITEM_MOD_STRENGTH_SHORT", -- Strength
        "ITEM_MOD_INTELLECT_SHORT", -- Intellect
        "ITEM_MOD_SPIRIT_SHORT", -- Spirit
        "ITEM_MOD_STAMINA_SHORT", -- Stamina
        "ITEM_MOD_MANA_SHORT", -- Mana
    },
    {
        name = AL["Regen"],
        "ITEM_MOD_POWER_REGEN0_SHORT", -- Mana Per 5 Sec.
        "ITEM_MOD_POWER_REGEN1_SHORT", -- Rage Per 5 Sec.
        "ITEM_MOD_POWER_REGEN2_SHORT", -- Focus Per 5 Sec.
        "ITEM_MOD_POWER_REGEN3_SHORT", -- Energy Per 5 Sec.
        "ITEM_MOD_POWER_REGEN4_SHORT", -- Happiness Per 5 Sec.
        --"ITEM_MOD_POWER_REGEN5_SHORT", -- Runes Per 5 Sec.
        --"ITEM_MOD_POWER_REGEN6_SHORT", -- Runic Power Per 5 Sec.
        "ITEM_MOD_HEALTH_REGEN_SHORT", -- Health Per 5 Sec.
    },
    {
        name = AL["Bonus"],
        "ITEM_MOD_SPELL_POWER_SHORT", -- Spell Power
        "ITEM_MOD_SPELL_HEALING_DONE_SHORT", -- Increases healing done by magical spells and effects by up to %s.
        "ITEM_MOD_SPELL_DAMAGE_DONE_SHORT", -- Increases damage done by magical spells and effects by up to %s.
        "",
        "ITEM_MOD_ATTACK_POWER_SHORT", -- Attack Power
        "ITEM_MOD_MELEE_ATTACK_POWER_SHORT", -- Melee Attack Power
        "ITEM_MOD_RANGED_ATTACK_POWER_SHORT", -- Ranged Attack Power
        "ITEM_MOD_FERAL_ATTACK_POWER_SHORT", -- Attack Power In Forms
        "",
        "ITEM_MOD_HIT_RATING_SHORT", -- Hit
        "ITEM_MOD_HIT_MELEE_RATING_SHORT", -- Hit (Melee)
        "ITEM_MOD_HIT_RANGED_RATING_SHORT", -- Hit (Ranged)
        "ITEM_MOD_HIT_SPELL_RATING_SHORT", -- Hit (Spell)
        "",
        "ITEM_MOD_CRIT_RATING_SHORT", -- Critical Strike
        "ITEM_MOD_CRIT_MELEE_RATING_SHORT", -- Critical Strike (Melee)
        "ITEM_MOD_CRIT_RANGED_RATING_SHORT", -- Critical Strike (Ranged)
        "ITEM_MOD_CRIT_SPELL_RATING_SHORT", -- Critical Strike (Spell)
    },
    {
        name = AL["Special"],
        "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT", -- Defense
        "ITEM_MOD_DODGE_RATING_SHORT", -- Dodge
        "ITEM_MOD_PARRY_RATING_SHORT", -- Parry
        "ITEM_MOD_EXTRA_ARMOR_SHORT", -- Bonus Armor
        "",
        "ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT", -- Armor Penetration
        "ITEM_MOD_SPELL_PENETRATION_SHORT", -- Spell Penetration
        "",
        "ITEM_MOD_MANA_REGENERATION_SHORT", -- Mana Regeneration
        "ITEM_MOD_HEALTH_REGENERATION_SHORT", -- Health Regeneration
        "",
        "ITEM_MOD_RESILIENCE_RATING_SHORT", -- PvP Resilience
    }
}
local CLASS_FILTER

-- defaults
-- "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"
AtlasLoot.AtlasLootDBDefaults.profile.ClassFilter = {
	["WARRIOR"] = {
        ["*"] = true,
        ["ITEM_MOD_INTELLECT_SHORT"] = false,
    },
    ["PALADIN"] = {
        ["*"] = true,
    },
    ["HUNTER"] = {
        ["*"] = true,
    },
    ["ROGUE"] = {
        ["*"] = true,
        ["ITEM_MOD_INTELLECT_SHORT"] = false,
    },
    ["PRIEST"] = {
        ["*"] = true,
        ["ITEM_MOD_STRENGTH_SHORT"] = false,
        ["ITEM_MOD_AGILITY_SHORT"] = false,
        ["ITEM_MOD_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = false,
        ["ITEM_MOD_PARRY_RATING_SHORT"] = false,
        ["ITEM_MOD_DODGE_RATING_SHORT"] = false,
    },
    ["SHAMAN"] = {
        ["*"] = true,
    },
    ["MAGE"] = {
        ["*"] = true,
        ["ITEM_MOD_STRENGTH_SHORT"] = false,
        ["ITEM_MOD_AGILITY_SHORT"] = false,
        ["ITEM_MOD_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = false,
        ["ITEM_MOD_PARRY_RATING_SHORT"] = false,
        ["ITEM_MOD_DODGE_RATING_SHORT"] = false,
    },
    ["WARLOCK"] = {
        ["*"] = true,
        ["ITEM_MOD_STRENGTH_SHORT"] = false,
        ["ITEM_MOD_AGILITY_SHORT"] = false,
        ["ITEM_MOD_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] = false,
        ["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = false,
        ["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = false,
        ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = false,
        ["ITEM_MOD_PARRY_RATING_SHORT"] = false,
        ["ITEM_MOD_DODGE_RATING_SHORT"] = false,
    },
    ["DRUID"] = {
        ["*"] = true,
    },
    ["DEATHKNIGHT"] = {
        ["*"] = true,
        ["ITEM_MOD_INTELLECT_SHORT"] = false,
    },
}

local ITEM_SUB_CLASS_IGNORE = {
    [LE_ITEM_CLASS_ARMOR] = {
        ["INVTYPE_CLOAK"] = true,
    }
}

local function OnInit()
    db = AtlasLoot.db.ClassFilter
end
AtlasLoot:AddInitFunc(OnInit)

local function BitToTable(bit)
    local t = {}
    for classID = 1, #CLASS_SORT do
        if bit == true or bit_band(bit, CLASS_BITS[CLASS_SORT[classID]]) ~= 0 then
            t[classID] = true
        else
            t[classID] = false
        end
    end
    return t
end

local function BuildClassFilterList()
    CLASS_FILTER = {}
    for mainCatName, mainCat in pairs(FILTER_DATA) do
        CLASS_FILTER[mainCatName] = {}
        if mainCatName == "itemSubClass" then
            for itemClassID, itemClass in pairs(mainCat) do
                CLASS_FILTER[mainCatName][itemClassID] = {}
                for itemSubClassID, itemSubClassBit in pairs(itemClass) do
                    CLASS_FILTER[mainCatName][itemClassID][itemSubClassID] = BitToTable(itemSubClassBit)
                end
            end
        else
            for id, bit in pairs(mainCat) do
                CLASS_FILTER[mainCatName][id] = BitToTable(bit)
            end
        end
    end

    FILTER_DATA = nil
end

local OptionsClassSort
function ClassFilter.GetStatListForOptions()
    if not OptionsClassSort then
        local ownClass = UnitClassBase("player")
        OptionsClassSort = { ownClass }
        for k,v in ipairs(CLASS_SORT) do
            if v ~= ownClass then
                OptionsClassSort[#OptionsClassSort+1] = v
            end
        end
    end
    return STAT_LIST, OptionsClassSort, db
end

function ClassFilter.ClassCanUseItem(className, itemID)
    if not className or not itemID then return true end
    if not CLASS_FILTER then BuildClassFilterList() end
    local _, itemType, itemSubType, itemEquipLoc, icon, itemClassID, itemSubClassID = GetItemInfoInstant(itemID)
    local classID = CLASS_NAME_TO_ID[className]
    if not itemType or not classID then return true end

    if not Requirements.ClassCanUseItem(className, itemID) then
        return false
    end

    if CLASS_FILTER.itemEquipLoc[itemEquipLoc] and not CLASS_FILTER.itemEquipLoc[itemEquipLoc][classID] then
        return false
    end

    if CLASS_FILTER.itemClass[itemClassID] and not CLASS_FILTER.itemClass[itemClassID][classID] then
        return false
    end

    if ITEM_SUB_CLASS_IGNORE[itemClassID] and ITEM_SUB_CLASS_IGNORE[itemClassID][itemEquipLoc] then
        -- ignore
    elseif CLASS_FILTER.itemSubClass[itemClassID][itemSubClassID] and not CLASS_FILTER.itemSubClass[itemClassID][itemSubClassID][classID] then
        return false
    end

    -- check stats
    local stats = GetItemStats(type(itemID) == "string" and itemID or "item:"..itemID)
    if stats then
        for stat in pairs(stats) do
            if db[className][LINKED_STATS[stat] or stat] == false then
                return false
            end
        end
    end

    return true
end