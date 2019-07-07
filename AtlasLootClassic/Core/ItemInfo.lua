local _G = _G
local AtlasLoot = _G.AtlasLoot
local ItemInfo = {}
AtlasLoot.ItemInfo = ItemInfo
local AL = AtlasLoot.Locales
local IngameLocales = AtlasLoot.IngameLocales

local type, rawset, rawget, setmetatable = type, rawset, rawget, setmetatable
-- local GetAuctionItemClasses, GetAuctionItemSubClasses = GetAuctionItemClasses, GetAuctionItemSubClasses

local ITEM_DESC_INFO = {
	["slot"] = {
		[""] = "",
		["INVTYPE_RANGEDRIGHT"] 		= "",
		["INVTYPE_SHIELD"] 				= _G["INVTYPE_SHIELD"],
		["INVTYPE_RANGED"] 				= "",
		["INVTYPE_WEAPON"] 				= "",
		["INVTYPE_2HWEAPON"] 			= "",
		["INVTYPE_WRIST"]				= _G["INVTYPE_WRIST"],
		["INVTYPE_TRINKET"]				= _G["INVTYPE_TRINKET"],
		["INVTYPE_ROBE"]				= _G["INVTYPE_ROBE"],
		["INVTYPE_CLOAK"]				= _G["INVTYPE_CLOAK"],
		["INVTYPE_HEAD"]				= _G["INVTYPE_HEAD"],
		["INVTYPE_HOLDABLE"]			= _G["INVTYPE_HOLDABLE"],
		["INVTYPE_CHEST"]				= _G["INVTYPE_CHEST"],
		["INVTYPE_NECK"]				= _G["INVTYPE_NECK"],
		["INVTYPE_TABARD"]				= _G["INVTYPE_TABARD"],
		["INVTYPE_LEGS"]				= _G["INVTYPE_LEGS"],
		["INVTYPE_HAND"]				= _G["INVTYPE_HAND"],
		["INVTYPE_WAIST"]				= _G["INVTYPE_WAIST"],
		["INVTYPE_FEET"]				= _G["INVTYPE_FEET"],
		["INVTYPE_SHOULDER"]			= _G["INVTYPE_SHOULDER"],
		["INVTYPE_FINGER"]				= _G["INVTYPE_FINGER"],
		["INVTYPE_BAG"]					= _G["INVTYPE_BAG"],
		["INVTYPE_AMMO"]				= _G["INVTYPE_AMMO"],
		["INVTYPE_BODY"]				= _G["INVTYPE_BODY"], -- Shirt
		["INVTYPE_QUIVER"]				= _G["INVTYPE_QUIVER"],
		["INVTYPE_RELIC"]				= _G["INVTYPE_RELIC"],
		["INVTYPE_THROWN"]				= _G["INVTYPE_THROWN"],
		["INVTYPE_WEAPONMAINHAND"] 		= _G["INVTYPE_WEAPONMAINHAND"],
		["INVTYPE_WEAPONMAINHAND_PET"]	= _G["INVTYPE_WEAPONMAINHAND_PET"],	-- "Main Attack"
		["INVTYPE_WEAPONOFFHAND"]		= _G["INVTYPE_WEAPONOFFHAND"],
	},
	["Weapon"] = {	-- 1
		["One-Handed Axes"] 	= AL["One-Hand, Axe"],		-- 1
		["Two-Handed Axes"]		= AL["Two-Hand, Axe"],		-- 2
		["Bows"]				= AL["Bow"],				-- 3
		["Guns"]				= AL["Gun"],				-- 4
		["One-Handed Maces"]	= AL["One-Hand, Mace"],		-- 5
		["Two-Handed Maces"]	= AL["Two-Hand, Mace"],		-- 6
		["Polearms"]			= AL["Polearm"],			-- 7
		["One-Handed Swords"]	= AL["One-Hand, Sword"],	-- 8
		["Two-Handed Swords"]	= AL["Two-Hand, Sword"],	-- 9
		["Staves"]				= AL["Staff"],				-- 10
		["Fist Weapons"]		= AL["Fist Weapon"],		-- 11
		--["Miscellaneous"]		= true,						-- 12
		["Daggers"]				= AL["Dagger"],				-- 13
		--["Thrown"]			= true,						-- 14
		["Crossbows"]			= AL["Crossbow"],			-- 15
		["Wands"]				= AL["Wand"],				-- 16
		["Fishing Poles"]		= AL["Fishing Pole"],		-- 17
	},
	["Armor"] = {	-- 2
		["Miscellaneous"] 	= "",							-- 1
		--["Cloth"]			= true,							-- 2
		--["Leather"] 		= true,							-- 3
		--["Mail"]			= true,							-- 4
		--["Plate"]			= true,							-- 5
		--["Cosmetic"]	 	= true,							-- 6
		["Shields"]			= AL["Shield"],					-- 7
	},
	--[[
	["Container"] = {	-- 3
		["Bag"]						= true,					-- 1
		["Herb Bag"]				= true,					-- 2
		["Enchanting Bag"]			= true,					-- 3
		["Engineering Bag"]			= true,					-- 4
		["Gem Bag"]					= true,					-- 5
		["Mining Bag"]				= true,					-- 6
		["Leatherworking Bag"]		= true,					-- 7
		["Inscription Bag"]			= true,					-- 8
		["Tackle Box"]				= true,					-- 9
		["Cooking Bag"]				= true,					-- 10
	},
	]]--
	--[[
	["Consumable"] = {	-- 4
		["Food & Drink"]		= true,						-- 1
		["Potion"]				= true,						-- 2
		["Elixir"]				= true,						-- 3
		["Flask"]				= true,						-- 4
		["Bandage"]				= true,						-- 5
		["Item Enhancement"]	= true,						-- 6
		["Scroll"]				= true,						-- 7
		["Other"]				= true,						-- 8
	},
	]]--
	--[[
	["Glyph"] = {	-- 5
		["Warrior"]				= true,						-- 1
		["Paladin"]				= true,						-- 2
		["Hunter"]				= true,						-- 3
		["Rogue"]				= true,						-- 4
		["Priest"]				= true,						-- 5
		["Death Knight"]		= true,						-- 6
		["Shaman"]				= true,						-- 7
		["Mage"]				= true,						-- 8
		["Warlock"]				= true,						-- 9
		["Monk"]				= true,						-- 10
		["Druid"]				= true,						-- 11
	},
	]]--
	--[[
	["Trade Goods"] = {	-- 6
		["Elemental"]			= true,						-- 1
		["Cloth"]				= true,						-- 2
		["Leather"]				= true,						-- 3
		["Metal & Stone"]		= true,						-- 4
		["Cooking"]				= true,						-- 5
		["Herb"]				= true,						-- 6
		["Enchanting"]			= true,						-- 7
		["Jewelcrafting"]		= true,						-- 8
		["Parts"]				= true,						-- 9
		["Devices"]				= true,						-- 10
		["Explosives"]			= true,						-- 11
		["Materials"]			= true,						-- 12
		["Other"]				= true,						-- 13
		["Item Enchantment"] 	= true,						-- 14
	},
	]]--
	--[[
	["Recipe"] = {	-- 7
		["Book"]				= true,						-- 1
		["Leatherworking"]		= true,						-- 2
		["Tailoring"]			= true,						-- 3
		["Engineering"]			= true,						-- 4
		["Blacksmithing"]		= true,						-- 5
		["Cooking"]				= true,						-- 6
		["Alchemy"]				= true,						-- 7
		["First Aid"]			= true,						-- 8
		["Enchanting"]			= true,						-- 9
		["Fishing"]				= true,						-- 10
		["Jewelcrafting"]		= true,						-- 11
		["Inscription"]			= true,						-- 12
	},
	]]--
	--[[
	["Gem"] = {	-- 8
		["Red"]				= true,						-- 1
		["Blue"]			= true,						-- 2
		["Yellow"]			= true,						-- 3
		["Purple"]			= true,						-- 4
		["Green"]			= true,						-- 5
		["Orange"]			= true,						-- 6
		["Meta"]			= true,						-- 7
		["Simple"]			= true,						-- 8
		["Prismatic"]		= true,						-- 9
		["Cogwheel"]		= true,						-- 10
	},
	]]--

	["Miscellaneous"] = {	-- 9
		["Junk"]			= _G["MISCELLANEOUS"],		-- 1
		--["Reagent"]			= true,					-- 2
		--["Companion Pets"]	= true,					-- 3
		--["Holiday"]			= true,					-- 4
		--["Other"]			= true,						-- 5
		--["Mount"]			= true,						-- 6
	},

	--[[
	["Quest"] = {	-- 10
		["Quest"] = true,
	},
	]]--
	--[[
	["Battle Pets"] = {
		["Humanoid"]		= true,						-- 1
		["Dragonkin"]		= true,						-- 2
		["Flying"]			= true,						-- 3
		["Undead"]			= true,						-- 4
		["Critter"]			= true,						-- 5
		["Magic"]			= true,						-- 6
		["Elemental"]		= true,						-- 7
		["Beast"]			= true,						-- 8
		["Aquatic"]			= true,						-- 9
		["Mechanical"]		= true,						-- 10
	},
	]]--
}

-- small info
-- 2 ways you can replace _G["INVTYPE_WEAPONMAINHAND"] with "" in the ITEM_DESC_INFO["slot"] table too hide ALL Mainhand info in description or you use the filter and generate a own name like "Main Hand, Axe"
local FILTER = {
	--- examples
	--{ slot = "INVTYPE_CLOAK", itemType = "Armor", itemSubType = "Cloth", __new = "HELLO THIS IS A TEST :)" },	-- This replace "Back, Cloth" with "HELLO THIS IS A TEST :)"
	--{ slot = "INVTYPE_CLOAK", itemType = "Armor", itemSubType = "Cloth", __new = { slot = "INVTYPE_THROWN", itemType = "Miscellaneous", itemSubType = "Junk" }},	-- This replace "Back, Cloth" with "Thrown, Junk"
	-- replace
	{ slot = "INVTYPE_CLOAK", itemType = "Armor", itemSubType = "Cloth", __new = { slot = "INVTYPE_CLOAK" } },	-- This replace "Back, Cloth" with "Back"
}

local preMt
local function __indexFunc(self, key)
	if not rawget(self, key) then
		rawset(self, key, setmetatable({}, preMt))
	end
	return rawget(self, key)
end

local PreSave = {}
preMt = {
	__index = __indexFunc
}
setmetatable(PreSave, preMt)

local function GetAuctionItemClasses()
	return 'Weapon', 'Armor', 'Container', 'Consumable', 'Trade Goods', 'Projectile', 'Quiver', 'Recipes', 'Reagent', 'Miscellaneous'
end

local function GetAuctionItemClassesLoc()
	return {
				AUCTION_CATEGORY_WEAPONS,
				AUCTION_CATEGORY_ARMOR,
				AUCTION_CATEGORY_CONTAINERS,
				AUCTION_CATEGORY_CONSUMABLES,
				AUCTION_CATEGORY_TRADE_GOODS,
				AUCTION_CATEGORY_PROJECTILE,
				AUCTION_CATEGORY_QUIVER,
				AUCTION_CATEGORY_RECIPES,
				AUCTION_CATEGORY_REAGENT,
				AUCTION_CATEGORY_MISCELLANEOUS,
			}
end

local function Init()
	for i = 1,#FILTER do
		FILTER[ ItemInfo.CreateDescription(FILTER[i].slot, FILTER[i].itemType, FILTER[i].itemSubType, true) ] = type(FILTER[i].__new) == "table" and ItemInfo.CreateDescription(FILTER[i].__new.slot, FILTER[i].__new.itemType, FILTER[i].__new.itemSubType, true) or FILTER[i].__new
	end
end
AtlasLoot:AddInitFunc(Init)

-- only use this if you need to ignore the filter
function ItemInfo.CreateDescription(slot, itemType, itemSubType, filterIgnore)
	local desc = ""
	if slot then
		desc = ITEM_DESC_INFO["slot"][slot] and ITEM_DESC_INFO["slot"][slot] or ( _G[slot] or "" )
	end
	if itemType and itemSubType then
		if ITEM_DESC_INFO[itemType] and ITEM_DESC_INFO[itemType][itemSubType] then
			if ITEM_DESC_INFO[itemType][itemSubType] ~= true then
				if ITEM_DESC_INFO[itemType][itemSubType] ~= "" then
					desc = (desc=="" and "" or desc..", ")..ITEM_DESC_INFO[itemType][itemSubType]
				end
			else
				desc = (desc=="" and "" or desc..", ")..itemSubType
			end
		else
			desc = (desc=="" and "" or desc..", ")..itemSubType
		end
	end
	if not filterIgnore then PreSave[slot or "nil"][itemType or "nil"][itemSubType or "nil"] = { true, FILTER[desc] or desc  } end
	return filterIgnore and desc or ( FILTER[desc] or desc )
end

function ItemInfo.GetDescription(slot, itemType, itemSubType)
	return PreSave[slot or "nil"][itemType or "nil"][itemSubType or "nil"][1] == true and PreSave[slot or "nil"][itemType or "nil"][itemSubType or "nil"][2] or ItemInfo.CreateDescription(slot, itemType, itemSubType)
end
