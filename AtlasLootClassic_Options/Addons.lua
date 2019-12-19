local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local Addons = _G.AtlasLoot.Addons
local GetAddon = Addons.GetAddon
local FavAddon = _G.AtlasLoot.Addons:GetAddon("Favourites")
local Sources = _G.AtlasLoot.Addons:GetAddon("Sources")

local AceGUI = LibStub("AceGUI-3.0")

-- lua
local pairs = _G.pairs
local format = _G.format

-- WoW
local GetServerTime = _G.GetServerTime

local count = 0

local function UpdateItemFrame(addon)
    if addon then
        Addons:UpdateStatus(addon:GetName())
    end
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
    end
end

local function ImportItemList(listName, listID, isGlobal)
	local frame = AceGUI:Create("Frame")
	frame:SetTitle(AL["Import item list"])
	frame:SetStatusText(listName)
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Flow")

    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetValue(false)
    checkBox:SetLabel(AL["Replace existing items"])
    frame:AddChild(checkBox)

    local multiEditbox = AceGUI:Create("MultiLineEditBox")
    multiEditbox:SetText("")
    multiEditbox:SetFocus(true)
	multiEditbox:SetFullWidth(true)
    multiEditbox:SetFullHeight(true)
    multiEditbox:SetCallback("OnEnterPressed", function(self, script, text)
        local addedItems = FavAddon:ImportItemList(listID, isGlobal, text, checkBox:GetValue())
        UpdateItemFrame(FavAddon)
        AtlasLoot:Print(format(AL["Added |cff00ff00%d|r items into list |cff00ff00%s|r."], addedItems or 0, listName))
        frame:Hide()
    end)
    frame:AddChild(multiEditbox)
end

local function ExportItemList(listName, listString)
	local frame = AceGUI:Create("Frame")
	frame:SetTitle(AL["Export item list"])
	frame:SetStatusText(listName)
	frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame:SetLayout("Fill")

    local multiEditbox = AceGUI:Create("MultiLineEditBox")
    multiEditbox:SetText(listString or "")
    multiEditbox:HighlightText(0)
    multiEditbox:DisableButton(true)
    multiEditbox:SetFocus(true)
	multiEditbox:SetFullWidth(true)
	multiEditbox:SetFullHeight(true)
	frame:AddChild(multiEditbox)
end

local function CreateFavouriteOptions()
    count = count + 1
    local AddonName = FavAddon:GetName()
    local t = {
        type = "group",
        name = AL["Favourites"],
        order = count,
        get = function(info) return FavAddon.db[info[#info]] end,
        set = function(info, value) FavAddon.db[info[#info]] = value Addons:UpdateStatus("Favourites") end,
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                width = "full",
                name = _G.ENABLE,
                set = function(info, value)
                    FavAddon.db[info[#info]] = value
                    UpdateItemFrame(FavAddon)
                end
            },
            showIconInTT = {
                order = 2,
                type = "toggle",
                width = "full",
                name = AL["Show favourite item icon in item tooltip"],
            },
            showListInTT = {
                order = 3,
                type = "toggle",
                width = "full",
                name = AL["Show listname in item tooltip"],
            },
            global = {
                order = 4,
                type = "toggle",
                width = "full",
                name = AL["Global lists"],
                get = function(info) return FavAddon:GetDb().activeList[2] end,
                set = function(info, value)
                    local db = FavAddon:GetDb()
                    db.activeList[1] = value and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
                    db.activeList[2] = value
                    UpdateItemFrame(FavAddon)
                end
            },
            list = {
                type = "select",
                order = 5,
                name = AL["Active list"],
                width = "double",
                values = function()
                    local db = FavAddon:GetDb()
                    local listDb
                    local list = {}
                    if db.activeList[2] == true then
                        listDb = FavAddon:GetGlobaleLists()
                    else
                        listDb = FavAddon:GetProfileLists()
                    end
                    for k,v in pairs(listDb) do
                        list[ k ] = FavAddon:GetListName(k, db.activeList[2] == true, true)
                    end
                    return list
                end,
                sorting = function()
                    local db = FavAddon:GetDb()
                    local listDb
                    local list = {}
                    if db.activeList[2] == true then
                        listDb = FavAddon:GetGlobaleLists(true)
                    else
                        listDb = FavAddon:GetProfileLists(true)
                    end
                    for k,v in ipairs(listDb) do
                        list[ k ] = v.id
                    end
                    return list
                end,
                get = function(info) return FavAddon:GetDb().activeList[1] end,
                set = function(info, value)
                    FavAddon:GetDb().activeList[1] = value
                    UpdateItemFrame(FavAddon)
                end,
            },
            addNewList = {
                order = 6,
                type = 'execute',
                name = AL["Add new list"],
                confirm = true,
                func = function()
                    local newList = FavAddon:AddNewList(FavAddon:GetDb().activeList[2])
                    if newList then
                        FavAddon:GetDb().activeList[1] = newList
                        UpdateItemFrame(FavAddon)
                    end
                end,
            },
            deleteList = {
                order = 7,
                type = 'execute',
                name = AL["Delete list"],
                confirm = true,
                disabled = function(info)
                    local db = FavAddon:GetDb().activeList
                    if db[1] == FavAddon.BASE_NAME_P or db[1] == FavAddon.BASE_NAME_G then
                        return true
                    else
                        return false
                    end
                end,
                func = function()
                    local db = FavAddon:GetDb().activeList
                    local deleted = FavAddon:RemoveList(db[1], db[2])
                    if deleted then
                        db[1] = db[2] and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
                        UpdateItemFrame(FavAddon)
                    end
                end,
            },
            headerSetting = {
                order = 10,
                type = "header",
                name = AL["Selected list settings"],
            },
            name = {
                order = 11,
                type = 'input',
                name = _G.NAME,
                width = "full",
                func = function() FavAddon:AddNewList() end,
                get = function(info) return FavAddon:GetActiveListName() end,
                set = function(info, value) FavAddon:SetActiveListName(value) UpdateItemFrame(FavAddon) end,
            },
            import = {
                order = 12,
                type = "execute",
                name = AL["Import item list"],
                func = function(info)
                    local db = FavAddon:GetDb()
                    ImportItemList(FavAddon:GetActiveListName(), db.activeList[1], db.activeList[2])
                end,
            },
            export = {
                order = 13,
                type = "execute",
                name = AL["Export item list"],
                func = function(info)
                    local db = FavAddon:GetDb()
                    ExportItemList(FavAddon:GetActiveListName(), FavAddon:ExportItemList(db.activeList[1], db.activeList[2]))
                end,
            },
            clearList = {
                order = 14,
                type = "execute",
                name = AL["Clear list"],
                desc = function() return format(AL["Remove |cffff0000%d|r items from list."], FavAddon:GetNumItemsInList()) end,
                confirm = true,
                func = function(info)
                    FavAddon:ClearList()
                    UpdateItemFrame()
                end,
            },
            useGlobal = {
                order = 15,
                type = "toggle",
                width = "full",
                name = AL["Always active for all Profiles."],
                desc = AL["Always marks items as favourite for every profile if enabled."],
                hidden = function(info) return not FavAddon:GetDb().activeList[2] end,
                get = function(info) return FavAddon:ListIsGlobalActive( FavAddon:GetDb().activeList[1] ) end,
                set = function(info, value)
                    local db = FavAddon:GetDb()
                    if value then
                        FavAddon:AddIntoShownList(db.activeList[1], db.activeList[2], true)
                    else
                        FavAddon:RemoveFromShownList(db.activeList[1], db.activeList[2], true)
                    end
                    UpdateItemFrame(FavAddon)
                end
            },
            useProfile = {
                order = 16,
                type = "toggle",
                width = "full",
                name = function() return format(AL["Always active for profile: |cff00ff00%s|r"], AtlasLoot.dbRaw:GetCurrentProfile()) end,
                desc = function() return format(AL["Always marks items as favourite for profile |cff00ff00%s|r if enabled."], AtlasLoot.dbRaw:GetCurrentProfile()) end,
                get = function(info) return FavAddon:ListIsProfileActive( FavAddon:GetDb().activeList[1] ) end,
                set = function(info, value)
                    local db = FavAddon:GetDb()
                    if value then
                        FavAddon:AddIntoShownList(db.activeList[1], db.activeList[2], false)
                    else
                        FavAddon:RemoveFromShownList(db.activeList[1], db.activeList[2], false)
                    end
                    UpdateItemFrame(FavAddon)
                end
            },
            iconSelection = {
                type = "group",
                name = AL["Icon"],
                inline = true,
                order = -1,
                get = function(info) return FavAddon.db[info[#info]] end,
                set = function(info, value)
                    FavAddon:SetIcon(nil)
                    UpdateItemFrame(FavAddon)
                end,
                get = function(info) return FavAddon.db[info[#info]] end,
                set = function(info, value)
                    FavAddon.db[info[#info]] = value
                    FavAddon:SetIcon(value)
                end,
                args = {
                    useIcon = {
                        order = 1,
                        type = "toggle",
                        width = "full",
                        name = _G.DEFAULT,
                        disabled = function(info) return not FavAddon:HasIcon() end,
                        get = function(info) return not FavAddon:HasIcon() end,
                        set = function(info, value)
                            FavAddon:SetIcon(nil)
                            UpdateItemFrame(FavAddon)
                        end
                    },
                },
            },
        },
    }

    -- icons
    local args = t.args.iconSelection.args
    local iconList = FavAddon.IconList
    local count = 1
    for i = 3, #iconList do
        local icon = iconList[i]
        count = count + 1
        args[icon] = {
            order = count,
            type = "execute",
            name = function(info)
                return FavAddon:GetIcon() == info[#info] and "^" or ""
            end,
            image = icon,
            imageWidth = 20,
            imageHeight = 20,
            width = 0.3,
            func = function(info)
                FavAddon:SetIcon(info[#info])
                UpdateItemFrame(FavAddon)
            end,
        }
    end

    return t
end

local function CreateSourceOptions()
    local AddonName = Sources:GetName()
    count = count + 1

    local t = {
        type = "group",
        name = AL["Sources"],
        order = count,
        get = function(info) return Sources.db[info[#info]] end,
        set = function(info, value) Sources.db[info[#info]] = value Addons:UpdateStatus("Sources") end,
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                width = "full",
                name = _G.ENABLE,
                desc = format(AL["This loads the |cff999999%s|r module."], "AtlasLootClassic_Data")
            },
            showDropRate = {
                order = 2,
                type = "toggle",
                width = "full",
                name = AL["Show drop rate if available."],
                desc = format(AL["This loads the |cff999999%s|r module."], "AtlasLootClassic_DungeonsAndRaids")
            },
            showProfRank = {
                order = 3,
                type = "toggle",
                width = "full",
                name = AL["Show profession rank if available."],
            },
            showRecipeSource = {
                order = 4,
                type = "toggle",
                width = "full",
                name = AL["Show recipe source if available."],
            },
            typeSelection = {
                type = "group",
                name = AL["Icon"],
                inline = true,
                order = -1,
                get = function(info) return Sources.db["Sources"][tonumber(info[#info])] end,
                set = function(info, value) Sources.db["Sources"][tonumber(info[#info])] = value Addons:UpdateStatus("Sources") end,
                args = {},
            },
        }
    }

    local data = t.args.typeSelection.args

    for num, srcName in ipairs(Sources:GetSourceTypes()) do
        data[tostring(num)] = {
            order = num,
            type = "toggle",
            --width = "full",
            name = srcName,
        }
    end

    return t
end

-- Addons
Options.orderNumber = Options.orderNumber + 1
Options.config.args.addons = {
	type = "group",
	name = _G.ADDONS,
	order = Options.orderNumber,
	args = {
        sources = CreateSourceOptions(),
        favourite = CreateFavouriteOptions(),
	},
}