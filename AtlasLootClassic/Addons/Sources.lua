local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local Sources = Addons:RegisterNewAddon("Sources")
local Tooltip = AtlasLoot.Tooltip

-- lua
local format = format

-- WoW


-- locals
local DUMMY_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local TEXTURE_ICON_F, ATLAS_ICON_F = "|T%s:0|t ", "|A:%s:0:0|a "
local ICON_TEXTURE = {
    [0]  = format(TEXTURE_ICON_F, DUMMY_ICON),	            -- UNKNOWN
    [1]  = format(ATLAS_ICON_F, "ParagonReputation_Bag"),   -- Loot
    [2]  = format(ATLAS_ICON_F, "QuestNormal"),             -- Quest
    [3]  = format(ATLAS_ICON_F, "Auctioneer"),              -- Buy
	[4]  = format(TEXTURE_ICON_F, GetSpellTexture(3273)),   -- First Aid
	[5]  = format(TEXTURE_ICON_F, GetSpellTexture(2018)),   -- Blacksmithing
	[6]  = format(TEXTURE_ICON_F, GetSpellTexture(2108)),   -- Leatherworking
	[7]  = format(TEXTURE_ICON_F, GetSpellTexture(2259)),   -- Alchemy
	[8]  = format(TEXTURE_ICON_F, GetSpellTexture(2366)),   -- Herbalism
	[9]  = format(TEXTURE_ICON_F, GetSpellTexture(2550)),   -- Cooking
	[10]  = format(TEXTURE_ICON_F, GetSpellTexture(2575)),   -- Mining
	[11] = format(TEXTURE_ICON_F, GetSpellTexture(3908)),   -- Tailoring
	[12] = format(TEXTURE_ICON_F, GetSpellTexture(4036)),   -- Engineering
	[13] = format(TEXTURE_ICON_F, GetSpellTexture(7411)),   -- Enchanting
	[14] = format(TEXTURE_ICON_F, GetSpellTexture(7732)),   -- Fishing
    [15] = format(TEXTURE_ICON_F, GetSpellTexture(8618)),   -- Skinning
    [16] = format(TEXTURE_ICON_F, GetSpellTexture(2842)),   -- Rogue: Poisons
}

-- Addon
Sources.DbDefaults = {

}

--Sources.GlobalDbDefaults = {}


function Sources.OnInitialize()

end

function Sources:OnProfileChanged()

end

function Sources:OnStatusChanged()

end



Sources:Finalize()