local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Token = {}
AtlasLoot.Data.Token = Token
local AL = AtlasLoot.Locales

local type, pairs = type, pairs
local format = format

local TOKE_NUMBER_RANGE = 900000

local TOKEN_FORMAT_STRING = "|cff00ff00"..AL["L-Click"]..":|r %s"
local TOKEN_TYPE_DEFAULT = 1
local TOKEN_TYPE_TEXT = {
	[0]  = nil,	-- empty
	[1]  = format(TOKEN_FORMAT_STRING, AL["Show additional items."]), -- default
	[2]  = format(TOKEN_FORMAT_STRING, AL["Show possible items."]),
	[3]  = format(TOKEN_FORMAT_STRING, AL["Show quest rewards."]),
	[4]  = format(TOKEN_FORMAT_STRING, AL["Quest objective."]),
	[5]  = format(TOKEN_FORMAT_STRING, AL["Reagent for..."]),
	[6]  = format(TOKEN_FORMAT_STRING, AL["Token for..."]),
	[7]  = format(TOKEN_FORMAT_STRING, AL["Bought with..."]),
	[8]  = format(TOKEN_FORMAT_STRING, AL["Token for..."]), -- same as '6' but with itemDesc added
	[9]  = format(TOKEN_FORMAT_STRING, AL["Show loot."]),
	[10] = format(TOKEN_FORMAT_STRING, AL["Show Achievements."]),
	[11] = format(TOKEN_FORMAT_STRING, AL["Contains."])

	-- classes get set with the init
	-- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR", "DEATHKNIGHT"
}

local TOKEN_TYPE_ADD_ITEM_DESCRIPTION = {
	[7] = true,
	[8] = true,
	[9] = true,
}

local ICONS = ALPrivate.CLASS_ICON_PATH_ITEM_DB

local TOKEN, TOKEN_DATA = AtlasLoot:GetGameVersionDataTable()

TOKEN_DATA.CLASSIC = {
	-- [itemID] = { itemID or {itemID, count} }
	-- optional: type=0 		-	select the desc from the TOKEN_TYPE_TEXT table
	-- optional: itemID == 0 	-	creates a new line
	-- Dire Maul books
	[18401] = { 18348 },	-- Foror's Compendium of Dragon Slaying
	[18362] = { 18469, type = "PRIEST" },	-- Holy Bologna: What the Light Won't Tell You
	[18358] = { 18468, type = "MAGE" },		-- The Arcanist's Cookbook
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
	[19724] = { ICONS.HUNTER, 19831, 0, ICONS.ROGUE, 19834, 0, ICONS.PRIEST, 19841, type = 6 },		-- Primal Hakkari Aegis
	[19717] = { ICONS.WARRIOR, 19824, 0, ICONS.ROGUE, 19836, 0, ICONS.SHAMAN, 19830, type = 6 },	-- Primal Hakkari Armsplint
	[19716] = { ICONS.PALADIN, 19827, 0, ICONS.HUNTER, 19833, 0, ICONS.MAGE, 19846, type = 6 },		-- Primal Hakkari Bindings
	[19719] = { ICONS.WARRIOR, 19823, 0, ICONS.ROGUE, 19835, 0, ICONS.SHAMAN, 19829, type = 6 },	-- Primal Hakkari Girdle
	[19723] = { ICONS.WARRIOR, 19822, 0, ICONS.MAGE, 20034, 0, ICONS.WARLOCK, 20033, type = 6 },	-- Primal Hakkari Kossack
	[19720] = { ICONS.PRIEST, 19842, 0, ICONS.WARLOCK, 19849, 0, ICONS.DRUID, 19839, type = 6 },	-- Primal Hakkari Sash
	[19721] = { ICONS.PALADIN, 19826, 0, ICONS.HUNTER, 19832, 0, ICONS.MAGE, 19845, type = 6 },		-- Primal Hakkari Shawl
	[19718] = { ICONS.PRIEST, 19843, 0, ICONS.WARLOCK, 19848, 0, ICONS.DRUID, 19840, type = 6 },	-- Primal Hakkari Stanchion
	[19722] = { ICONS.PALADIN, 19825, 0, ICONS.SHAMAN, 19828, 0, ICONS.DRUID, 19838, type = 6 },	-- Primal Hakkari Tabard

	-- AQ40
	[21237] = { 21268, 21273, 21275, type = 6 },			-- Imperial Qiraji Regalia
	[21232] = { 21242, 21244, 21272, 21269, type = 6 },	-- Imperial Qiraji Armaments
	[20928] = { ICONS.WARRIOR, 21330, 21333, 0, ICONS.HUNTER, 21367, 21365, 0, ICONS.ROGUE, 21361, 21359, 0, ICONS.PRIEST, 21350, 21349, type = 6  }, -- Qiraji Bindings of Command
	[20932] = { ICONS.PALADIN, 21391, 21388, 0, ICONS.SHAMAN, 21376, 21373, 0, ICONS.MAGE, 21345, 21344, 0, ICONS.WARLOCK, 21335, 21338, 0, ICONS.DRUID, 21354, 21355, type = 6 }, -- Qiraji Bindings of Dominance
	[20930] = { ICONS.PALADIN, 21387, 0, ICONS.HUNTER, 21366, 0, ICONS.ROGUE, 21360, 0, ICONS.SHAMAN, 21372, 0, ICONS.DRUID, 21353, type = 6 }, -- Vek'lor's Diadem
	[20926] = { ICONS.WARRIOR, 21329, 0, ICONS.PRIEST, 21348, 0, ICONS.MAGE, 21347, 0, ICONS.WARLOCK, 21337, type = 6 }, -- Vek'nilash's Circlet
	[20927] = { ICONS.WARRIOR, 21332, 0, ICONS.ROGUE, 21362, 0, ICONS.PRIEST, 21352, 0, ICONS.MAGE, 21346, type = 6 }, -- Ouro's Intact Hide
	[20931] = { ICONS.PALADIN, 21390, 0, ICONS.HUNTER, 21368, 0, ICONS.SHAMAN, 21375, 0, ICONS.WARLOCK, 21336, 0, ICONS.DRUID, 21356, type = 6 }, -- Skin of the Great Sandworm
	[20929] = { ICONS.WARRIOR, 21331, 0, ICONS.PALADIN, 21389, 0, ICONS.HUNTER, 21370, 0, ICONS.ROGUE, 21364, 0, ICONS.SHAMAN, 21374, type = 6 }, -- Carapace of the Old God
	[20933] = { ICONS.PRIEST, 21351, 0, ICONS.MAGE, 21343, 0, ICONS.WARLOCK, 21334, 0, ICONS.DRUID, 21357, type = 6 }, -- Husk of the Old God

	-- AQ20
	[20888] = { ICONS.HUNTER, 21402, 0, ICONS.ROGUE, 21405, 0, ICONS.PRIEST, 21411, 0, ICONS.WARLOCK, 21417, type = 6 },							-- Qiraji Ceremonial Ring
	[20884] = { ICONS.WARRIOR, 21393, 0, ICONS.PALADIN, 21396, 0, ICONS.SHAMAN, 21399, 0, ICONS.MAGE, 21414, 0, ICONS.DRUID, 21408, type = 6 },		-- Qiraji Magisterial Ring
	[20885] = { ICONS.WARRIOR, 21394, 0, ICONS.ROGUE, 21406, 0, ICONS.PRIEST, 21412, 0, ICONS.MAGE, 21415, type = 6 },								-- Qiraji Martial Drape
	[20889] = { ICONS.PALADIN, 21397, 0, ICONS.HUNTER, 21403, 0, ICONS.SHAMAN, 21400, 0, ICONS.WARLOCK, 21418, 0, ICONS.DRUID, 21409, type = 6 },	-- Qiraji Regal Drape
	[20890] = { ICONS.PRIEST, 21410, 0, ICONS.MAGE, 21413, 0, ICONS.WARLOCK, 21416, 0, ICONS.DRUID, 21407, type = 6 },								-- Qiraji Ornate Hilt
	[20886] = { ICONS.WARRIOR, 21392, 0, ICONS.PALADIN, 21395, 0, ICONS.HUNTER, 21401, 0, ICONS.ROGUE, 21404, 0, ICONS.SHAMAN, 21398, type = 6  },	-- Qiraji Spiked Hilt

	-- Tier 3
	[22360] = { ICONS.PALADIN, 22428, 0, ICONS.HUNTER, 22438, 0, ICONS.SHAMAN, 22466, 0, ICONS.DRUID, 22490, type = 6 }, -- Desecrated Headpiece
	[22361] = { ICONS.PALADIN, 22429, 0, ICONS.HUNTER, 22439, 0, ICONS.SHAMAN, 22467, 0, ICONS.DRUID, 22491, type = 6 }, -- Desecrated Spaulders
	[22350] = { ICONS.PALADIN, 22425, 0, ICONS.HUNTER, 22436, 0, ICONS.SHAMAN, 22464, 0, ICONS.DRUID, 22488, type = 6 }, -- Desecrated Tunic
	[22362] = { ICONS.PALADIN, 22424, 0, ICONS.HUNTER, 22443, 0, ICONS.SHAMAN, 22471, 0, ICONS.DRUID, 22495, type = 6 }, -- Desecrated Wristguards
	[22364] = { ICONS.PALADIN, 22426, 0, ICONS.HUNTER, 22441, 0, ICONS.SHAMAN, 22469, 0, ICONS.DRUID, 22493, type = 6 }, -- Desecrated Handguards
	[22363] = { ICONS.PALADIN, 22431, 0, ICONS.HUNTER, 22442, 0, ICONS.SHAMAN, 22470, 0, ICONS.DRUID, 22494, type = 6 }, -- Desecrated Girdle
	[22359] = { ICONS.PALADIN, 22427, 0, ICONS.HUNTER, 22437, 0, ICONS.SHAMAN, 22465, 0, ICONS.DRUID, 22489, type = 6 }, -- Desecrated Legguards
	[22365] = { ICONS.PALADIN, 22430, 0, ICONS.HUNTER, 22440, 0, ICONS.SHAMAN, 22468, 0, ICONS.DRUID, 22492, type = 6 }, -- Desecrated Boots
	[22367] = { ICONS.PRIEST, 22514, 0, ICONS.MAGE ,22498, 0, ICONS.WARLOCK, 22506, type = 6 },	-- Desecrated Circlet
	[22368] = { ICONS.PRIEST, 22515, 0, ICONS.MAGE ,22499, 0, ICONS.WARLOCK, 22507, type = 6 },	-- Desecrated Shoulderpads
	[22351] = { ICONS.PRIEST, 22512, 0, ICONS.MAGE ,22496, 0, ICONS.WARLOCK, 22504, type = 6 }, -- Desecrated Robe
	[22369] = { ICONS.PRIEST, 22519, 0, ICONS.MAGE ,22503, 0, ICONS.WARLOCK, 22511, type = 6 }, -- Desecrated Bindings
	[22371] = { ICONS.PRIEST, 22517, 0, ICONS.MAGE ,22501, 0, ICONS.WARLOCK, 22509, type = 6 },	-- Desecrated Gloves
	[22370] = { ICONS.PRIEST, 22518, 0, ICONS.MAGE ,22502, 0, ICONS.WARLOCK, 22510, type = 6 },	-- Desecrated Belt
	[22366] = { ICONS.PRIEST, 22513, 0, ICONS.MAGE ,22497, 0, ICONS.WARLOCK, 22505, type = 6 }, -- Desecrated Leggings
	[22372] = { ICONS.PRIEST, 22516, 0, ICONS.MAGE ,22500, 0, ICONS.WARLOCK, 22508, type = 6 }, -- Desecrated Sandals
	[22353] = { ICONS.WARRIOR, 22418, 0, ICONS.ROGUE, 22478, type = 6 }, -- Desecrated Helmet
	[22354] = { ICONS.WARRIOR, 22419, 0, ICONS.ROGUE, 22479, type = 6 }, -- Desecrated Pauldrons
	[22349] = { ICONS.WARRIOR, 22416, 0, ICONS.ROGUE, 22476, type = 6 }, -- Desecrated Breastplate
	[22355] = { ICONS.WARRIOR, 22423, 0, ICONS.ROGUE, 22483, type = 6 }, -- Desecrated Bracers
	[22357] = { ICONS.WARRIOR, 22421, 0, ICONS.ROGUE, 22481, type = 6 }, -- Desecrated Gauntlets
	[22356] = { ICONS.WARRIOR, 22422, 0, ICONS.ROGUE, 22482, type = 6 }, -- Desecrated Waistguard
	[22352] = { ICONS.WARRIOR, 22417, 0, ICONS.ROGUE, 22477, type = 6 }, -- Desecrated Legplates
	[22358] = { ICONS.WARRIOR, 22420, 0, ICONS.ROGUE, 22480, type = 6 }, -- Desecrated Sabatons

	-- Gem Sacks
	[17962] = { 12361, 7971, 13926, {1529, "1-2"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },		-- Blue Sack of Gems
	[17963] = { 12364, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Green Sack of Gems
	[17964] = { 12800, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Gray Sack of Gems
	[17965] = { 12363, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },			-- Yellow Sack of Gems
	[17969] = { 12799, 7971, 13926, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, type = 2 },		-- Red Sack of Gems
	[11938] = {
		17962, 12361, 7971, 13926, {1529, "1-2"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
		17963, 12364, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
		17964, 12800, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
		17965, 12363, 7971, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"}, 0,
		17969, 12799, 7971, 13926, {1529, "1-3"}, {7909, "1-3"}, {7910, "1-3"}, {3864, "1-3"},
		type = 2,
	},

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
	[17771] = { 17771, 0, 18562, {12360,10}, 17010, {18567,3} }, -- Elementium Bar

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
	[20644] = { 20600, type = 3 }, -- Shrouded in Nightmare

	-- Quest objective
	[18705] = { 18713, type = 4 }, -- Mature Black Dragon Sinew
	[18704] = { 18714, type = 4 }, -- Mature Blue Dragon Sinew
	[12871] = { 12895, 0, 12903, 12945, type = 4 }, -- Chromatic Carapace
	[18706] = { {18706, 12}, 0, 19024, type = 4 }, -- Arena Master


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
				ICONS.WARLOCK, ICONS.PRIEST, ICONS.MAGE, ICONS.ROGUE, ICONS.DRUID, ICONS.HUNTER, ICONS.SHAMAN, ICONS.WARRIOR, ICONS.PALADIN, 0,
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
	[22737] = 22727, -- Atiesh / Use item

	-- UBRS key
	[12219] = { 12219, 12336, 12335, 12337, 0, 12344 }, -- Unadorned Seal of Ascension
	[12336] = 12219, -- Gemstone of Spirestone
	[12335] = 12219, -- Gemstone of Smolderthorn
	[12337] = 12219, -- Gemstone of Bloodaxe

	--- Cenarion Circle Dailies
	-- Exalted
	[21188] = { "f609rep8", 0, {20802, 15}, {20800, 20}, {20801, 20}, 21508 }, -- Fist of Cenarius
	[21180] = 21188, -- Earthstrike
	[21190] = 21188, -- Wrath of Cenarius
	-- Revered
	[21184] = { "f609rep7", 0, {20802, 15}, {20800, 20}, {20801, 17}, 21515 }, -- Deeprock Bracers
	[21186] = 21184, -- Rockfury Bracers
	[21185] = 21184, -- Earthcalm Orb
	[21189] = 21184, -- Might of Cenarius
	-- Honored
	[21181] = { "f609rep6", 0, {20802, 7}, {20800, 4}, {20801, 4} }, -- Grace of Earth
	[21183] = 21181, -- Earthpower Vest
	[21182] = 21181, -- Band of Earthen Might
	-- Friendly
	[21178] = { "f609rep5", 0, {20802, 5}, {20800, 3}, {20801, 7} }, -- Gloves of Earthen Power
	[21187] = 21178, -- Earthweave Cloak
	[21179] = 21178, -- Band of Earthen Wrath
}

if AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM) then
	TOKEN_DATA.BCC = {
		--- T4
		-- Head
		[29760] = { ICONS.PALADIN, 29061, 29068, 29073, 0, ICONS.ROGUE, 29044, 0, ICONS.SHAMAN, 29028, 29035, 29040, type = 6 }, -- Helm of the Fallen Champion
		[29761] = { ICONS.WARRIOR, 29011, 29021, 0, ICONS.PRIEST, 29049, 29058, 0, ICONS.DRUID, 29086, 29093, 29098, type = 6 }, -- Helm of the Fallen Defender
		[29759] = { ICONS.HUNTER, 29081, 0, ICONS.MAGE, 29076, 0, ICONS.WARLOCK, 28963, type = 6 }, -- Helm of the Fallen Hero
		-- Shoulder
		[29763] = { ICONS.PALADIN, 29064, 29070, 29075, 0, ICONS.ROGUE, 29047, 0, ICONS.SHAMAN, 29037, 29031, 29043, type = 6 }, -- Pauldrons of the Fallen Champion
		[29764] = { ICONS.WARRIOR, 29016, 29023, 0, ICONS.PRIEST, 29054, 29060, 0, ICONS.DRUID, 29100, 29095, 29089, type = 6 }, -- Pauldrons of the Fallen Defender
		[29762] = { ICONS.HUNTER, 29084, 0, ICONS.MAGE, 29079, 0, ICONS.WARLOCK, 28967, type = 6 }, -- Pauldrons of the Fallen Hero
		-- Chest
		[29754] = { ICONS.PALADIN, 29071, 29066, 29062, 0, ICONS.ROGUE, 29045, 0, ICONS.SHAMAN, 29038, 29033, 29029, type = 6 }, -- Chestguard of the Fallen Champion
		[29753] = { ICONS.WARRIOR, 29012, 29019, 0, ICONS.PRIEST, 29050, 29056, 0, ICONS.DRUID, 29087, 29091, 29096, type = 6 }, -- Chestguard of the Fallen Defender
		[29755] = { ICONS.HUNTER, 29082, 0, ICONS.MAGE, 29077, 0, ICONS.WARLOCK, 28964, type = 6 }, -- Chestguard of the Fallen Hero
		-- Hands
		[29757] = { ICONS.PALADIN, 29065, 29067, 29072, 0, ICONS.ROGUE, 29048, 0, ICONS.SHAMAN, 29032, 29034, 29039, type = 6 }, -- Gloves of the Fallen Champion
		[29758] = { ICONS.WARRIOR, 29017, 29020, 0, ICONS.PRIEST, 29055, 29057, 0, ICONS.DRUID, 29090, 29092, 29097, type = 6 }, -- Gloves of the Fallen Defender
		[29756] = { ICONS.HUNTER, 29085, 0, ICONS.MAGE, 29080, 0, ICONS.WARLOCK, 28968, type = 6 }, -- Gloves of the Fallen Hero
		--Legs
		[29766] = { ICONS.PALADIN, 29074, 29063, 29069, 0, ICONS.ROGUE, 29046, 0, ICONS.SHAMAN, 29030, 29036, 29042, type = 6 }, -- Leggings of the Fallen Champion
		[29767] = { ICONS.WARRIOR, 29022, 29015, 0, ICONS.PRIEST, 29059, 29053, 0, ICONS.DRUID, 29094, 29099, 29088, type = 6 }, -- Leggings of the Fallen Defender
		[29765] = { ICONS.HUNTER, 29083, 0, ICONS.MAGE, 29078, 0, ICONS.WARLOCK, 28966, type = 6 }, -- Leggings of the Fallen Hero

		--- T5
		-- Head
		[30242] = { ICONS.PALADIN, 30125, 30136, 30131, 0, ICONS.ROGUE, 30146, 0, ICONS.SHAMAN, 30166, 30171, 30190, type = 6 }, -- Helm of the Vanquished Champion
		[30243] = { ICONS.WARRIOR, 30120, 30115, 0, ICONS.PRIEST, 30161, 30152, 0, ICONS.DRUID, 30228, 30219, 30233, type = 6 }, -- Helm of the Vanquished Defender
		[30244] = { ICONS.HUNTER, 30141, 0, ICONS.MAGE, 30206, 0, ICONS.WARLOCK, 30212, type = 6 }, -- Helm of the Vanquished Hero
		-- Shoulder
		[30248] = { ICONS.PALADIN, 30127, 30133, 30138, 0, ICONS.ROGUE, 30149, 0, ICONS.SHAMAN, 30168, 30173, 30194, type = 6 }, -- Pauldrons of the Vanquished Champion
		[30249] = { ICONS.WARRIOR, 30117, 30122, 0, ICONS.PRIEST, 30154, 30163, 0, ICONS.DRUID, 30221, 30230, 30235, type = 6 }, -- Pauldrons of the Vanquished Defender
		[30250] = { ICONS.HUNTER, 30143, 0, ICONS.MAGE, 30210, 0, ICONS.WARLOCK, 30215, type = 6 }, -- Pauldrons of the Vanquished Hero
		-- Chest
		[30236] = { ICONS.PALADIN, 30123, 30129, 30134, 0, ICONS.ROGUE, 30144, 0, ICONS.SHAMAN, 30164, 30169, 30185, type = 6 }, -- Chestguard of the Vanquished Champion
		[30237] = { ICONS.WARRIOR, 30113, 30118, 0, ICONS.PRIEST, 30150, 30159, 0, ICONS.DRUID, 30216, 30222, 30231, type = 6 }, -- Chestguard of the Vanquished Defender
		[30238] = { ICONS.HUNTER, 30139, 0, ICONS.MAGE, 30196, 0, ICONS.WARLOCK, 30214, type = 6 }, -- Chestguard of the Vanquished Hero
		-- Hands
		[30239] = { ICONS.PALADIN, 30130, 30135, 30124, 0, ICONS.ROGUE, 30145, 0, ICONS.SHAMAN, 30189, 30165, 30170, type = 6 }, -- Gloves of the Vanquished Champion
		[30240] = { ICONS.WARRIOR, 30114, 30119, 0, ICONS.PRIEST, 30160, 30151, 0, ICONS.DRUID, 30223, 30217, 30232, type = 6 }, -- Gloves of the Vanquished Defender
		[30241] = { ICONS.HUNTER, 30140, 0, ICONS.MAGE, 30205, 0, ICONS.WARLOCK, 30211, type = 6 }, -- Gloves of the Vanquished Hero
		-- Legs
		[30245] = { ICONS.PALADIN, 30132, 30137, 30126, 0, ICONS.ROGUE, 30148, 0, ICONS.SHAMAN, 30172, 30167, 30192, type = 6 }, -- Leggings of the Vanquished Champion
		[30246] = { ICONS.WARRIOR, 30121, 30116, 0, ICONS.PRIEST, 30153, 30162, 0, ICONS.DRUID, 30229, 30220, 30234, type = 6 }, -- Leggings of the Vanquished Defender
		[30247] = { ICONS.HUNTER, 30142, 0, ICONS.MAGE, 30207, 0, ICONS.WARLOCK, 30213, type = 6 }, -- Leggings of the Vanquished Hero

		--- T6
		-- Head
		[31097] = { ICONS.PALADIN, 30987, 30988, 30989, 0, ICONS.PRIEST, 31063, 31064, 0, ICONS.WARLOCK, 31051, type = 6 }, -- Helm of the Forgotten Conqueror
		[31096] = { ICONS.ROGUE, 31027, 0, ICONS.MAGE, 31056, 0, ICONS.DRUID, 31037, 31040, 31039, type = 6 }, -- Helm of the Forgotten Vanquisher
		[31095] = { ICONS.WARRIOR, 30972, 30974, 0, ICONS.HUNTER, 31003, 0, ICONS.SHAMAN, 31012, 31014, 31015, type = 6 }, -- Helm of the Forgotten Protector
		-- Shoulders
		[31101] = { ICONS.PALADIN, 30996, 30997, 30998, 0, ICONS.PRIEST, 31069, 31070, 0, ICONS.WARLOCK, 31054, type = 6 }, -- Pauldrons of the Forgotten Conqueror
		[31102] = { ICONS.ROGUE, 31030, 0, ICONS.MAGE, 31059, 0, ICONS.DRUID, 31047, 31048, 31049, type = 6 }, -- Pauldrons of the Forgotten Vanquisher
		[31103] = { ICONS.WARRIOR, 30979, 30980, 0, ICONS.HUNTER, 31006, 0, ICONS.SHAMAN, 31022, 31023, 31024, type = 6 }, -- Pauldrons of the Forgotten Protector
		-- Chest
		[31089] = { ICONS.PALADIN, 30990, 30991, 30992, 0, ICONS.PRIEST, 31065, 31066, 0, ICONS.WARLOCK, 31052, type = 6 }, -- Chestguard of the Forgotten Conqueror
		[31090] = { ICONS.ROGUE, 31028, 0, ICONS.MAGE, 31057, 0, ICONS.DRUID, 31041, 31042, 31043, type = 6 }, -- Chestguard of the Forgotten Vanquisher
		[31091] = { ICONS.WARRIOR, 30975, 30976, 0, ICONS.HUNTER, 31004, 0, ICONS.SHAMAN, 31016, 31017, 31018, type = 6 }, -- Chestguard of the Forgotten Protector
		-- Hands
		[31092] = { ICONS.PALADIN, 30982, 30983, 30985, 0, ICONS.PRIEST, 31060, 31061, 0, ICONS.WARLOCK, 31050, type = 6 }, -- Gloves of the Forgotten Conqueror
		[31093] = { ICONS.ROGUE, 31026, 0, ICONS.MAGE, 31055, 0, ICONS.DRUID, 31032, 31034, 31035, type = 6 }, -- Gloves of the Forgotten Vanquisher
		[31094] = { ICONS.WARRIOR, 30969, 30970, 0, ICONS.HUNTER, 31001, 0, ICONS.SHAMAN, 31007, 31008, 31011, type = 6 }, -- Gloves of the Forgotten Protector
		-- Legs
		[31098] = { ICONS.PALADIN, 30993, 30994, 30995, 0, ICONS.PRIEST, 31067, 31068, 0, ICONS.WARLOCK, 31053, type = 6 }, -- Leggings of the Forgotten Conqueror
		[31099] = { ICONS.ROGUE, 31029, 0, ICONS.MAGE, 31058, 0, ICONS.DRUID, 31044, 31045, 31046, type = 6 }, -- Leggings of the Forgotten Vanquisher
		[31100] = { ICONS.WARRIOR, 30977, 30978, 0, ICONS.HUNTER, 31005, 0, ICONS.SHAMAN, 31019, 31020, 31021, type = 6 }, -- Leggings of the Forgotten Protector
		-- Wrist
		[34848] = { ICONS.PALADIN, 34431, 34432, 34433, 0, ICONS.PRIEST, 34434, 34435, 0, ICONS.WARLOCK, 34436, type = 6 }, -- Bracers of the Forgotten Conqueror
		[34852] = { ICONS.ROGUE, 34448, 0, ICONS.MAGE, 34447, 0, ICONS.DRUID, 34444, 34445, 34446, type = 6 }, -- Bracers of the Forgotten Vanquisher
		[34851] = { ICONS.WARRIOR, 34441, 34442, 0, ICONS.HUNTER, 34443, 0, ICONS.SHAMAN, 34437, 34438, 34439, type = 6 }, -- Bracers of the Forgotten Protector
		-- Belt
		[34853] = { ICONS.PALADIN, 34485, 34487, 34488, 0, ICONS.PRIEST, 34527, 34528, 0, ICONS.WARLOCK, 34541, type = 6 }, -- Belt of the Forgotten Conqueror
		[34855] = { ICONS.ROGUE, 34558, 0, ICONS.MAGE, 34557, 0, ICONS.DRUID, 34554, 34555, 34556, type = 6 }, -- Belt of the Forgotten Vanquisher
		[34854] = { ICONS.WARRIOR, 34546, 34547, 0, ICONS.HUNTER, 34549, 0, ICONS.SHAMAN, 34542, 34543, 34545, type = 6 }, -- Belt of the Forgotten Protector
		-- Boots
		[34856] = { ICONS.PALADIN, 34559, 34560, 34561, 0, ICONS.PRIEST, 34562, 34563, 0, ICONS.WARLOCK, 34564, type = 6 }, -- Boots of the Forgotten Conqueror
		[34858] = { ICONS.ROGUE, 34575, 0, ICONS.MAGE, 34574, 0, ICONS.DRUID, 34571, 34572, 34573, type = 6 }, -- Boots of the Forgotten Vanquisher
		[34857] = { ICONS.WARRIOR, 34568, 34569, 0, ICONS.HUNTER, 34570, 0, ICONS.SHAMAN, 34565, 34566, 34567, type = 6 }, -- Boots of the Forgotten Protector

		--- Sunwell Sunmote tokens
		-- Cloth
		[34399] = { 34399, 0, {34664, "1"}, {34233, "1"}, type = 7 }, -- Robes of Ghostly Hatred
		[34233] = { 34399, 0, {34664, "1"}, {34233, "1"}, type = 8 }, -- Robes of Faltered Light
		[34406] = { 34406, 0, {34664, "1"}, {34342, "1"}, type = 7 }, -- Gloves of Tyri's Power
		[34342] = { 34406, 0, {34664, "1"}, {34342, "1"}, type = 8 }, -- Handguards of the Dawn
		[34405] = { 34405, 0, {34664, "1"}, {34339, "1"}, type = 7 }, -- Helm of Arcane Purity
		[34339] = { 34405, 0, {34664, "1"}, {34339, "1"}, type = 8 }, -- Cowl of Light's Purity
		[34386] = { 34386, 0, {34664, "1"}, {34170, "1"}, type = 7 }, -- Pantaloons of Growing Strife
		[34170] = { 34386, 0, {34664, "1"}, {34170, "1"}, type = 8 }, -- Pantaloons of Calming Strife
		[34393] = { 34393, 0, {34664, "1"}, {34202, "1"}, type = 7 }, -- Shoulderpads of Knowledge's Pursuit
		[34202] = { 34393, 0, {34664, "1"}, {34202, "1"}, type = 8 }, -- Shawl of Wonderment

		-- Leather
		[34397] = { 34397, 0, {34664, "1"}, {34211, "1"}, type = 7 }, -- Bladed Chaos Tunic
		[34211] = { 34397, 0, {34664, "1"}, {34211, "1"}, type = 8 }, -- Harness of Carnal Instinct
		[34398] = { 34398, 0, {34664, "1"}, {34212, "1"}, type = 7 }, -- Utopian Tunic of Elune
		[34212] = { 34398, 0, {34664, "1"}, {34212, "1"}, type = 8 }, -- Sunglow Vest
		[34408] = { 34408, 0, {34664, "1"}, {34234, "1"}, type = 7 }, -- Gloves of the Forest Drifter
		[34234] = { 34408, 0, {34664, "1"}, {34234, "1"}, type = 8 }, -- Shadowed Gauntlets of Paroxysm
		[34407] = { 34407, 0, {34664, "1"}, {34351, "1"}, type = 7 }, -- Tranquil Moonlight Wraps
		[34351] = { 34407, 0, {34664, "1"}, {34351, "1"}, type = 8 }, -- Tranquil Majesty Wraps
		[34403] = { 34403, 0, {34664, "1"}, {34245, "1"}, type = 7 }, -- Cover of Ursoc the Mighty
		[34245] = { 34403, 0, {34664, "1"}, {34245, "1"}, type = 8 }, -- Cover of Ursol the Wise
		[34404] = { 34404, 0, {34664, "1"}, {34244, "1"}, type = 7 }, -- Mask of the Fury Hunter
		[34244] = { 34404, 0, {34664, "1"}, {34244, "1"}, type = 8 }, -- Duplicitous Guise
		[34384] = { 34384, 0, {34664, "1"}, {34169, "1"}, type = 7 }, -- Breeches of Natural Splendor
		[34169] = { 34384, 0, {34664, "1"}, {34169, "1"}, type = 8 }, -- Breeches of Natural Aggression
		[34385] = { 34385, 0, {34664, "1"}, {34188, "1"}, type = 7 }, -- Leggings of the Immortal Beast
		[34188] = { 34385, 0, {34664, "1"}, {34188, "1"}, type = 8 }, -- Leggings of the Immortal Night
		[34392] = { 34392, 0, {34664, "1"}, {34195, "1"}, type = 7 }, -- Demontooth Shoulderpads
		[34195] = { 34392, 0, {34664, "1"}, {34195, "1"}, type = 8 }, -- Shoulderpads of Vehemence
		[34391] = { 34391, 0, {34664, "1"}, {34209, "1"}, type = 7 }, -- Spaulders of Devastation
		[34209] = { 34391, 0, {34664, "1"}, {34209, "1"}, type = 8 }, -- Spaulders of Reclamation

		-- Mail
		[34402] = { 34402, 0, {34664, "1"}, {34332, "1"}, type = 7 }, -- Cover of Ursoc the Mighty
		[34332] = { 34402, 0, {34664, "1"}, {34332, "1"}, type = 8 }, -- Cowl of Gul'dan
		[34396] = { 34396, 0, {34664, "1"}, {34229, "1"}, type = 7 }, -- Garments of Crashing Shores
		[34229] = { 34396, 0, {34664, "1"}, {34229, "1"}, type = 8 }, -- Garments of Serene Shores
		[34390] = { 34390, 0, {34664, "1"}, {34208, "1"}, type = 7 }, -- Erupting Epaulets
		[34208] = { 34390, 0, {34664, "1"}, {34208, "1"}, type = 8 }, -- Equilibrium Epaulets
		[34409] = { 34409, 0, {34664, "1"}, {34350, "1"}, type = 7 }, -- Gauntlets of the Ancient Frostwolf
		[34350] = { 34409, 0, {34664, "1"}, {34350, "1"}, type = 8 }, -- Gauntlets of the Ancient Shadowmoon
		[34383] = { 34383, 0, {34664, "1"}, {34186, "1"}, type = 7 }, -- Kilt of Spiritual Reconstruction
		[34186] = { 34383, 0, {34664, "1"}, {34186, "1"}, type = 8 }, -- Chain Links of the Tumultuous Storm

		-- Plate
		[34401] = { 34401, 0, {34664, "1"}, {34243, "1"}, type = 7 }, -- Helm of Uther's Resolve
		[34243] = { 34401, 0, {34664, "1"}, {34243, "1"}, type = 8 }, -- Helm of Burning Righteousness
		[34400] = { 34400, 0, {34664, "1"}, {34345, "1"}, type = 7 }, -- Crown of Dath'Remar
		[34345] = { 34400, 0, {34664, "1"}, {34345, "1"}, type = 8 }, -- Crown of Anasterian
		[34389] = { 34389, 0, {34664, "1"}, {34193, "1"}, type = 7 }, -- Spaulders of the Thalassian Defender
		[34193] = { 34389, 0, {34664, "1"}, {34193, "1"}, type = 8 }, -- Spaulders of the Thalassian Savior
		[34388] = { 34388, 0, {34664, "1"}, {34192, "1"}, type = 7 }, -- Pauldrons of Berserking
		[34192] = { 34388, 0, {34664, "1"}, {34192, "1"}, type = 8 }, -- Pauldrons of Perseverance
		[34395] = { 34395, 0, {34664, "1"}, {34216, "1"}, type = 7 }, -- Noble Judicator's Chestguard
		[34216] = { 34395, 0, {34664, "1"}, {34216, "1"}, type = 8 }, -- Heroic Judicator's Chestguard
		[34394] = { 34394, 0, {34664, "1"}, {34215, "1"}, type = 7 }, -- Breastplate of Agony's Aversion
		[34215] = { 34394, 0, {34664, "1"}, {34215, "1"}, type = 8 }, -- Warharness of Reckless Fury
		[34382] = { 34382, 0, {34664, "1"}, {34167, "1"}, type = 7 }, -- Judicator's Legguards
		[34167] = { 34382, 0, {34664, "1"}, {34167, "1"}, type = 8 }, -- Legplates of the Holy Juggernaut
		[34381] = { 34381, 0, {34664, "1"}, {34180, "1"}, type = 7 }, -- Felstrength Legplates
		[34180] = { 34381, 0, {34664, "1"}, {34180, "1"}, type = 8 }, -- Felfury Legplates


		--- Misc
		-- Magtheridon's Lair
		[32385] = { 28791, 28790, 28793, 28792, type = 3 }, -- Magtheridon's Head
		[34846] = { -- Black Sack of Gems
			{32230,"1-3"}, {32249,"1-3"}, {32228,"1-3"}, {32229,"1-3"}, {32231,"1-3"}, {32227,"1-3"}, 0, -- Epic
			{23441,"1-2"}, {23437,"1-2"}, {23436,"1-2"}, {23438,"1-2"}, {23440,"1-2"}, {23439,"1-2"}, -- Blue
			type = 2,
		},
		-- Tempest Keep
		[32405] = { 30018, 30017, 30007, 30015 }, -- Verdant Sphere

		-- Motes
		[22574] = { {22574,"10"}, 0, 21884 }, -- Mote of Fire
		[22576] = { {22576,"10"}, 0, 22457 }, -- Mote of Mana
		[22573] = { {22573,"10"}, 0, 22452 }, -- Mote of Earth
		[22572] = { {22572,"10"}, 0, 22451 }, -- Mote of Air
		[22575] = { {22575,"10"}, 0, 21886 }, -- Mote of Life
		[22578] = { {22578,"10"}, 0, 21885 }, -- Mote of Water

		--- Darkmoon cards
		-- Furies Deck / Darkmoon Card: Vengeance
		[31907] = { 31907, 31858, 0, 31901, 31909, 31908, 31904, 31903, 31906, 31905, 31902 },
		[31901] = 31907, [31909] = 31907, [31908] = 31907, [31904] = 31907, [31903] = 31907, [31906] = 31907, [31905] = 31907, [31902] = 31907,

		-- Blessings Deck / Darkmoon Card: Crusade
		[31890] = { 31890, 31856, 0, 31882, 31889, 31888, 31885, 31884, 31887, 31886, 31883 },
		[31882] = 31890, [31889] = 31890, [31888] = 31890, [31885] = 31890, [31884] = 31890, [31887] = 31890, [31886] = 31890, [31883] = 31890,

		-- Storms Deck / Darkmoon Card: Wrath
		[31891] = { 31891, 31857, 0, 31892, 31900, 31899, 31895, 31894, 31898, 31896, 31893 },
		[31892] = 31891, [31900] = 31891, [31899] = 31891, [31899] = 31891, [31895] = 31891, [31898] = 31891, [31896] = 31891, [31893] = 31891,

		-- Lunacy Deck / Darkmoon Card: Madness
		[31914] = { 31914, 31859, 0, 31910, 31918, 31917, 31913, 31912, 31916, 31915, 31911 },
		[31910] = 31914, [31918] = 31914, [31917] = 31914, [31913] = 31914, [31912] = 31914, [31916] = 31914, [31915] = 31914, [31911] = 31914,

		-- Brewfest
		[33016] = { 33017, 33018, 33019, 33020, 33021 }, -- Blue Brewfest Stein
		[32912] = { 32917, 32918, 32920, 32915, 32919 }, -- Yellow Brewfest Stein
	}
end

if AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM) then
	TOKEN_DATA.WRATH = {
		-- The Oculus
		[52676] = {{47241,"2"}, 43953, 0,
			{36918,"1-3"}, {36921,"1-3"}, {36924,"1-3"}, {36927,"1-3"}, {36930,"1-3"}, {36933,"1-3"}, type = 2
		}, -- Cache of the Ley-Guardian

		-- Battered Hilt
		[50380] = {50047, 50046, 50049, 50048, type = 3}, -- horde
		[50379] = 50380, -- alli

		-- Key to the Focusing Iris
		[44569] = {44582, type = 3}, -- 10man
		[44577] = {44581, type = 3}, -- 25man

		-- Heart of Magic / Malygos
		[44650] = {44658, 44657, 44659, 44660, type = 3}, -- 10man
		[44651] = {44661, 44662, 44664, 44665, type = 3}, -- 25man

		--- T7 / 10Man
		-- Head
		[40616] = { ICONS.PALADIN, 39628, 39635, 39640, 0, ICONS.PRIEST, 39514, 39521, 0, ICONS.WARLOCK, 39496, type = 6}, -- Helm of the Lost Conqueror
		[40617] = { ICONS.WARRIOR, 39605, 39610, 0, ICONS.HUNTER, 39578, 0, ICONS.SHAMAN, 39583, 39594, 39602, type = 6}, -- Helm of the Lost Protector
		[40618] = { ICONS.ROGUE, 39561, 0, ICONS.DEATHKNIGHT, 39619, 39625, 0, ICONS.MAGE, 39491, 0, ICONS.DRUID, 39531, 39545, 39553, type = 6}, -- Helm of the Lost Vanquisher
		-- Shoulders
		[40622] = { ICONS.PALADIN, 39631, 39637, 39642, 0, ICONS.PRIEST, 39518, 39529, 0, ICONS.WARLOCK, 39499, type = 6}, -- Spaulders of the Lost Conqueror
		[40623] = { ICONS.WARRIOR, 39608, 39613, 0, ICONS.HUNTER, 39581, 0, ICONS.SHAMAN, 39590, 39596, 39604, type = 6}, -- Spaulders of the Lost Protector
		[40624] = { ICONS.ROGUE, 39565, 0, ICONS.DEATHKNIGHT, 39621, 39627, 0, ICONS.MAGE, 39494, 0, ICONS.DRUID, 39542, 39548, 39556, type = 6}, -- Spaulders of the Lost Vanquisher
		-- Chest
		[40610] = { ICONS.PALADIN, 39629, 39633, 39638, 0, ICONS.PRIEST, 39515, 39523, 0, ICONS.WARLOCK, 39497, type = 6}, -- Chestguard of the Lost Conqueror
		[40611] = { ICONS.WARRIOR, 39606, 39611, 0, ICONS.HUNTER, 39579, 0, ICONS.SHAMAN, 39588, 39592, 39597, type = 6}, -- Chestguard of the Lost Protector
		[40612] = { ICONS.ROGUE, 39558, 0, ICONS.DEATHKNIGHT, 39617, 39623, 0, ICONS.MAGE, 39492, 0, ICONS.DRUID, 39538, 39547, 39554, type = 6}, -- Chestguard of the Lost Vanquisher
		-- Hands
		[40613] = { ICONS.PALADIN, 39632, 39634, 39639, 0, ICONS.PRIEST, 39519, 39530, 0, ICONS.WARLOCK, 39500, type = 6}, -- Gloves of the Lost Conqueror
		[40614] = { ICONS.WARRIOR, 39609, 39622, 0, ICONS.HUNTER, 39582, 0, ICONS.SHAMAN, 39591, 39593, 39601, type = 6}, -- Gloves of the Lost Protector
		[40615] = { ICONS.ROGUE, 39560, 0, ICONS.DEATHKNIGHT, 39618, 39624, 0, ICONS.MAGE, 39495, 0, ICONS.DRUID, 39543, 39544, 39557, type = 6}, -- Gloves of the Lost Vanquisher
		-- Leggings
		[40619] = { ICONS.PALADIN, 39630, 39636, 39641, 0, ICONS.PRIEST, 39517, 39528, 0, ICONS.WARLOCK, 39498, type = 6}, -- Leggings of the Lost Conqueror
		[40620] = { ICONS.WARRIOR, 39607, 39612, 0, ICONS.HUNTER, 39580, 0, ICONS.SHAMAN, 39589, 39595, 39603, type = 6}, -- Leggings of the Lost Protector
		[40621] = { ICONS.ROGUE, 39564, 0, ICONS.DEATHKNIGHT, 39620, 39626, 0, ICONS.MAGE, 39493, 0, ICONS.DRUID, 39539, 39546, 39555, type = 6}, -- Leggings of the Lost Vanquisher

		--- T7 / 25Man
		-- Head
		[40631] = { ICONS.PALADIN, 40571, 40576, 40581, 0, ICONS.PRIEST, 40447, 40456, 0, ICONS.WARLOCK, 40421, type = 6}, -- Crown of the Lost Conqueror
		[40632] = { ICONS.WARRIOR, 40528, 40546, 0, ICONS.HUNTER, 40505, 0, ICONS.SHAMAN, 40510, 40516, 40521, type = 6}, -- Crown of the Lost Protector
		[40633] = { ICONS.ROGUE, 40499, 0, ICONS.DEATHKNIGHT, 40554, 40565, 0, ICONS.MAGE, 40416, 0, ICONS.DRUID, 40461, 40467, 40473, type = 6}, -- Crown of the Lost Vanquisher
		-- Shoulders
		[40637] = { ICONS.PALADIN, 40573, 40578, 40584, 0, ICONS.PRIEST, 40450, 40459, 0, ICONS.WARLOCK, 40424, type = 6}, -- Mantle of the Lost Conqueror
		[40638] = { ICONS.WARRIOR, 40530, 40548, 0, ICONS.HUNTER, 40507, 0, ICONS.SHAMAN, 40513, 40518, 40524, type = 6}, -- Mantle of the Lost Protector
		[40639] = { ICONS.ROGUE, 40502, 0, ICONS.DEATHKNIGHT, 40557, 40568, 0, ICONS.MAGE, 40419, 0, ICONS.DRUID, 40465, 40470, 40494, type = 6}, -- Mantle of the Lost Vanquisher
		-- Chest
		[40625] = { ICONS.PALADIN, 40569, 40574, 40579, 0, ICONS.PRIEST, 40449, 40458, 0, ICONS.WARLOCK, 40423, type = 6}, -- Breastplate of the Lost Conqueror
		[40626] = { ICONS.WARRIOR, 40525, 40544, 0, ICONS.HUNTER, 40503, 0, ICONS.SHAMAN, 40508, 40514, 40523, type = 6}, -- Breastplate of the Lost Protector
		[40627] = { ICONS.ROGUE, 40495, 0, ICONS.DEATHKNIGHT, 40550, 40559, 0, ICONS.MAGE, 40418, 0, ICONS.DRUID, 40463, 40469, 40471, type = 6}, -- Breastplate of the Lost Vanquisher
		-- Hands
		[40628] = { ICONS.PALADIN, 40570, 40575, 40580, 0, ICONS.PRIEST, 40445, 40454, 0, ICONS.WARLOCK, 40420, type = 6}, -- Gauntlets of the Lost Conqueror
		[40629] = { ICONS.WARRIOR, 40527, 40545, 0, ICONS.HUNTER, 40504, 0, ICONS.SHAMAN, 40509, 40515, 40520, type = 6}, -- Gauntlets of the Lost Protector
		[40630] = { ICONS.ROGUE, 40496, 0, ICONS.DEATHKNIGHT, 40552, 40563, 0, ICONS.MAGE, 40415, 0, ICONS.DRUID, 40460, 40466, 40472, type = 6}, -- Gauntlets of the Lost Vanquisher
		-- Leggings
		[40634] = { ICONS.PALADIN, 40572, 40577, 40583, 0, ICONS.PRIEST, 40448, 40457, 0, ICONS.WARLOCK, 40422, type = 6}, -- Legplates of the Lost Conqueror
		[40635] = { ICONS.WARRIOR, 40529, 40547, 0, ICONS.HUNTER, 40506, 0, ICONS.SHAMAN, 40512, 40517, 40522, type = 6}, -- Legplates of the Lost Protector
		[40636] = { ICONS.ROGUE, 40500, 0, ICONS.DEATHKNIGHT, 40556, 40567, 0, ICONS.MAGE, 40417, 0, ICONS.DRUID, 40462, 40468, 40493, type = 6}, -- Legplates of the Lost Vanquisher

		--- T8 / 10Man
		-- Head
		[45647] = { ICONS.PALADIN, 45372, 45377, 45382, 0, ICONS.PRIEST, 45386, 45391, 0, ICONS.WARLOCK, 45417, type = 6}, -- Helm of the Wayward Conqueror
		[45648] = { ICONS.WARRIOR, 45425, 45431, 0, ICONS.HUNTER, 45361, 0, ICONS.SHAMAN, 45402, 45408, 45412, type = 6}, -- Helm of the Wayward Protector
		[45649] = { ICONS.ROGUE, 45398, 0, ICONS.DEATHKNIGHT, 45336, 45342, 0, ICONS.MAGE, 45365, 0, ICONS.DRUID, 45346, 45356, 46313, type = 6}, -- Helm of the Wayward Vanquisher
		-- Shoulders
		[45659] = { ICONS.PALADIN, 45373, 45380, 45385, 0, ICONS.PRIEST, 45390, 45393, 0, ICONS.WARLOCK, 45422, type = 6}, -- Spaulders of the Wayward Conqueror
		[45660] = { ICONS.WARRIOR, 45428, 45433, 0, ICONS.HUNTER, 45363, 0, ICONS.SHAMAN, 45404, 45410, 45415, type = 6}, -- Spaulders of the Wayward Protector
		[45661] = { ICONS.ROGUE, 45400, 0, ICONS.DEATHKNIGHT, 45339, 45344, 0, ICONS.MAGE, 45369, 0, ICONS.DRUID, 45349, 45352, 45359, type = 6}, -- Spaulders of the Wayward Vanquisher
		-- Chest
		[45635] = { ICONS.PALADIN, 45374, 45375, 45381, 0, ICONS.PRIEST, 45389, 45395, 0, ICONS.WARLOCK, 45421, type = 6}, -- Chestguard of the Wayward Conqueror
		[45636] = { ICONS.WARRIOR, 45424, 45429, 0, ICONS.HUNTER, 45364, 0, ICONS.SHAMAN, 45405, 45411, 45413, type = 6}, -- Chestguard of the Wayward Protector
		[45637] = { ICONS.ROGUE, 45396, 0, ICONS.DEATHKNIGHT, 45335, 45340, 0, ICONS.MAGE, 45368, 0, ICONS.DRUID, 45348, 45354, 45358, type = 6}, -- Chestguard of the Wayward Vanquisher
		-- Hands
		[45644] = { ICONS.PALADIN, 45370, 45376, 45383, 0, ICONS.PRIEST, 45387, 45392, 0, ICONS.WARLOCK, 45419, type = 6}, -- Gloves of the Wayward Conqueror
		[45645] = { ICONS.WARRIOR, 45426, 45430, 0, ICONS.HUNTER, 45360, 0, ICONS.SHAMAN, 45401, 45406, 45414, type = 6}, -- Gloves of the Wayward Protector
		[45646] = { ICONS.ROGUE, 45397, 0, ICONS.DEATHKNIGHT, 45337, 45341, 0, ICONS.MAGE, 46131, 0, ICONS.DRUID, 45345, 45351, 45355, type = 6}, -- Gloves of the Wayward Vanquisher
		-- Leggings
		[45650] = { ICONS.PALADIN, 45371, 45379, 45384, 0, ICONS.PRIEST, 45388, 45394, 0, ICONS.WARLOCK, 45420, type = 6}, -- Leggings of the Wayward Conqueror
		[45651] = { ICONS.WARRIOR, 45427, 45432, 0, ICONS.HUNTER, 45362, 0, ICONS.SHAMAN, 45403, 45409, 45416, type = 6}, -- Leggings of the Wayward Protector
		[45652] = { ICONS.ROGUE, 45399, 0, ICONS.DEATHKNIGHT, 45338, 45343, 0, ICONS.MAGE, 45367, 0, ICONS.DRUID, 45347, 45353, 45357, type = 6}, -- Leggings of the Wayward Vanquisher

		--- T8 / 25Man
		-- Head
		[45638] = { ICONS.PALADIN, 46156, 46175, 46180, 0, ICONS.PRIEST, 46172, 46197, 0, ICONS.WARLOCK, 46140, type = 6}, -- Crown of the Wayward Conqueror
		[45639] = { ICONS.WARRIOR, 46151, 46166, 0, ICONS.HUNTER, 46143, 0, ICONS.SHAMAN, 46201, 46209, 46212, type = 6}, -- Crown of the Wayward Protector
		[45640] = { ICONS.ROGUE, 46125, 0, ICONS.DEATHKNIGHT, 46115, 46120, 0, ICONS.MAGE, 46129, 0, ICONS.DRUID, 46161, 46184, 46191, type = 6}, -- Crown of the Wayward Vanquisher
		-- Shoulders
		[45656] = { ICONS.PALADIN, 46152, 46177, 46182, 0, ICONS.PRIEST, 46165, 46190, 0, ICONS.WARLOCK, 46136, type = 6}, -- Mantle of the Wayward Conqueror
		[45657] = { ICONS.WARRIOR, 46149, 46167, 0, ICONS.HUNTER, 46145, 0, ICONS.SHAMAN, 46203, 46204, 46211, type = 6}, -- Mantle of the Wayward Protector
		[45658] = { ICONS.ROGUE, 46127, 0, ICONS.DEATHKNIGHT, 46117, 46122, 0, ICONS.MAGE, 46134, 0, ICONS.DRUID, 46157, 46187, 46196, type = 6}, -- Mantle of the Wayward Vanquisher
		-- Chest
		[45632] = { ICONS.PALADIN, 46154, 46173, 46178, 0, ICONS.PRIEST, 46168, 46193, 0, ICONS.WARLOCK, 46137, type = 6}, -- Breastplate of the Wayward Conqueror
		[45633] = { ICONS.WARRIOR, 46146, 46162, 0, ICONS.HUNTER, 46141, 0, ICONS.SHAMAN, 46198, 46205, 46206, type = 6}, -- Breastplate of the Wayward Protector
		[45634] = { ICONS.ROGUE, 46123, 0, ICONS.DEATHKNIGHT, 46111, 46118, 0, ICONS.MAGE, 46130, 0, ICONS.DRUID, 46159, 46186, 46194, type = 6}, -- Breastplate of the Wayward Vanquisher
		-- Hands
		[45641] = { ICONS.PALADIN, 46155, 46174, 46179, 0, ICONS.PRIEST, 46163, 46188, 0, ICONS.WARLOCK, 46135, type = 6}, -- Gauntlets of the Wayward Conqueror
		[45642] = { ICONS.WARRIOR, 46148, 46164, 0, ICONS.HUNTER, 46142, 0, ICONS.SHAMAN, 46199, 46200, 46207, type = 6}, -- Gauntlets of the Wayward Protector
		[45643] = { ICONS.ROGUE, 46124, 0, ICONS.DEATHKNIGHT, 46113, 46119, 0, ICONS.MAGE, 46132, 0, ICONS.DRUID, 46158, 46183, 46189, type = 6}, -- Gauntlets of the Wayward Vanquisher
		-- Leggings
		[45653] = { ICONS.PALADIN, 46153, 46176, 46181, 0, ICONS.PRIEST, 46170, 46195, 0, ICONS.WARLOCK, 46139, type = 6}, -- Legplates of the Wayward Conqueror
		[45654] = { ICONS.WARRIOR, 46150, 46169, 0, ICONS.HUNTER, 46144, 0, ICONS.SHAMAN, 46202, 46208, 46210, type = 6}, -- Legplates of the Wayward Protector
		[45655] = { ICONS.ROGUE, 46126, 0, ICONS.DEATHKNIGHT, 46116, 46121, 0, ICONS.MAGE, 46133, 0, ICONS.DRUID, 46160, 46185, 46192, type = 6}, -- Legplates of the Wayward Vanquisher

		--- ## WrathOnyxiasLair
		[49644] = {49485, 49486, 49487, type = 3}, -- Head of Onyxia
		[49294] = { {36919, "1-2"}, {36922, "1-3"}, {36931, "1-3"}, {36928, "1-3"}, {36934, "1-3"}, {36925, "1-3"}, type = 2 },	-- Ashen Sack of Gems
		["WrathOnyxiaClassItems10"] = {
			ICONS.WARLOCK, 49315, 0, ICONS.PRIEST, 49316, 49317, 0, ICONS.MAGE, 49318, 0,
			ICONS.ROGUE, 49322, 0, ICONS.DRUID, 49327, 49328, 49326, 0,
			ICONS.HUNTER, 49319, 0, ICONS.SHAMAN, 49331, 49330, 49329, 0,
			ICONS.WARRIOR, 49320, 49321, 0, ICONS.PALADIN, 49323, 49325, 49324, 0, ICONS.DEATHKNIGHT, 49333, 49332,
			type = 9
		},
		["WrathOnyxiaClassItems25"] = {
			ICONS.WARLOCK, 49484, 0, ICONS.PRIEST, 49482, 49483, 0, ICONS.MAGE, 49481, 0,
			ICONS.ROGUE, 49477, 0, ICONS.DRUID, 49472, 49473, 49471, 0,
			ICONS.HUNTER, 49480, 0, ICONS.SHAMAN, 49469, 49468, 49470, 0,
			ICONS.WARRIOR, 49479, 49478, 0, ICONS.PALADIN, 49476, 49475, 49474, 0, ICONS.DEATHKNIGHT, 49467, 49466,
			type = 9
		},

		--- ## Ulduar
		[45038] = { { 45038, 30 }, 45039, 45896, 0, 46017 }, -- Fragment of Val'anyr
		[45039] = 45038, -- Shattered Fragments of Val'anyr
		[45896] = 45038, -- Unbound Fragments of Val'anyr
		[46017] = 45038, -- Val'anyr, Hammer of Ancient Kings

		[46052] = { 46320, 46321, 46322, 46323, type = 3 }, -- Reply-Code Alpha / 10man
		[46053] = { 45588, 45618, 45608, 45614, type = 3 }, -- Reply-Code Alpha / 25man

		--- Algalon Key
		-- 10 man
		[45796] = { 45788, 45786, 45787, 45784, 0, 45796, type = 4 }, -- Celestial Planetarium Key / 10man
		[45788] = 45796, [45786] = 45796, [45787] = 45796, [45784] = 45796,
		-- 25 man
		[45798] = { 45814, 45815, 45816, 45817, 0, 45798, type = 4 }, -- Celestial Planetarium Key / 25man
		[45814] = 45798, [45815] = 45798, [45816] = 45798, [45817] = 45798,

		["AC_UlduarFlameLeviathan10"] = {"ac2913", "ac2914", "ac2915", "ac3056", 0, "ac2911", "ac2909", "ac2907", "ac2905", type = 10},
		["AC_UlduarFlameLeviathan25"] = {"ac2918", "ac2916", "ac2917", "ac3057", 0, "ac2912", "ac2910", "ac2908", "ac2906", type = 10},

		["AC_UlduarXTDeconstructor10"] = {"ac3058", "ac2937", "ac2931", "ac2934", "ac2933", type = 10},
		["AC_UlduarXTDeconstructor25"] = {"ac3059", "ac2938", "ac2932", "ac2936", "ac2935", type = 10},

		["AC_UlduarCouncil10"] = {"ac2945", "ac2947", "ac2939", "ac2941", "ac2940", type = 10},
		["AC_UlduarCouncil25"] = {"ac2946", "ac2948", "ac2942", "ac2944", "ac2943", type = 10},

		["AC_UlduarFreya10"] = {"ac2980", "ac2985", "ac2982", "ac2979", 0, "ac3177", "ac3178", "ac3179", type = 10},
		["AC_UlduarFreya25"] = {"ac2981", "ac2984", "ac2983", "ac3118", 0, "ac3185", "ac3186", "ac3187", type = 10},

		["AC_UlduarHodir10"] = {"ac2961", "ac2967", "ac3182", "ac2963", "ac2969", type = 10},
		["AC_UlduarHodir25"] = {"ac2962", "ac2968", "ac3184", "ac2965", "ac2970", type = 10},

		["AC_UlduarYoggSaron10"] = {"ac3159", "ac3158", "ac3141", "ac3157", "ac3008", 0, "ac3012", "ac3015", "ac3009", "ac3014", type = 10},
		["AC_UlduarYoggSaron25"] = {"ac3164", "ac3163", "ac3162", "ac3161", "ac3010", 0, "ac3013", "ac3016", "ac3011", "ac3017", type = 10},

		--- ## ICC
		[50274] = { {50274,"50"}, {49908,"25"}, 49869, 50226, 50231, 0, 49888, 49623, 0, 51315, 52200, 52201, 52251, 52252, 52253 }, -- Shadowfrost Shard
		[49869] = 50274, -- Light's Vengeance
		[50226] = 50274, -- Festergut's Acidic Blood
		[50231] = 50274, -- Rotface's Acidic Blood
		[49623] = 50274, -- Shadowmourne
		[51315] = 50274, -- Sealed Chest
		[52200] = 50274, -- Reins of the Crimson Deathcharger
		[52201] = 50274, -- Muradin's Favor
		[52251] = 50274, -- Jaina's Locket
		[52252] = 50274, -- Tabard of the Lightbringer
		[52253] = 50274, -- Sylvanas' Music Box


		--- ## VaultofArchavon
		--- Archavon the Stone Watcher
		-- Warlock
		["VoA_A_WARLOCK_10"] = {39497, 39500, 39498, 0, 42001, 42015, 42003, type = 9},
		["VoA_A_WARLOCK_25"] = {40423, 40420, 40422, 0, 41997, 42016, 42004, type = 9},
		-- Priest
		["VoA_A_PRIEST_10_H"] = {39515, 39519, 39517, 0, 41857, 41872, 41862, type = 9},
		["VoA_A_PRIEST_10_D"] = {39523, 39530, 39528, 0, 41919, 41938, 41925, type = 9},
		["VoA_A_PRIEST_25_H"] = {40449, 40445, 40448, 0, 41858, 41873, 41863, type = 9},
		["VoA_A_PRIEST_25_D"] = {40458, 40454, 40457, 0, 41920, 41939, 41926, type = 9},
		-- Rogue
		["VoA_A_ROGUE_10"] = {39558, 39560, 39564, 0, 41648, 41765, 41653, type = 9},
		["VoA_A_ROGUE_25"] = {40495, 40496, 40500, 0, 41649, 41766, 41654, type = 9},
		-- Hunter
		["VoA_A_HUNTER_10"] = {39579, 39582, 39580, 0, 41085, 41141, 41203, type = 9},
		["VoA_A_HUNTER_25"] = {40503, 40504, 40506, 0, 41086, 41142, 41204, type = 9},
		-- Warrior
		["VoA_A_WARRIOR_10_D"] = {39606, 39609, 39607, 0, 40783, 40801, 40840, type = 9},
		["VoA_A_WARRIOR_10_T"] = {39611, 39622, 39612, type = 9},
		["VoA_A_WARRIOR_25_D"] = {40525, 40527, 40529, 0, 40786, 40804, 40844, type = 9},
		["VoA_A_WARRIOR_25_T"] = {40544, 40545, 40547, type = 9},
		-- Deathknight
		["VoA_A_DEATHKNIGHT_10_D"] = {39617, 39618, 39620, 0, 40781, 40803, 40841, type = 9},
		["VoA_A_DEATHKNIGHT_10_T"] = {39623, 39624, 39626, type = 9},
		["VoA_A_DEATHKNIGHT_25_D"] = {40550, 40552, 40556, 0, 40784, 40806, 40845, type = 9},
		["VoA_A_DEATHKNIGHT_25_T"] = {40559, 40563, 40567, type = 9},
		-- Mage
		["VoA_A_MAGE_10"] = {39492, 39495, 39493, 0, 41950, 41969, 41957, type = 9},
		["VoA_A_MAGE_25"] = {40418, 40415, 40417, 0, 41951, 41970, 41958, type = 9},
		-- Druid
		["VoA_A_DRUID_10_DR"] = {39547, 39544, 39546, 0, 41314, 41291, 41302, type = 9},
		["VoA_A_DRUID_25_DR"] = {40469, 40466, 40468, 0, 41315, 41292, 41303, type = 9},
		["VoA_A_DRUID_10_D"] = {39554, 39557, 39555, 0, 41659, 41771, 41665, type = 9},
		["VoA_A_DRUID_25_D"] = {40471, 40472, 40493, 0, 41660, 41772, 41666, type = 9},
		["VoA_A_DRUID_10_H"]  = {39538, 39543, 39539, 0, 41308, 41284, 41296, type = 9},
		["VoA_A_DRUID_25_H"]  = {40463, 40460, 40462, 0, 41309, 41286, 41297, type = 9},
		-- Shaman
		["VoA_A_SHAMAN_10_DR"] = {39592, 39593, 39595, 0, 40989, 41005, 41031, type = 9},
		["VoA_A_SHAMAN_25_DR"] = {40514, 40515, 40517, 0, 40991, 41006, 41032, type = 9},
		["VoA_A_SHAMAN_10_D"] = {39597, 39601, 39603, 0, 41079, 41135, 41162, type = 9},
		["VoA_A_SHAMAN_25_D"] = {40523, 40520, 40522, 0, 41080, 41136, 41198, type = 9},
		["VoA_A_SHAMAN_10_H"]  = {39588, 39591, 39589, 0, 40988, 40999, 41025, type = 9},
		["VoA_A_SHAMAN_25_H"]  = {40508, 40509, 40512, 0, 40990, 41000, 41026, type = 9},
		-- Paladin
		["VoA_A_PALADIN_10_H"] = {39629, 39632, 39630, 0, 40904, 40925, 40937, type = 9},
		["VoA_A_PALADIN_25_H"] = {40569, 40570, 40572, 0, 40905, 40926, 40938, type = 9},
		["VoA_A_PALADIN_10_D"] = {39633, 39634, 39636, 0, 40782, 40802, 40842, type = 9},
		["VoA_A_PALADIN_25_D"] = {40574, 40575, 40577, 0, 40785, 40805, 40846, type = 9},
		["VoA_A_PALADIN_10_T"] = {39638, 39639, 39641, type = 9},
		["VoA_A_PALADIN_25_T"] = {40579, 40580, 40583, type = 9},

		--- Emalon the Storm Watcher
		-- Warlock
		["VoA_E_WARLOCK_10"] = {45419, 45420, 0, 42016, 42004, type = 9},
		["VoA_E_WARLOCK_25"] = {46135, 46139, 0, 42017, 42005, type = 9},
		-- Priest
		["VoA_E_PRIEST_10_H"] = {45387, 45388, 0, 41873, 41863, type = 9},
		["VoA_E_PRIEST_10_D"] = {45392, 45394, 0, 41939, 41926, type = 9},
		["VoA_E_PRIEST_25_H"] = {46188, 46195, 0, 41874, 41864, type = 9},
		["VoA_E_PRIEST_25_D"] = {46163, 46170, 0, 41940, 41927, type = 9},
		-- Rogue
		["VoA_E_ROGUE_10"] = {45397, 45399, 0, 41766, 41654, type = 9},
		["VoA_E_ROGUE_25"] = {46124, 46126, 0, 41767, 41655, type = 9},
		-- Hunter
		["VoA_E_HUNTER_10"] = {45360, 45362, 0, 41142, 41204, type = 9},
		["VoA_E_HUNTER_25"] = {46142, 46144, 0, 41143, 41205, type = 9},
		-- Warrior
		["VoA_E_WARRIOR_10_D"] = {45430, 45432, 0, 40804, 40844, type = 9},
		["VoA_E_WARRIOR_10_T"] = {45426, 45427, type = 9},
		["VoA_E_WARRIOR_25_D"] = {46148, 46150, 0, 40807, 40847, type = 9},
		["VoA_E_WARRIOR_25_T"] = {46164, 46169, type = 9},
		-- Deathknight
		["VoA_E_DEATHKNIGHT_10_D"] = {45341, 45343, 0, 40806, 40845, type = 9},
		["VoA_E_DEATHKNIGHT_10_T"] = {45337, 45338, type = 9},
		["VoA_E_DEATHKNIGHT_25_D"] = {46113, 46116, 0, 46119, 46121, type = 9},
		["VoA_E_DEATHKNIGHT_25_T"] = {40809, 40848, type = 9},
		-- Mage
		["VoA_E_MAGE_10"] = {46131, 45367, 0, 41970, 41958, type = 9},
		["VoA_E_MAGE_25"] = {46132, 46133, 0, 41971, 41959, type = 9},
		-- Druid
		["VoA_E_DRUID_10_DR"] = {45351, 45353, 0, 41314, 41291, type = 9},
		["VoA_E_DRUID_10_D"] = {45355, 45357, 0, 41659, 41771, type = 9},
		["VoA_E_DRUID_10_H"]  = {45345, 45347, 0, 41308, 41284, type = 9},
		["VoA_E_DRUID_25_DR"] = {46189, 46192, 0, 41293, 41304, type = 9},
		["VoA_E_DRUID_25_D"] = {46158, 46160, 0, 41773, 41667, type = 9},
		["VoA_E_DRUID_25_H"]  = {46183, 46185, 0, 41287, 41298, type = 9},
		-- Shaman
		["VoA_E_SHAMAN_10_DR"] = {45406, 45409, 0, 41006, 41032, type = 9},
		["VoA_E_SHAMAN_10_D"] = {45414, 45416, 0, 41136, 41198, type = 9},
		["VoA_E_SHAMAN_10_H"]  = {45401, 45403, 0, 41000, 41026, type = 9},
		["VoA_E_SHAMAN_25_DR"] = {46207, 46210, 0, 41007, 41033, type = 9},
		["VoA_E_SHAMAN_25_D"] = {46200, 46208, 0, 41137, 41199, type = 9},
		["VoA_E_SHAMAN_25_H"]  = {46199, 46202, 0, 41001, 41027, type = 9},
		-- Paladin
		["VoA_E_PALADIN_10_H"] = {45370, 45371, 0, 40926, 40938, type = 9},
		["VoA_E_PALADIN_10_D"] = {45376, 45379, 0, 40805, 40846, type = 9},
		["VoA_E_PALADIN_10_T"] = {45383, 45384, type = 9},
		["VoA_E_PALADIN_25_H"] = {46179, 46181, 0, 40927, 40939, type = 9},
		["VoA_E_PALADIN_25_D"] = {46155, 46153, 0, 40808, 40849, type = 9},
		["VoA_E_PALADIN_25_T"] = {46174, 46176, type = 9},

		--- Koralon the Flame Watcher (Alliance)
		-- Non-ClassSet-Items
		["VoA_K_CLOTH_10"] = {41909, 41898, 41903, 0, 41893, 41881, 41885, type = 9},
		["VoA_K_LEATHER_10"] = {41640, 41630, 41635, 0, 41625, 41617, 41621, 0, 41840, 41832, 41836, type = 9},
		["VoA_K_MAIL_10"] = {41065, 41070, 41075, 0, 41060, 41051, 41055, 0, 41225, 41235, 41230, type = 9},
		["VoA_K_PLATE_10"] = {40983, 40976, 40977, 0, 40889, 40881, 40882, type = 9},
		["VoA_K_BACK_10"] = {42071, 42073, 42069, 42072, 42070, 0, 42074, 42075, type = 9},
		["VoA_K_NECK_10"] = {42037, 42039, 42036, 42040, 42038, 0, 46373, 42034, 42035, type = 9},
		["VoA_K_FINGER_10"] = {42116, 0, 42117, type = 9},
		["VoA_K_CLOTH_25"] = {41910, 41899, 41904, 0, 41894, 41882, 41886, 0, 49181, 49179, 49183, type = 9},
		["VoA_K_LEATHER_25"] = {41641, 41631, 41636, 0, 41626, 41618, 41622, 0, 41841, 41833, 41837, type = 9},
		["VoA_K_MAIL_25"] = {41066, 41071, 41076, 0, 41061, 41052, 41056, 0, 41226, 41236, 41231, type = 9},
		["VoA_K_PLATE_25"] = {40984, 40978, 40979, 0, 40890, 40883, 40884, type = 9},
		["VoA_K_BACK_25"] = {42078, 42080, 42076, 42079, 42077, 0, 42081, 42082, type = 9},
		["VoA_K_NECK_25"] = {42044, 42046, 42043, 42047, 42045, 0, 46374, 42041, 42042, type = 9},
		["VoA_K_FINGER_25"] = {42118, 0, 42119, type = 9},
		-- Warlock
		["VoA_KA_WARLOCK_10"] = {47783, 47785, 0, 42017, 42005, type = 9},
		["VoA_KA_WARLOCK_25"] = {47782, 47780, 0, 42018, 42006, type = 9},
		-- Priest
		["VoA_KA_PRIEST_10_H"] = {47982, 47980, 0, 41874, 41864, type = 9},
		["VoA_KA_PRIEST_10_D"] = {48072, 48074, 0, 41940, 41927, type = 9},
		["VoA_KA_PRIEST_25_H"] = {47983, 47985, 0, 41875, 41865, type = 9},
		["VoA_KA_PRIEST_25_D"] = {48077, 48079, 0, 41941, 41928, type = 9},
		-- Rogue
		["VoA_KA_ROGUE_10"] = {48222, 48220, 0, 41767, 41655, type = 9},
		["VoA_KA_ROGUE_25"] = {48224, 48226, 0, 41768, 41656, type = 9},
		-- Hunter
		["VoA_KA_HUNTER_10"] = {48254, 48252, 0, 41143, 41205, type = 9},
		["VoA_KA_HUNTER_25"] = {48256, 48258, 0, 41144, 41206, type = 9},
		-- Warrior
		["VoA_KA_WARRIOR_10_D"] = {48375, 48373, 0, 40807, 40847, type = 9},
		["VoA_KA_WARRIOR_10_T"] = {48449, 48445, type = 9},
		["VoA_KA_WARRIOR_25_D"] = {48377, 48379, 0, 40810, 40850, type = 9},
		["VoA_KA_WARRIOR_25_T"] = {48452, 48446, type = 9},
		-- Deathknight
		["VoA_KA_DEATHKNIGHT_10_D"] = {48480, 48476, 0, 40809, 40848, type = 9},
		["VoA_KA_DEATHKNIGHT_10_T"] = {48537, 48533, type = 9},
		["VoA_KA_DEATHKNIGHT_25_D"] = {48482, 48484, 0, 40811, 40851, type = 9},
		["VoA_KA_DEATHKNIGHT_25_T"] = {48539, 48541, type = 9},
		-- Mage
		["VoA_KA_MAGE_10"] = {47752, 47750, 0, 41971, 41959, type = 9},
		["VoA_KA_MAGE_25"] = {47753, 47755, 0, 41972, 41960, type = 9},
		-- Druid
		["VoA_KA_DRUID_10_DR"] = {48162, 48160, 0, 41293, 41304, type = 9},
		["VoA_KA_DRUID_10_D"] = {48213, 48215, 0, 41773, 41667, type = 9},
		["VoA_KA_DRUID_10_H"]  = {48132, 48130, 0, 41287, 41298, type = 9},
		["VoA_KA_DRUID_25_DR"] = {48163, 48165, 0, 41294, 41305, type = 9},
		["VoA_KA_DRUID_25_D"] = {48212, 48210, 0, 41774, 41668, type = 9},
		["VoA_KA_DRUID_25_H"]  = {48133, 48135, 0, 41288, 41299, type = 9},
		-- Shaman
		["VoA_KA_SHAMAN_10_DR"] = {48312, 48314, 0, 41007, 41033, type = 9},
		["VoA_KA_SHAMAN_10_D"] = {48342, 48344, 0, 41137, 41199, type = 9},
		["VoA_KA_SHAMAN_10_H"]  = {48284, 48282, 0, 41001, 41027, type = 9},
		["VoA_KA_SHAMAN_25_DR"] = {48317, 48319, 0, 41008, 41034, type = 9},
		["VoA_KA_SHAMAN_25_D"] = {48347, 48349, 0, 41138, 41200, type = 9},
		["VoA_KA_SHAMAN_25_H"]  = {48286, 48288, 0, 41002, 41028, type = 9},
		-- Paladin
		["VoA_KA_PALADIN_10_H"] = {48574, 48568, 0, 40927, 40939, type = 9},
		["VoA_KA_PALADIN_10_D"] = {48603, 48605, 0, 40808, 40849, type = 9},
		["VoA_KA_PALADIN_10_T"] = {48633, 48635, type = 9},
		["VoA_KA_PALADIN_25_H"] = {48576, 48578, 0, 40928, 40940, type = 9},
		["VoA_KA_PALADIN_25_D"] = {48608, 48610, 0, 40812, 40852, type = 9},
		["VoA_KA_PALADIN_25_T"] = {48640, 48638, type = 9},
		-- Koralon the Flame Watcher (Horde)
		-- Warlock
		["VoA_KH_WARLOCK_10"] = {47802, 47800, 0, 42017, 42005, type = 9},
		["VoA_KH_WARLOCK_25"] = {47803, 47805, 0, 42018, 42006, type = 9},
		-- Priest
		["VoA_KH_PRIEST_10_H"] = {48067, 48069, 0, 41874, 41864, type = 9},
		["VoA_KH_PRIEST_10_D"] = {48097, 48099, 0, 41940, 41927, type = 9},
		["VoA_KH_PRIEST_25_H"] = {48066, 48064, 0, 41875, 41865, type = 9},
		["VoA_KH_PRIEST_25_D"] = {48096, 48094, 0, 41941, 41928, type = 9},
		-- Rogue
		["VoA_KH_ROGUE_10"] = {48244, 48246, 0, 41767, 41655, type = 9},
		["VoA_KH_ROGUE_25"] = {48241, 48239, 0, 41768, 41656, type = 9},
		-- Hunter
		["VoA_KH_HUNTER_10"] = {48276, 48278, 0, 41143, 41205, type = 9},
		["VoA_KH_HUNTER_25"] = {48273, 48271, 0, 41144, 41206, type = 9},
		-- Warrior
		["VoA_KH_WARRIOR_10_D"] = {48387, 48389, 0, 40807, 40847, type = 9},
		["VoA_KH_WARRIOR_10_T"] = {48457, 48459, type = 9},
		["VoA_KH_WARRIOR_25_D"] = {48392, 48394, 0, 40810, 40850, type = 9},
		["VoA_KH_WARRIOR_25_T"] = {48462, 48464, type = 9},
		-- Deathknight
		["VoA_KH_DEATHKNIGHT_10_D"] = {48502, 48504, 0, 40809, 40848, type = 9},
		["VoA_KH_DEATHKNIGHT_10_T"] = {48559, 48561, type = 9},
		["VoA_KH_DEATHKNIGHT_25_D"] = {48499, 48497, 0, 40811, 40851, type = 9},
		["VoA_KH_DEATHKNIGHT_25_T"] = {48556, 48554, type = 9},
		-- Mage
		["VoA_KH_MAGE_10"] = {47773, 47775, 0, 41971, 41959, type = 9},
		["VoA_KH_MAGE_25"] = {47772, 47770, 0, 41972, 41960, type = 9},
		-- Druid
		["VoA_KH_DRUID_10_DR"] = {48183, 48185, 0, 41293, 41304, type = 9},
		["VoA_KH_DRUID_10_D"] = {48192, 48190, 0, 41773, 41667, type = 9},
		["VoA_KH_DRUID_10_H"]  = {48153, 48155, 0, 41287, 41298, type = 9},

		["VoA_KH_DRUID_25_DR"] = {48182, 48180, 0, 41294, 41305, type = 9},
		["VoA_KH_DRUID_25_D"] = {48193, 48195, 0, 41774, 41668, type = 9},
		["VoA_KH_DRUID_25_H"]  = {48152, 48150, 0, 41288, 41299, type = 9},
		-- Shaman
		["VoA_KH_SHAMAN_10_DR"] = {48337, 48339, 0, 41007, 41033, type = 9},
		["VoA_KH_SHAMAN_10_D"] = {48367, 48369, 0, 41137, 41199, type = 9},
		["VoA_KH_SHAMAN_10_H"]  = {48296, 48298, 0, 41001, 41027, type = 9},
		["VoA_KH_SHAMAN_25_DR"] = {48334, 48332, 0, 41008, 41034, type = 9},
		["VoA_KH_SHAMAN_25_D"] = {48364, 48362, 0, 41138, 41200, type = 9},
		["VoA_KH_SHAMAN_25_H"]  = {48301, 48303, 0, 41002, 41028, type = 9},
		-- Paladin
		["VoA_KH_PALADIN_10_H"] = {48598, 48596, 0, 40927, 40939, type = 9},
		["VoA_KH_PALADIN_10_D"] = {48630, 48628, 0, 40808, 40849, type = 9},
		["VoA_KH_PALADIN_10_T"] = {48653, 48655, type = 9},
		["VoA_KH_PALADIN_25_H"] = {48593, 48591, 0, 40928, 40940, type = 9},
		["VoA_KH_PALADIN_25_D"] = {48625, 48623, 0, 40812, 40852, type = 9},
		["VoA_KH_PALADIN_25_T"] = {48658, 48660, type = 9},

		--- Toravon the Ice Watcher
		-- Non-ClassSet-Items
		["VoA_T_CLOTH_10"] = {41910, 41899, 41904, 0, 41894, 41882, 41886, 0, 49181, 49179, 49183, type = 9},
		["VoA_T_LEATHER_10"] = {41641, 41631, 41636, 0, 41626, 41618, 41622, 0, 41841, 41833, 41837, type = 9},
		["VoA_T_MAIL_10"] = {41066, 41071, 41076, 0, 41061, 41052, 41056, 0, 41226, 41236, 41231, type = 9},
		["VoA_T_PLATE_10"] = {40984, 40978, 40979, 0, 40890, 40883, 40884, type = 9},
		["VoA_T_BACK_10"] = {42078, 42080, 42076, 42079, 42077, 0, 42081, 42082, type = 9},
		["VoA_T_NECK_10"] = {42044, 42046, 42043, 42047, 42045, 0, 46374, 42041, 42042, type = 9},
		["VoA_T_FINGER_10"] = {42118, 0, 42119, type = 9},
		["VoA_T_CLOTH_25"] = {51329, 51327, 51328, 0, 51367, 51365, 51366, 0, 51339, 51337, 51338, type = 9},
		["VoA_T_LEATHER_25"] = {51345, 51343, 51344, 0, 51342, 51340, 51341, 0, 51370, 51368, 51369, type = 9},
		["VoA_T_MAIL_25"] = {51376, 51374, 51375, 0, 51373, 51371, 51372, 0, 51352, 51350, 51351, type = 9},
		["VoA_T_PLATE_25"] = {51361, 51359, 51360, 0, 51364, 51362, 51363, type = 9},
		["VoA_T_BACK_25"] = {51334, 51348, 51330, 51346, 51332, 0, 51354, 51356, type = 9},
		["VoA_T_NECK_25"] = {51335, 51349, 51331, 51347, 51333, 0, 51353, 51355, 51357, type = 9},
		["VoA_T_FINGER_25"] = {51336, 0, 51358, type = 9},
		-- Warlock
		["VoA_T_WARLOCK_10"] = {50240, 50242, 0, 42018, 42006, type = 9},
		["VoA_T_WARLOCK_25"] = {51209, 51207, 0, 51537, 51539, type = 9},
		-- Priest
		["VoA_T_PRIEST_10_H"] = {50766, 50769, 0, 41875, 41865, type = 9},
		["VoA_T_PRIEST_10_D"] = {50391, 50393, 0, 41941, 41928, type = 9},
		["VoA_T_PRIEST_25_H"] = {51179, 51177, 0, 51483, 51485, type = 9},
		["VoA_T_PRIEST_25_D"] = {51183, 51181, 0, 51488, 51490, type = 9},
		-- Rogue
		["VoA_T_ROGUE_10"] = {50088, 50090, 0, 41768, 41656, type = 9},
		["VoA_T_ROGUE_25"] = {51188, 51186, 0, 51493, 51495, type = 9},
		-- Hunter
		["VoA_T_HUNTER_10"] = {50114, 50116, 0, 41144, 41206, type = 9},
		["VoA_T_HUNTER_25"] = {51154, 51152, 0, 51459, 51461, type = 9},
		-- Warrior
		["VoA_T_WARRIOR_10_D"] = {50079, 50081, 0, 40810, 40850, type = 9},
		["VoA_T_WARRIOR_10_T"] = {50849, 50847, type = 9},
		["VoA_T_WARRIOR_25_D"] = {51213, 51211, 0, 51542, 51544, type = 9},
		["VoA_T_WARRIOR_25_T"] = {51217, 51216, type = 9},
		-- Deathknight
		["VoA_T_DEATHKNIGHT_10_D"] = {50095, 50097, 0, 40811, 40851, type = 9},
		["VoA_T_DEATHKNIGHT_10_T"] = {50856, 50854, type = 9},
		["VoA_T_DEATHKNIGHT_25_D"] = {51128, 51126, 0, 51414, 51416, type = 9},
		["VoA_T_DEATHKNIGHT_25_T"] = {51132, 51131, type = 9},
		-- Mage
		["VoA_T_MAGE_10"] = {50275, 50277, 0, 41972, 41960, type = 9},
		["VoA_T_MAGE_25"] = {51159, 51157, 0, 51464, 51466, type = 9},
		-- Druid
		["VoA_T_DRUID_10_DR"] = {50822, 50820, 0, 41294, 41305, type = 9},
		["VoA_T_DRUID_10_D"] = {50827, 50825, 0, 41774, 41668, type = 9},
		["VoA_T_DRUID_10_H"]  = {50107, 50109, 0, 41288, 41299, type = 9},
		["VoA_T_DRUID_25_DR"] = {51148, 51146, 0, 51434, 51436, type = 9},
		["VoA_T_DRUID_25_D"] = {51144, 51142, 0, 51426, 51428, type = 9},
		["VoA_T_DRUID_25_H"]  = {51138, 51136, 0, 51420, 51422, type = 9},
		-- Shaman
		["VoA_T_SHAMAN_10_DR"] = {50842, 50844, 0, 41008, 41034, type = 9},
		["VoA_T_SHAMAN_10_D"] = {50831, 50833, 0, 41138, 41200, type = 9},
		["VoA_T_SHAMAN_10_H"]  = {50836, 50838, 0, 41002, 41028, type = 9},
		["VoA_T_SHAMAN_25_DR"] = {51201, 51203, 0, 51510, 51512, type = 9},
		["VoA_T_SHAMAN_25_D"] = {51196, 51198, 0, 51504, 51506, type = 9},
		["VoA_T_SHAMAN_25_H"]  = {51191, 51193, 0, 51498, 51500, type = 9},
		-- Paladin
		["VoA_T_PALADIN_10_H"] = {50868, 50866, 0, 40928, 40940, type = 9},
		["VoA_T_PALADIN_10_D"] = {50327, 50325, 0, 40812, 40852, type = 9},
		["VoA_T_PALADIN_10_T"] = {50863, 50861, type = 9},
		["VoA_T_PALADIN_25_H"] = {51169, 51168, 0, 51469, 51471, type = 9},
		["VoA_T_PALADIN_25_D"] = {51163, 51161, 0, 51475, 51477, type = 9},
		["VoA_T_PALADIN_25_T"] = {51172, 51171, type = 9},

		--- Darkmoon cards
		-- Chaos Deck / Darkmoon Card: Berserker!
		[44276] = { 44276, 42989, 0, 44277, 44278, 44279, 44280, 44281, 44282, 44284, 44285 },
		[44277] = 44276, [44278] = 44276, [44279] = 44276, [44280] = 44276, [44281] = 44276, [44282] = 44276, [44284] = 44276, [44285] = 44276,

		-- Prisms Deck / Darkmoon Card: Illusion
		[44259] = { 44259, 42988, 0, 44260, 44261, 44262, 44263, 44264, 44265, 44266, 44267 },
		[44260] = 44259, [44261] = 44259, [44262] = 44259, [44263] = 44259, [44264] = 44259, [44265] = 44259, [44266] = 44259, [44267] = 44259,

		-- Undeath Deck / Darkmoon Card: Death
		[44294] = { 44294, 42990, 0, 44286, 44287, 44288, 44289, 44290, 44291, 44292, 44293 },
		[44286] = 44294, [44287] = 44294, [44288] = 44294, [44289] = 44294, [44290] = 44294, [44291] = 44294, [44292] = 44294, [44293] = 44294,

		-- Lunacy Deck / Darkmoon Card: Greatness
		[44326] = { 44326, 44253, 42987, 44254, 44255, 0, 44268, 44269, 44270, 44271, 44272, 44273, 44274, 44275 },
		[44268] = 44326, [44269] = 44326, [44270] = 44326, [44271] = 44326, [44272] = 44326, [44273] = 44326, [44274] = 44326, [44275] = 44326,


		--- Misc
		[44951] = { { 41119, "24-40" }, type = 11 }
	}
end


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

function Token.TokenTypeAddDescription(itemID)
	return ( itemID and TOKEN[itemID] ) and TOKEN_TYPE_ADD_ITEM_DESCRIPTION[TOKEN[itemID].type or TOKEN_TYPE_DEFAULT] or false
end

function Token.GetTokenDummyNumberRange()
	return TOKE_NUMBER_RANGE
end

-- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR", "DEATHKNIGHT"
-- AtlasLoot.Data.Token.GetClassItemsForToken(45654, "WARRIOR")
function Token.GetClassItemsForToken(tokenItemID, className)
	if not tokenItemID or not TOKEN[tokenItemID] then return end
	if not className or not ICONS[className] then return end

	local classTokens = {}
	local isClassToken = false
	for i, token in ipairs(TOKEN[tokenItemID]) do
		if isClassToken then
			if token == 0 then
				break
			else
				classTokens[#classTokens+1] = token
			end
		elseif token == ICONS[className] then
			isClassToken = true
		end
	end

	return #classTokens > 0 and classTokens or nil
end

-- TOKEN_TYPE_ADD_ITEM_DESCRIPTION
--[==[@debug@
function Token.GetFullTokenTable()
	return TOKEN
end
--@end-debug@]==]