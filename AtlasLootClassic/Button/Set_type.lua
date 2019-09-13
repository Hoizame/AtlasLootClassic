local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local Set = AtlasLoot.Button:AddType("Set", "set")
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local ClickHandler = AtlasLoot.ClickHandler
local Sets

--local db

-- lua
local tonumber, type = _G.tonumber, _G.type
local pairs = _G.pairs
local split, format = string.split, _G.format

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local SetClickHandler = nil

local CLASS_COLOR_FORMAT = "|c%s%s|r"
local CLASS_NAMES_WITH_COLORS = {}

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

		for k,v in pairs(RAID_CLASS_COLORS) do
			if v.colorStr then
				CLASS_NAMES_WITH_COLORS[k] = format(CLASS_COLOR_FORMAT,  v.colorStr, ALIL[k] or k)
			end
		end
		CLASS_COLOR_FORMAT = nil

		Sets = AtlasLoot.Data.Sets
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.SetID = button.__atlaslootinfo.secType[2]

		local name, items, icon, classID, className = Sets:GetItemSetData(button.secButton.SetID)
		button.secButton.SetName = name
		button.secButton.Items = items
		button.secButton.SetIcon = icon
		button.secButton.SetClassName = className

		Set.Refresh(button.secButton)
	else
		button.SetID = button.__atlaslootinfo.type[2]

		local name, items, icon, classID, className = Sets:GetItemSetData(button.SetID)
		button.SetName = name
		button.Items = items
		button.SetIcon = icon
		button.SetClassName = className

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
		for i = 1, #button.Items do
			DressUpItemLink(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
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
	button.SetIcon = nil
	button.SetClassName = nil
	button.SetID = nil

	button.secButton.SetName = nil
	button.secButton.Items = nil
	button.secButton.SetIcon = nil
	button.secButton.SetClassName = nil
	button.secButton.SetID = nil
	AtlasLoot.Button:ExtraItemFrame_ClearFrame()
end

function Set.Refresh(button)
	if button.type == "secButton" then
		button:SetNormalTexture(button.SetIcon)
	else
		button.icon:SetTexture(button.SetIcon)
		button.name:SetText(Sets:GetSetColor(button.SetID)..button.SetName)
		if button.SetClassName then
			button.extra:SetText(CLASS_NAMES_WITH_COLORS[button.SetClassName])
		end
	end
	if AtlasLoot.db.ContentPhase.enableOnSets then
		local phaseT = Sets:GetPhaseTextureForSetID(button.SetID)
		if phaseT then
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
	if not button.Items then return end
	AtlasLoot.Button:ExtraItemFrame_GetFrame(button, button.Items)
end

function Set.ShowToolTipFrame(button)
	if not button.Items then return end
	if not Set.tooltipFrame then
		local name = "AtlasLoot-SetToolTip"
		local frame = CreateFrame("Frame", name)
		frame:SetClampedToScreen(true)
		frame:SetSize(230, 280)

		frame.modelFrame = CreateFrame("DressUpModel", name.."-ModelFrame", frame)
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

		Set.tooltipFrame = frame
		frame:Hide()
	end

	local frame = Set.tooltipFrame

	frame:Show()

	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPLEFT", (button:GetWidth() * 0.5), 5)

	frame = Set.tooltipFrame.modelFrame
	frame:Reset()
	frame:Undress()
	frame:SetRotation(frame.curRotation)
	frame:SetPortraitZoom(frame.zoomLevelNew)
	for i = 1, #button.Items do
		frame:TryOn(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
	end

end
