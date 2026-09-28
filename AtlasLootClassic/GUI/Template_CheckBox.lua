-- Modified by HoliestWoW on 2026-09-17: Replaced deprecated OptionsCheckButtonTemplate with UICheckButtonTemplate and manually generated text label.

local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

-- lua
local assert, type = assert, type

--//\\
local CHECK_BOX_COUNT = 0

local function SetOnClickFunc(self, func)
	assert(type(func)=="function", "'func' must be a function")
	self.onClickFunc = func
end

local function SetChecked(self, checked)
	self.frame:SetChecked(checked)
	self.checked = checked
end

local function SetText(self, text)
	self.frame.text:SetText(text or "")
end


local function OnClick(self, ...)
	if self.obj.onClickFunc then
		self.obj:onClickFunc(self:GetChecked())
	end
end

function GUI.CreateCheckBox()
	CHECK_BOX_COUNT = CHECK_BOX_COUNT + 1
	local frameName = "AtlasLoot-CheckBox-"..CHECK_BOX_COUNT
	local self = {}

	-- functions
	self.SetParPoint = GUI.Temp_SetParPoint
	self.SetOnClickFunc = SetOnClickFunc
	self.SetChecked = SetChecked
	self.SetText = SetText

	-- data
	self.onClickFunc = nil	-- Run on OnClick
	self.checked = false

	self.frame = CreateFrame("CheckButton", frameName, nil, "UICheckButtonTemplate")
	self.frame:SetWidth(25)
	self.frame:SetHeight(25)
	self.frame:SetScript("OnClick", OnClick)
	self.frame.obj = self
	self.frame.text = _G[frameName.."Text"]
	if not self.frame.text then
		self.frame.text = self.frame:CreateFontString(frameName.."Text", "ARTWORK", "GameFontNormal")
		self.frame.text:SetPoint("LEFT", self.frame, "RIGHT", 4, 0)
	end

	return self
end
