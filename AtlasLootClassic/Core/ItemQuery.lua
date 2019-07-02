local AtlasLoot = _G.AtlasLoot
local ItemQuery = {}
AtlasLoot.ItemQuery = ItemQuery

-- lua
local pairs = pairs

-- WoW
local CreateFrame = CreateFrame
local GetItemInfo, GetItemStats = GetItemInfo, GetItemStats
local GetTime = GetTime

-- //\\
local SPAM_PROTECT = 0.5


local Proto = {}


function Proto.OnEvent(frame, event)
	if event == "GET_ITEM_INFO_RECEIVED" then	-- arg1 is itemID maybe change this later..
		local self = frame.obj
		for i = 1, self.NumItemInfoItems do
			if self.itemInfoList[i] and GetItemInfo(self.itemInfoList[i]) then
				self.itemInfoList[i] = nil
				self.NumItemInfoItemsFound = self.NumItemInfoItemsFound + 1
			end
		end
		if self.NumItemInfoItems == self.NumItemInfoItemsFound then
			self.itemInfoList = nil
			self.NumItemInfoItems = nil
			self.NumItemInfoItemsFound = nil
			if self.OnItemInfoFinish then
				self.OnItemInfoFinish()
				self.OnItemInfoFinish = nil
			end
			frame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
		end
	end
end

function Proto.OnUpdate(frame)
	if not frame.lastUpdate or ( GetTime() - frame.lastUpdate > SPAM_PROTECT) then
		local self = frame.obj
		for i = 1, self.NumItemStatsItems do
			if self.itemStatsList[i] and GetItemStats(self.itemStatsList[i]) then
				self.itemStatsList[i] = nil
				self.NumItemStatsItemsFound = self.NumItemStatsItemsFound + 1
			end
		end
		if self.NumItemStatsItems == self.NumItemStatsItemsFound then
			self.itemStatsList = nil
			self.NumItemStatsItems = nil
			self.NumItemStatsItemsFound = nil

			if self.OnItemStatsFinish then
				self.OnItemStatsFinish()
				self.OnItemStatsFinish = nil
			end
			frame:SetScript("OnUpdate", nil)
		end
		frame.lastUpdate = GetTime()
	end
end

function Proto:Wipe()
	-- itemInfo
	self.itemInfoList = nil
	self.NumItemInfoItems = nil
	self.NumItemInfoItemsFound = nil
	self.OnItemInfoFinish = nil
	self.frame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")

	-- itemStats
	self.itemStatsList = nil
	self.NumItemStatsItems = nil
	self.NumItemStatsItemsFound = nil
	self.OnItemStatsFinish = nil
	self.frame:SetScript("OnUpdate", nil)
end

-- ( { item1, item2, item3 }, function() print("yay all items found") end )
function Proto:AddItemInfoList(list, onFinishFunc)
	if not list then return end
	-- copy list
	self.itemInfoList = {}
	for i = 1, #list do
		self.itemInfoList[i] = list[i]
	end
	self.NumItemInfoItems = #list
	self.NumItemInfoItemsFound = 0
	self.OnItemInfoFinish = onFinishFunc
	-- fist call maybe all items are cached
	self.OnEvent(self.frame, "GET_ITEM_INFO_RECEIVED")
	if self.itemInfoList then
		self.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	end
end

function Proto:AddItemStatsList(list, onFinishFunc)
	if not list then return end
	self.itemStatsList = {}
	for i = 1, #list do
		self.itemStatsList[i] = "item:"..list[i]
	end
	self.NumItemStatsItems = #list
	self.NumItemStatsItemsFound = 0
	self.OnItemStatsFinish = onFinishFunc
	-- fist call maybe all items are cached
	self.OnUpdate(self.frame)
	if self.itemStatsList then
		self.frame:SetScript("OnUpdate", self.OnUpdate)
	end
end

function ItemQuery:Create(tab)
	tab = tab or {}

	-- Add protos
	for k,v in pairs(Proto) do
		tab[k] = v
	end


	tab.frame = CreateFrame("FRAME")
	tab.frame.obj = tab
	tab.frame:SetScript("OnEvent", tab.OnEvent)

	return tab
end
