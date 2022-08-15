local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local Set = AtlasLoot.Button:AddType("Set", "set")
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local ClickHandler = AtlasLoot.ClickHandler
local ItemSet

--local db

-- lua
local tonumber, type = _G.tonumber, _G.type
local pairs = _G.pairs
local split, format = string.split, _G.format

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local SetClickHandler = nil

local CLASS_COLOR_FORMAT = "|c%s%s|r"

ClickHandler:Add(
	"Set",
	{
		OpenSet = { "LeftButton", "None" },
		DressUp = { "LeftButton", "Ctrl" },
		WoWHeadLink = { "RightButton", "Shift" },
		--ChatLink = { "LeftButton", "Shift" },
		types = {
			OpenSet = true,
			DressUp = true,
			--ChatLink = true,
			WoWHeadLink = true,
		},
	},
	{
		{ "OpenSet", 	"OpenSet", 	"OpenSet desc" },
		{ "DressUp", 	AL["Dress up"], 	AL["Shows the item in the Dressing room"] },
		--{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		{ "WoWHeadLink", 	AL["Show WowHead link"], 	AL["Shows a copyable link for WoWHead"] },
	}
)

function Set.OnSet(button, second)
	if not SetClickHandler then
		SetClickHandler = ClickHandler:GetHandler("Set")

		ItemSet = AtlasLoot.Data.ItemSet
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.SetID = button.__atlaslootinfo.secType[2]

		button.secButton.SetName = ItemSet.GetSetName(button.secButton.SetID, true)
		button.secButton.Items = ItemSet.GetSetItems(button.secButton.SetID)
		button.secButton.ExtraFrameData = ItemSet.GetSetDataForExtraFrame(button.secButton.SetID)
		button.secButton.SetIcon = ItemSet.GetSetIcon(button.secButton.SetID, true)
		button.secButton.SetDescription = ItemSet.GetSetDescriptionString(button.secButton.SetID)
		button.secButton.SetBonusData = ItemSet.GetSetBonusString(button.secButton.SetID)

		Set.Refresh(button.secButton)
	else
		button.SetID = button.__atlaslootinfo.type[2]

		button.SetName = ItemSet.GetSetName(button.SetID, true)
		button.Items = ItemSet.GetSetItems(button.SetID)
		button.ExtraFrameData = ItemSet.GetSetDataForExtraFrame(button.SetID)
		button.SetIcon = ItemSet.GetSetIcon(button.SetID, true)
		button.SetDescription = ItemSet.GetSetDescriptionString(button.SetID)
		button.SetBonusData = ItemSet.GetSetBonusString(button.SetID)

		Set.Refresh(button)
	end
end

function Set.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = SetClickHandler:Get(mouseButton) or mouseButton
	if mouseButton == "ChatLink" then
		--local itemInfo, itemLink = GetItemInfo(button.ItemString or button.ItemID)
		--itemLink = itemLink or button.ItemString
		--AtlasLoot.Button:AddChatLink(itemLink or "item:"..button.ItemID)
	elseif mouseButton == "WoWHeadLink" then
		AtlasLoot.Button:OpenWoWHeadLink(button, "item-set", button.SetID)
	elseif mouseButton == "DressUp" then
		if button.Items then
			for i = 1, #button.Items do
				DressUpItemLink(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
			end
		end
	elseif mouseButton == "OpenSet" then
		Set.OnClickItemList(button)
	elseif mouseButton == "MouseWheelUp" and Set.tooltipFrame then  -- ^
		local frame = Set.tooltipFrame.modelFrame
		if IsAltKeyDown() then -- model zoom
			frame.zoomLevelNew = frame.zoomLevelNew + 0.1 >= frame.maxZoom and frame.maxZoom or frame.zoomLevelNew + 0.1
			frame:SetPortraitZoom(frame.zoomLevelNew)
		else -- model rotation
			frame.curRotation = frame.curRotation + 0.1
			frame:SetRotation(frame.curRotation)
		end
	elseif mouseButton == "MouseWheelDown" and Set.tooltipFrame then	-- v
		local frame = Set.tooltipFrame.modelFrame
		if IsAltKeyDown() then -- model zoom
			frame.zoomLevelNew = frame.zoomLevelNew - 0.1 <= frame.minZoom and frame.minZoom or frame.zoomLevelNew - 0.1
			frame:SetPortraitZoom(frame.zoomLevelNew)
		else -- model rotation
			frame.curRotation = frame.curRotation - 0.1
			frame:SetRotation(frame.curRotation)
		end
	end
end

function Set.OnEnter(button, owner)
	Set.ShowToolTipFrame(button)
end

function Set.OnLeave(button)
	if Set.tooltipFrame then Set.tooltipFrame:Hide() end
end

function Set.OnClear(button)
	button.SetName = nil
	button.Items = nil
	button.ExtraFrameData = nil
	button.SetIcon = nil
	button.SetDescription = nil
	button.SetID = nil
	button.SetBonusData = nil

	button.secButton.SetName = nil
	button.secButton.Items = nil
	button.secButton.ExtraFrameData = nil
	button.secButton.SetIcon = nil
	button.secButton.SetDescription = nil
	button.secButton.SetID = nil
	button.secButton.SetBonusData = nil
	if button.ExtraFrameShown then
		AtlasLoot.Button:ExtraItemFrame_ClearFrame()
		button.ExtraFrameShown = false
	end
end

function Set.Refresh(button)
	if button.type == "secButton" then
		button:SetNormalTexture(button.SetIcon)
	else
		button.icon:SetTexture(button.SetIcon)
		button.name:SetText(button.SetName)
		if button.SetDescription then
			button.extra:SetText(button.SetDescription)
		end
	end
	if AtlasLoot.db.ContentPhase.enableOnSets then
		local phaseT, active = ItemSet.GetPhaseTextureForSetID(button.SetID)
		if phaseT and not active then
			button.phaseIndicator:SetTexture(phaseT)
			button.phaseIndicator:Show()
		end
	end

	return true
end

function Set.GetStringContent(str)
	return tonumber(str)
end

-- #########
-- Tooltip
-- #########

function Set.OnClickItemList(button)
	if not button.ExtraFrameData then return end
	button.ExtraFrameShown = true
	AtlasLoot.Button:ExtraItemFrame_GetFrame(button, button.ExtraFrameData)
end

function Set.ShowToolTipFrame(button)
	if not button.Items then return end
	if not Set.tooltipFrame then
		local name = "AtlasLoot-SetToolTip"
		local frame = CreateFrame("Frame", name)
		frame:SetClampedToScreen(true)
		frame:SetSize(230, 280)

		frame.modelFrame = CreateFrame("DressUpModel", name.."-ModelFrame", frame, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
		frame.modelFrame:ClearAllPoints()
		frame.modelFrame:SetParent(frame)
		frame.modelFrame:SetAllPoints(frame)
		frame.modelFrame.defaultRotation = MODELFRAME_DEFAULT_ROTATION
		frame.modelFrame:SetRotation(MODELFRAME_DEFAULT_ROTATION)
		frame.modelFrame:SetBackdrop(ALPrivate.BOX_BORDER_BACKDROP)
		frame.modelFrame:SetBackdropColor(0,0,0,1)
		frame.modelFrame:SetUnit("player")
		frame.modelFrame.minZoom = 0
		frame.modelFrame.maxZoom = 1.0
		frame.modelFrame.curRotation = MODELFRAME_DEFAULT_ROTATION
		frame.modelFrame.zoomLevel = frame.modelFrame.minZoom
		frame.modelFrame.zoomLevelNew = frame.modelFrame.zoomLevel
		frame.modelFrame:SetPortraitZoom(frame.modelFrame.zoomLevel)
		frame.modelFrame.Reset = _G.Model_Reset

		frame.bonusDataFrame = CreateFrame("Frame", name.."-bonus", frame, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
		frame.bonusDataFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, -2)
		frame.bonusDataFrame:SetSize(230, 50)
		frame.bonusDataFrame:SetBackdrop(ALPrivate.BOX_BORDER_BACKDROP)
		frame.bonusDataFrame:SetBackdropColor(0,0,0,1)

		frame.bonusDataFrame.text = frame.bonusDataFrame:CreateFontString(name.."-bonusText", "ARTWORK", "GameFontNormalSmall")
		frame.bonusDataFrame.text:SetPoint("TOPLEFT", frame.bonusDataFrame, 5, -5)
		frame.bonusDataFrame.text:SetPoint("TOPRIGHT", frame.bonusDataFrame, -5, -5)
		frame.bonusDataFrame.text:SetPoint("BOTTOM", frame.bonusDataFrame, 0, 5)
		frame.bonusDataFrame.text:SetJustifyH("LEFT")
		frame.bonusDataFrame.text:SetText("")

		Set.tooltipFrame = frame
		frame:Hide()
	end

	local frame = Set.tooltipFrame

	frame:Show()

	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetFrameLevel(button:GetFrameLevel() + 1)
	frame:SetPoint("BOTTOMLEFT", button, "TOPLEFT", (button:GetWidth() * 0.5), 5)

	frame = Set.tooltipFrame.modelFrame
	frame:Reset()
	frame:Undress()
	frame:SetRotation(frame.curRotation)
	frame:SetPortraitZoom(frame.zoomLevelNew)
	for i = 1, #button.Items do
		frame:TryOn(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
	end

	if not button.SetBonusData then
		button.SetBonusData = ItemSet.GetSetBonusString(button.SetID)
	end

	if button.SetBonusData then
		Set.tooltipFrame.bonusDataFrame:Show()
		Set.tooltipFrame.bonusDataFrame:SetFrameStrata("TOOLTIP")
		Set.tooltipFrame.bonusDataFrame:SetFrameLevel(button:GetFrameLevel() + 1)
		Set.tooltipFrame.bonusDataFrame.text:SetText(button.SetBonusData)
		Set.tooltipFrame.bonusDataFrame:SetHeight(Set.tooltipFrame.bonusDataFrame.text:GetStringHeight()+14)
		Set.tooltipFrame:SetPoint("BOTTOMLEFT", button, "TOPLEFT", (button:GetWidth() * 0.5), 5 + Set.tooltipFrame.bonusDataFrame:GetHeight())
	else
		Set.tooltipFrame.bonusDataFrame:Hide()
	end
end
