local Type, Version = "Text", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs

local widgetMethods = {

}


local function Create()
	local frame = CreateFrame("FRAME")
	
	local widget = {
		frame = frame,
		type = Type,
		version = Version
	}
	
	for k,v in pairs(widgetMethods) do
		widget[k] = v
	end
	return ALOptions.GUI:SetWidgetBase(widget)
end
ALOptions.GUI:RegisterWidgetType(Type, Create, Version)
