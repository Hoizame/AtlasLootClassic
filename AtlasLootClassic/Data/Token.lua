local ALName, ALPrivate = ...

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
	[6] = format(TOKEN_FORMAT_STRING, AL["Token for..."]),

	-- classes get set with the init
	-- "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"
}

local ICONS = {
	WARRIOR 	= 	"ADDON_classicon_warrior",
	PALADIN 	= 	"ADDON_classicon_paladin",
	HUNTER 		= 	"ADDON_classicon_hunter",
	ROGUE 		= 	"ADDON_classicon_rogue",
	PRIEST 		= 	"ADDON_classicon_priest",
	SHAMAN 		= 	"ADDON_classicon_shaman",
	MAGE 		= 	"ADDON_classicon_mage",
	WARLOCK 	= 	"ADDON_classicon_warlock",
	DRUID 		= 	"ADDON_classicon_druid",
}

local TOKEN = {
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

--@version-bc@

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
	[30250] = { ICONS.HUNTER, 30143, 0, ICONS.MAGE, 32047, 0, ICONS.WARLOCK, 30215, type = 6 }, -- Pauldrons of the Vanquished Hero
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
--@end-version-bc@
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

--@debug@
function Token.GetFullTokenTable()
	return TOKEN
end
--@end-debug@