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
