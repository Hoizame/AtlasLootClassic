--[[ ############################

- function overrites
    MyAddon:OnInitialize()
    MyAddon:OnProfileChanged()

- table overrites
    MyAddon.DbDefaults = {}     -- calls Addons:SetDbDefaults

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

local AddonMT = {
    __index = AddonProto,
    __newindex = function(table, key, value)
        rawset(table, key, value)
        if key == "OnInitialize" and type(value) == "function" then
            AtlasLoot:AddInitFunc(value)
        elseif key == "DbDefaults" and type(value) == "table" then
            Addons:SetDbDefaults(table.__name, value)
        end
    end
}

function Addons:RegisterNewAddon(name)
    local addonTable = {
        __name = name,
    }
    setmetatable(addonTable, AddonMT)
    AddonList[name] = addonTable

    return addonTable
end

function Addons:GetAddon(name)
    assert(name and AddonList[name], "Addon '"..(name or "nil").."' not found.")
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
    assert(addonName and dbDefaults and type(dbDefaults), "Invalid value/s.")
    AtlasLoot.AtlasLootDBDefaults.profile.Addons[addonName] = dbDefaults
end

-- ##########################
-- AddonProto
-- ##########################

