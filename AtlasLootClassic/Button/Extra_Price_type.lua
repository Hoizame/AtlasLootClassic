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
	["burningblossom"] 	= { itemID = 23247 }, -- Burning Blossom
	["ancestrycoin"] 	= { itemID = 21100 }, -- Coin of Ancestry
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
