local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Favourites = Addons:RegisterNewAddon("Favourites")

-- lua
local type = _G.type
local next, pairs, tblconcat = _G.next, _G.pairs, _G.table.concat
local format, strsub, strmatch, strgmatch, strsplit = _G.format, _G.strsub, _G.strmatch, _G.gmatch, _G.strsplit

-- WoW
local GetItemInfo = _G.GetItemInfo
local GetServerTime = _G.GetServerTime
local GetItemInfoInstant = _G.GetItemInfoInstant
local RETRIEVING_ITEM_INFO = _G["RETRIEVING_ITEM_INFO"]

-- locals
local ICONS_PATH = ALPrivate.ICONS_PATH
local BASE_NAME_P, BASE_NAME_G, LIST_BASE_NAME = "ProfileBase", "GlobalBase", "List"
local NEW_LIST_ID_PATTERN = "%s%s"
local ATLAS_ICON_IDENTIFIER = "#"
local IMPORT_EXPORT_DELIMITER, IMPORT_PATTERN, EXPORT_PATTERN = ",", "(%w+):(%d+)", "%s:%d"
local STD_ICON, STD_ICON2
local KEY_WEAK_MT = {__mode="k"}

local TooltipsHooked = false
local TooltipCache, TooltipTextCache = {}
setmetatable(TooltipCache, KEY_WEAK_MT)

Favourites.BASE_NAME_P, Favourites.BASE_NAME_G = BASE_NAME_P, BASE_NAME_G


-- Addon
Favourites.DbDefaults = {
    enabled = true,
    showInTT = false,
    activeList = { BASE_NAME_P, false }, -- name, isGlobal
    activeSubLists = {},
    lists = {
        [BASE_NAME_P] = {
            __name = AL["Profile base list"],
        },
    }
}

Favourites.GlobalDbDefaults = {
    activeSubLists = {},
    lists = {
        [BASE_NAME_G] = {
            __name = AL["Global base list"],
        },
    },
}

Favourites.HookTooltipList = {
    "AtlasLootTooltip",
    "GameTooltip",
    "ItemRefTooltip",
    "ShoppingTooltip1",
    "ShoppingTooltip2",
    "ShoppingTooltip3"
}
local AlreadyHookedTT = {}

Favourites.PlaceHolderIcon = ICONS_PATH.."placeholder-icon"
Favourites.IconList = {
    ICONS_PATH.."VignetteKill",
    ICONS_PATH.."Gear",
    ICONS_PATH.."groupfinder-icon-class-druid",
    ICONS_PATH.."groupfinder-icon-class-hunter",
    ICONS_PATH.."groupfinder-icon-class-mage",
    ICONS_PATH.."groupfinder-icon-class-paladin",
    ICONS_PATH.."groupfinder-icon-class-priest",
    ICONS_PATH.."groupfinder-icon-class-rogue",
    ICONS_PATH.."groupfinder-icon-class-shaman",
    ICONS_PATH.."groupfinder-icon-class-warlock",
    ICONS_PATH.."groupfinder-icon-class-warrior",
    ICONS_PATH.."groupfinder-icon-role-large-dps",
    ICONS_PATH.."groupfinder-icon-role-large-heal",
    ICONS_PATH.."groupfinder-icon-role-large-tank",
    ICONS_PATH.."Vehicle-HammerGold",
    ICONS_PATH.."Vehicle-HammerGold-1",
    ICONS_PATH.."Vehicle-HammerGold-2",
    ICONS_PATH.."Vehicle-HammerGold-3",
    ICONS_PATH.."Vehicle-TempleofKotmogu-CyanBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-GreenBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-OrangeBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-PurpleBall",
    ICONS_PATH.."worldquest-tracker-questmarker",
}

local function AddItemsInfoFavouritesSub(items, activeSub, isGlobal)
    if items and activeSub then
        local fav = Favourites.subItems
        for itemID in pairs(items) do
            fav[itemID] = { activeSub, isGlobal }
        end
    end
end

local function CheckSubSetDb(list, db, globalDb)
    if list then
        for activeSub, isGlobal in pairs(list) do
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

local function OnTooltipSetItem_Hook(self)
    if not Favourites.db.enabled or not Favourites.db.showInTT then return end
    local _, item = self:GetItem()
    if not item then return end
    if not TooltipCache[item] then
        TooltipCache[item] = tonumber(strmatch(item, "item:(%d+)"))
    end

    item = TooltipCache[item]
    if Favourites:IsFavouriteItemID(item) then
        if not TooltipTextCache[item] and _G[self:GetName().."TextLeft1"]:GetText() ~= RETRIEVING_ITEM_INFO then
            TooltipTextCache[item] = format("|T%s:0|t%s", Favourites:GetIconForActiveItemID(item), _G[self:GetName().."TextLeft1"]:GetText())
        end
        _G[self:GetName().."TextLeft1"]:SetText( TooltipTextCache[item] or RETRIEVING_ITEM_INFO )
    end
end

local function InitTooltips()
    if TooltipsHooked then return end
    for i = 1, #Favourites.HookTooltipList do
        local tooltip = _G[Favourites.HookTooltipList[i]]
        Favourites:AddTooltipHook(tooltip)
    end
    TooltipsHooked = true
end

function Favourites:AddTooltipHook(tooltip)
    if tooltip and tooltip.HookScript and not AlreadyHookedTT[tooltip] then
        tooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem_Hook)
        AlreadyHookedTT[tooltip] = true
    end
end

function Favourites:UpdateDb()
    self.db = self:GetDb()
    self.globalDb = self:GetGlobalDb()
    self.activeList = GetActiveList(self)
    TooltipTextCache = {}
    setmetatable(TooltipTextCache, KEY_WEAK_MT)

    -- populate sublists
    Favourites.subItems = {}
    PopulateSubLists(self.db, self.globalDb)

    -- tooltip hook
    if self.db.enabled and self.db.showInTT and not TooltipsHooked then
        InitTooltips()
    end
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
    STD_ICON, STD_ICON2 = Favourites.IconList[1], Favourites.IconList[2]
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

function Favourites:SetFavouriteIcon(itemID, texture, hideOnFail)
    local listName = self:IsFavouriteItemID(itemID)
    if not listName then return hideOnFail and texture:Hide() or nil end
    local icon

    if listName == true then
        icon = self.activeList.__icon or STD_ICON
    elseif listName[2] == true then
        icon = self.globalDb.lists[listName[1]].IconList or STD_ICON2
    elseif listName[2] == false then
        icon = self.db.lists[listName[1]].__icon or STD_ICON2
    elseif listName[2] then
        icon = listName[2]
    end

    if icon then
        local iconType = type(icon)
        if iconType == "number" then
            texture:SetTexture(icon)
        elseif iconType == "string" then
            if strsub(icon, 1, 1) == ATLAS_ICON_IDENTIFIER then
                if icon and icon ~= texture:GetAtlas() then
                    texture:SetAtlas(strsub(icon, 2))
                end
            else
                texture:SetTexture(icon)
            end
        end
    end
end

function Favourites:GetIconForActiveItemID(itemID)
    local listName = self:IsFavouriteItemID(itemID)
    local icon
    if listName == true then
        icon = self.activeList.__icon or STD_ICON
    elseif listName[2] == true then
        icon = self.globalDb.lists[listName[1]].IconList or STD_ICON2
    elseif listName[2] == false then
        icon = self.db.lists[listName[1]].__icon or STD_ICON2
    elseif listName[2] then
        icon = listName[2]
    end
    return icon
end

function Favourites:GetProfileLists()
    return self.db.lists
end

function Favourites:GetGlobaleLists()
    return self.globalDb.lists
end

function Favourites:GetListByID(listID, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    return list[listID]
end

function Favourites:GetListName(id, isGlobal)
    if isGlobal and self:GetGlobaleLists()[id] then
        return self:GetGlobaleLists()[id].__name or LIST_BASE_NAME
    elseif not isGlobal and self:GetProfileLists()[id] then
        return self:GetProfileLists()[id].__name or LIST_BASE_NAME
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

function Favourites:SetIcon(icon)
    self.activeList.__icon = ( icon ~= STD_ICON and icon ~= STD_ICON2 ) and icon or nil
end

function Favourites:GetIcon()
    return self.activeList.__icon
end

function Favourites:HasIcon()
    return self.activeList.__icon and true or false
end

function Favourites:GetActiveListName()
    return self.activeList.__name or LIST_BASE_NAME
end

function Favourites:SetActiveListName(name)
    self.activeList.__name = name
end

function Favourites:AddNewList(isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local id = format(NEW_LIST_ID_PATTERN, isGlobalList and "g" or "p", GetServerTime())

    if not list[id] then    -- should work as spam protect as GetServerTime returns sec
        list[id] = {}
        return id
    end
    return false
end

function Favourites:RemoveList(listID, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if list[listID] then
        list[listID] = nil
        self:CleanUpShownLists()
        return true
    end
    return false
end
-- AtlasLoot.Addons.GetAddon(Addons, "Favourites"):ExportItemList("ProfileBase", false)
function Favourites:RemoveEntrysFromList(listID, isGlobalList)
    local list = self:GetListByID(listID, isGlobalList)
    if not list then return end
    local newList = {}
    for key, entry in pairs(list) do
        if strsub(key, 1, 2) == "__" then
            newList[key] = entry
        end
    end
    list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    list[listID] = newList
    return newList
end

function Favourites:ExportItemList(listID, isGlobalList)
    local list = self:GetListByID(listID, isGlobalList)
    if not list then return end
    local ret = {}
    for entry in pairs(list) do
        if strsub(entry, 1, 2) ~= "__" then
            ret[#ret + 1] = format(EXPORT_PATTERN, "i", entry)
        end
    end
    return tblconcat(ret, IMPORT_EXPORT_DELIMITER)
end

function Favourites:ImportItemList(listID, isGlobalList, newList, replace)
    local list = replace and self:RemoveEntrysFromList(listID, isGlobalList) or self:GetListByID(listID, isGlobalList)
    if not list then return end
    local numNewEntrys = 0
    if type(newList) == "string" then
        local stList = { strsplit(IMPORT_EXPORT_DELIMITER, newList) }
        for i = 1, #stList do
            local eType, entry = strmatch(stList[i], IMPORT_PATTERN)
            if entry then
                entry = tonumber(entry)
                if eType == "i" and not list[entry] and GetItemInfoInstant(entry) then
                    list[entry] = true
                    numNewEntrys = numNewEntrys + 1
                end
            end
        end
    elseif type(newList) == "table" then
        for i = 1, #newList do
            if not list[newList[i]] then
                list[newList[i]] = true
                numNewEntrys = numNewEntrys + 1
            end
        end
    end
    return numNewEntrys
end

Favourites:Finalize()