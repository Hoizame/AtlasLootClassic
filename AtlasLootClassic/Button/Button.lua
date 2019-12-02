--[[
	button.__atlaslootinfo = {
		type			= "item",
		itemID 			= 123,
		spellID			= 123,
		achievmentID	= 123,
		petID			= 123,
		questID			= 123,
		mountID			= 123,
	}
]]
local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Button = {}
local Proto = {}
local API = {}
AtlasLoot.Button = Button
Button.Proto = Proto
Button.API = API
local AL = AtlasLoot.Locales

local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

-- lua
local assert, type, tonumber, tostring = assert, type, tonumber, tostring
local next, pairs = next, pairs
local str_sub, str_format, str_len, str_match = string.sub, string.format, string.len, string.match

-- WoW
local CreateFrame = CreateFrame

-- UnitFactionGroup("player")		"Alliance", "Horde", "Neutral" or nil.
-- :SetAtlas()
local WOW_HEAD_LINK, WOW_HEAD_LINK_LOC = "https://classic.wowhead.com/%s=%d", "https://%s.classic.wowhead.com/%s=%d"
local WOW_HEAD_LOCALE
local FACTION_INFO_IS_SET_ID = 998
local IGNORE_THIS_BUTTON_ID = 999
local FACTION_TEXTURES = {
	[0] = "MountJournalIcons-Horde",
	[1] = "MountJournalIcons-Alliance"
}
local PLAYER_FACTION_ID = 0
local LOOT_BORDER_BY_QUALITY_AL = {}

local BUTTON_COUNT = 0
local SEC_BUTTON_COUNT = 0
local button_types, extra_button_types, button_types_index, extra_button_types_index = {}, {}, {}, {}
local STANDART_TABLE = { "Name", "Description" }
local STANDART_FORMAT_TABLE = { "Item", "Item" }
for i = 1,#STANDART_TABLE do STANDART_FORMAT_TABLE[#STANDART_FORMAT_TABLE+1] = STANDART_TABLE[i] end

function Button.Init()
	PLAYER_FACTION_ID = UnitFactionGroup("player") == "Horde" and 0 or 1

	for k, v in pairs(LOOT_BORDER_BY_QUALITY) do
		LOOT_BORDER_BY_QUALITY_AL[k] = v
	end
	LOOT_BORDER_BY_QUALITY_AL[1] = ALPrivate.IMAGE_PATH.."loottoast-itemborder-white"
	LOOT_BORDER_BY_QUALITY_AL["gold"] = "loottoast-itemborder-gold"

	-- Setup WoW Head locale
	local locale = GetLocale()
	if locale == "deDE" then WOW_HEAD_LOCALE = "de"
	elseif locale == "esMX" then WOW_HEAD_LOCALE = "es"
	elseif locale == "esES" then WOW_HEAD_LOCALE = "es"
	elseif locale == "frFR" then WOW_HEAD_LOCALE = "fr"
	elseif locale == "itIT" then WOW_HEAD_LOCALE = "it"
	elseif locale == "ptBR" then WOW_HEAD_LOCALE = "pt"
	elseif locale == "ruRU" then WOW_HEAD_LOCALE = "ru"
	elseif locale == "koKR" then WOW_HEAD_LOCALE = "ko"
	elseif locale == "zhCN" then WOW_HEAD_LOCALE = "cn"
	elseif locale == "zhTW" then WOW_HEAD_LOCALE = "cn" end
end
AtlasLoot:AddInitFunc(Button.Init)

function Button:GetWoWHeadLocale()
	return WOW_HEAD_LOCALE
end

function Button:CreateFormatTable(tab)
	for i = 1,#STANDART_TABLE do tab[#tab+1] = STANDART_TABLE[i] end
	return tab
end

function Button:AddChatLink(link)
	if ChatFrameEditBox and ChatFrameEditBox:IsVisible() then
		ChatFrameEditBox:Insert(link)
	else
		ChatEdit_InsertLink(link)
	end
end

function Button:OpenWoWHeadLink(button, type, id)
	if id and type and AtlasLoot.db.enableWoWHeadIntegration and type then
		if AtlasLoot.db.useEnglishWoWHead or not WOW_HEAD_LOCALE then
			Button:CopyBox_Show(button, format(WOW_HEAD_LINK, type, id))
		else
			Button:CopyBox_Show(button, format(WOW_HEAD_LINK_LOC, WOW_HEAD_LOCALE, type, id))
		end
	end
end

local function Button_OnEnter(self)
	if self.type == "secButton" then
		if button_types[self.obj.__atlaslootinfo.secType[1]] and button_types[self.obj.__atlaslootinfo.secType[1]].OnEnter then
			button_types[self.obj.__atlaslootinfo.secType[1]].OnEnter(self)
		end
	else
		if button_types[self.__atlaslootinfo.type[1]] and button_types[self.__atlaslootinfo.type[1]].OnEnter then
			button_types[self.__atlaslootinfo.type[1]].OnEnter(self)
		end
	end
end

local function Button_OnLeave(self)
	if self.type == "secButton" then
		if button_types[self.obj.__atlaslootinfo.secType[1]] and button_types[self.obj.__atlaslootinfo.secType[1]].OnLeave then
			button_types[self.obj.__atlaslootinfo.secType[1]].OnLeave(self)
		end
	else
		if button_types[self.__atlaslootinfo.type[1]] and button_types[self.__atlaslootinfo.type[1]].OnLeave then
			button_types[self.__atlaslootinfo.type[1]].OnLeave(self)
		end
	end
end

local function Button_OnClick(self, button) -- down)
	if not button then return end
	if self.type == "secButton" then
		if button_types[self.obj.__atlaslootinfo.secType[1]] and button_types[self.obj.__atlaslootinfo.secType[1]].OnMouseAction then
			button_types[self.obj.__atlaslootinfo.secType[1]].OnMouseAction(self, button)
		end
	else
		if button_types[self.__atlaslootinfo.type[1]] and button_types[self.__atlaslootinfo.type[1]].OnMouseAction then
			button_types[self.__atlaslootinfo.type[1]].OnMouseAction(self, button)
		end
	end
end

local function Button_OnMouseWheel(self, delta)
	if not delta then return end
	Button_OnClick(self, delta == 1 and "MouseWheelUp" or "MouseWheelDown")
end

local function Button_SetNormalTexture(self, texture)
	self.icon:SetTexture(texture)
end

local function Button_ForceSetText(self, text, force)
	if force == true then	-- single force
		self.forcedTextSet = true
		self:Ori_SetText(text)
	elseif force == false then	-- remove text force
		self.forcedTextSet = false
	elseif text == nil then	-- reset
		self:Ori_SetText(nil)
		self.forcedTextSet = false
	elseif not self.forcedTextSet then
		self:Ori_SetText(text)
	end
end

local function Button_Overlay_SetQualityBorder(self, qualityID)
	if qualityID ==  1 then
		self:SetTexture(LOOT_BORDER_BY_QUALITY_AL[qualityID])
	else
		self:SetAtlas(LOOT_BORDER_BY_QUALITY_AL[qualityID] or LOOT_BORDER_BY_QUALITY_AL[LE_ITEM_QUALITY_UNCOMMON])
	end
	if not LOOT_BORDER_BY_QUALITY_AL[qualityID] then
		self:SetDesaturated(true)
	else
		self:SetDesaturated(false)
	end
end
Button.Button_Overlay_SetQualityBorder = Button_Overlay_SetQualityBorder

--/run AtlasLoot.Button:Create():SetContentTable({ 1, 104939 })
function Button:Create()
	BUTTON_COUNT = BUTTON_COUNT + 1
	local buttonName = "AtlasLoot_Button_"..BUTTON_COUNT
	local button = CreateFrame("BUTTON", buttonName)
	button:SetWidth(270)
	button:SetHeight(28)
	button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	--button:SetNormalTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	--button:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	button:EnableMouseWheel(true)
	button:RegisterForClicks("AnyDown") --"AnyUp",
	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Button_OnLeave)
	button:SetScript("OnClick", Button_OnClick)
	button:SetScript("OnMouseWheel", Button_OnMouseWheel)

	-- highlight Background
	button.highlightBg = button:CreateTexture(buttonName.."_highlightBg")
	button.highlightBg:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.highlightBg:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -(button:GetWidth()/2), 0)
	button.highlightBg:SetColorTexture(1,0,0)
	button.highlightBg:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 0.45, 1, 1, 1, 0)
	button.highlightBg:Hide()

	-- Icon <texture>
	button.icon = button:CreateTexture(buttonName.."_icon")
	button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -1)
	button.icon:SetHeight(26)
	button.icon:SetWidth(26)
	button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

	--[[
	button.icon.glow = CreateFrame("FRAME")
	button.icon.glow:ClearAllPoints()
	button.icon.glow:SetParent(button)
	button.icon.glow:SetHeight(26)
	button.icon.glow:SetWidth(26)
	button.icon.glow:SetAllPoints(button.icon)
	ActionButton_ShowOverlayGlow(button.icon.glow)
	--ActionButton_HideOverlayGlow(self)

	button.qualityBorder = button:CreateTexture(buttonName.."_qualityBorder")
	button.qualityBorder:SetPoint("TOPLEFT", button.icon, "TOPLEFT")
	button.qualityBorder:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT")
	button.qualityBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
	button.qualityBorder:Hide()
	]]--

	-- secButtonTexture <texture>
	button.overlay = button:CreateTexture(buttonName.."_overlay", "OVERLAY")
	button.overlay:SetPoint("TOPLEFT", button.icon, "TOPLEFT")
	button.overlay:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT")
	button.overlay:Hide()
	button.overlay.SetQualityBorder = Button_Overlay_SetQualityBorder

	button.completed = button:CreateTexture(buttonName.."_completed", "OVERLAY")
	button.completed:SetPoint("BOTTOMRIGHT", button.icon)
	button.completed:SetHeight(20)
	button.completed:SetWidth(20)
	button.completed:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
	button.completed:Hide()

	button.phaseIndicator = button:CreateTexture(buttonName.."_phaseIndicator", "OVERLAY")
	button.phaseIndicator:SetPoint("TOPLEFT", button.icon)
	button.phaseIndicator:SetPoint("BOTTOMRIGHT", button.icon)
	button.phaseIndicator:SetDrawLayer(button.overlay:GetDrawLayer(), 1)
	button.phaseIndicator:Hide()

	button.favourite = button:CreateTexture(buttonName.."_favourite", "OVERLAY")
	button.favourite:SetPoint("TOPLEFT", button.icon, -2, 2)
	button.favourite:SetHeight(20)
	button.favourite:SetWidth(20)
	button.favourite:SetAtlas("VignetteKill")
	button.favourite:SetDrawLayer(button.overlay:GetDrawLayer(), 2)
	button.favourite:Hide()

	-- ItemName <FontString>
	button.name = button:CreateFontString(buttonName.."_name", "ARTWORK", "GameFontNormal")
	button.name:SetPoint("TOPLEFT", button.icon, "TOPRIGHT", 3, 0)
	button.name:SetJustifyH("LEFT")
	button.name:SetText("")
	button.name:SetWidth(205)
	button.name:SetHeight(12)
	button.name.Ori_SetText = button.name.SetText
	button.name.SetText = Button_ForceSetText

	-- ExtraText <FontString>
	button.extra = button:CreateFontString(buttonName.."_extra", "ARTWORK", "GameFontNormalSmall")
	button.extra:SetPoint("TOPLEFT", button.name, "BOTTOMLEFT", 0, -1)
	button.extra:SetJustifyH("LEFT")
	button.extra:SetText("")
	button.extra:SetWidth(205)
	button.extra:SetHeight(10)
	button.extra:SetTextColor(1, 1, 1, 1)
	button.extra.Ori_SetText = button.extra.SetText
	button.extra.SetText = Button_ForceSetText

	-- counter
	button.count = button:CreateFontString(buttonName.."_count", "ARTWORK", "AtlasLoot_ItemAmountFont")
	button.count:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", -1, 1)
	button.count:SetJustifyH("RIGHT")
	button.count:SetHeight(15)
	button.count:SetText(15)
	button.count:Hide()

	-- secButton <button>
	button.secButton = CreateFrame("BUTTON", buttonName.."_secButton", button)
	button.secButton:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1, -1)
	button.secButton:SetHeight(26)
	button.secButton:SetWidth(26)
	button.secButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button.secButton.OriSetNormalTexture = button.secButton.SetNormalTexture
	button.secButton.type = "secButton"
	button.secButton.obj = button
	button.secButton:Hide()
	button.secButton:EnableMouseWheel(true)
	button.secButton:SetScript("OnEnter", Button_OnEnter)
	button.secButton:SetScript("OnLeave", Button_OnLeave)
	button.secButton:SetScript("OnClick", Button_OnClick)
	button.secButton:SetScript("OnMouseWheel", Button_OnMouseWheel)
	button.secButton:RegisterForClicks("AnyDown")

	-- secButtonTexture <texture>
	button.secButton.icon = button.secButton:CreateTexture(buttonName.."_secButtonIcon", button.secButton)
	button.secButton.icon:SetAllPoints(button.secButton)
	button.secButton.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

	--[[
	button.secButton.qualityBorder = button.secButton:CreateTexture(buttonName.."_secButtonQualityBorder")
	button.secButton.qualityBorder:SetAllPoints(button.secButton)
	button.secButton.qualityBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
	button.secButton.qualityBorder:Hide()
	]]--

	-- secButtonMini <texture>
	button.secButton.mini = button.secButton:CreateTexture(buttonName.."_secButtonMini")
	button.secButton.mini:SetPoint("TOPRIGHT", button.secButton.icon, "TOPRIGHT", 0, 0)
	button.secButton.mini:SetHeight(13)
	button.secButton.mini:SetWidth(13)
	button.secButton.mini:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	button.secButton.mini:Hide()

	-- secButtonOverlay <texture>
	button.secButton.overlay = button.secButton:CreateTexture(buttonName.."_secButtonOverlay", "OVERLAY")
	button.secButton.overlay:SetPoint("TOPLEFT", button.secButton.icon, "TOPLEFT")
	button.secButton.overlay:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT")
	button.secButton.overlay:Hide()
	button.secButton.overlay.SetQualityBorder = Button_Overlay_SetQualityBorder

	button.secButton.completed = button.secButton:CreateTexture(buttonName.."_secCompleted", "OVERLAY")
	button.secButton.completed:SetPoint("BOTTOMRIGHT", button.secButton.icon)
	button.secButton.completed:SetHeight(20)
	button.secButton.completed:SetWidth(20)
	button.secButton.completed:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
	button.secButton.completed:Hide()

	button.secButton.count = button.secButton:CreateFontString(buttonName.."_secCount", "ARTWORK", "AtlasLoot_ItemAmountFont")
	button.secButton.count:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT", -1, 1)
	button.secButton.count:SetJustifyH("RIGHT")
	button.secButton.count:SetHeight(15)
	button.secButton.count:SetText(15)
	button.secButton.count:Hide()

	button.secButton.pvp = button.secButton:CreateTexture(buttonName.."_secButtonPvp")
	button.secButton.pvp:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT", -3, 3)
	button.secButton.pvp:SetHeight(13)
	button.secButton.pvp:SetWidth(13)
	button.secButton.pvp:SetDrawLayer(button.secButton.icon:GetDrawLayer(), 1)
	button.secButton.pvp:Hide()

	button.secButton.phaseIndicator = button.secButton:CreateTexture(buttonName.."_phaseIndicator", "OVERLAY")
	button.secButton.phaseIndicator:SetPoint("TOPLEFT", button.secButton.icon)
	button.secButton.phaseIndicator:SetPoint("BOTTOMRIGHT", button.secButton.icon)
	button.secButton.phaseIndicator:SetDrawLayer(button.secButton.overlay:GetDrawLayer(), 1)
	button.secButton.phaseIndicator:Hide()

	button.secButton.favourite = button.secButton:CreateTexture(buttonName.."_favourite", "OVERLAY")
	button.secButton.favourite:SetPoint("TOPLEFT", button.secButton.icon, -2, 2)
	button.secButton.favourite:SetHeight(20)
	button.secButton.favourite:SetWidth(20)
	button.secButton.favourite:SetAtlas("VignetteKill")
	button.secButton.favourite:SetDrawLayer(button.secButton.overlay:GetDrawLayer(), 2)
	button.secButton.favourite:Hide()

	-- factionIcon
	button.factionIcon = button:CreateTexture(buttonName.."_factionIcon", button)
	button.factionIcon:SetPoint("RIGHT", button.secButton, "LEFT", -2, 0)
	button.factionIcon:SetHeight(28)
	button.factionIcon:SetWidth(28)
	button.factionIcon:Hide()


	button.secButton.SetNormalTexture = Button_SetNormalTexture

	button:Hide()
	button.__atlaslootinfo = {}
	for k,v in pairs(Proto) do
		button[k] = v
	end

	return button
end

function Button:CreateSecOnly(frame)
	SEC_BUTTON_COUNT = SEC_BUTTON_COUNT + 1

	local buttonName = "AtlasLoot_SecButton_"..SEC_BUTTON_COUNT

	local button = frame or CreateFrame("FRAME", buttonName.."_container")

	button.secButton = CreateFrame("BUTTON", buttonName, button)
	button.secButton:SetAllPoints(button)
	button.secButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	button.secButton.OriSetNormalTexture = button.secButton.SetNormalTexture
	button.secButton.type = "secButton"	-- now we can use button functions ;)
	button.secButton.obj = button
	button.secButton:SetScript("OnEnter", Button_OnEnter)
	button.secButton:SetScript("OnLeave", Button_OnLeave)
	button.secButton:SetScript("OnClick", Button_OnClick)
	button.secButton:SetScript("OnMouseWheel", Button_OnMouseWheel)
	button.secButton:RegisterForClicks("AnyDown")

	-- secButtonTexture <texture>
	button.secButton.icon = button.secButton:CreateTexture(buttonName.."_secButtonIcon", button.secButton)
	button.secButton.icon:SetAllPoints(button.secButton)
	button.secButton.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

	--[[
	button.secButton.qualityBorder = button.secButton:CreateTexture(buttonName.."_secButtonQualityBorder")
	button.secButton.qualityBorder:SetAllPoints(button.secButton)
	button.secButton.qualityBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
	button.secButton.qualityBorder:Hide()
	]]--

	-- secButtonMini <texture>
	button.secButton.mini = button.secButton:CreateTexture(buttonName.."_secButtonMini")
	button.secButton.mini:SetPoint("TOPRIGHT", button.secButton.icon, "TOPRIGHT", 0, 0)
	button.secButton.mini:SetHeight(13)
	button.secButton.mini:SetWidth(13)
	button.secButton.mini:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	button.secButton.mini:Hide()

	-- secButtonOverlay <texture>
	button.secButton.overlay = button.secButton:CreateTexture(buttonName.."_secButtonOverlay", "OVERLAY")
	button.secButton.overlay:SetPoint("TOPLEFT", button.secButton.icon, "TOPLEFT")
	button.secButton.overlay:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT")
	button.secButton.overlay:Hide()
	button.secButton.overlay.SetQualityBorder = Button_Overlay_SetQualityBorder

	button.secButton.count = button.secButton:CreateFontString(buttonName.."_secCount", "ARTWORK", "AtlasLoot_ItemAmountFont")
	button.secButton.count:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT", -1, 1)
	button.secButton.count:SetJustifyH("RIGHT")
	button.secButton.count:SetHeight(15)
	button.secButton.count:SetText(15)
	button.secButton.count:Hide()

	button.secButton.pvp = button.secButton:CreateTexture(buttonName.."_secButtonPvp")
	button.secButton.pvp:SetPoint("BOTTOMRIGHT", button.secButton.icon, "BOTTOMRIGHT", -3, 3)
	button.secButton.pvp:SetHeight(13)
	button.secButton.pvp:SetWidth(13)
	button.secButton.pvp:SetDrawLayer(button.secButton.icon:GetDrawLayer(), 1)
	button.secButton.pvp:Hide()

	button.secButton.phaseIndicator = button.secButton:CreateTexture(buttonName.."_phaseIndicator", "OVERLAY")
	button.secButton.phaseIndicator:SetPoint("TOPLEFT", button.secButton.icon)
	button.secButton.phaseIndicator:SetPoint("BOTTOMRIGHT", button.secButton.icon)
	button.secButton.phaseIndicator:SetDrawLayer(button.secButton.overlay:GetDrawLayer(), 1)
	button.secButton.phaseIndicator:Hide()

	button.secButton.favourite = button.secButton:CreateTexture(buttonName.."_favourite", "OVERLAY")
	button.secButton.favourite:SetPoint("TOPLEFT", button.secButton.icon, -2, 2)
	button.secButton.favourite:SetHeight(18)
	button.secButton.favourite:SetWidth(18)
	button.secButton.favourite:SetAtlas("VignetteKill")
	button.secButton.favourite:SetDrawLayer(button.secButton.overlay:GetDrawLayer(), 2)
	button.secButton.favourite:Hide()

	button.secButton.SetNormalTexture = Button_SetNormalTexture

	button.secButton:Hide()
	button.__atlaslootinfo = {}
	for k,v in pairs(Proto) do
		button[k] = v
	end

	return button
end

API.Button_OnEnter = Button_OnEnter
API.Button_OnLeave = Button_OnLeave
API.Button_OnClick = Button_OnClick

--################################
-- Button Protos
--################################
function Proto:Clear()
	if self.IsShown and not self:IsShown() then return end
	if self.__atlaslootinfo.type and self.__atlaslootinfo.type[1] and button_types[self.__atlaslootinfo.type[1]].OnClear then
		button_types[self.__atlaslootinfo.type[1]].OnClear(self)
	end
	if self.__atlaslootinfo.secType and self.__atlaslootinfo.secType[1] and button_types[self.__atlaslootinfo.secType[1]].OnClear then
		button_types[self.__atlaslootinfo.secType[1]].OnClear(self)
	end

	if self.enhancedDesc then
		self.enhancedDesc:Clear()
		self.enhancedDesc = nil
		self.extra:Show()
	end

	if self.IsShown and self.icon then
		self.icon:SetTexture(nil)
		self.name:SetText(nil)
		self.extra:SetText(nil)
		self:SetAlpha(1.0)
		if self.count then self.count:Hide() end
		self.overlay:SetSize(self.icon:GetWidth(), self.icon:GetHeight())
		if self.completed then self.completed:Hide() end
		if self.favourite then self.favourite:Hide() end
		if self.phaseIndicator then self.phaseIndicator:Hide() end
		if self.overlay then
			self.overlay:SetDesaturated(false)
			self.overlay:Hide()
		end
		self:Hide()
	end
	if self.secButton then
		local secButton = self.secButton
		secButton:SetNormalTexture(nil)
		secButton.overlay:SetSize(secButton:GetWidth(), secButton:GetHeight())
		if secButton.count then secButton.count:Hide() end
		if secButton.completed then secButton.completed:Hide() end
		if secButton.favourite then secButton.favourite:Hide() end
		if secButton.phaseIndicator then secButton.phaseIndicator:Hide() end
		if secButton.overlay then
			secButton.overlay:SetDesaturated(false)
			secButton.overlay:Hide()
		end
		secButton:Hide()
	end

	if self.highlightBg then
		self.highlightBg:Hide()
	end

	wipe(self.__atlaslootinfo)
end

function Proto:SetPreSet(tab)
	self.__atlaslootinfo.preSet = tab
end
--- Set the content table
--[[ formatTab
	formatTab = {
		"Item",
		"Spell",
	}
]]--
function Proto:SetContentTable(tab, formatTab, setOnlySec)
	if not tab or tab[IGNORE_THIS_BUTTON_ID] then return end
	formatTab = formatTab or STANDART_FORMAT_TABLE
	self.formatTab = formatTab
	-- +1 because first is allways button position
	local sub
	local typ = formatTab[1]
	-- first load all info
	if setOnlySec then
		self.__atlaslootinfo.type = {}
	end

	for i = 1, #formatTab do
		self.__atlaslootinfo[formatTab[i]] = tab[i+1]
	end

	self.__atlaslootinfo.filterIgnore = tab[ATLASLOOT_IT_FILTERIGNORE]

	-- faction specific things must be replaced / set
	if self.factionIcon then
		if tab[ATLASLOOT_IT_HORDE] or tab[ATLASLOOT_IT_ALLIANCE] then
			local horde, alliance = tab[ATLASLOOT_IT_HORDE], tab[ATLASLOOT_IT_ALLIANCE]
			if horde or alliance then
				if alliance == false and PLAYER_FACTION_ID == 1 then
					tab[IGNORE_THIS_BUTTON_ID] = true
					return
				elseif horde == false and PLAYER_FACTION_ID == 0 then
					tab[IGNORE_THIS_BUTTON_ID] = true
					return
				else
					self.factionIcon:SetAtlas(FACTION_TEXTURES[ ( horde and alliance ) and PLAYER_FACTION_ID or ( horde and 0 or 1 )])
				end
			end

			if not tab[FACTION_INFO_IS_SET_ID] then
				horde = ( horde and alliance ) and ( PLAYER_FACTION_ID == 0 and horde or alliance ) or horde and horde or ( alliance and alliance or nil )
				if type(horde) == "table" then
					for i = 1, #horde do
						tab[i+1] = horde[i]
					end
				elseif horde and horde ~= true then
					tab[2] = horde
				end
				tab[FACTION_INFO_IS_SET_ID] = true
			end
			self.factionIcon:Show()
		else
			self.factionIcon:Hide()
		end
	end

	-- amount setup
	if tab[ATLASLOOT_IT_AMOUNT1] then
		self.count:SetText(tab[ATLASLOOT_IT_AMOUNT1])
		self.count:Show()
	end
	if tab[ATLASLOOT_IT_AMOUNT2] then
		self.secButton.count:SetText(tab[ATLASLOOT_IT_AMOUNT2])
		self.secButton.count:Show()
	end
	-- set difficulty if needed
	if self.__atlaslootinfo.preSet and self.__atlaslootinfo.preSet.Item and self.__atlaslootinfo.preSet.Item.addDifficultyBonus then
		self.__atlaslootinfo.ItemDifficulty = type(self.__atlaslootinfo.preSet.Item.addDifficultyBonus) == "number" and self.__atlaslootinfo.preSet.Item.addDifficultyBonus or self.__atlaslootinfo.difficulty
	end


	local formatType, curContent, buttonType
	for i = 1, #formatTab do
		formatType, curContent = formatTab[i], tab[i+1]
		self.__atlaslootinfo[formatType] = nil

		if formatType == "Name" and curContent then	-- force namechange
			self.name:SetText(curContent, true)
		elseif formatType == "Description" and curContent then -- force description change
			self.extra:SetText(curContent, true)
		elseif type(curContent) == "string" and not button_types[curContent] then
			local found = false
			for j=1, #button_types_index do
				buttonType = button_types[ button_types_index[j] ]
				sub = str_sub(curContent, 1, buttonType.identifierLength)
				if sub == buttonType.identifier then
					if buttonType.GetStringContent then
						self:SetType(button_types_index[j], buttonType.GetStringContent(str_sub(curContent, buttonType.identifierLength+1)))
					else
						self:SetType(button_types_index[j], tonumber(str_match(curContent, "(%d+)")))
					end
					found = true
					break
				end
			end
			if not found and button_types[formatType] and button_types[formatType].GetStringContent then
				self:SetType(formatType,  button_types[formatType].GetStringContent(curContent))
			end
		elseif button_types[curContent] then
			self.__atlaslootinfo[formatType] = nil
			if button_types[curContent].GetStringContent then
				self:SetType(i, button_types[curContent].GetStringContent(str_sub(curContent, button_types[curContent].identifierLength+1)))
			else
				self:SetType(formatType, curContent)
			end
		else
			self.__atlaslootinfo[formatType] = nil
			self:SetType(formatType, curContent)
		end
	end

	-- check for auto complete of second item
	if self.__atlaslootinfo.preSet and tab[3] == nil and self.__atlaslootinfo.type and self.__atlaslootinfo.type[1] == "Item" and self.__atlaslootinfo.preSet.Item and self.__atlaslootinfo.preSet.Item.autoCompleteItem2 then
		self:SetType("Item", self.__atlaslootinfo.type[2])
	end

	-- check for extra types
	if formatTab.extra then
		for i=1, #formatTab.extra do
			if tab[i+100] then
				self:SetExtraType(formatTab.extra[i], tab[i+100])
			end
		end
	end
end

function Proto:SetType(typ, val)
	--assert(typ, str_format("type '%s' not found", tostring(typ)))
	if not val or val == 0 or val == "" then return end
	if button_types[typ] then
		if self.__atlaslootinfo.type then
			self:SetSecType(typ, val)
		else
			self.__atlaslootinfo.type = { typ, val }
			if button_types[typ].OnSet then
				button_types[typ].OnSet(self)
			end
			if self.Show then self:Show() end
		end
	end
end

function Proto:SetSecType(typ, val)
	if not typ or not val or val == 0 or self.__atlaslootinfo.secType then return end
	--assert(typ and button_types[typ], str_format("type '%s' not found", tostring(typ)))
	self.__atlaslootinfo.secType = { typ, val }
	if button_types[typ].OnSet then
		button_types[typ].OnSet(self, true)
	end
	if self.__atlaslootinfo.secType then
		if self.IsShown and not self:IsShown() and self.Show then self:Show() end
		self.secButton:Show()
	end
end

function Proto:SetExtraType(typ, val)
	if extra_button_types[typ] then
		self:AddEnhancedDescription()
		--if self.__atlaslootinfo.extraType  then
		--	if type(self.__atlaslootinfo.extraType[1]) ~= "table" then
		--		self.__atlaslootinfo.extraType = { [1] = self.__atlaslootinfo.extraType }
		--	end
		--	self.__atlaslootinfo.extraType[#self.__atlaslootinfo.extraType+1] = { typ, val }
		--else
			self.__atlaslootinfo.extraType = { typ, val }
		--end
		self.enhancedDesc.ttInfo = typ
		extra_button_types[typ].OnSet(self, self.enhancedDesc)
	end
end

function Proto:SetDifficultyID(diffID)
	self.__atlaslootinfo.difficulty = diffID
end

function Proto:SetNpcID(npcID)
	self.__atlaslootinfo.npcID = npcID
end

function Proto:GetTypeFunctions()
	return self.__atlaslootinfo.type and button_types[self.__atlaslootinfo.type[1]] or nil
end

function Proto:GetSecTypeFunctions()
	return button_types[self.__atlaslootinfo.secType[1]]
end
--################################
-- Enhanced Description
--################################
local EnhancedDescriptionCache = { desc = {}, text = {}, icon = {} }

local function getEnhancedDescription(typ)
	local desc = next(EnhancedDescriptionCache[typ])
	if desc then
		EnhancedDescriptionCache[typ][desc] = nil
	end
	return desc
end

local function freeEnhancedDescription(typ, desc)
	EnhancedDescriptionCache[typ][desc] = true
end

local EnhancedDescriptionProto = {
	["Clear"] = function(self)
		self:Hide()
		self.contentSize = 0
		self.info = nil
		self.ttInfo = nil
		if self.removerInfo then
			self.removerInfo[1](self.removerInfo[2])
			self.removerInfo = nil
		end

		for i = 1, #self.content do
			freeEnhancedDescription(self.content[i].typ, self.content[i])
			self.content[i]:Hide()
			self.content[i] = nil
		end

		freeEnhancedDescription("desc", self)
	end,
	["AddText"] = function(self, text)
		if self.contentSize == self.parWidth then return end
		local textFrame = getEnhancedDescription("text")
		if not textFrame then
			textFrame = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			textFrame:SetJustifyH("LEFT")
			--textFrame:SetText("")
			textFrame:SetHeight(10)
			textFrame:SetTextColor(1, 1, 1, 1)

			textFrame.typ = "text"
		end
		textFrame:ClearAllPoints()
		textFrame:SetParent(self)

		textFrame:SetText(text)
		textFrame:SetWidth(0)
		textFrame:SetWidth(textFrame:GetStringWidth())

		self.contentSize = self.contentSize + textFrame:GetWidth() + 1

		if self.contentSize > self.parWidth then
			textFrame:SetWidth(textFrame:GetWidth() - (self.contentSize - self.parWidth))
			self.contentSize = self.parWidth
		end

		if #self.content > 0 then
			textFrame:SetPoint("LEFT", self.content[#self.content], "RIGHT", 1, 0)
		else
			textFrame:SetPoint("LEFT", self, "LEFT", 0, 0)
		end

		textFrame:Show()
		self.content[#self.content+1] = textFrame
	end,
	["AddIcon"] = function(self, path, size)
		if self.contentSize == self.parWidth then return end
		local iconFrame = getEnhancedDescription("icon")
		if not iconFrame then
			iconFrame = self:CreateTexture()
			iconFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)

			iconFrame.typ = "icon"
		end
		size = size or self:GetHeight()
		iconFrame:ClearAllPoints()
		iconFrame:SetParent(self)

		iconFrame:SetTexture(path or "Interface\\Icons\\INV_Misc_QuestionMark")

		iconFrame:SetSize(size,size)

		self.contentSize = self.contentSize + size + 1

		if self.contentSize > self.parWidth then
			iconFrame:Clear()
			self.contentSize = self.parWidth
			return
		end

		if #self.content > 0 then
			iconFrame:SetPoint("LEFT", self.content[#self.content], "RIGHT", 0, 0)
		else
			iconFrame:SetPoint("LEFT", self, "LEFT", 0, 0)
		end

		iconFrame:Show()
		self.content[#self.content+1] = iconFrame
	end
}

local function enhancedDescription_OnEnter(self)
	if not self.ttInfo or not extra_button_types[self.ttInfo].OnEnter then return end
	local tooltip = GetAlTooltip()
	tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 24)
	extra_button_types[self.ttInfo].OnEnter(self, tooltip)
	tooltip:Show()
end

local function enhancedDescription_OnLeave(self)
	if not self.ttInfo or not extra_button_types[self.ttInfo].OnEnter then return end
	GetAlTooltip():Hide()
end

function Proto:AddEnhancedDescription()
	if self.enhancedDesc then return end
	local desc = getEnhancedDescription("desc")
	if not desc then
		desc = CreateFrame("FRAME")
		desc:SetScript("OnEnter", enhancedDescription_OnEnter)
		desc:SetScript("OnLeave", enhancedDescription_OnLeave)

		desc.content = {}

		for k, v in pairs(EnhancedDescriptionProto) do
			desc[k] = v
		end
	end

	desc:Show()
	desc:ClearAllPoints()
	desc:SetParent(self)
	desc:SetAllPoints(self.extra)

	desc.parWidth = self.extra:GetWidth()
	desc.contentSize = 0

	self.enhancedDesc = desc
	self.extra:Hide()
	return desc
end
--################################
-- Type register
--################################
--[[
	:OnSet(second)			-- on type change
	:OnEnter()				-- on button enter
	:OnLeave()				-- on button leave
	:OnMouseAction(mouseAction)	-- on button action
	:OnClear()				-- clears the button
	.GetStringContent(s)	-- Gets the content from a string in the table e.g. " string.match(s, "(%d+)") "
]]
function Button:AddType(typ, identifier)
	assert(typ and type(typ) == "string", "typ must be a string.")
	assert(identifier and type(identifier) == "string", "identifier must be a string.")
	if not button_types[typ] then
		button_types_index[#button_types_index+1] = typ
		button_types[typ] = {
			index = #button_types_index,
			identifier = identifier,
			identifierLength = str_len(identifier),
		}

		--[[
		setmetatable(button_types[typ], {
			--__newindex = function(t, k, v)
			--	assert(type(v) == "function", string.format("Cant set value '%s' into key '%s'. Value must be a function.", tostring(v), tostring(k)))
			--	rawset(t, k, v)
			--end,
			__index = Proto,
		})
		]]--
	end

	return button_types[typ]
end

function Button:AddIdentifier(sourceType, identifier)
	if button_types[sourceType] then
		return setmetatable(Button:AddType(sourceType..identifier, identifier), {__index = button_types[sourceType]})
	end
end

function Button:GetType(typ)
	assert(button_types[typ], typ.." type not found")
	return button_types[typ]
end

function Button:AddExtraType(typ)
	assert(typ and type(typ) == "string", "typ must be a string.")
	if not extra_button_types[typ] then
		extra_button_types[typ] = {

		}
		extra_button_types_index[#extra_button_types_index+1] = typ
	end

	return extra_button_types[typ]
end

function Button:GetExtraType(typ)
	assert(extra_button_types_index[typ], typ.." type not found")
	return extra_button_types_index[typ]
end

function Button:FormatItemTableType(tab)
	assert(tab and type(tab) == "table", "tab must be a table.")

end

--################################
-- Extra Items Frame
--################################
local ITEM_ICON_SIZE = 30
local ITEM_DISTANCE = 3
local BORDER_DISTANCE = 6
local MAX_ITEMS_PER_LINE = 9
local ExtraItemFrame_Frame

local function ExtraItemFrame_AddButton(self)
	local container = self.Container
	local shownContainer = self.ShownContainer
	local button = next(container)
	if not button then
		button = AtlasLoot.Button:CreateSecOnly()
		button:SetSize(ITEM_ICON_SIZE,ITEM_ICON_SIZE)
		button:SetParent(self)
		button.secButton.IsExtraItemFrameButton = true
	end
	container[button] = nil

	if #shownContainer < 1 then
		button:SetPoint("TOPLEFT", self, "TOPLEFT", BORDER_DISTANCE, -BORDER_DISTANCE)
	else
		if #shownContainer % MAX_ITEMS_PER_LINE == 0 then
			button:SetPoint("TOPLEFT", shownContainer[(#shownContainer-MAX_ITEMS_PER_LINE) + 1], "BOTTOMLEFT", 0, -ITEM_DISTANCE)
		else
			button:SetPoint("TOPLEFT", shownContainer[#shownContainer], "TOPRIGHT", ITEM_DISTANCE, 0)
		end
	end
	button:Show()
	shownContainer[#shownContainer + 1] = button
	return button
end

local function ExtraItemFrame_ClearAllButtons(self)
	if not self.ItemList and not self:IsShown() then return end
	for i = 1, #self.ShownContainer do
		self.Container[self.ShownContainer[i]] = true
		self.ShownContainer[i]:Clear()
		self.ShownContainer[i]:Hide()
	end
	wipe(self.ShownContainer)
	self:Hide()
	self:SetWidth(BORDER_DISTANCE*2)
	self:SetHeight(ITEM_ICON_SIZE+(BORDER_DISTANCE*2))
	self.ItemList = nil
	self.button = nil
end

local function ExtraItemFrame_Refresh(self, triggerButton)
	if not self.ItemList and not self:IsShown() then return end
	local itemList, button = self.ItemList, self.button
	ExtraItemFrame_ClearAllButtons(self)
	Button:ExtraItemFrame_GetFrame(button, itemList)
	if triggerButton and triggerButton.IsExtraItemFrameButton then
		if button.type == "secButton" then
			button.obj:GetSecTypeFunctions().Refresh(button)
		else
			button:GetTypeFunctions().Refresh(button)
		end
	end
end

function Button:ExtraItemFrame_GetFrame(button, itemList)
	if button and button.IsExtraItemFrameButton then return end -- skip own buttons
	local frame = ExtraItemFrame_Frame
	if frame and frame.ItemList then
		if frame.button == button then
			return ExtraItemFrame_Frame:Clear()
		else
			ExtraItemFrame_Frame:Clear()
		end
	elseif not frame then
		frame = CreateFrame("frame")
		frame:SetClampedToScreen(true)
		frame:SetHeight(ITEM_ICON_SIZE+(BORDER_DISTANCE*2))
		frame:SetWidth(BORDER_DISTANCE*2)
		frame:SetBackdrop(ALPrivate.BOX_BORDER_BACKDROP)
		frame:SetBackdropColor(1,1,1,1)
		frame:EnableMouse(true)

		frame.Container = {}
		frame.ShownContainer = {}
		frame.AddButton = ExtraItemFrame_AddButton
		frame.Clear = ExtraItemFrame_ClearAllButtons
		frame.Refresh = ExtraItemFrame_Refresh

		frame:Hide()
		ExtraItemFrame_Frame = frame
	end

	local line = 0
	local fixedCounter, lineItem, biggestLineItem = 0, 0, 0
	local skipScaling = true
	for i = 1, #itemList do
		local item = itemList[i]

		-- get new Line, 0 = new line
		if item == 0 then
			line = line + 1
			-- if we have a new line we must create some empty buttons
			local newButtonCount = ( line * MAX_ITEMS_PER_LINE ) - fixedCounter
			fixedCounter = fixedCounter + newButtonCount
			for i = 1, newButtonCount do
				frame:AddButton():Hide()
			end
			skipScaling = true
			lineItem = 0
		else
			lineItem = lineItem + 1
			fixedCounter = fixedCounter + 1
			if type(item) == "table" then
				frame:AddButton():SetContentTable({ 1, 0, item[1], [ATLASLOOT_IT_AMOUNT2] = item[2] }, nil, true)
			else
				frame:AddButton():SetContentTable({ 1, 0, item }, nil, true)
			end
			skipScaling = false
		end

		if not skipScaling then
			if fixedCounter > MAX_ITEMS_PER_LINE and fixedCounter % (MAX_ITEMS_PER_LINE+1) == 0 then
				frame:SetHeight(frame:GetHeight() + ITEM_ICON_SIZE + ITEM_DISTANCE)
			elseif fixedCounter == 1 then
				frame:SetWidth(frame:GetWidth() + ITEM_ICON_SIZE)
			elseif lineItem <= MAX_ITEMS_PER_LINE and lineItem > biggestLineItem then
				biggestLineItem = lineItem
				frame:SetWidth(frame:GetWidth() + ITEM_ICON_SIZE + ITEM_DISTANCE)
			end
		end
	end

	local newParent = button:GetParent():GetParent()
	if newParent ~= frame then
		frame:ClearAllPoints()
		frame:SetParent(newParent)
		frame:SetPoint("TOPLEFT", button, "BOTTOMLEFT")
		frame:SetFrameStrata("TOOLTIP")
		frame.button = button
	end
	frame:Show()
	frame.ItemList = itemList

	return frame
end

function Button:ExtraItemFrame_Refresh(triggerButton)
	if not ExtraItemFrame_Frame then return end
	ExtraItemFrame_Frame:Refresh(triggerButton)
end

function Button:ExtraItemFrame_ClearFrame()
	if not ExtraItemFrame_Frame then return end
	ExtraItemFrame_Frame:Clear()
end


--################################
-- WowHead Copy Frame
--################################
local CopyBox_Frame
local COPY_BOX_HIDE_AFTER, COPY_BOX_HIDE_AFTER_ENTER = 3, 0.5

local function CopyBox_SetCopyText(self, text)
	if not text or text == self.text then
		self.text = nil
		self:Hide()
		return false
	end

	if self:IsShown() then self:Hide() end
	self:SetText(text)
	self.tLenght:SetText(text)
	self:SetWidth(self.tLenght:GetStringWidth() + 20)
	self.text = text

	self:Show()
	return true
end

local function CopyBox_OnUpdate(self, elapsed)
	if not self.time then return end
	self.time = self.time - elapsed
	if self.time <= 0 then
		self:Hide()
	end
end

local function CopyBox_Create()
	local frame = CreateFrame("EditBox")
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", 70, 4)
	frame:SetHeight(16)
	frame:SetFontObject("GameFontNormal")
	frame:SetBlinkSpeed(0)
	frame:SetAutoFocus(false)
	frame:EnableKeyboard(false)
	frame:SetScript("OnKeyDown", function() end)
	frame:SetScript("OnMouseUp", function()
		if frame:IsMouseOver() then
			frame:HighlightText()
		else
			frame:HighlightText(0, 0)
		end
	end)
	frame:SetScript("OnEnter", function(self)
		local tooltip = GetAlTooltip()
		tooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -5)
		tooltip:SetText(AL["Ctrl + C to copy"], nil, nil, nil, nil, true)
		tooltip:Show()
		self:HighlightText()
		self:SetFocus()
		self.time = nil
	end)
	frame:SetScript("OnLeave", function(self)
		GetAlTooltip():Hide()
		self:ClearFocus()
		self.time = COPY_BOX_HIDE_AFTER_ENTER -- let it stay some time
	end)
	frame:SetScript("OnShow", function(self)
		self.time = COPY_BOX_HIDE_AFTER
	end)
	frame:SetScript("OnHide", function(self)
		if self:IsShown() then self:Hide() end -- fix for when the frame itself is not hidden
		GetAlTooltip():Hide()
		self:ClearFocus()
		self.text = nil
		self.time = nil
	end)
	frame:SetScript("OnUpdate", CopyBox_OnUpdate)

	frame.bg = frame:CreateTexture(nil, "BACKGROUND")
	frame.bg:SetAllPoints(frame)
	frame.bg:SetColorTexture(0.1, 0.1, 0.1, 1.0)

	frame.tLenght = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	frame.tLenght:Hide()

	frame.SetCopyText = CopyBox_SetCopyText

	return frame
end

function Button:CopyBox_Show(button, text)
	if not CopyBox_Frame then
		CopyBox_Frame = CopyBox_Create()
	end
	if CopyBox_Frame:SetCopyText(text) then
		CopyBox_Frame:ClearAllPoints()
		CopyBox_Frame:SetParent(button)
		CopyBox_Frame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -1)
	end
end

function Button:CopyBox_Hide()
	if CopyBox_Frame and CopyBox_Frame:IsShown() then
		CopyBox_Frame:Hide()
	end
end