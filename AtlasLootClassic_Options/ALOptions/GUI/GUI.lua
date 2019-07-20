local Version = 1
local ALOptions = LibStub and LibStub("ALOptions-1.0", true)
if not ALOptions or (ALOptions:GetGUIVersion() or 0) >= Version then return end

local GUI = {}
ALOptions.GUI = GUI
-- contains all widget types
local WidgetTypeVersions = {}
local WidgetTypeCreates = {}

-- lua

function GUI:RegisterWidgetType(Type, Version, Create)
	assert(type(Version) == "number") 
	assert(type(Create) == "function")
	
	local oldVersion = WidgetTypeVersions[Type]
	if oldVersion and oldVersion >= Version then return end
	
	WidgetTypeVersions[Type] = Version
	WidgetTypeCreates[Type] = Create
end

function GUI:GetWidgetVersion(Type)
	return WidgetTypeVersions[Type]
end


function GUI:RegisterAsWidget(widget)
	widget.frame.obj = widget
	return widget
end

function GUI:GetBackgroundColor()
	return 0.478,0.545,0.545,1
end









ALOptions:SetGUIVersion(Version)
