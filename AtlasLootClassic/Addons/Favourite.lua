local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local Favourite = Addons:RegisterNewAddon("Favourite")

-- lua


-- WoW
local GetItemInfo = _G.GetItemInfo

Favourite.DbDefaults = {
    enabled = true,
    activeList = "Base",
    lists = {
        ["*"] = {},
    }
}

function Favourite:UpdateDb()
    self.db = self:GetDb()
    self.activeList = self.db.lists[self.db.activeList]
end

function Favourite.OnInitialize()
    Favourite:UpdateDb()
end

function Favourite:OnProfileChanged()
    self:UpdateDb()
end

function Favourite:AddItemID(itemID)
    if itemID and GetItemInfo(itemID) and not self.activeList[itemID] then
        self.activeList[itemID] = true
        return true
    end
    return false
end

function Favourite:RemoveItemID(itemID)
    if itemID and self.activeList[itemID] then
        self.activeList[itemID] = nil
        return true
    end
    return false
end

function Favourite:IsFavouriteItemID(itemID)
    return self.activeList[itemID]
end

Favourite:Finalize()