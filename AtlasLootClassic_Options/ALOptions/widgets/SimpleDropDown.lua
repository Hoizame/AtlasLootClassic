local Type, Version = "SimpleDropDown", 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or ALOptions.GUI:GetWidgetTypeVersion(Type) > Version then return end

local pairs = pairs

local widgetMethods = {
	-- :Content({
	--	{ name = "LocString", key = "OnSetKey", textColor = "white" or {r=1,g=1,b=1,a=1} },
	--})
	Content = function(self, contentTable)
		
	end,
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
