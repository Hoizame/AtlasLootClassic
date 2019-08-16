local ALName, ALPrivate = ...

local _G = _G
local AtlasLoot = _G.AtlasLoot
local TargetScan = {}
AtlasLoot.TargetScan = TargetScan
local AL = AtlasLoot.Locales

-- lua
local str_split, format = _G.string.split, _G.format
local tonumber = _G.tonumber

-- WoW
local UnitGUID = _G.UnitGUID

-- local
local TARGET_UNIT, MOUSEOVER_UNIT = "target", "mouseover"

local EventFrame = CreateFrame("FRAME")

local TargetTypes = {
    ["Creature"] = function(guid, _, serverID, instanceID, zoneUID, creatureID, spawnUID)

    end,
    --[[
    ["Pet"] = function(guid, _, serverID, instanceID, zoneUID, creatureID, spawnUID)
    end,
    ["GameObject"] = function(guid, _, serverID, instanceID, zoneUID, objectID, spawnUID)
    end,
    ["Player"] = function(guid, serverID, playerUID)
    end,
    ["Item"] = function(guid, serverID, _, spawnUID)
    end,
    ]]--
}

local function OnEvent(self, event)
    local unitGUID = UnitGUID(event == "UPDATE_MOUSEOVER_UNIT" and MOUSEOVER_UNIT or TARGET_UNIT)
    if unitGUID then
        local type, a, b, c, d, e, f = str_split("-", unitGUID)
        if type and TargetTypes[type] then
            TargetTypes[type](unitGUID, a, b, c, d, e, f)
        end
    end
end
EventFrame:SetScript("OnEvent", OnEvent)

local function Init()
    EventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
end
AtlasLoot:AddInitFunc(Init)

-- global
