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

function AtlasLoot.ReturnForGameVersion(classic, bcc, wrath)
	if ALPrivate.IS_CLASSIC then
		return classic
	elseif ALPrivate.IS_BC then
		return bcc or classic
	--elseif ALPrivate.IS_WRATH then
	else
		return wrath or bcc or classic
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
-- RGBToHex
-- #############################
function AtlasLoot.RGBToHex(t)
	local r,g,b = t.r*255,t.g*255,t.b*255
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return format("%02x%02x%02x", r, g, b)
end

-- #############################
-- Faction switch
-- #############################
function AtlasLoot:GetRetByFaction(horde, alliance)
	return UnitFactionGroup("player") == "Horde" and horde or alliance
end

-- #############################
-- Tables for different game versions
-- #############################
function AtlasLoot:GetGameVersionDataTable()
    local useTable = {}
    local dataTable = setmetatable({}, {
        __newindex = function(t,k,v)
			for k,v in pairs(v) do
				useTable[k] = v
			end
        end,
    })
    return useTable, dataTable
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

-- ##############################
-- Difficultys
-- ##############################
AtlasLoot.DIFFICULTY = {
	[1] 	= {	id = 1,		short = "n", 	loc = AL["Normal"],				sourceLoc = AL["N"], 		key = "NORMAL"			},
	[2] 	= {	id = 2,		short = "h", 	loc = AL["Heroic"],				sourceLoc = AL["H"], 		key = "HEROIC"			},
	[3] 	= {	id = 3,		short = "r10", 	loc = AL["10 Raid"],			sourceLoc = "10", 			key = "10RAID"			},
	[4] 	= {	id = 4,		short = "r25", 	loc = AL["25 Raid"],			sourceLoc = "25", 			key = "25RAID"			},
	[5] 	= {	id = 5,		short = "r10h", loc = AL["10 Raid Heroic"],		sourceLoc = AL["10H"], 		key = "10RAIDH"			},
	[6] 	= {	id = 6,		short = "r25h",	loc = AL["25 Raid Heroic"],		sourceLoc = AL["25H"], 		key = "25RAIDH"			},
	[9] 	= {	id = 7,		short = "r40", 	loc = AL["40 Raid"],			sourceLoc = nil, 			key = "40RAID"			},
	[148] 	= {	id = 148,	short = "r20", 	loc = AL["20 Raid"],			sourceLoc = nil, 			key = "20RAID"			},
	[173] 	= {	id = 173,	short = "n", 	loc = AL["Normal"],				sourceLoc = AL["N"], 		key = "NORMAL2"			},
	[174] 	= {	id = 174,	short = "h", 	loc = AL["Heroic"],				sourceLoc = AL["H"], 		key = "HEROIC2"			},
	[175] 	= {	id = 175,	short = "r10", 	loc = AL["10 Raid"],			sourceLoc = "10", 			key = "10RAID2"			},
	[176] 	= {	id = 176,	short = "r25", 	loc = AL["25 Raid"],			sourceLoc = "25", 			key = "25RAID2"			},
	[193] 	= {	id = 193,	short = "r10h", loc = AL["10 Raid Heroic"],		sourceLoc = AL["10H"], 		key = "10RAIDH2"		},
	[194] 	= {	id = 194,	short = "r25h",	loc = AL["25 Raid Heroic"],		sourceLoc = AL["25H"], 		key = "25RAIDH2"		},
}

for k,v in pairs(AtlasLoot.DIFFICULTY) do
	AtlasLoot.DIFFICULTY[v.key] = v
end
