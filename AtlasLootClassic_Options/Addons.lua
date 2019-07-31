local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local Addons = _G.AtlasLoot.Addons
local GetAddon = Addons.GetAddon

local count = 0

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
                    Addons:UpdateStatus(AddonName)
                    AtlasLoot.GUI.ItemFrame:Refresh(true)
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