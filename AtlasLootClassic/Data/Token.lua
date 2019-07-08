local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales

local TOKEN = {
	--[itemID] = { itemID or {itemID, count} }
	[22371] = { 22501, 22517, 22509 },	-- Desecrated Gloves
}

function Token.IsToken(itemID)
	return TOKEN[itemID or 0] and true or false
end

function Token.GetTokenData(itemID)
	return TOKEN[itemID or 0] and TOKEN[itemID or 0] or nil
end