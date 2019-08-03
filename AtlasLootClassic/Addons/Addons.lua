--[[ ############################

- function overrites
    MyAddon.OnInitialize()
    MyAddon:OnProfileChanged()
    MyAddon:OnStatusChanged()   added / disabled / enabled

- table overrites
    MyAddon.DbDefaults = { enabled = true }     -- calls Addons:SetDbDefaults
    MyAddon.GlobalDbDefaults = { enabled = true }     -- calls Addons:SetGlobalDbDefaults

- Protos
    MyAddon:IsEnabled()
    MyAddon:UpdateCallbacks()
    MyAddon:GetDb()

- End
    MyAddon:Finalize()

-- ############################ ]]--

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = {}
AtlasLoot.Addons = Addons
local AddonList = {}
local AddonProto = {}

-- lua
local setmetatable, rawset = _G.setmetatable, _G.rawset
local assert = _G.assert
local type = _G.type
local pairs = _G.pairs

local CallbackList = {}

local AddonMT = {
    __index = AddonProto,
    __newindex = function(table, key, value)
        rawset(table, key, value)
        if key == "OnInitialize" and type(value) == "function" then
            AtlasLoot:AddInitFunc(value)
        elseif key == "DbDefaults" and type(value) == "table" then
            Addons:SetDbDefaults(table.__name, value)
        elseif key == "GlobalDbDefaults" and type(value) == "table" then
            Addons:SetGlobalDbDefaults(table.__name, value)
        end
    end
}

local function UpdateCallbacks(name)
    if AddonList[name] and CallbackList[name] then
        for c in pairs(CallbackList[name]) do
            c(AddonList[name], AddonList[name]:IsEnabled())
        end
    end
end

function Addons:RegisterNewAddon(name)
    CallbackList[name] = CallbackList[name] or {}
    local addonTable = {
        __name = name,
        __callbacks = CallbackList[name]
    }
    setmetatable(addonTable, AddonMT)
    AddonList[name] = addonTable

    return addonTable
end

-- callback(Addon, enabled) gets called if the addon is added / disabled / enabled
function Addons:GetAddon(name, callback)
    if callback then
        CallbackList[name] = CallbackList[name] or {}
        CallbackList[name][callback] = true
        if AddonList[name] then
            callback(AddonList[name], AddonList[name]:IsEnabled())
        end
    end
    return AddonList[name]
end

function Addons:OnProfileChanged()
    for addonName, addonTable in pairs(AddonList) do
        if addonTable.OnProfileChanged and type(addonTable.OnProfileChanged) == "function" then
            addonTable:OnProfileChanged()
        end
    end
end

function Addons:SetDbDefaults(addonName, dbDefaults)
    assert(addonName and dbDefaults and type(dbDefaults) == "table", "Invalid args.")
    AtlasLoot.AtlasLootDBDefaults.profile.Addons[addonName] = dbDefaults
end

function Addons:SetGlobalDbDefaults(addonName, dbDefaults)
    assert(addonName and dbDefaults and type(dbDefaults) == "table", "Invalid args.")
    AtlasLoot.AtlasLootDBDefaults.global.Addons[addonName] = dbDefaults
end

function Addons:UpdateStatus(addonName)
    assert(addonName and AddonList[addonName], "Invalid args.")
    if AddonList[addonName].OnStatusChanged then
        AddonList[addonName].OnStatusChanged(AddonList[addonName])
    end
    AddonList[addonName]:UpdateCallbacks()
end

-- ##########################
-- AddonProto
-- ##########################

function AddonProto:Finalize()
    UpdateCallbacks(self.__name)
end

function AddonProto:IsEnabled()
    local db = self:GetDb()
    if db and db.enabled ~= nil then
        return db.enabled
    else
        return true
    end
end

function AddonProto:UpdateCallbacks()
    UpdateCallbacks(self.__name)
end

function AddonProto:GetDb()
    return AtlasLoot.db.Addons[self.__name]
end

function AddonProto:GetGlobalDb()
    return AtlasLoot.dbGlobal.Addons[self.__name]
end

function AddonProto:GetName()
    return self.__name
end