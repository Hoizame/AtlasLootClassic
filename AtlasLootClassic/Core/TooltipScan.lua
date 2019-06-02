local _G = _G
local AtlasLoot = _G.AtlasLoot
local TooltipScan = {}
AtlasLoot.TooltipScan = TooltipScan

-- lua
local match, find = string.match, string.find
local pairs, tab_remove = pairs, table.remove

-- WoW
local GetSpellLink = GetSpellLink
local C_Timer_After = C_Timer.After

local cache = {}
setmetatable(cache, {__mode = "kv"})

local AtlasLootScanTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootScanTooltip", nil, "GameTooltipTemplate")
AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")

function TooltipScan.GetTradeskillLink(tradeskillID)
	if not tradeskillID then return end
	if cache[tradeskillID] then 
		return cache[tradeskillID][1], cache[tradeskillID][2] 
	end
	local TradeskillLink = nil
	local TradeskillName = nil
	AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootScanTooltip:ClearLines()
	AtlasLootScanTooltip:SetHyperlink("enchant:"..tradeskillID)
	AtlasLootScanTooltip:Show()
	local text = _G["AtlasLootScanTooltipTextLeft1"]:GetText()
	if text and find(text, ":") then
		TradeskillLink = "|cffffd000|Henchant:"..tradeskillID.."|h["..text.."]|h|r"
		TradeskillName = match(text, "(%w+):")
	else
		TradeskillLink = GetSpellLink(tradeskillID)
	end
	AtlasLootScanTooltip:Hide()
	cache[tradeskillID] = {TradeskillLink, TradeskillName}
	return TradeskillLink, TradeskillName
end

-------------------------------

local AtlasLootQueryTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootQueryTooltip", nil, "GameTooltipTemplate")
AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_TOP")

local queryList = {}
local queryListByID = {}
local queryCacheMT = {__mode = "kv"}
local queryCache = { "quest" }
for i = 1, #queryCache do
	queryCache[ queryCache[i] ] = setmetatable({}, queryCacheMT)
end

local function SetNextQuery()
	if AtlasLootQueryTooltip.curQuery then return end
	local nextQuery = next(queryList)
	if nextQuery then
		queryList[ nextQuery ] = nil
		nextQuery[1](nextQuery[2], nextQuery[3], nextQuery[4], nextQuery)
	end
end

local function OnTooltipSetQuest(self)
	queryCache.quest[self.questID] = queryCache.quest[self.questID] or _G["AtlasLootQueryTooltipTextLeft1"]:GetText()
	self.onGetFunc(queryCache.quest[self.questID], self.arg1, self.curQuery)
	self.onGetFunc = nil
	self.questID = nil
	self.arg1 = nil
	self.curQuery = nil
	self:SetScript("OnTooltipSetQuest", nil)
	self:Hide()
	-- give the query a little bit time and it works perfect for more than 1 query :)
	C_Timer_After(0.05, SetNextQuery)
end
AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", OnTooltipSetQuest)

-- /dump AtlasLoot.TooltipScan.GetQuestName(5090, print)
function TooltipScan.GetQuestName(questID, onGetFunc, arg1, preSetQuery)
	if not questID then return end
	if queryCache.quest[questID] then 
		onGetFunc( queryCache.quest[questID], arg1 )
		AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", nil)
		AtlasLootQueryTooltip.onGetFunc = nil
		AtlasLootQueryTooltip.questID = nil
		AtlasLootQueryTooltip.arg1 = nil
		AtlasLootQueryTooltip.curQuery = nil
		AtlasLootQueryTooltip:Hide()
		SetNextQuery()
		return
	end
	preSetQuery = preSetQuery or {TooltipScan.GetQuestName, questID, onGetFunc, arg1}
	if AtlasLootQueryTooltip.onGetFunc then
		queryList[preSetQuery] = true
		return preSetQuery
	end
	--AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootQueryTooltip:ClearLines()
	AtlasLootQueryTooltip.onGetFunc = onGetFunc
	AtlasLootQueryTooltip.questID = questID
	AtlasLootQueryTooltip.arg1 = arg1
	AtlasLootQueryTooltip.curQuery = preSetQuery
	AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", OnTooltipSetQuest)
	AtlasLootQueryTooltip:Show()
	AtlasLootQueryTooltip:SetHyperlink("quest:"..questID)
	return preSetQuery
end

function TooltipScan.Remove(listEntry)
	if AtlasLootQueryTooltip.curQuery and AtlasLootQueryTooltip.curQuery == listEntry then
		AtlasLootQueryTooltip.onGetFunc = nil
		AtlasLootQueryTooltip.questID = nil
		AtlasLootQueryTooltip.arg1 = nil
		AtlasLootQueryTooltip.curQuery = nil
		AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", nil)
		AtlasLootQueryTooltip:Hide()
		SetNextQuery()
	else
		queryList[listEntry] = nil
	end
end

function TooltipScan.Clear()
	wipe(queryList)
end
