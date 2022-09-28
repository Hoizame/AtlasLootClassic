local _G = _G
local AtlasLoot = _G.AtlasLoot
local ItemInfo = {}
AtlasLoot.ItemInfo = ItemInfo
local AL = AtlasLoot.Locales
local IngameLocales = AtlasLoot.IngameLocales

local type, rawset, rawget, setmetatable = type, rawset, rawget, setmetatable
-- local GetAuctionItemClasses, GetAuctionItemSubClasses = GetAuctionItemClasses, GetAuctionItemSubClasses

local LOC_DATA = {
	[0] = {
		["__name"] = "Consumable",
		[0] = "Consumable",
		[1] = "Cheese/Bread(OBSOLETE)",
		[2] = "Liquid(OBSOLETE)",
	},
	[1] = {
		["__name"] = "Container",
		[0] = "Bag",
		[1] = "Soul Bag",
		[2] = "Herb Bag",
		[3] = "Enchanting Bag",
		[4] = "Engineering Bag",
	},
	[2] = {
		["__name"] = "Weapon",
		[0] = "One-Handed Axes",
		[1] = "Two-Handed Axes",
		[2] = "Bows",
		[3] = "Guns",
		[4] = "One-Handed Maces",
		[5] = "Two-Handed Maces",
		[6] = "Polearms",
		[7] = "One-Handed Swords",
		[8] = "Two-Handed Swords",
		[9] = "Obsolete",
		[10] = "Staves",
		[11] = "One-Handed Exotics",
		[12] = "Two-Handed Exotics",
		[13] = "Fist Weapons",
		[14] = "Miscellaneous",
		[15] = "Daggers",
		[16] = "Thrown",
		[17] = "Spears",
		[18] = "Crossbows",
		[19] = "Wands",
		[20] = "Fishing Pole",
	},
	[3] = {
		["__name"] = "Jewelry(OBSOLETE)",
		[0] = "Jewelry(OBSOLETE)",
	},
	[4] = {
		["__name"] = "Armor",
		[0] = "Miscellaneous",
		[1] = "Cloth",
		[2] = "Leather",
		[3] = "Mail",
		[4] = "Plate",
		[5] = "Bucklers",
		[6] = "Shields",
		[7] = "Librams",
		[8] = "Idols",
		[9] = "Totems",
	},
	[5] = {
		["__name"] = "Reagent",
		[0] = "Reagent",
	},
	[6] = {
		["__name"] = "Projectile",
		[0] = "Wand(OBSOLETE)",
		[1] = "Bolt(OBSOLETE)",
		[2] = "Arrow",
		[3] = "Bullet",
		[4] = "Thrown(OBSOLETE)",
	},
	[7] = {
		["__name"] = "Trade Goods",
		[0] = "Trade Goods",
		[1] = "Parts",
		[2] = "Explosives",
		[3] = "Devices",
	},
	[8] = {
		["__name"] = "Generic(OBSOLETE)",
		[0] = "Generic(OBSOLETE)",
	},
	[9] = {
		["__name"] = "Recipe",
		[0] = "Book",
		[1] = "Leatherworking",
		[2] = "Tailoring",
		[3] = "Engineering",
		[4] = "Blacksmithing",
		[5] = "Cooking",
		[6] = "Alchemy",
		[7] = "First Aid",
		[8] = "Enchanting",
		[9] = "Fishing",
	},
	[10] = {
		["__name"] = "Money(OBSOLETE)",
		[0] = "Money(OBSOLETE)",
	},
	[11] = {
		["__name"] = "Quiver",
		[0] = "Quiver(OBSOLETE)",
		[1] = "Quiver(OBSOLETE)",
		[2] = "Quiver",
		[3] = "Ammo Pouch",
	},
	[12] = {
		["__name"] = "Quest",
		[0] = "Quest",
	},
	[13] = {
		["__name"] = "Key",
		[0] = "Key",
		[1] = "Lockpick",
	},
	[14] = {
		["__name"] = "Permanent(OBSOLETE)",
		[0] = "Permanent",
	},
	[15] = {
		["__name"] = "Miscellaneous",
		[0] = "Junk",
	},
}

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
	--[[
	["Consumable"] = {		-- 0
		["Consumable"] = true, -- 0
		["Cheese/Bread(OBSOLETE)"] = true, -- 1
		["Liquid(OBSOLETE)"] = true, -- 2
	},
	--]]
	["Container"] = {		-- 1
		["Bag"] 				= "", 		-- 0
		--["Soul Bag"] 			= true, 	-- 1
		--["Herb Bag"] 			= true, 	-- 2
		--["Enchanting Bag"] 	= true, 	-- 3
		--["Engineering Bag"] 	= true, 	-- 4
	},
	["Weapon"] = {		-- 2
		["One-Handed Axes"] 	= AL["One-Hand, Axe"], 		-- 0
		["Two-Handed Axes"] 	= AL["Two-Hand, Axe"], 		-- 1
		["Bows"] 				= AL["Bow"], 				-- 2
		["Guns"] 				= AL["Gun"], 				-- 3
		["One-Handed Maces"] 	= AL["One-Hand, Mace"], 	-- 4
		["Two-Handed Maces"] 	= AL["Two-Hand, Mace"], 	-- 5
		["Polearms"] 			= AL["Polearm"], 			-- 6
		["One-Handed Swords"] 	= AL["One-Hand, Sword"], 	-- 7
		["Two-Handed Swords"] 	= AL["Two-Hand, Sword"], 	-- 8
		--["Obsolete"] 			= true, 					-- 9
		["Staves"] 				= AL["Staff"], 				-- 10
		--["One-Handed Exotics"]= true, 					-- 11
		--["Two-Handed Exotics"]= true, 					-- 12
		["Fist Weapons"] 		= AL["Fist Weapon"], 		-- 13
		--["Miscellaneous"] 	= true, 					-- 14
		["Daggers"] 			= AL["Dagger"], 			-- 15
		--["Thrown"] 			= true, 					-- 16
		--["Spears"] 			= true, 					-- 17
		["Crossbows"] 			= AL["Crossbow"], 			-- 18
		["Wands"] 				= AL["Wand"], 				-- 19
		["Fishing Pole"] 		= AL["Fishing Pole"], 		-- 20
	},
	--[[
	["Jewelry(OBSOLETE)"] = {		-- 3
		["Jewelry(OBSOLETE)"] = true, -- 0
	},
	--]]
	["Armor"] = {		-- 4
		["Miscellaneous"] 	= "", -- 0
		--["Cloth"] 		= true, 			-- 1
		--["Leather"] 		= true, 			-- 2
		--["Mail"] 			= true, 			-- 3
		--["Plate"] 		= true, 			-- 4
		--["Bucklers"] 		= true, 			-- 5
		["Shields"]		 	= AL["Shield"], 	-- 6
		--["Librams"] 		= true, 			-- 7
		--["Idols"] 		= true, 			-- 8
		--["Totems"] 		= true, 			-- 9
	},
	--[[
	["Reagent"] = {		-- 5
		["Reagent"] = true, -- 0
	},
	--]]
	--[[
	["Projectile"] = {		-- 6
		["Wand(OBSOLETE)"] = true, -- 0
		["Bolt(OBSOLETE)"] = true, -- 1
		["Arrow"] = true, -- 2
		["Bullet"] = true, -- 3
		["Thrown(OBSOLETE)"] = true, -- 4
	},
	--]]
	--[[
	["Trade Goods"] = {		-- 7
		["Trade Goods"] = true, -- 0
		["Parts"] = true, -- 1
		["Explosives"] = true, -- 2
		["Devices"] = true, -- 3
	},
	--]]
	--[[
	["Generic(OBSOLETE)"] = {		-- 8
		["Generic(OBSOLETE)"] = true, -- 0
	},
	--]]
	--[[
	["Recipe"] = {		-- 9
		["Book"] = true, -- 0
		["Leatherworking"] = true, -- 1
		["Tailoring"] = true, -- 2
		["Engineering"] = true, -- 3
		["Blacksmithing"] = true, -- 4
		["Cooking"] = true, -- 5
		["Alchemy"] = true, -- 6
		["First Aid"] = true, -- 7
		["Enchanting"] = true, -- 8
		["Fishing"] = true, -- 9
	},
	--]]
	["Money(OBSOLETE)"] = {		-- 10
		["Money(OBSOLETE)"] = IngameLocales["Currency"], -- 0
	},
	--[[
	["Quiver"] = {		-- 11
		["Quiver(OBSOLETE)"] = true, -- 0
		["Quiver(OBSOLETE)"] = true, -- 1
		["Quiver"] = true, -- 2
		["Ammo Pouch"] = true, -- 3
	},
	--]]
	--[[
	["Quest"] = {		-- 12
		["Quest"] = true, -- 0
	},
	--]]
	--[[
	["Key"] = {		-- 13
		["Key"] = true, -- 0
		["Lockpick"] = true, -- 1
	},
	--]]
	--[[
	["Permanent(OBSOLETE)"] = {		-- 14
		["Permanent"] = true, -- 0
	},
	--]]
	["Miscellaneous"] = {		-- 15
		["Junk"] 	= 	_G["MISCELLANEOUS"], 	-- 0
	},
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
	local NewLocData = {
		--en = {},
		loc = {},
	}
	for iC = 0, #LOC_DATA do
		local class = LOC_DATA[iC]
		local className = GetItemClassInfo(iC)

		--NewLocData.en[class.__name] = className
		NewLocData.loc[className] = class.__name

		for isC = 0, #class do
			local subClass = class[isC]
			local name = GetItemSubClassInfo(iC,isC)
			if not NewLocData[subClass] then
				--NewLocData.en[class.__name..subClass] = name
				NewLocData.loc[className..name] = subClass
			end
		end
	end

	LOC_DATA = NewLocData

	for i = 1,#FILTER do
		FILTER[ ItemInfo.CreateDescription(FILTER[i].slot, LOC_DATA.loc[FILTER[i].itemType], LOC_DATA.loc[FILTER[i].itemType..FILTER[i].itemSubType], true) ] = type(FILTER[i].__new) == "table" and ItemInfo.CreateDescription(FILTER[i].__new.slot, LOC_DATA.loc[FILTER[i].__new.itemType], (FILTER[i].__new.itemType and FILTER[i].__new.itemSubType) and FILTER[i].__new.itemType..FILTER[i].__new.itemSubType or nil, true) or FILTER[i].__new
	end
end
AtlasLoot:AddInitFunc(Init)

-- only use this if you need to ignore the filter
function ItemInfo.CreateDescription(slot, itemType, itemSubType, filterIgnore)
	local desc = ""
	if slot then
		desc = ITEM_DESC_INFO["slot"][slot] and ITEM_DESC_INFO["slot"][slot] or ( _G[slot] or "" )
	end
	itemType = itemType and ( LOC_DATA.loc[itemType] or itemType ) or itemType
	itemSubType = (itemType and itemSubType) and ( LOC_DATA.loc[itemType..itemSubType] or itemSubType ) or itemSubType
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
