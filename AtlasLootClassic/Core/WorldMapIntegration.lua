-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, select = _G.pairs, _G.select
-- Libraries

-- WoW
local GetAddOnInfo, GetAddOnEnableState, UnitName, GetRealmName = _G.GetAddOnInfo, _G.GetAddOnEnableState, _G.UnitName, _G.GetRealmName
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local WorldMap = {}
AtlasLoot.WorldMap = WorldMap
local AL = AtlasLoot.Locales
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local profile

local function checkAddonStatus(addonName)
	if not addonName then return nil end
	local loadable = select(4, GetAddOnInfo(addonName))
	local enabled = GetAddOnEnableState(UnitName("player"), addonName)
	if (enabled > 0 and loadable) then
		return true
	else
		return false
	end
end

local function AdjustOtherWorldMapButton(adjust)
	profile = AtlasLoot.db.WorldMap

	if (not (checkAddonStatus("Mapster") or checkAddonStatus("HandyNotes_WorldMapButton") or checkAddonStatus("ElvUI"))) then return end
	local ElvUI_BZSkin = false
	if (checkAddonStatus("ElvUI") and ElvPrivateDB) then
		local profileKey
		if ElvPrivateDB.profileKeys then
			profileKey = ElvPrivateDB.profileKeys[UnitName("player")..' - '..GetRealmName()]
		end

		if profileKey and ElvPrivateDB.profiles and ElvPrivateDB.profiles[profileKey] and ElvPrivateDB.profiles[profileKey]["skins"] then
			if (ElvPrivateDB.profiles[profileKey]["skins"]["blizzard"]["enable"] and ElvPrivateDB.profiles[profileKey]["skins"]["blizzard"]["worldmap"]) then
				ElvUI_BZSkin = true
			end
		end
	end

	if (checkAddonStatus("ElvUI") and profile.buttonOnTitleBar and ElvUI_BZSkin) then
		local button = _G["AtlasLootToggleFromWorldMap2"]
		button:SetNormalTexture("Interface\\Icons\\INV_Box_01")
		button:SetWidth(16)
		button:SetHeight(16)
		button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
	end

	local HandyNotesButton = _G["HandyNotesWorldMapButton"]
	if (HandyNotesButton) then
		if (adjust) then
			HandyNotesButton:SetPoint("TOPRIGHT", WorldMapFrame.BorderFrame, "TOPRIGHT", -72, -3)
		else
			HandyNotesButton:SetPoint("TOPRIGHT", WorldMapFrame.BorderFrame, "TOPRIGHT", -48, -3)
		end
	end

	local mapsterButton = _G["MapsterOptionsButton"]
	if (mapsterButton and mapsterButton:IsShown()) then
		if (adjust) then
			if (HandyNotesButton) then
				mapsterButton:SetPoint("TOPRIGHT", WorldMapTitleButton, "TOPRIGHT", -40, -3)
			else
				mapsterButton:SetPoint("TOPRIGHT", WorldMapTitleButton, "TOPRIGHT", -20, -3)
			end
		else
			if (HandyNotesButton) then
				mapsterButton:SetPoint("TOPRIGHT", WorldMapTitleButton, "TOPRIGHT", -16, -3)
			else
				mapsterButton:SetPoint("TOPRIGHT", WorldMapTitleButton, "TOPRIGHT", 0, -3)
			end
		end
	end

end

local function ButtonBinding()
	local button = _G["AtlasLootToggleFromWorldMap2"]
	if (not button) then
		button = CreateFrame("Button", "AtlasLootToggleFromWorldMap2", WorldMapFrame.BorderFrame)
		button:SetWidth(32)
		button:SetHeight(32)

		--button:SetPoint("TOPRIGHT", WorldMapFrameSizeDownButton, -24, 0, "TOPRIGHT")
		button:SetPoint("LEFT", WorldMapFrame.BorderFrame.MaximizeMinimizeFrame, -24, 0, "RIGHT")
		button:SetNormalTexture("Interface\\AddOns\\AtlasLoot\\Images\\AtlasLootButton-Up")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")

		button:SetScript("OnEnter", WorldMap.Button_OnEnter)
		button:SetScript("OnLeave", WorldMap.Button_OnLeave)
		button:SetScript("OnClick", WorldMap.Button_OnClick)
		button:SetScript("OnShow", AdjustOtherWorldMapButton)
	end
end

function WorldMap.Init()
	profile = AtlasLoot.db.WorldMap
	local button

	if (profile.buttonOnTitleBar) then
		ButtonBinding()
		button = _G["AtlasLootToggleFromWorldMap2"]
	else
		button = _G["AtlasLootToggleFromWorldMap1"]
	end

	if (profile.showbutton) then
		button:Show()
	else
		button:Hide()
	end
end
AtlasLoot:AddInitFunc(WorldMap.Init)

function WorldMap.ToggleButtonOnChange()
	local button
	if (profile.buttonOnTitleBar) then
		button = _G["AtlasLootToggleFromWorldMap2"]
		if (not button) then ButtonBinding() end
		button = _G["AtlasLootToggleFromWorldMap2"]
	else
		button = _G["AtlasLootToggleFromWorldMap1"]
	end

	if (profile.showbutton) then
		if (profile.buttonOnTitleBar) then
			AdjustOtherWorldMapButton(true)
		end
		button:Show()
	else
		if (profile.buttonOnTitleBar) then
			AdjustOtherWorldMapButton(false)
		end
		button:Hide()
	end
end

function WorldMap.ButtonStyleOnChange(styleID)
	if (not profile.showbutton) then return end
	local button1 = _G["AtlasLootToggleFromWorldMap1"]
	local button2 = _G["AtlasLootToggleFromWorldMap2"]

	if (profile.buttonOnTitleBar) then
		button1:Hide()
		if (not button2) then ButtonBinding() end
		button2 = _G["AtlasLootToggleFromWorldMap2"]
		button2:Show()
		AdjustOtherWorldMapButton(true)
	else
		button1:Show()
		button2:Hide()
		AdjustOtherWorldMapButton(false)
	end
end

function WorldMap.Button_OnEnter(self)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	-- No owner?
	--if owner and type(owner) == "table" then
	--	tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	--else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 5)
	--end
	tooltip:AddLine(AL["Click to open AtlasLoot window"])
	tooltip:Show()
end

function WorldMap.Button_OnLeave(self)
	GetAlTooltip():Hide()
end

function WorldMap.Button_OnClick(self, button)
	if (not AtlasLoot.GUI.frame:IsVisible()) then
		AtlasLoot.GUI.frame:Show()
	end
	ToggleFrame(WorldMapFrame)
end

