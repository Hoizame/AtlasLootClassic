local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Favourites = Addons:RegisterNewAddon("Favourites")

-- lua
local next = _G.next

-- WoW
local GetItemInfo = _G.GetItemInfo

-- locals
local BASE_NAME_P, BASE_NAME_G = "ProfileBase", "GlobalBase"
local STD_ATLAS, STD_ATLAS2

Favourites.BASE_NAME_P, Favourites.BASE_NAME_G = BASE_NAME_P, BASE_NAME_G


-- Addon
Favourites.DbDefaults = {
    enabled = true,
    activeList = { BASE_NAME_P, false }, -- name, isGlobal
    activeSubLists = {},
    lists = {
        [BASE_NAME_P] = {
            __name = AL["Profile base list"],
        },
        --["*"] = {
        --},
    }
}

Favourites.GlobalDbDefaults = {
    activeSubLists = {},
    lists = {
        [BASE_NAME_G] = {
            __name = AL["Global base list"],
        },
        --["*"] = {
        --},
    },
}

Favourites.AtlasList = {
    "VignetteKill", -- std
    "Gear",
    "VignetteLoot",
    "VignetteEventElite",
    "VignetteKillElite",
    "VignetteLootElite",
    "tradeskills-star",
    "tradeskills-star-off",
    "Vehicle-HammerGold",
    "Vehicle-HammerGold-1",
    "Vehicle-HammerGold-2",
    "Vehicle-HammerGold-3",
    "Taxi_Frame_Green",
    "Taxi_Frame_Yellow",
    "ShipMissionIcon-Bonus-Map",
    "services-checkmark",
    "services-number-1",
    "services-number-2",
    "services-number-3",
    "services-number-4",
    "services-number-5",
    "services-number-6",
    "services-number-7",
    "services-number-8",
    "services-number-9",
}

local function AddItemsInfoFavouritesSub(items, activeSub, isGlobal)
    if items and activeSub then
        local fav = Favourites.subItems
        for itemID in next, items do
            fav[itemID] = { activeSub, isGlobal }
        end
    end
end

local function CheckSubSetDb(list, db, globalDb)
    if list then
        for activeSub, isGlobal in next, list do
            if isGlobal and globalDb[activeSub] then
                AddItemsInfoFavouritesSub(globalDb[activeSub] or db[activeSub], activeSub, isGlobal)
            elseif not isGlobal and db[activeSub] then
                AddItemsInfoFavouritesSub(db[activeSub], activeSub, isGlobal)
            end
        end
    end
end

local function PopulateSubLists(db, globalDb)
    local subDb, globalSubDb = db.activeSubLists, globalDb.activeSubLists
    db, globalDb = db.lists, globalDb.lists

    CheckSubSetDb(subDb, db, globalDb)
    CheckSubSetDb(globalSubDb, db, globalDb)
end

local function GetActiveList(self)
    local name, isGlobal = self.db.activeList[1], ( self.db.activeList[2] == true )
    local db = isGlobal and self:GetGlobaleLists() or self:GetProfileLists()
    if db[name] then
        return db[name]
    else
        self.db.activeList[1] = db[BASE_NAME_P]
        return db[BASE_NAME_P]
    end
end

local function CleanUpShownLists(db, globalDb, activeSubLists, isGlobalList)
    local new = {}

    for listID, isGlobal in next, activeSubLists do
        if ( isGlobal and globalDb[listID] ) then
            new[listID] = isGlobal
        elseif not isGlobal and not isGlobalList and db[listID] then
            new[listID] = isGlobal
        end
    end

    return new
end

function Favourites:UpdateDb()
    self.db = self:GetDb()
    self.globalDb = self:GetGlobalDb()
    self.activeList = GetActiveList(self)

    -- populate sublists
    Favourites.subItems = {}
    PopulateSubLists(self.db, self.globalDb)
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
    STD_ATLAS, STD_ATLAS2 = Favourites.AtlasList[1], Favourites.AtlasList[2]
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

function Favourites:IsFavouriteItemID(itemID, onlyActiveList)
    if onlyActiveList then
        return self.activeList[itemID]
    else
        return self.activeList[itemID] or self.subItems[itemID]
    end
end

function Favourites:SetFavouriteAtlas(itemID, texture, hideOnFail)
    local listName = self:IsFavouriteItemID(itemID)
    if not listName then return hideOnFail and texture:Hide() or nil end
    local atlas

    if listName == true then
        atlas = self.activeList.__atlas or STD_ATLAS
    elseif listName[2] == true then
        atlas = self.globalDb.lists[listName[1]].__atlas or STD_ATLAS2
    elseif listName[2] == false then
        atlas = self.db.lists[listName[1]].__atlas or STD_ATLAS2
    elseif listName[2] then
        atlas = listName[2]
    end

    if atlas and atlas ~= texture:GetAtlas() then
        texture:SetAtlas(atlas)
    end
end

function Favourites:GetProfileLists()
    return self.db.lists
end

function Favourites:GetGlobaleLists()
    return self.globalDb.lists
end

function Favourites:GetListName(id, isGlobal)
    if isGlobal and self:GetGlobaleLists()[id] then
        return self:GetGlobaleLists()[id].__name or UNKNOWN
    elseif not isGlobal and self:GetProfileLists()[id] then
        return self:GetProfileLists()[id].__name or UNKNOWN
    end
    return id
end

function Favourites:ListIsGlobalActive(listID)
    return ( self.globalDb.activeSubLists[listID] or self.globalDb.activeSubLists[listID] == false ) and true or false
end

function Favourites:ListIsProfileActive(listID)
    return ( self.db.activeSubLists[listID] or self.db.activeSubLists[listID] == false ) and true or false
end

function Favourites:CleanUpShownLists()
    local db, globalDb = self.db, self.globalDb

    local newDbActive, newGlobalActive = {}, {}

    self.db.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.db.activeSubLists)
    self.globalDb.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.globalDb.activeSubLists, true)
end

function Favourites:AddIntoShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = isGlobalList
end

function Favourites:RemoveFromShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = nil
end

Favourites:Finalize()