-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then return end

--##START-DATA##
local SOURCE_DATA = {
    ["AtlasLootIDs"] = {
        "BlackrockCaverns",
        "ThroneOfTheTides",
        "TheStonecore",
        "TheVortexPinnacle",
        "LostCityOfTolvir",
        "HallsOfOrigination",
        "GrimBatol",
        "Deadmines",
        "ShadowfangKeep",
        "ZulAman",
        "ZulGurub",
        "EndTime",
        "WellOfEternity",
        "HourOfTwilight",
        "TheBastionOfTwilight",
        "BlackwingDescent",
        "ThroneOfTheFourWinds",
        "Firelands",
        "DragonSoul",
        "BaradinHold",
    },
    ["ItemData"] = {
    },
}

--##END-DATA##
AtlasLoot.Addons:GetAddon("Sources"):SetData(SOURCE_DATA)
