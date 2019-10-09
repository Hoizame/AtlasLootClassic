local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales

local type, pairs = type, pairs
local format = format

local TOKEN_FORMAT_STRING = "|cff00ff00"..AL["L-Click"]..":|r %s"
local TOKEN_TYPE_DEFAULT = 1
local TOKEN_TYPE_TEXT = {
	[0] = nil,	-- empty
	[1] = format(TOKEN_FORMAT_STRING, AL["Show additional items."]), -- default
	[2] = format(TOKEN_FORMAT_STRING, AL["Show possible items."]),
	[3] = format(TOKEN_FORMAT_STRING, AL["Show quest rewards."]),
	[4] = format(TOKEN_FORMAT_STRING, AL["Quest objective."]),
	[5] = format(TOKEN_FORMAT_STRING, AL["Reagent for..."]),

	-- classes get set with the init
	-- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"
}

local TOKEN = {
	-- [itemID] = { itemID or {itemID, count} }
	-- optional: type=0 		-	select the desc from the TOKEN_TYPE_TEXT table
	-- optional: itemID == 0 	-	creates a new line
	-- Dire Maul books
	[18401] = { 18348 },	-- Foror's Compendium of Dragon Slaying
	[18362] = { 18469, type = "PRIEST" },	-- Holy Bologna: What the Light Won't Tell You
	[18358] = { 18468, type = "MAGE" },	-- The Arcanist's Cookbook
	[18360] = { 18467, type = "WARLOCK" },	-- Harnessing Shadows
	[18356] = { 18465, type = "ROGUE" },	-- Garona: A Study on Stealth and Treachery
	[18364] = { 18470, type = "DRUID" },	-- The Emerald Dream
	[18361] = { 18473, type = "HUNTER" },	-- The Greatest Race of Hunters
	[18363] = { 18471, type = "SHAMAN" },	-- Frost Shock and You
	[18359] = { 18472, type = "PALADIN" },	-- The Light and How to Swing It
	[18357] = { 18466, type = "WARRIOR" },	-- Codex of Defense
	[18333] = { 18330, 0, 18333, 18335, {14344, 4}, {12753, 2}, type = 4 },	-- Libram of Focus
	[11733] = { 11642, 0, 11733, 11754, 8411, {11952, 4}, type = 4 },		-- Libram of Constitution
	[18334] = { 18331, 0, 18334, 18335, {14344, 2}, 12735, type = 4  },		-- Libram of Protection
	[18332] = { 18329, 0, 18332, 18335, {14344, 2}, {12938, 2}, type = 4 },	-- Libram of Rapidity
	[11736] = { 11644, 0, 11736, 11754, 11751, {11567, 4}, type = 4 },		-- Libram of Resilience
	[11732] = { 11622, 0, 11732, 11754, 11752, 8424, type = 4 },			-- Libram of Rumination
	[11734] = { 11643, 0, 11734, 11754, 11753, {11564, 4}, type = 4 },		-- Libram of Tenacity
	[11737] = { 11647, 11648, 11649, 11645, 11646, 0, 11737, 11754, {11951, 4}, {11563, 4}, type = 4 },	-- Libram of Voracity

	--- Darkmoon cards
	-- Portals / Darkmoon Card: Twisting Nether
	[19277] = { 19277, 19290, 0, 19276, 19278, 19279, 19280, 19281, 19282, 19283, 19284 },	-- Portals Deck
	[19276] = 19277,	-- Ace of Portals
	[19278] = 19277,	-- Two of Portals
	[19279] = 19277,	-- Three of Portals
	[19280] = 19277,	-- Four of Portals
	[19281] = 19277,	-- Five of Portals
	[19282] = 19277,	-- Six of Portals
	[19283] = 19277,	-- Seven of Portals
	[19284] = 19277,	-- Eight of Portals

	-- Elementals / Darkmoon Card: Maelstrom
	[19267] = { 19267, 19289, 0, 19268, 19269, 19270, 19271, 19272, 19273, 19274, 19275 },	-- Elementals Deck
	[19268] = 19267,	-- Ace of Elementals
	[19269] = 19267,	-- Two of Elementals
	[19270] = 19267,	-- Three of Elementals
	[19271] = 19267,	-- Four of Elementals
	[19272] = 19267,	-- Five of Elementals
	[19273] = 19267,	-- Six of Elementals
	[19274] = 19267,	-- Seven of Elementals
	[19275] = 19267,	-- Eight of Elementals

	-- Warlords / Darkmoon Card: Heroism
	[19257] = { 19257, 19287, 0, 19258, 19259, 19260, 19261, 19262, 19263, 19264, 19265 },	-- Warlords Deck
	[19258] = 19257,	-- Ace of Warlords
	[19259] = 19257,	-- Two of Warlords
	[19260] = 19257,	-- Three of Warlords
	[19261] = 19257,	-- Four of Warlords
	[19262] = 19257,	-- Five of Warlords
	[19263] = 19257,	-- Six of Warlords
	[19264] = 19257,	-- Seven of Warlords
	[19265] = 19257,	-- Eight of Warlords

	-- Beasts / Darkmoon Card: Blue Dragon
	[19228] = { 19228, 19288, 0, 19227, 19230, 19231, 19232, 19233, 19234, 19235, 19236 },	-- Beasts Deck
	[19227] = 19228,	-- Ace of Beasts
	[19230] = 19228,	-- Two of Beasts
	[19231] = 19228,	-- Three of Beasts
	[19232] = 19228,	-- Four of Beasts
	[19233] = 19228,	-- Five of Beasts
	[19234] = 19228,	-- Six of Beasts
	[19235] = 19228,	-- Seven of Beasts
	[19236] = 19228,	-- Eight of Beasts

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
	[11086] = { 9372, 0, 9379, 11086 }, -- Jang'thraze the Protector
	[9379] =  11086, -- Sang'thraze the Deflector
	[18784] = { 12725, 0, 18783, 18784 }, -- Top Half of Advanced Armorsmithing: Volume III
	[18783] = 18784, -- Bottom Half of Advanced Armorsmithing: Volume III
	[18780] = { 12727, 0, 18779, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
	[18779] = 18780, -- Bottom Half of Advanced Armorsmithing: Volume I
	[12731] = { 12752, 12757, 12756 }, -- Pristine Hide of the Beast
	[18782] = { 12726, 0, 18781, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
	[18781] = { 12726, 0, 18781, 18782 }, -- Bottom Half of Advanced Armorsmithing: Volume II
	[21813] = { 21816, 21817, 21818, 21819, 21820, 21821, 21822, 21823, type = 2}, -- Bag of Candies
	[19697] = { {19696, 4} }, -- Bounty of the Harvest
	[18564] = { 19019, 0, 18563, 18564, 19017 }, -- Bindings of the Windseeker <right>
	[18563] = 18564, -- Bindings of the Windseeker <left>
	[19017] = 18564, -- Essence of the Firelord
	[17204] = { 17182 }, -- Eye of Sulfuras
	[18703] = { 18714, 18713, 18715 }, -- Ancient Petrified Leaf
	[18646] = { 18665, 18646, 0, 18608, 18609 }, -- The Eye of Divinity
	[18665] = 18646, -- The Eye of Shadow
	[17074] = { 17074, 17223 }, -- Shadowstrike
	[17223] = 17074, -- Thunderstrike
	[18608] = { 18608, 18609 }, -- Benediction
	[18609] = 18608, -- Anathema
	[7733] = { 7733, 0, 7740, 7741 }, -- Staff of Prehistoria
	[7740] = 7733, -- Gni'kiv Medallion
	[7741] = 7733, -- The Shaft of Tsol
	[12845] = { 17044, 17045, type = 4 }, -- Medallion of Faith

	-- Quests
	[10441] = { 10657, 10658, type = 3 }, -- Glowing Shard
	[6283] = { 6335, 4534, type = 3 }, -- The Book of Ur
	[16782] = { 16886, 16887, type = 3 }, -- Strange Water Globe
	[9326] = { 9588, type = 3 }, -- Grime-Encrusted Ring
	[17008] = { 17043, 17042, 17039, type = 3 }, -- Small Scroll
	[10454] = { 10455, type = 3 }, -- Essence of Eranikus
	[12780] = { 13966, 13968, 13965, type = 3 }, -- General Drakkisath's Command
	[7666] = { 7673, type = 3 }, -- Shattered Necklace
	[19003] = { 19383, 19384, 19366, type = 3 }, -- Head of Nefarian
	[18423] = { 18404, 18403, 18406, type = 3 }, -- Head of Onyxia

	-- Quest objective
	[18705] = { 18713, type = 4 }, -- Mature Black Dragon Sinew
	[18704] = { 18714, type = 4 }, -- Mature Blue Dragon Sinew
	[12871] = { 12895, 0, 12903, 12945, type = 4 }, -- Chromatic Carapace
	[18706] = { 19024, 0, {18706, 12}, type = 4 }, -- Arena Master


	[22523] = { 22523, 22524, 0,
				22689, 22690, 22681, 22680, 22688, 22679, 0,
				22667, 22668, 22657, 22659, 22678, 22656, type = 4 }, -- Insignia of the Dawn
	[22524] = 22523, -- Insignia of the Crusade

	-- Naxxramas
	[22520] = { 23207, 23206, type = 3 }, -- The Phylactery of Kel'Thuzad

	-- AQ40
	[21221] = { 21712, 21710, 21709, type = 3 }, -- Amulet of the Fallen God
	[21762] = { 21156, 20876, 20879, 20875, 20878, 20881, 20877, 20874, 20882 }, -- Greater Scarab Coffer Key

	-- AQ20
	[21220] = { 21504, 21507, 21505, 21506, type = 3 }, -- Head of Ossirian the Unscarred

	-- ZG
	[19802] = { 19950, 19949, 19948, type = 3 }, -- Heart of Hakkar
	[19939] = { 19939, 19940, 19941, 19942, 0,
				19819, 19820, 19818, 19814, 19821, 19816, 19817, 19813, 19815, 0,
				19957, 19958, 19959, 19954, 19955, 19953, 19956, 19951, 19952 }, -- Gri'lek's Blood
	[19940] = 19939, -- Renataki's Tooth
	[19941] = 19939, -- Wushoolay's Mane
	[19942] = 19939, -- Hazza'rah's Dream Thread
	-- ZG / Punctured Voodoo Doll
	[19820] = 19939, [19818] = 19939, [19819] = 19939, [19814] = 19939, [19821] = 19939, [19816] = 19939, [19817] = 19939, [19815] = 19939, [19813] = 19939,

	-- Reagent for...
	[12811] = { "prof20034", "prof22750", "prof25079", 0, "prof18456", "prof16990", "prof23632", "prof23633", type = 5 }, -- Righteous Orb
	[20381] = { "prof24703", type = 5 }, -- Dreamscale Breastplate
	[12753] = { "prof22928", "prof27830", type = 5 }, -- Dreamscale Breastplate
	[17203] = { "prof21161", type = 5 }, -- Sulfuron Ingot
	[15410] = { "prof19106", "prof19093", type = 5 }, -- Scale of Onyxia

	-- Atiesh
	[22727] = { { 22726, 40 }, 22727, 22734, 22733, 0, 22631, 22589, 22630, 22632 }, -- Frame of Atiesh
	[22726] = 22727, -- Splinter of Atiesh
	[22734] = 22727, -- Base of Atiesh
	[22733] = 22727, -- Staff Head of Atiesh

	-- UBRS key
	[12219] = { 12219, 12336, 12335, 12337, 0, 12344 }, -- Unadorned Seal of Ascension
	[12336] = 12219, -- Gemstone of Spirestone
	[12335] = 12219, -- Gemstone of Smolderthorn
	[12337] = 12219, -- Gemstone of Bloodaxe
}

local function Init()
	local coloredClassNames = AtlasLoot:GetColoredClassNames()

	for k, v in pairs(TOKEN) do
		if TOKEN[v] then
			TOKEN[k] = TOKEN[v]
		end
	end

	for className, cClassName in pairs(coloredClassNames) do
		TOKEN_TYPE_TEXT[className] = format(TOKEN_FORMAT_STRING, cClassName)
	end
end
AtlasLoot:AddInitFunc(Init)

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