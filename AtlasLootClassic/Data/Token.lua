local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales


local TOKEN = {
	--[itemID] = { itemID or {itemID, count} } 	optional: hideDesc=true (hide the description text and use std)
	-- Dire Maul books
	[18401] = { 18348 },	-- Foror's Compendium of Dragon Slaying
	[18362] = { 18469 },	-- Holy Bologna: What the Light Won't Tell You
	[18358] = { 18468 },	-- The Arcanist's Cookbook
	[18360] = { 18467 },	-- Harnessing Shadows
	[18356] = { 18465 },	-- Garona: A Study on Stealth and Treachery
	[18364] = { 18470 },	-- The Emerald Dream
	[18361] = { 18473 },	-- The Greatest Race of Hunters
	[18363] = { 18471 },	-- Frost Shock and You
	[18359] = { 18472 },	-- The Light and How to Swing It
	[18357] = { 18466 },	-- Codex of Defense

	-- Zul'Gurub
	[19724] = { 19841, 19834, 19831 },	-- Primal Hakkari Aegis
	[19717] = { 19830, 19836, 19824 },	-- Primal Hakkari Armsplint
	[19716] = { 19827, 19846, 19833 },	-- Primal Hakkari Bindings
	[19719] = { 19829, 19835, 19823 },	-- Primal Hakkari Girdle
	[19723] = { 20033, 20034, 19822 },	-- Primal Hakkari Kossack
	[19720] = { 19842, 19849, 19839 },	-- Primal Hakkari Sash
	[19721] = { 19826, 19845, 19832 },	-- Primal Hakkari Shawl
	[19718] = { 19843, 19848, 19840 },	-- Primal Hakkari Stanchion
	[19722] = { 19828, 19825, 19838 },	-- Primal Hakkari Tabard

	-- AQ40
	[21237] = { 21268, 21273, 21275 },	-- Imperial Qiraji Regalia
	[21232] = { 21242, 21244, 21272, 21269 },	-- Imperial Qiraji Armaments
	[20928] = { 21333, 21330, 21359, 21361, 21349, 21350, 21365, 21367 },	-- Qiraji Bindings of Command
	[20932] = { 21388, 21391, 21338, 21335, 21344, 21345, 21355, 21354, 21373, 21376 },	-- Qiraji Bindings of Dominance
	[20930] = { 21387, 21360, 21353, 21372, 21366 },	-- Vek'lor's Diadem
	[20926] = { 21329, 21337, 21347, 21348 },	-- Vek'nilash's Circlet
	[20927] = { 21332, 21362, 21346, 21352 },	-- Ouro's Intact Hide
	[20931] = { 21390, 21336, 21356, 21375, 21368 },	-- Skin of the Great Sandworm
	[20929] = { 21389, 21331, 21364, 21374, 21370 },	-- Carapace of the Old God
	[20933] = { 21334, 21343, 21357, 21351 },	-- Ouro's Intact Hide

	-- AQ20
	[20888] = { 21405, 21411, 21417, 21402 },	-- Qiraji Ceremonial Ring
	[20884] = { 21408, 21414, 21396, 21399, 21393 },	-- Qiraji Magisterial Ring
	[20885] = { 21406, 21394, 21415, 21412 },	-- Qiraji Martial Drape
	[20889] = { 21397, 21409, 21400, 21403, 21418 },	-- Qiraji Regal Drape
	[20890] = { 21413, 21410, 21416, 21407 },	-- Qiraji Ornate Hilt
	[20886] = { 21395, 21404, 21398, 21401, 21392 },	-- Qiraji Spiked Hilt

	-- Tier 3
	[22370] = { 22518, 22502, 22510 },	-- Desecrated Belt
	[22369] = { 22519, 22503, 22511 },	-- Desecrated Bindings
	[22365] = { 22440, 22492, 22468, 22430 },	-- Desecrated Boots
	[22355] = { 22483, 22423 },	-- Desecrated Bracers
	[22349] = { 22476, 22416 },	-- Desecrated Breastplate
	[22367] = { 22514, 22498, 22506 },	-- Desecrated Circlet
	[22357] = { 22481, 22421 },	-- Desecrated Gauntlets
	[22363] = { 22442, 22494, 22470, 22431 },	-- Desecrated Girdle
	[22371] = { 22501, 22517, 22509 },	-- Desecrated Gloves
	[22364] = { 22441, 22493, 22469, 22426 },	-- Desecrated Handguards
	[22360] = { 22438, 22490, 22466, 22428 },	-- Desecrated Headpiece
	[22353] = { 22478, 22418 },	-- Desecrated Helmet
	[22366] = { 22497, 22513, 22505 },	-- Desecrated Leggings
	[22359] = { 22437, 22489, 22465, 22427 },	-- Desecrated Legguards
	[22352] = { 22477, 22417 },	-- Desecrated Legplates
	[22354] = { 22479, 22419 },	-- Desecrated Pauldrons
	[22351] = { 22496, 22504, 22512 },	-- Desecrated Robe
	[22358] = { 22480, 22420 },	-- Desecrated Sabatons
	[22372] = { 22500, 22508, 22516 },	-- Desecrated Robe
	[22368] = { 22499, 22507, 22515 },	-- Desecrated Shoulderpads
	[22361] = { 22439, 22491, 22467, 22429 },	-- Desecrated Spaulders
	[22350] = { 22436, 22488, 22464, 22425 },	-- Desecrated Tunic
	[22356] = { 22482, 22422 },	-- Desecrated Waistguard
	[22362] = { 22443, 22495, 22471, 22424 },	-- Desecrated Wristguards
}

function Token.IsToken(itemID)
	return TOKEN[itemID or 0] and true or false
end

function Token.GetTokenData(itemID)
	return TOKEN[itemID or 0] and TOKEN[itemID or 0] or nil
end

function Token.GetTokenDescription(itemID)
	if not itemID then return end
	return ( TOKEN[itemID] and not TOKEN[itemID].hideDesc ) and AL["|cff00ff00Left-Click:|r Show additional items."] or nil
end