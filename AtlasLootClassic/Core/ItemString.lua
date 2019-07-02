local AtlasLoot = _G.AtlasLoot
local ItemString = {}
AtlasLoot.ItemString = ItemString

-- lua
local format = string.format

local ITEM_FORMAT_STRING = "item:%d:0:0:0:0:0:0:0:0:0:0:0:0"


function ItemString.Create(itemID)
	return format( ITEM_FORMAT_STRING,
		itemID					-- itemID
	)
end

local function AltasLoot_PrintItemString(slot)
	local itemString = GetInventoryItemLink("player",slot or INVSLOT_FEET)
	local _, itemID, enchantID, gemID1, gemID2, gemID3, gemID4,
	suffixID, uniqueID, linkLevel, specializationID, upgradeTypeID, instanceDifficultyID, numBonusIDs = strsplit(":", itemString)
	local tempString, unknown1, unknown2, unknown3 = strmatch(itemString, "item:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:([-:%d]+):([-%d]-):([-%d]-):([-%d]-)|")
	local bonusIDs, upgradeValue
	if upgradeTypeID and upgradeTypeID ~= "" then
		upgradeValue = tempString:match("[-:%d]+:([-%d]+)")
		bonusIDs = {strsplit(":", tempString:match("([-:%d]+):"))}
	else
		bonusIDs = {strsplit(":", tempString)}
	end
	return suffixID, uniqueID, linkLevel, specializationID, upgradeTypeID, instanceDifficultyID, numBonusIDs, bonusIDs, upgradeValue
end
-- /run print(AtlasLoot.ItemString.AddBonusByDifficultyID(140914, 16))
-- /run print(GetItemInfo(AtlasLoot.ItemString.AddBonusByDifficultyID(140914, 16)))
