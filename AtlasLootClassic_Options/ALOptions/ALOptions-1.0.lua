local _G = getfenv(0)
local LibStub = _G.LibStub

local ALOPTIONS_MAJOR, ALOPTIONS_MINOR = "ALOptions-1.0", 1
local ALOptions, oldminor = LibStub:NewLibrary(ALOPTIONS_MAJOR, ALOPTIONS_MINOR)
-- I only use this in AtlasLoot at this time. The overload with newer version isnt tested..
if not ALOptions then return end -- No upgrade needed

-- lua
local assert, select, unpack = assert, select, unpack
local setmetatable, rawset, pairs = setmetatable, rawset, pairs
local min, floor = math.min, math.floor

-- data register
local Data = {}
-- data protos
local DataProto = {}
-- main frame that shows options
local mainFrame = nil
-- gui functions for widgets
local GUI = {}
ALOptions.GUI = GUI
local db = AtlasLoot.db

function ALOptions:Register(addonName, frameTitle, addonVersion, savedVariables, contentTable)
	assert(addonName and addonName ~= "", "No empty addonNames allowed.")
	assert(not Data[addonName], addonName.." already exists.")
	Data[addonName] = {
		addonName = addonName,
		frameTitle = frameTitle,
		version = addonVersion,
		savedVariables = savedVariables,
		contentTable = contentTable,
	}
	for k,v in pairs(DataProto) do
		Data[addonName][k] = v
	end
	return Data[addonName]
end

function ALOptions:Get(addonName)
	return Data[addonName]
end

-- ########################
-- Data Protos
-- ########################

function DataProto:Show(quickSelect)
	ALOptions:Show(self.frameTitle)
	ALOptions:SetContentTable(self.contentTable)
	ALOptions:SetSelected(quickSelect)
end

-- ########################
-- Main Window
-- ########################
local SELECT_BUTTON_HEIGHT = 20

-- ## mainframe functions
local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		self:StartMoving()
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a, b, c, d, e = self:GetPoint()
	db.OptionsFrame.point = { a, b, c, d, e }
end

-- ## selection frame functions
local SELECT_FRAME_LEVEL = {
	[1] = { textX = 5, textY = 0, textColor = { r = 1.0, 	g = 0.82, 	b = 0.0, 	a = 1.0 },		fontObject = "GameFontNormal" },
	[2] = { textX = 15, textY = 0, textColor = { r = 1.0, 	g = 1.0, 	b = 1.0, 	a = 1.0 },		fontObject = "GameFontNormalSmall" },
	[3] = { textX = 25, textY = 0, textColor = { r = 1.0, 	g = 1.0,	b = 1.0, 	a = 1.0 },		fontObject = "GameFontNormalSmall" },
}

local function UpdateScrollBar(self, startValue)
	startValue = startValue or 1
	if self.numContent > self.numEntrysMax then
		self.scrollbar:Show()
		self.enableScroll = true
		self.maxScroll = self.numContent - self.numEntrysMax + 1
		self.scrollbar:SetMinMaxValues(1, self.maxScroll)
		self.scrollbar:SetValue(startValue > self.maxScroll and self.maxScroll or startValue)
	else
		self.scrollbar:Hide()
		self.enableScroll = false
	end
	-- update entry size if neede
	local button = self.content[1]
	if button.scrollState and self.numContent <= self.numEntrysMax then
		-- not scrollable
		button:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -2, -(2+SELECT_BUTTON_HEIGHT))
		button.scrollState = false
	elseif not button.scrollState and self.numContent > self.numEntrysMax then
		-- scrollable
		button:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -20, -(2+SELECT_BUTTON_HEIGHT))
		button.scrollState = true
	end
end

local function UpdateScroll(self)
	if not self.contentTable then return end
	self.buttonCount = 0
	local contentTable = self.contentTable
	local frameCounter = 1
	for i = 1, #contentTable do
		if frameCounter > mainFrame.selection.numEntrysMax then
			-- we must enable scroll...
			frameCounter = frameCounter + 1
		else
			frameCounter = mainFrame.selection.content[frameCounter]:Set(contentTable[i], contentTable[i].title, contentTable[i].desc, 1, contentTable[i].clickFunc, contentTable[i].content, contentTable[i].extended, self.enableScroll and self.curPos or 1)
		end
	end
	self.numContent = frameCounter - 1
end

local function GetPageTitle(contentTable, first)
	return contentTable.title and format(first and "%s%s" or "%s%s -> ", (contentTable and contentTable.obj) and GetPageTitle(contentTable.obj) or "", contentTable.title or "") or nil
end

local function Select_SetPage(content)
	if not content.clickFunc then return end
	GUI:Clear()
	mainFrame.topContent.text:SetText(GetPageTitle(content, true))
	content.clickFunc(GUI, content)
end

local function Select_Button_Set(self, contentTable, title, description, lvl, linkedPage, extendTable, isExtended, firstSetValue)
	local nextButtonIndex = self.index + 1
	self.obj.buttonCount = self.obj.buttonCount + 1
	self.contentTable = contentTable
	self.contentID = contentTable.contentID
	
	if contentTable.openOnRun then
		if self.obj.selectedButton then
			self.obj.selectedButton.contentTable.selected = nil
		end
		contentTable.selected = true
		Select_SetPage(contentTable) 
		contentTable.openOnRun = nil
	end
	
	if self.obj.buttonCount >= firstSetValue then
		if contentTable.selected or self.contentID == self.obj.curContentID then
			self:SetChecked(true)
			self.obj.selectedButton = self
		end
		self:Show()
		self.txt:SetText(title)
		self.desc = description
		lvl = SELECT_FRAME_LEVEL[lvl] and lvl or #SELECT_FRAME_LEVEL
		if lvl ~= self.curLevel then
			local lvlTab = SELECT_FRAME_LEVEL[lvl]
			self.txt:SetPoint("TOPLEFT", self, "TOPLEFT", lvlTab.textX or 0, lvlTab.textY or 0)
			self.txt:SetFontObject(lvlTab.fontObject or "GameFontNormal")
			self.txt:SetTextColor(lvlTab.textColor.r or 1, lvlTab.textColor.g or 1, lvlTab.textColor.b or 1, lvlTab.textColor.a or 1)
		end
	end
	
	if extendTable then
		if self.obj.buttonCount >= firstSetValue then
			if not self.extend:IsShown() then
				self.extend:Show()
				self.txt:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -15, 0)
			end
			if isExtended and not self.extendedState then
				self.extend:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
				self.extend:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
				self.extendedState = true
			elseif not isExtended and self.extendedState then
				self.extend:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
				self.extend:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
				self.extendedState = false
			end
		end
		if isExtended then
			for i = 1, #extendTable do
				if nextButtonIndex > mainFrame.selection.numEntrysMax then
					-- we must enable scroll...
					nextButtonIndex = nextButtonIndex + 1
				else
					nextButtonIndex = self.obj.content[self.obj.buttonCount+1 == firstSetValue and 1 or nextButtonIndex]:Set(extendTable[i], extendTable[i].title, extendTable[i].desc, lvl+1, extendTable[i].clickFunc, extendTable[i].content, extendTable[i].extended, firstSetValue)
				end
			end
		end
	elseif self.obj.buttonCount >= firstSetValue and self.extend:IsShown() then
		self.extend:Hide()
		self.txt:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	end
	return self.obj.buttonCount >= firstSetValue and nextButtonIndex or 1
end

local function Select_Button_Extend_OnClick(self)
	self.obj.contentTable.extended = not self.obj.contentTable.extended
	
	if self.obj.obj.selectedButton then
		self.obj.obj.selectedButton.contentTable.selected = nil
		self.obj.obj.selectedButton = nil
	end
	
	ALOptions:ClearContentTable()
	self.obj.obj:Update()
	self.obj.obj:UpdateBar(self.curPos)
end

local function Select_Button_OnClick(self)
	if self.obj.selectedButton == self then self:SetChecked(true) return end
	if self.obj.selectedButton then
		self.obj.selectedButton:SetChecked(false)
		self.obj.selectedButton.contentTable.selected = nil
	end
	self:SetChecked(true)
	self.obj.selectedButton = self
	self.obj.curContentID = self.contentID
	Select_SetPage(self.contentTable)
	
end

local function Select_Button_OnEnter(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine(self.contentTable.title)
	GameTooltip:AddLine(self.contentTable.desc, 1, 1, 1, true)
	GameTooltip:Show()
end

local function Select_Button_OnLeave(self)
	GameTooltip:Hide()
end
	
local function Select_CreateButton(self)
	local button = CreateFrame("CheckButton", nil, self)
	button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button:SetCheckedTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button:SetChecked(false)
	--button:SetNormalTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2")
	button.obj = self
	button:SetScript("OnClick", Select_Button_OnClick)
	button:SetScript("OnEnter", Select_Button_OnEnter)
	button:SetScript("OnLeave", Select_Button_OnLeave)
	
	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp")
	button.bg:SetBlendMode("ADD")
	button.bg:SetVertexColor(0.5, 0.5, 0.5, 0.25)
	button.bg:SetAllPoints(button)
	
	button.txt = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	button.txt:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.txt:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -5, 0)
	button.txt:SetJustifyH("LEFT")
	button.txt:SetText("Text")
	button.txt:SetWordWrap(false)
	
	button.extend = CreateFrame("Button", nil, button)
	button.extend:SetPoint("RIGHT", button, "RIGHT")
	button.extend:SetSize(15, 15)
	button.extend:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight", "ADD")
	button.extend:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
	button.extend:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
	button.extend:SetScript("OnClick", Select_Button_Extend_OnClick)
	button.extend.obj = button
	button.extend:Hide()
	button.extendedState = false
	
	button.Set = Select_Button_Set

	return button
end

local select_content_mt = {
	__index = function(self, key)
		if type(key) ~= "number" then return end
		local button = Select_CreateButton(self.frame)
		button.index = key
		if key == 1 then
			button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 2, -2)
			button:SetPoint("BOTTOMRIGHT", self.frame, "TOPRIGHT", -2, -(2+SELECT_BUTTON_HEIGHT))
		else
			button:SetPoint("TOPLEFT", self[key-1], "BOTTOMLEFT", 0, -2)
			button:SetPoint("BOTTOMRIGHT", self[key-1], "BOTTOMRIGHT", 0, -(2+SELECT_BUTTON_HEIGHT))
		end
		rawset(self, key, button)
		return self[key]
	end,
}

local function Select_OnMouseWheel(self, value)
	if not self.enableScroll then return end
	self.curPos = self.curPos - value
	if self.curPos >= self.maxScroll then self.curPos = self.maxScroll end
	if self.curPos <= 0 then self.curPos = 1 end
	self.scrollbar:SetValue(min(self.curPos, self.maxScroll))
end

local function Select_ScrollBar_OnValueChanged(self, value)
	if not self.obj.enableScroll then return end
	self = self.obj
	self.curPos = floor(value)
	
	if self.curPos <= 0 then self.curPos = 1 end
	UpdateScroll(self)
end

function ALOptions:Show(title)
	if not mainFrame then
		local point, relativeTo, relativePoint, ofsx, ofsy = unpack(db.OptionsFrame.point)
		
		mainFrame = CreateFrame("FRAME", "ALOptions_frame")
		mainFrame:ClearAllPoints()
		mainFrame:SetParent(UIParent)
		mainFrame:SetPoint(point or "CENTER", nil, relativePoint or "CENTER", ofsx or 0, ofsy or 0)
		mainFrame:SetSize(810, 550)
		mainFrame:SetMovable(true)
		mainFrame:EnableMouse(true)
		mainFrame:SetScript("OnMouseDown", FrameOnDragStart)
		mainFrame:SetScript("OnMouseUp", FrameOnDragStop)
		mainFrame:SetToplevel(true)
		mainFrame:SetClampedToScreen(true)
		mainFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame:SetBackdropColor(0.45, 0.45, 0.45, 1)
		tinsert(UISpecialFrames, "ALOptions_frame")	-- allow ESC close
		
		mainFrame.CloseButton = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
		mainFrame.CloseButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", 0, 0)
		
		mainFrame.title = CreateFrame("Frame", nil, mainFrame)
		--frame:SetParent(SVF.frame.containerFrame)
		mainFrame.title:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame.title:SetBackdropColor(0, 0, 0, 1)
		mainFrame.title:SetPoint("TOPLEFT", mainFrame, 10, -7)
		mainFrame.title:SetPoint("BOTTOMRIGHT", mainFrame, "TOPRIGHT", -30, -25)
	
		mainFrame.title.text = mainFrame.title:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		mainFrame.title.text:SetAllPoints(mainFrame.title)
		mainFrame.title.text:SetTextColor(0.9, 0.9, 0.9, 1)
		mainFrame.title.text:SetJustifyH("CENTER")
		mainFrame.title.text:SetText(title)
		
		-- select frame left
		mainFrame.selection = CreateFrame("ScrollFrame", "ALOptions_frame_selection", mainFrame)
		mainFrame.selection:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame.selection:SetBackdropColor(0, 0, 0, 1)
		mainFrame.selection:SetPoint("TOPLEFT", mainFrame.title, "BOTTOMLEFT", 0, -5)
		mainFrame.selection:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT", (mainFrame:GetWidth()-30)*0.25, 10)
		mainFrame.selection:SetScript("OnMouseWheel", Select_OnMouseWheel)
		mainFrame.selection.enableScroll = false
		mainFrame.selection.curPos = 1
		mainFrame.selection.maxScroll = 4					-- Max value for scrollbar (SetMinMaxValues)
		mainFrame.selection.numEntrysMax = floor( (mainFrame.selection:GetHeight() - 4) / (SELECT_BUTTON_HEIGHT+2) )
		mainFrame.selection.content = setmetatable({frame = mainFrame.selection}, select_content_mt)
		mainFrame.selection.Update = UpdateScroll
		mainFrame.selection.UpdateBar = UpdateScrollBar
		
		mainFrame.selection.scrollbar = CreateFrame("Slider", "ALOptions_frame_selection-scrollbar", mainFrame.selection, "UIPanelScrollBarTemplate")
		mainFrame.selection.scrollbar:SetPoint("TOPLEFT", mainFrame.selection, "TOPRIGHT", -17, -17)
		mainFrame.selection.scrollbar:SetPoint("BOTTOMLEFT", mainFrame.selection, "BOTTOMRIGHT", 17, 17)
		mainFrame.selection.scrollbar:SetMinMaxValues(0, 1000)
		mainFrame.selection.scrollbar:SetValueStep(1)
		mainFrame.selection.scrollbar.scrollStep = 1
		mainFrame.selection.scrollbar:SetValue(0)
		mainFrame.selection.scrollbar:SetWidth(16)
		--mainFrame.selection.scrollbar:Hide()
		mainFrame.selection.scrollbar:SetScript("OnValueChanged", Select_ScrollBar_OnValueChanged)
		mainFrame.selection.scrollbar.obj = mainFrame.selection
		
		local scrollbg = mainFrame.selection.scrollbar:CreateTexture(nil, "BACKGROUND")
		scrollbg:SetAllPoints(mainFrame.selection.scrollbar)
		scrollbg:SetTexture(0, 0, 0, 0.4)
		
		-- content frame
		mainFrame.topContent = CreateFrame("FRAME", "ALOptions_frame_topContent", mainFrame)
		mainFrame.topContent:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame.topContent:SetBackdropColor(0, 0, 0, 1)
		mainFrame.topContent:SetPoint("TOPLEFT", mainFrame.selection, "TOPRIGHT", 10, 0)
		mainFrame.topContent:SetPoint("RIGHT", mainFrame, "RIGHT", -10, 0)
		mainFrame.topContent:SetHeight(20)
		
		mainFrame.topContent.text = mainFrame.topContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		mainFrame.topContent.text:SetPoint("TOPLEFT", mainFrame.topContent, "TOPLEFT", 2, 0)
		mainFrame.topContent.text:SetPoint("BOTTOMRIGHT", mainFrame.topContent, "BOTTOMRIGHT", -2, 0)
		mainFrame.topContent.text:SetTextColor(0.9, 0.9, 0.9, 1)
		mainFrame.topContent.text:SetJustifyH("LEFT")
		mainFrame.topContent.text:SetText("Test -> Test -> Test")
		
		mainFrame.bottomContent = CreateFrame("FRAME", "ALOptions_frame_bottomContent", mainFrame)
		mainFrame.bottomContent:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame.bottomContent:SetBackdropColor(0, 0, 0, 1)
		mainFrame.bottomContent:SetPoint("BOTTOMLEFT", mainFrame.selection, "BOTTOMRIGHT", 10, 0)
		mainFrame.bottomContent:SetPoint("RIGHT", mainFrame, "RIGHT", -10, 0)
		mainFrame.bottomContent:SetHeight(20)
		
		mainFrame.content = CreateFrame("FRAME", "ALOptions_frame_content", mainFrame)
		mainFrame.content:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
		mainFrame.content:SetBackdropColor(0, 0, 0, 1)
		mainFrame.content:SetPoint("TOPLEFT", mainFrame.topContent, "BOTTOMLEFT", 0, -2)
		mainFrame.content:SetPoint("BOTTOMRIGHT", mainFrame.bottomContent, "TOPRIGHT", 0, 3)
	end
	mainFrame:Show()
end

function ALOptions:ClearContentTable()
	for i = 1, #mainFrame.selection.content do
		mainFrame.selection.content[i]:SetChecked(false)
		mainFrame.selection.content[i]:Hide()
	end
end

local function ValidateContentTable(content, counter)
	counter = counter or 0
	for i = 1, #content do
		counter = counter + 1
		content[i].obj = content.obj or content
		content[i].contentID = counter
		if content[i].content then
			counter = counter + 1
			content[i].content.contentID = counter
			content[i].content.obj = content[i]
			counter = ValidateContentTable(content[i].content, counter)
		end
	end
	return counter
end

function ALOptions:SetContentTable(contentTable)
	mainFrame.selection.contentTable = contentTable
	if contentTable then
		ValidateContentTable(mainFrame.selection.contentTable)
	end
	self:ClearContentTable()

	mainFrame.selection:Update()
	mainFrame.selection:UpdateBar()
end

local function SetSelectedLoop(quickSelect, content)
	for i = 1, #content do
		if content[i].quickSelect == quickSelect then
			content[i].openOnRun = true
			return
		elseif content[i].content then
			local found = SetSelectedLoop(quickSelect, content[i].content)
			if found then
				content[i].extended = true
			end
		end
	end
end

function ALOptions:SetSelected(quickSelect)
	if not quickSelect or not mainFrame.selection.contentTable then return end
	SetSelectedLoop(quickSelect, mainFrame.selection.contentTable)
	self:ClearContentTable()
	mainFrame.selection:Update()
	mainFrame.selection:UpdateBar()
end

-- ########################
-- GUI
-- ########################
local WidgetTypeContainer = {}

local widgetSave = {}
local inUseWidgetSave = {}

local function GetWidgetByType(typ)
	if not widgetSave[typ] then widgetSave[typ] = {} end
	local frame = next(widgetSave[typ])
	if frame then 
		widgetSave[typ][frame] = nil
		-- dont reuse old version..
		if frame.version < WidgetTypeContainer[typ].version then
			return GetWidgetByType(typ)
		end
	end
	return frame or GUI:GetNewWidget(typ)
end

local function FreeWidgetByType(typ, frame)
	if not widgetSave[typ] then widgetSave[typ] = {} end
	widgetSave[typ][frame] = true
end


-- # widget base
local WidgetBase = {
	Clear = function(self)
		if self.OnClear then self:OnClear() end
		self:Tooltip():DB()
		FreeWidgetByType(self.type, self)
		self.frame:Hide()
		return self
	end,
	OnAddBase = function(self) 
		self.frame:Show() 
		if self.OnAdd then self:OnAdd() end
		return self 
	end,
	-- :DB(table, tableKey [, onValueChange]])
	DB = function(self, savedVariablesTable, tableKey, onValueChangeCallback)
		self.dbTable = savedVariablesTable
		self.dbKey = tableKey
		self.dbOnChange = onValueChangeCallback
		if savedVariablesTable and tableKey then
			self:SetDBValue(savedVariablesTable[tableKey], true)
		end
		return self
	end,
	SetDBValue = function(self, value, noCallback)
		if not self.dbTable then return end
		self.dbTable[self.dbKey] = value
		self.dbCur = value
		if self.OnDBSet then self:OnDBSet(value) end
		if not noCallback and self.dbOnChange then self:dbOnChange(value) end
		return self
	end,
	Point = function(self, point, relativeFrame, relativePoint, ofsx, ofsy)
		self.frame:ClearAllPoints()
		self.frame:SetParent(mainFrame.content)
		self.frame:SetPoint(point, (relativeFrame and type(relativeFrame) ~= "number") and (relativeFrame.frame and relativeFrame.frame or relativeFrame ) or (type(relativeFrame) == "number" and relativeFrame or mainFrame.content), relativePoint, ofsx, ofsy)
		return self
	end,
	ClearAllPoints = function(self)
		self.frame:ClearAllPoints()
		return self
	end,
	SetPoint = function(self, ...)
		self.frame:SetPoint(...)
		return self
	end,
	SetParent = function(self, par)
		self.frame:SetParent(par)
		return self
	end,
	-- width/height		=	"full" (full parent frame size), "half" (half parent frame size), number
	Size = function(self, width, height)
		width = width == "full" and self.frame:GetParent():GetWidth() or width == "half" and self.frame:GetParent():GetWidth()*0.5 or width
		height = height == "full" and self.frame:GetParent():GetWidth() or height == "half" and self.frame:GetParent():GetWidth()*0.5 or height
		width = (width and width > self.minWidth) and ( (self.maxWidth and width > self.maxWidth) and self.maxWidth or width ) or self.minWidth
		height = (height and height > self.minHeight) and ( (self.maxHeight and width > self.maxHeight) and self.maxHeight or height ) or self.minHeight
		self.frame:SetSize(width or self.minWidth, height or self.minHeight)
		if self.OnSizeSet then self:OnSizeSet(width, height) end
		return self
	end,
	-- title	=	"text" use the text from the textframe
	Tooltip = function(self, title, desc)
		self.ttTitle = title
		self.ttDesc = desc
		if title or desc then
			self.frame:SetScript("OnEnter", self.OnEnter)
			self.frame:SetScript("OnLeave", self.OnLeave)
		else
			self.frame:SetScript("OnEnter", nil)
			self.frame:SetScript("OnLeave", nil)
		end
		return self
	end,
	
	-- base functions
	SetDBValueBase = function(self, value)
		if not self.dbTable then return end
		if type(self.dbTable) == "table" then
			self.dbTable[self.dbKey] = value
		elseif type(self.dbTable) == "function" then
			self.dbTable(value)
		end
		if self.dbOnChange then
			self.dbOnChange(value)
		end
	end,

	-- :SetColorBase(textFrame, "white" [, alpha])
	-- :SetColorBase(textFrame, r, g, b, a)
	SetColorBase = function(self, textFrame, colorOrR, g, b, a)
		if type(colorOrR) == "string" then
			if colorOrR == "white" then
				textFrame:SetTextColor(1, 1, 1, g or 1)
			elseif colorOrR == "red" then
				textFrame:SetTextColor(1, 0, 0, g or 1)
			elseif colorOrR == "green" then
				textFrame:SetTextColor(0, 1, 0, g or 1)
			elseif colorOrR == "blue" then
				textFrame:SetTextColor(0, 0, 1, g or 1)
			else
				textFrame:SetTextColor(1, 0.82, 0, 1)
			end
		else
			textFrame:SetTextColor(colorOrR or 1, g or 0.82, b or 0, a or 1)
		end
		return self
	end,
	
	-- Scripts
	OnEnter = function(self)
		if self.obj.ttTitle or self.obj.ttDesc then
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
			GameTooltip:AddLine( (self.obj.ttTitle and self.obj.ttTitle == "text" and self.obj.text) and self.obj.text:GetText() or ( self.obj.ttTitle or " " ))
			if self.obj.ttDesc then
				GameTooltip:AddLine(self.obj.ttDesc, 1, 1, 1, true)
			end
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		GameTooltip:Hide()
	end,
	
	
	-- some settings
	minWidth = 1,
	maxWidth = nil,
	minHeight = 1,
	maxHeight = nil,
}
local WidgetBaseMt = { __index = WidgetBase }

function GUI:SetWidgetBase(widget)
	setmetatable(widget, WidgetBaseMt)
	widget.frame.obj = widget.frame.obj or widget
	return widget
end

function GUI:GetNewWidget(typ)
	return WidgetTypeContainer[typ] and WidgetTypeContainer[typ].func() or nil
end

function GUI:GetWidgetTypeVersion(typ)
	return WidgetTypeContainer[typ] or 0
end

function GUI:RegisterWidgetType(typ, func, version)
	WidgetTypeContainer[typ] = {
		func = func, 
		version = version,
	}
end

-- gui functions for options functions
function GUI:Add(typ)
	local frame = GetWidgetByType(typ):OnAddBase()
	if frame then
		inUseWidgetSave[#inUseWidgetSave + 1] = frame
	end
	return frame
end

function GUI:Clear()
	for i = 1, #inUseWidgetSave do
		inUseWidgetSave[i]:Clear()
		inUseWidgetSave[i] = nil
	end
end
--[[
local AL_Options = ALOptions:Register("AtlasLoot", "AtlasLoot Options", "6.0.0", AtlasLoot.db.profile, {
	{
		title = "Ex Normal",
		desc = "This is a simple example entry",
		clickFunc = function(self) print(self.title, self.desc) end,
		quickSelect = "start",
	},
	{
		title = "Ex Extended",
		desc = "This is a example with extended content",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Extended 2",
		desc = "This is a example with extended content (2)",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2 with content",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
				content = {
					{
						title = "Ex SubSubEntry",
						desc = "This is a sub-sub entry",
						clickFunc = function(self) print(self.title, self.desc) end,
					},
				},	
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Normal",
		desc = "This is a simple example entry",
		clickFunc = function(self) print(self.title, self.desc) end,
	},
	{
		title = "Ex Extended",
		desc = "This is a example with extended content",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Extended 2",
		desc = "This is a example with extended content (2)",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2 with content",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
				content = {
					{
						title = "Ex SubSubEntry",
						desc = "This is a sub-sub entry",
						clickFunc = function(self) print(self.title, self.desc) end,
					},
				},	
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Normal",
		desc = "This is a simple example entry",
		clickFunc = function(self) print(self.title, self.desc) end,
	},
	{
		title = "Ex Extended",
		desc = "This is a example with extended content",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Extended 2",
		desc = "This is a example with extended content (2)",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2 with content",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
				content = {
					{
						title = "Ex SubSubEntry",
						desc = "This is a sub-sub entry",
						clickFunc = function(self) print(self.title, self.desc) end,
					},
				},	
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Normal",
		desc = "This is a simple example entry",
		clickFunc = function(self) print(self.title, self.desc) end,
	},
	{
		title = "Ex Extended",
		desc = "This is a example with extended content",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
	{
		title = "Ex Extended 2",
		desc = "This is a example with extended content (2)",
		clickFunc = function(self) print(self.title, self.desc) end,
		content = {
			{
				title = "Ex SubEntry 1",
				desc = "This is a sub entry (1)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
			{
				title = "Ex SubEntry 2 with content",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
				content = {
					{
						title = "Ex SubSubEntry",
						desc = "This is a sub-sub entry",
						clickFunc = function(self) print(self.title, self.desc) end,
					},
				},	
			},
			{
				title = "Ex SubEntry 2",
				desc = "This is a sub entry (2)",
				clickFunc = function(self) print(self.title, self.desc) end,
			},
		},
	},
})
AL_Options:Show()
]]--
