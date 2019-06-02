local _G = _G
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local SVF = {}
AtlasLoot.GUI.SetViewFrame = SVF
local AL = AtlasLoot.Locales

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

--lua
local type = type
local next, pairs = next, pairs
local wipe, tab_sort = table.wipe, table.sort

-- WOW
local CreateFrame = CreateFrame
local GetItemStats = GetItemStats

-- AtlasLoot
local ItemQuery = AtlasLoot.ItemQuery:Create()
local getFrame = AtlasLoot.GUI.GetFrameByType
local delFrame = AtlasLoot.GUI.FreeFrameByType
local GetTextFrameWithBackground = AtlasLoot.GUI.CreateTextWithBg

-- Saved variables
local db

-- //\\
local SVF_FRAME_NAME = "AtlasLoot-SetViewFrame"
local SVF_FRAME_WIDTH = 800
local SVF_FRAME_HEIGHT = 400
local BACKDROP_DATA = {bgFile = "Interface/Tooltips/UI-Tooltip-Background"}

local MODEL_FRAME_WIDTH = 220
local MODEL_FRAME_HEIGHT = 300

local CONTAINER_MAX_NUM_ITEMS = nil
local CONTAINER_FRAME_WIDTH = nil
local CONTAINER_FRAME_HEIGHT = nil
local CONTAINER_ITEM_PLACE_HEIGHT = nil

local CONTAINER_ITEM_TEXT_BG_COLOR = { r = 1, g = 1, b = 1, a = 1 }
local CONTAINER_ITEM_TEXT_COLOR = { r = 1, g = 0.82, b = 0, a = 1 }
local CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR = { r = 0, g = 0.86, b = 1, a = 1 }
local CONTAINER_TOP_BOTTOM_TEXT_COLOR = { r = 1, g = 1, b = 1, a = 1 }
local CONTAINER_ITEM_MIN_HEIGHT = 20
local CONTAINER_ITEM_MAX_HEIGHT = 35

-- "hide" 				= 	hide the stat
-- function(statValue)	= 	returns new value for this
local STATS_FILTER = {
	["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = "hide",
	["EMPTY_SOCKET"] = "hide",
	["EMPTY_SOCKET_BLUE"] = "hide",
	["EMPTY_SOCKET_COGWHEEL"] = "hide",
	["EMPTY_SOCKET_HYDRAULIC"] = "hide",
	["EMPTY_SOCKET_META"] = "hide",
	["EMPTY_SOCKET_NO_COLOR"] = "hide",
	["EMPTY_SOCKET_PRISMATIC"] = "hide",
	["EMPTY_SOCKET_RED"] = "hide",
	["EMPTY_SOCKET_YELLOW"] = "hide",
}

local CurrentData = {}

-- INIT
function SVF.Init()
	db = AtlasLoot.db.SetViewFrame
	--AtlasLoot:Teest()
	AtlasLoot.SlashCommands:AddResetFunction(SVF.ResetFrames, "frames", "svf")
end
AtlasLoot:AddInitFunc(SVF.Init)

local function SetTextForFrame(textFrame, data)
	if type(data) == "table" then
		textFrame:SetText(data[1])
		textFrame:SetToolTip(data[2], data[3])
	else
		textFrame:SetText(data)
		textFrame:SetToolTip(nil)
	end
end

-- TEXT
-- content = { "hello1", "hello2", "hello3" }
-- content = { { title, tooltip_line_1, tooltip_line_2 }, { title2, tooltip_line_1, tooltip_line_2 } )
local function CreateTextColumn(content, parFrame, width, height, pointInParFrame, bgColor, textColor)
	if not content or not parFrame then return end
	bgColor = bgColor or CONTAINER_ITEM_TEXT_BG_COLOR
	textColor = textColor or CONTAINER_ITEM_TEXT_COLOR
	if type(content) == "table" then
		-- calc the size of the column
		local numFrames = #content
		local textHeight = height or parFrame:GetHeight()
		local textWidth = ( ( (width or parFrame:GetWidth()) ) / numFrames ) - 2
		-- print(width or parFrame:GetWidth(), numFrames, pointInParFrame and pointInParFrame[4] or 2, textWidth )
		-- create text frames
		local text
		for i = 1, #content do
			text = GetTextFrameWithBackground(parFrame,  textWidth, textHeight, bgColor, textColor)
			text.set_bgColor = bgColor
			text.set_textColor = textColor
			if i == 1 then
				if pointInParFrame then
					text:SetPoint(pointInParFrame[1], pointInParFrame[2], pointInParFrame[3], pointInParFrame[4], pointInParFrame[5])
				else
					text:SetPoint("LEFT", parFrame, "LEFT", 2, 0)
				end
			else
				text:SetPoint("LEFT", parFrame.content[i-1], "RIGHT", 2, 0)
			end
			SetTextForFrame(text, content[i])
			text:Show()
			parFrame.content[i] = text
		end
	else -- only 1 entry
		width = width or parFrame:GetWidth()
		local text = GetTextFrameWithBackground(parFrame, (pointInParFrame and pointInParFrame[4]) and width-pointInParFrame[4] or width-2, height or parFrame:GetHeight(), bgColor, textColor)
		if pointInParFrame then
			text:SetPoint(pointInParFrame[1], pointInParFrame[2], pointInParFrame[3], pointInParFrame[4], pointInParFrame[5])
		else
			text:SetPoint("LEFT", parFrame, "LEFT", 2, 0)
		end
		SetTextForFrame(text, content)
		text:Show()
		text.set_bgColor = bgColor
		text.set_textColor = textColor
		parFrame.content[1] = text
	end
end

local function CreatePrevNextFrames(parent, parentTable)
	parentTable = parentTable or parent
	parentTable.prev = CreateFrame("Button")
	parentTable.prev:SetParent(parent)
	parentTable.prev:SetPoint("LEFT", parent)
	parentTable.prev:SetSize(24, 24)
	parentTable.prev:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	parentTable.prev:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	parentTable.prev:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
	parentTable.prev:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	--parentTable.prev:SetScript("OnClick", print)
	parentTable.prev.typ = "prev"
	
	parentTable.next = CreateFrame("Button")
	parentTable.next:SetParent(parent)
	parentTable.next:SetPoint("RIGHT", parent, "RIGHT", 3, 0)
	parentTable.next:SetSize(24, 24)
	parentTable.next:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	parentTable.next:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	parentTable.next:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	parentTable.next:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	--parentTable.next:SetScript("OnClick", print)
	parentTable.next.typ = "next"	
	
	parentTable.bg = parent:CreateTexture(nil, "BACKGROUND")
	parentTable.bg:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp")
	parentTable.bg:SetBlendMode("ADD")
	parentTable.bg:SetVertexColor(0.5, 0.5, 0.5, 0.5)
	parentTable.bg:SetPoint("LEFT", parentTable.prev, "RIGHT", -10, 0)
	parentTable.bg:SetPoint("RIGHT", parentTable.next, "LEFT", 10, 0)
	
	parentTable.text = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	parentTable.text:SetJustifyH("CENTER")
	--parentTable.text:SetText()
	parentTable.text:SetAllPoints(parentTable.bg)
end

-- ITEM LINES
local function SetItemFrameHeight(self, height)
	self:SetHeight(height)
	self.itemButton:SetWidth(height)
end

local function SetItemFrameItem(self, itemID, itemLink)
	self.itemID = itemID
	self.itemLink = type(itemLink) == "string" and itemLink or "item:"..itemID
	--self:SetContentTable({ 0, itemID}, {"Item", "Item"}, true)
	self.__atlaslootinfo.type = {}
	self:SetType("Item", {itemID = itemID, itemString = self.itemLink})
	SVF.frame.modelFrame:TryOn("item:"..itemID)
end

local function GetNextItemFrame()
	local frame = getFrame("SVF-ItemFrame")
	if not frame then
		frame = CreateFrame("Frame")
		frame:SetParent(SVF.frame.containerFrame)
		frame:SetWidth(CONTAINER_FRAME_WIDTH-10)
		--frame:SetBackdrop(BACKDROP_DATA)
		--frame:SetBackdropColor(0,1,0,1)
		AtlasLoot.Button:CreateSecOnly(frame)	
		frame.itemButton = frame.secButton
		frame.itemButton:ClearAllPoints()
		frame.itemButton:SetParent(frame)
		frame.itemButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.itemButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		frame.SetItemFrameHeight = SetItemFrameHeight
		frame.SetItem = SetItemFrameItem
		
		frame.content = {}
	end
	local frameNum = #SVF.frame.containerFrame.content
	frame:ClearAllPoints()
	if frameNum > 0 then
		frame:SetPoint("TOPLEFT", SVF.frame.containerFrame.content[frameNum], "BOTTOMLEFT", 0, -2)
	else
		frame:SetPoint("TOPLEFT", SVF.frame.containerFrame.subTopFrame, "BOTTOMLEFT", 0, -2)
	end
	frame:Show()
	
	--CreateTextColumn({ "test1", "test2", "test3"}, frame)
	
	SVF.frame.containerFrame.content[frameNum+1] = frame
	return frame
end

local function ClearItemFrames()
	for i = 1, #SVF.frame.containerFrame.content do
		local frame = SVF.frame.containerFrame.content[i]
		frame.itemID = nil
		frame.itemLink = nil
		frame:Clear()
		for j = 1, #frame.content do
			frame.content[j].set_bgColor = nil
			frame.content[j].set_textColor = nil
			frame.content[j]:Clear()
			frame.content[j] = nil
		end
		frame:Hide()
		delFrame("SVF-ItemFrame", frame)
		SVF.frame.containerFrame.content[i] = nil
	end
end

local function ClearExtraList()
	for i = 1, #SVF.frame.containerFrame.subTopFrame.content do
		SVF.frame.containerFrame.subTopFrame.content[i].set_bgColor = nil
		SVF.frame.containerFrame.subTopFrame.content[i].set_textColor = nil
		SVF.frame.containerFrame.subTopFrame.content[i]:Clear()
		SVF.frame.containerFrame.subTopFrame.content[i] = nil
	end
	for i = 1, #SVF.frame.containerFrame.bottomFrame.content do
		SVF.frame.containerFrame.bottomFrame.content[i].set_bgColor = nil
		SVF.frame.containerFrame.bottomFrame.content[i].set_textColor = nil
		SVF.frame.containerFrame.bottomFrame.content[i]:Clear()
		SVF.frame.containerFrame.bottomFrame.content[i] = nil
	end
end

local LoadExtraList
local function RefreshExtraList_ItemQueryEnd()
	LoadExtraList(CurrentData.currentContentType)
end

local function RefreshExtraList()
	ClearExtraList()
	if CurrentData.currentContentType == "stats" then
		ItemQuery:AddItemStatsList(CurrentData.itemList, RefreshExtraList_ItemQueryEnd)
	else
		LoadExtraList(CurrentData.currentContentType)
	end
end

function LoadExtraList(typ)
	if typ == "stats" then
		local list = {}			-- list of all existing stats for the items
		local itemStats = {}	-- item stats for single items
		local statSummary = {}	-- Saves a summary of all stats
		local listBottom = {}	-- the summary on the bottom
		local listTopTmp = {}	-- temporary used for the header
		local listTop = {}		-- used for the header
		local globalNames = {}	-- saves global names e.g. ( "Blue Socket" = "EMPTY_SOCKET_BLUE" )
		
		local globalTmp
		for i = 1, #SVF.frame.containerFrame.content do
			if SVF.frame.containerFrame.content[i].itemLink then
				itemStats[i] = GetItemStats(SVF.frame.containerFrame.content[i].itemLink)
				if not itemStats[i] then
					RefreshExtraList()
					return
				end
				for k,v in pairs(itemStats[i]) do
					globalTmp = _G[k]
					if STATS_FILTER[k] ~= "hide" and globalTmp then
						if not statSummary[globalTmp] then
							globalNames[globalTmp] = k
							list[ #list+1 ] = globalTmp
							statSummary[ globalTmp ] = v or 0
							listTopTmp[ globalTmp ] = { globalTmp, globalTmp }
						else
							statSummary[globalTmp] = statSummary[globalTmp] + v
						end
					end
				end
			end
		end
		tab_sort(list)
		
		-- Create Item stats and fill empty spots
		for i = 1, #SVF.frame.containerFrame.content do
			local itemStatsList = {}
			for j = 1, #list do
				local v = list[j]
				-- resort and create stats list on top
				if i == 1 then
					listTop[j] = listTopTmp[v]
					listBottom[j] = statSummary[v]
				end
				if STATS_FILTER[j] and type(STATS_FILTER[j]) == "function" then
					itemStatsList[j] = STATS_FILTER[j]( itemStats[i][ globalNames[v] ] or 0 )
				else
					itemStatsList[j] = itemStats[i][ globalNames[v] ] or 0
				end
			end
			CreateTextColumn(itemStatsList, SVF.frame.containerFrame.content[i], CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.content[i].itemButton, "RIGHT", 2, 0})
		end
		
		-- Create stats list on top
		CreateTextColumn(listTop, SVF.frame.containerFrame.subTopFrame, CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.subTopFrame, "LEFT", SVF.frame.containerFrame.subTopFrame:GetWidth()-CurrentData.textColumnWidth+2, 0}, CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR, CONTAINER_TOP_BOTTOM_TEXT_COLOR)

		-- Create summary on bottom and relocate
		SVF.frame.containerFrame.bottomFrame:SetPoint("TOPLEFT", SVF.frame.containerFrame.content[#SVF.frame.containerFrame.content], "BOTTOMLEFT", 0, -2)
		CreateTextColumn(listBottom, SVF.frame.containerFrame.bottomFrame, CurrentData.textColumnWidth, nil, {"LEFT", SVF.frame.containerFrame.bottomFrame, "LEFT", SVF.frame.containerFrame.bottomFrame:GetWidth()-CurrentData.textColumnWidth+2, 0}, CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR, CONTAINER_TOP_BOTTOM_TEXT_COLOR)
	--elseif typ == "droplocation" then
		-- curently not mutch here :(
	elseif typ == "ALText" then
		local textData = CurrentData.set:GetInfoTable(CurrentData.subSet, CurrentData.diff, CurrentData.info)
		if textData then
			for i = 1, #CurrentData.set:GetItemTable(CurrentData.subSet, CurrentData.diff) do
				local itemFrame = SVF.frame.containerFrame.content[i]
				CreateTextColumn(textData[i] or " ", itemFrame, CurrentData.textColumnWidth, nil, {"LEFT", itemFrame.itemButton, "RIGHT", 2, 0} )
			end
		else
			CurrentData.info = "stats"
			SVF:RefreshAtlasLootSet()
		end
	elseif typ ~= nil then
		-- we dont have any presets here so its only text ;)
		for i = 1, #SVF.frame.containerFrame.content do
			local itemFrame = SVF.frame.containerFrame.content[i]
			if itemFrame.itemID and CurrentData.contentTypesData[itemFrame.itemID] and CurrentData.contentTypesData[itemFrame.itemID][CurrentData.currentContentTypeID] then
				CreateTextColumn(CurrentData.contentTypesData[itemFrame.itemID][CurrentData.currentContentTypeID], itemFrame, CurrentData.textColumnWidth, nil, {"LEFT", itemFrame.itemButton, "RIGHT", 2, 0} )
			end
		end
	else
		LoadExtraList("stats")
		return
	end
end

local function SetItemList(tab, itemLinkTab)
	local frame = SVF.frame

	-- get height of the item frame
	local itemFrameHeight = ( CONTAINER_ITEM_PLACE_HEIGHT / #tab ) - 2
	if itemFrameHeight < CONTAINER_ITEM_MIN_HEIGHT then
		error("WARNING item limit is reached - "..#tab)
	elseif itemFrameHeight > CONTAINER_ITEM_MAX_HEIGHT then
		itemFrameHeight = CONTAINER_ITEM_MAX_HEIGHT
	end

	local itemFrame, textColumnWidth
	for i = 1, #tab do
		--frame.modelFrame:TryOn(tab[i])
		
		itemFrame = GetNextItemFrame()
		itemFrame:SetItemFrameHeight(itemFrameHeight)
		itemFrame:SetItem(tab[i], (itemLinkTab and itemLinkTab[i]) and itemLinkTab[i] or nil)
		
		if not textColumnWidth then
			textColumnWidth = itemFrame:GetWidth() - itemFrame:GetHeight() 
			CurrentData.textColumnWidth = textColumnWidth
		end

		--CreateTextColumn({ "test1", "test2", "test3"}, itemFrame, textColumnWidth, nil, {"LEFT", itemFrame.itemButton, "RIGHT", 2, 0})
	end
end

local function NewSet()
	SetItemList(CurrentData)
	RefreshExtraList()
end

function SVF:Clear(noHide, soft)
	self.frame.modelFrame:Reset()
	self.frame.modelFrame:Undress()
	ClearItemFrames()
	ClearExtraList()
	if not soft then
		if CurrentData and CurrentData.USERSET then
			wipe(CurrentData)
		else
			CurrentData = nil
		end
	end
	
	if not noHide then
		self.frame:Hide()
	end
end


function SVF:SetNewItemSet(setTable)
	if not self.frame then self:Create() end
	self:Clear()
	
	-- set set name
	CurrentData.name = setTable.name
	
	-- create content list
	CurrentData.contentTypes = {}
	if setTable.contentTypes then
		CurrentData.contentTypes = setTable.contentTypes
	else
		CurrentData.contentTypes = { "stats" }		-- no content given show only stats
	end
	CurrentData.currentContentType = CurrentData.contentTypes[1] or "stats"
	CurrentData.currentContentTypeID = 1
	
	-- create item list and item data
	CurrentData.itemList = {}
	CurrentData.contentTypesData = {}
	
	for i = 1, #setTable.data do
		local item = setTable.data[i]
		CurrentData.itemList[i] = item.itemID
		if item.content then
			CurrentData.contentTypesData[item.itemID] = item.content
		end
	end
	
	
	-- load all items into cache and after finish refresh the frame
	ItemQuery:AddItemInfoList(CurrentData.itemList, NewSet)
	
	self.frame:Show()
end

function SVF:SetNewItemSetNEW(setTable)
	if not self.frame then self:Create() end
	self.frame:Show()
	self:Clear(true)
	
	
	CurrentData = setTable
	
	-- get extraData from items
	for i = 1, #setTable do
		if setTable[i] == "table" then
			
		end
	end

	-- load all items into cache and after finish refresh the frame
	ItemQuery:AddItemInfoList(CurrentData, NewSet)
end

local function SetSubSet(subSet)
	
end

-- ###########################
-- AtlasLootSet
-- ###########################
local function NewAtlasLootSet()
	SetItemList(CurrentData.itemList, CurrentData.set:GetDiffTable(CurrentData.subSet, CurrentData.diff))
	RefreshExtraList()
end

local function NextPrevPageButton_OnClick(self, button)
	CurrentData.subSet = self.info
	SVF:RefreshAtlasLootSet()
end

local function NextPrevDiffButton_OnClick(self, button)
	CurrentData.diff = self.info
	SVF:RefreshAtlasLootSet()
end

local function NextPrevInfoButton_OnClick(self, button)
	CurrentData.info = self.info
	SVF:RefreshAtlasLootSet()
end

local function SetPrevNextButton_AL(frame, infoPrev, infoNext, OnClick, textFormat, text, ...)
	if infoPrev then
		frame.prev:Enable()
		frame.prev:SetScript("OnClick", OnClick)
		frame.prev.info = infoPrev
	else
		frame.prev:Disable()
	end
	frame.text:SetText(textFormat and format(textFormat, text, ...) or text)
	if infoNext then
		frame.next:Enable()
		frame.next:SetScript("OnClick", OnClick)
		frame.next.info = infoNext
	else
		frame.next:Disable()
	end
end

function SVF:RefreshAtlasLootSet()
	if not CurrentData or not CurrentData.set then return end
	self.frame:Show()
	self:Clear(true, true)
	local set = CurrentData.set
	--frame.containerFrame.topFrame 
	--frame.containerFrame.topFrameSec.itemSwitch
	--frame.containerFrame.topFrameSec.infoSwitch
	
	-- Page switcher
	local CurE, NextE, PrevE = set:GetNextPrevPage(CurrentData.subSet)
	CurrentData.subSet = CurE
	SetPrevNextButton_AL(SVF.frame.containerFrame.topFrame, PrevE, NextE, NextPrevPageButton_OnClick, "%s - %s", set.name, set[CurE].name)
	
	-- Diff Switcher
	CurE, NextE, PrevE = set:GetNextPrevDifficulty(CurrentData.subSet, CurrentData.diff)
	CurrentData.diff = CurE
	SetPrevNextButton_AL(SVF.frame.containerFrame.topFrameSec.itemSwitch, PrevE, NextE, NextPrevDiffButton_OnClick, nil, set:GetDifficultyName(CurE))
	
	-- Info Switcher
	CurE, NextE, PrevE = set:GetNextPrevInfo(CurrentData.subSet, CurrentData.diff, CurrentData.info)
	if not CurE or CurE == "stats" then --CurrentData.info == "stats" then
		CurrentData.info = CurE
		CurrentData.currentContentType = CurE
		SetPrevNextButton_AL(SVF.frame.containerFrame.topFrameSec.infoSwitch, nil, NextE, NextPrevInfoButton_OnClick, nil, AL["Stats"])
	else
		PrevE = PrevE or "stats"
		CurrentData.info = CurE
		CurrentData.currentContentType = "ALText"
		SetPrevNextButton_AL(SVF.frame.containerFrame.topFrameSec.infoSwitch, PrevE, NextE, NextPrevInfoButton_OnClick, nil, set:GetInfoName(CurE))
	end
	
	-- set item list
	CurrentData.itemList = set:GetItemTable(CurrentData.subSet, CurrentData.diff)
	ItemQuery:AddItemInfoList(CurrentData.itemList, NewAtlasLootSet)
end

-- ("set", [, addonName or "global" [,subSet]])
function SVF:SetAtlasLootItemSet(setName, addonName, subSet, diff)
	if not self.frame then self:Create() end
	local set = AtlasLoot.Data.Sets:GetSet(setName, addonName)
	if not set then return self:Clear() end
	self:Clear()
	
	CurrentData = {
		set = set,
		setName = setName,
		addonName = addonName,
		subSet = subSet,
		diff = diff,
		info = "stats",
	}
	
	SVF:RefreshAtlasLootSet()
	--ItemQuery:AddItemInfoList(CurrentData, NewAtlasLootSet)
end

--function SVF:
local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		self:StartMoving()
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

function SVF:Create()
	if self.frame then return end
	local frame = CreateFrame("Frame", SVF_FRAME_NAME)
	self.frame = frame
	frame:SetParent(UIParent)
	frame:SetSize(SVF_FRAME_WIDTH, SVF_FRAME_HEIGHT)
	frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	--frame:SetBackdropColor(0,0,0,1)
	frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForDrag("LeftButton", "RightButton")
	frame:SetScript("OnMouseDown", FrameOnDragStart)
	frame:SetScript("OnMouseUp", FrameOnDragStop)
	--frame:SetScript("OnEvent", FrameOnEvent)
	--frame:SetScript("OnShow", FrameOnShow)
	--frame:SetScript("OnHide", FrameOnHide)
	--frame:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	tinsert(UISpecialFrames, SVF_FRAME_NAME)
	
	frame.closeButton = CreateFrame("Button", SVF_FRAME_NAME.."-CloseButton", frame, "UIPanelCloseButton")
	frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 4)
	
	frame.title = GetTextFrameWithBackground(frame, 0, 0, {r=0, g=0.86, b=1}, {r=1, g=1, b=1})
	frame.title:SetPoint("TOPLEFT", frame, 5, -5)
	frame.title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -28, -20)
	frame.title.text:SetText(AL["AtlasLoot Set View"])
	
	frame.modelFrame = GUI.CreateModelFrame(true, SVF_FRAME_NAME.."-ModelFrame", frame)
	frame.modelFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -25)
	frame.modelFrame:SetSize(MODEL_FRAME_WIDTH, MODEL_FRAME_HEIGHT)
	frame.modelFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	
	frame.containerFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame")
	frame.containerFrame:ClearAllPoints()
	frame.containerFrame:SetParent(frame)
	frame.containerFrame:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -5)
	frame.containerFrame:SetPoint("TOPRIGHT", frame.modelFrame, "TOPLEFT", -5, 0)
	frame.containerFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)
	--frame.containerFrame:SetHeight(200)
	--frame.containerFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame:SetBackdropColor(0,0.86,1,1)
	frame.containerFrame.content = {}
	
	CONTAINER_FRAME_WIDTH = frame.containerFrame:GetWidth()
	CONTAINER_FRAME_HEIGHT = frame.containerFrame:GetHeight()
	
	frame.containerFrame.topFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-TopFrame")
	frame.containerFrame.topFrame:ClearAllPoints()
	frame.containerFrame.topFrame:SetParent(frame.containerFrame)
	frame.containerFrame.topFrame:SetPoint("TOPLEFT", frame.containerFrame, 5, 0)
	frame.containerFrame.topFrame:SetPoint("BOTTOMRIGHT", frame.containerFrame, "TOPRIGHT", -5, -20)
	
	CreatePrevNextFrames(frame.containerFrame.topFrame)

	frame.containerFrame.topFrameSec = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-TopFrameSec")
	frame.containerFrame.topFrameSec:ClearAllPoints()
	frame.containerFrame.topFrameSec:SetParent(frame.containerFrame)
	frame.containerFrame.topFrameSec:SetPoint("TOPLEFT", frame.containerFrame.topFrame, "BOTTOMLEFT", 0, -2)
	frame.containerFrame.topFrameSec:SetPoint("BOTTOMRIGHT", frame.containerFrame.topFrame, "BOTTOMRIGHT", 0, -22)
	frame.containerFrame.topFrameSec.itemSwitch = {}
	frame.containerFrame.topFrameSec.infoSwitch = {}
	
	CreatePrevNextFrames(frame.containerFrame.topFrameSec, frame.containerFrame.topFrameSec.itemSwitch)
	frame.containerFrame.topFrameSec.itemSwitch.next:SetPoint("RIGHT", frame.containerFrame.topFrameSec, "CENTER", -2, 0)
	
	CreatePrevNextFrames(frame.containerFrame.topFrameSec, frame.containerFrame.topFrameSec.infoSwitch)
	frame.containerFrame.topFrameSec.infoSwitch.prev:SetPoint("LEFT", frame.containerFrame.topFrameSec, "CENTER", 2, 0)
	
	frame.containerFrame.subTopFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-SubTopFrame")
	frame.containerFrame.subTopFrame:ClearAllPoints()
	frame.containerFrame.subTopFrame:SetParent(frame.containerFrame)
	frame.containerFrame.subTopFrame:SetPoint("TOPLEFT", frame.containerFrame.topFrameSec, "BOTTOMLEFT", 0, -2)
	frame.containerFrame.subTopFrame:SetPoint("BOTTOMRIGHT", frame.containerFrame.topFrameSec, "BOTTOMRIGHT", 0, -20)
	--frame.containerFrame.subTopFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame.subTopFrame:SetBackdropColor(0,0,1,1)
	frame.containerFrame.subTopFrame.content = {}
	
	frame.containerFrame.bottomFrame = CreateFrame("Frame", SVF_FRAME_NAME.."-ContainerFrame-BottomFrame")
	frame.containerFrame.bottomFrame:ClearAllPoints()
	frame.containerFrame.bottomFrame:SetParent(frame.containerFrame)
	frame.containerFrame.bottomFrame:SetPoint("CENTER")
	frame.containerFrame.bottomFrame:SetSize(frame.containerFrame.subTopFrame:GetWidth(), frame.containerFrame.subTopFrame:GetHeight())
	--frame.containerFrame.bottomFrame:SetBackdrop(BACKDROP_DATA)
	--frame.containerFrame.bottomFrame:SetBackdropColor(1,0,0,1)
	frame.containerFrame.bottomFrame.content = {}
	
	CONTAINER_ITEM_PLACE_HEIGHT = frame.containerFrame:GetHeight() - 4 - frame.containerFrame.topFrame:GetHeight() - frame.containerFrame.topFrameSec:GetHeight() - frame.containerFrame.subTopFrame:GetHeight() - frame.containerFrame.bottomFrame:GetHeight()
	
	SVF.RefreshStyle()
	--frame:Hide()
end

function SVF.ResetFrames()
	db.point = { "CENTER" }
	if SVF.frame then
		SVF.frame:ClearAllPoints()
		SVF.frame:SetPoint(db.point[1])
	end
end

function SVF.RefreshStyle()
	if not SVF.frame then return end
	
	local frame = SVF.frame
	frame:SetBackdropColor(db.mainFrame.bgColor[1], db.mainFrame.bgColor[2], db.mainFrame.bgColor[3], db.mainFrame.bgColor[4])
	frame.title:SetBackdropColor(db.mainFrame.title.bgColor[1], db.mainFrame.title.bgColor[2], db.mainFrame.title.bgColor[3], db.mainFrame.title.bgColor[4])
	frame.title.text:SetTextColor(db.mainFrame.title.textColor[1], db.mainFrame.title.textColor[2], db.mainFrame.title.textColor[3], db.mainFrame.title.textColor[4])
	frame.title.text:SetFont(LibSharedMedia:Fetch("font", db.mainFrame.title.font), db.mainFrame.title.size)
	frame.modelFrame:SetBackdropColor(db.mainFrame.bgColorModel[1], db.mainFrame.bgColorModel[2], db.mainFrame.bgColorModel[3], db.mainFrame.bgColorModel[4])
	frame:SetScale(db.mainFrame.scale)

	CONTAINER_ITEM_TEXT_BG_COLOR.r = db.content.bgColor[1]
	CONTAINER_ITEM_TEXT_BG_COLOR.g = db.content.bgColor[2]
	CONTAINER_ITEM_TEXT_BG_COLOR.b = db.content.bgColor[3]
	CONTAINER_ITEM_TEXT_BG_COLOR.a = db.content.bgColor[4]

	CONTAINER_ITEM_TEXT_COLOR.r = db.content.textColor[1]
	CONTAINER_ITEM_TEXT_COLOR.g = db.content.textColor[2]
	CONTAINER_ITEM_TEXT_COLOR.b = db.content.textColor[3]
	CONTAINER_ITEM_TEXT_COLOR.a = db.content.textColor[4]
	CONTAINER_ITEM_TEXT_COLOR.font = db.content.textFont
	CONTAINER_ITEM_TEXT_COLOR.fontSize = db.content.textSize
	
	CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR.r = db.contentTopBottom.bgColor[1]
	CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR.g = db.contentTopBottom.bgColor[2]
	CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR.b = db.contentTopBottom.bgColor[3]
	CONTAINER_TOP_BOTTOM_TEXT_BG_COLOR.a = db.contentTopBottom.bgColor[4]

	CONTAINER_TOP_BOTTOM_TEXT_COLOR.r = db.contentTopBottom.textColor[1]
	CONTAINER_TOP_BOTTOM_TEXT_COLOR.g = db.contentTopBottom.textColor[2]
	CONTAINER_TOP_BOTTOM_TEXT_COLOR.b = db.contentTopBottom.textColor[3]
	CONTAINER_TOP_BOTTOM_TEXT_COLOR.a = db.contentTopBottom.textColor[4]
	CONTAINER_TOP_BOTTOM_TEXT_COLOR.font = db.contentTopBottom.textFont
	CONTAINER_TOP_BOTTOM_TEXT_COLOR.fontSize = db.contentTopBottom.textSize
	
	-- update existing
	for i = 1, #SVF.frame.containerFrame.content do
		local frame = SVF.frame.containerFrame.content[i]
		for j = 1, #frame.content do
			frame.content[j]:SetColors(frame.content[j].set_bgColor, frame.content[j].set_textColor)
		end
	end
	for i = 1, #SVF.frame.containerFrame.subTopFrame.content do
		SVF.frame.containerFrame.subTopFrame.content[i]:SetColors(SVF.frame.containerFrame.subTopFrame.content[i].set_bgColor, SVF.frame.containerFrame.subTopFrame.content[i].set_textColor)
	end
	for i = 1, #SVF.frame.containerFrame.bottomFrame.content do
		SVF.frame.containerFrame.bottomFrame.content[i]:SetColors(SVF.frame.containerFrame.bottomFrame.content[i].set_bgColor, SVF.frame.containerFrame.bottomFrame.content[i].set_textColor)
	end

	
end

function SVF:ShowPreviewSet()
	SVF:SetAtlasLootItemSet("GMTESTSET", "global")
end
