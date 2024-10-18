-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.WRATH_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)

local GEM_FORMAT1 = ALIL["Gems"].." - %s"
local GEM_FORMAT2 = ALIL["Gems"].." - %s & %s"

data["AlchemyWrath"] = {
    name = ALIL["Alchemy"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ALCHEMY_LINK,
    items = {
        {
            name = AL["Flasks"],
            [NORMAL_DIFF] = {
                { 1, 53903 },	-- Flask of Endless Rage
                { 2, 54213 },	-- Flask of Pure Mojo
                { 3, 53902 },	-- Flask of Stoneblood
                { 4, 53901 },	-- Flask of the Frost Wyrm
                { 5, 62213 },	-- Lesser Flask of Resistance
                { 6, 53899 },	-- Lesser Flask of Toughness
                { 16, 67025 },	-- Flask of the North
            },
        },
        {
            name = AL["Transmutes"],
            [NORMAL_DIFF] = {
                { 1, 66658 },	-- Transmute: Ametrine
                { 2, 66662 },	-- Transmute: Dreadstone
                { 3, 66664 },	-- Transmute: Eye of Zul
                { 4, 66660 },	-- Transmute: King's Amber
                { 5, 66663 },	-- Transmute: Majestic Zircon
                { 6, 66659 },	-- Transmute: Cardinal Ruby
                { 8, 57425 },	-- Transmute: Skyflare Diamond
                { 9, 57427 },	-- Transmute: Earthsiege Diamond
                { 11, 60350 },	-- Transmute: Titanium
                { 16, 53777 },	-- Transmute: Eternal Air to Earth
                { 17, 53776 },	-- Transmute: Eternal Air to Water
                { 18, 53781 },	-- Transmute: Eternal Earth to Air
                { 19, 53782 },	-- Transmute: Eternal Earth to Shadow
                { 20, 53775 },	-- Transmute: Eternal Fire to Life
                { 21, 53774 },	-- Transmute: Eternal Fire to Water
                { 22, 53773 },	-- Transmute: Eternal Life to Fire
                { 23, 53771 },	-- Transmute: Eternal Life to Shadow
                { 24, 53779 },	-- Transmute: Eternal Shadow to Earth
                { 25, 53780 },	-- Transmute: Eternal Shadow to Life
                { 26, 53783 },	-- Transmute: Eternal Water to Air
                { 27, 53784 },	-- Transmute: Eternal Water to Fire
            },
        },
        {
            name = AL["Healing/Mana Potions"],
            [NORMAL_DIFF] = {
            { 1, 53904 },	-- Powerful Rejuvenation Potion
            { 2, 53895 },	-- Crazy Alchemist's Potion

            { 4, 58871 },	-- Endless Healing Potion
            { 5, 53836 },	-- Runic Healing Potion
            { 6, 53838 },	-- Resurgent Healing Potion

            { 16, 53900 },	-- Potion of Nightmares

            { 19, 58868 },	-- Endless Mana Potion
            { 20, 53837 },	-- Runic Mana Potion
            { 21, 53839 },	-- Icy Mana Potion
            },
        },
        {
            name = AL["Protection Potions"],
            [NORMAL_DIFF] = {
                { 1, 53936 },	-- Mighty Arcane Protection Potion
                { 2, 53939 },	-- Mighty Fire Protection Potion
                { 3, 53937 },	-- Mighty Frost Protection Potion
                { 4, 53942 },	-- Mighty Nature Protection Potion
                { 5, 53938 },	-- Mighty Shadow Protection Potion
            },
        },
        {
            name = AL["Util Potions"],
            [NORMAL_DIFF] = {
                { 1, 54221 },	-- Potion of Speed
                { 2, 54222 },	-- Potion of Wild Magic
                { 3, 53905 },	-- Indestructible Potion
            },
        },
        {
            name = AL["Elixirs"],
            [NORMAL_DIFF] = {
                { 1, 60354 },	-- Elixir of Accuracy
                { 2, 60365 },	-- Elixir of Armor Piercing
                { 3, 60355 },	-- Elixir of Deadly Strikes
                { 4, 60357 },	-- Elixir of Expertise
                { 5, 60366 },	-- Elixir of Lightning Speed
                { 6, 56519 },	-- Elixir of Mighty Mageblood
                { 7, 53840 },	-- Elixir of Mighty Agility
                { 8, 54218 },	-- Elixir of Mighty Strength
                { 9, 53847 },	-- Elixir of Spirit
                { 10, 53848 },	-- Guru's Elixir
                { 11, 53842 },	-- Spellpower Elixir
                { 12, 53841 },	-- Wrath Elixir
                { 16, 60356 },	-- Elixir of Mighty Defense
                { 17, 54220 },	-- Elixir of Protection
                { 18, 62410 },	-- Elixir of Water Walking
                { 19, 60367 },	-- Elixir of Mighty Thoughts
                { 20, 53898 },	-- Elixir of Mighty Fortitude
            },
        },
        {
            name = AL["Stones"],
            [NORMAL_DIFF] = {
                { 1, 60403 },	-- Indestructible Alchemist Stone
                { 2, 60396 },	-- Mercurial Alchemist Stone
                { 3, 60405 },	-- Mighty Alchemist Stone
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 62409 },	-- Ethereal Oil
                { 2, 53812 },	-- Pygmy Oil
            },
        }
    },
}

data["BlacksmithingWrath"] = {
    name = ALIL["Blacksmithing"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.BLACKSMITHING_LINK,
    items = {
        { -- Daggers
            name = AL["Weapons"].." - "..ALIL["Daggers"],
            [NORMAL_DIFF] = {
                { 1, 56234 },	-- Titansteel Shanker
                { 2, 55181 },	-- Saronite Shiv
                { 3, 55179 },	-- Saronite Ambusher
                { 16, 63182 },	-- Titansteel Spellblade
            }
        },
        { -- Axes
            name = AL["Weapons"].." - "..AL["Axes"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
                { 2, 55204 },	-- Notched Cobalt War Axe
                { 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
                { 17, 55174 },	-- Honed Cobalt Cleaver
            }
        },
        { -- Maces
            name = AL["Weapons"].." - "..AL["Maces"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
                { 2, 55370 },	-- Titansteel Bonecrusher
                { 3, 55371 },	-- Titansteel Guardian
                { 4, 56280 },	-- Cudgel of Saronite Justice
                { 5, 55182 },	-- Furious Saronite Beatstick
                { 6, 55201 },	-- Cobalt Tenderizer
                { 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
                { 17, 55369 },	-- Titansteel Destroyer
                { 18, 55185 },	-- Saronite Mindcrusher
            }
        },
        { -- Swords
            name = AL["Weapons"].." - "..AL["Swords"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
                { 2, 55183 },	-- Corroded Saronite Edge
                { 3, 55184 },	-- Corroded Saronite Woundbringer
                { 4, 59442 },	-- Saronite Spellblade
                { 5, 55177 },	-- Savage Cobalt Slicer
                { 6, 55200 },	-- Sturdy Cobalt Quickblade
                { 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
                { 17, 55203 },	-- Forged Cobalt Claymore
            }
        },
        { -- Shield
            name = AL["Weapons"].." - "..ALIL["Shield"],
            [NORMAL_DIFF] = {
                { 1, 56400 },	-- Titansteel Shield Wall
                { 2, 55014 },	-- Saronite Bulwark
                { 3, 54557 },	-- Saronite Defender
                { 4, 54550 },	-- Cobalt Triangle Shield
                { 16, 55013 },	-- Saronite Protector
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [PLATE_DIFF] = {
                { 1, 55374 },	-- Brilliant Titansteel Helm
                { 2, 55372 },	-- Spiked Titansteel Helm
                { 3, 55373 },	-- Tempered Titansteel Helm
                { 4, 55302 },	-- Helm of Command
                { 5, 56556 },	-- Ornate Saronite Skullshield
                { 6, 55312 },	-- Savage Saronite Skullshield
                { 7, 59441 },	-- Brilliant Saronite Helm
                { 8, 54555 },	-- Tempered Saronite Helm
                { 9, 54949 },	-- Horned Cobalt Helm
                { 10, 54979 },	-- Reinforced Cobalt Helm
                { 11, 54917 },	-- Spiked Cobalt Helm
                { 12, 52571 },	-- Cobalt Helm
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [PLATE_DIFF] = {
                { 1, 56550 },	-- Ornate Saronite Pauldrons
                { 2, 55306 },	-- Savage Saronite Pauldrons
                { 3, 59440 },	-- Brilliant Saronite Pauldrons
                { 4, 54556 },	-- Tempered Saronite Shoulders
                { 5, 54941 },	-- Spiked Cobalt Shoulders
                { 6, 54978 },	-- Reinforced Cobalt Shoulders
                { 7, 52572 },	-- Cobalt Shoulders
            },
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [PLATE_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67091 }, [ATLASLOOT_IT_HORDE] = { 67130 } },	-- Breastplate of the White Knight
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67095 }, [ATLASLOOT_IT_HORDE] = { 67134 } },	-- Sunforged Breastplate
                { 3, [ATLASLOOT_IT_ALLIANCE] = { 67093 }, [ATLASLOOT_IT_HORDE] = { 67132} },	-- Titanium Razorplate
                { 4, 61008 },	-- Icebane Chestguard
                { 5, 55311 },	-- Savage Saronite Hauberk
                { 6, 55058 },	-- Brilliant Saronite Breastplate
                { 7, 55186 },	-- Chestplate of Conquest
                { 8, 54553 },	-- Tempered Saronite Breastplate
                { 9, 54944 },	-- Spiked Cobalt Chestpiece
                { 10, 54981 },	-- Reinforced Cobalt Chestpiece
                { 11, 52570 },	-- Cobalt Chestpiece
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [PLATE_DIFF] = {
                { 1, 70568 },	-- Boots of Kingly Upheaval
                { 2, 70566 },	-- Hellfrozen Bonegrinders
                { 3, 70563 },	-- Protectors of Life
                { 4, 63188 },	-- Battlelord's Plate Boots
                { 5, 63192 },	-- Spiked Deathdealers
                { 6, 63190 },	-- Treads of Destiny
                { 7, 55377 },	-- Brilliant Titansteel Treads
                { 8, 55375 },	-- Spiked Titansteel Treads
                { 9, 55376 },	-- Tempered Titansteel Treads
                { 10, 61010 },	-- Icebane Treads
                { 11, 56552 },	-- Ornate Saronite Walkers
                { 12, 55308 },	-- Savage Saronite Walkers
                { 13, 55057 },	-- Brilliant Saronite Boots
                { 14, 54552 },	-- Tempered Saronite Boots
                { 15, 54918 },	-- Spiked Cobalt Boots
                { 16, 52569 },	-- Cobalt Boots
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [PLATE_DIFF] = {
                { 1, 55301 },	-- Daunting Handguards
                { 2, 56553 },	-- Ornate Saronite Gauntlets
                { 3, 55300 },	-- Righteous Gauntlets
                { 4, 55309 },	-- Savage Saronite Gauntlets
                { 5, 55015 },	-- Tempered Saronite Gauntlets
                { 6, 55056 },	-- Brilliant Saronite Gauntlets
                { 7, 54945 },	-- Spiked Cobalt Gauntlets
                { 8, 55835 },	-- Cobalt Gauntlets
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [PLATE_DIFF] = {
                { 1, 70565 },	-- Legplates of Painful Death
                { 2, 70567 },	-- Pillars of Might
                { 3, 70562 },	-- Puresteel Legplates
                { 4, 55303 },	-- Daunting Legplates
                { 5, 56554 },	-- Ornate Saronite Legplates
                { 6, 55304 },	-- Righteous Greaves
                { 7, 55310 },	-- Savage Saronite Legplates
                { 8, 55187 },	-- Legplates of Conquest
                { 9, 55055 },	-- Brilliant Saronite Legplates
                { 10, 54554 },	-- Tempered Saronite Legplates
                { 11, 54947 },	-- Spiked Cobalt Legplates
                { 12, 54980 },	-- Reinforced Cobalt Legplates
                { 13, 52567 },	-- Cobalt Legplates
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [PLATE_DIFF] = {
                { 1, 63187 },	-- Belt of the Titans
                { 2, 63191 },	-- Indestructible Plate Girdle
                { 3, 63189 },	-- Plate Girdle of Righteousness
                { 4, 61009 },	-- Icebane Girdle
                { 5, 56551 },	-- Ornate Saronite Waistguard
                { 6, 55307 },	-- Savage Saronite Waistguard
                { 7, 59436 },	-- Brilliant Saronite Belt
                { 8, 54551 },	-- Tempered Saronite Belt
                { 9, 54946 },	-- Spiked Cobalt Belt
                { 10, 52568 },	-- Cobalt Belt
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [PLATE_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67092 }, [ATLASLOOT_IT_HORDE] = { 67131 } },	-- Saronite Swordbreakers
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67096 }, [ATLASLOOT_IT_HORDE] = { 67135 } },	-- Sunforged Bracers
                { 3, [ATLASLOOT_IT_ALLIANCE] = { 67094 }, [ATLASLOOT_IT_HORDE] = { 67133 } },	-- Titanium Spikeguard
                { 4, 56549 },	-- Ornate Saronite Bracers
                { 5, 55305 },	-- Savage Saronite Bracers
                { 6, 55298 },	-- Vengeance Bindings
                { 7, 55017 },	-- Tempered Saronite Bracers
                { 8, 59438 },	-- Brilliant Saronite Bracers
                { 9, 54948 },	-- Spiked Cobalt Bracers
                { 10, 55834 },	-- Cobalt Bracers
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 55656 },	-- Eternal Belt Buckle
                { 6, 55641 },	-- Socket Gloves
                { 16, 56357 },	-- Titanium Shield Spike
                { 17, 62202 },	-- Titanium Plating
                { 19, 55839 },	-- Titanium Weapon Chain
                { 21, 55628 },	-- Socket Bracer
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 59406 },	-- Titanium Skeleton Key
                { 3, 55732 },	-- Titanium Rod
            }
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 814 }, -- Ornate Saronite Battlegear
                { 2, 816 }, -- Savage Saronite Battlegear
            },
        },
    }
}

data["EnchantingWrath"] = {
    name = ALIL["Enchanting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENCHANTING_LINK,
    items = {
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 64441 },	-- Enchant Weapon - Blade Ward
                { 2, 64579 },	-- Enchant Weapon - Blood Draining
                { 3, 59619 },	-- Enchant Weapon - Accuracy
                { 4, 59625 },	-- Enchant Weapon - Black Magic
                { 5, 59621 },	-- Enchant Weapon - Berserking
                { 6, 60714 },	-- Enchant Weapon - Mighty Spellpower
                { 7, 60707 },	-- Enchant Weapon - Superior Potency
                { 8, 44621 },	-- Enchant Weapon - Giant Slayer
                { 9, 44524 },	-- Enchant Weapon - Icebreaker
                { 10, 44576 },	-- Enchant Weapon - Lifeward
                { 11, 44633 },	-- Enchant Weapon - Exceptional Agility
                { 12, 44510 },	-- Enchant Weapon - Exceptional Spirit
                { 13, 44629 },	-- Enchant Weapon - Exceptional Spellpower
                { 14, 60621 },	-- Enchant Weapon - Greater Potency
            }
        },
        {
            name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 60691 },	-- Enchant 2H Weapon - Massacre
                { 2, 44595 },	-- Enchant 2H Weapon - Scourgebane
                { 3, 44630 },	-- Enchant 2H Weapon - Greater Savagery
                { 16, 62948 },	-- Enchant Staff - Greater Spellpower
                { 17, 62959 },	-- Enchant Staff - Spellpower
            }
        },
        {
            name = ALIL["Cloak"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 44631 },	-- Enchant Cloak - Shadow Armor
                { 2, 47899 },	-- Enchant Cloak - Wisdom
                { 3, 44591 },	-- Enchant Cloak - Superior Dodge
                { 4, 47898 },	-- Enchant Cloak - Greater Speed
                { 5, 47672 },	-- Enchant Cloak - Mighty Stamina
                { 6, 60663 },	-- Enchant Cloak - Major Agility
                { 7, 44500 },	-- Enchant Cloak - Superior Agility
                { 8, 44582 },	-- Enchant Cloak - Minor Power
                { 9, 60609 },	-- Enchant Cloak - Speed

                { 20, 44596 },	-- Enchant Cloak - Superior Arcane Resistance
                { 19, 44556 },	-- Enchant Cloak - Superior Fire Resistance
                { 16, 44483 },	-- Enchant Cloak - Superior Frost Resistance
                { 17, 44494 },	-- Enchant Cloak - Superior Nature Resistance
                { 18, 44590 },	-- Enchant Cloak - Superior Shadow Resistance



            }
        },
        {
            name = ALIL["Chest"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 60692 },	-- Enchant Chest - Powerful Stats
                { 2, 47900 },	-- Enchant Chest - Super Health
                { 3, 44509 },	-- Enchant Chest - Greater Mana Restoration
                { 4, 44588 },	-- Enchant Chest - Exceptional Resilience
                { 5, 47766 },	-- Enchant Chest - Greater Dodge
                { 6, 44492 },	-- Enchant Chest - Mighty Health
                { 7, 44623 },	-- Enchant Chest - Super Stats
                { 8, 27958 },	-- Enchant Chest - Exceptional Mana
            }
        },
        {
            name = ALIL["Feet"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 60763 },	-- Enchant Boots - Greater Assault
                { 2, 47901 },	-- Enchant Boots - Tuskarr's Vitality
                { 3, 44508 },	-- Enchant Boots - Greater Spirit
                { 4, 44589 },	-- Enchant Boots - Superior Agility
                { 5, 44584 },	-- Enchant Boots - Greater Vitality
                { 6, 44528 },	-- Enchant Boots - Greater Fortitude
                { 7, 60623 },	-- Enchant Boots - Icewalker
                { 8, 60606 },	-- Enchant Boots - Assault
            }
        },
        {
            name = ALIL["Hand"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 44625 },	-- Enchant Gloves - Armsman
                { 2, 60668 },	-- Enchant Gloves - Crusher
                { 3, 44513 },	-- Enchant Gloves - Greater Assault
                { 4, 44529 },	-- Enchant Gloves - Major Agility
                { 5, 44488 },	-- Enchant Gloves - Precision
                { 6, 44484 },	-- Enchant Gloves - Haste
                { 7, 71692 },	-- Enchant Gloves - Angler
                { 8, 44506 },	-- Enchant Gloves - Gatherer
                { 9, 44592 },	-- Enchant Gloves - Exceptional Spellpower
            }
        },
        {
            name = ALIL["Shield"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 44489 },	-- Enchant Shield - Dodge
                { 2, 60653 },	-- Enchant Shield - Greater Intellect
            }
        },
        {
            name = ALIL["Wrist"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 62256 },	-- Enchant Bracer - Major Stamina
                { 2, 60767 },	-- Enchant Bracer - Superior Spellpower
                { 3, 44575 },	-- Enchant Bracer - Greater Assault
                { 4, 44598 },	-- Enchant Bracer - Haste
                { 5, 44616 },	-- Enchant Bracer - Greater Stats
                { 6, 44593 },	-- Enchant Bracer - Major Spirit
                { 7, 44635 },	-- Enchant Bracer - Greater Spellpower
                { 8, 44555 },	-- Enchant Bracer - Exceptional Intellect
                { 9, 60616 },	-- Enchant Bracer - Assault
            }
        },
        {
            name = AL["Ring"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 44636 },	-- Enchant Ring - Greater Spellpower
                { 2, 44645 },	-- Enchant Ring - Assault
                { 3, 59636 },	-- Enchant Ring - Stamina
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 69412 },	-- Abyssal Shatter
                { 3, 60619 },   -- Runed Titanium Rod
            }
        },
    }
}

data["EngineeringWrath"] = {
    name = ALIL["Engineering"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENGINEERING_LINK,
    items = {
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Cloth"],
            [NORMAL_DIFF] = {
                { 1, 56484 },	-- Visage Liquification Goggles
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
            [NORMAL_DIFF] = {
                { 1, 56486 },	-- Greensight Gogs
                { 2, 56481 },	-- Weakness Spectralizers
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
            [NORMAL_DIFF] = {
                { 1, 56487 },	-- Electroflux Sight Enhancers
                { 2, 56574 },	-- Truesight Ice Blinders
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
            [NORMAL_DIFF] = {
                { 1, 56480 },	-- Armored Titanium Goggles
                { 2, 56483 },	-- Charged Titanium Specs
                { 3, 62271 },	-- Unbreakable Healing Amplifiers
                { 16, 61483 },	-- Mechanized Snow Goggles
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 56469 },	-- Gnomish Lightning Generator
                { 2, 56467 },	-- Noise Machine
                { 3, 56466 },	-- Sonic Booster
            }
        },
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 56478 },	-- Heartseeker Scope
                { 2, 56470 },	-- Sun Scope
                { 3, 61471 },	-- Diamond-Cut Refractor Scope
            }
        },
        {
            name = AL["Weapons"].." - "..ALIL["Guns"],
            [NORMAL_DIFF] = {
                { 1, 56479 },	-- Armor Plated Combat Shotgun
                { 2, 60874 },	-- Nesingwary 4000
                { 3, 54353 },	-- Mark "S" Boomstick
            }
        },
        {
            name = ALIL["Projectile"],
            [NORMAL_DIFF] = {
                { 1, 72953 },	-- Iceblade Arrow
                { 2, 56475 },	-- Saronite Razorheads
                { 16, 72952 },	-- Shatter Rounds
                { 17, 56474 },	-- Mammoth Cutters
            }
        },
        {
            name = ALIL["Parts"],
            [NORMAL_DIFF] = {
                { 1, 56471 },	-- Froststeel Tube
                { 2, 56464 },	-- Overcharged Capacitor
                { 3, 56349 },	-- Handful of Cobalt Bolts
                { 4, 53281 },	-- Volatile Blasting Trigger
            }
        },
        {
            name = ALIL["Explosives"],
            [NORMAL_DIFF] = {
                { 1, 56514 },	-- Global Thermal Sapper Charge
                { 3, 56463 },	-- Explosive Decoy
                { 4, 56460 },	-- Cobalt Frag Bomb
                { 16, 56468 },	-- Box of Bombs
                { 17, "i44951" }
            }
        },
        {
            name = ALIL["Engineering"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 54999 },	-- Hyperspeed Accelerators
                { 2, 54998 },	-- Hand-Mounted Pyro Rocket
                { 3, 63770 },	-- Reticulated Armor Webbing
                { 5, 55002 },	-- Flexweave Underlay
                { 6, 63765 },	-- Springy Arachnoweave
                { 16, 55016 },	-- Nitro Boosts
                { 17, 54736 },	-- Personal Electromagnetic Pulse Generator
                { 18, 54793 },	-- Frag Belt
                { 19, 67839 },	-- Mind Amplification Dish
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 60867 }, [ATLASLOOT_IT_HORDE] = { 60866 } }, -- Mekgineer's Chopper / Mechano-Hog
                { 3, 56476 },	-- Healing Injector Kit
                { 4, 56477 },	-- Mana Injector Kit
                { 6, 56461 },	-- Bladed Pickaxe
                { 7, 56459 },	-- Hammer Pick
                { 9, 55252 },	-- Scrapbot Construction Kit
                { 11, 56462 },	-- Gnomish Army Knife
                { 13, 67326 },	-- Goblin Beam Welder
                { 16, 68067 },	-- Jeeves
                { 18, 56472 },	-- MOLL-E
                { 20, 67920 },	-- Wormhole Generator: Northrend
                { 22, 30349 },	-- Titanium Toolbox
                { 24, 56473 },	-- Gnomish X-Ray Specs
            }
        },
    }
}

data["TailoringWrath"] = {
    name = ALIL["Tailoring"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.TAILORING_LINK,
    items = {
        {
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 56017 },	-- Deathchill Cloak
                { 2, 56016 },	-- Wispcloak
                { 3, 64730 },	-- Cloak of Crimson Snow
                { 4, 64729 },	-- Frostguard Drape
                { 5, 56015 },	-- Cloak of Frozen Spirits
                { 6, 56014 },	-- Cloak of the Moon
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Head"],
            [NORMAL_DIFF] = {
                { 1, 56018 },	-- Hat of Wintry Doom
                { 2, 59589 },	-- Frostsavage Cowl
                { 3, 55919 },	-- Duskweave Cowl
                { 4, 55907 },	-- Frostwoven Cowl
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [NORMAL_DIFF] = {
                { 1, 59584 },	-- Frostsavage Shoulders
                { 2, 55910 },	-- Mystic Frostwoven Shoulders
                { 3, 55923 },	-- Duskweave Shoulders
                { 4, 55902 },	-- Frostwoven Shoulders
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Chest"],
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67066 }, [ATLASLOOT_IT_HORDE] = { 67146 } },	-- Merlin's Robe
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67064 }, [ATLASLOOT_IT_HORDE] = { 67144 } },	-- Royal Moonshroud Robe
                { 3, 56026 },	-- Ebonweave Robe
                { 4, 56024 },	-- Moonshroud Robe
                { 5, 56028 },	-- Spellweave Robe
                { 6, 60993 },	-- Glacial Robe
                { 7, 59587 },	-- Frostsavage Robe
                { 8, 55941 },	-- Black Duskweave Robe
                { 9, 55911 },	-- Mystic Frostwoven Robe
                { 10, 55921 },	-- Duskweave Robe
                { 11, 55903 },	-- Frostwoven Robe
            },
        },
        {
            name = AL["Armor"].." - "..ALIL["Feet"],
            [NORMAL_DIFF] = {
                { 1, 70551 },	-- Deathfrost Boots
                { 2, 70553 },	-- Sandals of Consecration
                { 3, 63206 },	-- Savior's Slippers
                { 4, 63204 },	-- Spellslinger's Slippers
                { 5, 60994 },	-- Glacial Slippers
                { 6, 56023 },	-- Aurora Slippers
                { 7, 59585 },	-- Frostsavage Boots
                { 8, 56019 },	-- Silky Iceshard Boots
                { 9, 55924 },	-- Duskweave Boots
                { 10, 55906 },	-- Frostwoven Boots
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Hand"],
            [NORMAL_DIFF] = {
                { 1, 56027 },	-- Ebonweave Gloves
                { 2, 56025 },	-- Moonshroud Gloves
                { 3, 56029 },	-- Spellweave Gloves
                { 4, 59586 },	-- Frostsavage Gloves
                { 5, 56022 },	-- Light Blessed Mittens
                { 6, 55922 },	-- Duskweave Gloves
                { 7, 55904 },	-- Frostwoven Gloves
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Legs"],
            [NORMAL_DIFF] = {
                { 1, 70550 },	-- Leggings of Woven Death
                { 2, 70552 },	-- Lightweave Leggings
                { 3, 56021 },	-- Frostmoon Pants
                { 4, 59588 },	-- Frostsavage Leggings
                { 5, 55925 },	-- Black Duskweave Leggings
                { 6, 55901 },	-- Duskweave Leggings
                { 7, 56030 },	-- Frostwoven Leggings
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Waist"],
            [NORMAL_DIFF] = {
                { 1, 63205 },	-- Cord of the White Dawn
                { 2, 63203 },	-- Sash of Ancient Power
                { 3, 60990 },	-- Glacial Waistband
                { 4, 56020 },	-- Deep Frozen Cord
                { 5, 59582 },	-- Frostsavage Belt
                { 6, 55914 },	-- Duskweave Belt
                { 7, 55908 },	-- Frostwoven Belt
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67079 }, [ATLASLOOT_IT_HORDE] = { 67145 } },	-- Bejeweled Wizard's Bracers
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67065 }, [ATLASLOOT_IT_HORDE] = { 67147 } },	-- Royal Moonshroud Bracers
                { 3, 55943 },	-- Black Duskweave Wristwraps
                { 4, 59583 },	-- Frostsavage Bracers
                { 5, 55913 },	-- Mystic Frostwoven Wriststraps
                { 6, 55920 },	-- Duskweave Wriststraps
                { 7, 56031 },	-- Frostwoven Wriststraps
            }
        },
        {
            name = AL["Shirts"],
            [NORMAL_DIFF] = {
                { 1, 55993 },    -- Red Lumberjack Shirt
                { 2, 55994 },    -- Blue Lumberjack Shirt
                { 3, 55995 },    -- Yellow Lumberjack Shirt
                { 4, 55996 },    -- Green Lumberjack Shirt
            }
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 56005 },	-- Glacial Bag
                { 2, 56007 },	-- Frostweave Bag
                { 16, 63924 },	-- Emerald Bag
                { 18, 56004 },	-- Abyssal Bag
                { 20, 56006 },	-- Mysterious Bag
            }
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 56034 },	-- Master's Spellthread
                { 2, 56011 },   -- Sapphire Spellthrea
                { 3, 56010 },	-- Azure Spellthread
                { 5, 55777 },	-- Swordguard Embroidery
                { 6, 55642 },	-- Lightweave Embroidery
                { 7, 55769 },	-- Darkglow Embroidery
                { 16, 56039 },	-- Sanctified Spellthread
                { 17, 56009 },  -- Brilliant Spellthread
                { 18, 56008 },	-- Shining Spellthread
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 75597 },	-- Frosty Flying Carpet
                { 2, 60971 },	-- Magnificent Flying Carpet
                { 3, 60969 },	-- Flying Carpet
                { 5, 56002 },	-- Ebonweave
                { 6, 56001 },	-- Moonshroud
                { 8, 55900 },	-- Bolt of Imbued Frostweave
                { 9, 55899 },	-- Bolt of Frostweave
                { 16, 55898 },	-- Frostweave Net
                { 20, 56003 },	-- Spellweave
            }
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 764 }, -- Duskweaver
                { 2, 763 }, -- Frostwoven Power
            },
        },
    }
}

data["LeatherworkingWrath"] = {
    name = ALIL["Leatherworking"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.LEATHERWORKING_LINK,
    items = {
        { -- Cloak
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 60637 },	-- Ice Striker's Cloak
                { 2, 60640 },	-- Durable Nerubhide Cape
                { 3, 55199 },	-- Cloak of Tormented Skies
                { 4, 60631 },	-- Cloak of Harsh Winds
            }
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [LEATHER_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67086 }, [ATLASLOOT_IT_HORDE] = { 67142 } },	-- Knightbane Carapace
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67084 }, [ATLASLOOT_IT_HORDE] = { 67140 } },	-- Lunar Eclipse Chestguard
                { 3, 60996 },	-- Polar Vest
                { 4, 60703 },	-- Eviscerator's Chestguard
                { 5, 60718 },	-- Overcast Chestguard
                { 6, 60669 },	-- Wildscale Breastplate
                { 7, 51570 },	-- Dark Arctic Chestpiece
                { 8, 60613 },	-- Dark Iceborne Chestguard
                { 9, 50944 },	-- Arctic Chestpiece
                { 10, 50938 },	-- Iceborne Chestguard
            },
            [MAIL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67082 }, [ATLASLOOT_IT_HORDE] = { 67138 } },	-- Crusader's Dragonscale Breastplate
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67080 }, [ATLASLOOT_IT_HORDE] = { 67136 } },	-- Ensorcelled Nerubian Breastplate
                { 3, 60756 },	-- Revenant's Breastplate
                { 4, 60999 },	-- Icy Scale Chestguard
                { 5, 60730 },	-- Swiftarrow Hauberk
                { 6, 60747 },	-- Stormhide Hauberk
                { 7, 60649 },	-- Razorstrike Breastplate
                { 8, 60604 },	-- Dark Frostscale Breastplate
                { 9, 60629 },	-- Dark Nerubian Chestpiece
                { 10, 50950 },	-- Frostscale Chestguard
                { 11, 50956 },	-- Nerubian Chestguard
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [LEATHER_DIFF] = {
                { 1, 70555 },	-- Blessed Cenarion Boots
                { 2, 70557 },	-- Footpads of Impending Death
                { 3, 63201 },	-- Boots of Wintry Endurance
                { 4, 63199 },	-- Footpads of Silence
                { 5, 60761 },	-- Earthgiving Boots
                { 6, 60998 },	-- Polar Boots
                { 7, 62176 },	-- Windripper Boots
                { 8, 60712 },	-- Eviscerator's Treads
                { 9, 60727 },	-- Overcast Boots
                { 10, 60666 },	-- Jormscale Footpads
                { 11, 51568 },	-- Black Chitinguard Boots
                { 12, 60620 },	-- Bugsquashers
                { 13, 50948 },	-- Arctic Boots
                { 14, 50942 },	-- Iceborne Boots
            },
            [MAIL_DIFF] = {
                { 1, 70559 },	-- Earthsoul Boots
                { 2, 70561 },	-- Rock-Steady Treads
                { 3, 63195 },	-- Boots of Living Scale
                { 4, 63197 },	-- Lightning Grounded Boots
                { 5, 60757 },	-- Revenant's Treads
                { 6, 61002 },	-- Icy Scale Boots
                { 7, 60737 },	-- Swiftarrow Boots
                { 8, 60752 },	-- Stormhide Stompers
                { 9, 60605 },	-- Dragonstompers
                { 10, 60630 },	-- Scaled Icewalkers
                { 11, 50954 },	-- Frostscale Boots
                { 12, 50960 },	-- Nerubian Boots
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [LEATHER_DIFF] = {
                { 1, 60705 },	-- Eviscerator's Gauntlets
                { 2, 60721 },	-- Overcast Handwraps
                { 3, 60665 },	-- Seafoam Gauntlets
                { 4, 50947 },	-- Arctic Gloves
                { 5, 50941 },	-- Iceborne Gloves
            },
            [MAIL_DIFF] = {
                { 1, 60732 },	-- Swiftarrow Gauntlets
                { 2, 60749 },	-- Stormhide Grips
                { 3, 50953 },	-- Frostscale Gloves
                { 4, 50959 },	-- Nerubian Gloves
            },
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [LEATHER_DIFF] = {
                { 1, 60697 },	-- Eviscerator's Facemask
                { 2, 60715 },	-- Overcast Headguard
                { 3, 51572 },	-- Arctic Helm
                { 4, 60608 },	-- Iceborne Helm
            },
            [MAIL_DIFF] = {
                { 1, 60728 },	-- Swiftarrow Helm
                { 2, 60743 },	-- Stormhide Crown
                { 3, 60655 },	-- Nightshock Hood
                { 4, 60600 },	-- Frostscale Helm
                { 5, 60624 },	-- Nerubian Helm
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [LEATHER_DIFF] = {
                { 1, 70556 },	-- Bladeborn Leggings
                { 2, 70554 },	-- Legwraps of Unleashed Nature
                { 3, 60760 },	-- Earthgiving Legguards
                { 4, 62177 },	-- Windripper Leggings
                { 5, 60711 },	-- Eviscerator's Legguards
                { 6, 60725 },	-- Overcast Leggings
                { 7, 60660 },	-- Leggings of Visceral Strikes
                { 8, 51569 },	-- Dark Arctic Leggings
                { 9, 60611 },	-- Dark Iceborne Leggings
                { 10, 50945 },	-- Arctic Leggings
                { 11, 50939 },	-- Iceborne Leggings
            },
            [MAIL_DIFF] = {
                { 1, 70560 },	-- Draconic Bonesplinter Legguards
                { 2, 70558 },	-- Lightning-Infused Leggings
                { 3, 60754 },	-- Giantmaim Legguards
                { 4, 60735 },	-- Swiftarrow Leggings
                { 5, 60751 },	-- Stormhide Legguards
                { 6, 60601 },	-- Dark Frostscale Leggings
                { 7, 60627 },	-- Dark Nerubian Leggings
                { 8, 50951 },	-- Frostscale Leggings
                { 9, 50957 },	-- Nerubian Legguards
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [LEATHER_DIFF] = {
                { 1, 60758 },	-- Trollwoven Spaulders
                { 2, 60702 },	-- Eviscerator's Shoulderpads
                { 3, 60716 },	-- Overcast Spaulders
                { 4, 60671 },	-- Purehorn Spaulders
                { 5, 50946 },	-- Arctic Shoulderpads
                { 6, 50940 },	-- Iceborne Shoulderpads
            },
            [MAIL_DIFF] = {
                { 1, 60729 },	-- Swiftarrow Shoulderguards
                { 2, 60746 },	-- Stormhide Shoulders
                { 3, 60651 },	-- Virulent Spaulders
                { 4, 50952 },	-- Frostscale Shoulders
                { 5, 50958 },	-- Nerubian Shoulders
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [LEATHER_DIFF] = {
                { 1, 63200 },	-- Belt of Arctic Life
                { 2, 63198 },	-- Death-warmed Belt
                { 3, 60759 },	-- Trollwoven Girdle
                { 4, 60997 },	-- Polar Cord
                { 5, 60706 },	-- Eviscerator's Waistguard
                { 6, 60723 },	-- Overcast Belt
                { 7, 50949 },	-- Arctic Belt
                { 8, 50943 },	-- Iceborne Belt
            },
            [MAIL_DIFF] = {
                { 1, 63194 },	-- Belt of Dragons
                { 2, 63196 },	-- Blue Belt of Chaos
                { 3, 61000 },	-- Icy Scale Belt
                { 4, 60734 },	-- Swiftarrow Belt
                { 5, 60750 },	-- Stormhide Belt
                { 6, 60658 },	-- Nightshock Girdle
                { 7, 50955 },	-- Frostscale Belt
                { 8, 50961 },	-- Nerubian Belt
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [LEATHER_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67087 }, [ATLASLOOT_IT_HORDE] = { 67139 } },	-- Bracers of Swift Death
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67085 }, [ATLASLOOT_IT_HORDE] = { 67141 } },	-- Moonshadow Armguards
                { 3, 60704 },	-- Eviscerator's Bindings
                { 4, 60720 },	-- Overcast Bracers
                { 5, 51571 },	-- Arctic Wristguards
                { 6, 60607 },	-- Iceborne Wristguards
            },
            [MAIL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = { 67081 }, [ATLASLOOT_IT_HORDE] = { 67137 } },	-- Black Chitin Bracers
                { 2, [ATLASLOOT_IT_ALLIANCE] = { 67083 }, [ATLASLOOT_IT_HORDE] = { 67143 } },	-- Crusader's Dragonscale Bracers
                { 3, 60755 },	-- Giantmaim Bracers
                { 4, 60731 },	-- Swiftarrow Bracers
                { 5, 60748 },	-- Stormhide Wristguards
                { 6, 60652 },	-- Eaglebane Bracers
                { 7, 60599 },	-- Frostscale Bracers
                { 8, 60622 },	-- Nerubian Bracers
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 62448 },	-- Earthen Leg Armor
                { 2, 50965 },	-- Frosthide Leg Armor
                { 3, 50967 },	-- Icescale Leg Armor
                { 5, 50964 },	-- Jormungar Leg Armor
                { 6, 50966 },	-- Nerubian Leg Armor
                { 8, 50963 },	-- Heavy Borean Armor Kit

                { 10, 60584 },	-- Nerubian Leg Reinforcements
                { 11, 60583 },	-- Jormungar Leg Reinforcements

                { 16, 57691 },	-- Fur Lining - Spell Power
                { 17, 57690 },	-- Fur Lining - Stamina
                { 18, 57683 },	-- Fur Lining - Attack Power

                { 20, 57701 },	-- Fur Lining - Arcane Resist
                { 21, 57692 },	-- Fur Lining - Fire Resist
                { 22, 57694 },	-- Fur Lining - Frost Resist
                { 23, 57699 },	-- Fur Lining - Nature Resist
                { 24, 57696 },	-- Fur Lining - Shadow Resist

            },
        },
        {
            name = AL["Drums"],
            [NORMAL_DIFF] = {
                { 1, 69386 },	-- Drums of Forgotten Kings
                { 2, 69388 },	-- Drums of the Wild
            },
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 50971 },	-- Mammoth Mining Bag
                { 2, 60643 },	-- Pack of Endless Pockets
                { 3, 50970 },	-- Trapper's Traveling Pack
                { 5, 60647 },	-- Nerubian Reinforced Quiver
                { 6, 60645 },	-- Dragonscale Ammo Pouch
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 50936 },	-- Heavy Borean Leather
                { 2, 64661 },	-- Borean Leather
            },
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 754 }, -- Iceborne Embrace
                { 2, 757 }, -- Borean Embrace
                { 16, 756 }, -- Nerubian Hive
                { 17, 755 }, -- Frostscale Binding
            },
        },
    }
}

data["JewelcraftingWrath"] = {
    name = ALIL["Jewelcrafting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.JEWELCRAFTING_LINK,
    items = {
        {
            name = ALIL["Jewelcrafting"].." - "..ALIL["Gems"],
            [NORMAL_DIFF] = {
                -- red
                { 1, 56049 },	-- Bold Dragon's Eye
                { 2, 56052 },	-- Delicate Dragon's Eye
                { 3, 56053 },	-- Runed  Dragon's Eye
                { 4, 56054 },	-- Bright Dragon's Eye
                { 5, 56074 },	-- Brilliant Dragon's Eye
                { 6, 56056 },	-- Flashing Dragon's Eye
                { 7, 56081 },	-- Precise Dragon's Eye
                -- blue
                { 9, 56077 },	-- Lustrous Dragon's Eye
                { 10, 56086 },	-- Solid Dragon's Eye
                { 11, 56087 },	-- Sparkling Dragon's Eye
                { 12, 56088 },	-- Stormy Dragon's Eye
                { 13, 56084 },	-- Rigid Dragon's Eye
                -- yellow
                { 16, 56085 },	-- Smooth Dragon's Eye
                { 17, 56079 },	-- Mystic Dragon's Eye
                { 18, 56083 },	-- Quick Dragon's Eye
                { 19, 56089 },	-- Thick Dragon's Eye
                { 20, 56055 },	-- Subtle Dragon's Eye
                { 21, 56076 },	-- Smooth Dragon's Eye
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Neck"],
            [NORMAL_DIFF] = {
                { 1, 56500 },	-- Titanium Earthguard Chain
                { 2, 56499 },	-- Titanium Impact Choker
                { 3, 56501 },	-- Titanium Spellshock Necklace
                { 5, 64725 },	-- Emerald Choker
                { 6, 64726 },	-- Sky Sapphire Amulet
                { 7, 56196 },	-- Blood Sun Necklace
                { 8, 56195 },	-- Jade Dagger Pendant
                { 10, 58142 },	-- Crystal Chalcedony Amulet
                { 11, 58141 },	-- Crystal Citrine Necklace
            }
        },
        {
            name = AL["Armor"].." - "..AL["Ring"],
            [NORMAL_DIFF] = {
                { 1, 56497 },	-- Titanium Earthguard Ring
                { 2, 56496 },	-- Titanium Impact Band
                { 3, 56498 },	-- Titanium Spellshock Ring
                { 4, 58954 },	-- Titanium Frostguard Ring
                { 6, 56193 },	-- Bloodstone Band
                { 7, 56194 },	-- Sun Rock Ring
                { 8, 58146 },	-- Shadowmight Ring
                { 9, 58145 },	-- Stoneguard Band
                { 16, 56197 },	-- Dream Signet
                { 17, 58147 },	-- Ring of Earthen Might
                { 18, 58150 },	-- Ring of Northern Tears
                { 19, 58148 },	-- Ring of Scarlet Shadows
                { 20, 64727 },	-- Runed Mana Band
                { 21, 58507 },	-- Savage Titanium Band
                { 22, 58492 },	-- Savage Titanium Ring
                { 23, 64728 },	-- Scarlet Signet
                { 24, 58149 },	-- Windfire Band
                { 25, 58143 },	-- Earthshadow Ring
                { 26, 58144 },	-- Jade Ring of Slaying
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 56203 },	-- Figurine - Emerald Boar
                { 2, 59759 },	-- Figurine - Monarch Crab
                { 3, 56199 },	-- Figurine - Ruby Hare
                { 4, 56202 },	-- Figurine - Sapphire Owl
                { 5, 56201 },	-- Figurine - Twilight Serpent
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Meta"]),
            [NORMAL_DIFF] = {
                { 1, 55401 },	-- Austere Earthsiege Diamond
                { 2, 55405 },	-- Beaming Earthsiege Diamond
                { 3, 55397 },	-- Bracing Earthsiege Diamond
                { 4, 55398 },	-- Eternal Earthsiege Diamond
                { 5, 55396 },	-- Insightful Earthsiege Diamond
                { 6, 55404 },	-- Invigorating Earthsiege Diamond
                { 7, 55402 },	-- Persistant Earthsiege Diamond
                { 8, 55399 },	-- Powerful Earthsiege Diamond
                { 9, 55400 },	-- Relentless Earthsiege Diamond
                { 10, 55403 },	-- Trenchant Earthsiege Diamond
                { 16, 55389 },	-- Chaotic Skyflare Diamond
                { 17, 55390 },	-- Destructive Skyflare Diamond
                { 18, 55384 },  -- Effulgent Skyflare Diamond
                { 19, 55392 },	-- Ember Skyflare Diamond
                { 20, 55393 },	-- Enigmatic Skyflare Diamond
                { 21, 55387 },	-- Forlorn Skyflare Diamond
                { 22, 55388 },	-- Impassive Skyflare Diamond
                { 23, 55407 },	-- Revitalizing Skyflare Diamond
                { 24, 55394 },	-- Swift Skyflare Diamond
                { 25, 55395 },	-- Thundering Skyflare Diamond
                { 26, 55386 },	-- Tireless Skyflare Diamond
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Red"]),
            [NORMAL_DIFF] = {
                { 1, 66447 },	-- Bold Cardinal Ruby
                { 2, 66446 },	-- Brilliant Cardinal Ruby
                { 3, 66448 },	-- Delicate Cardinal Ruby
                { 4, 66453 },	-- Flashing Cardinal Ruby
                { 5, 66450 },	-- Precise Cardinal Ruby
                -- blue
                { 7, 53830 },	-- Bold Scarlet Ruby
                { 8, 53946 },	-- Brilliant Scarlet Ruby
                { 9, 53945 },	-- Delicate Scarlet Ruby
                { 10, 53949 },	-- Flashing Scarlet Ruby
                { 11, 53951 },	-- Precise Scarlet Ruby
                -- green
                { 16, 53831 },	-- Bold Bloodstone
                { 17, 53834 },	-- Brilliant Bloodstone
                { 18, 53832 },	-- Delicate Bloodstone
                { 19, 53844 },	-- Flashing Bloodstone
                { 20, 54017 },	-- Precise Bloodstone
                -- perfect
                { 22, "i41432" }, -- Perfect Bold Bloodstone
                { 23, "i41438" }, -- Perfect Brilliant Bloodstone
                { 24, "i41434" }, -- Perfect Delicate Bloodstone
                { 25, "i41435" }, -- Perfect Flashing Bloodstone
                { 26, "i41437" }, -- Perfect Precise Bloodstone
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Yellow"]),
            [NORMAL_DIFF] = {
                { 1, 66452 },   -- Subtle King's Amber
                { 2, 66505 },	-- Mystic King's Amber
                { 3, 66506 },	-- Quick King's Amber
                { 4, 66502 },	-- Smooth King's Amber
                -- blue
                { 6, 53948 },  -- Subtle Autumn's Glow
                { 7, 53960 },	-- Mystic Autumn's Glow
                { 8, 53961 },	-- Quick Autumn's Glow
                { 9, 53950 },  -- Smooth Autumn's Glow
                -- green
                { 16, 53843 }, -- Subtle Sun Crystal
                { 17, 53857 },	-- Mystic Sun Crystal
                { 18, 53856 },	-- Quick Sun Crystal
                { 19, 53845 }, -- Smooth Sun Crystal
                -- perfect
                { 21, "i41439" }, -- Perfect Subtle Sun Crystal
                { 22, "i41445" },	-- Perfect Mystic Sun Crystal
                { 23, "i41446" },	-- Perfect Quick Sun Crystal
                { 24, "i41436" }, -- Perfect Smooth Sun Crystal
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Blue"]),
            [NORMAL_DIFF] = {
                { 1, 66498 },	-- Sparkling Majestic Zircon
                { 2, 66497 },	-- Solid Majestic Zircon
                { 3, 66499 },	-- Stormy Majestic Zircon
                { 4, 66501 },	-- Rigid Majestic Zircon
                -- blue
                { 6, 53954 },	-- Sparkling Sky Sapphire
                { 7, 53952 },	-- Solid Sky Sapphire
                { 8, 53955 },	-- Stormy Sky Sapphire
                { 9, 53958 },	-- Rigid Sky Sapphire
                -- green
                { 16, 53940 },	-- Sparkling Chalcedony
                { 17, 53934 },	-- Solid Chalcedony
                { 18, 53943 },	-- Stormy Chalcedony
                { 19, 53854 },	-- Rigid Chalcedony
                -- perfect
                { 21, "i41442" },	-- Perfect Sparkling Chalcedony
                { 22, "i41441" },	-- Perfect Solid Chalcedony
                { 23, "i41443" },	-- Perfect Stormy Chalcedony
                { 24, "i41447" },	-- Perfect Rigid Chalcedony
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Orange"]),
            [NORMAL_DIFF] = {
                { 1, 66579 },	-- Champion's Ametrine
                { 2, 66568 },	-- Deadly Ametrine
                { 3, 66584 },	-- Deft Ametrine
                { 4, 66571 },	-- Willful Ametrine
                { 5, 66580 },	-- Lucent Ametrine
                { 6, 66583 },	-- Fierce Ametrine
                { 7, 66581 },   -- Stalwart Ametrine
                { 8, 66567 },	-- Inscribed Ametrine
                { 9, 66569 },	-- Potent Ametrine
                { 10, 66574 },	-- Reckless Ametrine
                { 11, 66586 },	-- Resolute Ametrine
                { 12, 66582 },	-- Resplendent Ametrine
                -- blue
                { 16, 53977 },	-- Champion's Monarch Topaz
                { 17, 53979 },	-- Deadly Monarch Topaz
                { 18, 53991 },	-- Deft Monarch Topaz
                { 19, 53986 },	-- Willfur Monarch Topaz
                { 20, 53990 },	-- Lucent Monarch Topaz
                { 21, 54019 },	-- Fierce Monarch Topaz
                { 22, 53993 }, -- Stalwart Monarch Topaz
                { 23, 53975 },	-- Inscribed Monarch Topaz
                { 24, 53983 }, -- Reckless Monarch Topaz
                { 25, 53984 },	-- Potent Monarch Topaz
                { 26, 54023 },	-- Resolute Monarch Topaz
                { 27, 53978 },	-- Resplendent Monarch Topaz
                -- green
                { 101, 53874 },	-- Champion's Huge Citrine
                { 102, 53877 },	-- Deadly Huge Citrine
                { 103, 53880 },	-- Deft Huge Citrine
                { 104, 53884 }, -- Willful Huge Citrine
                { 105, 53888 }, -- Lucent Huge Citrine
                { 106, 53876 },	-- Fierce Huge Citrine
                { 107, 53891 }, -- Stalwart Huge Citrine
                { 108, 53872 },	-- Inscribed Huge Citrine
                { 109, 53885 }, -- Reckless Huge Citrine
                { 110, 53882 },	-- Potent Huge Citrine
                { 111, 53893 },	-- Resolute Huge Citrine
                { 112, 53875 },	-- Resplendent Huge Citrine
                -- perfect
                { 116, "i41483" }, -- Perfect Champion's Huge Citrine
                { 117, "i41484" }, -- Perfect Deadly Huge Citrine
                { 118, "i41485" }, -- Perfect Deft Huge Citrine
                { 119, "i41486" }, -- Perfect Willful Huge Citrine
                { 120, "i41487" }, -- Perfect Lucent Huge Citrine
                { 121, "i41489" }, -- Perfect Fierce Huge Citrine
                { 122, "i41490" }, -- Perfect Stalwart Huge Citrine
                { 123, "i41492" }, -- Perfect Inscribed Huge Citrine
                { 124, "i41497" }, -- Perfect Reckless Huge Citrine
                { 125, "i41495" }, -- Perfect Potent Huge Citrine
                { 126, "i41498" }, -- Perfect Resolute Huge Citrine
                { 127, "i41499" }, -- Perfect Resplendent Huge Citrine
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Green"]),
            [NORMAL_DIFF] = {
                { 1, 66338 },   -- Regal Eye of Zul
                { 2, 66442 },	-- Energized Eye of Zul
                { 3, 66434 },	-- Forceful Eye of Zul
                { 4, 66431 },	-- Jagged Eye of Zul
                { 5, 66439 },   -- Lightning Eye of Zul
                { 6, 66435 },	-- Misty Eye of Zul
                { 7, 66441 },	-- Radiant Eye of Zul
                { 8, 66443 },	-- Shattered Eye of Zul
                { 9, 66428 },	-- Steady Eye of Zul
                { 10, 66445 },	-- Turbid Eye of Zul
                { 11, 66429 },  -- Nimble Eye of Zul
                -- blue
                { 16, 53998 }, -- Regal Forest Emerald
                { 17, 54011 },	-- Energized Forest Emerald
                { 18, 54001 },	-- Forceful Forest Emerald
                { 19, 53996 },	-- Jagged Forest Emerald
                { 20, 54009 }, -- Lightning Forest Emerald
                { 21, 54003 },	-- Misty Forest Emerald
                { 22, 54012 },	-- Radiant Forest Emerald
                { 23, 54014 },	-- Shattered Forest Emerald
                { 24, 54000 },	-- Steady Forest Emerald
                { 25, 54005 },	-- Turbid Forest Emerald
                { 26, 53997 }, -- Nimble Forest Emerald
                -- green
                { 101, 53918 }, -- Regal Dark Jade
                { 102, 53930 },	-- Energized Dark Jade
                { 103, 53920 }, -- Forceful Dark Jade
                { 104, 53916 },	-- Jagged Dark Jade
                { 105, 53928 }, -- Lightning Dark Jade
                { 106, 53922 },	-- Misty Dark Jade
                { 107, 53932 },	-- Radiant Dark Jade
                { 108, 53933 },	-- Shattered Dark Jade
                { 109, 53919 }, -- Steady Dark Jade
                { 110, 53924 },	-- Turbid Dark Jade
                { 111, 53917 }, -- Nimble Dark Jade
                -- perfect
                { 116, "i41464" }, -- Perfect Regal Dark Jade
                { 117, "i41465" }, -- Perfect Energized Dark Jade
                { 118, "i41466" }, -- Perfect Forceful Dark Jade
                { 119, "i41468" }, -- Perfect Jagged Dark Jade
                { 120, "i41469" }, -- Perfect Lightning Dark Jade
                { 121, "i41470" }, -- Perfect Misty Dark Jade
                { 122, "i41471" }, -- Perfect Turbid Dark Jade
                { 123, "i41472" }, -- Perfect Radiant Dark Jade
                { 124, "i41474" }, -- Perfect Shattered Dark Jade
                { 125, "i41476" }, -- Perfect Steady Dark Jade
                { 126, "i41481" }, -- Perfect Nimble Dark Jade
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Purple"]),
            [NORMAL_DIFF] = {
                { 1, 66560 },	-- Defender's Dreadstone
                { 2, 66432 },  -- Timeless Dreadstone
                { 3, 66561 },	-- Guardian's Dreadstone
                { 4, 66562 },	-- Mysterious Dreadstone
                { 5, 66556 },	-- Purified Dreadstone
                { 6, 66557 },	-- Shifting Dreadstone
                { 7, 66554 },	-- Sovereign Dreadstone
                { 8, 66576 },   -- Accurate Dreadstone
                { 9, 66572 },	-- Etched Dreadstone
                { 10, 66573 },	-- Glinting Dreadstone
                { 11, 66570 },  -- Veiled Dreadstone
                -- blue
                { 16, 53972 },	-- Defender's Twilight Opal
                { 17, 53965 }, -- Timeless Forest Emerald
                { 18, 53974 },	-- Guardian's Twilight Opal
                { 19, 53968 },	-- Mysterious Twilight Opal
                { 20, 53966 },	-- Purified Twilight Opal
                { 21, 53963 },	-- Shifting Twilight Opal
                { 22, 53962 },	-- Sovereign Twilight Opal
                { 23, 53994 }, -- Accurate Twilight Opal
                { 24, 53976 }, --  Etched Twilight Opal
                { 25, 53980 }, -- Glinting Twilight Opal
                { 26, 53985 },	-- Veiled Twilight Opal
                -- green
                { 101, 53869 },	-- Defender's Shadow Crystal
                { 102, 53894 },	-- Timeless Shadow Crystal
                { 103, 53871 },	-- Guardian's Shadow Crystal
                { 104, 53865 },	-- Mysterious Shadow Crystal
                { 105, 53921 },	-- Purified Shadow Crystal
                { 106, 53866 },	-- Shifting Shadow Crystal
                { 107, 53859 },	-- Sovereign Shadow Crystal
                { 108, 53892 }, -- Accurate Shadow Crystal
                { 109, 53873 }, -- Etched Shadow Crystal
                { 110, 53861 },	-- Glinting Shadow Crystal
                { 111, 53883 },	-- Veiled Shadow Crystal
                -- perfect
                { 116, "i41451" },	-- Perfect Defender's Shadow Crystal
                { 117, "i41479" }, -- Perfect Timeless Shadow Crystal
                { 118, "i41453" },	-- Perfect Guardian's Shadow Crystal
                { 119, "i41455" },	-- Perfect Mysterious Shadow Crystal
                { 120, "i41457" },	-- Perfect Purified Shadow Crystal
                { 121, "i41450" },	-- Perfect Shifting Shadow Crystal
                { 122, "i41461" },	-- Perfect Sovereign Shadow Crystal
                { 123, "i41482" }, -- Perfect Accurate Shadow Crystal
                { 124, "i41488" }, -- Perfect Etched Shadow Crystal
                { 125, "i41491" }, -- Perfect Glinting Shadow Crystal
                { 126, "i41502" }, -- Perfect Veiled Shadow Crystal
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Prismatic"]),
            [NORMAL_DIFF] = {
                { 1, 68253 }, -- Nightmare Tear
                { 2, 56531 }, -- Enchanted Tear
                { 3, 56530 }, -- Enchanted Pearl
            }
        },
        {
            name = AL["Raw Gems"],
            TableType = NORMAL_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 41334 }, --  Earthsiege Diamond
                { 2, 41266 }, --  Skyflare Diamond
                { 3, 36783 }, --  Northsea Pearl
                { 5, 36928 }, --  Dreadstone
                { 6, 36927 }, --  Twilight Opal
                { 7, 36926 }, --  Shadow Crystal
                { 9, 36934 }, --  Eye of Zul
                { 10, 36933 }, --  Forest Emerald
                { 11, 36932 }, --  Dark Jade
                { 13, 36931 }, --  Ametrine
                { 14, 36930 }, --  Monarch Topaz
                { 15, 36929 }, --  Huge Citrine
                { 16, "i42225" }, --  Dragon's Eye
                { 17, 36784 }, --  Siren's Tear
                { 20, 36925 }, --  Majestic Zircon
                { 21, 36924 }, -- Sky Sapphire
                { 22, 36923 }, --  Chalcedony
                { 24, 36919 }, --  Cardinal Ruby
                { 25, 36918 }, --  Scarlet Ruby
                { 26, 36917 }, --  Bloodstone
                { 28, 36922 }, --  King's Amber
                { 29, 36921 }, --  Autumn's Glow
                { 30, 36920 }, --  Sun Crystal
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 62242 },	-- Icy Prism
                { 3, "i43297" },	-- Damaged Necklace
                { 16, 56208 },	-- Shadow Jade Focusing Lens
                { 17, 56206 },	-- Shadow Crystal Focusing Lens
                { 18, 56205 },	-- Dark Jade Focusing Lens
            }
        },
    }
}

data["InscriptionWrath"] = {
    name = ALIL["Inscription"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.INSCRIPTION_LINK,
    items = {
        {
            name = AL["Scrolls"],
            [NORMAL_DIFF] = {
                { 1, 69385 },	-- Runescroll of Fortitude
                { 3, 60337 },	-- Scroll of Recall III
                { 4, 60336 },	-- Scroll of Recall II
                { 5, 48248 },	-- Scroll of Recall

                { 16, 58483 },	-- Scroll of Agility VIII
                { 17, 58482 },	-- Scroll of Agility VII
                { 18, 58481 },	-- Scroll of Agility VI
                { 19, 58480 },	-- Scroll of Agility V
                { 20, 58478 },	-- Scroll of Agility IV
                { 21, 58476 },	-- Scroll of Agility III
                { 22, 58473 },	-- Scroll of Agility II
                { 23, 58472 },	-- Scroll of Agility

                { 101, 50604 },	-- Scroll of Intellect VIII
                { 102, 50603 },	-- Scroll of Intellect VII
                { 103, 50602 },	-- Scroll of Intellect VI
                { 104, 50601 },	-- Scroll of Intellect V
                { 105, 50600 },	-- Scroll of Intellect IV
                { 106, 50599 },	-- Scroll of Intellect III
                { 107, 50598 },	-- Scroll of Intellect II
                { 108, 48114 },	-- Scroll of Intellect

                { 116, 50611 },	-- Scroll of Spirit VIII
                { 117, 50610 },	-- Scroll of Spirit VII
                { 118, 50609 },	-- Scroll of Spirit VI
                { 119, 50608 },	-- Scroll of Spirit V
                { 120, 50607 },	-- Scroll of Spirit IV
                { 121, 50606 },	-- Scroll of Spirit III
                { 122, 50605 },	-- Scroll of Spirit II
                { 123, 48116 },	-- Scroll of Spirit

                { 201, 50620 },	-- Scroll of Stamina VIII
                { 202, 50619 },	-- Scroll of Stamina VII
                { 203, 50618 },	-- Scroll of Stamina VI
                { 204, 50617 },	-- Scroll of Stamina V
                { 205, 50616 },	-- Scroll of Stamina IV
                { 206, 50614 },	-- Scroll of Stamina III
                { 207, 50612 },	-- Scroll of Stamina II
                { 208, 45382 },	-- Scroll of Stamina

                { 216, 58491 },	-- Scroll of Strength VIII
                { 217, 58490 },	-- Scroll of Strength VII
                { 218, 58489 },	-- Scroll of Strength VI
                { 219, 58488 },	-- Scroll of Strength V
                { 220, 58487 },	-- Scroll of Strength IV
                { 221, 58486 },	-- Scroll of Strength III
                { 222, 58485 },	-- Scroll of Strength II
                { 223, 58484 },	-- Scroll of Strength
            }
        },
        {
            name = ALIL["Off Hand"],
            [NORMAL_DIFF] = {
                { 1, 59498 },	-- Faces of Doom
                { 2, 59497 },	-- Iron-bound Tome
                { 3, 64051 },	-- Rituals of the New Moon
                { 4, 64053 },	-- Twilight Tome
                { 5, 59496 },	-- Book of Clever Tricks
                { 6, 59495 },	-- Hellfire Tome
                { 7, 59494 },	-- Manual of Clouds
                { 8, 59493 },	-- Stormbound Tome
                { 9, 59490 },	-- Book of Stars
                { 10, 59489 },	-- Fire Eater's Guide
                { 11, 59486 },	-- Royal Guide of Escape Routes
                { 12, 59484 },	-- Tome of Kings
                { 13, 59478 },	-- Book of Survival
                { 14, 59475 },	-- Tome of the Dawn
                { 15, 58565 },	-- Mystic Tome
            }
        },
        {
            name = AL["Cards"],
            [NORMAL_DIFF] = {
                { 1, 59504 },	-- Darkmoon Card of the North
                { 2, 59503 },	-- Greater Darkmoon Card
                { 3, 59502 },	-- Darkmoon Card
                { 16, 59491 },	-- Shadowy Tarot
                { 17, 59487 },	-- Arcane Tarot
                { 18, 48247 },	-- Mysterious Tarot
                { 19, 59480 },	-- Strange Tarot
            }
        },
        {
            name = AL["Ink"],
            [NORMAL_DIFF] = {
                { 1, 57716 },	-- Snowfall Ink
                { 2, 57715 },	-- Ink of the Sea
                { 3, 57714 },	-- Darkflame Ink
                { 4, 57713 },	-- Ethereal Ink
                { 5, 57712 },	-- Ink of the Sky
                { 6, 57711 },	-- Shimmering Ink
                { 7, 57710 },	-- Fiery Ink
                { 8, 57709 },	-- Celestial Ink
                { 9, 57708 },	-- Royal Ink
                { 10, 57707 },	-- Jadefire Ink
                { 11, 57706 },	-- Dawnstar Ink
                { 12, 57704 },	-- Lion's Ink
                { 13, 57703 },	-- Hunter's Ink
                { 14, 53462 },	-- Midnight Ink
                { 15, 52843 },	-- Moonglow Ink
            }
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 61117 },	-- Master's Inscription of the Axe
                { 2, 61119 },	-- Master's Inscription of the Pinnacle
                { 16, 61120 },	-- Master's Inscription of the Storm
                { 17, 61118 },	-- Master's Inscription of the Crag
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 59387 },	-- Certificate of Ownership
                { 3, 52739 },	-- Enchanting Vellum
            }
        },
    }
}

data["MiningWrath"] = {
    name = ALIL["Mining"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.MINING_LINK,
    items = {
        {
            name = AL["Smelting"],
            [NORMAL_DIFF] = {
                { 1, 49258 }, -- Smelt Saronite
                { 3, 49252 }, -- Smelt Cobalt
                { 16, 55211 }, -- Smelt Titanium
                { 18, 55208 }, -- Smelt Titansteel
            }
        },
    }
}

data["SkinningWrath"] = {
    name = ALIL["Skinning"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.SKINNING_LINK,
    items = {
        {
            name = AL["Grand Master"],
            [NORMAL_DIFF] = {
                { 1, 33568 }, -- Borean Leather
                { 2, 33567 }, -- Borean Leather Scraps
                { 16, 38558 }, -- Nerubian Chitin
                { 17, 38557 }, -- Icy Dragonscale
                { 19, 44128 }, -- Arctic Fur
            }
        },
    }
}

data["HerbalismWrath"] = {
    name = ALIL["Herbalism"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.HERBALISM_LINK,
    items = {
        {
            name = AL["Grand Master"],
            [NORMAL_DIFF] = {
                { 1, 36906 }, -- Icethorn
                { 2, 36905 }, -- Lichbloom
                { 3, 36903 }, -- Adder's Tongue
                { 4, 36907 }, -- Talandra's Rose
                { 5, 36904 }, -- Tiger Lily
                { 6, 39970 }, -- Fire Leaf
                { 7, 36901 }, -- Goldclover
                { 16, 36908 }, -- Frost Lotus
                { 17, 37921 }, -- Deadnettle
                { 19, 37704 }, -- Crystallized Life
            }
        },
    }
}

data["CookingWrath"] = {
    name = ALIL["Cooking"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.COOKING_LINK,
    items = {
        {
            name = ALIL["Agility"],
            [NORMAL_DIFF] = {
                { 1, 57441 },	-- Blackened Dragonfin
            },
        },
        {
            name = ALIL["Strength"],
            [NORMAL_DIFF] = {
                { 1, 57442 },	-- Dragonfin Filet
            },
        },
        {
            name = ALIL["Hit"],
            [NORMAL_DIFF] = {
                { 1, 57437 },	-- Snapper Extreme
                { 2, 62350 },	-- Worg Tartare
            },
        },
        {
            name = ALIL["Haste"],
            [NORMAL_DIFF] = {
                { 1, 45570 },	-- Imperial Manta Steak
                { 2, 45558 },	-- Very Burnt Worg
                { 3, 45569 },	-- Baked Manta Ray
                { 4, 45552 },	-- Roasted Worg
            },
        },
        {
            name = ALIL["Critical Strike"],
            [NORMAL_DIFF] = {
                { 1, 45557 },	-- Spiced Worm Burger
                { 2, 45571 },	-- Spicy Blue Nettlefish
                { 3, 45565 },	-- Poached Nettlefish
                { 4, 45551 },	-- Worm Delight
            },
        },
        {
            name = ALIL["Spirit"],
            [NORMAL_DIFF] = {
                { 1, 57439 },	-- Cuttlesteak
            },
        },
        {
            name = ALIL["Attack Power"],
            [NORMAL_DIFF] = {
                { 1, 45555 },	-- Mega Mammoth Meal
                { 2, 45567 },	-- Poached Northern Sculpin
                { 3, 45563 },	-- Grilled Sculpin
                { 4, 45549 },	-- Mammoth Meal
            },
        },
        {
            name = ALIL["Spell Power"],
            [NORMAL_DIFF] = {
                { 1, 45550 },	-- Shoveltusk Steak
                { 2, 45564 },	-- Smoked Salmon
                { 16, 45556 },	-- Tender Shoveltusk Steak
                { 17, 45568 },	-- Firecracker Salmon
            },
        },

        {
            name = ALIL["Attack Power"].." + "..ALIL["Spell Power"],
            [NORMAL_DIFF] = {
                { 1, 58065 },	-- Dalaran Clam Chowder
            },
        },
        {
            name = ALIL["Armor Penetration Rating"],
            [NORMAL_DIFF] = {
                { 1, 57436 },	-- Hearty Rhino
            },
        },
        {
            name = ALIL["Expertise"],
            [NORMAL_DIFF] = {
                { 1, 57434 },	-- Rhinolicious Wormsteak
            },
        },
        {
            name = ALIL["Mana Per 5 Sec."],
            [NORMAL_DIFF] = {
                { 1, 45559 },	-- Mighty Rhino Dogs
                { 2, 57433 },	-- Spicy Fried Herring
                { 3, 45566 },	-- Pickled Fangtooth
                { 4, 45553 },	-- Rhino Dogs
            },
        },
        {
            name = AL["Feast"],
            [NORMAL_DIFF] = {
                { 1, 45554 },	-- Great Feast
                { 3, 58528 },   -- Small Feast
                { 16, 57423 },	-- Fish Feast
                { 18, 58527 },  -- Gigantic Feast
            },
        },
        {
            name = ALIL["Food"],
            [NORMAL_DIFF] = {
                { 1, 57421 },	-- Northern Stew
                { 3, 64358 },	-- Black Jelly
                { 4, 45561 },	-- Grilled Bonescale
                { 5, 45562 },	-- Sauteed Goby
                { 6, 45560 },	-- Smoked Rockfin
                { 8, 53056 },	-- Kungaloosh
            },
        },
        {
            name = AL["Pet"],
            [NORMAL_DIFF] = {
                { 1, 57440 },	-- Spiced Mammoth Treats
            },
        },
        {
            name = AL["Special"],
            [NORMAL_DIFF] = {
                { 1, 57438 },	-- Blackened Worg Steak
                { 2, 57443 },	-- Tracker Snacks
                { 4, 58523 },   -- Bad Clams
                { 5, 58521 },   -- Last Week's Mammoth
                { 16, 57435 },	-- Critter Bites
                { 19, 58525 },  -- Haunted Herring
                { 20, 58512 },  -- Tasty Cupcake
            },
        },
    }
}

data["FirstAidWrath"] = {
    name = ALIL["First Aid"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.FIRSTAID_LINK,
    items = {
        {
            name = ALIL["First Aid"],
            [NORMAL_DIFF] = {
                { 1, 45546 },	-- Heavy Frostweave Bandage
                { 2, 45545 },	-- Frostweave Bandage
            }
        },
    }
}

data["FishingWrath"] = {
    name = ALIL["Fishing"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.FISHING_LINK,
    items = {
        {
            name = ALIL["Fishing"],
            [NORMAL_DIFF] = {
                { 1, 6533 }, --  Aquadynamic Fish Attractor
                { 2, 34861 }, -- Sharpened Fish Hook
                { 3, 46006 }, -- Glow Worm
                { 4, 6532 }, --  Bright Baubles
                { 5, 7307 }, --  Flesh Eating Worm
                { 6, 6811 }, --  Aquadynamic Fish Lens
                { 7, 6530 }, --  Nightcrawlers
                { 16, 34109 }, -- Weather-Beaten Journal
                { 18, 19971 }, -- High Test Eternium Fishing Line
                { 19, 34836 }, -- Spun Truesilver Fishing Line
                { 27, 27532 }, -- Master Fishing - The Art of Angling
                { 28, 16082 }, -- Artisan Fishing - The Way of the Lure
                { 29, 16083 }, -- Expert Fishing - The Bass and You
                { 30, 46054 }, -- Journeyman Fishing - Fishing for Dummies
            }
        },
        {
            name = ALIL["Fishing Pole"],
            [NORMAL_DIFF] = {
                { 1, 19970 }, -- Arcanite Fishing Pole
                { 2, 44050 }, -- Mastercraft Kalu'ak Fishing Pole
                { 3, 45992 }, -- Jeweled Fishing Pole
                { 4, 45991 }, -- Bone Fishing Pole
                { 5, 45858 }, -- Nat's Lucky Fishing Pole
                { 6, 19022 }, -- Nat Pagle's Extreme Angler FC-5000
                { 7, 25978 }, -- Seth's Graphite Fishing Pole
                { 8, 6367 }, -- Big Iron Fishing Pole
                { 9, 6366 }, -- Darkwood Fishing Pole
                { 10, 6365 }, -- Strong Fishing Pole
                { 11, 12225 }, -- Blump Family Fishing Pole
                { 12, 6256 }, -- Fishing Pole
                { 13, 45120 }, -- Basic Fishing Pole
            }
        },
        {
            name = AL["Fishes"],
            [NORMAL_DIFF] = {
                { 1, 43572 }, -- Magic Eater
                { 2, 43571 }, -- Sewer Carp
                { 3, 43647 }, -- Shimmering Minnow
                { 4, 43652 }, -- Slippery Eel
                { 5, 43646 }, -- Fountain Goldfish
                { 6, 41812 }, -- Barrelhead Goby
                { 7, 41808 }, -- Bonescale Snapper
                { 8, 41805 }, -- Borean Man O' War
                { 9, 41807 }, -- Dragonfin Angelfish
                { 10, 41810 }, -- Fangtooth Herring
                { 11, 41809 }, -- Glacial Salmon
                { 12, 41802 }, -- Imperial Manta Ray
                { 13, 41806 }, -- Musselback Sculpin
                { 14, 41813 }, -- Nettlefish
                { 15, 41803 }, -- Rockfin Grouper
                { 16, 45907 }, -- Mostly-eaten Bonescale Snapper :D
            }
        },
    }
}
