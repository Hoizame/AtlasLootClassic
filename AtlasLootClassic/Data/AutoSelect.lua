local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local AutoSelect = {}
AtlasLoot.Data.AutoSelect = AutoSelect
local AL = AtlasLoot.Locales

-- lua

-- WoW

-- AutoSelect
local AutoSelectSave = {}

function AutoSelect:RefreshOptions()
	if AtlasLoot.db.enableAutoSelect and not AtlasLoot.Loader:IsModuleLoaded("AtlasLootClassic_DungeonsAndRaids") then
		AtlasLoot.Loader:LoadModule("AtlasLootClassic_DungeonsAndRaids")
	end
end

function AutoSelect:Add(module, instanceAlID, instanceID)
	if module and instanceAlID and instanceID then
		AutoSelectSave[instanceID] = { module, instanceAlID }
	end
end

function AutoSelect:AddInstanceTable(module, instanceAlID, iniTab)
    if not iniTab then return end
    local instanceID = iniTab.InstanceID
    if not module or not instanceAlID or not instanceID then return end

end

function AutoSelect:GetCurrrentPlayerData()
	local posY, posX, posZ, instanceID = UnitPosition("player")
	if instanceID and AutoSelectSave[instanceID] then
		if AutoSelectSave[instanceID][2][3] then
			local bossID = nil
			return AutoSelectSave[instanceID][1], AutoSelectSave[instanceID][2], bossID
		else
			return AutoSelectSave[instanceID][1], AutoSelectSave[instanceID][2]
		end
	end
end
