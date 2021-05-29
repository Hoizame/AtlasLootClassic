-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local type, pairs, collectgarbage = type, pairs, collectgarbage
local str_find, str_format = string.find, string.format
local tbl_insert, tbl_remove = table.insert, table.remove

-- WoW
local GetNumAddOns, GetAddOnInfo, IsAddOnLoaded, GetAddOnMetadata = GetNumAddOns, GetAddOnInfo, IsAddOnLoaded, GetAddOnMetadata
local GetTime = GetTime
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AtlasLoot = _G.AtlasLoot
local Loader = {}
AtlasLoot.Loader = Loader
local AL = AtlasLoot.Locales

local IsInit = false
local AllLoaded

local LoaderQueue = {}
local LoaderQueueSaves = {}
local ModuleList = {}
local AtlasModuleList = {}
local LoadModuleSpam = {}

local AtlasMapsModuleLoaded = false

-- A list of officiel AtlasLoot modules
local ATLASLOOT_MODULE_LIST = {
	{
		addonName = "AtlasLootClassic_DungeonsAndRaids",
		--icon = "Interface\\ICONS\\Inv_ChampionsOfAzeroth",
		name = AL["Dungeons and Raids"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLootClassic_Crafting",
		--icon = "Interface\\ICONS\\Inv_ChampionsOfAzeroth",
		name = AL["Crafting"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLootClassic_Factions",
		--icon = "Interface\\ICONS\\Inv_ChampionsOfAzeroth",
		name = AL["Factions"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLootClassic_PvP",
		--icon = "Interface\\ICONS\\Inv_ChampionsOfAzeroth",
		name = AL["PvP"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLootClassic_Collections",
		--icon = "Interface\\ICONS\\Inv_ChampionsOfAzeroth",
		name = AL["Collections"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
}
local ATLASLOOT_MODULE_LIST_NAMES = {}
for i = 1, #ATLASLOOT_MODULE_LIST do
	ATLASLOOT_MODULE_LIST_NAMES[ATLASLOOT_MODULE_LIST[i].addonName] = i
end

local LoaderFrame = CreateFrame("FRAME")
LoaderFrame:RegisterEvent("ADDON_LOADED")
local function LoaderEvents(frame, event, arg1)
	if event == "ADDON_LOADED" then
		if ModuleList[arg1] then
			ModuleList[arg1].loaded = true
			collectgarbage("collect")
		end
		if LoaderQueue[arg1] then
			if type(LoaderQueue[arg1]) == "function" then
				LoaderQueue[arg1](arg1)
			elseif type(LoaderQueue[arg1]) == "table" then
				for i = 1, #LoaderQueue[arg1] do
					if type(LoaderQueue[arg1][i]) == "function" then
						LoaderQueue[arg1][i](arg1)
					end
				end
			end
			LoaderQueue[arg1] = nil
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		for k,v in pairs(LoaderQueue) do
			Loader:LoadModule(k)
		end
		LoaderFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		wipe(LoadModuleSpam)
	end
end
LoaderFrame:SetScript("OnEvent", LoaderEvents)

function Loader.Init()
	-- Check addonlist for AtlasLoot modules
	local tmp
	local playerName = UnitName("player")
	for i=1,GetNumAddOns() do
		tmp = {GetAddOnInfo(i)} --5
		if tmp[1] and str_find(tmp[1], "AtlasLootClassic_") then
			ModuleList[tmp[1]] = {
				index = i,
				enabled = GetAddOnEnableState(playerName, i) ~= 0, --tmp[4], -- 0 = Disabled on char, 1 = Enabled only on some chars (including this), 2 = enabled on all chars
				loaded = IsAddOnLoaded(i),
				loadReason = tmp[5],
				standardModule = ATLASLOOT_MODULE_LIST_NAMES[tmp[1]],

				moduleName = GetAddOnMetadata(tmp[1], "X-AtlasLootClassic-ModuleName") or tmp[1],
				lootModule = GetAddOnMetadata(tmp[1], "X-AtlasLootClassic-LootModule"),
			}
		elseif tmp[1] and str_find(tmp[1], "Atlas_") then
			AtlasModuleList[tmp[1]] = GetAddOnEnableState(playerName, i) ~= 0
		end
	end
	IsInit = true
	if AllLoaded then
		IsInit = true
		local loadCustom = AllLoaded == "loadAll" and true or false
		AllLoaded = nil
		Loader:LoadAllModules(loadCustom)
	end

	if ModuleList["AtlasLootClassic_Maps"] and ModuleList["AtlasLootClassic_Maps"].enabled then
		Loader:LoadModule("AtlasLootClassic_Maps", function() AtlasMapsModuleLoaded = true end)
	else
		AtlasMapsModuleLoaded = false
	end

	AtlasLoot.Data.AutoSelect:RefreshOptions()
end
AtlasLoot:AddInitFunc(Loader.Init)

--/dump GetAddOnEnableState(playerName, i) == 0 and false or true
--- Loads a module for AtlasLoot
-- @param	moduleName		<string> name of the module
-- @param	onLoadFunction	<function> function that is called after the module is finish loaded
-- @param	oneFunction		<string> category of the load
local warningSpam = {nil, nil}
function Loader:LoadModule(moduleName, onLoadFunction, oneFunction)
	if not moduleName or not ModuleList[moduleName] then return end
	if ( ModuleList[moduleName].loadReason and ModuleList[moduleName].loadReason ~= "DEMAND_LOADED" ) or not ModuleList[moduleName].enabled then
		local state = ModuleList[moduleName].loadReason == "DEMAND_LOADED" and "DISABLED" or ModuleList[moduleName].loadReason
		if warningSpam[1] ~= moduleName or ( warningSpam[1] == moduleName and GetTime() - warningSpam[2] > 1 ) then
			if state == "DISABLED" then -- localized "ADDON_" ("BANNED", "CORRUPT", "DEMAND_LOADED", "DISABLED", "INCOMPATIBLE", "INTERFACE_VERSION", "MISSING")
				AtlasLoot:Print(str_format(AL["Module %s is deactivated."], moduleName))
			elseif state == "MISSING" then
				AtlasLoot:Print(str_format(AL["Module %s is not installed."], moduleName))
			end
			warningSpam[1] = moduleName
			warningSpam[2] = GetTime()
		end
		return state
	end
	if self:IsModuleLoaded(moduleName) then
		if onLoadFunction then
			onLoadFunction(moduleName)
		end
		return true
	end
	LoaderQueue[moduleName] = LoaderQueue[moduleName] or {}
	if onLoadFunction and not oneFunction then
		tbl_insert(LoaderQueue[moduleName], onLoadFunction)
	elseif onLoadFunction and oneFunction and oneFunction ~= true then
		if LoaderQueueSaves[oneFunction] and LoaderQueue[ LoaderQueueSaves[oneFunction] ] then
			tbl_remove(LoaderQueue[ LoaderQueueSaves[oneFunction] ], LoaderQueue[LoaderQueueSaves[oneFunction]][oneFunction])
			LoaderQueue[LoaderQueueSaves[oneFunction]][oneFunction] = nil
			--if #LoaderQueue[LoaderQueueSaves[oneFunction]] == 0 then
			--	LoaderQueue[LoaderQueueSaves[oneFunction]] = nil
			--end
		end
		if LoaderQueue[moduleName][oneFunction] then
			LoaderQueue[moduleName][ LoaderQueue[moduleName][oneFunction] ] = onLoadFunction
		else
			LoaderQueue[moduleName][oneFunction] = #LoaderQueue[moduleName]+1
			LoaderQueue[moduleName][ LoaderQueue[moduleName][oneFunction] ] = onLoadFunction
		end
		LoaderQueueSaves[oneFunction] = moduleName
	elseif onLoadFunction and oneFunction then
		LoaderQueue[moduleName] = onLoadFunction
	end
	if InCombatLockdown() then
		-- in combat must waite with load
		if LoadModuleSpam[moduleName] and (GetTime() - LoadModuleSpam[moduleName]) > 5 then
			AtlasLoot:Print(str_format(AL["%s will finish loading after combat."], moduleName))
			LoadModuleSpam[moduleName] = GetTime()
		elseif not LoadModuleSpam[moduleName] then
			LoadModuleSpam[moduleName] = GetTime()
		end
		LoaderFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return "InCombat"
	else
		LoadAddOn(moduleName)
	end
end

function Loader:IsModuleLoaded(moduleName)
	if not moduleName or not ModuleList[moduleName] then return end
	return IsAddOnLoaded(moduleName)
end

function Loader:GetLootModuleList()
	local data = {}
	-- AtlasLoot modules
	data.module = {}
	local moduleTable
	for i = 1, #ATLASLOOT_MODULE_LIST do
		moduleTable = ATLASLOOT_MODULE_LIST[i]
		if moduleTable.addonName and ModuleList[moduleTable.addonName] and ModuleList[moduleTable.addonName].lootModule == "1" and ModuleList[moduleTable.addonName].enabled then
			local displayName
			if (AtlasLoot.db.GUI.ExpansionIcon and moduleTable.icon and moduleTable.name) then
				displayName = str_format("|T%s:0:0|t %s", moduleTable.icon, moduleTable.name)
			else
				displayName = moduleTable.name
			end
			data.module[#data.module+1] = {
				addonName = moduleTable.addonName,
				name = displayName,
				tt_title = moduleTable.tt_title or moduleTable.name,
				tt_text = moduleTable.tt_text or select(3, GetAddOnInfo(moduleTable.addonName)),
			}
		end
	end
	-- custom modules
	data.custom = {}
	for addonName, addonTable in pairs(ModuleList) do
		if not addonTable.standardModule and addonTable.enabled and addonTable.lootModule == "1" then
			data.custom[#data.custom+1] = {
				addonName = addonName,
				name = addonTable.moduleName or UNKNOWN,
			}
		end
	end
	return data
end

function Loader:LoadAllModules(loadCustom)
	if not IsInit or (AllLoaded == "loadAllNoCustom" and loadCustom) then
		AllLoaded = loadCustom and "loadAll" or "loadAllNoCustom"
		return
	elseif AllLoaded then
		return
	end
	local moduleList = Loader:GetLootModuleList()
	if not moduleList then return end
	for k,v in ipairs(moduleList.module) do
		Loader:LoadModule(v.addonName)
	end
	if loadCustom then
		for k,v in ipairs(moduleList.custom) do
			Loader:LoadModule(v.addonName)
		end
	end
end

function Loader.IsMapsModuleAviable(moduleName)
	if moduleName then
		if AtlasLoot.db.enableAtlasMapIntegration then
			return AtlasModuleList[moduleName]
		else
			return false
		end
	else
		return AtlasMapsModuleLoaded
	end
end