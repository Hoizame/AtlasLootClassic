local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Favourites = Addons:RegisterNewAddon("Favourites")
local Tooltip = AtlasLoot.Tooltip

-- lua
local type = _G.type
local next, pairs, tblconcat, tblsort = _G.next, _G.pairs, _G.table.concat, _G.table.sort
local format, strsub, strmatch, strgmatch, strsplit = _G.format, _G.strsub, _G.strmatch, _G.gmatch, _G.strsplit

-- WoW
local GetItemInfo = _G.GetItemInfo
local GetServerTime = _G.GetServerTime
local GetItemInfoInstant = _G.GetItemInfoInstant
local RETRIEVING_ITEM_INFO = _G["RETRIEVING_ITEM_INFO"]
local ItemExist = _G.C_Item.DoesItemExistByID

-- locals
local ICONS_PATH = ALPrivate.ICONS_PATH
local BASE_NAME_P, BASE_NAME_G, LIST_BASE_NAME = "ProfileBase", "GlobalBase", "List"
local NEW_LIST_ID_PATTERN = "%s%s"
local TEXT_WITH_TEXTURE = "|T%s:0|t %s"
local ATLAS_ICON_IDENTIFIER = "#"
local IMPORT_EXPORT_DELIMITER, IMPORT_PATTERN, EXPORT_PATTERN = ",", "(%w+):(%d+)", "%s:%d"
local STD_ICON, STD_ICON2
local KEY_WEAK_MT = {__mode="k"}

local TooltipsHooked = false
local TooltipCache, TooltipTextCache = {}
local ListNameCache
setmetatable(TooltipCache, KEY_WEAK_MT)

Favourites.BASE_NAME_P, Favourites.BASE_NAME_G = BASE_NAME_P, BASE_NAME_G


-- Addon
Favourites.DbDefaults = {
    enabled = true,
    showIconInTT = false,
    showListInTT = true,
    activeList = { BASE_NAME_P, false }, -- name, isGlobal
    activeSubLists = {},
    lists = {
        [BASE_NAME_P] = {
            __name = AL["Profile base list"],
        },
    },
    GUI = {
        bgColor = {r = 0.45, g = 0.45, b = 0.45, a = 1},
        scale = 1,
        title = {
            bgColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
            textColor = {r = 1, g = 1, b = 1, a = 1},
            size = 12,
            font = "Friz Quadrata TT",
        },
        content = {
            bgColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
        },
    },
}

Favourites.GlobalDbDefaults = {
    activeSubLists = {},
    lists = {
        [BASE_NAME_G] = {
            __name = AL["Global base list"],
        },
    },
}

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
STD_ICON, STD_ICON2 = Favourites.IconList[1], Favourites.IconList[2]

local function AddItemsInfoFavouritesSub(items, activeSub, isGlobal)
    if items and activeSub then
        local fav = Favourites.subItems
        for itemID in pairs(items) do
            if fav[itemID] then
                fav[itemID][#fav[itemID] + 1] = { activeSub, isGlobal }
            else
                fav[itemID] = {
                    { activeSub, isGlobal }
                }
            end
        end
    end
end

local function CheckSubSetDb(list, db, globalDb)
    if list then
        for activeSub, isGlobal in pairs(list) do
            if activeSub ~= Favourites.db.activeList[1] then
                if isGlobal and globalDb[activeSub] then
                    AddItemsInfoFavouritesSub(globalDb[activeSub] or db[activeSub], activeSub, isGlobal)
                elseif not isGlobal and db[activeSub] then
                    AddItemsInfoFavouritesSub(db[activeSub], activeSub, isGlobal)
                end
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

local function PopulateListNames(db, dest)
    for k,v in pairs(db) do
        dest[k] = format(TEXT_WITH_TEXTURE, tostring(v.__icon or STD_ICON), v.__name or LIST_BASE_NAME)
    end
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

local function ClearActiveList(self)
    local name, isGlobal = self.db.activeList[1], ( self.db.activeList[2] == true )
    local db = isGlobal and self:GetGlobaleLists() or self:GetProfileLists()
    local new = {}

    for k,v in pairs(self.activeList) do
        if type(k) ~= "number" and k ~= "mainItems" then
            new[k] = v
        end
    end

    if db[name] then
        db[name] = new
    else
        db[BASE_NAME_P] = new
    end
end

local function CleanUpShownLists(db, globalDb, activeSubLists, isGlobalList)
    local new = {}
    db, globalDb = db.lists, globalDb.lists

    for listID, isGlobal in pairs(activeSubLists) do
        if ( isGlobal and globalDb[listID] ) then
            new[listID] = isGlobal
        elseif not isGlobal and not isGlobalList and db[listID] then
            new[listID] = isGlobal
        end
    end

    return new
end

local function OnTooltipSetItem_Hook(self)
    if self:IsForbidden() or not Favourites.db.enabled or (not Favourites.db.showIconInTT and not Favourites.db.showListInTT) then return end
    local _, item = self:GetItem()
    if not item then return end
    if not TooltipCache[item] then
        TooltipCache[item] = tonumber(strmatch(item, "item:(%d+)"))
    end

    item = TooltipCache[item]
    if Favourites:IsFavouriteItemID(item) then
        if Favourites.db.showIconInTT then
            local text = _G[self:GetName().."TextLeft1"]
            if not TooltipTextCache[item] and text:GetText() ~= RETRIEVING_ITEM_INFO then
                TooltipTextCache[item] = format(TEXT_WITH_TEXTURE, Favourites:GetIconForActiveItemID(item), text:GetText())
            end
            text:SetText( TooltipTextCache[item] or RETRIEVING_ITEM_INFO )
        end

        -- Add Listnames
        if Favourites.db.showListInTT then
            self:AddLine(" ")
            if Favourites.activeList[item] then
                self:AddLine(ListNameCache.active)
            end
            if Favourites.subItems[item] then
                for i = 1, #Favourites.subItems[item] do
                    local entry = Favourites.subItems[item][i]
                    if entry[1] ~= Favourites.activeListID then
                        self:AddLine(ListNameCache[entry[2] and "global" or "profile"][entry[1]])
                    end
                end
            end
        end
    end
end

local function InitTooltips()
    if TooltipsHooked then return end
    Tooltip:AddHookFunction("OnTooltipSetItem", OnTooltipSetItem_Hook)
    TooltipsHooked = true
end

local function SlashCommand()
    Favourites.GUI:Toggle()
end
AtlasLoot.SlashCommands:Add("fav", SlashCommand, "/al fav - "..AL["Open Favourites"])

function Favourites:UpdateDb()
    self.db = self:GetDb()
    self.globalDb = self:GetGlobalDb()
    self.activeList = GetActiveList(self)
    self.activeListID = self.db.activeList[1]
    TooltipTextCache = {}
    setmetatable(TooltipTextCache, KEY_WEAK_MT)

    -- populate sublists
    self.subItems = {}
    PopulateSubLists(self.db, self.globalDb)

    -- init item count
    local numItems = 0
    for k in pairs(self.activeList) do
        if type(k) == "number" then
            numItems = numItems + 1
        end
    end
    self.numItems = numItems

    -- name / icon mix
    ListNameCache = {
        active = format(TEXT_WITH_TEXTURE, tostring(self.activeList.__icon or STD_ICON), self.activeList.__name or LIST_BASE_NAME),
        global = {},
        profile = {},
    }
    PopulateListNames(self.db.lists, ListNameCache.profile)
    PopulateListNames(self.globalDb.lists, ListNameCache.global)

    -- tooltip hook
    if self:TooltipHookEnabled() and not TooltipsHooked then
        InitTooltips()
    end
    self.GUI:ItemListUpdate()
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
    Favourites.GUI.OnInitialize()
end

function Favourites:OnProfileChanged()
    self:UpdateDb()
    self.GUI:OnProfileChanged()
end

function Favourites:OnStatusChanged()
    self:UpdateDb()
    self.GUI:OnStatusChanged()
end

function Favourites:AddItemID(itemID)
    if itemID and ItemExist(itemID) and not self.activeList[itemID] then
        self.numItems = self.numItems + 1
        self.activeList[itemID] = true
        TooltipTextCache[itemID] = nil
        self.GUI:ItemListUpdate()
        return true
    end
    return false
end

function Favourites:RemoveItemID(itemID)
    if itemID and self.activeList[itemID] then
        self.numItems = self.numItems - 1
        self.activeList[itemID] = nil
        TooltipTextCache[itemID] = nil
        self:CleanUpMainItems()
        return true
    end
    return false
end

function Favourites:GetActiveList()
    return self.activeList
end

function Favourites:ClearList()
    if self.db and self.activeList then
        ClearActiveList(self)
        self:UpdateDb()
        return true
    end
    return false
end

function Favourites:GetNumItemsInList()
    return self.numItems or 0
end

function Favourites:IsFavouriteItemID(itemID, onlyActiveList)
    if onlyActiveList then
        return self.activeList[itemID]
    else
        return self.activeList[itemID] or self.subItems[itemID]
    end
end

function Favourites:SetFavouriteIcon(itemID, texture, hideOnFail)
    if not texture then return end
    local listName = self:IsFavouriteItemID(itemID)
    if not listName then return hideOnFail and texture:Hide() or nil end
    local icon = Favourites:GetIconForActiveItemID(itemID)

    if icon then
        if type(icon) == "number" then
            texture:SetTexture(icon)
        elseif type(icon) == "string" then
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
    elseif #listName > 1 then
        icon = STD_ICON
    elseif listName[1][2] == true then
        icon = self.globalDb.lists[ listName[1][1] ].__icon or STD_ICON2
    elseif listName[1][2] == false then
        icon = self.db.lists[ listName[1][1] ].__icon or STD_ICON2
    elseif listName[1][2] then
        icon = listName[1][2]
    end

    return icon
end

local function SortedListFunc(a,b)
    return a.name:lower() < b.name:lower()
end

local function GetSortedList(list, isGlobal)
    local new = {}
    for k,v in pairs(list) do
        new[#new+1] = {
            id = k,
            name = Favourites:GetListName(k, isGlobal, false),
            nameIcon = Favourites:GetListName(k, isGlobal, true),
        }
    end
    tblsort(new, SortedListFunc)
    return new
end

function Favourites:GetProfileLists(sorted)
    if sorted then
        return GetSortedList(self.db.lists, false)
    else
        return self.db.lists
    end
end

function Favourites:GetGlobaleLists(sorted)
    if sorted then
        return GetSortedList(self.globalDb.lists, true)
    else
        return self.globalDb.lists
    end
end

function Favourites:GetListByID(listID, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    return list[listID]
end

function Favourites:GetListName(id, isGlobal, withIcon)
    --ListNameCache[isGlobal and "global" or "profile"]
    if withIcon then
        return ListNameCache[isGlobal and "global" or "profile"][id]
    else
        if isGlobal and self:GetGlobaleLists()[id] then
            return self:GetGlobaleLists()[id].__name or LIST_BASE_NAME
        elseif not isGlobal and self:GetProfileLists()[id] then
            return self:GetProfileLists()[id].__name or LIST_BASE_NAME
        end
        return id
    end
end

function Favourites:ListIsGlobalActive(listID)
    return ( self.globalDb.activeSubLists[listID] or self.globalDb.activeSubLists[listID] == false ) and true or false
end

function Favourites:ListIsProfileActive(listID)
    return ( self.db.activeSubLists[listID] or self.db.activeSubLists[listID] == false ) and true or false
end

function Favourites:CleanUpShownLists()
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
                if eType == "i" and not list[entry] and ItemExist(entry) then
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

function Favourites:TooltipHookEnabled()
    return self.db.enabled and ( self.db.showIconInTT or self.db.showListInTT ) or false
end

-- gui
function Favourites:SetAsMainItem(slotID, itemID)
    if not self.activeList then return end
    if not self.activeList.mainItems then self.activeList.mainItems = {} end
    self.activeList.mainItems[slotID] = itemID
end

function Favourites:SetMainItemEmpty(slotID)
    self:SetAsMainItem(slotID, true)
end

function Favourites:CleanUpMainItems()
    if self.activeList and self.activeList.mainItems then
        local newList = {}
        local count = 0
        for k,v in pairs(self.activeList.mainItems) do
            if v == true or self.activeList[v] then
                newList[k] = v
                count = count + 1
            end
        end
        if count > 0 then
            self.activeList.mainItems = newList
        else
            self.activeList.mainItems = nil
        end
    end
    self.GUI:ItemListUpdate()
end

function Favourites:GetMainListItems()
    return self.activeList and self.activeList.mainItems or nil
end

Favourites:Finalize()