local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local SoundFrame = {}
AtlasLoot.GUI.SoundFrame = SoundFrame
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler

-- lua
local str_format = string.format
local min, floor = min, floor
local ipairs = ipairs

-- //\\
local SCROLL_STEP = 1
local MAX_SOUNDS_PER_PAGE = 15 -- = 30 height

local BUTTON_MAIN_COLOR1 = {r = 0.50196, g = 0.50196, b = 0.50196}
local BUTTON_MAIN_COLOR2 = {r = 0.50196, g = 0.50196, b = 0.50196}
local BUTTON_SUB_COLOR1 = {r = 0.75294, g = 0.75294, b = 0.75294}
local BUTTON_SUB_COLOR2 = {r = 0.75294, g = 0.75294, b = 0.75294}
local BUTTON_MAIN_ALPHA = 0.8
local BUTTON_SUB_ALPHA = 0.8

local NUM_SOUND_FILES_FORMATE = "( %d/%d )"

local UpdateContent
local SoundItemClickHandler = nil

-- ##########################
-- SoundButton
-- ##########################
local function OnStopClick(self)
	if self.stopId then
		StopSound(self.stopId)
		self.stopId = nil
	end
end

local function OnPlayClick(self)
	if self.soundFile then
		-- stop last sound (DoubleClickProtect xD)
		OnStopClick(self.stop)
		if self.info then
			self.stop.stopId = AtlasLoot.ItemDB.SoundData:PlaySound(self.soundFile)
			self.info.curFile = self.info.curFile + 1
			if self.info.curFile > self.info.numFiles then self.info.curFile = 1 end
			self.soundFile = self.info.sounds[self.info.curFile]
			self.obj.count:SetText(str_format(NUM_SOUND_FILES_FORMATE, self.info.curFile, self.info.numFiles))
		else
			self.stop.stopId = AtlasLoot.ItemDB.SoundData:PlaySound(self.soundFile)
		end
	end
end

local function OnCollapseClick(self)
	if self.info then
		self.info.collapsed = not self.info.collapsed
		UpdateContent(true)
	end
end


local function CreateSoundButtons()

	for i=1,MAX_SOUNDS_PER_PAGE do
		local frameName = "AtlasLoot-SoundButton"..i

		local frame = CreateFrame("FRAME", frameName)
		frame:SetHeight(28)
		frame:SetWidth(550)
		frame:ClearAllPoints()
		frame:SetParent(SoundFrame.frame)
		frame:SetFrameLevel(SoundFrame.frame:GetFrameLevel()+1)

		frame.bg = frame:CreateTexture(frameName.."-bg","BACKGROUND")
		frame.bg:SetPoint("TOPLEFT", frame)
		frame.bg:SetPoint("BOTTOMRIGHT", frame)
		frame.bg:SetTexture(BUTTON_MAIN_COLOR1.r, BUTTON_MAIN_COLOR1.g, BUTTON_MAIN_COLOR1.b, BUTTON_MAIN_ALPHA)

		frame.collapse = CreateFrame("BUTTON", frameName.."-collapse", frame)
		frame.collapse:SetPoint("LEFT", frame, "LEFT", 3, 0)
		frame.collapse:SetWidth(22)
		frame.collapse:SetHeight(22)
		frame.collapse:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Up") --"Interface\\Minimap\\UI-Minimap-ZoomOutButton-Up"
		frame.collapse:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Down")
		frame.collapse:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
		frame.collapse:SetScript("OnClick", OnCollapseClick)

		frame.count = frame:CreateFontString(frameName.."-count", "ARTWORK", "GameFontNormal")
		frame.count:SetPoint("RIGHT", frame, "RIGHT", -3, 0)
		frame.count:SetHeight(28)
		frame.count:SetJustifyH("CENTER")
		frame.count:SetText(str_format(NUM_SOUND_FILES_FORMATE, 10, 10))

		frame.stop = CreateFrame("BUTTON", frameName.."-stop", frame)
		frame.stop:SetPoint("RIGHT", frame.count, "LEFT", -5, 0)
		frame.stop:SetWidth(22)
		frame.stop:SetHeight(22)
		frame.stop:SetNormalTexture("Interface\\TimeManager\\ResetButton")
		frame.stop:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
		frame.stop:SetScript("OnClick", OnStopClick)

		frame.play = CreateFrame("BUTTON", frameName.."-play", frame)
		frame.play:SetPoint("RIGHT", frame.stop, "LEFT", -3, 0)
		frame.play:SetWidth(22)
		frame.play:SetHeight(22)
		frame.play:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
		frame.play:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
		frame.play:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
		frame.play:SetScript("OnClick", OnPlayClick)
		frame.play.obj = frame
		frame.play.stop = frame.stop


		frame.name = frame:CreateFontString(frameName.."-name", "ARTWORK", "GameFontNormal")
		frame.name:SetPoint("LEFT", frame, "LEFT", 28, 0)
		frame.name:SetPoint("RIGHT", frame.play, "LEFT")
		frame.name:SetHeight(28)
		frame.name:SetJustifyH("LEFT")
		frame.name:SetJustifyV("CENTER")
		frame.name:SetText("Sound.name")

		if i==1 then
			frame:SetPoint("TOPLEFT", SoundFrame.frame, "TOPLEFT", 5, -1)
		else
			frame:SetPoint("TOPLEFT", SoundFrame.frame.buttons[#SoundFrame.frame.buttons], "BOTTOMLEFT", 0, -2)
		end

		SoundFrame.frame.buttons[i] = frame
	end
end

local function ClearButtonList()
	local frame
	for i=1,MAX_SOUNDS_PER_PAGE do
		frame = SoundFrame.frame.buttons[i]

		frame.stop.stopId = nil
		frame.play.soundFile = nil
		frame.play.info = nil

		frame:Hide()
	end
end

local function GetStartAndEndPos()
	if not SoundFrame.enableScroll then
		return 1, nil, #SoundFrame.data
	end

	local startPos, endPos = 1,1

	if SoundFrame.scrollCurPos then

		if SoundFrame.scrollCurPos + MAX_SOUNDS_PER_PAGE - 1 >= SoundFrame.numContent then
			startPos = SoundFrame.numContent - MAX_SOUNDS_PER_PAGE + 1
			endPos = MAX_SOUNDS_PER_PAGE
		else
			startPos = SoundFrame.scrollCurPos
			endPos = SoundFrame.scrollCurPos + MAX_SOUNDS_PER_PAGE - 1
		end
	else
		startPos = 1
		endPos = SoundFrame.numContent
	end

	return startPos, endPos
end

--[[
data[index] = {
		kitId = kitId,
		numFiles = Storage["sounddata"][kitId][3] or 1,
		name = Storage["sounddata"][kitId][1],
		sounds = {},
	}
]]--

local function UpdateScroll()
	if not SoundFrame.data or #SoundFrame.data < 1 then return end

	local startPos, endPos = GetStartAndEndPos()
	local info, button, pos
	local fixValue = 0
	for i=1,MAX_SOUNDS_PER_PAGE do
		if i+fixValue > MAX_SOUNDS_PER_PAGE then break end
		button = SoundFrame.frame.buttons[i+fixValue]
		pos = startPos + i - 1
		info = SoundFrame.dataScroll --[startPos + i - 1]
		if info[pos] then
			info = SoundFrame.data[info[pos][1]]
			pos = SoundFrame.dataScroll[pos][2]
		else
			info = nil
		end

		if info then
			if pos == true or pos == nil then
				if SoundFrame.enableScroll then
					button:SetWidth(525)
				else
					button:SetWidth(550)
				end


				button.name:SetText(info.name)
				if not info.curFile or info.curFile > info.numFiles then info.curFile = 1 end
				button.count:Show()
				button.count:SetText(str_format(NUM_SOUND_FILES_FORMATE, info.curFile, info.numFiles))
				button.stop:SetPoint("RIGHT", button.count, "LEFT", -5, 0)
				button.collapse:Show()
				button.collapse.info = info

				button.play.info = info
				button.play.soundFile = info.sounds[info.curFile]

				if i%2 == 0 then
					button.bg:SetTexture(BUTTON_MAIN_COLOR1.r, BUTTON_MAIN_COLOR1.g, BUTTON_MAIN_COLOR1.b, BUTTON_MAIN_ALPHA)
				else
					button.bg:SetTexture(BUTTON_MAIN_COLOR2.r, BUTTON_MAIN_COLOR2.g, BUTTON_MAIN_COLOR2.b, BUTTON_MAIN_ALPHA)
				end

				if pos == true then
					button.collapse:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Up")
					button.collapse:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Down")
					button.collapse:Show()
				else
					button.collapse:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Up")
					button.collapse:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Down")
					button.collapse:Show()
				end

				button:Show()
			elseif pos and info.sounds[pos] then
				if SoundFrame.enableScroll then
					button:SetWidth(525)
				else
					button:SetWidth(550)
				end

				button.collapse:Hide()
				button.name:SetText(info.sounds[pos])
				button.count:Hide()
				button.stop:SetPoint("RIGHT", button, "RIGHT", -3, 0)

				button.play.soundFile = info.sounds[pos]

				if pos%2 == 0 then
					button.bg:SetTexture(BUTTON_SUB_COLOR1.r, BUTTON_SUB_COLOR1.g, BUTTON_SUB_COLOR1.b, BUTTON_SUB_ALPHA)
				else
					button.bg:SetTexture(BUTTON_SUB_COLOR2.r, BUTTON_SUB_COLOR2.g, BUTTON_SUB_COLOR2.b, BUTTON_SUB_ALPHA)
				end
				button:Show()
			end

		else
			button:Hide()
		end
	end
end

function UpdateContent(noPosUpdate)
	if not SoundFrame.data then return end
	ClearButtonList()
	wipe(SoundFrame.dataScroll)

	for k,v in ipairs(SoundFrame.data) do
		SoundFrame.dataScroll[#SoundFrame.dataScroll+1] = {k, nil}
		if v.collapsed then
			SoundFrame.dataScroll[#SoundFrame.dataScroll][2] = true
			for i in ipairs(v.sounds) do
				SoundFrame.dataScroll[#SoundFrame.dataScroll+1] = {k, i}
			end
		end
	end

	SoundFrame.numContent = #SoundFrame.dataScroll
	SoundFrame.scrollMax = SoundFrame.numContent - MAX_SOUNDS_PER_PAGE + 1
	if SoundFrame.numContent > MAX_SOUNDS_PER_PAGE then
		SoundFrame.enableScroll = true
		SoundFrame.frame.scrollbar:Show()
		local oldValue = SoundFrame.frame.scrollbar:GetValue()
		SoundFrame.frame.scrollbar:SetMinMaxValues(1, SoundFrame.scrollMax)
		if noPosUpdate then
			SoundFrame.frame.scrollbar:SetValue(oldValue)
		else
			SoundFrame.frame.scrollbar:SetValue(1)
		end
	else
		SoundFrame.enableScroll = false
		SoundFrame.frame.scrollbar:Hide()
	end
	UpdateScroll()
end

-- value: up +1, down -1
local function OnMouseWheel(self, value)
	if not SoundFrame.enableScroll then return end
	SoundFrame.scrollCurPos = SoundFrame.scrollCurPos - value
	if SoundFrame.scrollCurPos >= SoundFrame.scrollMax then SoundFrame.scrollCurPos = SoundFrame.scrollMax end
	if SoundFrame.scrollCurPos <= 0 then SoundFrame.scrollCurPos = 1 end
	self.scrollbar:SetValue(min(SoundFrame.scrollCurPos, SoundFrame.scrollMax))
end

local function OnValueChanged(self, value)
	if not SoundFrame.enableScroll then return end
	SoundFrame.scrollCurPos = floor(value)

	if SoundFrame.scrollCurPos <= 0 then SoundFrame.scrollCurPos = 1 end
	UpdateScroll()
end

function SoundFrame:Create()
	if self.frame then return self.frame end
	if not SoundItemClickHandler then
		SoundItemClickHandler = ClickHandler:Add(
		"Sound",
		{
			ChatLink = { "LeftButton", "Shift" },
			CopyBox = { "LeftButton", "Ctrl" },
			types = {
				ChatLink = true,
				CopyBox = true,
			},
		},
		AtlasLoot.db.Button.Sound.ClickHandler,
		{
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add sound into chat"] },
			{ "CopyBox", 	AL["Copy Box"], 	AL["Shows the sound in the copy box"] },
		})
	end

	local frameName = "AtlasLoot_GUI-SoundFrame"

	self.frame = CreateFrame("FRAME", frameName, GUI.frame)
	local frame = self.frame
	frame:ClearAllPoints()
	frame:SetParent(GUI.frame)
	frame:SetPoint("TOPLEFT", GUI.frame.contentFrame.itemBG)
	frame:SetWidth(560)
	frame:SetHeight(450)
	--frame:Hide()

	frame.Refresh = SoundFrame.Refresh
	frame.Clear = SoundFrame.Clear

	-- soundbuttons here !
	frame.buttons = {}

	-- the f***ing scrollbar..
	frame:SetScript("OnMouseWheel", OnMouseWheel)
	frame.scrollbar = CreateFrame("Slider", frameName.."-scrollbar", frame, "UIPanelScrollBarTemplate")
	frame.scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", -20, -20)
	frame.scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 20, 20)
	frame.scrollbar:SetScript("OnValueChanged", OnValueChanged)
	frame.scrollbar:SetMinMaxValues(0, 1000)
	frame.scrollbar:SetValueStep(SCROLL_STEP)
	frame.scrollbar.scrollStep = SCROLL_STEP
	frame.scrollbar:SetValue(0)
	frame.scrollbar:SetWidth(16)
	--frame.scrollbar:Hide()

	frame.scrollbar.obj = self

	SoundFrame.enableScroll = false
	SoundFrame.scrollCurPos = 1
	SoundFrame.scrollMax = 1
	SoundFrame.numContent = 1
	SoundFrame.dataScroll = {}

	CreateSoundButtons()

	return self.frame
end

function SoundFrame:Show()
	if not SoundFrame.frame then SoundFrame:Create() end
	if not SoundFrame.frame:IsShown() or GUI.frame.contentFrame.shownFrame ~= SoundFrame.frame then
		GUI:HideContentFrame()
		SoundFrame.frame:Show()
		GUI.frame.contentFrame.shownFrame = SoundFrame.frame
		SoundFrame:Refresh()
	end
end

function SoundFrame:Refresh()
	--SoundFrame.npcId
	SoundFrame.data = AtlasLoot.ItemDB.SoundData:GetNpcData(SoundFrame.npcId)
	UpdateContent()
end

function SoundFrame.Clear()
	ClearButtonList()
	SoundFrame.frame:Hide()
end
-- Sound Entry
