local Type, Version = "Line", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs

local widgetMethods = {
	OnAdd = function(self)
		self:Text():TextColor()
		return self
	end,
	Text = function(self, text)
		self.text:SetText(text)
		if text and text ~= "" then
			self.lineLeft:SetPoint("RIGHT", self.text, "LEFT", -5, 0)
			self.lineRight:Show()
		else
			self.lineLeft:SetPoint("RIGHT", -3, 0)
			self.lineRight:Hide()
		end
		return self
	end,
	TextColor = function(self, colorOrR, g, b, a)
		return self:SetColorBase(self.text, colorOrR, g, b, a)
	end,
}

-- from AceGUI's Heading <3
local function Create()
	local frame = CreateFrame("FRAME")
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("TOP")
	text:SetPoint("BOTTOM")
	text:SetWordWrap(false)
	text:SetJustifyH("CENTER")
	
	local lineLeft = frame:CreateTexture(nil, "BACKGROUND")
	lineLeft:SetHeight(8)
	lineLeft:SetPoint("LEFT", 3, 0)
	lineLeft:SetPoint("RIGHT", text, "LEFT", -5, 0)
	lineLeft:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
	lineLeft:SetTexCoord(0.81, 0.94, 0.5, 1)
	
	local lineRight = frame:CreateTexture(nil, "BACKGROUND")
	lineRight:SetHeight(8)
	lineRight:SetPoint("RIGHT", -3, 0)
	lineRight:SetPoint("LEFT", text, "RIGHT", 5, 0)
	lineRight:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
	lineRight:SetTexCoord(0.81, 0.94, 0.5, 1)

	local widget = {
		frame = frame,
		text = text,
		lineLeft = lineLeft,
		lineRight = lineRight,
		type = Type,
		version = Version,
		
		minHeight = 8,
		maxHeight = 8,
	}
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
