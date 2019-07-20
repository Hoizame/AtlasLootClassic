-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0);
-- Libraries
local pairs, wipe = pairs, wipe
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local Type, Version = "Button", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local LibStub = _G.LibStub
local LibDialog = LibStub("LibDialog-1.0")

local MIN_WIDTH = 40
local FIX_SIZE = 20
--[[
StaticPopupDialogs["ATLASLOOT_CONFIRM_OPTIONS_BUTTON"] = {
	text = CONFIRM_SAVE_EQUIPMENT_SET,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = nil,
	OnCancel = nil,
	OnHide = nil,
	hideOnEscape = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
}
local popUp = StaticPopupDialogs["ATLASLOOT_CONFIRM_OPTIONS_BUTTON"]
]]
local function Confirm_OnAccept(self, data)
	if not data then return end
	if data.OnClickFunc then
		data.OnClickFunc()
	end
end

local function Confirm_OnCancel(self, data)
	-- do nothing here
end

local function Confirm_OnHide(self, data)
	-- if not data then return end
	-- do nothing here
end

local function Button_OnClick(self, button)
	self = self.obj
	if self.confirmation.text then
		LibDialog:Register("ATLASLOOT_CONFIRM_OPTIONS_BUTTON", {
			text = self.confirmation.text,
			buttons = {
				{
					text = ACCEPT,
					on_click = (function() self.OnClickFunc(self, button) end),
				},
				{
					text = CANCEL,
				},
			},
			on_cancel = self.confirmation.OnCancel,
			on_hide = self.confirmation.OnHide,
			is_exclusive = true,
			show_while_dead = true,
			hide_on_escape = true,
		})
		LibDialog:Spawn("ATLASLOOT_CONFIRM_OPTIONS_BUTTON")
--[[
		popUp.text = self.confirmation.text
		popUp.OnAccept = self.confirmation.OnAccept
		popUp.OnCancel = self.confirmation.OnCancel
		popUp.OnHide = self.confirmation.OnHide
		
		StaticPopup_Show("ATLASLOOT_CONFIRM_OPTIONS_BUTTON", nil, nil, self)
]]
	elseif self.OnClickFunc then
		self.OnClickFunc(self, button)
	end
end

local widgetMethods = {
	OnAdd = function(self)
		wipe(self.confirmation)
		self:Click()
		return self
	end,
	Text = function(self, text)
		self.frame:SetText(text)
		local newWidth = self.frame:GetTextWidth() + FIX_SIZE
		self.frame:SetWidth(newWidth < MIN_WIDTH and MIN_WIDTH or newWidth)
		return self
	end,
	Click = function(self, OnClick)
		self.OnClickFunc = OnClick
		return self
	end,
	Raw_Confirm = function(self, text, OnAccept, OnCancel, OnHide)
		if text then
			self.confirmation.text = text
			self.confirmation.OnAccept = OnAccept
			self.confirmation.OnCancel = OnCancel
			self.confirmation.OnHide = OnHide
		end
		return self
	end,
	Confirm = function(self, text)
		self.confirmation.text = text
		
		self:Raw_Confirm(text, Confirm_OnAccept, Confirm_OnCancel, Confirm_OnCancel)
		
		return self
	end,
}


local function Create()
	local frame = CreateFrame("BUTTON", frameName, nil, "UIPanelButtonTemplate")
	frame:SetHeight(22)
	frame:SetScript("OnClick", Button_OnClick)
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetAllPoints(frame)
	text:SetWordWrap(false)
	text:SetJustifyH("CENTER")
	text:SetJustifyV("MIDDLE")
	
	local widget = {
		frame = frame,
		text = text,
		type = Type,
		version = Version,
		confirmation = {},
	}
	frame.obj = widget
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
