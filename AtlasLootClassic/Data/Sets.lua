local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Sets = {}
AtlasLoot.Data.Sets = Sets
local ALIL = AtlasLoot.IngameLocales
local IMAGE_PATH = ALPrivate.ICONS_PATH

local ClassicItemSets = LibStub:GetLibrary("LibClassicItemSets-1.0")

-- lua
local assert, type = assert, type

local format = string.format

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

function Sets:GetIcon(setID)
	if not ClassicItemSets:SetExist(setID) then return end
	local icon, class, className = ClassicItemSets:GetSetIcon(setID), ClassicItemSets:GetPlayerClass(setID)
	if class then
		return ICON_PATH_PRE[className]
	else
		return icon or NO_ICON
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