local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local Favourites = Addons:RegisterNewAddon("Favourites")

-- lua


-- WoW
local GetItemInfo = _G.GetItemInfo

Favourites.DbDefaults = {
    enabled = true,
    activeList = { "Base", false }, -- name, isGlobal
    lists = {
        ["Base"] = {},
        ["*"] = {},
    }
}

Favourites.GlobalDbDefaults = {
    ["Base"] = {},
    ["*"] = {},
}

function Favourites:UpdateDb()
    self.db = self:GetDb()
    if self.db and self.db.activeList[2] then
        self.activeList = self:GetGlobalDb()[self.db.activeList[1]]
    else
        self.activeList = self.db.lists[self.db.activeList[1]]
    end
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
end

function Favourites:OnProfileChanged()
    self:UpdateDb()
end

function Favourites:OnStatusChanged()
    self:UpdateDb()
end

function Favourites:AddItemID(itemID)
    if itemID and GetItemInfo(itemID) and not self.activeList[itemID] then
        self.activeList[itemID] = true
        return true
    end
    return false
end

function Favourites:RemoveItemID(itemID)
    if itemID and self.activeList[itemID] then
        self.activeList[itemID] = nil
        return true
    end
    return false
end

function Favourites:IsFavouriteItemID(itemID)
    return self.activeList[itemID]
end

function Favourites:GetProfileLists()
    return self.db.lists
end

function Favourites:GetGlobaleLists()
    return self:GetGlobalDb()
end

Favourites:Finalize()