local Type, Version = "Text", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local type = type
local pairs = pairs

local widgetMethods = {
	OnAdd = function(self)
		self:Justify():FontObject("GameFontNormal"):Color()
		return self
	end,
	Text = function(self, text)
		self.text:SetText(text)
		return self
	end,
	FontObject = function(self, fontObject)
		if self.curFontObject ~= fontObject then
			self.curFontObject = fontObject or "GameFontNormal"
			self.text:SetFontObject(self.curFontObject)
		end
		return self
	end,
	-- H = CENTER, LEFT, RIGHT
	-- V = BOTTOM, MIDDLE, TOP
	Justify = function(self, H, V)
		self.text:SetJustifyH(H or "LEFT")
		self.text:SetJustifyV(V or "MIDDLE")
		return self
	end,
	-- :Color("white" [, alpha])
	-- :Color(r, g, b, a)
	Color = function(self, colorOrR, g, b, a)
		return self:SetColorBase(self.text, colorOrR, g, b, a)
	end
}

local function Create()
	local frame = CreateFrame("FRAME")
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetAllPoints(frame)
	text:SetWordWrap(false)
	
	local widget = {
		frame = frame,
		text = text,
		type = Type,
		version = Version
	}
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
