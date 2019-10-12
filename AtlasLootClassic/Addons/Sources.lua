local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local Sources = Addons:RegisterNewAddon("Sources")
local Tooltip = AtlasLoot.Tooltip
local Droprate = AtlasLoot.Data.Droprate
local Profession = AtlasLoot.Data.Profession
local Recipe = AtlasLoot.Data.Recipe

-- lua
local type = type
local format = format

-- WoW


-- locals
local TT_F = "%s |cFF00ccff%s|r"
local DUMMY_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local TEXTURE_ICON_F, ATLAS_ICON_F = "|T%s:0|t ", "|A:%s:0:0|a "
local RECIPE_ICON = format(TEXTURE_ICON_F, "134939")
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
	[10] = format(TEXTURE_ICON_F, GetSpellTexture(2575)),   -- Mining
	[11] = format(TEXTURE_ICON_F, GetSpellTexture(3908)),   -- Tailoring
	[12] = format(TEXTURE_ICON_F, GetSpellTexture(4036)),   -- Engineering
	[13] = format(TEXTURE_ICON_F, GetSpellTexture(7411)),   -- Enchanting
	[14] = format(TEXTURE_ICON_F, GetSpellTexture(7732)),   -- Fishing
    [15] = format(TEXTURE_ICON_F, GetSpellTexture(8618)),   -- Skinning
    [16] = format(TEXTURE_ICON_F, GetSpellTexture(2842)),   -- Rogue: Poisons
}
local SOURCE_TYPES = {
    [0]  = UNKNOWN,	                    -- UNKNOWN
    [1]  = AL["Loot"],                  -- Loot
    [2]  = AL["Quest"],                 -- Quest
    [3]  = AL["Vendor"],                -- Buy
	[4]  = ALIL["First Aid"],           -- First Aid
	[5]  = ALIL["Blacksmithing"],       -- Blacksmithing
	[6]  = ALIL["Leatherworking"],      -- Leatherworking
	[7]  = ALIL["Alchemy"],             -- Alchemy
	[8]  = ALIL["Herbalism"],           -- Herbalism
	[9]  = ALIL["Cooking"],             -- Cooking
	[10] = ALIL["Mining"],              -- Mining
	[11] = ALIL["Tailoring"],           -- Tailoring
	[12] = ALIL["Engineering"],          -- Engineering
	[13] = ALIL["Enchanting"],          -- Enchanting
	[14] = ALIL["Fishing"],             -- Fishing
    [15] = ALIL["Skinning"],            -- Skinning
    [16] = ALIL["ROGUE"]..": "..ALIL["Poisons"],             -- Rogue: Poisons
}
local SOURCE_DATA
local KEY_WEAK_MT = {__mode="k"}
local AL_MODULE = "AtlasLootClassic_DungeonsAndRaids"

local TooltipsHooked = false
local TooltipCache, TooltipTextCache = {}

-- Addon
Sources.DbDefaults = {
    enabled = true,
    showDropRate = true,
    showProfRank = true,
    showRecipeSource = true,
    ["Sources"] = {
        ["*"] = true,
        [16] = false,
    }
}

--Sources.GlobalDbDefaults = {}
local function BuildSource(ini, boss, typ, item)
    if typ and typ > 3 then
        -- Profession
        local src = ""
        --RECIPE_ICON
        if Sources.db.showRecipeSource then
            local recipe = Recipe.GetRecipeForSpell(item)
            if recipe and SOURCE_DATA.ItemData[recipe] then
                local data = SOURCE_DATA.ItemData[recipe]
                src = format(TT_F, RECIPE_ICON, BuildSource(SOURCE_DATA.AtlasLootIDs[data[1]],data[2],data[3],data[4] or item))
                src = "\n"..src
            end
        end
        if Sources.db.showProfRank then
            local prof = Profession.GetProfessionData(item)
            if prof and prof[3] > 1 then
                return SOURCE_TYPES[typ].." ("..prof[3]..")"..src
            else
                return SOURCE_TYPES[typ]..src
            end
        else
            return SOURCE_TYPES[typ]..src
        end
    end
    if ini then
        local iniName, bossName = AtlasLoot.ItemDB:GetNameData_UNSAFE(AL_MODULE, ini, boss)
        local dropRate
        if Sources.db.showDropRate then
            local npcID = AtlasLoot.ItemDB:GetNpcID_UNSAFE(AL_MODULE, ini, boss)
            if type(npcID) == "table" then npcID = npcID[1] end
            dropRate = Droprate:GetData(npcID, item)
        end
        if iniName and bossName then
            if dropRate then
                return iniName.." - "..bossName.." ("..dropRate.."%)"
            else
                return iniName.." - "..bossName
            end
        elseif iniName then
            if dropRate then
                return iniName.." ("..dropRate.."%)"
            else
                return iniName
            end
        end
    end
    return ""
end

local function OnTooltipSetItem_Hook(self)
    if self:IsForbidden() or not SOURCE_DATA or not Sources.db.enabled then return end
    local _, item = self:GetItem()
    if not item then return end
    if not TooltipCache[item] then
        TooltipCache[item] = tonumber(strmatch(item, "item:(%d+)"))
    end

    item = TooltipCache[item]
    if item and SOURCE_DATA.ItemData[item] then
        if TooltipTextCache[item] ~= false then
            if not TooltipTextCache[item] then
                TooltipTextCache[item] = {}
                if type(SOURCE_DATA.ItemData[item][1]) == "table" then
                    for i = 1, #SOURCE_DATA.ItemData[item] do
                        local data = SOURCE_DATA.ItemData[item][i]
                        if data[3] and Sources.db.Sources[data[3]] then
                            TooltipTextCache[item][i] = format(TT_F, ICON_TEXTURE[data[3] or 0], BuildSource(SOURCE_DATA.AtlasLootIDs[data[1]],data[2],data[3],data[4] or item))
                        end
                    end
                else
                    local data = SOURCE_DATA.ItemData[item]
                    if data[3] and Sources.db.Sources[data[3]] then
                        TooltipTextCache[item][1] = format(TT_F, ICON_TEXTURE[data[3] or 0], BuildSource(SOURCE_DATA.AtlasLootIDs[data[1]],data[2],data[3],data[4] or item))
                    end
                end
                if #TooltipTextCache[item] < 1 then
                    TooltipTextCache[item] = false
                end
            end
            if TooltipTextCache[item] then
                for i = 1, #TooltipTextCache[item] do
                    self:AddLine(TooltipTextCache[item][i])
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

function Sources:UpdateDb()
    self.db = self:GetDb()

    TooltipTextCache = {}
    setmetatable(TooltipTextCache, KEY_WEAK_MT)

    if self.db.enabled then
        AtlasLoot.Loader:LoadModule("AtlasLootClassic_Data", InitTooltips)
        if self.db.showDropRate then
            AtlasLoot.Loader:LoadModule("AtlasLootClassic_DungeonsAndRaids")
        end
    end
end

function Sources.OnInitialize()
    Sources:UpdateDb()
end

function Sources:OnProfileChanged()
    Sources:UpdateDb()
end

function Sources:OnStatusChanged()
    Sources:UpdateDb()
end

function Sources:SetData(dataTable)
    if SOURCE_DATA then return end
    SOURCE_DATA = dataTable
end

function Sources:GetSourceTypes()
    return SOURCE_TYPES
end

Sources:Finalize()