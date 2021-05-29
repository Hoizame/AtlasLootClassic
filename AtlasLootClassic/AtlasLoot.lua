local ALName, ALPrivate = ...
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)

-- lua
local assert, type, pairs, next = assert, type, pairs, next
local wipe = wipe

-- wow
local CreateFrame = CreateFrame
local UnitPosition = UnitPosition
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales

local LibStub = _G.LibStub

-- lua

-- WoW
local SendAddonMessage = C_ChatInfo.SendAddonMessage
local RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix

-- DisableAddOn

local EventFrame = CreateFrame("FRAME")
EventFrame:RegisterEvent("ADDON_LOADED")

local function EventFrame_OnEvent(frame, event, arg1, ...)
	if event == "ADDON_LOADED" and arg1 and AtlasLoot.Init[arg1] then
		AtlasLoot:OnInitialize()
		-- init all other things
		if AtlasLoot.Init then
			for i = 1, #AtlasLoot.Init[arg1] do
				local func = AtlasLoot.Init[arg1][i]
				if func and type(func) == "function" then
					func()
				end
			end
			AtlasLoot.Init[arg1] = nil
		end
		if not next(AtlasLoot.Init) then
			EventFrame:UnregisterEvent("ADDON_LOADED")
		end
	end
end
EventFrame:SetScript("OnEvent", EventFrame_OnEvent)

function AtlasLoot:Print(msg)
	print("|cff33ff99AtlasLoot|r: "..(msg or ""))
end

function AtlasLoot:DevPrint(msg)
	if AtlasLoot.IsDevVersion then
		print("|cff33ff99AtlasLoot-Dev|r: "..(msg or ""))
	end
end

function AtlasLoot:OnProfileChanged()
	AtlasLoot.db = AtlasLoot.dbRaw.profile

	AtlasLoot.ClickHandler:OnProfileChanged()
	AtlasLoot.Addons:OnProfileChanged()
	AtlasLoot.GUI:ForceUpdate()

	AtlasLoot.Data.AutoSelect:RefreshOptions()
end

function AtlasLoot:OnInitialize()
	self.dbRaw = LibStub("AceDB-3.0"):New("AtlasLootClassicDB", AtlasLoot.AtlasLootDBDefaults)
	self.db = self.dbRaw.profile
	self.dbGlobal = self.dbRaw.global

	self.dbRaw.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.dbRaw.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.dbRaw.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	self.dbGlobal.__addonrevision = self.IsDevVersion and 0 or self.__addonrevision

	RegisterAddonMessagePrefix(ALPrivate.ADDON_MSG_PREFIX)

	-- bindings
	BINDING_HEADER_ATLASLOOT = AL["AtlasLoot"]
	BINDING_NAME_ATLASLOOT_TOGGLE = AL["Toggle AtlasLoot"]

	-- version
	AtlasLoot.SendAddonVersion("GUILD")
end

function AtlasLoot:AddInitFunc(func, module)
	assert(type(func) == "function", "'func' must be a function.")
	if not EventFrame:IsEventRegistered("ADDON_LOADED") then
		EventFrame:RegisterEvent("ADDON_LOADED")
	end
	module = module or "AtlasLootClassic"
	if not AtlasLoot.Init[module] then AtlasLoot.Init[module] = {} end
	AtlasLoot.Init[module][#AtlasLoot.Init[module]+1] = func
end

function AtlasLoot.ReturnForGameVersion(classic, bcc)
	if ALPrivate.IS_CLASSIC then
		return classic
	elseif ALPrivate.IS_BC then
		return bcc
	end
end
-- #############################
-- ClassColors
-- #############################
local CLASS_COLOR_FORMAT = "|c%s%s|r"
local CLASS_NAMES_WITH_COLORS

function AtlasLoot:GetColoredClassNames()
	if not CLASS_NAMES_WITH_COLORS then
		CLASS_NAMES_WITH_COLORS = {}
		for k,v in pairs(RAID_CLASS_COLORS) do
			if v.colorStr then
				CLASS_NAMES_WITH_COLORS[k] = format(CLASS_COLOR_FORMAT,  v.colorStr, AtlasLoot.IngameLocales[k] or k)
			end
		end
	end
	return CLASS_NAMES_WITH_COLORS
end

-- #############################
-- UpdateChecker
-- #############################
local UpdateSendMsg = "#v:"
local UpdateGetMsg = "#v:(%d+)"
local UpdateCheckerFrame = CreateFrame("FRAME")
local IsAddonUpdateAviable = false
local UpdatedVersionRev = AtlasLoot.__addonrevision

local function UpdateCheckFrameOnEvent(frame, event, arg1, ...)
	if event == "CHAT_MSG_ADDON" and arg1 == ALPrivate.ADDON_MSG_PREFIX then
		local text, channel, sender, target, zoneChannelID, localID, name, instanceID = ...
		--if sender ~= ALPrivate.PLAYER_NAME then
			local v = text:match(UpdateGetMsg)
			v = tonumber(v or 0)
			if v and v > 0 and AtlasLoot.IsDevVersion then
				AtlasLoot:DevPrint(format("Player '|cff00FAF6%s|r' sends version '|cff00FF96%d|r'!", sender, v))
			end
			if v and v > 0 and v > UpdatedVersionRev and v < 99999999 then
				IsAddonUpdateAviable = true
				UpdatedVersionRev = v
				AtlasLoot.GUI.RefreshVersionUpdate()
			end
		--end
	elseif event == "GROUP_JOINED" then
		AtlasLoot.SendAddonVersion("RAID")
		AtlasLoot.SendAddonVersion("PARTY")
	elseif event == "RAID_ROSTER_UPDATE" then
		AtlasLoot.SendAddonVersion("RAID")
	end
end

UpdateCheckerFrame:SetScript("OnEvent", UpdateCheckFrameOnEvent)
UpdateCheckerFrame:RegisterEvent("CHAT_MSG_ADDON")
UpdateCheckerFrame:RegisterEvent("GROUP_JOINED")
UpdateCheckerFrame:RegisterEvent("RAID_ROSTER_UPDATE")

function AtlasLoot.SendAddonVersion(channel, target)
	if AtlasLoot.IsDevVersion then return end
	if not channel then return end
	if channel == "GUILD" and not IsInGuild() then return end
	if channel == "PARTY" and not IsInGroup() then return end
	if channel == "RAID" and not IsInRaid() then return end
	SendAddonMessage(ALPrivate.ADDON_MSG_PREFIX, UpdateSendMsg..UpdatedVersionRev, channel, target)
end

function AtlasLoot.IsAddonUpdateAviable()
	return IsAddonUpdateAviable
end