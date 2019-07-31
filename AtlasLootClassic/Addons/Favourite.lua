local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local Favourite = Addons:RegisterNewAddon("Favourite")

-- lua


-- WoW
local GetItemInfo = _G.GetItemInfo

Favourite.DbDefaults = {
    enabled = true,
    activeList = { "Base", false }, -- name, isGlobal
    lists = {
        ["Base"] = {},
        ["*"] = {},
    }
}

Favourite.GlobalDbDefaults = {
    ["Base"] = {},
    ["*"] = {},
}

function Favourite:UpdateDb()
    self.db = self:GetDb()
    if self.db and self.db.activeList[2] then
        self.activeList = self:GetGlobalDb()[self.db.activeList[1]]
    else
        self.activeList = self.db.lists[self.db.activeList[1]]
    end
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

function Favourite:GetProfileLists()
    return 
end

function Favourite:GetGlobaleLists()

end

Favourite:Finalize()