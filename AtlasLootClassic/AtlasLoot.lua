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

	-- bindings
	BINDING_HEADER_ATLASLOOT = AL["AtlasLoot"]
	BINDING_NAME_ATLASLOOT_TOGGLE = AL["Toggle AtlasLoot"]
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
