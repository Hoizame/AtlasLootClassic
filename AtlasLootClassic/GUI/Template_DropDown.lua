--[[ usage
	data = {
		[1] = {		-- category
			info = {
				name = "Display Title",
				bgColor = {r, g, b, alpha},		-- Background color
				textColor = {r, g, b},			-- Text color
			},
			[1] = {		-- entry number
				id			= "1-Display Name",		-- unique id
				name		= "Display Name",
				color		= {r, g, b},			-- Text color
				tt_title	= "Tooltip Title",		-- OnEnter can changed with "SetToolTipFunc", arg list = ShowToolTip(...)
				tt_text		= "Tooltip Text",
				arg			= "arg",				-- OnClick(arg)
				icon		= "Interface\\Icons\\INV_Misc_QuestionMark",
			},
		}
	}
]]
local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

-- lua
local assert, type = assert, type
local next, wipe = next, table.wipe

-- //\\
local WHITE_TEXT_COLOR = {1, 1, 1}
local WHITE_BG_COLOR = {1, 1, 1, 1}


local DROPDOWN_COUNT = 0
local LIST_IS_OPEN = nil

local Button_Id_List = {}

local GenerateButtonFrame

local function MainFrame_OnHide(self)
	if LIST_IS_OPEN then
		GenerateButtonFrame(self, true)
	end
end

-- STD functions
local function ShowToolTip(self)
	self.ttSource:SetOwner(self, "ANCHOR_RIGHT")
	self.ttSource:AddLine(self.ttTitle or "", 1.0, 1.0, 1.0)
	self.ttSource:AddLine(self.ttText or "", nil, nil, nil, 1)
	self.ttSource:Show()
end

local function HideToolTip(self)
	self.ttSource:Hide()
end

-- DropDown functions

local function Toggle(self)
	GenerateButtonFrame(self)
end

local function Clear(self)
	GenerateButtonFrame(self, true)
end

local function SetData(self, data, startValue)
	if not data then
		self:Clear()
		self.data = nil
		self.selectedId = nil
		return
	end
	assert(type(data) == "table", "'data' must be a table. See 'GUI/Template_DropDown.lua' for infos.")
	self.data = data
	self.selectedId = startValue
	if startValue then
		self:SetSelected(startValue)
	end
end

-- DropDown Set functions
local function SetWidth(self, width)
	self.width = width
	self.frame:SetWidth(width)
	--self.frame.label:SetWidth(width-35)
end

local function SetToolTipFunc(self, OnEnter, OnLeave)
		self.OnEnterButton = OnEnter or ShowToolTip
		self.OnLeaveButton = OnLeave or HideToolTip
end

local function SetText(self, text)
	if text and type(text) == "string" then
		self.frame.label:SetText(text)
	else
		self.frame.label:SetText("")
	end
end

local function SetTitle(self, text)
	if text and type(text) == "string" then
		self.frame.title:SetText(text)
	else
		self.frame.title:SetText("")
	end
end

-- function(dropdown, id, arg, <OnClickHandler>)
local function SetButtonOnClick(self, func)
	if func and type(func) == "function" then
		self.ButtonOnClick = func
	else
		self.ButtonOnClick = nil
	end
end

-- must be a unique id
local function SetSelected(self, id, userClick)
	if not id then return end
	local textColor, bgColor
	local text, arg
	if Button_Id_List[id] and self == LIST_IS_OPEN then
		local button = Button_Id_List[id]
		arg = button.info.arg
		text = button.info.name
		textColor = button.info.color
		bgColor = button.cat.info.bgColor
		GenerateButtonFrame(self)
	else
		for i = 1, #self.data do
			local cat = self.data[i]
			for j = 1, #cat do
				local entry = cat[j]
				if id == entry.id then
					if entry.arg then
						arg = entry.arg
					end
					if entry.name then
						text = entry.name
					end
					if entry.color then
						textColor = entry.color
					end
					if cat.info.bgColor then
						bgColor = cat.info.bgColor
					end
					break
				end
			end
			if text then break end
		end
	end

	if self.ButtonOnClick then
		self:ButtonOnClick(id, arg, userClick)
	end
	self.selectedId = id
	self.frame.label:SetText(text or id)

	textColor, bgColor = textColor or WHITE_TEXT_COLOR, bgColor or WHITE_BG_COLOR
	self.frame.label:SetTextColor(textColor[1], textColor[2], textColor[3])
	self.frame:SetBackdropColor(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
end

local function EnableSelectable(self, enabled)
	self.selectable = enabled
end

local function EnableIcon(self, enabled)
	self.icon = enabled
end


-- ButtonFrame
-- local GenerateButtonFrame
do
	local BUTTON_HEIGHT = 15

	local CAT_FRAME_COUNT = 0
	local BUTTON_COUNT = 0

	local count_cats_created = 0
	local cat_width = {}
	local cat_height = {}
	local frameContainer = {}
	local cache = {
		frames = {},
		buttons = {},
	}

	local function RefreshCatWidth(index, width)
		if cat_width[index] and cat_width[index] < width then
			cat_width[index] = width
		end
	end

	local function GetFromCache(type)
		if not cache[type] then return end

		local frame = next(cache[type])
		if frame then
			cache[type][frame] = nil
		end
		return frame
	end

	local function ClearFrameContainer()
		for i = 1, #frameContainer do
			local frame = frameContainer[i]
			for j = 1, #frame.buttons do
				frame.buttons[j]:Hide()
				cache.buttons[ frame.buttons[j] ] = true
			end
			wipe(frame.buttons)
			frame.info = nil
			frame:Hide()
			cache.frames[frame] = true
		end
		wipe(frameContainer)
		count_cats_created = 0
		wipe(cat_width)
	end

	local function ButtonOnClick(self, ...)
		local dropdown = LIST_IS_OPEN
		dropdown:SetSelected(self.id, true)
	end

	local function CreateButton(dropdown, cat, buttonInfo, catIndex)
		assert(buttonInfo.id, "No 'id' found for button")
		local frame = GetFromCache("buttons")
		if not frame then
			BUTTON_COUNT = BUTTON_COUNT + 1
			local frameName = "AtlasLoot-DropDown-Button"..BUTTON_COUNT

			frame = CreateFrame("Button", frameName, cat)
			frame:SetHeight(BUTTON_HEIGHT)
			frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
			frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")

			frame.label = frame:CreateFontString(frameName.."-label", "ARTWORK", "GameFontNormalSmall")
			frame.label:SetPoint("LEFT", frame, "LEFT")
			frame.label:SetHeight(BUTTON_HEIGHT)
			frame.label:SetJustifyH("LEFT")
			frame.label:SetText(frameName.."-label")

			frame.check = frame:CreateTexture(frameName.."-check", "ARTWORK")
			frame.check:SetPoint("LEFT", frame, "LEFT", 0, 0)
			frame.check:SetHeight(BUTTON_HEIGHT)
			frame.check:SetWidth(BUTTON_HEIGHT)
			frame.check:SetTexture("Interface\\Common\\UI-DropDownRadioChecks")
			frame.check:SetTexCoord(0,0.5,0.5,1.0)
			frame.check:Hide()

			frame.icon = frame:CreateTexture(frameName.."-icon", "ARTWORK")
			frame.icon:SetPoint("LEFT", frame, "LEFT", 0, 0)
			frame.icon:SetHeight(BUTTON_HEIGHT)
			frame.icon:SetWidth(BUTTON_HEIGHT)
			frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		end
		frame:SetScript("OnEnter", dropdown.OnEnterButton)
		frame:SetScript("OnLeave", dropdown.OnLeaveButton)
		frame:SetScript("OnClick", ButtonOnClick)
		frame:SetWidth(cat_width[catIndex]-10)

		local width_fix = 0
		local icon,selectable
		frame.info = buttonInfo
		Button_Id_List[buttonInfo.id] = frame

		frame.label:SetText(buttonInfo.name or buttonInfo.id)

		frame:ClearAllPoints()
		frame:SetParent(cat)
		frame:SetFrameLevel(cat:GetFrameLevel()+1)
		if #cat.buttons == 0 then
			if cat.label:IsShown() then
				frame:SetPoint("TOPLEFT", cat, "TOPLEFT", 5, -(cat_height[catIndex] - 5))
			else
				frame:SetPoint("TOPLEFT", cat, "TOPLEFT", 5, -5)
			end
		else
			frame:SetPoint("TOPLEFT", cat.buttons[#cat.buttons], "BOTTOMLEFT")
		end

		if buttonInfo.color then
			frame.label:SetTextColor(buttonInfo.color[1], buttonInfo.color[2], buttonInfo.color[3])
		else
			frame.label:SetTextColor(1, 1, 1)
		end

		if buttonInfo.icon and dropdown.icon then
			frame.icon:SetTexture(buttonInfo.icon)
			frame.icon:Show()
			width_fix = width_fix + BUTTON_HEIGHT
			icon = true
		else
			frame.icon:Hide()
		end

		if dropdown.selectable then
			if buttonInfo.id and buttonInfo.id == dropdown.selectedId then
				frame.check:SetTexCoord(0, 0.5, 0.5, 1.0)
			else
				frame.check:SetTexCoord(0.5, 1, 0.5, 1.0)
			end
			frame.check:Show()
			selectable = true
			width_fix = width_fix + BUTTON_HEIGHT
		else
			frame.check:Hide()
		end

		if icon and selectable then
			frame.label:SetPoint("LEFT", frame.icon, "RIGHT")
			frame.icon:SetPoint("LEFT", frame.check, "RIGHT")
			frame.check:SetPoint("LEFT", frame, "LEFT")
		elseif icon then
			frame.label:SetPoint("LEFT", frame.icon, "RIGHT")
		elseif selectable then
			frame.label:SetPoint("LEFT", frame.check, "RIGHT")
		else
			frame.label:SetPoint("LEFT", frame, "LEFT")
		end

		frame.cat = cat
		frame.ttSource = dropdown.ttSource
		frame.ttTitle = buttonInfo.tt_title
		frame.ttText = buttonInfo.tt_text
		frame.arg = buttonInfo.arg
		frame.id = buttonInfo.id

		cat_height[catIndex] = cat_height[catIndex] + BUTTON_HEIGHT

		RefreshCatWidth(catIndex,frame.label:GetWidth()+width_fix+10)

		frame:Show()

		return frame
	end

	local function CreateCategory(dropdown, catTab, parent)
		local frame = GetFromCache("frames")
		if not frame then
			CAT_FRAME_COUNT = CAT_FRAME_COUNT + 1
			local frameName = "AtlasLoot-DropDown-CatFrame"..CAT_FRAME_COUNT

			frame = CreateFrame("Frame", frameName, nil, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
			frame:EnableMouse(true)
			frame:SetBackdrop(ALPrivate.BOX_BORDER_BACKDROP)

			frame.label = frame:CreateFontString(frameName.."-label", "ARTWORK", "GameFontNormalSmall")
			frame.label:SetPoint("TOP", frame, "TOP", 0, -5)
			--frame.label:SetHeight(15)
			frame.label:SetText(frameName.."-label")

			frame.buttons = {}
			frame.info = nil
			frame.type = "frame"
		end
		count_cats_created = count_cats_created + 1
		catTab.index = count_cats_created
		cat_height[catTab.index] = 10
		cat_width[catTab.index] = dropdown.frame:GetWidth()
		frame.info = catTab.info

		frame:ClearAllPoints()
		frame:SetParent(dropdown.frame)
		frame:SetFrameStrata("TOOLTIP")
			frame:SetFrameLevel(100)
		if parent and type(parent) == "number" and parent ~= 1 then
			frame:SetPoint("TOPLEFT", frameContainer[#frameContainer], "BOTTOMLEFT")
		elseif parent and type(parent) == "table" and parent.type then
			if parent.type == "frame" then
				frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT")
			elseif parent.type == "button" then
				frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 15, 0)
			end
		else
			frame:SetPoint("TOPLEFT", dropdown.frame, "BOTTOMLEFT")
		end

		if catTab.info and catTab.info.name then
			frame.label:SetText(catTab.info.name)
			frame.label:Show()
			cat_height[catTab.index] = cat_height[catTab.index] + frame.label:GetHeight() + 5 -- with spacing
			RefreshCatWidth(catTab.index, frame.label:GetWidth() + 20)
		else
			frame.label:Hide()
		end

		if catTab.info and catTab.info.textColor then
			frame.label:SetTextColor(catTab.info.textColor[1] or 0, catTab.info.textColor[2] or 0, catTab.info.textColor[3] or 0)
		else
			frame.label:SetTextColor(1, 0.82, 0)
		end

		if catTab.info and catTab.info.bgColor then
			frame:SetBackdropColor(catTab.info.bgColor[1] or 0, catTab.info.bgColor[2] or 0, catTab.info.bgColor[3] or 0, catTab.info.bgColor[4] or 1)
		else
			frame:SetBackdropColor(0, 0, 0, 1)
		end

		for i = 1, #catTab do
			frame.buttons[i] = CreateButton(dropdown, frame, catTab[i], catTab.index)
		end

		if cat_width[catTab.index] > frame:GetWidth() then
			for i = 1, #frame.buttons do
				frame.buttons[i]:SetWidth(cat_width[catTab.index]-10)
			end
		end
		frame:SetWidth(cat_width[catTab.index])
		frame:SetHeight(cat_height[catTab.index])
		frame:Show()

		frameContainer[#frameContainer+1] = frame
	end

	function GenerateButtonFrame(dropdown, clear)
		if not clear and (not dropdown or not dropdown.data) then return end
		wipe(Button_Id_List)
		if LIST_IS_OPEN or clear then
			ClearFrameContainer()
			if LIST_IS_OPEN == dropdown or clear then
				LIST_IS_OPEN = nil
				return
			end
		end

		LIST_IS_OPEN = dropdown
		for i = 1, #dropdown.data do
			CreateCategory(dropdown, dropdown.data[i], i)
		end
	end
end

local function DropDownButtonOnClick(self)
	GenerateButtonFrame(self.par)
end

function GUI.CreateDropDown()
	DROPDOWN_COUNT = DROPDOWN_COUNT + 1
	local frameName = "AtlasLoot-DropDown-"..DROPDOWN_COUNT
	local self = {}

	-- functions
	self.Toggle = Toggle
	self.Clear = Clear
	self.SetData = SetData
	self.ttSource = GameTooltip
	self.OnEnterButton = ShowToolTip
	self.OnLeaveButton = HideToolTip

	-- Set functions
	self.SetParPoint = GUI.Temp_SetParPoint
	self.SetWidth = SetWidth
	self.SetToolTipFunc = SetToolTipFunc
	self.SetButtonOnClick = SetButtonOnClick
	self.SetSelected = SetSelected
	self.SetText = SetText
	self.SetTitle = SetTitle
	self.EnableSelectable = EnableSelectable
	self.EnableIcon = EnableIcon
	--self.SetIcon = SetIcon

	self.frame = CreateFrame("Button", frameName, nil, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
	local frame = self.frame
	frame:ClearAllPoints()
	frame:SetHeight(25)
	frame:EnableMouse(true)
	frame:SetBackdrop(ALPrivate.BOX_BORDER_BACKDROP)
	frame:SetBackdropColor(0,0,0,1)
	frame:SetScript("OnHide", MainFrame_OnHide)
	frame:SetScript("OnClick", DropDownButtonOnClick)
	frame.par = self

	frame.label = frame:CreateFontString(frameName.."-label", "ARTWORK", "GameFontNormalSmall")
	--frame.label:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, 0)
	--frame.label:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -29, 0)
	frame.label:SetPoint("LEFT", frame, "LEFT", 7, 0)
	frame.label:SetPoint("RIGHT", frame, "RIGHT", -29, 0)
	frame.label:SetHeight(15)
	frame.label:SetTextColor(1, 1, 1)
	frame.label:SetJustifyH("RIGHT")
	frame.label:SetJustifyV("MIDDLE")
	frame.label:SetNonSpaceWrap(true)
	--frame.label:SetHeight(15)
	frame.label:SetText(frameName.."-label")

	frame.title = frame:CreateFontString(frameName.."-title", "ARTWORK", "GameFontNormalSmall")
	frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, 10)
	frame.title:SetText(frameName.."-title")

	frame.button = CreateFrame("Button", frameName.."-button", frame)
	frame.button:SetWidth(27)
	frame.button:SetHeight(27)
	frame.button:SetPoint("RIGHT", frame, "RIGHT", 2, 0)
	frame.button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	frame.button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	frame.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	frame.button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	frame.button:SetScript("OnClick", DropDownButtonOnClick)
	frame.button.par = self

	-- data
	self.data = {}
	self.ButtonOnClick = nil
	self.Selected = nil
	self.selectedId = nil
	self.width = nil
	self.selectable = true
	self.icon = true

	self:SetWidth(200)

	return self
end
