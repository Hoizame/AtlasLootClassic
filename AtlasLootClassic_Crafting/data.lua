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

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1)
local RAID20_DIFF = data:AddDifficulty(AL["20 Raid"], "r20", 9)
local RAID40_DIFF = data:AddDifficulty(AL["40 Raid"], "r40", 9)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

data["Alchemy"] = {
	name = ALIL["Alchemy"],
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 17635 }, --Flask of the Titans
				{ 2, 17636 }, --Flask of Distilled Wisdom
				{ 3, 17637 }, --Flask of Supreme Power
				{ 4, 17638 }, --Flask of Chromatic Resistance
				{ 16, 17634 }, --Flask of Petrification
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 17560 }, --Transmute: Fire to Earth
				{ 2, 17565 }, --Transmute: Life to Earth
				{ 4, 17561 }, --Transmute: Earth to Water
				{ 5, 17563 }, --Transmute: Undeath to Water
				{ 7, 17562 }, --Transmute: Water to Air
				{ 9, 17564 }, --Transmute: Water to Undeath
				{ 11, 17566 }, --Transmute: Earth to Life
				{ 13, 17559 }, --Transmute: Air to Fire
				{ 16, 17187 }, --Transmute: Arcanite
				{ 17, 11479 }, --Transmute: Iron to Gold
				{ 18, 11480 }, --Transmute: Mithril to Truesilver
				{ 20, 25146 }, --Transmute: Elemental Fire
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17556 }, --Major Healing Potion
				{ 2, 11457 }, --Superior Healing Potion
				{ 3, 7181 }, --Greater Healing Potion
				{ 4, 3447 }, --Healing Potion
				{ 5, 2337 }, --Lesser Healing Potion
				{ 6, 2330 }, --Minor Healing Potion
				{ 8, 2332 }, --Minor Rejuvenation Potion
				{ 10, 24366 }, --Greater Dreamless Sleep Potion
				{ 12, 4508 }, --Discolored Healing Potion
				{ 13, 11458 }, --Wildvine Potion
				{ 16, 17580 }, --Major Mana Potion
				{ 17, 17553 }, --Superior Mana Potion
				{ 18, 11448 }, --Greater Mana Potion
				{ 19, 3452 }, --Mana Potion
				{ 20, 3173 }, --Lesser Mana Potion
				{ 21, 2331 }, --Minor Mana Potion
				{ 23, 22732 }, --Major Rejuvenation Potion
				{ 25, 15833 }, --Dreamless Sleep Potion
				{ 27, 24365 }, --Mageblood Potion
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 17574 }, --Greater Fire Protection Potion
				{ 2, 17575 }, --Greater Frost Protection Potion
				{ 3, 17576 }, --Greater Nature Protection Potion
				{ 4, 17577 }, --Greater Arcane Protection Potion
				{ 5, 17578 }, --Greater Shadow Protection Potion
				{ 7, 11453 }, --Magic Resistance Potion
				{ 8, 3174 }, --Elixir of Poison Resistance
				{ 16, 7257 }, --Fire Protection Potion
				{ 17, 7258 }, --Frost Protection Potion
				{ 18, 7259 }, --Nature Protection Potion
				{ 19, 7255 }, --Holy Protection Potion
				{ 20, 7256 }, --Shadow Protection Potion
				{ 22, 3172 }, --Minor Magic Resistance Potion
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 11464 }, --Invisibility Potion
				{ 2, 2335 }, --Swiftness Potion
				{ 3, 6624 }, --Free Action Potion
				{ 4, 3175 }, --Limited Invulnerability Potion
				{ 5, 24367 }, --Living Action Potion
				{ 6, 7841 }, --Swim Speed Potion
				{ 8, 17572 }, --Purification Potion
				{ 10, 17552 }, --Mighty Rage Potion
				{ 11, 6618 }, --Great Rage Potion
				{ 12, 6617 }, --Rage Potion
				{ 16, 3448 }, --Lesser Invisibility Potion
				{ 23, 11452 }, --Restorative Potion
				{ 25, 17570 }, --Greater Stoneshield Potion
				{ 26, 4942 }, --Lesser Stoneshield Potion
			},
		},
		{
			name = AL["Stat Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 3451 }, --Mighty Troll
				{ 2, 24368 }, --Major Troll
				{ 3, 3176 }, --Strong Troll
				{ 4, 3170 }, --Weak Troll
				{ 6, 17554 }, --Elixir of Superior Defense
				{ 7, 11450 }, --Elixir of Greater Defense
				{ 8, 3177 }, --Elixir of Defense
				{ 9, 7183 }, --Elixir of Minor Defense
				{ 11, 11472 }, --Elixir of Giants
				{ 12, 3188 }, --Elixir of Ogre
				{ 13, 2329 }, --Elixir of Lion
				{ 16, 11467 }, --Elixir of Greater Agility
				{ 17, 11449 }, --Elixir of Agility
				{ 18, 2333 }, --Elixir of Lesser Agility
				{ 19, 3230 }, --Elixir of Minor Agility
				{ 21, 11465 }, --Elixir of Greater Intellect
				{ 22, 3171 }, --Elixir of Wisdom
				{ 23, 17573 }, --Greater Arcane Elixir
				{ 24, 11461 }, --Arcane Elixir
			},
		},
		{
			name = AL["Misc Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 11478 }, --Elixir of Detect Demon
				{ 2, 12609 }, --Catseye Elixir
				{ 4, 22808 }, --Elixir of Greater Water Breathing
				{ 6, 11468 }, --Elixir of Dream Vision

				{ 16, 11460 }, --Elixir of Detect Undead
				{ 17, 3453 }, --Elixir of Detect Lesser Invisibility
				{ 19, 7179 }, --Elixir of Water Breathing
			},
		},
		{
			name = AL["Special Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 26277 }, --Elixir of Greater Firepower
				{ 2, 17555 }, --Elixir of the Sages
				{ 5, 3450 }, --Elixir of Fortitude
				{ 7, 17557 }, --Elixir of Brute Force
				{ 8, 17571 }, --Elixir of the Mongoose
				{ 10, 11477 }, --Elixir of Demonslaying
				{ 16, 7845 }, --Elixir of Firepower
				{ 17, 21923 }, --Elixir of Frost Power
				{ 18, 11476 }, --Elixir of Shadow Power
				{ 20, 2334 }, --Elixir of Minor Fortitude
				{ 22, 8240 }, --Elixir of Giant Growth
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 17632 }, --Alchemist's Stone
				{ 3, 11473 }, --Ghost Dye
				{ 5, 24266 }, --Gurubashi Mojo Madness
				{ 7, 11466 }, --Gift of Arthas
				{ 8, 3449 }, --Shadow Oil
				{ 9, 3454 }, --Frost Oil
				{ 10, 7837 }, --Fire Oil
				{ 16, 11459 }, --Philosophers' Stone
				{ 18, 11456 }, --Goblin Rocket Fuel
				{ 23, 7836 }, --Blackmouth Oil
				{ 24, 11451 }, --Oil of Immolation
				{ 25, 17551 }, --Stonescale Oil
			},
		},
	},
}