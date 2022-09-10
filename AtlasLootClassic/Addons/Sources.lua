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
local VendorPrice = AtlasLoot.Data.VendorPrice

-- lua
local type = type
local format = format
local str_split = string.split

-- WoW
local GetCurrencyInfo, GetItemIcon = C_CurrencyInfo.GetCurrencyInfo, GetItemIcon

-- AtlasLoot
local PRICE_INFO = VendorPrice.GetPriceInfoList()
local PRICE_ICON_REPLACE = ALPrivate.PRICE_ICON_REPLACE
local DIFFICULTY = AtlasLoot.DIFFICULTY
local TOKEN_NUMBER_DUMMY = AtlasLoot.Data.Token.GetTokenDummyNumberRange()


-- locals
local TT_F = "%s |cFF00ccff%s|r"
local WHITE_TEXT = "|cffffffff%s|r"
local DUMMY_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local TEXTURE_ICON_F, TEXTURE_ICON_FN, ATLAS_ICON_F = "|T%s:0|t ", "|T%d:0|t ", "|A:%s:0:0|a "
local TT_F_PRICE_T, TT_F_PRICE_TN = "|T%s:0|t|cFFffffff%s|r", "|T%d:0|t|cFFffffff%s|r"
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
    [17] = format(TEXTURE_ICON_F, 134071),                  -- Jewelcrafting
    [18] = format(TEXTURE_ICON_F, 237171),                  -- Inscription
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
	[12] = ALIL["Engineering"],         -- Engineering
	[13] = ALIL["Enchanting"],          -- Enchanting
	[14] = ALIL["Fishing"],             -- Fishing
    [15] = ALIL["Skinning"],            -- Skinning
    [16] = ALIL["ROGUE"]..": "..ALIL["Poisons"],             -- Rogue: Poisons
    [17] = ALIL["Jewelcrafting"],       -- Jewelcrafting
    [18] = ALIL["Inscription"],         -- Inscription
}
local SOURCE_DATA = {}
local KEY_WEAK_MT = {__mode="k"}
local AL_MODULE = "AtlasLootClassic_DungeonsAndRaids"
local PRICE_STRING_SPLIT_OR = "-"
local PRICE_STRING_SPLIT_AND = ":"
local PRICE_DELIMITER = " |cFFffffff&|r  "
local PRICE_INFO_TT_START = format(TT_F.."  ", ICON_TEXTURE[3], AL["Vendor"]..":")
local DIFF_SPLIT_STRING = " / "

local TooltipsHooked = false
local TooltipCache, TooltipTextCache = {}

-- Addon
Sources.DbDefaults = {
    enabled = true,
    showDropRate = true,
    showProfRank = true,
    showRecipeSource = true,
    showLineBreak = true,
    showVendorPrices = true,
    ["Sources"] = {
        ["*"] = true,
        [16] = false,
    }
}

--Sources.GlobalDbDefaults = {}
local function BuildSource(ini, boss, typ, item, diffID)
    if typ and typ > 3 then
        -- Profession
        local src = ""
        --RECIPE_ICON
        if Sources.db.showRecipeSource then
            local recipe = Recipe.GetRecipeForSpell(item)
            local sourceData
            for i = #SOURCE_DATA, 1, -1 do
                if recipe and SOURCE_DATA[i].ItemData[recipe] then
                    sourceData = SOURCE_DATA[i]
                end
            end
            if recipe and sourceData then
                if type(sourceData.ItemData[item]) == "number" then
                    sourceData.ItemData[item] = sourceData.ItemData[sourceData.ItemData[item]]
                end

                local data = sourceData.ItemData[recipe]
                if type(data[1]) == "table" then
                    for i = 1, #data do
                        src = src..format(TT_F, RECIPE_ICON, BuildSource(sourceData.AtlasLootIDs[data[i][1]],data[i][2],data[i][3],data[i][4] or item))..(i==#data and "" or "\n")
                    end
                else
                    src = src..format(TT_F, RECIPE_ICON, BuildSource(sourceData.AtlasLootIDs[data[1]],data[2],data[3],data[4] or item))
                end
            end
        end
        if Sources.db.showProfRank then
            local prof = Profession.GetProfessionData(item)
            if prof and prof[3] > 1 then
                return SOURCE_TYPES[typ].." ("..prof[3]..")"..(src ~= "" and "\n"..src or src)
            else
                return SOURCE_TYPES[typ]..(src ~= "" and "\n"..src or src)
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
        if bossName and diffID then
            -- diff 0 means just heroic
            if diffID == 0 then
                bossName = bossName.." <"..DIFFICULTY.HEROIC.sourceLoc..">"
            elseif type(diffID) == "table" then
                local diffString
                for i = 1, #diffID do
                    diffString = i>1 and (diffString..DIFF_SPLIT_STRING..DIFFICULTY[diffID[i]].sourceLoc) or (DIFFICULTY[diffID[i]].sourceLoc)
                end
                if diffString then
                    bossName = bossName.." <"..diffString..">"
                end
            else
                bossName = bossName.." <"..DIFFICULTY[diffID].sourceLoc..">"
            end
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

local function GetPriceToolTipString(icon, value)
    if type(icon) == "number" then
        return format(TT_F_PRICE_TN, icon, value)
    else
        return format(TT_F_PRICE_T, icon, value)
    end
end

local function GetPriceFormatString(priceList)
    local fullString = PRICE_INFO_TT_START
    for i = 1, #priceList, 2 do
        local priceType, priceValue = priceList[i], priceList[i+1]
        if i > 1 then fullString = fullString..PRICE_DELIMITER end

        if PRICE_INFO[priceType] then
            if PRICE_INFO[priceType].func then
                fullString = fullString..PRICE_INFO[priceType].func(priceValue)
            elseif PRICE_INFO[priceType].icon then
                fullString = fullString..GetPriceToolTipString(PRICE_INFO[priceType].icon, priceValue)
            elseif PRICE_INFO[priceType].currencyID then
                local info = GetCurrencyInfo(PRICE_INFO[priceType].currencyID)
                if info then
                    fullString = fullString..GetPriceToolTipString(PRICE_ICON_REPLACE[priceType] or info.iconFileID, priceValue)
                end
            elseif PRICE_INFO[priceType].itemID then
                PRICE_INFO[priceType].icon = GetItemIcon(PRICE_INFO[priceType].itemID)
                fullString = fullString..GetPriceToolTipString(PRICE_INFO[priceType].icon, priceValue)
            end
        elseif tonumber(priceType) then
            fullString = fullString..GetPriceToolTipString(GetItemIcon(priceType), priceValue)
        end
    end

    return fullString ~= PRICE_INFO_TT_START and fullString or nil
end

local function GetTokenIcon(token)
    if token >= TOKEN_NUMBER_DUMMY then
        return ICON_TEXTURE[1]
    else
        return format(TEXTURE_ICON_FN, GetItemIcon(token))
    end
end

local function BuildSourceFromItemData(item, destTable, itemData, sourceData, iconTexture)
    if not item or not itemData[item] then return end
    if type(itemData[item][1]) == "table" then
        for i, data in ipairs(itemData[item]) do
            if data[3] and Sources.db.Sources[data[3]] then
                destTable[#destTable + 1] = format(TT_F, iconTexture or ICON_TEXTURE[data[3] or 0], BuildSource(sourceData.AtlasLootIDs[data[1]], data[2], data[3], data[4] or item, data[5]))
            end
        end
    else
        local data = itemData[item]
        if data[3] and Sources.db.Sources[data[3]] then
            destTable[#destTable + 1] = format(TT_F, iconTexture or ICON_TEXTURE[data[3] or 0], BuildSource(sourceData.AtlasLootIDs[data[1]], data[2], data[3], data[4] or item, data[5]))
        end
    end
end

local function OnTooltipSetItem_Hook(self)
    if self:IsForbidden() or not SOURCE_DATA or not Sources.db.enabled then return end
    local _, item = self:GetItem()
    if not item then return end
    if not TooltipCache[item] then
        TooltipCache[item] = tonumber(strmatch(item, "item:(%d+)"))
    end

    item = TooltipCache[item]

    local sourceData
    for i = #SOURCE_DATA, 1, -1 do
        if item and SOURCE_DATA[i].ItemData[item] then
            sourceData = SOURCE_DATA[i]
        end
    end

    if item then
        local newAdded
        -- sources from loot tables
        if sourceData and TooltipTextCache[item] ~= false and not TooltipTextCache[item] then
            TooltipTextCache[item] = {}

            -- token data
            if type(sourceData.ItemData[item]) == "number" then
                BuildSourceFromItemData(sourceData.ItemData[item], TooltipTextCache[item], sourceData.ItemData, sourceData, GetTokenIcon(sourceData.ItemData[item]))
            else
                if sourceData.ItemData[item][6] then
                    for i, v in ipairs(sourceData.ItemData[item][6]) do
                        BuildSourceFromItemData(v, TooltipTextCache[item], sourceData.ItemData, sourceData, GetTokenIcon(v))
                    end
                end
                BuildSourceFromItemData(item, TooltipTextCache[item], sourceData.ItemData, sourceData)
            end


            if #TooltipTextCache[item] < 1 then
                TooltipTextCache[item] = false
            end
            newAdded = true
        end

        -- price sources
        if Sources.db.showVendorPrices and (newAdded or not TooltipTextCache[item]) and VendorPrice.ItemHasVendorPrice(item) then
            if not TooltipTextCache[item] then
                TooltipTextCache[item] = {}
            end
            local priceString = VendorPrice.GetVendorPriceForItem(item)
            -- split the price string into parts
            local priceInfo = { str_split(PRICE_STRING_SPLIT_OR, priceString) }
            if priceInfo[2] then
                for i = 1, #priceInfo do
                    priceInfo[i] = { str_split(PRICE_STRING_SPLIT_AND, priceInfo[i]) }
                end
            else
                priceInfo = { { str_split(PRICE_STRING_SPLIT_AND, priceInfo[1]) } }
            end

            for priceSumCount = 1, #priceInfo do
                TooltipTextCache[item][ #TooltipTextCache[item] + 1 ] = GetPriceFormatString(priceInfo[priceSumCount])
            end
        end
        if TooltipTextCache[item] then
            if Sources.db.showLineBreak then
                self:AddLine(" ")
            end
            for i = 1, #TooltipTextCache[item] do
                self:AddLine(TooltipTextCache[item][i])
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
    SOURCE_DATA[#SOURCE_DATA+1] = dataTable
end

function Sources:GetSourceTypes()
    return SOURCE_TYPES
end

function Sources:ItemSourcesUpdated(itemID)
    if not itemID then return end
    TooltipTextCache[itemID] = nil
end

Sources:Finalize()