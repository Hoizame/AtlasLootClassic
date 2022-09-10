local addonname, private = ...
local AtlasLoot = _G.AtlasLoot

private.WORLD_EPICS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "WorldEpics",
    [AtlasLoot.BC_VERSION_NUM]          = "WorldEpicsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "WorldEpicsWrath",
}

private.MOUNTS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Mounts",
    [AtlasLoot.BC_VERSION_NUM]          = "MountsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "MountsWrath",
}

private.TABARDS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Tabards",
    [AtlasLoot.BC_VERSION_NUM]          = "TabardsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "TabardsWrath",
}

private.HALLOWEEN = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Halloween",
    [AtlasLoot.BC_VERSION_NUM]          = "HalloweenBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "HalloweenWrath",
}