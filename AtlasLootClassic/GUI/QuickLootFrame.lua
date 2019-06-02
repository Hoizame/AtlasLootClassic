local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local ItemDB = AtlasLoot.ItemDB
local Button = AtlasLoot.Button
local QLF = {}
AtlasLoot.GUI.QuickLootFrame = QLF
local AL = AtlasLoot.Locales

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

--lua
local rawset, type, unpack, setmetatable, pairs = rawset, type, unpack, setmetatable, pairs
local tonumber, table = tonumber, table
local floor = math.floor
local match, format = string.match, string.format

-- WoW
local GetNumSpecializations = GetNumSpecializations

local db

local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

--const
local QLF_FRAME_NAME = "AtlasLoot-QuickLootFrame"
local QLF_FRAME_WIDTH = 285
local QLF_FRAME_MIN_HEIGHT_STD = 54

local SELECTION_ICON_SIZE = 24

local ITEMS_PER_LINE = 9
local ITEM_SIZE = 24

local PAGE_NAME_DIFF = "%s (%s)"

local DIF_INFO = {
	--[0] = "none",	
	[1] = AL["Normal"],		-- 5 Player Dungeon
	[2] = AL["Heroic"],		-- 5 Player Heroic Dungeon
	[3] = AL["Normal"],		-- 10 Player
	[4] = AL["25 Player"],		-- 25 Player
	[5] = AL["Heroic"],		-- 10 Player Heroic
	[6] = AL["25 Player Heroic"],	-- 25 Player Heroic
	[7] = AL["Raid Finder"],
	--[8] = "CM",			-- Challenge Mode
	--[9] = "40 player",		-- 40 Player Raid
	--[10] = "unused",
	--[11] = "HC SC",		-- Heroic Scenario
	--[12] = "SC",			-- Scenario
	--[13] = "unused",
	[14] = AL["Normal"],		-- 10-30 Player Flexible Raid
	[15] = AL["Heroic"],		-- 10-30 Player Flexible Heroic Raid
	[16] = AL["Mythic"],		-- 20 Player mythic Raid
	[17] = AL["Raid Finder"],	-- 10-30 Player Flexible LFR
}

-- set on run
local QLF_FRAME_MIN_HEIGHT = QLF_FRAME_MIN_HEIGHT_STD
local QLF_ITEM_FRAME_ITEM_DISTANCE = 0


-- INIT
function QLF.Init()
	db = AtlasLoot.db.QuickLootFrame
	AtlasLoot.SlashCommands:AddResetFunction(QLF.ResetFrames, "frames", "qlf")
end
AtlasLoot:AddInitFunc(QLF.Init)

local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		self:StartMoving()
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

local function FrameOnEvent(self, event)
	if event == "PLAYER_LOOT_SPEC_UPDATED" then
		local spec = GetLootSpecialization() == 0 and GetSpecializationInfo(GetSpecialization()) or GetLootSpecialization()
		if spec ~= QLF.selectedPlayerSpec then
			QLF.selectedPlayerSpec = spec
			QLF:Refresh()
		end
	end
end

local function FrameOnShow(self)
	FrameOnEvent(self, "PLAYER_LOOT_SPEC_UPDATED")
end

local function FrameOnHide(self)
	QLF:Clear()
end

local function RefreshItemFrameHeight()
	local newHeight = QLF_FRAME_MIN_HEIGHT_STD - 2	-- remove the distance from the right icons
	for i = 1, #QLF.frame.items.list do
		if (QLF.frame.items.list[i].secButton and QLF.frame.items.list[i].secButton:IsShown()) then
			if i == 1 then
				newHeight = newHeight + ITEM_SIZE + QLF_ITEM_FRAME_ITEM_DISTANCE*2
			elseif i%ITEMS_PER_LINE == 1 then
				newHeight = newHeight + ITEM_SIZE + QLF_ITEM_FRAME_ITEM_DISTANCE
			end
		end
	end

	QLF.frame:SetHeight(newHeight > QLF_FRAME_MIN_HEIGHT and newHeight or QLF_FRAME_MIN_HEIGHT)
end

local function ClearItemButtons()
	for i = 1, #QLF.frame.items.list do
		if (QLF.frame.items.list[i].secButton and QLF.frame.items.list[i].secButton:IsShown()) then
			QLF.frame.items.list[i]:Clear()
		end
	end
end

local function CreateItemButton()
	local frame = QLF.frame
	local button = {}
	local count = #frame.items.list+1
	local buttonName = QLF_FRAME_NAME.."Button"..count
	frame.items.list[count] = button
	
	button.secButton = CreateFrame("BUTTON", buttonName, self)
	button.secButton:SetSize(ITEM_SIZE, ITEM_SIZE)
	
	button.secButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button.secButton.OriSetNormalTexture = button.secButton.SetNormalTexture
	button.secButton.type = "secButton"	-- now we can use button functions ;)
	button.secButton.obj = button
	button.secButton:SetScript("OnEnter", AtlasLoot.Button.API.Button_OnEnter)
	button.secButton:SetScript("OnLeave", AtlasLoot.Button.API.Button_OnLeave)
	button.secButton:SetScript("OnClick", AtlasLoot.Button.API.Button_OnClick)

		
	-- secButtonTexture <texture>
	button.secButton.icon = button.secButton:CreateTexture(buttonName.."-Icon", button.secButton)
	button.secButton.icon:SetPoint("TOPLEFT", button.secButton)
	button.secButton.icon:SetPoint("BOTTOMRIGHT", button.secButton)
	button.secButton.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	
	button.secButton.qualityBorder = button.secButton:CreateTexture(buttonName.."-QualityBorder")
	button.secButton.qualityBorder:SetPoint("TOPLEFT", button.secButton.icon, "TOPLEFT")
	button.secButton.qualityBorder:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT")
	button.secButton.qualityBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
	button.secButton.qualityBorder:Hide()
	
	-- secButtonOverlay <texture>
	button.secButton.overlay = button.secButton:CreateTexture(buttonName.."-Overlay", "OVERLAY")
	button.secButton.overlay:SetPoint("TOPLEFT", button.secButton.icon)
	button.secButton.overlay:SetPoint("BOTTOMRIGHT", button.secButton.icon)
	button.secButton.overlay:Hide()
		
	function button.secButton.SetNormalTexture(self, texture) 
		button.secButton.icon:SetTexture(texture)
	end
	button.__atlaslootinfo = {}
	
	for k,v in pairs(Button.Proto) do
		button[k] = v
	end
	
	button.secButton:ClearAllPoints()
	button.secButton:SetParent(frame.items)
	if count == 1 then
		frame.items.list[count].secButton:SetPoint("TOPLEFT", frame.items, "TOPLEFT", QLF_ITEM_FRAME_ITEM_DISTANCE, -QLF_ITEM_FRAME_ITEM_DISTANCE)
	elseif count%ITEMS_PER_LINE == 1 then
		frame.items.list[count].secButton:SetPoint("TOPLEFT", frame.items.list[count-ITEMS_PER_LINE].secButton, "BOTTOMLEFT", 0, -QLF_ITEM_FRAME_ITEM_DISTANCE)
	else
		frame.items.list[count].secButton:SetPoint("LEFT",frame.items.list[count-1].secButton, "RIGHT", QLF_ITEM_FRAME_ITEM_DISTANCE, 0)
	end
	
	return button
end

local function ClearSelectionButtons()
	for i = 1, #QLF.frame.selection.list do
		if QLF.frame.selection.list[i]:IsShown() then
			QLF.frame.selection.list[i]:SetButtonType(nil)
		end
	end
end

local function SelectionButton_SpecButtonOnEnter(self, owner)
	local tooltip = GetAlTooltip() 
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 24)
	end
	tooltip:AddLine(self.info[1])
	tooltip:AddLine(self.info[2], 1, 1, 1, true)
	tooltip:Show()
end

local function SelectionButton_SpecButtonOnLeave(self)
	GetAlTooltip():Hide()
end

local function SelectionButton_SpecButtonOnClick(self)
	if self.info then
		QLF.selectedPlayerSpec = self.info[3]
		QLF:Refresh()
	end
end

local function SelectionButton_SetButtonType(button, typ, val)
	if typ == "spec" then
		local id, name, description, icon, background, role = GetSpecializationInfo(val)
		
		button.icon:SetTexture(icon)
		
		button:SetScript("OnEnter", SelectionButton_SpecButtonOnEnter)
		button:SetScript("OnLeave", SelectionButton_SpecButtonOnLeave)
		button:SetScript("OnClick", SelectionButton_SpecButtonOnClick)
		
		button.info = {name, description, id}
		button:Show()
	--elseif type(typ) == "table" then
	else
		button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		button:SetScript("OnEnter", nil)
		button:SetScript("OnLeave", nil)
		button:SetScript("OnClick", nil)
		button.info = nil
		button:Hide()
	end
end

local function SelectionButton_SetSelected(button, selected)
	if selected then
		button:SetAlpha(1.0)
	else
		button:SetAlpha(0.5)
	end
end

local function CreateSelectionButton()
	local frame = QLF.frame
	local count = #frame.selection.list+1
	local buttonName = QLF_FRAME_NAME.."SelectionButton"..count
	frame.selection.list[count] = button
	
	local button = CreateFrame("BUTTON", buttonName, frame.selection)
	button:SetSize(SELECTION_ICON_SIZE, SELECTION_ICON_SIZE)
	button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button:SetAlpha(0.5)
	if count == 1 then
		button:SetPoint("TOPLEFT", frame.selection, "TOPLEFT", 1, -1)
	else
		button:SetPoint("TOPLEFT", frame.selection.list[count-1], "BOTTOMLEFT", 0, -1)
	end
	
	button.icon = button:CreateTexture(buttonName.."-Icon", button)
	button.icon:SetPoint("TOPLEFT", button)
	button.icon:SetPoint("BOTTOMRIGHT", button)
	button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	
	button.SetButtonType = SelectionButton_SetButtonType
	button.SetSelected = SelectionButton_SetSelected
	
	return button
end

function QLF:SetSelection(typ)
	QLF_FRAME_MIN_HEIGHT = QLF_FRAME_MIN_HEIGHT_STD
	if typ == "spec" then
		for i=1,GetNumSpecializations() do
			self.frame.selection.list[i]:SetButtonType("spec", i)
			if self.frame.selection.list[i].info[3] == self.selectedPlayerSpec then
				self.frame.selection.list[i]:SetSelected(true)
			else
				self.frame.selection.list[i]:SetSelected(false)
			end
			
			if i==1 then
				QLF_FRAME_MIN_HEIGHT = QLF_FRAME_MIN_HEIGHT + SELECTION_ICON_SIZE
			else
				QLF_FRAME_MIN_HEIGHT = QLF_FRAME_MIN_HEIGHT + SELECTION_ICON_SIZE + 1
			end
			self.frame.selection.list[i]:Show()
		end
	end
end

-- /dump AtlasLoot.GUI.QuickLootFrame:SetAtlasLootBonusRollItemTable("AtlasLoot_MistsofPandaria", "SiegeofOrgrimmar", 1, "Heroic" )
-- /dump AtlasLoot.GUI.QuickLootFrame:SetAtlasLootBonusRollItemTable("AtlasLoot_WarlordsofDraenor", "BlackrockFoundry", 1, "Heroic" )
-- if boss is a string check for encounter journal id
function QLF:SetAtlasLootBonusRollItemTableOLD(addonName, contentName, boss, dif)
	if not self.frame then QLF:Create() end
	ClearItemButtons()
	self.currentShownInfo = {
		type = "spec",
		typeInfo = {addonName, contentName, boss, dif},
	}
	
	QLF:SetSelection("spec")
	
	if not AtlasLoot.Loader:IsModuleLoaded(addonName) then
		self.frame:Show()
		self.frame.items.loadingText:Show()
		RefreshItemFrameHeight()
		return AtlasLoot.Loader:LoadModule(addonName, function() AtlasLoot.GUI.QuickLootFrame:SetAtlasLootBonusRollItemTable(addonName, contentName, boss, dif) end)
	else
		self.frame.items.loadingText:Hide()
	end
	
	local moduleData = ItemDB:Get(addonName)
	if type(boss) == "string" then -- if boss is a string check for encounter journal id
		boss = tonumber(boss)
		for i = 1, #moduleData[contentName].items do
			if moduleData[contentName].items[i].EncounterJournalID == boss then
				boss = i
				self.currentShownInfo[3] = boss
				break
			end
		end
	end
	local items, tableType, diffData = ItemDB:GetItemTable(addonName, contentName, boss, dif)
	local frame = self.frame
	
	-- set title
	frame.topTitleFrame.text:SetText(moduleData[contentName]:GetName() or "")
	frame.titleFrame.text:SetText(format(PAGE_NAME_DIFF, moduleData[contentName]:GetNameForItemTable(boss) or "", diffData.name))
	--frame.titleFrame.text:SetText(moduleData[contentName]:GetNameForItemTable(boss) or "")
	
	-- set items
	local item, itemID
	local count = 0
	local newHeight = QLF_FRAME_MIN_HEIGHT_STD
	for i = 1, #items do
		item = items[i]
		itemID = type(item[2]) == "number" and item[2] or tonumber(match(item[2], "i(%d+)"))
		if CheckBonusRollItem(itemID, self.selectedPlayerSpec or 1) then
			count = count + 1
			frame.items.list[count]:SetPreSet(diffData.preset)
			frame.items.list[count]:SetContentTable(item, tableType, true)
		end
	end
	RefreshItemFrameHeight()
	
	self.frame:Show()
	return self.frame
end

local function renewItemDataEJ(itemTable)
	ClearItemButtons()
	QLF.frame.items.loadingText:Hide()
	
	for i = 1, #itemTable do
		QLF.frame.items.list[i].__atlaslootinfo.type = {}
		QLF.frame.items.list[i]:SetType("Item", {itemID = itemTable[i][1], itemString = itemTable[i][2]})
	end
	RefreshItemFrameHeight()
end

function QLF:SetEncounterJournalBonusRoll(tierID, difficultyID, instanceID, encounterID)
	if not self.frame then QLF:Create() end
	if not self.frame:IsShown() then self.frame:Show() end
	AtlasLoot.EncounterJournal:ClearLootQuery()
	--ClearItemButtons()
	self.currentShownInfo = {
		type = "ejbr",
		typeInfo = {tierID, difficultyID, instanceID, encounterID},
	}
	
	-- We want a spec selection
	QLF:SetSelection("spec")
	
	-- TopTitle with 
	self.frame.topTitleFrame.text:SetText( EJ_GetInstanceInfo(instanceID) or "" )
	self.frame.titleFrame.text:SetText( format(PAGE_NAME_DIFF, EJ_GetEncounterInfo(encounterID) or "", DIF_INFO[difficultyID]) )
	
	AtlasLoot.EncounterJournal:SetLootQuery(instanceID, encounterID, difficultyID, tierID, nil, self.selectedPlayerSpec or 0, renewItemDataEJ)
	
	return self.frame
end

function QLF:Refresh()
	if self.currentShownInfo then
		if self.currentShownInfo.type == "ejbr" then
			QLF:SetEncounterJournalBonusRoll(self.currentShownInfo.typeInfo[1], self.currentShownInfo.typeInfo[2], self.currentShownInfo.typeInfo[3], self.currentShownInfo.typeInfo[4])
		end
	end
end

function QLF:Clear()
	if self.currentShownInfo and self.currentShownInfo.type == "ejbr" then
		AtlasLoot.EncounterJournal:ClearLootQuery()
	end
	ClearSelectionButtons()
	ClearItemButtons()
	self.currentShownInfo = nil
end

function QLF:Hide()
	self.frame:Hide()
end

function QLF:Create()
	if self.frame then return end
	local frame = CreateFrame("Frame", QLF_FRAME_NAME)
	self.frame = frame
	frame:SetParent(UIParent)
	frame:SetSize(QLF_FRAME_WIDTH, QLF_FRAME_MIN_HEIGHT)
	frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
	--frame:SetBackdropColor(0,0,0,1)
	frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForDrag("LeftButton", "RightButton")
	frame:SetScript("OnMouseDown", FrameOnDragStart)
	frame:SetScript("OnMouseUp", FrameOnDragStop)
	frame:SetScript("OnEvent", FrameOnEvent)
	frame:SetScript("OnShow", FrameOnShow)
	frame:SetScript("OnHide", FrameOnHide)
	frame:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	
	frame.CloseButton = CreateFrame("Button", QLF_FRAME_NAME.."-CloseButton", frame, "UIPanelCloseButton")
	frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 4)
	
	frame.topTitleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0, {r=0, g=0.86, b=1}, {r=1, g=1, b=1})
	frame.topTitleFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -3)
	frame.topTitleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -26, -21)

	frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0, {r=0, g=1, b=1}, {r=1, g=1, b=1})
	frame.titleFrame:SetPoint("TOPLEFT", frame.topTitleFrame, "BOTTOMLEFT", 0, -5)
	frame.titleFrame:SetPoint("BOTTOMRIGHT", frame.topTitleFrame, "BOTTOMRIGHT", 21, -21)
	
	frame.selection = CreateFrame("Frame", QLF_FRAME_NAME.."-Selection")
	frame.selection:ClearAllPoints()
	frame.selection:SetParent(frame)
	frame.selection:SetWidth(26)
	frame.selection:SetPoint("TOPRIGHT", frame.titleFrame, "BOTTOMRIGHT", 0, -5)
	frame.selection:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)
	frame.selection:SetBackdrop(ALPrivate.BOX_BACKDROP)
	
	
	frame.selection.list = {}
	
	setmetatable(
		frame.selection.list,
		{ __index = function(table, key)
			frame.selection.list[key] = CreateSelectionButton()
			return frame.selection.list[key]
		end,}
	)
	
	frame.items = CreateFrame("Frame", QLF_FRAME_NAME.."ItemFrame")
	frame.items:ClearAllPoints()
	frame.items:SetParent(frame)
	frame.items:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0, -5)
	frame.items:SetPoint("BOTTOMRIGHT", frame.selection, "BOTTOMLEFT", -5, 0)
	frame.items:SetBackdrop(ALPrivate.BOX_BACKDROP)
	
	frame.items.loadingText = frame.items:CreateFontString(QLF_FRAME_NAME.."ItemFrameLoadingText", "ARTWORK", "GameFontNormal")
	frame.items.loadingText:SetPoint("TOPLEFT", frame.items)
	frame.items.loadingText:SetPoint("BOTTOMRIGHT", frame.items)
	frame.items.loadingText:SetJustifyH("CENTER")
	frame.items.loadingText:SetText(AL["Loading Data ..."])
	
	frame.items.list = {}
	
	setmetatable(
		frame.items.list,
		{ __index = function(table, key)
			frame.items.list[key] = CreateItemButton()
			return frame.items.list[key]
		end,}
	)
	
	
	frame:SetHeight(QLF_FRAME_MIN_HEIGHT)
	QLF_ITEM_FRAME_ITEM_DISTANCE = (((frame.items:GetWidth())/ITEMS_PER_LINE-ITEM_SIZE)*ITEMS_PER_LINE)/(ITEMS_PER_LINE+1)
	frame:Hide()
	self.frame = frame
	QLF.RefreshStyle()
end

function QLF.ResetFrames()
	db.point = { "CENTER" }
	if QLF.frame then
		QLF.frame:ClearAllPoints()
		QLF.frame:SetPoint(db.point[1])
	end
end


function QLF.RefreshStyle()
	local frame = QLF.frame
	if not frame then return end
	-- main frame
	frame:SetScale(db.mainFrame.scale)
	frame:SetBackdropColor(db.mainFrame.bgColor[1], db.mainFrame.bgColor[2], db.mainFrame.bgColor[3], db.mainFrame.bgColor[4])
	
	-- title
	frame.topTitleFrame:SetColors(db.mainFrame.title.bgColor, db.mainFrame.title.textColor)
	frame.topTitleFrame.text:SetFont(LibSharedMedia:Fetch("font", db.mainFrame.title.font), db.mainFrame.title.size)
	
	-- subTitle
	frame.titleFrame:SetColors(db.mainFrame.subTitle.bgColor, db.mainFrame.subTitle.textColor)
	frame.titleFrame.text:SetFont(LibSharedMedia:Fetch("font", db.mainFrame.subTitle.font), db.mainFrame.subTitle.size)
	
	-- content
	frame.items:SetBackdropColor(db.mainFrame.content.bgColor[1], db.mainFrame.content.bgColor[2], db.mainFrame.content.bgColor[3], db.mainFrame.content.bgColor[4])
	frame.selection:SetBackdropColor(db.mainFrame.content.bgColor[1], db.mainFrame.content.bgColor[2], db.mainFrame.content.bgColor[3], db.mainFrame.content.bgColor[4])
end
