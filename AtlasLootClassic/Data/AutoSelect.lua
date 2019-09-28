local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local AutoSelect = {}
AtlasLoot.Data.AutoSelect = AutoSelect
local AL = AtlasLoot.Locales

-- lua
local unpack = unpack

-- WoW
local UnitPosition = UnitPosition
local GetSubZoneText = GetSubZoneText

local SUB_L = {}
-- Locales data
--##START-DATA##
--##END-DATA##

-- AutoSelect
local AutoSelectSave = {}
local LastBase

function AutoSelect:RefreshOptions()
	if AtlasLoot.db.enableAutoSelect and not AtlasLoot.Loader:IsModuleLoaded("AtlasLootClassic_DungeonsAndRaids") then
		AtlasLoot.Loader:LoadModule("AtlasLootClassic_DungeonsAndRaids")
	end
end

function AutoSelect:AddInstanceTable(module, instanceAlID, iniTab)
    if not iniTab then return end
    local instanceID = iniTab.InstanceID
    if not module or not instanceAlID or not instanceID then return end
    if not AutoSelectSave[instanceID] then
        AutoSelectSave[instanceID] = {
            base = { module, instanceAlID }
        }
    end
    local content = AutoSelectSave[instanceID]

    if iniTab.SubAreaIDs then
        if not content.sub then
            content.sub = {}
            content.subList = {}
        end

        for i = 1, #iniTab.SubAreaIDs do
            content.sub[iniTab.SubAreaIDs[i]] = { module, instanceAlID }
            content.subList[#content.subList + 1] = iniTab.SubAreaIDs[i]
        end
        -- SubAreaIDs / SubAreaID
        for i = 1, #iniTab.items do
            local id = iniTab.items[i].SubAreaID
            if id and content.sub[id] and not content.sub[id][3] then
                content.sub[id][3] = id
            end
        end

    end
end

function AutoSelect:GetCurrrentPlayerData()
    local posY, posX, posZ, instanceID = UnitPosition("player")
    local ini = instanceID and AutoSelectSave[instanceID] or nil
    if ini then
        if ini.sub then
            local subZoneName = GetSubZoneText()
            for i = 1, #ini.subList do
                local locName = SUB_L[ini.subList[i]]
                if locName and locName == subZoneName then
                    return ini.base[1], ini.base[2], ini.sub[ini.subList[i]]
                end
            end
        end
        return unpack(ini.base)
	end
end
