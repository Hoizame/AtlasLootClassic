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

--##START-DATA##
local PHASE_ITEMS = {
	["AtlasLootIDs"] = {
		[1] = "Ragefire",
		[2] = "WailingCaverns",
		[3] = "TheDeadmines",
		[4] = "ShadowfangKeep",
		[5] = "BlackfathomDeeps",
		[6] = "TheStockade",
		[7] = "Gnomeregan",
		[8] = "RazorfenKraul",
		[9] = "ScarletMonasteryGraveyard",
		[10] = "ScarletMonasteryLibrary",
		[11] = "ScarletMonasteryArmory",
		[12] = "ScarletMonasteryCathedral",
		[13] = "RazorfenDowns",
		[14] = "Uldaman",
		[15] = "Zul'Farrak",
		[16] = "Maraudon",
		[17] = "TheTempleOfAtal'Hakkar",
		[18] = "BlackrockDepths",
		[19] = "LowerBlackrockSpire",
		[20] = "UpperBlackrockSpire",
		[21] = "DireMaulEast",
		[22] = "DireMaulWest",
		[23] = "DireMaulNorth",
		[24] = "Scholomance",
		[25] = "Stratholme",
		[26] = "MoltenCore",
		[27] = "Onyxia",
		[28] = "Zul'Gurub",
		[29] = "BlackwingLair",
		[30] = "TheRuinsofAhnQiraj",
		[31] = "TheTempleofAhnQiraj",
		[32] = "Naxxramas",
	},
}
--##END-DATA##
