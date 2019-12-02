local ALName, ALPrivate = ...
local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local GUI = {}
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

AtlasLoot.GUI = GUI
local SoundData = AtlasLoot.ItemDB.SoundData

-- lua
local type, tonumber, tostring = type, tonumber, tostring
local tab_insert = table.insert
local str_format = string.format

-- AL functions
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local IsMapsModuleAviable = AtlasLoot.Loader.IsMapsModuleAviable

local GUI_CREATED = false
local FIRST_SHOW = true
local PLAYER_CLASS, PLAYER_CLASS_FN
local TT_ENTRY = "|cFFCFCFCF%s:|r %s"

local LOADER_STRING = "GUI_LOADING"
local TT_INFO_ENTRY = "|cFFCFCFCF%s:|r %s"

local db

local function UpdateFrames(noPageUpdate, forceContentUpdate)
	local moduleData = AtlasLoot.ItemDB:Get(db.selected[1])
	local dataID = db.selected[2]
	local bossID = db.selected[3]
	if not GUI.frame.contentFrame.shownFrame then
		GUI.ItemFrame:Show()
	end
	local frame, contentFrame = GUI.frame, GUI.frame.contentFrame
	local contentName, contentIndex, contentColor = moduleData[dataID]:GetContentType()
	local name, description, _, loreImage, dungeonAreaMapID
	contentColor = contentColor or ATLASLOOT_UNKNOWN_COLOR

	-- Set Boss name
	contentFrame.title.txt = moduleData[dataID]:GetNameForItemTable(bossID)
	contentFrame.title:SetText(contentFrame.title.txt)

	-- refresh background info
	GUI.lastBgInfo = GUI.curBGInfo
	GUI.curBgInfo = {
		contentColor, 	-- color of topBg
		moduleData[dataID].items[bossID].BgImage and moduleData[dataID].items[bossID].BgImage or (moduleData[dataID].BgImage and moduleData[dataID].BgImage or nil),	-- background image
	}

	GUI.RefreshContentBackGround()

	--[[ set MapID
	if not moduleData[dataID].MapID and dungeonAreaMapID and dungeonAreaMapID > 0 then
		GUI.frame.contentFrame.mapButton.mapID = dungeonAreaMapID
		GUI.frame.contentFrame.mapButton:Show()
	elseif moduleData[dataID].MapID then
		GUI.frame.contentFrame.mapButton.mapID = moduleData[dataID].MapID
		GUI.frame.contentFrame.mapButton:Show()
	else
		GUI.frame.contentFrame.mapButton.mapID = nil
		GUI.frame.contentFrame.mapButton:Hide()
	end
	]]--
	if IsMapsModuleAviable() then
		if moduleData[dataID] and moduleData[dataID].AtlasMapFile then
			GUI.frame.contentFrame.mapButton.atlasMapFile = moduleData[dataID].items[bossID].AtlasMapFile or moduleData[dataID].AtlasMapFile
			GUI.frame.contentFrame.mapButton:Show()
		else
			GUI.frame.contentFrame.mapButton.atlasMapFile = nil
			GUI.frame.contentFrame.mapButton:Hide()
		end
		contentFrame.map:SetMap(GUI.frame.contentFrame.mapButton.atlasMapFile)
	end

	-- MODEL
	if moduleData[dataID].items[bossID].DisplayIDs then
		if not moduleData[dataID].items[bossID].DisplayIDs[1][2] then
			moduleData[dataID].items[bossID].DisplayIDs[1][2] = moduleData[dataID]:GetNameForItemTable(bossID)
		end
		GUI.ModelFrame.DisplayIDs = moduleData[dataID].items[bossID].DisplayIDs
		contentFrame.modelButton:Show()
	elseif moduleData[dataID].items[bossID].EncounterJournalID then
		GUI.ModelFrame.EncounterJournalID = moduleData[dataID].items[bossID].EncounterJournalID
		contentFrame.modelButton:Show()
	else
		GUI.ModelFrame.DisplayIDs = nil
		GUI.ModelFrame.EncounterJournalID = nil
		contentFrame.modelButton:Hide()
	end

	-- SOUNDS
	if moduleData[dataID].items[bossID].npcID and SoundData:GetNpcData(moduleData[dataID].items[bossID].npcID) then
		GUI.SoundFrame.npcID = moduleData[dataID].items[bossID].npcID
		contentFrame.soundsButton:Show()
	else
		GUI.SoundFrame.npcID = nil
		contentFrame.soundsButton:Hide()
		if contentFrame.shownFrame == GUI.SoundFrame.frame then
			contentFrame.shownFrame = nil
			if GUI.SoundFrame.frame then
				GUI.SoundFrame.frame:Hide()
			end
		end
	end

	-- npcID
	local usedNpcID = moduleData[dataID].items[bossID].npcID
	if not usedNpcID then
		usedNpcID = moduleData[dataID].items[bossID].ObjectID
	end
	if usedNpcID then
		if type(moduleData[dataID].items[bossID].npcID) == "table" then
			GUI.ItemFrame.npcID = usedNpcID[1]
		else
			GUI.ItemFrame.npcID = usedNpcID
		end
	end

	-- Search
	if contentFrame.shownFrame and contentFrame.shownFrame.OnSearch then
		contentFrame.searchBox:Show()
	else
		contentFrame.searchBox:Hide()
	end

	--[[ AtlasMapID
	if AtlasLoot.AtlasIntegration and (AtlasLoot.AtlasIntegration.IsEnabled() and moduleData[dataID].AtlasMapID and AtlasLoot.AtlasIntegration.GetAtlasZoneData(moduleData[dataID].AtlasMapID)) then
		contentFrame.AtlasMapButton.AtlasMapID = moduleData[dataID].AtlasMapID
		contentFrame.AtlasMapButton:Show()
		if (contentFrame.soundsButton:IsVisible()) then
			contentFrame.AtlasMapButton:SetPoint("RIGHT", contentFrame.soundsButton, "LEFT", -2, 0)
		elseif (contentFrame.modelButton:IsVisible()) then
			contentFrame.AtlasMapButton:SetPoint("RIGHT", contentFrame.modelButton, "LEFT", -2, 0)
		else
			contentFrame.AtlasMapButton:SetPoint("RIGHT", contentFrame.nextPageButton, "LEFT", 0, 0)
		end
	else
		contentFrame.AtlasMapButton.AtlasMapID = nil
		contentFrame.AtlasMapButton:Hide()
	end
	]]--

	-- BaseLvl for Items
	GUI.ItemFrame.ItemBaseLvl = moduleData[dataID].ItemBaseLvl

	if not noPageUpdate then
		-- Next/Prev
		if moduleData[dataID].items[bossID+1] then
			if moduleData[dataID].items[bossID].ExtraList and moduleData[dataID].items[bossID+1].ExtraList then
				contentFrame.nextPageButton.info = nil
				--contentFrame.nextPageButton.info = bossID + 1
			elseif not moduleData[dataID].items[bossID+1].ExtraList and not moduleData[dataID].items[bossID].ExtraList then
				contentFrame.nextPageButton.info = GUI.frame.boss:CheckIfNext()
			else
				contentFrame.nextPageButton.info = nil
			end
		else
			contentFrame.nextPageButton.info = nil
		end
		if contentFrame.shownFrame and contentFrame.shownFrame.prevPage and not moduleData[dataID].items[bossID].ExtraList then
			contentFrame.prevPageButton.info = tostring(contentFrame.shownFrame.prevPage)
		elseif moduleData[dataID].items[bossID-1] and not moduleData[dataID].items[bossID].ExtraList then
			contentFrame.prevPageButton.info = GUI.frame.boss:CheckIfPrev()
		else
			contentFrame.prevPageButton.info = nil
		end

		-- refresh current page
		if contentFrame.shownFrame and contentFrame.shownFrame.Refresh then
			contentFrame.shownFrame:Refresh(forceContentUpdate)
		elseif not contentFrame.shownFrame then
			GUI.ItemFrame:Show()
		end
	end
	GUI:RefreshNextPrevButtons()
	AtlasLoot.Button:CopyBox_Hide()
end

-- ################################
-- GUI frame recycling
-- ################################
local frameSave = {}

function GUI.GetFrameByType(typ)
	if not frameSave[typ] then frameSave[typ] = {} end
	local frame = next(frameSave[typ])
	if frame then
		frameSave[typ][frame] = nil
	end
	return frame
end

function GUI.FreeFrameByType(typ, frame)
	if not frameSave[typ] then frameSave[typ] = {} end
	frameSave[typ][frame] = true
end

-- ################################
-- GUI scripts
-- ################################
local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		if not db.DefaultFrameLocked then
			self:StartMoving()
		end
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

local function FrameOnShow(self)
	if FIRST_SHOW then
		self.moduleSelect:SetSelected(db.selected[1])
	end
	FIRST_SHOW = false
	if (AtlasLoot.db.enableAutoSelect) then
		local module, instance, boss = AtlasLoot.Data.AutoSelect:GetCurrrentPlayerData()
		local pass = false
		if module and module ~= db.selected[1] then
			self.moduleSelect:SetSelected(module)
			pass = true
		end
		if ( pass and instance ) or ( instance and instance ~= db.selected[2] ) then
			if instance ~= db.selected[2] then
				pass = true
			else
				pass = false
			end
			self.subCatSelect:SetSelected(instance)
		end
		if AtlasLoot.db.enableAutoSelectBoss and (pass or (boss and boss ~= db.selected[3])) then
			self.boss:SetSelected(boss or 1)
		elseif pass then
			self.boss:SetSelected(1)
		end
		UpdateFrames(false, true) -- force a update
	end
end

local function ItemButtonOnClick(self)
	GUI.ItemFrame:Show(true)
	UpdateFrames()
end

local function SoundButtonOnClick(self)
	GUI.SoundFrame:Show()
	UpdateFrames(true)
end

local function ModelButtonOnClick(self)
	GUI.ModelFrame:Show()
	UpdateFrames(true)
end

-- Atlas
local function AtlasMapButton_OnClick(self, button)
	if (AtlasLoot.AtlasIntegration.IsEnabled()) then
		if (button == "RightButton") then
			if ( AtlasFrameSmall:IsVisible() ) then
				HideUIPanel(AtlasFrameSmall)
			end
		else
			if (self.AtlasMapID) then
				AtlasLoot.AtlasIntegration.ShowMap(self.AtlasMapID)
			end
		end
	end
end

local function AtlasMapButton_OnEnter(self, owner)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 5)
	end
	tooltip:AddLine(AL["Click to open Atlas instance map."].."\n"..AL["Right-click to close Atlas window."])
	tooltip:Show()
end

-- Class Filer
local function ClassFilterButton_Refresh(self)
	-- insert class selection?
	self.texture:SetDesaturated(not db.classFilter)
	if self.selectionFrame and self.selectionFrame:IsShown() then self.selectionFrame:Hide() end

	self.selectedPlayerSpecID = self.selectedPlayerSpecID or GetSpecialization() and ( GetLootSpecialization() == 0 and GetSpecializationInfo(GetSpecialization()) or GetLootSpecialization() ) or 0

	if self.selectedPlayerSpecID == 0 then
		self.specName = PLAYER_CLASS
		self.specDesc = str_format(AL["Shows items for all %s specializations."], PLAYER_CLASS)
		self.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		self.texture:SetTexCoord(CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][1], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][2], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][3], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][4])
	else
		local id, name, description, icon, background, role = GetSpecializationInfoByID(self.selectedPlayerSpecID)
		self.specName = name
		self.specDesc = description
		self.texture:SetTexture(icon)
		self.texture:SetTexCoord(0, 1, 0, 1)
	end
	if GUI.frame.contentFrame.shownFrame and GUI.frame.contentFrame.shownFrame.OnClassFilterUpdate then
		GUI.frame.contentFrame.shownFrame.OnClassFilterUpdate()
	end
end

local function ClassFilterButton_OnEvent(self, event)
	if event == "PLAYER_LOOT_SPEC_UPDATED" then
		local spec = GetLootSpecialization() == 0 and GetSpecializationInfo(GetSpecialization()) or GetLootSpecialization()
		if spec ~= self.selectedPlayerSpecID then
			self.selectedPlayerSpecID = spec
			ClassFilterButton_Refresh(self)
		end
	end
end

local function ClassFilterButton_OnEnter(self, owner)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 5)
	end
	tooltip:AddLine(self.specName)
	tooltip:AddLine(self.specDesc, 1, 1, 1, true)
	if self.mainButton then
		tooltip:AddLine(" ")
		tooltip:AddLine(AL["|cff00ff00Right-Click:|r Change Spec"])
	end
	tooltip:Show()
end

local function ClassFilterButton_OnLeave(self)
	GetAlTooltip():Hide()
end

local function ClassFilterButton_OnShow(self)
	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	ClassFilterButton_Refresh(self)
end

local function ClassFilterButton_OnHide(self)
	self:UnregisterEvent("PLAYER_LOOT_SPEC_UPDATED")
end

local function ClassFilterSpecButton_OnClick(self)
	self.obj:Hide()
	self.obj.obj.selectedPlayerSpecID = self.specID
	ClassFilterButton_Refresh(self.obj.obj)
end

local function ClassFilterButton_OnClick(self, button)
	if button == "LeftButton" then
		db.classFilter = not db.classFilter
		ClassFilterButton_Refresh(self)
	else
		-- show spec selection here
		if not self.selectionFrame then
			local frame = CreateFrame("FRAME", nil, self)
			frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
						tile = true, tileSize = 16, edgeSize = 16,
						insets = { left = 4, right = 4, top = 4, bottom = 4 }})
			frame:SetBackdropColor(0,0,0,1)
			frame:SetPoint("BOTTOMLEFT", self, "TOP", 0, 5)
			frame:SetSize(10,10)
			frame.obj = self
			frame.buttons = {}

			local width, newWidth, height = 10, 0, 10
			local button_height = 20
			local id, name, description, icon

			local button = CreateFrame("BUTTON", nil, frame)
			button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
			button:SetBackdrop(ALPrivate.BOX_BACKDROP)
			button:SetBackdropColor(RAID_CLASS_COLORS[PLAYER_CLASS_FN].r, RAID_CLASS_COLORS[PLAYER_CLASS_FN].g, RAID_CLASS_COLORS[PLAYER_CLASS_FN].b, 1)
			button.obj = frame
			button.specID = 0
			button.specName = PLAYER_CLASS
			button.specDesc = str_format(AL["Shows items for all %s specializations."], PLAYER_CLASS)

			button.icon = button:CreateTexture(nil, button)
			button.icon:SetPoint("LEFT", button, "LEFT", 0, 0)
			button.icon:SetSize(button_height, button_height)
			button.icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			button.icon:SetTexCoord(CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][1], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][2], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][3], CLASS_ICON_TCOORDS[PLAYER_CLASS_FN][4])

			button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			button.text:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
			button.text:SetJustifyH("LEFT")
			button.text:SetText(PLAYER_CLASS)
			button.text:SetSize(button.text:GetStringWidth(), button_height)

			newWidth = button_height + 2 + button.text:GetWidth()
			width = newWidth+10 > width and newWidth+10 or width
			height = height + button_height + 1

			button:SetScript("OnClick", ClassFilterSpecButton_OnClick)
			button:SetScript("OnEnter", ClassFilterButton_OnEnter)
			button:SetScript("OnLeave", ClassFilterButton_OnLeave)

			frame.buttons[1] = button

			for i=1,GetNumSpecializations() do
				id, name, description, icon = GetSpecializationInfo(i)

				button = CreateFrame("BUTTON", nil, frame)
				button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
				--button:SetAlpha(0.5)
				--if i == 1 then
				--	button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
				--else
					button:SetPoint("TOPLEFT", frame.buttons[#frame.buttons], "BOTTOMLEFT", 0, -1)
				--end
				button.obj = frame
				button.specID = id
				button.specName = name
				button.specDesc = description

				button.icon = button:CreateTexture(nil, button)
				button.icon:SetPoint("LEFT", button, "LEFT", 0, 0)
				button.icon:SetSize(button_height, button_height)
				button.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")

				button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
				button.text:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				button.text:SetJustifyH("LEFT")
				button.text:SetText(name)
				button.text:SetSize(button.text:GetStringWidth(), button_height)

				newWidth = button_height + 2 + button.text:GetWidth()
				width = newWidth+10 > width and newWidth+10 or width
				--button:SetSize(newWidth, button_height)
				height = height + button_height + 1

				button:SetScript("OnClick", ClassFilterSpecButton_OnClick)
				button:SetScript("OnEnter", ClassFilterButton_OnEnter)
				button:SetScript("OnLeave", ClassFilterButton_OnLeave)

				frame.buttons[i+1] = button
			end
			for i = 1, #frame.buttons do
				frame.buttons[i]:SetSize(width-10, button_height)
			end

			frame:SetSize(width, height)
			frame:Hide()

			self.selectionFrame = frame
		end

		if self.selectionFrame:IsShown() then
			self.selectionFrame:Hide()
		else
			local button
			for i = 1, #self.selectionFrame.buttons do
				button = self.selectionFrame.buttons[i]
				if button.specID == self.selectedPlayerSpecID then
					button:SetAlpha(1.0)
				else
					button:SetAlpha(0.5)
				end
			end
			self.selectionFrame:Show()
		end
	end
end

-- Next / Prev buttons
local function NextPrevButtonOnClick(self)
	if self.info then
		if type(self.info) == "string" then 	-- next item page
			AtlasLoot.db.GUI.selected[5] = tonumber(self.info)
			UpdateFrames()
		elseif type(self.info) == "table" then
			AtlasLoot.db.GUI.selected[5] = tonumber(self.info[2])
			GUI.frame.boss:SetSelected(self.info[1])
		elseif type(self.info) == "number" then
			GUI.frame.boss:SetSelected(self.info)
		else	-- next boss ;)
			if self.typ == "next" then
				GUI.frame.boss:SetNext()
			else
				GUI.frame.boss:SetPrev()
			end
		end
	end
end

local function SearchBoxOnEnter(self)
	self:ClearFocus()
	if GUI.frame.contentFrame.shownFrame and GUI.frame.contentFrame.shownFrame.OnSearch then
		GUI.frame.contentFrame.shownFrame.OnSearch(self:GetText())
	end
end

-- Search box
local function SearchBoxOnClear(self)
	if GUI.frame.contentFrame.shownFrame and GUI.frame.contentFrame.shownFrame.OnSearchClear then
		GUI.frame.contentFrame.shownFrame.OnSearchClear()
	end
end

local function SearchBoxOnTextChanged(self, pI)
	if pI and GUI.frame.contentFrame.shownFrame and GUI.frame.contentFrame.shownFrame.OnSearchTextChanged then
		GUI.frame.contentFrame.shownFrame.OnSearchTextChanged(self:GetText())
	end
end

-- AtlasMaps
local ATLAS_MAPS_PATH = "Interface\\AddOns\\AtlasLootClassic_Maps\\"
local function AtlasMaps_SetMaps(self, map, entranceMap)
	if map == self.map and self.entranceMap == entranceMap then
		self:ShowOverlay(true)
		return
	end
	if not map or not IsMapsModuleAviable() then
		self:Hide()
		self.overlay:Hide()
		return
	end
	if type(map) == "table" then
		return AtlasMaps_SetMaps(self, unpack(map))
	end

	self.map = map
	self.entranceMap = entranceMap

	self:ShowEntranceMap(false, true, true)
end

local function AtlasMaps_ShowEntranceMap(self, flag, showOverlay, force)
	if (self.isEntranceMap and not flag) or (not flag and force) then
		self:SetTexture(ATLAS_MAPS_PATH..self.map)
		self.isEntranceMap = false
	elseif (not self.isEntranceMap and flag and self.entranceMap) or (flag and self.entranceMap and force) then
		self:SetTexture(ATLAS_MAPS_PATH..self.entranceMap)
		self.isEntranceMap = true
	end
	self:Show()
	self:ShowOverlay(showOverlay)
end

local function AtlasMaps_ShowOverlay(self, flag)
	if flag then
		self.overlay:Show()
	else
		self.overlay:Hide()
	end
end

local function MapButtonOnClick(self, button)
	if GUI.frame.contentFrame.shownFrame then
		GUI.frame.contentFrame.shownFrame:Clear()
	end
	if button == "RightButton" then
		self.mapData:ShowEntranceMap(true)
	else
		self.mapData:ShowEntranceMap(false)
	end
	self.mapData:ShowOverlay(false)
end

local function MapButtonOnEnter(self, owner)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 5)
	end
	tooltip:AddLine(AL["Atlas map"])
	tooltip:AddLine(format(TT_ENTRY, AL["Left Click"], AL["Show dungeon map"]))
	if self.mapData.entranceMap then
		tooltip:AddLine(format(TT_ENTRY, AL["Right Click"], AL["Show entrance map"]))
	end
	tooltip:Show()
end

-- Info Button
local function GUI_InfoOnEnter(self)
    local tooltip = GetAlTooltip()
    tooltip:SetOwner(self, "ANCHOR_LEFT", (self:GetWidth() * 0.5), 5)
	tooltip:AddLine("AtlasLootClassic", 0, 1, 0)
	tooltip:AddLine(format(TT_INFO_ENTRY, AL["Shift + Left Click"], AL["Add item into chat"]))
	tooltip:AddLine(format(TT_INFO_ENTRY, AL["Ctrl + Left Click"], AL["Shows the item in the Dressing room"]))
	tooltip:AddLine(format(TT_INFO_ENTRY, AL["Alt + Left Click"], AL["Set/Remove the item as favourite"]))
	if AtlasLoot.db.enableWoWHeadIntegration then
		tooltip:AddLine(format(TT_INFO_ENTRY, AL["Shift + Right Click"], AL["Shows a copyable link for WoWHead"]))
	end
    tooltip:Show()
end

local function GUI_InfoOnLeave(self)
    GetAlTooltip():Hide()
end

-- ################################
-- DropDowns/Select
-- ################################
-- Called when the module is loaded
local function loadModule(addonName)
	local moduleList = AtlasLoot.ItemDB:GetModuleList(db.selected[1])
	local moduleData = AtlasLoot.ItemDB:Get(db.selected[1])
	local contentTypes = moduleData:GetContentTypes()
	local data = {}
	local _, contentIndex
	local first
	local foundDbValue
	for i = 1, #contentTypes do
		if not data[i] then
			data[i] = {
				info = {
					name = contentTypes[i][1],
					bgColor = contentTypes[i][2],
				}
			}
		end
	end
	local content
	for i = 1, #moduleList do
		content = moduleList[i]
		if not first then first = content end
		if content == db.selected[2] then foundDbValue = true end
		-- contentName, contentIndex, contentColor
		_, contentIndex = moduleData[content]:GetContentType()
		data[contentIndex][ #data[contentIndex]+1 ] = {
			id			= content,
			name		= moduleData[content]:GetName(),
			tt_title	= moduleData[content]:GetName(),
			tt_text		= moduleData[content]:GetInfo(),
		}
	end
	if data[0] and #data[0] > 0 then
		data[#data+1] = data[0]
		data[0] = nil
	end
	if not foundDbValue then
		db.selected[2] = first
	end

	GUI.frame.subCatSelect:SetData(data, db.selected[2])
	if GUI.frame.contentFrame.loadingDataText and GUI.frame.contentFrame.loadingDataText:IsShown() then
		GUI.frame.contentFrame.loadingDataText:Hide()
	end

	if not GUI.frame.contentFrame.itemsButton:IsShown() then
		GUI.frame.contentFrame.itemsButton:Show()
	end
end

function GUI:ShowLoadingInfo(addonName, noWipe, displayType)
	if not GUI.frame.contentFrame.loadingDataText then
		local text = GUI.frame.contentFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
		text:SetAllPoints(GUI.frame.contentFrame)
		text:SetJustifyH("CENTER")
		text:SetJustifyV("MIDDLE")
		text:SetTextColor(1,1,1)
		GUI.frame.contentFrame.loadingDataText = text
	end
	if GUI.frame.contentFrame.shownFrame and GUI.frame.contentFrame.shownFrame.Clear then
		GUI.frame.contentFrame.shownFrame.Clear()
	end
	if not noWipe then
		GUI.frame.subCatSelect:SetData(nil)
		GUI.frame.difficulty:SetData(nil)
		GUI.frame.boss:SetData(nil)
		GUI.frame.extra:SetData(nil)
		GUI.frame.contentFrame.mapButton:Hide()
		--GUI.frame.contentFrame.AtlasMapButton:Hide()
		GUI.frame.contentFrame.modelButton:Hide()
		GUI.frame.contentFrame.itemsButton:Hide()
		GUI.frame.contentFrame.nextPageButton.info = nil
		GUI.frame.contentFrame.prevPageButton.info = nil
		GUI:RefreshNextPrevButtons()
		GUI.frame.contentFrame.clasFilterButton:Hide()
	end

	if not displayType or displayType == "InCombat" then
		GUI.frame.contentFrame.loadingDataText:SetText(str_format(AL["%s will finish loading after combat."], addonName))
	elseif displayType == "DISABLED" then
		GUI.frame.contentFrame.loadingDataText:SetText(str_format(AL["Required module %s is currently disabled."], addonName))
	elseif displayType == "MISSING" then
		GUI.frame.contentFrame.loadingDataText:SetText(str_format(AL["Required module %s is not installed."], addonName))
	else
		GUI.frame.contentFrame.loadingDataText:SetText(addonName)
	end

	GUI.frame.contentFrame.loadingDataText:Show()
end

local ModuleSelectFunction_FirstCall = true
local function ModuleSelectFunction(self, id, arg)
	db.selected[1] = id
	if ModuleSelectFunction_FirstCall then
		ModuleSelectFunction_FirstCall = false
	else
		db.selected[4] = 1
	end
	local combat = AtlasLoot.Loader:LoadModule(id, loadModule, LOADER_STRING)
	if combat == "InCombat" then
		GUI:ShowLoadingInfo(id)
	end
end

local SubCatSelectFunction_FirstCall = true
local function SubCatSelectFunction(self, id, arg)
	db.selected[2] = id
	db.selected[3] = 0
	local moduleData = AtlasLoot.ItemDB:Get(db.selected[1])
	local data = {}
	local dataExtra

	local tabVal
	for i = 1, #moduleData[id].items do
		tabVal = moduleData[id].items[i]
		moduleData:CheckForLink(id, i)
		if tabVal.ExtraList then
			if not dataExtra then dataExtra = {} end
			dataExtra[#dataExtra+1] = {
				id = i,
				name = moduleData[id]:GetNameForItemTable(i),
				coinTexture = tabVal.CoinTexture,
				tt_title = moduleData[id]:GetNameForItemTable(i),
				tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
			}
			if not dataExtra[#dataExtra].name then dataExtra[#dataExtra] = nil end
		else
			data[#data+1] = {
				id = i,
				name = moduleData[id]:GetNameForItemTable(i),
				coinTexture = tabVal.CoinTexture,
				tt_title = moduleData[id]:GetNameForItemTable(i),
				tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
			}
			if not data[#data].name then data[#data] = nil end
		end
	end
	-- change difficulty from some instances
	-- this prevents load from unused modules
	db.selected[4] = moduleData[id].LoadDifficulty or db.selected[4]
	--if dataExtra then
		GUI.frame.extra:SetData(dataExtra)
	--end
	db.selected[3] = data[1] and data[1].id or 1
	GUI.frame.boss:SetData(data, db.selected[3])

end

local function BossSelectFunction(self, id, arg)
	GUI.frame.extra:SetSelected(nil)
	db.selected[3] = id
	db.selected[5] = 0
	local moduleData = AtlasLoot.ItemDB:Get(db.selected[1])
	moduleData:CheckForLink(db.selected[2], db.selected[3], true)
	local difficultys = moduleData:GetDifficultys()
	local data = {}
	for count = 1, #difficultys do
		if moduleData[db.selected[2]].items[id][count] then
			data[ #data+1 ] = {
				id = count,
				name = difficultys[count].name,
				tt_title = difficultys[count].name
			}
		end
	end
	GUI.frame.difficulty:SetData(data, moduleData:GetDifficulty(db.selected[2], db.selected[3], db.selected[4]))
	--UpdateFrames()
end

local function ExtraSelectFunction(self, id, arg)
	GUI.frame.boss:SetSelected(nil)
	db.selected[3] = id
	db.selected[5] = 0
	local moduleData = AtlasLoot.ItemDB:Get(db.selected[1])
	moduleData:CheckForLink(db.selected[2], id, true)
	local difficultys = moduleData:GetDifficultys()
	local data = {}
	for count = 1, #difficultys do
		if moduleData[db.selected[2]].items[id][count] then
			data[ #data+1 ] = {
				id = count,
				name = difficultys[count].name,
				tt_title = difficultys[count].name
			}
		end
	end

	GUI.frame.difficulty:SetData(data, moduleData:GetDifficulty(db.selected[2], db.selected[3], db.selected[4]))
	--UpdateFrames()
end

local function DifficultySelectFunction(self, id, arg, start)
	if not start then
		db.selected[4] = id
	end
	UpdateFrames()
end

-- ################################
-- GUI functions
-- ################################
function GUI.Init()
	db = AtlasLoot.db.GUI

	GUI:Create()

	-- Class Info
	PLAYER_CLASS, PLAYER_CLASS_FN = UnitClass("player")

	-- create module list
	local data = {}

	local tmp = AtlasLoot.Loader:GetLootModuleList()
	local index = 0
	local first, foundDbValue
	local v
	if #tmp.module > 0 then
		index = index + 1
		data[index] = {
			info = {
				name = AL["AtlasLoot Modules"],
				bgColor = {0, 0, 0, 1},		-- Background color
			}
		}
		for i = 1, #tmp.module do
			v = tmp.module[i]
			if not first then first = v.addonName end
			if v.addonName == db.selected[1] then foundDbValue = true end
			data[index][ #data[index]+1 ] = {
				id			= v.addonName,
				name		= v.name,
				tt_title	= v.tt_title,
				tt_text		= v.tt_text,
			}
		end
	end
	if #tmp.custom > 0 then
		index = index + 1
		data[index] = {
			info = {
				name = AL["Custom Modules"],
				bgColor = {0, 0.3, 0, 1},		-- Background color
			}
		}
		for i = 1, #tmp.custom do
			v = tmp.custom[i]
			if not first then first = v.addonName end
			if v.addonName == db.selected[1] then foundDbValue = true end
			data[index][ #data[index]+1 ] = {
				id			= v.addonName,
				name		= v.name,
				tt_title	= v.tt_title,
				tt_text		= v.tt_text,
			}
		end
	end
	if not foundDbValue then
		db.selected[1] = first
	end
	if index == 0 then
		GUI.frame.moduleSelect:SetText(AL["No module found."])
	else
		GUI.frame.moduleSelect:SetData(data)
	end

	AtlasLoot.SlashCommands:AddResetFunction(GUI.ResetFrames, "frames", "gui")
	AtlasLoot.SlashCommands:Add("togglebg", function() db.hideBGImage = not db.hideBGImage end, AL["/al togglebg - Toggle the background image on loottables."])

	-- if auto-select is enabled, pre-load all instance modules to save the first-time AL frame's loading time
	if (AtlasLoot.db.GUI.autoselect) then
		--AtlasLoot:PreLoadModules();
	end
end
AtlasLoot:AddInitFunc(GUI.Init)

function GUI:Toggle()
	if self.frame:IsShown() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function GUI:HideContentFrame()
	if self.frame.contentFrame.shownFrame then
		self.frame.contentFrame.shownFrame:Hide()
	end
end

function GUI:RefreshNextPrevButtons()
	if GUI.frame.contentFrame.nextPageButton.info then
		GUI.frame.contentFrame.nextPageButton:Show()
	else
		GUI.frame.contentFrame.nextPageButton:Hide()
	end
	if GUI.frame.contentFrame.prevPageButton.info then
		GUI.frame.contentFrame.prevPageButton:Show()
	else
		GUI.frame.contentFrame.prevPageButton:Hide()
	end
end

function GUI:Create()
	if GUI_CREATED then return end
	GUI_CREATED = true
	local frameName = "AtlasLoot_GUI-Frame"

	local frame = CreateFrame("Frame", frameName)
	frame:ClearAllPoints()
	frame:SetParent(UIParent)
	frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
	frame:SetWidth(920)
	frame:SetHeight(600)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton", "RightButton")
	frame:SetScript("OnMouseDown", FrameOnDragStart)
	frame:SetScript("OnMouseUp", FrameOnDragStop)
	frame:SetScript("OnShow", FrameOnShow)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
	--frame:SetBackdropColor(0.45,0.45,0.45,1)
	frame:Hide()
	tinsert(UISpecialFrames, frameName)	-- allow ESC close

	frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
	frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)

	--frame.Title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	--frame.Title:SetPoint("TOP", frame, "TOP", 0, -10)
	--frame.Title:SetText(AL["AtlasLoot"])

	frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0)
	frame.titleFrame:SetPoint("TOPLEFT", frame, 10, -7)
	frame.titleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -30, -25)
	frame.titleFrame.text:SetText(AL["AtlasLoot"])

	frame.titleFrame.infoButton = CreateFrame("Button", nil, frame, "UIPanelInfoButton")
	frame.titleFrame.infoButton:SetPoint("RIGHT", frame.titleFrame, "RIGHT", -1, 0)
	frame.titleFrame.infoButton:SetScript("OnEnter", GUI_InfoOnEnter)
	frame.titleFrame.infoButton:SetScript("OnLeave", GUI_InfoOnLeave)

	frame.titleFrame.version = frame.titleFrame:CreateFontString(nil, "ARTWORK")
	frame.titleFrame.version:SetPoint("BOTTOMRIGHT", frame.titleFrame, "BOTTOMRIGHT", -20, 1)
	frame.titleFrame.version:SetTextColor(1, 1, 1, 0.5)
	frame.titleFrame.version:SetSize(150, 10)
	frame.titleFrame.version:SetFont(_G["SystemFont_Tiny"]:GetFont(), 10)
	frame.titleFrame.version:SetJustifyH("RIGHT")
	frame.titleFrame.version:SetJustifyV("BOTTOM")
	frame.titleFrame.version:SetText(AtlasLoot.__addonversion)

	frame.moduleSelect = GUI:CreateDropDown()
	frame.moduleSelect:SetParPoint("TOPLEFT", frame, "TOPLEFT", 10, -40)
	frame.moduleSelect:SetWidth(270)
	frame.moduleSelect:SetTitle(AL["Select Module"])
	frame.moduleSelect:SetText("Select Module")
	frame.moduleSelect:SetButtonOnClick(ModuleSelectFunction)

	frame.subCatSelect = GUI:CreateDropDown()
	frame.subCatSelect:SetParPoint("TOPLEFT", frame.moduleSelect.frame, "TOPRIGHT", 20, 0)
	frame.subCatSelect:SetWidth(270)
	frame.subCatSelect:SetTitle(AL["Select Subcategory"])
	frame.subCatSelect:SetText("Select Subcategory")
	frame.subCatSelect:SetButtonOnClick(SubCatSelectFunction)

	frame.difficulty = GUI:CreateSelect()
	frame.difficulty:SetParPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -40)
	frame.difficulty:SetWidth(320)
	frame.difficulty:SetNumEntrys(2)
	frame.difficulty:ShowSelectedCoin(false)
	frame.difficulty:SetButtonOnClick(DifficultySelectFunction)

	frame.boss = GUI:CreateSelect()
	frame.boss:SetParPoint("TOPLEFT", frame.difficulty.frame, "BOTTOMLEFT", 0, -10)
	frame.boss:SetWidth(320)
	frame.boss:SetNumEntrys(22)
	frame.boss:SetButtonOnClick(BossSelectFunction)

	frame.extra = GUI:CreateSelect()
	frame.extra:SetParPoint("TOPLEFT", frame.boss.frame, "BOTTOMLEFT", 0, -10)
	frame.extra:SetWidth(320)
	frame.extra:SetNumEntrys(5)
	frame.extra:SetButtonOnClick(ExtraSelectFunction)

	frameName =  "AtlasLoot_GUI-ItemFrame"

	frame.contentFrame = CreateFrame("Frame", frameName)
	frame.contentFrame:ClearAllPoints()
	frame.contentFrame:SetParent(frame)
	frame.contentFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -70)
	frame.contentFrame:SetWidth(560)		-- Frame = 560, Abstand = 20, Button = 270
	frame.contentFrame:SetHeight(510)		-- Frame = 460, Abstand = 10, Button = 30
	frame.contentFrame.shownFrame = nil

	frame.contentFrame.title = frame.contentFrame:CreateFontString(frameName.."-title", "ARTWORK", "GameFontHighlightLarge")
	frame.contentFrame.title:SetPoint("TOP", frame.contentFrame, "TOP")
	frame.contentFrame.title:SetJustifyH("CENTER")
	frame.contentFrame.title:SetText("")
	frame.contentFrame.title:SetWidth(frame.contentFrame:GetWidth())
	frame.contentFrame.title:SetHeight(30)

	frame.contentFrame.topBG = frame.contentFrame:CreateTexture(frameName.."-topBG","BACKGROUND")
	frame.contentFrame.topBG:SetPoint("TOPLEFT", frame.contentFrame, "TOPLEFT")
	frame.contentFrame.topBG:SetWidth(560)
	frame.contentFrame.topBG:SetHeight(30)

	frame.contentFrame.downBG = frame.contentFrame:CreateTexture(frameName.."-downBG","BACKGROUND")
	frame.contentFrame.downBG:SetPoint("TOPLEFT", frame.contentFrame, "TOPLEFT", 0, -480)
	frame.contentFrame.downBG:SetWidth(560)
	frame.contentFrame.downBG:SetHeight(30)

	frame.contentFrame.itemBG = frame.contentFrame:CreateTexture(frameName.."-itemBG","BACKGROUND")
	frame.contentFrame.itemBG:SetPoint("TOPLEFT", frame.contentFrame, "TOPLEFT", 0, -30)
	frame.contentFrame.itemBG:SetWidth(560)
	frame.contentFrame.itemBG:SetHeight(450)
	frame.contentFrame.itemBG:SetTexCoord(0.1, 0.7, 0.1, 0.7)

	-- Map frame
	frame.contentFrame.map = frame.contentFrame:CreateTexture(frameName.."-map1","BACKGROUND")
	frame.contentFrame.map:SetAllPoints(frame.contentFrame.itemBG)
	frame.contentFrame.map:SetDrawLayer(frame.contentFrame.itemBG:GetDrawLayer(), 2)
	frame.contentFrame.map:Hide()

	frame.contentFrame.map.overlay = frame.contentFrame:CreateTexture(frameName.."-map3","BACKGROUND")
	frame.contentFrame.map.overlay:SetAllPoints(frame.contentFrame.itemBG)
	frame.contentFrame.map.overlay:SetDrawLayer(frame.contentFrame.itemBG:GetDrawLayer(), 4)
	frame.contentFrame.map.overlay:SetColorTexture(0, 0, 0, 0.4)
	frame.contentFrame.map.overlay:Hide()

	frame.contentFrame.map.maxWidth = frame.contentFrame.map:GetWidth()
	frame.contentFrame.map.maxHeight = frame.contentFrame.map:GetHeight()
	frame.contentFrame.map.SetMap = AtlasMaps_SetMaps
	frame.contentFrame.map.ShowEntranceMap = AtlasMaps_ShowEntranceMap
	frame.contentFrame.map.ShowOverlay = AtlasMaps_ShowOverlay

	-- #####
	-- Right -> Left
	-- #####
	frame.contentFrame.nextPageButton = CreateFrame("Button", frameName.."-nextPageButton")
	frame.contentFrame.nextPageButton:SetParent(frame.contentFrame)
	frame.contentFrame.nextPageButton:SetWidth(30)
	frame.contentFrame.nextPageButton:SetHeight(30)
	frame.contentFrame.nextPageButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	frame.contentFrame.nextPageButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	frame.contentFrame.nextPageButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	frame.contentFrame.nextPageButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	frame.contentFrame.nextPageButton:SetPoint("RIGHT", frame.contentFrame.downBG, "RIGHT", 0, 0)
	frame.contentFrame.nextPageButton:SetScript("OnClick", NextPrevButtonOnClick)
	frame.contentFrame.nextPageButton.typ = "next"

	-- mapButton
	frame.contentFrame.mapButton = CreateFrame("Button", frameName.."-mapButton")
	frame.contentFrame.mapButton:SetParent(frame.contentFrame)
	frame.contentFrame.mapButton:SetWidth(48)
	frame.contentFrame.mapButton:SetHeight(32)
	frame.contentFrame.mapButton:RegisterForClicks("AnyDown")
	frame.contentFrame.mapButton:SetPoint("RIGHT", frame.contentFrame.nextPageButton, "LEFT", 0, 0)
	frame.contentFrame.mapButton:SetScript("OnClick", MapButtonOnClick)
	frame.contentFrame.mapButton:SetScript("OnMouseDown", function(self) self.texture:SetTexCoord(0.125, 0.875, 0.5, 1.0) end)
	frame.contentFrame.mapButton:SetScript("OnMouseUp", function(self) self.texture:SetTexCoord(0.125, 0.875, 0.0, 0.5) end)
	frame.contentFrame.mapButton:SetScript("OnEnter", MapButtonOnEnter)
	frame.contentFrame.mapButton:SetScript("OnLeave", function(self) GetAlTooltip():Hide() end)
	frame.contentFrame.mapButton.mapData = frame.contentFrame.map
	frame.contentFrame.mapButton:Hide()

	frame.contentFrame.mapButton.texture = frame.contentFrame.mapButton:CreateTexture(frameName.."-mapButton-texture","ARTWORK")
	frame.contentFrame.mapButton.texture:SetPoint("RIGHT", frame.contentFrame.mapButton)
	frame.contentFrame.mapButton.texture:SetWidth(48)
	frame.contentFrame.mapButton.texture:SetHeight(32)
	frame.contentFrame.mapButton.texture:SetTexture("Interface\\QuestFrame\\UI-QuestMap_Button")
	frame.contentFrame.mapButton.texture:SetTexCoord(0.125, 0.875, 0.0, 0.5)

	frame.contentFrame.mapButton.highlight = frame.contentFrame.mapButton:CreateTexture(frameName.."-mapButton-highlight","HIGHLIGHT")
	frame.contentFrame.mapButton.highlight:SetPoint("RIGHT", frame.contentFrame.mapButton, -7, 0)
	frame.contentFrame.mapButton.highlight:SetWidth(36)
	frame.contentFrame.mapButton.highlight:SetHeight(25)
	frame.contentFrame.mapButton.highlight:SetTexture("Interface\\BUTTONS\\ButtonHilight-Square")
	frame.contentFrame.mapButton.highlight:SetBlendMode("ADD")

	-- Model
	frame.contentFrame.modelButton = GUI.CreateButton()
	frame.contentFrame.modelButton:SetPoint("RIGHT", frame.contentFrame.mapButton, "LEFT", 0, 0)
	frame.contentFrame.modelButton:SetText(AL["Model"])
	frame.contentFrame.modelButton:SetScript("OnClick", ModelButtonOnClick)
	frame.contentFrame.modelButton:Hide()

	--[[ AtlasMapButton
	frame.contentFrame.AtlasMapButton = CreateFrame("Button", frameName.."-AtlasMapButton")
	frame.contentFrame.AtlasMapButton:SetParent(frame.contentFrame)
	frame.contentFrame.AtlasMapButton:SetWidth(32)
	frame.contentFrame.AtlasMapButton:SetHeight(32)
	frame.contentFrame.AtlasMapButton:SetPoint("RIGHT", frame.contentFrame.modelButton, "LEFT", -2, 0)
	frame.contentFrame.AtlasMapButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	frame.contentFrame.AtlasMapButton:SetScript("OnClick", AtlasMapButton_OnClick)
	frame.contentFrame.AtlasMapButton:SetScript("OnEnter", AtlasMapButton_OnEnter)
	frame.contentFrame.AtlasMapButton:SetScript("OnLeave", function(self) GetAlTooltip():Hide() end)

	frame.contentFrame.AtlasMapButton.texture = frame.contentFrame.AtlasMapButton:CreateTexture(frameName.."-AtlasMapButton-texture","ARTWORK")
	frame.contentFrame.AtlasMapButton.texture:SetPoint("RIGHT", frame.contentFrame.AtlasMapButton)
	frame.contentFrame.AtlasMapButton.texture:SetWidth(32)
	frame.contentFrame.AtlasMapButton.texture:SetHeight(32)
	frame.contentFrame.AtlasMapButton.texture:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\Atlas_Button")

	frame.contentFrame.AtlasMapButton.highlight = frame.contentFrame.AtlasMapButton:CreateTexture(frameName.."-AtlasMapButton-highlight","HIGHLIGHT")
	frame.contentFrame.AtlasMapButton.highlight:SetPoint("CENTER", frame.contentFrame.AtlasMapButton, 0, 0)
	frame.contentFrame.AtlasMapButton.highlight:SetWidth(48)
	frame.contentFrame.AtlasMapButton.highlight:SetHeight(48)
	frame.contentFrame.AtlasMapButton.highlight:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	frame.contentFrame.AtlasMapButton.highlight:SetBlendMode("ADD")
	]]--

	-- Sound
	frame.contentFrame.soundsButton = GUI.CreateButton()
	frame.contentFrame.soundsButton:SetPoint("RIGHT", frame.contentFrame.modelButton, "LEFT", -5, 0)
	frame.contentFrame.soundsButton:SetText(AL["Sounds"])
	frame.contentFrame.soundsButton:SetScript("OnClick", SoundButtonOnClick)

	-- #####
	-- Center
	-- #####
	frame.contentFrame.searchBox = CreateFrame("EditBox", frameName.."-SearchBox", frame.contentFrame, "SearchBoxTemplate")
	frame.contentFrame.searchBox:SetWidth(200)
	frame.contentFrame.searchBox:SetHeight(35)
	frame.contentFrame.searchBox:SetPoint("CENTER", frame.contentFrame.downBG, "CENTER", 0, 0)
	frame.contentFrame.searchBox:SetAutoFocus(false)
	frame.contentFrame.searchBox:SetMaxLetters(50)
	frame.contentFrame.searchBox:SetScript("OnEnterPressed", SearchBoxOnEnter)
	frame.contentFrame.searchBox:HookScript("OnTextChanged", SearchBoxOnTextChanged)
	frame.contentFrame.searchBox.clearButton:HookScript("OnClick", SearchBoxOnClear)
	frame.contentFrame.searchBox:Show()

	-- #####
	-- Left -> Right
	-- #####
	frame.contentFrame.prevPageButton = CreateFrame("Button", frameName.."-prevPageButton")
	frame.contentFrame.prevPageButton:SetParent(frame.contentFrame)
	frame.contentFrame.prevPageButton:SetWidth(30)
	frame.contentFrame.prevPageButton:SetHeight(30)
	frame.contentFrame.prevPageButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	frame.contentFrame.prevPageButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	frame.contentFrame.prevPageButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
	frame.contentFrame.prevPageButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	frame.contentFrame.prevPageButton:SetPoint("LEFT", frame.contentFrame.downBG, "LEFT", 5, 0)
	frame.contentFrame.prevPageButton:SetScript("OnClick", NextPrevButtonOnClick)
	frame.contentFrame.prevPageButton.typ = "prev"

	frame.contentFrame.itemsButton = GUI.CreateButton()
	frame.contentFrame.itemsButton:SetPoint("LEFT", frame.contentFrame.prevPageButton, "RIGHT", 5, 0)
	frame.contentFrame.itemsButton:SetText(AL["Items"])
	frame.contentFrame.itemsButton:SetScript("OnClick", ItemButtonOnClick)

	-- Class Filter
	frame.contentFrame.clasFilterButton = CreateFrame("Button", frameName.."-clasFilterButton")
	frame.contentFrame.clasFilterButton:SetParent(frame.contentFrame)
	frame.contentFrame.clasFilterButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	frame.contentFrame.clasFilterButton:SetWidth(25)
	frame.contentFrame.clasFilterButton:SetHeight(25)
	frame.contentFrame.clasFilterButton:SetPoint("LEFT", frame.contentFrame.itemsButton, "RIGHT", 5, 0)
	frame.contentFrame.clasFilterButton:SetScript("OnClick", ClassFilterButton_OnClick)
	frame.contentFrame.clasFilterButton:SetScript("OnShow", ClassFilterButton_OnShow)
	frame.contentFrame.clasFilterButton:SetScript("OnHide", ClassFilterButton_OnHide)
	frame.contentFrame.clasFilterButton:SetScript("OnEvent", ClassFilterButton_OnEvent)
	frame.contentFrame.clasFilterButton:SetScript("OnEnter", ClassFilterButton_OnEnter)
	frame.contentFrame.clasFilterButton:SetScript("OnLeave", ClassFilterButton_OnLeave)
	frame.contentFrame.clasFilterButton.mainButton = true
	frame.contentFrame.clasFilterButton:Hide()

	frame.contentFrame.clasFilterButton.texture = frame.contentFrame.clasFilterButton:CreateTexture(frameName.."-clasFilterButton-texture","ARTWORK")
	frame.contentFrame.clasFilterButton.texture:SetAllPoints(frame.contentFrame.clasFilterButton)
	frame.contentFrame.clasFilterButton.texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

	self.frame = frame

	GUI.RefreshMainFrame()

	self.ItemFrame:Create()
	-- Set itemframe as start frame
	frame.contentFrame.shownFrame = GUI.ItemFrame.frame
	--self.SoundFrame:Create()
end

function GUI:ForceUpdate()
	db = AtlasLoot.db.GUI
	FIRST_SHOW = true
	if self.frame:IsShown() then
		self.frame:Hide()
		self.frame:Show()
	end
	GUI.RefreshStyle()
	--UpdateFrames()
end

function GUI.RefreshStyle()
	GUI.RefreshContentBackGround()
	GUI.RefreshMainFrame()
	GUI.RefreshFonts()
end

function GUI.ResetFrames()
	db.point = { "CENTER" }
	if GUI.frame then
		GUI.frame:ClearAllPoints()
		GUI.frame:SetPoint(db.point[1])
	end
end

-- Function to set Parent and Point of a frame
function GUI.Temp_SetParPoint(self, ...)
	local frame = self.frame or self
	frame:ClearAllPoints()
	-- check for Parent
	local tmp
	local parent = frame:GetParent()
	for i=1, select('#', ...) do
		tmp = select(i,...)
		if type(tmp) == "string" then
			if _G[tmp] and _G[tmp].GetObjectType then
				parent = _G[tmp]
				break
			end
		elseif type(tmp) == "table" and tmp.GetObjectType then
			parent = tmp
			break
		end
	end

	frame:SetParent(parent:GetObjectType() == "Frame" and parent or parent:GetParent())
	-- check if we have a overridden SetPoint
	if frame.SetPoint == GUI.Temp_SetParPoint then
		if frame.SetPointOri then
			frame:SetPointOri(...)
		else
			error("No SetPoint found ( :SetPointOri() )")
		end
	else
		frame:SetPoint(...)
	end
end

-- ################################
-- Option functions
-- ################################
function GUI.RefreshContentBackGround()
	if not GUI.frame or not GUI.curBgInfo then return end
	local frame = GUI.frame.contentFrame

	-- top Bg
	if db.contentTopBar.useContentColor and ( frame.topBG.curAlpha ~= db.contentTopBar.bgColor.a or frame.topBG.curColor ~= GUI.curBgInfo[1]) then
		frame.topBG:SetColorTexture(GUI.curBgInfo[1][1], GUI.curBgInfo[1][2], GUI.curBgInfo[1][3], db.contentTopBar.bgColor.a)
		frame.topBG.curColor = GUI.curBgInfo[1]
		frame.topBG.curAlpha = db.contentTopBar.bgColor.a
	elseif not db.contentTopBar.useContentColor and frame.topBG.curColor ~= db.contentTopBar.bgColor then
		frame.topBG:SetColorTexture(db.contentTopBar.bgColor.r, db.contentTopBar.bgColor.g, db.contentTopBar.bgColor.b, db.contentTopBar.bgColor.a)
		frame.topBG.curColor = db.contentTopBar.bgColor
	end

	-- content Bg
	if db.content.showBgImage and GUI.curBgInfo and GUI.curBgInfo[2] ~= ( GUI.lastBgInfo and GUI.lastBgInfo[2] or nil) then
		GUI.frame.contentFrame.itemBG:SetTexture(GUI.curBgInfo[2])
		GUI.frame.contentFrame.itemBG:SetAlpha(db.content.bgColor.a)
	elseif not db.content.showBgImage or not GUI.curBgInfo[2] then
		GUI.frame.contentFrame.itemBG:SetAlpha(1)
		GUI.frame.contentFrame.itemBG:SetColorTexture(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
	end

	-- bottom Bg
	if db.contentBottomBar.useContentColor and ( frame.downBG.curAlpha ~= db.contentBottomBar.bgColor.a or frame.downBG.curColor ~= GUI.curBgInfo[1]) then
		frame.downBG:SetColorTexture(GUI.curBgInfo[1][1], GUI.curBgInfo[1][2], GUI.curBgInfo[1][3], db.contentTopBar.bgColor.a)
		frame.downBG.curColor = GUI.curBgInfo[1]
		frame.downBG.curAlpha = db.contentBottomBar.bgColor.a
	elseif not db.contentBottomBar.useContentColor and frame.downBG.curColor ~= db.contentBottomBar.bgColor then
		frame.downBG:SetColorTexture(db.contentBottomBar.bgColor.r, db.contentBottomBar.bgColor.g, db.contentBottomBar.bgColor.b, db.contentBottomBar.bgColor.a)
		frame.downBG.curColor = db.contentBottomBar.bgColor
	end
end

function GUI.RefreshMainFrame()
	if not GUI.frame then return end

	local frame = GUI.frame
	frame:SetBackdropColor(db.mainFrame.bgColor.r, db.mainFrame.bgColor.b, db.mainFrame.bgColor.g, db.mainFrame.bgColor.a)
	frame.titleFrame:SetBackdropColor(db.mainFrame.title.bgColor.r, db.mainFrame.title.bgColor.g, db.mainFrame.title.bgColor.b, db.mainFrame.title.bgColor.a)
	GUI.RefreshFonts("title")

	frame:SetScale(db.mainFrame.scale)
end

function GUI.RefreshFonts(obj)
	if not GUI.frame then return end
	local frame = GUI.frame

	--db.GUI.mainFrame.title.font
	if not obj or obj == "title" then
		frame.titleFrame:SetFont(LibSharedMedia:Fetch("font", db.mainFrame.title.font), db.mainFrame.title.size)
		frame.titleFrame.text:SetTextColor(db.mainFrame.title.textColor.r, db.mainFrame.title.textColor.g, db.mainFrame.title.textColor.b, db.mainFrame.title.textColor.a)
	end
	if not obj or obj == "contentFrame" then
		frame.contentFrame.title:SetFont(LibSharedMedia:Fetch("font", db.contentTopBar.font.font), db.contentTopBar.font.size)
		frame.contentFrame.title:SetTextColor(db.contentTopBar.font.color.r, db.contentTopBar.font.color.g, db.contentTopBar.font.color.b, db.contentTopBar.font.color.a)
	end
end

function GUI.OnLevelRangeRefresh()
	ModuleSelectFunction(nil, db.selected[1])
end
