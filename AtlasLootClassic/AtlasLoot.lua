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
end

function AtlasLoot:OnInitialize()
	self.dbRaw = LibStub("AceDB-3.0"):New("AtlasLootClassicDB", AtlasLoot.AtlasLootDBDefaults)
	self.db = self.dbRaw.profile
	self.dbGlobal = self.dbRaw.global

	self.dbRaw.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.dbRaw.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.dbRaw.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	self.dbGlobal.__addonrevision = AtlasLoot.__addonrevision

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

-- ##############################
-- Should be new File but for testing leave it here
-- ##############################
do
	local str_split = string.split

	local UnitGUID = UnitGUID

	local SCAN_TARGET, CHECK_TARGET = "target", "Creature"

	local EventFrame = CreateFrame("Frame")

	--EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

	local function PLAYER_TARGET_CHANGED()
		local tGuid = UnitGUID(SCAN_TARGET)
		if not tGuid then return end
		local type, _, _, _, _, npcID = str_split("-", tGuid)
		if type == CHECK_TARGET then
			--print(npcID)
		end
	end
	--EventFrame:SetScript("OnEvent", PLAYER_TARGET_CHANGED)
end

--[=[ Only instance related module will be handled
local ATLASLOOT_INSTANCE_MODULE_LIST = {
	"AtlasLoot_BattleforAzeroth",
	"AtlasLoot_Legion",
	"AtlasLoot_WarlordsofDraenor",
	"AtlasLoot_MistsofPandaria",
	"AtlasLoot_Cataclysm",
	"AtlasLoot_WrathoftheLichKing",
	"AtlasLoot_BurningCrusade",
	"AtlasLoot_Classic",
}

-- if auto-select is enabled, pre-load all instance modules to save the first-time AL frame's loading time
function AtlasLoot:PreLoadModules()
	local db = AtlasLoot.db.GUI

	local o_moduleName = db.selected[1] or "AtlasLoot_BattleforAzeroth"
	local o_dataID = db.selected[2] or 1
	local o_bossID = db.selected[3] or 1
	local o_diffID = db.selected[4] or 1
	local o_page = db.selected[5] or 0
	local moduleName, dataID

	for i = 1, #ATLASLOOT_INSTANCE_MODULE_LIST do
		local enabled = GetAddOnEnableState(UnitName("player"), ATLASLOOT_INSTANCE_MODULE_LIST[i])
		if (enabled > 0) then
			AtlasLoot.GUI.frame.moduleSelect:SetSelected(ATLASLOOT_INSTANCE_MODULE_LIST[i])
			AtlasLoot.GUI.ItemFrame:Refresh(true)
		end
	end

	db.selected[1] = o_moduleName
	db.selected[2] = o_dataID
	db.selected[3] = o_bossID
	db.selected[4] = o_diffID
	db.selected[5] = o_page
end

function AtlasLoot:AutoSelect()
	local db = AtlasLoot.db.GUI

	local wowMapID, _ = MapUtil.GetDisplayableMapForPlayer()
	local o_moduleName = db.selected[1]
	local o_dataID = db.selected[2]
	local o_bossID = db.selected[3]
	local o_diffID = db.selected[4]
	local o_page = db.selected[5]
	local moduleName, dataID
	local refresh = false

	for i = 1, #ATLASLOOT_INSTANCE_MODULE_LIST do
		local enabled = GetAddOnEnableState(UnitName("player"), ATLASLOOT_INSTANCE_MODULE_LIST[i])
		if (enabled > 0) then
			AtlasLoot.GUI.frame.moduleSelect:SetSelected(ATLASLOOT_INSTANCE_MODULE_LIST[i])
			local moduleData = AtlasLoot.ItemDB:Get(ATLASLOOT_INSTANCE_MODULE_LIST[i])
			for ka, va in pairs(moduleData) do
				if (type(va) == "table" and moduleData[ka].MapID and moduleData[ka].MapID == wowMapID) then
					moduleName = ATLASLOOT_INSTANCE_MODULE_LIST[i]
					dataID = ka
					refresh = true
					break
				end
			end
		end
		if (dataID) then break end
	end

	if (refresh and (o_moduleName ~= moduleName or o_dataID ~= dataID)) then
		AtlasLoot.GUI.frame.moduleSelect:SetSelected(moduleName)
		AtlasLoot.GUI.frame.subCatSelect:SetSelected(dataID)
		AtlasLoot.GUI.ItemFrame:Refresh(true)
	else
		AtlasLoot.GUI.frame.moduleSelect:SetSelected(o_moduleName)
		AtlasLoot.GUI.frame.subCatSelect:SetSelected(o_dataID)
		AtlasLoot.GUI.frame.boss:SetSelected(o_bossID)
		AtlasLoot.GUI.frame.difficulty:SetSelected(o_diffID)
		AtlasLoot.GUI.ItemFrame:Refresh(true)
	end
end

]=]--