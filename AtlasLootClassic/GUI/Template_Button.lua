local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

local BUTTON_COUNT = 0
local MIN_WIDTH = 40

local function setText(self, text)
	text = text or ""
	self:SetTextOri(text)
	local newWidth = self:GetTextWidth()+20
	self:SetWidth(newWidth < MIN_WIDTH and MIN_WIDTH or newWidth)
end

function GUI.CreateButton()
	BUTTON_COUNT = BUTTON_COUNT + 1

	local frameName = "AtlasLoot-Button-"..BUTTON_COUNT
	local frame = CreateFrame("BUTTON", frameName, nil, "UIPanelButtonTemplate")
	frame:SetText("")
	frame:SetWidth(MIN_WIDTH)
	frame:SetHeight(22)

	frame.SetPointOri = frame.SetPoint
	frame.SetPoint = GUI.Temp_SetParPoint

	frame.SetTextOri = frame.SetText
	frame.SetText = setText

	return frame
end
