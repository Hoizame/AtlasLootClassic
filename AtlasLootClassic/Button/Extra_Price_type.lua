-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = string
local type, tonumber, pairs = type, tonumber, pairs
local str_split = string.split
-- WoW
local GetCurrencyInfo, GetItemInfo, GetItemCount, GetItemIcon = GetCurrencyInfo, GetItemInfo, GetItemCount, GetItemIcon
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AtlasLoot = _G.AtlasLoot
local Price = AtlasLoot.Button:AddExtraType("Price")
local AL = AtlasLoot.Locales


local FIRST_RUN = true
local ITEMS_NOT_FOUND = true

local STRING_SPLIT_OR = "-"
local STRING_DELIMITER_OR = "|r; "
local STRING_DELIMITER_TT_OR = "|cff999999"..AL["--- or ---"]
local STRING_SPLIT_AND = ":"
local STRING_DELIMITER_AND = "|r & "
local STRING_DELIMITER_END = ""
local STRING_TABLE = "table"
local STRING_RED = "|cffff0000"
local STRING_GREEN = "|cff1eff00"

local PRICE_INFO = {
	-- items
	["markofhonor"] 	= { itemID = 137642 }, -- Mark of Honor
	["bfclaw"] 		= { itemID = 124099 }, -- Blackfang Claw
	["brewfest"] 		= { itemID = 37829 }, -- Brewfest Prize Token
	["burningblossom"] 	= { itemID = 23247 }, -- Burning Blossom
	["lovetoken"] 		= { itemID = 49927 }, -- Love Token
	["noblegardenchocolate"] = { itemID = 44791 }, -- Noblegarden Chocolate
	["spiritofharmony"] 	= { itemID = 76061 }, -- Spirit of Harmony
	["trickytreat"] 	= { itemID = 33226 }, -- Tricky Treat
	["ancestrycoin"] 	= { itemID = 21100 }, -- Coin of Ancestry
	["vicioussaddle"] 	= { itemID = 103533 }, -- Vicious Saddle, added in 5.4.0
	["luckycoin"] 		= { itemID = 117397 }, -- Nat's Lucky Coin, added in 6.0.1
	["forlorn"] 		= { itemID = 66998 }, -- Essence of the Forlorn, Added in patch 4.0.1.12984
	["65000"] = { itemID = 65000 }, -- Crown of the Forlorn Protector
	["65001"] = { itemID = 65001 }, -- Crown of the Forlorn Conqueror
	["65002"] = { itemID = 65002 }, -- Crown of the Forlorn Vanquisher
	["65087"] = { itemID = 65087 }, -- Shoulders of the Forlorn Protector
	["65088"] = { itemID = 65088 }, -- Shoulders of the Forlorn Conqueror
	["65089"] = { itemID = 65089 }, -- Shoulders of the Forlorn Vanquisher
	["67423"] = { itemID = 67423 }, -- Chest of the Forlorn Conqueror
	["67424"] = { itemID = 67424 }, -- Chest of the Forlorn Protector
	["67425"] = { itemID = 67425 }, -- Chest of the Forlorn Vanquisher
	["67426"] = { itemID = 67426 }, -- Leggings of the Forlorn Vanquisher
	["67427"] = { itemID = 67427 }, -- Leggings of the Forlorn Protector
	["67428"] = { itemID = 67428 }, -- Leggings of the Forlorn Conqueror
	["67429"] = { itemID = 67429 }, -- Gauntlets of the Forlorn Conqueror
	["67430"] = { itemID = 67430 }, -- Gauntlets of the Forlorn Protector
	["67431"] = { itemID = 67431 }, -- Gauntlets of the Forlorn Vanquisher
	["71668"] = { itemID = 71668 }, -- Helm of the Fiery Vanquisher
	["71682"] = { itemID = 71682 }, -- Helm of the Fiery Protector
	["71675"] = { itemID = 71675 }, -- Helm of the Fiery Conqueror
	["71670"] = { itemID = 71670 }, -- Crown of the Fiery Vanquisher
	["71684"] = { itemID = 71684 }, -- Crown of the Fiery Protector
	["71677"] = { itemID = 71677 }, -- Crown of the Fiery Conqueror
	["71672"] = { itemID = 71672 }, -- Chest of the Fiery Vanquisher
	["71686"] = { itemID = 71686 }, -- Chest of the Fiery Protector
	["71679"] = { itemID = 71679 }, -- Chest of the Fiery Conqueror
	["71669"] = { itemID = 71669 }, -- Gauntlets of the Fiery Vanquisher
	["71683"] = { itemID = 71683 }, -- Gauntlets of the Fiery Protector
	["71676"] = { itemID = 71676 }, -- Gauntlets of the Fiery Conqueror
	["71671"] = { itemID = 71671 }, -- Leggings of the Fiery Vanquisher
	["71685"] = { itemID = 71685 }, -- Leggings of the Fiery Protector
	["71678"] = { itemID = 71678 }, -- Leggings of the Fiery Conqueror
	["71674"] = { itemID = 71674 }, -- Mantle of the Fiery Vanquisher
	["71688"] = { itemID = 71688 }, -- Mantle of the Fiery Protector
	["71681"] = { itemID = 71681 }, -- Mantle of the Fiery Conqueror
	["71673"] = { itemID = 71673 }, -- Shoulders of the Fiery Vanquisher
	["71687"] = { itemID = 71687 }, -- Shoulders of the Fiery Protector
	["71680"] = { itemID = 71680 }, -- Shoulders of the Fiery Conqueror
	["70945"] = { itemID = 70945 }, -- Chestguard of the Molten Giant
	["70943"] = { itemID = 70943 }, -- Handguards of the Molten Giant
	["70942"] = { itemID = 70942 }, -- Legguards of the Molten Giant
	["60339"] = { itemID = 60339 }, -- Magma Plated Battleplate
	["60340"] = { itemID = 60340 }, -- Magma Plated Gauntlets
	["60342"] = { itemID = 60342 }, -- Magma Plated Legplates
	["60349"] = { itemID = 60349 }, -- Magma Plated Chestguard
	["60350"] = { itemID = 60350 }, -- Magma Plated Handguards
	["60352"] = { itemID = 60352 }, -- Magma Plated Legguards
	["70955"] = { itemID = 70955 }, -- Elementium Deathplate Chestguard
	["71058"] = { itemID = 71058 }, -- Elementium Deathplate Breastplate
	["70953"] = { itemID = 70953 }, -- Elementium Deathplate Handguards
	["71059"] = { itemID = 71059 }, -- Elementium Deathplate Gauntlets
	["70952"] = { itemID = 70952 }, -- Elementium Deathplate Legguards
	["71061"] = { itemID = 71061 }, -- Elementium Deathplate Greaves
	["78170"] = { itemID = 78170 }, -- Shoulders of the Corrupted Vanquisher
	["78171"] = { itemID = 78171 }, -- Leggings of the Corrupted Vanquisher
	["78172"] = { itemID = 78172 }, -- Crown of the Corrupted Vanquisher
	["78173"] = { itemID = 78173 }, -- Gauntlets of the Corrupted Vanquisher
	["78174"] = { itemID = 78174 }, -- Chest of the Corrupted Vanquisher
	["78175"] = { itemID = 78175 }, -- Shoulders of the Corrupted Protector
	["78176"] = { itemID = 78176 }, -- Leggings of the Corrupted Protector
	["78177"] = { itemID = 78177 }, -- Crown of the Corrupted Protector
	["78178"] = { itemID = 78178 }, -- Gauntlets of the Corrupted Protector
	["78179"] = { itemID = 78179 }, -- Chest of the Corrupted Protector
	["78180"] = { itemID = 78180 }, -- Shoulders of the Corrupted Conqueror
	["78181"] = { itemID = 78181 }, -- Leggings of the Corrupted Conqueror
	["78182"] = { itemID = 78182 }, -- Crown of the Corrupted Conqueror
	["78183"] = { itemID = 78183 }, -- Gauntlets of the Corrupted Conqueror
	["78184"] = { itemID = 78184 }, -- Chest of the Corrupted Conqueror
	["78847"] = { itemID = 78847 }, -- Chest of the Corrupted Conqueror
	["78848"] = { itemID = 78848 }, -- Chest of the Corrupted Protector
	["78849"] = { itemID = 78849 }, -- Chest of the Corrupted Vanquisher
	["78850"] = { itemID = 78850 }, -- Crown of the Corrupted Conqueror
	["78851"] = { itemID = 78851 }, -- Crown of the Corrupted Protector
	["78852"] = { itemID = 78852 }, -- Crown of the Corrupted Vanquisher
	["78853"] = { itemID = 78853 }, -- Gauntlets of the Corrupted Conqueror
	["78854"] = { itemID = 78854 }, -- Gauntlets of the Corrupted Protector
	["78855"] = { itemID = 78855 }, -- Gauntlets of the Corrupted Vanquisher
	["78856"] = { itemID = 78856 }, -- Leggings of the Corrupted Conqueror
	["78857"] = { itemID = 78857 }, -- Leggings of the Corrupted Protector
	["78858"] = { itemID = 78858 }, -- Leggings of the Corrupted Vanquisher
	["78859"] = { itemID = 78859 }, -- Shoulders of the Corrupted Conqueror
	["78860"] = { itemID = 78860 }, -- Shoulders of the Corrupted Protector
	["78861"] = { itemID = 78861 }, -- Shoulders of the Corrupted Vanquisher
	["78862"] = { itemID = 78862 }, -- Chest of the Corrupted Vanquisher
	["78863"] = { itemID = 78863 }, -- Chest of the Corrupted Conqueror
	["78864"] = { itemID = 78864 }, -- Chest of the Corrupted Protector
	["78865"] = { itemID = 78865 }, -- Gauntlets of the Corrupted Vanquisher
	["78866"] = { itemID = 78866 }, -- Gauntlets of the Corrupted Conqueror
	["78867"] = { itemID = 78867 }, -- Gauntlets of the Corrupted Protector
	["78868"] = { itemID = 78868 }, -- Crown of the Corrupted Vanquisher
	["78869"] = { itemID = 78869 }, -- Crown of the Corrupted Conqueror
	["78870"] = { itemID = 78870 }, -- Crown of the Corrupted Protector
	["78871"] = { itemID = 78871 }, -- Leggings of the Corrupted Vanquisher
	["78872"] = { itemID = 78872 }, -- Leggings of the Corrupted Conqueror
	["78873"] = { itemID = 78873 }, -- Leggings of the Corrupted Protector
	["78874"] = { itemID = 78874 }, -- Shoulders of the Corrupted Vanquisher
	["78875"] = { itemID = 78875 }, -- Shoulders of the Corrupted Conqueror
	["78876"] = { itemID = 78876 }, -- Shoulders of the Corrupted Protector
	-- currencies
	["WrithingEssence"]	= { currencyID = 1501 }, -- Writhing Essence, added in 7.3.0
	["ArgusWaystone"]	= { currencyID = 1506 }, -- Argus Waystone, added in 7.3.0
	["VeiledArgunite"]	= { currencyID = 1508 }, -- Veiled Argunite, added in 7.3.0
	["echoofbattle"] 	= { currencyID = 1356 }, -- added in 7.2.0, LegionPVPTier1
	["echoofdomination"] = { currencyID = 1357 }, -- added in 7.2.0, LegionPVPTier4
	["brawlergold"] 	= {currencyID = 1299}, -- Brawler's Gold, Added in patch 7.1.5.23360
	["nethershard"] 	= { currencyID = 1226 },
	["orderresources"] 	= { currencyID = 1220 },
	["apexis"] 			= { currencyID = 823 },
	["artifactfragment"] 	= { currencyID = 944 },
	["bloodycoin"] 		= { currencyID = 789 },
	["championsseal"] 	= { currencyID = 241 },
	["conquest"] 		= { currencyID = 390 }, -- has been removed since 7.0.3
	["honor"] 			= { currencyID = 392 }, -- has been removed since 7.0.3
	["darkmoon"] 		= { currencyID = 515 },
	["eldercharm"] 		= { currencyID = 697 },
	["timelesscoin"] 	= { currencyID = 777 },
	["tolbarad"] 		= { currencyID = 391 },
	["worldtree"] 		= { currencyID = 416 },
	["valor"] 			= {currencyID = 1191},
	["timewarped"] 		= {currencyID = 1166}, -- Timewarped Badge
	-- others
	["money"] 		= { func = GetCoinTextureString },
}

local Cache = {}
setmetatable(Cache, {__mode = "kv"})

local function SetContentInfo(frame, typ, value, delimiter)
	value = value or 0
	delimiter = delimiter or STRING_DELIMITER_END

	if PRICE_INFO[typ] then
		if PRICE_INFO[typ].func then
			frame:AddText(PRICE_INFO[typ].func(value)..delimiter)
		elseif PRICE_INFO[typ].icon then
			frame:AddIcon(PRICE_INFO[typ].icon, 12)
			frame:AddText(value..delimiter)
		elseif PRICE_INFO[typ].currencyID then
			local name, currentAmount, texture = GetCurrencyInfo(PRICE_INFO[typ].currencyID) --name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity
			frame:AddIcon(texture, 12)
			frame:AddText(currentAmount >= tonumber(value) and STRING_GREEN..value..delimiter or STRING_RED..value..delimiter)
		elseif PRICE_INFO[typ].itemID then
			PRICE_INFO[typ].icon = GetItemIcon(PRICE_INFO[typ].itemID)
			SetContentInfo(frame, typ, value, delimiter)
		end
	elseif tonumber(typ) then
		frame:AddIcon(GetItemIcon(typ), 12)
		frame:AddText(value..delimiter)
	end
end

function Price.OnSet(mainButton, descFrame)
	if FIRST_RUN then
		for k,v in pairs(PRICE_INFO) do
			if v.itemID then
				local itemName = GetItemInfo(v.itemID)
				v.icon = GetItemIcon(v.itemID)
				v.name = itemName
			end
		end
		FIRST_RUN = false
	end
	local typeVal = mainButton.__atlaslootinfo.extraType[2]
	local info
	if Cache[typeVal] then
		info = Cache[typeVal]
	else
		info = { str_split(STRING_SPLIT_OR, typeVal) }
		if info[2] then
			for i = 1, #info do
				info[i] = { str_split(STRING_SPLIT_AND, info[i]) }
			end
		else
			info = { str_split(STRING_SPLIT_AND, info[1]) }
		end
		Cache[typeVal] = info
	end

	if type(info[1]) == STRING_TABLE then
		for i = 1, #info do
			for j = 1, #info[i], 2 do
				SetContentInfo(descFrame, info[i][j], info[i][j+1], j+1 == #info[i] and (#info == i and STRING_DELIMITER_END or STRING_DELIMITER_OR) or STRING_DELIMITER_AND)
			end
		end
	else
		for i = 1, #info, 2 do
			SetContentInfo(descFrame, info[i], info[i+1], i+1 == #info and STRING_DELIMITER_END or STRING_DELIMITER_AND)
		end
	end

	descFrame.info = info
end

-- ##########
-- OnEnter
-- ##########

local TT_ICON_AND_NAME = "|T%s:16|t %s"
local TT_HAVE_AND_NEED_GREEN = STRING_GREEN.."%d / %d"
local TT_HAVE_AND_NEED_RED = STRING_RED.."%d / %d"

local function SetTooltip(tooltip, typ, value)
	value = tonumber(value) or 0

	if PRICE_INFO[typ] then
		if PRICE_INFO[typ].func then
			tooltip:AddLine(PRICE_INFO[typ].func(value))
		--elseif PRICE_INFO[typ].icon then
		--	tooltip:AddLine(TT_ICON_AND_NAME:format(PRICE_INFO[typ].icon, PRICE_INFO[typ].name or ""))
		--	tooltip:AddLine(TT_HAVE_AND_NEED_GREEN:format(value))
		elseif PRICE_INFO[typ].currencyID then
			local name, currentAmount, texture = GetCurrencyInfo(PRICE_INFO[typ].currencyID) --name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity
			if texture then
				tooltip:AddLine(TT_ICON_AND_NAME:format(texture, name or ""))
			end
			tooltip:AddLine(currentAmount >= value and TT_HAVE_AND_NEED_GREEN:format(currentAmount, value) or  TT_HAVE_AND_NEED_RED:format(currentAmount, value))
		elseif PRICE_INFO[typ].itemID then
			local itemName = GetItemInfo(PRICE_INFO[typ].itemID)
			tooltip:AddLine(TT_ICON_AND_NAME:format(GetItemIcon(PRICE_INFO[typ].itemID), GetItemInfo(PRICE_INFO[typ].itemID) or ""))
			local count = GetItemCount(PRICE_INFO[typ].itemID, true)
			tooltip:AddLine(count >= value and TT_HAVE_AND_NEED_GREEN:format(count, value) or  TT_HAVE_AND_NEED_RED:format(count, value))
		end
	elseif tonumber(typ) then
		local itemName = GetItemInfo(typ)
		tooltip:AddLine(TT_ICON_AND_NAME:format(GetItemIcon(typ), GetItemInfo(typ) or ""))
		local count = GetItemCount(typ, true)
		tooltip:AddLine(count >= value and TT_HAVE_AND_NEED_GREEN:format(count, value) or  TT_HAVE_AND_NEED_RED:format(count, value))
	end
end

function Price.OnEnter(descFrame, tooltip)
	if not descFrame.info then return end
	local info = descFrame.info
	if type(info[1]) == STRING_TABLE then
		for i = 1, #info do
			if i > 1 then
				tooltip:AddLine(STRING_DELIMITER_TT_OR)
			end
			for j = 1, #info[i], 2 do
				SetTooltip(tooltip, info[i][j], info[i][j+1])
			end
		end
	else
		for i = 1, #info, 2 do
			SetTooltip(tooltip, info[i], info[i+1])
		end
	end
end
