local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local Addons = _G.AtlasLoot.Addons
local GetAddon = Addons.GetAddon

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
    local t = {
        type = "group",
        name = AL["Favourites"],
        order = count,
        get = function(info) return GetAddon(Addons, AddonName).db[info[#info]] end,
        set = function(info, value) GetAddon(Addons, AddonName).db[info[#info]] = value end,
        args = {
            enabled = {
                order = 1,
                type = "toggle",
                width = "full",
                name = _G.ENABLE,
                set = function(info, value)
                    GetAddon(Addons, AddonName).db[info[#info]] = value
                    UpdateItemFrame(Addons, AddonName)
                end
            },
            test = {
                type = "select",
                order = 2,
                name = AL["List"],
                values = function()
                    local db = GetAddon(Addons, AddonName):GetDb()
                    local list = {}
                    if db.activeList[2] == true then --gloabal
                        db = GetAddon(Addons, AddonName):GetGlobalDb()
                    else
                        db = db.lists
                    end
                    for k,v in pairs(db) do
                        list[k] = k
                    end
                    return list
                end,
                get = function(info) return GetAddon(Addons, AddonName):GetDb().activeList[1] end,
                set = function(info, value)
                    GetAddon(Addons, AddonName):GetDb().activeList[1] = value
                    UpdateItemFrame(Addons, AddonName)
                end,
            },
            global = {
                order = 3,
                type = "toggle",
                --width = "half",
                name = AL["Use global list."],
                get = function(info) return GetAddon(Addons, AddonName):GetDb().activeList[2] end,
                set = function(info, value)
                    local db = GetAddon(Addons, AddonName):GetDb()
                    db.activeList[1] = "Base"
                    db.activeList[2] = value
                    UpdateItemFrame(Addons, AddonName)
                end
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