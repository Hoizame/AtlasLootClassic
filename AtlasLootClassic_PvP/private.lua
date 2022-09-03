local addonname, private = ...
local AtlasLoot = _G.AtlasLoot

private.MOUNTS_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "PvPMounts",
    [AtlasLoot.BC_VERSION_NUM]          = "PvPMountsBCC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "PvPMountsWrath",
}