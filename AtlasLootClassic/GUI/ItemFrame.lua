local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local ItemDB = AtlasLoot.ItemDB
local ItemFrame = {}
AtlasLoot.GUI.ItemFrame = ItemFrame
local AL = AtlasLoot.Locales

-- lua
local type, tostring = type, tostring
local floor = math.floor
local format, sfind, slower = string.format, string.find, string.lower

-- WoW
local GetTime = GetTime

local LastRefresh = GetTime()
local PAGE_NAME_PAGE = "%s [%d/%d]"
local PAGE_NAME_DIFF = "%s (%s)"
local PAGE_NAME_DIFF_PAGE = "%s (%s) [%d/%d]"
local FILTER_ALPHA = 0.33

function ItemFrame:Create()
	if self.frame then return self.frame end
	local frameName = "AtlasLoot_GUI-ItemFrame"

	self.frame = CreateFrame("FRAME", frameName, GUI.frame)
	local frame = self.frame
	frame:ClearAllPoints()
	frame:SetParent(GUI.frame)
	frame:SetPoint("TOPLEFT", GUI.frame.contentFrame.itemBG)
	frame:SetWidth(560)
	frame:SetHeight(450)
	--frame:Hide()
	-- create all item buttons
	frame.Refresh = ItemFrame.Refresh
	frame.Clear = ItemFrame.Clear
	frame.OnSearch = ItemFrame.OnSearch
	frame.OnSearchClear = ItemFrame.OnSearchClear
	frame.OnSearchTextChanged = ItemFrame.OnSearchTextChanged
	frame.OnClassFilterUpdate = ItemFrame.OnClassFilterUpdate
	frame.OnTransMogUpdate = ItemFrame.OnTransMogUpdate

	frame.ItemButtons = {}
	for i=1,30 do
		frame.ItemButtons[i] = AtlasLoot.Button:Create()
		frame.ItemButtons[i]:ClearAllPoints()
		frame.ItemButtons[i]:SetParent(frame)
		if i == 1 then
			frame.ItemButtons[i]:SetPoint("TOPLEFT", frame, "TOPLEFT", 5)
		elseif i == 16 then
			frame.ItemButtons[i]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		else
			frame.ItemButtons[i]:SetPoint("TOPLEFT", frame.ItemButtons[i-1], "BOTTOMLEFT", 0, -2)
		end
	end
	return self.frame
end

function ItemFrame:Show(noRefresh)
	if not ItemFrame.frame:IsShown() or GUI.frame.contentFrame.shownFrame ~= ItemFrame.frame then
		GUI:HideContentFrame()
		ItemFrame.frame:Show()
		GUI.frame.contentFrame.shownFrame = ItemFrame.frame
		if not noRefresh then
			ItemFrame:Refresh()
		end
	end
end

function ItemFrame:ClearItems()
	for i=1,30 do
		self.frame.ItemButtons[i]:Clear()
		self.frame.ItemButtons[i]:Hide()
	end
end

function ItemFrame.UpdateFilter()
	local Reset = true
	if AtlasLoot.db.GUI.classFilter then
		-- NYI
		-- Reset = false
	end
	if ItemFrame.SearchString then
		local searchString = ItemFrame.SearchString
		for i=1,30 do
			local button = ItemFrame.frame.ItemButtons[i]
			local text = button.RawName or button.name:GetText()
			if text and not sfind(slower(text), searchString, 1, true) then
				button:SetAlpha(FILTER_ALPHA)
			else
				button:SetAlpha(1.0)
			end
		end
		Reset = false
	end
	if Reset then
		for i=1,30 do
			ItemFrame.frame.ItemButtons[i]:SetAlpha(1)
		end
	end
end

function ItemFrame.OnClassFilterUpdate(filterTab)
	--[[ NEED REWORK
	if AtlasLoot.db.GUI.classFilter and GUI.__EJData then
		if not filterTab then
			AtlasLoot.EncounterJournal:SetLootQuery(GUI.__EJData[1], GUI.__EJData[2], ItemFrame.CurDiff, ItemFrame.CurTier, nil, GUI.frame.contentFrame.clasFilterButton.selectedPlayerSpecID, ItemFrame.OnClassFilterUpdate )
		else
			local button
			for i = 1,30 do
				button = ItemFrame.frame.ItemButtons[i]
				if button and button.__atlaslootinfo and not button.__atlaslootinfo.filterIgnore and button.__atlaslootinfo.type and button.__atlaslootinfo.type[1] == "Item" then
					if button.ItemID and filterTab[button.ItemID] then
						button:SetAlpha(1)
					else
						button:SetAlpha(0.33)
					end
				else
					button:SetAlpha(1)
				end
			end
		end
	else
		for i=1,30 do
			ItemFrame.frame.ItemButtons[i]:SetAlpha(1)
		end
	end
	]]--
end

function ItemFrame.OnSearch(msg)
	ItemFrame.SearchString = ( not msg or msg == "" ) and nil or slower(msg)
	ItemFrame.UpdateFilter()
end

function ItemFrame.OnSearchClear()
	ItemFrame.SearchString = nil
	ItemFrame.UpdateFilter()
end

function ItemFrame.OnSearchTextChanged(msg)
	ItemFrame.SearchString = ( not msg or msg == "" ) and nil or slower(msg)
	ItemFrame.UpdateFilter()
end

function ItemFrame:Refresh(skipProtect)
	-- small spam protection
	if not skipProtect and GetTime() - LastRefresh < 0.1 then return end
	LastRefresh = GetTime()

	ItemFrame:ClearItems()
	AtlasLoot.db.GUI.selected[5] = AtlasLoot.db.GUI.selected[5] or 0
	ItemFrame.nextPage = nil
	local page = AtlasLoot.db.GUI.selected[5] * 100 -- Page number for first items on a page are <1, 101, 201, 301, 401, ...>
	local items, tableType, diffData = ItemDB:GetItemTable(AtlasLoot.db.GUI.selected[1], AtlasLoot.db.GUI.selected[2], AtlasLoot.db.GUI.selected[3], AtlasLoot.db.GUI.selected[4])
	if items then

		ItemFrame.LinkedInfo = items.__linkedInfo
		ItemFrame.CurDiff = diffData.difficultyID or 1
		ItemFrame.CurTier = diffData.tierID or 1
		-- refresh title with diff and add pagenumber if there
			if #items and items[#items] and items[#items][1] > 100 then
				if not diffData.textIsHidden then
					GUI.frame.contentFrame.title:SetText(format(PAGE_NAME_DIFF_PAGE, GUI.frame.contentFrame.title.txt, diffData.name, AtlasLoot.db.GUI.selected[5]+1, floor(items[#items][1]/100)+1))
				else
					GUI.frame.contentFrame.title:SetText(format(PAGE_NAME_PAGE, GUI.frame.contentFrame.title.txt, AtlasLoot.db.GUI.selected[5]+1, floor(items[#items][1]/100)+1))
				end
			else
				if not diffData.textIsHidden then
					GUI.frame.contentFrame.title:SetText(format(PAGE_NAME_DIFF, GUI.frame.contentFrame.title.txt or "", diffData.name or ""))
				else
					GUI.frame.contentFrame.title:SetText(GUI.frame.contentFrame.title.txt or "")
				end
			end
		if type(items) == "string" then
			GUI:ShowLoadingInfo(items, true, tableType)
			AtlasLoot.Loader:LoadModule(items, function() ItemFrame:Refresh(true) GUI.frame.contentFrame.loadingDataText:Hide() end, true)
			return
		end

		local fixItemNum = 0
		local setn,item = nil
		for i = 1,#items do
			item = items[i]
			fixItemNum = item[1] - page
			if ItemFrame.frame.ItemButtons[fixItemNum] then
				ItemFrame.frame.ItemButtons[fixItemNum]:SetDifficultyID(diffData.difficultyID)
				ItemFrame.frame.ItemButtons[fixItemNum]:SetNpcID(ItemFrame.npcID)
				ItemFrame.frame.ItemButtons[fixItemNum]:SetPreSet(diffData.preset)
				ItemFrame.frame.ItemButtons[fixItemNum]:SetContentTable(item, tableType)
				setn = true
			elseif fixItemNum > 100 then
				GUI.frame.contentFrame.nextPageButton.info = tostring(AtlasLoot.db.GUI.selected[5] + 1)
				--break
			end
		end
		-- page not found set it to first page and reset
		if not setn and AtlasLoot.db.GUI.selected[5] ~= 0 then
			AtlasLoot.db.GUI.selected[5] = 0
			ItemFrame:Refresh(true)
			return
		end
	end
	-- calc prev page
	if AtlasLoot.db.GUI.selected[5] - 1 >= 0 then
		GUI.frame.contentFrame.prevPageButton.info = tostring(AtlasLoot.db.GUI.selected[5] - 1)
	else
		--[[	this must be fixed later ... Check for pages
		if AtlasLoot.db.GUI.selected[3] - 1 > 0 then
			items, tableType = ItemDB:GetItemTable(AtlasLoot.db.GUI.selected[1], AtlasLoot.db.GUI.selected[2], AtlasLoot.db.GUI.selected[3]-1, AtlasLoot.db.GUI.selected[4])
			if items and #items > 0 and floor(items[#items][1]/100) > 0 then
				GUI.frame.contentFrame.prevPageButton.info = { AtlasLoot.db.GUI.selected[3]-1, floor(items[#items][1]/100) }
			end
		end
		]]--
	end
	ItemFrame.UpdateFilter()
end

function ItemFrame.Clear()
	ItemFrame:ClearItems()
	ItemFrame.frame:Hide()
	GUI.frame.contentFrame.shownFrame = nil
end
