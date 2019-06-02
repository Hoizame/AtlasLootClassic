local _G = _G
local AtlasLoot = _G.AtlasLoot
local Tooltip = {}
AtlasLoot.Tooltip = Tooltip
local AL = AtlasLoot.Locales

local STANDART_TOOLTIP = "AtlasLootTooltip"

_G["AtlasLootTooltip"].shoppingTooltips = {ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3}

local TooltipList = {
	"GameTooltip",
	"AtlasLootTooltip",
}


function Tooltip.GetTooltip()
	return _G[AtlasLoot.db.Tooltip.tooltip or STANDART_TOOLTIP] or _G[STANDART_TOOLTIP]
end

function Tooltip:AddTooltipSource(src)
	TooltipList[#TooltipList+1] = src
end

function Tooltip:Refresh()
	AtlasLoot.db.Tooltip.tooltip = AtlasLoot.db.Tooltip.useGameTooltip and "GameTooltip" or "AtlasLootTooltip"
end

