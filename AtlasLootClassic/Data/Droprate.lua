local AtlasLoot = _G.AtlasLoot
local Droprate = {}
AtlasLoot.Data.Droprate = Droprate
local AL = AtlasLoot.Locales

-- lua
local type = type
local pairs = pairs

local DropRateData = {
    --[npcID] = { itemID = dropRate },
}

function Droprate:AddData(data)
    if data and type(data) == "table" then
        for k, v in pairs(data) do
            DropRateData[k] = v
        end
    end
end

function Droprate:GetData(npcID, itemID)
    if not npcID or not itemID then return end
    return DropRateData[npcID] and DropRateData[npcID][itemID] or nil
end