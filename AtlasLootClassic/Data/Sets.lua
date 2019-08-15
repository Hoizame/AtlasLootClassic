local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Sets = {}
AtlasLoot.Data.Sets = Sets
local ALIL = AtlasLoot.IngameLocales
local IMAGE_PATH = ALPrivate.ICONS_PATH
local ContentPhase

local ClassicItemSets = LibStub:GetLibrary("LibClassicItemSets-1.0")

-- lua
local assert, type = _G.assert, _G.type
local format = _G.string.format

-- WoW
local GetItemQualityColor, GetItemIcon = _G.GetItemQualityColor, _G.GetItemIcon

local GLOBAL_SETS = "global"
local NO_ICON = "Interface\\Icons\\inv_helmet_08"
local ICON_PATH_PRE = {
	-- class icons
	WARRIOR 	= 	IMAGE_PATH.."classicon_warrior",
	PALADIN 	= 	IMAGE_PATH.."classicon_paladin",
	HUNTER 		= 	IMAGE_PATH.."classicon_hunter",
	ROGUE 		= 	IMAGE_PATH.."classicon_rogue",
	PRIEST 		= 	IMAGE_PATH.."classicon_priest",
	SHAMAN 		= 	IMAGE_PATH.."classicon_shaman",
	MAGE 		= 	IMAGE_PATH.."classicon_mage",
	WARLOCK 	= 	IMAGE_PATH.."classicon_warlock",
	DRUID 		= 	IMAGE_PATH.."classicon_druid",
}
local SPECIAL_ICONS = {
	[466] = GetItemIcon(19898), -- Major Mojo Infusion
	[462] = GetItemIcon(19905), -- Zanzil's Concentration
	[465] = GetItemIcon(19863), -- Prayer of the Primal
	[464] = GetItemIcon(19873), -- Overlord's Resolution
	[461] = GetItemIcon(19865), -- The Twin Blades of Hakkari
	[41]  = GetItemIcon(12940), -- Dal'Rend's Arms
	[463] = GetItemIcon(19896), -- Primal Blessing
	[261] = GetItemIcon(18203), -- Spirit of Eskhandar
	[65]  = GetItemIcon(13183), -- Spider's Kiss
}
local COLOR_STRINGS = {}
local ContentPhaseCache = {}

local function OnInit()
    for i=0,7 do
		local _, _, _, itemQuality = GetItemQualityColor(i)
		COLOR_STRINGS[i] = "|c"..itemQuality
	end
    ContentPhase = AtlasLoot.Data.ContentPhase
end
AtlasLoot:AddInitFunc(OnInit)

function Sets:GetIcon(setID)
	if not ClassicItemSets:SetExist(setID) then return end
	if SPECIAL_ICONS[setID] then
		return SPECIAL_ICONS[setID]
	else
		local icon, class, className = ClassicItemSets:GetSetIcon(setID), ClassicItemSets:GetPlayerClass(setID)
		if class then
			return ICON_PATH_PRE[className]
		else
			return icon or NO_ICON
		end
	end
end

--local name, items, icon, classID, className = Sets:GetItemSetData(setID)
function Sets:GetItemSetData(setID)
	if not ClassicItemSets:SetExist(setID) then return end
	return ClassicItemSets:GetSetName(setID), ClassicItemSets:GetItems(setID), self:GetIcon(setID), ClassicItemSets:GetPlayerClass(setID)
end

function Sets:GetItemSetForItemID(itemID)
	return ClassicItemSets:GetItemSetForItemID(itemID)
end

function Sets:GetSetItems(setID)
	if not ClassicItemSets:SetExist(setID) then return end
	return ClassicItemSets:GetItems(setID)
end

function Sets:GetSetColor(setID)
	return COLOR_STRINGS[ClassicItemSets:GetSetQualityID(setID) or 0] or COLOR_STRINGS[0]
end

function Sets:GetSpetIDPhase(setID)
    if not ClassicItemSets:SetExist(setID) then return end
    if not ContentPhaseCache[setID] then
        local content = ClassicItemSets:GetItems(setID)
		local phase = 0
        for i = 1, #content do
            local c = ContentPhase:GetForItemID(content[i])
            phase = ( c and c > phase ) and c or phase
        end

        ContentPhaseCache[setID] = phase
    end
    return ContentPhaseCache[setID]
end

function Sets:GetPhaseTextureForSetID(setID)
    local phase = ContentPhaseCache[setID] or Sets:GetSpetIDPhase(setID)
    if not phase then return end
    return ContentPhase:GetPhaseTexture(phase)
end