local Type, Version = "Slider", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs
local min, max, floor = min, max, floor
local format = format

local DATA_TYPE_TABLE = "table"
local PERCENT_FORMAT = "%d%%"

local function UpdateStateText(self)
	if self.dataType == DATA_TYPE_TABLE then
		self.stateText:SetText(self.dataTable[self.value][1])
	elseif self.isPercent then
		self.stateText:SetText(format(PERCENT_FORMAT, self.value))
	else
		self.stateText:SetText(self.value)
	end
end

local widgetMethods = {
	OnAdd = function(self)
		self:MinMaxStep():Percent()
		self.dataType = nil
		self.dataTable = nil
		return self
	end,
	Text = function(self, text)
		self.text:SetText(text)
		return self
	end,
	Type = function(self, typ)
		self.dataType = typ
		return self
	end,
	MinMaxStep = function(self, minValue, maxValue, step)
		local slider = self.slider
		
		self.min = minValue
		self.max = maxValue
		self.step = step
		
		slider:SetMinMaxValues(minValue or 0,maxValue or 100)
		slider:SetValueStep(step or 1)
		return self
	end,
	-- {
	-- 		{ name, value }
	-- }
	DataSteps = function(self, data)
		if not data or type(data) ~= "table" then return end
		self.dataType = DATA_TYPE_TABLE
		self.dataTable = data
		
		self:MinMaxStep(1, #data, 1)
		return self
	end,
	Percent = function(self, percent)
		self.isPercent = percent
		return self
	end,
	OnDBSet = function(self, value)
		if not self.value or (self.value and (( self.dataTable and self.dataTable[self.value] and self.dataTable[self.value][2] ~= self.dbCur)) or self.value ~= self.dbCur) then
			if self.dataTable and type(self.dbCur) == "string" then
				for i = 1, #self.dataTable do
					if self.dataTable[i][2] == self.dbCur then
						self.value = i
						break
					end
				end
				self.value = self.value or 1
			else
				self.value = self.dbCur
			end
			
			self.slider:SetValue(self.value)
		end
		
		UpdateStateText(self)
	end,
}

local function Slider_OnValueChanged(frame)
	local self = frame.obj
	
	local newValue = frame:GetValue()
	if self.step and self.step > 0 then
		local min_value = self.min or 0
		newValue = floor((newValue - min_value) / self.step + 0.5) * self.step + min_value
	end
	if newValue ~= self.value and not self.disabled then
		self.value = newValue
		if self.dataType == DATA_TYPE_TABLE then
			self:SetDBValue(self.dataTable[newValue][2])
		else
			self:SetDBValue(newValue)
		end
	end
	if self.value then
		UpdateStateText(self)
	end
end

local function Slider_OnMouseUp(frame)
	local self = frame.obj
	if self.dataType == DATA_TYPE_TABLE then
		self:SetDBValue(self.dataTable[self.value][2])
	else
		self:SetDBValue(self.value)
	end
end

local function Slider_OnMouseWheel(frame, way)
	local self = frame.obj
	local value = self.value
	if way > 0 then
		value = min(value + (self.step or 1), self.max)
	else
		value = max(value - (self.step or 1), self.min)
	end
	self.slider:SetValue(value)
end

local SliderBackdrop  = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true, tileSize = 8, edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}

local function Create()
	local frame = CreateFrame("FRAME")
	frame:EnableMouse(true)
	
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	text:SetHeight(15)
	text:SetWordWrap(false)
	
	local slider = CreateFrame("Slider", nil, frame)
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(15)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetBackdrop(SliderBackdrop)
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetPoint("TOPLEFT", text, "BOTTOMLEFT")
	slider:SetPoint("LEFT", 3, 0)
	slider:SetPoint("RIGHT", -3, 0)
	slider:SetScript("OnValueChanged",Slider_OnValueChanged)
	slider:SetScript("OnEnter", Control_OnEnter)
	slider:SetScript("OnLeave", Control_OnLeave)
	slider:SetScript("OnMouseUp", Slider_OnMouseUp)
	slider:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	
	local stateText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	stateText:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT")
	stateText:SetJustifyH("RIGHT")
	stateText:SetJustifyV("MIDDLE")
	stateText:SetTextColor(1, 1, 1, 1)
	stateText:SetWordWrap(false)
	
	local widget = {
		text = text,
		slider = slider,
		stateText = stateText,
		
		frame = frame,
		type = Type,
		version = Version,
		
		minHeight = 35,
		minWidth = 100,
	}
	slider.obj = widget
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
