local _G = _G
local AtlasLoot = _G.AtlasLoot
local ItemInfo = {}
AtlasLoot.ItemInfo = ItemInfo
local AL = AtlasLoot.Locales
local IngameLocales = AtlasLoot.IngameLocales

local type, rawset, rawget, setmetatable = type, rawset, rawget, setmetatable
-- local GetAuctionItemClasses, GetAuctionItemSubClasses = GetAuctionItemClasses, GetAuctionItemSubClasses

local LOC_DATA = {
	{
		"One-Handed Axes", -- [1]
		"Two-Handed Axes", -- [2]
		"Bows", -- [3]
		"Guns", -- [4]
		"One-Handed Maces", -- [5]
		"Two-Handed Maces", -- [6]
		"Polearms", -- [7]
		"One-Handed Swords", -- [8]
		"Two-Handed Swords", -- [9]
		"Staves", -- [10]
		"Fist Weapons", -- [11]
		"Miscellaneous", -- [12]
		"Daggers", -- [13]
		"Thrown", -- [14]
		"Crossbows", -- [15]
		"Wands", -- [16]
		"Fishing Poles", -- [17]
		["__name"] = "Weapon",
	}, -- [1]
	{
		"Miscellaneous", -- [1]
		"Cloth", -- [2]
		"Leather", -- [3]
		"Mail", -- [4]
		"Plate", -- [5]
		"Cosmetic", -- [6]
		"Shields", -- [7]
		["__name"] = "Armor",
	}, -- [2]
	{
		"Bag", -- [1]
		"Herb Bag", -- [2]
		"Enchanting Bag", -- [3]
		"Engineering Bag", -- [4]
		"Gem Bag", -- [5]
		"Mining Bag", -- [6]
		"Leatherworking Bag", -- [7]
		"Inscription Bag", -- [8]
		"Tackle Box", -- [9]
		"Cooking Bag", -- [10]
		["__name"] = "Container",
	}, -- [3]
	{
		"Food & Drink", -- [1]
		"Potion", -- [2]
		"Elixir", -- [3]
		"Flask", -- [4]
		"Bandage", -- [5]
		"Item Enhancement", -- [6]
		"Scroll", -- [7]
		"Other", -- [8]
		["__name"] = "Consumable",
	}, -- [4]
	{
		"Warrior", -- [1]
		"Paladin", -- [2]
		"Hunter", -- [3]
		"Rogue", -- [4]
		"Priest", -- [5]
		"Death Knight", -- [6]
		"Shaman", -- [7]
		"Mage", -- [8]
		"Warlock", -- [9]
		"Monk", -- [10]
		"Druid", -- [11]
		["__name"] = "Glyph",
	}, -- [5]
	{
		"Elemental", -- [1]
		"Cloth", -- [2]
		"Leather", -- [3]
		"Metal & Stone", -- [4]
		"Cooking", -- [5]
		"Herb", -- [6]
		"Enchanting", -- [7]
		"Jewelcrafting", -- [8]
		"Parts", -- [9]
		"Devices", -- [10]
		"Explosives", -- [11]
		"Materials", -- [12]
		"Other", -- [13]
		"Item Enchantment", -- [14]
		["__name"] = "Trade Goods",
	}, -- [6]
	{
		"Book", -- [1]
		"Leatherworking", -- [2]
		"Tailoring", -- [3]
		"Engineering", -- [4]
		"Blacksmithing", -- [5]
		"Cooking", -- [6]
		"Alchemy", -- [7]
		"First Aid", -- [8]
		"Enchanting", -- [9]
		"Fishing", -- [10]
		"Jewelcrafting", -- [11]
		"Inscription", -- [12]
		["__name"] = "Recipe",
	}, -- [7]
	{
		"Red", -- [1]
		"Blue", -- [2]
		"Yellow", -- [3]
		"Purple", -- [4]
		"Green", -- [5]
		"Orange", -- [6]
		"Meta", -- [7]
		"Simple", -- [8]
		"Prismatic", -- [9]
		"Cogwheel", -- [10]
		["__name"] = "Gem",
	}, -- [8]
	{
		"Junk", -- [1]
		"Reagent", -- [2]
		"Companion Pets", -- [3]
		"Holiday", -- [4]
		"Other", -- [5]
		"Mount", -- [6]
		["__name"] = "Miscellaneous",
	}, -- [9]
	{
		["__name"] = "Quest",
	}, -- [10]
	{
		"Humanoid", -- [1]
		"Dragonkin", -- [2]
		"Flying", -- [3]
		"Undead", -- [4]
		"Critter", -- [5]
		"Magic", -- [6]
		"Elemental", -- [7]
		"Beast", -- [8]
		"Aquatic", -- [9]
		"Mechanical", -- [10]
		["__name"] = "Battle Pets",
	}, -- [11]
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
	--[[
	["Miscellaneous"] = {	-- 9
		["Junk"]			= true,						-- 1
		["Reagent"]			= true,						-- 2
		["Companion Pets"]	= true,						-- 3
		["Holiday"]			= true,						-- 4
		["Other"]			= true,						-- 5
		["Mount"]			= true,						-- 6
	},
	]]--
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
return 'Weapon', 'Armor', 'Container', 'Consumable', 'Glyph', 'Trade Goods', 'Recipe', 'Gem', 'Miscellaneous', 'Quest', 'Battle Pets'
end

local function Init()
	-- replace strings
	LOC_DATA.translation = {}
	local itemClasses = { AuctionCategories }
	for i = 1, #itemClasses do
		local itemSubClasses = { GetAuctionItemSubClasses(i) }
		local iTab = ITEM_DESC_INFO[ LOC_DATA[i]["__name"] ]
		if iTab then
			--iTab[ LOC_DATA[9]["__name"] ] = "" -- Hide Miscellaneous for every category
			ITEM_DESC_INFO[ itemClasses[i] ] = ITEM_DESC_INFO[ LOC_DATA[i]["__name"] ]
			LOC_DATA.translation[LOC_DATA[i]["__name"]] = itemClasses[i]
		end
		for j = 1, #LOC_DATA[i] do
			LOC_DATA.translation[LOC_DATA[i][j]] = itemSubClasses[j]
			if not rawget(IngameLocales, LOC_DATA[i][j]) then
				IngameLocales[LOC_DATA[i][j]] = itemSubClasses[j]
			end			
			if iTab and iTab[ LOC_DATA[i][j] ] then
				iTab[ itemSubClasses[j] ] = iTab[ LOC_DATA[i][j] ]
			end
		end
	end
	
	for i = 1,#FILTER do
		FILTER[ ItemInfo.CreateDescription(FILTER[i].slot, LOC_DATA.translation[FILTER[i].itemType], LOC_DATA.translation[FILTER[i].itemSubType], true) ] = type(FILTER[i].__new) == "table" and ItemInfo.CreateDescription(FILTER[i].__new.slot, LOC_DATA.translation[FILTER[i].__new.itemType], LOC_DATA.translation[FILTER[i].__new.itemSubType], true) or FILTER[i].__new
	end
	
	LOC_DATA = nil
	
	--[[ renew data
		local ITEM_DESC_INDEX = { GetAuctionItemClasses() }
	
		for i = 1, #ITEM_DESC_INDEX do
			ITEM_DESC_INDEX[ i ] = {
				__name = ITEM_DESC_INDEX[i]
			}
			local itemSubClasses = { GetAuctionItemSubClasses(i) }
			local itemClassTab = ITEM_DESC_INDEX[ i ] 
			for j = 1, #itemSubClasses do
				itemClassTab[ j ] = itemSubClasses[j]
			end
		end
		AtlasLoot.db.ItemInfoLUA = ITEM_DESC_INDEX
	]]--
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
