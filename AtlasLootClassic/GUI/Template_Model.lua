local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

local MODELFRAME_DEFAULT_ROTATION = MODELFRAME_DEFAULT_ROTATION

local function SetTexture(self, ...)
	self.bg:SetTexture(...)
end

function GUI.CreateModelFrame(hasControls, name, parent)
	local frame = CreateFrame("DressUpModel", name, parent, hasControls and "ModelWithControlsTemplate" or nil)
	if parent then
		frame:ClearAllPoints()
		frame:SetParent(parent)
		frame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -5, -25)
	end
	frame.defaultRotation = MODELFRAME_DEFAULT_ROTATION
	frame:SetRotation(MODELFRAME_DEFAULT_ROTATION)
	frame:SetUnit("player")
	frame.minZoom = 0
	frame.maxZoom = 1.0
	frame.zoomLevel = frame.minZoom
	frame:SetPortraitZoom(frame.zoomLevel)

	-- bg
	frame.bg = frame:CreateTexture(nil, "BACKGROUND")
	frame.bg:SetAllPoints(frame)

	-- functions
	frame.SetParPoint = GUI.Temp_SetParPoint
	frame.Reset = _G.Model_Reset
	frame.SetTexture = SetTexture

	return frame
end
