local ALName, ALPrivate = ...

local _G = _G
local AtlasLoot = _G.AtlasLoot
local Tooltip = {}
AtlasLoot.Tooltip = Tooltip
local AL = AtlasLoot.Locales

-- lua
local pairs = _G.pairs
local type = _G.type

-- WoW
local UnitGUID = _G.UnitGUID

local STANDART_TOOLTIP = "AtlasLootTooltip"
local COLOR = "|cFF00ccff%s|r"
local GOLD, SILVER, COPPER = "|T"..ALPrivate.COIN_TEXTURE.GOLD..":0|t "..COLOR, "|T"..ALPrivate.COIN_TEXTURE.SILVER..":0|t "..COLOR, "|T"..ALPrivate.COIN_TEXTURE.COPPER..":0|t "..COLOR

local AtlasLootTooltip = CreateFrame("GameTooltip", "AtlasLootTooltip", UIParent, "GameTooltipTemplate")
AtlasLootTooltip:Hide()
AtlasLootTooltip.shoppingTooltips = {ShoppingTooltip1, ShoppingTooltip2}

local TooltipList = {
	"GameTooltip",
	"AtlasLootTooltip",
}


function Tooltip.GetTooltip()
	return AtlasLoot.db.Tooltip.useGameTooltip and _G["GameTooltip"] or ( _G[AtlasLoot.db.Tooltip.tooltip or STANDART_TOOLTIP] or AtlasLootTooltip )
end

function Tooltip:AddTooltipSource(src)
	TooltipList[#TooltipList+1] = src
end

-- Hook
local HookInitDone = false
local HookTooltipList = {
    "AtlasLootTooltip",
    "GameTooltip",
    "ItemRefTooltip",
    "ShoppingTooltip1",
    "ShoppingTooltip2"
}
local HookedTooltipRegister = {}
local FunctionRegister = {}

local function RefreshHooks()
	for i = 1, #HookTooltipList do
		local tt = HookTooltipList[i]
		if not HookedTooltipRegister[tt] then
			HookedTooltipRegister[tt] = {}
		end
		local register = HookedTooltipRegister[tt]
		for script, scriptFunc in pairs(FunctionRegister) do
			if not register[script] then
				register[script] = {}
			end
			for func, state in pairs(scriptFunc) do
				if state and not register[script][func] then
					local hookTT = type(tt) == "string" and _G[tt] or tt
					if hookTT.HookScript then
						hookTT:HookScript(script, func)
						register[script][func] = true
					end
				end
			end
		end
	end
end

-- tt = "GameTooltip" or { "tt1", "tt2", myLocalTT }
function Tooltip:AddTooltipSource(tt, notRefresh)
	if not tt then return end
	if type(tt) == "table" then
		for i = 1, #tt do
			self:AddTooltipSource(tt[i], true)
		end
		if not notRefresh then
			RefreshHooks()
		end
	else
		local count = #HookTooltipList
		for i = 1, #HookTooltipList do
			if HookTooltipList[i] == tt then return end
		end
		HookTooltipList[count + 1] = tt
		if not notRefresh then
			RefreshHooks()
		end
	end
end

function Tooltip:AddHookFunction(script, func)
	if type(func) ~= "function" or not script then return end
	if not FunctionRegister[script] then
		FunctionRegister[script] = {}
	end
	if not FunctionRegister[script][func] then
		FunctionRegister[script][func] = true
		if HookInitDone then
			RefreshHooks()
		end
	end
end

local function HookInit()
	RefreshHooks()
	HookInitDone = true
end
AtlasLoot:AddInitFunc(HookInit)

local PLAYER_GUID_REGISTER = {
	["Player-4463-003F795C"] = format(GOLD, "AtlasLoot Author"),
	["Player-4466-015209F9"] = format(GOLD, "AtlasLoot Author"),
	["Player-4455-00D28DDC"] = format(SILVER, "AtlasLoot Friend"),
	["Player-4463-00A5D43D"] = format(SILVER, "AtlasLoot Friend"),
	["Player-4476-0054EED9"] = format(COPPER, "aka god of shadow"),
	["Player-4476-0166DB51"] = format(COPPER, "god of shadow"),
	["Player-4466-00B9FEDF"] = format(SILVER, "AtlasLoot Friend"), --K
	["player-4466-00BB4DD8"] = format(SILVER, "AtlasLoot Friend"), --D
	["Player-4463-00784DB2"] = format("|T132800:0|t "..COLOR, "AtlasLoot Friend"),
	--["Player-4463-00C0F307"]
}

local function AddText(self)
	if self:IsForbidden() then return end
	local name, target = self:GetUnit()
	if not target then return end
	local guid = UnitGUID(target)
	if guid and PLAYER_GUID_REGISTER[guid] then
		self:AddLine(PLAYER_GUID_REGISTER[guid])
	end
end
Tooltip:AddHookFunction("OnTooltipSetUnit", AddText)