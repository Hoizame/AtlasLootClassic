local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local Addons = _G.AtlasLoot.Addons
local GetAddon = Addons.GetAddon

-- lua
local pairs = _G.pairs
local format = _G.format

-- WoW
local GetServerTime = _G.GetServerTime

local count = 0

local function UpdateItemFrame(adoon, addonName)
    adoon:UpdateStatus(addonName)
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
    end
end

local function CreateFavouriteOptions()
    count = count + 1
    local AddonName = "Favourites"
    local FavAddon = GetAddon(Addons, "Favourites")
    local t = {
        type = "group",
        name = AL["Favourites"],
        order = count,
        get = function(info) return FavAddon.db[info[#info]] end,
        set = function(info, value) FavAddon.db[info[#info]] = value end,
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                width = "full",
                name = _G.ENABLE,
                set = function(info, value)
                    FavAddon.db[info[#info]] = value
                    UpdateItemFrame(Addons, AddonName)
                end
            },
            global = {
                order = 2,
                type = "toggle",
                width = "full",
                name = AL["Global lists."],
                get = function(info) return FavAddon:GetDb().activeList[2] end,
                set = function(info, value)
                    local db = FavAddon:GetDb()
                    db.activeList[1] = value and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
                    db.activeList[2] = value
                    UpdateItemFrame(Addons, AddonName)
                end
            },
            list = {
                type = "select",
                order = 3,
                name = AL["Active list"],
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
                        list[ k ] = FavAddon:GetListName(k, db.activeList[2] == true)
                    end
                    return list
                end,
                get = function(info) return FavAddon:GetDb().activeList[1] end,
                set = function(info, value)
                    FavAddon:GetDb().activeList[1] = value
                    UpdateItemFrame(Addons, AddonName)
                end,
            },
            addNewList = {
                order = 4,
                type = 'execute',
                name = AL["Add new list"],
                confirm = true,
                func = function()
                    local newList = FavAddon:AddNewList(FavAddon:GetDb().activeList[2])
                    if newList then
                        FavAddon:GetDb().activeList[1] = newList
                        UpdateItemFrame(Addons, AddonName)
                    end
                end,
            },
            deleteList = {
                order = 5,
                type = 'execute',
                name = _G.DELETE,
                confirm = true,
                func = function()
                    local db = FavAddon:GetDb().activeList
                    local deleted = FavAddon:RemoveList(db[1], db[2])
                    if deleted then
                        db[1] = db[2] and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
                        UpdateItemFrame(Addons, AddonName)
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
                func = function() FavAddon:AddNewList() end,
                get = function(info) return FavAddon:GetName() end,
                set = function(info, value) FavAddon:SetName(value) end,
            },
            useGlobal = {
                order = 12,
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
                    UpdateItemFrame(Addons, AddonName)
                end
            },
            useProfile = {
                order = 13,
                type = "toggle",
                width = "full",
                name = format(AL["Always active for profile: |cff00ff00%s|r"], AtlasLoot.dbRaw:GetCurrentProfile()),
                desc = format(AL["Always marks items as favourite for profile |cff00ff00%s|r if enabled."], AtlasLoot.dbRaw:GetCurrentProfile()),
                get = function(info) return FavAddon:ListIsProfileActive( FavAddon:GetDb().activeList[1] ) end,
                set = function(info, value)
                    local db = FavAddon:GetDb()
                    if value then
                        FavAddon:AddIntoShownList(db.activeList[1], db.activeList[2], false)
                    else
                        FavAddon:RemoveFromShownList(db.activeList[1], db.activeList[2], false)
                    end
                    UpdateItemFrame(Addons, AddonName)
                end
            },
            iconSelection = {
                type = "group",
                name = AL["Icon"],
                inline = true,
                order = -1,
                get = function(info) return FavAddon.db[info[#info]] end,
                set = function(info, value)
                    print("disable")
                    FavAddon:SetIconAtlas(nil)
                    UpdateItemFrame(Addons, AddonName)
                end,
                get = function(info) return FavAddon.db[info[#info]] end,
                set = function(info, value) FavAddon.db[info[#info]] = value end,
                args = {
                    useIcon = {
                        order = 1,
                        type = "toggle",
                        width = "full",
                        name = _G.DISABLE,
                        disabled = function(info) return FavAddon:GetIconAtlas() and false or true end,
                        get = function(info) return FavAddon:GetIconAtlas() and false or true end,
                        set = function(info, value)
                            print("disable")
                            FavAddon:SetIconAtlas(nil)
                            UpdateItemFrame(Addons, AddonName)
                        end
                    },
                },
            },
        },
    }

    local args = t.args

    return t
end
















-- Addons
Options.orderNumber = Options.orderNumber + 1
Options.config.args.addons = {
	type = "group",
	name = _G.ADDONS,
	order = Options.orderNumber,
	args = {
        favourite = CreateFavouriteOptions(),
	},
}