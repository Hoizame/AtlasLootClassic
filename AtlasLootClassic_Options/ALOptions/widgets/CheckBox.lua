local Type, Version = "CheckBox", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs

local STD_SIZE = 24

local widgetMethods = {
	OnAdd = function(self)
		self:Text():TextColor()
		self:SetDisabled(nil)
		return self
	end,
	OnDBSet = function(self, value)
		if value then
			self.check:Show()
		else
			self.check:Hide()
		end
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
	SetDisabled = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.frame:Disable()
			self.text:SetTextColor(0.5, 0.5, 0.5)
			SetDesaturation(self.check, true)
		else
			self.frame:Enable()
			self.text:SetTextColor(1, 0.82, 0)
		end
	end,
	-- H = CENTER, LEFT, RIGHT
	-- V = BOTTOM, MIDDLE, TOP
	TextJustify = function(self, H, V)
		self.text:SetJustifyH(H or "LEFT")
		self.text:SetJustifyV(V or "MIDDLE")
		return self
	end,
	-- :TextColor("white" [, alpha])
	-- :TextColor(r, g, b, a)
	TextColor = function(self, colorOrR, g, b, a)
		return self:SetColorBase(self.text, colorOrR, g, b, a)
	end,
}

local function OnClick(self, button)
	self.obj:SetDBValue(not self.obj.dbCur)
end

local function Create()
	local frame = CreateFrame("BUTTON")
	frame:SetSize(STD_SIZE,STD_SIZE)
	
	frame:EnableMouse(true)
	frame:SetScript("OnClick", OnClick)
	
	local checkBg = frame:CreateTexture(nil, "ARTWORK")
	checkBg:SetSize(STD_SIZE,STD_SIZE)
	checkBg:SetPoint("LEFT")
	checkBg:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
	
	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(checkBg)
	
	local check = frame:CreateTexture(nil, "OVERLAY")
	check:SetAllPoints(checkBg)
	check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("TOPLEFT", checkBg, "TOPRIGHT", 2, 0)
	text:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	text:SetWordWrap(false)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	
	local widget = {
		frame = frame,
		checkBg = checkBg,
		text = text,
		check = check,
		
		type = Type,
		version = Version,
		
		minHeight = STD_SIZE,
		maxHeight = STD_SIZE,
	}
	frame.obj = widget
	
	for method, func in pairs(widgetMethods) do
		widget[method] = func
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
