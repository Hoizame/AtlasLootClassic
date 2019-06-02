local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local Set = AtlasLoot.Button:AddType("Set", "set")
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler
local Sets
local SVF

local db

-- lua
local tonumber, type = tonumber, type
local assert = assert
local next, wipe, tab_remove = next, wipe, table.remove
local format, split = string.format, string.split

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

local SetClickHandler = nil

function Set.OnSet(button, second)
	if not SetClickHandler then
		db = AtlasLoot.db.Button.Set
		SetClickHandler = ClickHandler:Add(
		"Set",
		{
			OpenSet = { "LeftButton", "None" },
			DressUp = { "LeftButton", "Ctrl" },
			--ChatLink = { "LeftButton", "Shift" },
			types = {
				OpenSet = true,
				DressUp = true,
				--ChatLink = true,
			},
		},
		db.ClickHandler,
		{
			{ "OpenSet", 	"OpenSet", 	"OpenSet desc" },
			{ "DressUp", 	AL["Dress up"], 	AL["Shows the item in the Dressing room"] },
			--{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		})
		SVF = AtlasLoot.GUI.SetViewFrame
		Sets = AtlasLoot.Data.Sets
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.SetName = button.__atlaslootinfo.secType[2][1]
		button.secButton.SubSetName = button.__atlaslootinfo.secType[2][2]
		button.secButton.SetDiff = button.__atlaslootinfo.secType[2][3]
		button.secButton.SetAddonName = button.__atlaslootinfo.secType[2][4] or (AtlasLoot.GUI.ItemFrame.LinkedInfo and (AtlasLoot.GUI.ItemFrame.LinkedInfo[1] or AtlasLoot.db.GUI.selected[1]) or AtlasLoot.db.GUI.selected[1])
		local set = Sets:GetSet(button.secButton.SetName, button.secButton.SetAddonName)
		
		button.secButton.VisualName, button.secButton.VisualDesc, button.secButton.VisualIcon = set:GetInfo(button.secButton.SubSetName, set:GetNextPrevDifficulty(button.secButton.SubSetName, button.secButton.SetDiff))
		button.secButton.Items = set:GetDiffTable(button.secButton.SubSetName, button.secButton.SetDiff)
		if not set then
			error("Set \""..button.secButton.SetName.." / "..button.secButton.SetAddonName.."\" not found")
		end
		Set.Refresh(button.secButton)
	else
		button.SetName = button.__atlaslootinfo.type[2][1]
		button.SubSetName = button.__atlaslootinfo.type[2][2]
		button.SetDiff = button.__atlaslootinfo.type[2][3]
		button.SetAddonName = button.__atlaslootinfo.type[2][4] or (AtlasLoot.GUI.ItemFrame.LinkedInfo and (AtlasLoot.GUI.ItemFrame.LinkedInfo[1] or AtlasLoot.db.GUI.selected[1]) or AtlasLoot.db.GUI.selected[1])
		local set = Sets:GetSet(button.SetName, button.SetAddonName)
		if not set then
			error("Set \""..button.SetName.." / "..button.SetAddonName.."\" not found")
		end
		button.VisualName, button.VisualDesc, button.VisualIcon = set:GetInfo(button.SubSetName, set:GetNextPrevDifficulty(button.SubSetName, button.SetDiff))
		button.Items = set:GetDiffTable(button.SubSetName, button.SetDiff)
		
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
	elseif mouseButton == "DressUp" then
		for i = 1, #button.Items do
			DressUpItemLink(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
		end
	elseif mouseButton == "OpenSet" then
		SVF:SetAtlasLootItemSet(button.SetName, button.SetAddonName or AtlasLoot.db.GUI.selected[1], button.SubSetName, button.SetDiff)
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
	button.SubSetName = nil
	button.SetDiff = nil
	button.SetAddonName = nil
	button.Items = nil
	button.VisualName, button.VisualDesc, button.VisualIcon = nil, nil, nil
	
	button.secButton.SetName = nil
	button.secButton.SubSetName = nil
	button.secButton.SetDiff = nil
	button.secButton.SetAddonName = nil
	button.secButton.Items = nil
	button.secButton.VisualName, button.secButton.VisualDesc, button.secButton.VisualIcon = nil, nil, nil
end

function Set.Refresh(button)
	if button.type == "secButton" then
		button:SetNormalTexture(button.VisualIcon)
	else	
		button.icon:SetTexture(button.VisualIcon)
		button.name:SetText(button.VisualName)
		button.extra:SetText(button.VisualDesc)
	end

	return true
end

function Set.GetStringContent(str)
	return {
		split(":", str)
	}
end

-- #########
-- Tooltip
-- #########

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
	frame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT")
	
	frame = Set.tooltipFrame.modelFrame
	frame:Reset()
	frame:Undress()
	frame:SetRotation(frame.curRotation)
	frame:SetPortraitZoom(frame.zoomLevelNew)
	for i = 1, #button.Items do
		frame:TryOn(type(button.Items[i]) == "string" and button.Items[i] or "item:"..button.Items[i])
	end
	
	
end
