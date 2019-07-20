--[[
	type = "CheckBox"
	
	-- ################################
	-- widget specific entries
	-- ################################
	
]]--
local Type, Version = "CheckBox", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or (ALOptions.GUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- lua
local pairs = pairs

-- WoW 
local CreateFrame = CreateFrame

-- const
local function RefreshMouseDown(frame)
	if frame.mouseDown then
		frame.obj.boxBg:SetBackdropColor(0,0,1,1)
	else
		if frame.obj.checked then
			frame.obj.boxBg:SetBackdropColor(0,1,0,1)
		else
			frame.obj.boxBg:SetBackdropColor(1,0,0,1)
		end
	end
end

local function OnEnter(frame)
	
end

local function OnLeave(frame)
	frame.mouseDown = false
	RefreshMouseDown(frame)
end

local function OnMouseDown(frame)
	frame.mouseDown = true
	RefreshMouseDown(frame)
end

local function OnMouseUp(frame)
	if not frame.mouseDown then return end
	frame.mouseDown = false
	frame.obj:SetChecked(not frame.obj.checked)
	RefreshMouseDown(frame)
end

local widgetFunctions = {
	--["OnLoad"] = function(self)
		
	--end,
	["SetText"] = function(self, text)
		self.text:SetText(text or "")
		self.frame:SetWidth(6+self.boxBg:GetWidth()+self.textBg:GetWidth())
	end,
	["SetChecked"] = function(self, checked, noValueUpdate)
		if checked then
			self.check:Show()
			self.checked = true
		else
			self.check:Hide()
			self.checked = false
		end
		if not noValueUpdate and self.OnValueUpdate then
			self:OnValueUpdate(self.checked)
		end
		RefreshMouseDown(self.frame)
	end,
}

local function Create()
	local frame = CreateFrame("Frame")
	frame:SetSize(100,18)
	frame:SetPoint("CENTER")
	--background
	frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	frame:SetBackdropColor(ALOptions.GUI:GetBackgroundColor())
	
	frame:SetScript("OnEnter", OnEnter)
	frame:SetScript("OnLeave", OnLeave)
	frame:SetScript("OnMouseDown", OnMouseDown)
	frame:SetScript("OnMouseUp", OnMouseUp)
	
	-- boxframe
	local boxBg = CreateFrame("Frame", nil, frame)
	boxBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
	boxBg:SetSize(14,14)
	boxBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	boxBg:SetBackdropColor(0,0,0,1)
	
	-- text bg
	local textBg = CreateFrame("Frame", nil, frame)
	
	-- text
	local text = textBg:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text:SetPoint("TOPLEFT", boxBg, "TOPRIGHT", 4, 0)
	text:SetPoint("BOTTOMLEFT", boxBg, "BOTTOMRIGHT", 4, 0)
	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1,1)
	text:SetText("Text")
	
	-- set text BG's points
	textBg:SetPoint("TOPLEFT", text, "TOPLEFT", -2, 0)
	textBg:SetPoint("BOTTOMRIGHT", text, "BOTTOMRIGHT", 2, 0)
	textBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	textBg:SetBackdropColor(0,0,0,1)
	
	-- checktexture
	local check = boxBg:CreateTexture(nil, "OVERLAY")
	check:SetAllPoints(boxBg)
	check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	
	local widget = {
		
		frame = frame,
		boxBg = boxBg,
		textBg = textBg,
		text = text,
		check = check,
	}
	
	for k,v in pairs(widgetFunctions) do
		widget[k] = v
	end
	
	return ALOptions.GUI:RegisterAsWidget(widget)
end

--[[
local frame = Create()
frame:SetText("Moin Moin :)")
frame:SetChecked(false)
]]--
ALOptions.GUI:RegisterWidgetType(Type, Version, Create)
