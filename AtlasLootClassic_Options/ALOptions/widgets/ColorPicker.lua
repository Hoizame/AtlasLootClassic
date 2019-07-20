local Type, Version = "ColorPicker", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs

local widgetMethods = {
	OnAdd = function(self)
		--self:Justify():FontObject("GameFontNormal"):Color()
		return self
	end,
	OnDBSet = function(self)
		if self.dbCur then
			self.color:SetVertexColor(self.dbCur[1], self.dbCur[2], self.dbCur[3])
		end
	end,
	Text = function(self, text)
		self.text:SetText(text)
		return self
	end,
}

local function OnClick(frame, button)
	HideUIPanel(ColorPickerFrame)
	local self = frame.obj
	if not self.disabled and self.dbCur then
	
		ColorPickerFrame:SetFrameStrata("FULLSCREEN_DIALOG")
		ColorPickerFrame:SetFrameLevel(frame:GetFrameLevel() + 10)
		ColorPickerFrame:SetClampedToScreen(true)
		
		-- ColorPickerOkayButton
		ColorPickerFrame.func = function()
			local r, g, b = ColorPickerFrame:GetColorRGB()
			local a = 1 - OpacitySliderFrame:GetValue()
			self:SetDBValue({r, g, b, a})
		end
		
		-- OpacitySliderFrame -> OnValueChanged
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame.opacity = 1 - (self.dbCur[4] or 0)
		ColorPickerFrame.opacityFunc = function()
			local a = 1 - OpacitySliderFrame:GetValue()
			self:SetDBValue({self.dbCur[1], self.dbCur[2], self.dbCur[3], a})
		end
		
		
		self.lastColor = self.dbCur
		ColorPickerFrame:SetColorRGB(self.dbCur[1], self.dbCur[2], self.dbCur[3], self.dbCur[4])
		
		-- ColorPickerCancelButton
		ColorPickerFrame.cancelFunc = function()
			self:SetDBValue(self.lastColor)
			self.lastColor = nil
		end
		
		ShowUIPanel(ColorPickerFrame)
	end
end


local function Create()
	local frame = CreateFrame("BUTTON")
	frame:EnableMouse(true)
	frame:SetScript("OnClick", OnClick)
	
	local color = frame:CreateTexture(nil, "OVERLAY")
	color:SetWidth(19)
	color:SetHeight(19)
	color:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	color:SetPoint("LEFT", 2, 0)

	local bg = frame:CreateTexture(nil, "BACKGROUND")
	bg:SetWidth(16)
	bg:SetHeight(16)
	bg:SetTexture(1, 1, 1)
	bg:SetPoint("CENTER", color)
	bg:Show()
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("TOPLEFT", bg, "TOPRIGHT", 4, 0)
	text:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 2, 0)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	text:SetWordWrap(false)
	
	local widget = {
		frame = frame,
		bg = bg,
		color = color,
		text = text,
		type = Type,
		version = Version,
		
		minHeight = 19,
	}
	frame.obj = widget
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
