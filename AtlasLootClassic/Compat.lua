-- ----------------------------------------------------------------------------
-- AtlasLoot Compat
--
-- Classic Era 1.15.9 / TBC Anniversary 2.5.6 (July 2026) moved the client to
-- the shared modern UI code base. Several globals AtlasLoot relied on were
-- removed there:
--   * LE_ITEM_CLASS_* / LE_ITEM_WEAPON_* / LE_ITEM_ARMOR_* / ... constants
--     (now Enum.ItemClass, Enum.ItemWeaponSubclass, ...). Using them as table
--     keys made Data/ClassFilter.lua fail with "table index is nil" and the
--     whole addon stopped loading.
--   * Old item / spell / addon API globals (GetItemInfo, GetSpellInfo,
--     GetAddOnMetadata, ...) which now live in C_Item / C_Spell / C_AddOns.
--
-- This file only defines a global when it is missing, so it is a no-op on
-- clients that still provide the old names.
-- ----------------------------------------------------------------------------

local function def(name, value)
	if _G[name] == nil and value ~= nil then
		_G[name] = value
	end
end

local function defEnum(prefix, enumTable, map, fallback)
	for legacy, key in pairs(map) do
		local v = enumTable and enumTable[key]
		if v == nil then v = fallback[legacy] end
		def(prefix .. legacy, v)
	end
end

-- ## Item classes -------------------------------------------------------------
defEnum("LE_ITEM_CLASS_", Enum and Enum.ItemClass, {
	CONSUMABLE = "Consumable", CONTAINER = "Container", WEAPON = "Weapon",
	GEM = "Gem", ARMOR = "Armor", REAGENT = "Reagent", PROJECTILE = "Projectile",
	TRADEGOODS = "Tradegoods", ITEM_ENHANCEMENT = "ItemEnhancement",
	RECIPE = "Recipe", QUIVER = "Quiver", QUESTITEM = "Questitem",
	KEY = "Key", MISCELLANEOUS = "Miscellaneous", GLYPH = "Glyph",
	BATTLEPET = "Battlepet", WOW_TOKEN = "WoWToken",
}, {
	CONSUMABLE = 0, CONTAINER = 1, WEAPON = 2, GEM = 3, ARMOR = 4, REAGENT = 5,
	PROJECTILE = 6, TRADEGOODS = 7, ITEM_ENHANCEMENT = 8, RECIPE = 9,
	QUIVER = 11, QUESTITEM = 12, KEY = 13, MISCELLANEOUS = 15, GLYPH = 16,
	BATTLEPET = 17, WOW_TOKEN = 18,
})

-- ## Weapon subclasses --------------------------------------------------------
defEnum("LE_ITEM_WEAPON_", Enum and Enum.ItemWeaponSubclass, {
	AXE1H = "Axe1H", AXE2H = "Axe2H", BOWS = "Bows", GUNS = "Guns",
	MACE1H = "Mace1H", MACE2H = "Mace2H", POLEARM = "Polearm",
	SWORD1H = "Sword1H", SWORD2H = "Sword2H", WARGLAIVE = "Warglaive",
	STAFF = "Staff", BEARCLAW = "Bearclaw", CATCLAW = "Catclaw",
	UNARMED = "Unarmed", GENERIC = "Generic", DAGGER = "Dagger",
	THROWN = "Thrown", OBSOLETE3 = "Obsolete3", CROSSBOW = "Crossbow",
	WAND = "Wand", FISHINGPOLE = "Fishingpole",
}, {
	AXE1H = 0, AXE2H = 1, BOWS = 2, GUNS = 3, MACE1H = 4, MACE2H = 5,
	POLEARM = 6, SWORD1H = 7, SWORD2H = 8, WARGLAIVE = 9, STAFF = 10,
	BEARCLAW = 11, CATCLAW = 12, UNARMED = 13, GENERIC = 14, DAGGER = 15,
	THROWN = 16, OBSOLETE3 = 17, CROSSBOW = 18, WAND = 19, FISHINGPOLE = 20,
})

-- ## Armor subclasses ---------------------------------------------------------
defEnum("LE_ITEM_ARMOR_", Enum and Enum.ItemArmorSubclass, {
	GENERIC = "Generic", CLOTH = "Cloth", LEATHER = "Leather", MAIL = "Mail",
	PLATE = "Plate", COSMETIC = "Cosmetic", SHIELD = "Shield",
	LIBRAM = "Libram", IDOL = "Idol", TOTEM = "Totem", SIGIL = "Sigil",
	RELIC = "Relic",
}, {
	GENERIC = 0, CLOTH = 1, LEATHER = 2, MAIL = 3, PLATE = 4, COSMETIC = 5,
	SHIELD = 6, LIBRAM = 7, IDOL = 8, TOTEM = 9, SIGIL = 10, RELIC = 11,
})

-- ## Recipe subclasses --------------------------------------------------------
defEnum("LE_ITEM_RECIPE_", Enum and Enum.ItemRecipeSubclass, {
	BOOK = "Book", LEATHERWORKING = "Leatherworking", TAILORING = "Tailoring",
	ENGINEERING = "Engineering", BLACKSMITHING = "Blacksmithing",
	COOKING = "Cooking", ALCHEMY = "Alchemy", FIRST_AID = "FirstAid",
	ENCHANTING = "Enchanting", FISHING = "Fishing",
	JEWELCRAFTING = "Jewelcrafting", INSCRIPTION = "Inscription",
}, {
	BOOK = 0, LEATHERWORKING = 1, TAILORING = 2, ENGINEERING = 3,
	BLACKSMITHING = 4, COOKING = 5, ALCHEMY = 6, FIRST_AID = 7,
	ENCHANTING = 8, FISHING = 9, JEWELCRAFTING = 10, INSCRIPTION = 11,
})

-- ## Miscellaneous subclasses -------------------------------------------------
defEnum("LE_ITEM_MISCELLANEOUS_", Enum and Enum.ItemMiscellaneousSubclass, {
	JUNK = "Junk", REAGENT = "Reagent", COMPANION_PET = "CompanionPet",
	HOLIDAY = "Holiday", OTHER = "Other", MOUNT = "Mount",
	MOUNT_EQUIPMENT = "MountEquipment",
}, {
	JUNK = 0, REAGENT = 1, COMPANION_PET = 2, HOLIDAY = 3, OTHER = 4,
	MOUNT = 5, MOUNT_EQUIPMENT = 6,
})

-- ## Item quality -------------------------------------------------------------
local Q = Enum and Enum.ItemQuality
def("LE_ITEM_QUALITY_POOR",      Q and Q.Poor or 0)
def("LE_ITEM_QUALITY_COMMON",    Q and (Q.Common or Q.Standard) or 1)
def("LE_ITEM_QUALITY_UNCOMMON",  Q and (Q.Uncommon or Q.Good) or 2)
def("LE_ITEM_QUALITY_RARE",      Q and (Q.Rare or Q.Superior) or 3)
def("LE_ITEM_QUALITY_EPIC",      Q and Q.Epic or 4)
def("LE_ITEM_QUALITY_LEGENDARY", Q and Q.Legendary or 5)
def("LE_ITEM_QUALITY_ARTIFACT",  Q and Q.Artifact or 6)
def("LE_ITEM_QUALITY_HEIRLOOM",  Q and Q.Heirloom or 7)

-- ## Expansion level ----------------------------------------------------------
def("LE_EXPANSION_CLASSIC", 0)
def("LE_EXPANSION_BURNING_CRUSADE", 1)
def("LE_EXPANSION_WRATH_OF_THE_LICH_KING", 2)
if _G.LE_EXPANSION_LEVEL_CURRENT == nil and GetExpansionLevel then
	local ok, lvl = pcall(GetExpansionLevel)
	if ok then def("LE_EXPANSION_LEVEL_CURRENT", lvl) end
end

-- ## Item API -----------------------------------------------------------------
if C_Item then
	def("GetItemInfo",         C_Item.GetItemInfo)
	def("GetItemInfoInstant",  C_Item.GetItemInfoInstant)
	def("GetItemCount",        C_Item.GetItemCount)
	def("GetItemIcon",         C_Item.GetItemIconByID)
	def("GetItemQualityColor", C_Item.GetItemQualityColor)
	def("GetItemStats",        C_Item.GetItemStats)
	def("GetItemSpell",        C_Item.GetItemSpell)
	def("IsEquippableItem",    C_Item.IsEquippableItem)
	def("GetItemFamily",       C_Item.GetItemFamily)
end

-- ## Spell API ----------------------------------------------------------------
if C_Spell then
	if _G.GetSpellInfo == nil and C_Spell.GetSpellInfo then
		-- old signature: name, rank, icon, castTime, minRange, maxRange, spellID
		_G.GetSpellInfo = function(spell)
			local info = C_Spell.GetSpellInfo(spell)
			if not info then return end
			return info.name, nil, info.iconID, info.castTime, info.minRange, info.maxRange, info.spellID
		end
	end
	def("GetSpellTexture",     C_Spell.GetSpellTexture)
	def("GetSpellLink",        C_Spell.GetSpellLink)
	def("GetSpellDescription", C_Spell.GetSpellDescription)
end

-- ## AddOn API ----------------------------------------------------------------
if C_AddOns then
	def("GetAddOnMetadata",    C_AddOns.GetAddOnMetadata)
	def("GetAddOnInfo",        C_AddOns.GetAddOnInfo)
	if _G.GetAddOnEnableState == nil and C_AddOns.GetAddOnEnableState then
		-- NOTE: the argument order is swapped between the two:
		-- old global: GetAddOnEnableState(character, addonIndexOrName)
		-- new API:    C_AddOns.GetAddOnEnableState(addonIndexOrName, character)
		_G.GetAddOnEnableState = function(character, addon)
			return C_AddOns.GetAddOnEnableState(addon, character)
		end
	end
	def("GetNumAddOns",        C_AddOns.GetNumAddOns)
	def("IsAddOnLoaded",       C_AddOns.IsAddOnLoaded)
	def("LoadAddOn",           C_AddOns.LoadAddOn)
	def("EnableAddOn",         C_AddOns.EnableAddOn)
	def("DisableAddOn",        C_AddOns.DisableAddOn)
end

-- ## Container API ------------------------------------------------------------
if C_Container then
	def("GetContainerNumSlots", C_Container.GetContainerNumSlots)
	def("GetContainerItemID",   C_Container.GetContainerItemID)
	def("GetContainerItemLink", C_Container.GetContainerItemLink)
end

-- ## Misc ---------------------------------------------------------------------
if _G.GetMouseFocus == nil and GetMouseFoci then
	_G.GetMouseFocus = function() local t = GetMouseFoci(); return t and t[1] end
end
