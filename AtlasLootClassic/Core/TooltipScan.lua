local _G = _G
local AtlasLoot = _G.AtlasLoot
local TooltipScan = {}
AtlasLoot.TooltipScan = TooltipScan

local match, find = string.match, string.find
local GetSpellLink = GetSpellLink

local cache = {}
setmetatable(cache, {__mode = "kv"})

local AtlasLootScanTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootScanTooltip", nil, "GameTooltipTemplate")
AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")

function TooltipScan.GetTradeskillLink(tradeskillID)
	if not tradeskillID then return end
	if cache[tradeskillID] then
		return cache[tradeskillID][1], cache[tradeskillID][2]
	end
	local TradeskillLink
	local TradeskillName
	AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootScanTooltip:ClearLines()
	AtlasLootScanTooltip:SetHyperlink("enchant:"..tradeskillID)
	AtlasLootScanTooltip:Show()
	local line = _G["AtlasLootScanTooltipTextLeft1"]
	local text = line and line:GetText()
	if text and find(text, ":") then
		TradeskillLink = "|cffffd000|Henchant:"..tradeskillID.."|h["..text.."]|h|r"
		TradeskillName = match(text, "(%w+):")
	elseif GetSpellLink then
		TradeskillLink = GetSpellLink(tradeskillID)
	end
	AtlasLootScanTooltip:Hide()
	cache[tradeskillID] = {TradeskillLink, TradeskillName}
	return TradeskillLink, TradeskillName
end

local questCache = setmetatable({}, {__mode = "kv"})
local AtlasLootQueryTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootQueryTooltip", nil, "GameTooltipTemplate")
AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")

local function ReadQuestName(questID)
	if questCache[questID] then return questCache[questID] end
	local name
	if C_QuestLog and type(C_QuestLog.GetTitleForQuestID) == "function" then
		name = C_QuestLog.GetTitleForQuestID(questID)
	end
	if not name or name == "" then
		AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		AtlasLootQueryTooltip:ClearLines()
		local ok = pcall(AtlasLootQueryTooltip.SetHyperlink, AtlasLootQueryTooltip, "quest:"..questID)
		if ok then
			local line = _G["AtlasLootQueryTooltipTextLeft1"]
			local text = line and line:GetText()
			if text and text ~= "" then name = text end
		end
		AtlasLootQueryTooltip:Hide()
	end
	if name and name ~= "" then questCache[questID] = name end
	return name
end

function TooltipScan.GetQuestName(questID, onGetFunc, arg1, preSetQuery)
	if not questID then return end
	local name = ReadQuestName(questID)
	if type(onGetFunc) == "function" then
		onGetFunc(name or ((QUESTS_LABEL or "Quest").." "..questID), arg1, preSetQuery)
	end
	return preSetQuery
end

function TooltipScan.Remove(listEntry)
end

function TooltipScan.Clear()
end
