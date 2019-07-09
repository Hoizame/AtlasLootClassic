local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales

local TOKEN_TYPE_DEFAULT = 1
local TOKEN_TYPE_TEXT = {
	[0] = nil,	-- empty
	[1] = AL["|cff00ff00Left-Click:|r Show additional items."],		-- default
	[2] = AL["|cff00ff00Left-Click:|r Show possible items."],
	[3] = AL["|cff00ff00Left-Click:|r Show quest rewards."],
}

local TOKEN = {
	-- [itemID] = { itemID or {itemID, count} }
	-- optional: type=0 		-	select the desc from the TOKEN_TYPE_TEXT table
	-- optional: itemID == 0 	-	creates a new line
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
	[18333] = { 18330 },	-- Libram of Focus
	[11733] = { 11642 },	-- Libram of Constitution
	[18334] = { 18331 },	-- Libram of Protection
	[18332] = { 18329 },	-- Libram of Rapidity
	[11736] = { 11644 },	-- Libram of Resilience
	[11732] = { 11622 },	-- Libram of Rumination
	[11734] = { 11643 },	-- Libram of Tenacity
	[11737] = { 11647, 11648, 11649, 11645, 11646 },	-- Libram of Voracity

	--- Darkmoon cards
	-- Portals / Darkmoon Card: Twisting Nether
	[19277] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Portals Deck
	[19276] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Ace of Portals
	[19278] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Two of Portals
	[19279] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Three of Portals
	[19280] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Four of Portals
	[19281] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Five of Portals
	[19282] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Six of Portals
	[19283] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Seven of Portals
	[19284] = { 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284, 0, 19277, 19290 },	-- Eight of Portals

	-- Elementals / Darkmoon Card: Maelstrom
	[19267] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Elementals Deck
	[19268] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Ace of Elementals
	[19269] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Two of Elementals
	[19270] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Three of Elementals
	[19271] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Four of Elementals
	[19272] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Five of Elementals
	[19273] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Six of Elementals
	[19274] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Seven of Elementals
	[19275] = { 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275, 0, 19267, 19289 },	-- Eight of Elementals

	-- Warlords / Darkmoon Card: Heroism
	[19257] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Warlords Deck
	[19258] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Ace of Warlords
	[19259] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Two of Warlords
	[19260] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Three of Warlords
	[19261] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Four of Warlords
	[19262] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Five of Warlords
	[19263] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Six of Warlords
	[19264] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Seven of Warlords
	[19265] = { 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265, 0, 19257, 19287 },	-- Eight of Warlords

	-- Beasts / Darkmoon Card: Blue Dragon
	[19257] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Beasts Deck
	[19227] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Ace of Beasts
	[19230] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Two of Beasts
	[19231] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Three of Beasts
	[19232] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Four of Beasts
	[19233] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Five of Beasts
	[19234] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Six of Beasts
	[19235] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Seven of Beasts
	[19236] = { 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236, 0, 19228, 19288 },	-- Eight of Beasts

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
	[21237] = { 21268, 21273, 21275 },														-- Imperial Qiraji Regalia
	[21232] = { 21242, 21244, 21272, 21269 },												-- Imperial Qiraji Armaments
	[20928] = { 21333, 21330, 21359, 21361, 21349, 21350, 21365, 21367 },					-- Qiraji Bindings of Command
	[20932] = { 21388, 21391, 21338, 21335, 21344, 21345, 21355, 21354, 21373, 21376 },		-- Qiraji Bindings of Dominance
	[20930] = { 21387, 21360, 21353, 21372, 21366 },										-- Vek'lor's Diadem
	[20926] = { 21329, 21337, 21347, 21348 },												-- Vek'nilash's Circlet
	[20927] = { 21332, 21362, 21346, 21352 },												-- Ouro's Intact Hide
	[20931] = { 21390, 21336, 21356, 21375, 21368 },										-- Skin of the Great Sandworm
	[20929] = { 21389, 21331, 21364, 21374, 21370 },										-- Carapace of the Old God
	[20933] = { 21334, 21343, 21357, 21351 },												-- Ouro's Intact Hide

	-- AQ20
	[20888] = { 21405, 21411, 21417, 21402 },			-- Qiraji Ceremonial Ring
	[20884] = { 21408, 21414, 21396, 21399, 21393 },	-- Qiraji Magisterial Ring
	[20885] = { 21406, 21394, 21415, 21412 },			-- Qiraji Martial Drape
	[20889] = { 21397, 21409, 21400, 21403, 21418 },	-- Qiraji Regal Drape
	[20890] = { 21413, 21410, 21416, 21407 },			-- Qiraji Ornate Hilt
	[20886] = { 21395, 21404, 21398, 21401, 21392 },	-- Qiraji Spiked Hilt

	-- Tier 3
	[22370] = { 22518, 22502, 22510 },			-- Desecrated Belt
	[22369] = { 22519, 22503, 22511 },			-- Desecrated Bindings
	[22365] = { 22440, 22492, 22468, 22430 },	-- Desecrated Boots
	[22355] = { 22483, 22423 },					-- Desecrated Bracers
	[22349] = { 22476, 22416 },					-- Desecrated Breastplate
	[22367] = { 22514, 22498, 22506 },			-- Desecrated Circlet
	[22357] = { 22481, 22421 },					-- Desecrated Gauntlets
	[22363] = { 22442, 22494, 22470, 22431 },	-- Desecrated Girdle
	[22371] = { 22501, 22517, 22509 },			-- Desecrated Gloves
	[22364] = { 22441, 22493, 22469, 22426 },	-- Desecrated Handguards
	[22360] = { 22438, 22490, 22466, 22428 },	-- Desecrated Headpiece
	[22353] = { 22478, 22418 },					-- Desecrated Helmet
	[22366] = { 22497, 22513, 22505 },			-- Desecrated Leggings
	[22359] = { 22437, 22489, 22465, 22427 },	-- Desecrated Legguards
	[22352] = { 22477, 22417 },					-- Desecrated Legplates
	[22354] = { 22479, 22419 },					-- Desecrated Pauldrons
	[22351] = { 22496, 22504, 22512 },			-- Desecrated Robe
	[22358] = { 22480, 22420 },					-- Desecrated Sabatons
	[22372] = { 22500, 22508, 22516 },			-- Desecrated Robe
	[22368] = { 22499, 22507, 22515 },			-- Desecrated Shoulderpads
	[22361] = { 22439, 22491, 22467, 22429 },	-- Desecrated Spaulders
	[22350] = { 22436, 22488, 22464, 22425 },	-- Desecrated Tunic
	[22356] = { 22482, 22422 },					-- Desecrated Waistguard
	[22362] = { 22443, 22495, 22471, 22424 },	-- Desecrated Wristguards

	-- Gem Sacks
	[17962] = { 12361, 1529, 7909, 7910, 3864, 7971, 13926, type = 2 },			-- Blue Sack of Gems
	[17963] = { 12364, 1529, 7909, 7910, 3864, 7971, 13926, type = 2 },			-- Green Sack of Gems
	[17964] = { 12800, 1529, 7909, 7910, 3864, 7971, 13926, type = 2 },			-- Gray Sack of Gems
	[17965] = { 12363, 1529, 7909, 7910, 3864, 7971, 13926, type = 2 },			-- Yellow Sack of Gems
	[17969] = { 6332, 12799, 1529, 7909, 7910, 3864, 7971, 13926, type = 2 },	-- Red Sack of Gems

	-- Misc Bags
	[21156] = { 20858, 20859, 20860, 20861, 20862, 20863, 20864, 20865, type = 2 },						-- Scarab Bag
	[12033] = { 7910, 1529, 7909, 12361, 1705, 12799, 7971, 5500, 12800, 1206, 12364, type = 2 },		-- Thaurissan Family Jewels

	-- Misc
	[11086] = { 9379, 9372 }, -- Jang'thraze the Protector
	[9379] = { 11086, 9372 }, -- Sang'thraze the Deflector
	[18784] = { 18783, 12725, 16742 }, -- Top Half of Advanced Armorsmithing: Volume III
	[18783] = { 18784, 12725, 16742 }, -- Bottom Half of Advanced Armorsmithing: Volume III
	[18780] = { 18779, 12727, 12618 }, -- Pristine Hide of the Beast
	[18779] = { 18780, 12727, 12618 }, -- Top Half of Advanced Armorsmithing: Volume I
	[12731] = { 12752, 12757, 12756 }, -- Bottom Half of Advanced Armorsmithing: Volume I
	[18782] = { 18781, 12726, 12619 }, -- Top Half of Advanced Armorsmithing: Volume II
	[18781] = { 18782, 12726, 12619 }, -- Bottom Half of Advanced Armorsmithing: Volume II


	-- Quests
	[10441] = { 10657, 10658, type = 3 }, -- Glowing Shard
	[6283] = { 6335, 4534, type = 3 }, -- The Book of Ur
	[16782] = { 16886, 16887, type = 3 }, -- Strange Water Globe
	[9326] = { 9588, type = 3 }, -- Grime-Encrusted Ring
	[17008] = { 17043, 17042, 17039, type = 3 }, -- Small Scroll
	[10454] = { 10455, type = 3 }, -- Essence of Eranikus
	[12780] = { 13966, 13968, 13965, type = 3 }, -- General Drakkisath's Command

	-- Naxxramas
	[22520] = { 23207, 23206, type = 3 }, -- The Phylactery of Kel'Thuzad

	-- AQ40
	[21221] = { 21712, 21710, 21709, type = 3 }, -- Amulet of the Fallen God

	-- AQ20
	[21220] = { 21504, 21507, 21505, 21506, type = 3 }, -- Head of Ossirian the Unscarred

	-- ZG
	[19802] = { 19950, 19949, 19948, type = 3 }, -- Heart of Hakkar
}

function Token.IsToken(itemID)
	return TOKEN[itemID or 0] and true or false
end

function Token.GetTokenData(itemID)
	return TOKEN[itemID or 0] and TOKEN[itemID or 0] or nil
end

function Token.GetTokenDescription(itemID)
	return ( itemID and TOKEN[itemID] ) and TOKEN_TYPE_TEXT[TOKEN[itemID].type or TOKEN_TYPE_DEFAULT] or nil
end

function Token.GetTokenType(itemID)
	return ( itemID and TOKEN[itemID] ) and (TOKEN[itemID].type or TOKEN_TYPE_DEFAULT) or nil
end