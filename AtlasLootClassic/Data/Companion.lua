local AtlasLoot = _G.AtlasLoot
local Companion = {}
AtlasLoot.Data.Companion = Companion
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

-- lua
local format = string.format

-- WoW

-- local
local COLLECTED_DESCRIPTION = "|cff66cc33"..ALIL["Collected"].."|r"
local NOT_COLLECTED_DESCRIPTION = "|cffcc6666"..ALIL["Not Collected"].."|r"

local COLLECTED_STRINGS = {}
local COMPANION_TYPE = {
    [1] = { "CRITTER",  ALIL["Pet"] },
    [2] = { "MOUNT",    ALIL["Mount"] },
}
for i = 1,#COMPANION_TYPE do
	COLLECTED_STRINGS[i] = {
		collected = {
			text = format("%s - "..COLLECTED_DESCRIPTION, COMPANION_TYPE[i][2])
		},
		notCollected = {
			text = format("%s - "..NOT_COLLECTED_DESCRIPTION, COMPANION_TYPE[i][2])
		}
	}
end

local COMPANION_DATA = {
	-- [itemID] = {spellID, creatureID, creatureType}
  [44822] = {10713, 7561, 1}, --Albino Snake
  [211082] = {428053, 213605, 1}, --Arfus
  [44998] = {62609, 33238, 1}, --Argent Squire
  [10360] = {10714, 7565, 1}, --Black Kingsnake
  [54436] = {75134, 40295, 1}, --Blue Clockwork Rocket Bot
  [29958] = {36031, 21056, 1}, --Blue Dragonhawk Hatchling
  [65661] = {78683, 42177, 1}, --Blue Mini Jouster
  [29901] = {35907, 21010, 1}, --Blue Moth Egg
  [8485] = {10673, 7385, 1}, --Cat Carrier (Bombay)
  [10394] = {10709, 14421, 1}, --Prairie Dog Whistle
  [29364] = {35239, 20472, 1}, --Brown Rabbit Crate
  [10361] = {10716, 7562, 1}, --Brown Snake
  [46398] = {65358, 34364, 1}, --Cat Carrier (Calico Cat)
  [64372] = {90523, 48609, 1}, --Clockwork Gnome
  [39898] = {61351, 32591, 1}, --Cobra Hatchling
  [8496] = {10680, 7390, 1}, --Parrot Cage (Cockatiel)
  [10393] = {10688, 7395, 1}, --Cockroach
  [8486] = {10674, 7384, 1}, --Cat Carrier (Cornish Rex)
  [10392] = {10717, 7567, 1}, --Crimson Snake
  [46545] = {65381, 33530, 1}, --Curious Oracle Hatchling
  [46544] = {65382, 33529, 1}, --Curious Wolvar Pup
  [209877] = {423843, 211012, 1}, --Cypress
  [73762] = {103076, 55187, 1}, --Darkmoon Balloon
  [74981] = {105122, 56031, 1}, --Darkmoon Cub
  [73764] = {101733, 54491, 1}, --Darkmoon Monkey
  [32616] = {40614, 23258, 1}, --Egbert's Egg
  [21301] = {26533, 15698, 1}, --Green Helper Box
  [60955] = {84752, 45340, 1}, --Fossilized Hatchling
  [39973] = {53316, 29147, 1}, --Ghostly Skull
  [204982] = {407786, 200900, 1}, --Glub
  [65662] = {78685, 42183, 1}, --Gold Mini Jouster
  [29953] = {36027, 21055, 1}, --Golden Dragonhawk Hatchling
  [8500] = {10707, 7553, 1}, --Great Horned Owl
  [8492] = {10683, 7387, 1}, --Parrot Cage (Green Wing Macaw)
  [8501] = {10706, 7555, 1}, --Hawk Owl
  [200060] = {388541, 196534, 1}, --Hoplet
  [69648] = {98079, 53048, 1}, --Legs
  [44841] = {61991, 32939, 1}, --Little Fawn's Salt Lick
  [29363] = {35156, 20408, 1}, --Mana Wyrmling
  [10398] = {12243, 8376, 1}, --Mechanical Chicken
  [31760] = {39181, 22445, 1}, --Miniwing
  [33993] = {43918, 24480, 1}, --Mojo
  [23007] = {28739, 16548, 1}, --Piglet's Collar
  [38628] = {51716, 28470, 1}, --Nether Ray Fry
  [48120] = {67417, 35399, 1}, --Obsidian Hatchling
  [8487] = {10676, 7382, 1}, --Cat Carrier (Orange Tabby)
  [32622] = {40634, 23266, 1}, --Elekk Training Collar
  [22235] = {27570, 16085, 1}, --Truesilver Shafted Arrow
  [44723] = {61357, 32595, 1}, --Nurtured Penguin Egg
  [49912] = {70613, 37865, 1}, --Perky Pug
  [35504] = {46599, 26119, 1}, --Phoenix Hatchling
  [46707] = {44369, 24753, 1}, --Pint-Sized Pink Pachyderm
  [44810] = {61773, 32818, 1}, --Turkey Cage
  [44721] = {61350, 32592, 1}, --Proto-Drake Whelp
  [69821] = {98571, 53225, 1}, --Pterrordax Hatchling
  [48124] = {67419, 35398, 1}, --Razormaw Hatchling
  [29956] = {36028, 21064, 1}, --Red Dragonhawk Hatchling
  [29902] = {35909, 21009, 1}, --Red Moth Egg
  [63355] = {89472, 48107, 1}, --Rustberg Gull
  [66073] = {93817, 51635, 1}, --Snail Shell
  [8495] = {10684, 7389, 1}, --Parrot Cage (Senegal)
  [8490] = {10677, 7380, 1}, --Cat Carrier (Siamese)
  [29957] = {36029, 21063, 1}, --Silver Dragonhawk Hatchling
  [8488] = {10678, 7381, 1}, --Cat Carrier (Silver Tabby)
  [66067] = {93823, 51090, 1}, --Brazie's Sunflower Seeds
  [33154] = {42609, 23909, 1}, --Sinister Squashling
  [12529] = {16450, 10598, 1}, --Smolderweb Carrier
  [8497] = {10711, 7560, 1}, --Rabbit Crate (Snowshoe)
  [23002] = {28738, 16547, 1}, --Turtle Box
  [23083] = {28871, 16701, 1}, --Captured Flame
  [44794] = {61725, 32791, 1}, --Spring Rabbit's Foot
  [11474] = {15067, 9662, 1}, --Sprite Darter Egg
  [40653] = {40990, 23274, 1}, --Reeking Pet Carrier
  [39896] = {61348, 32589, 1}, --Tickbird Hatchling
  [21309] = {26045, 15710, 1}, --Snowman Kit
  [34478] = {45082, 25062, 1}, --Tiny Sporebat
  [50446] = {71840, 38374, 1}, --Toxic Wasteling
  [11026] = {10704, 7549, 1}, --Tree Frog Box
  [38658] = {51851, 28513, 1}, --Vampiric Batling
  [69824] = {98587, 53232, 1}, --Voodoo Figurine
  [23015] = {28740, 16549, 1}, --Rat Cage
  [8489] = {10679, 7386, 1}, --Cat Carrier (White Kitten)
  [29904] = {35911, 21018, 1}, --White Moth Egg
  [39899] = {61349, 32590, 1}, --White Tickbird Hatchling
  [32617] = {40613, 23231, 1}, --Sleepy Willy
  [21308] = {26529, 15706, 1}, --Jingling Bell
  [21305] = {26541, 15705, 1}, --Red Helper Box
  [32233] = {39709, 22943, 1}, --Wolpertinger's Tankard
  [11027] = {10703, 7550, 1}, --Wood Frog Box
  [12264] = {15999, 10259, 1}, --Worg Carrier
  [29903] = {35910, 21008, 1}, --Yellow Moth Egg
  [72042] = {101986, 54539, 1}, --Alliance Balloon
  [44984] = {62562, 33205, 1}, --Ammen Vale Lashling
  [11023] = {10685, 7394, 1}, --Ancona Chicken
  [45022] = {62746, 33239, 1}, --Argent Gruntling
  [63398] = {89670, 48242, 1}, --Armadillo Pup
  [34535] = {10696, 7547, 1}, --Azure Whelpling
  [8491] = {10675, 7383, 1}, --Cat Carrier (Black Tabby)
  [71387] = {101424, 54374, 1}, --Brilliant Kaliri
  [54810] = {75613, 40624, 1}, --Celestial Dragon
  [70099] = {99578, 53623, 1}, --Cenarion Hatchling
  [35350] = {46426, 26056, 1}, --Chuck's Bucket
  [34425] = {54187, 24968, 1}, --Clockwork Rocket Bot
  [60847] = {84263, 45128, 1}, --Crawling Claw
  [71076] = {100684, 54128, 1}, --Creepy Crate
  [70160] = {99668, 53661, 1}, --Crimson Lasher
  [8499] = {10697, 7544, 1}, --Tiny Crimson Whelpling
  [63138] = {89039, 47944, 1}, --Dark Phoenix Hatchling
  [10822] = {10695, 7543, 1}, --Dark Whelpling
  [73903] = {103544, 55356, 1}, --Darkmoon Tonk
  [73765] = {103074, 54487, 1}, --Darkmoon Turtle
  [73905] = {103549, 55367, 1}, --Darkmoon Zeppelin
  [48112] = {67413, 35396, 1}, --Darting Hatchling
  [60216] = {82173, 43916, 1}, --De-Weaponized Mechanical Companion
  [67418] = {94070, 51122, 1}, --Smoldering Murloc Egg
  [48114] = {67414, 35395, 1}, --Deviate Hatchling
  [20769] = {25162, 15429, 1}, --Disgusting Oozeling
  [44970] = {62508, 33194, 1}, --Dun Morogh Cub
  [44973] = {62513, 33198, 1}, --Durotar Scorpion
  [67282] = {93838, 50722, 1}, --Elementium Geode
  [44974] = {62516, 33200, 1}, --Elwynn Lamb
  [8498] = {10698, 7545, 1}, --Tiny Emerald Whelpling
  [44982] = {62564, 33227, 1}, --Enchanted Broom
  [67274] = {93836, 46898, 1}, --Enchanted Lantern
  [79744] = {112994, 59020, 1}, --Eye of the Legion
  [70908] = {100330, 53884, 1}, --Feline Familiar
  [74611] = {104049, 55574, 1}, --Festival Lantern
  [76062] = {105633, 56266, 1}, --Fetish Shaman's Spear
  [29960] = {36034, 21076, 1}, --Captured Firefly
  [64403] = {90637, 48641, 1}, --Fox Kit
  [53641] = {74932, 40198, 1}, --Ice Chip
  [43698] = {59250, 31575, 1}, --Giant Sewer Rat
  [72134] = {102317, 54730, 1}, --Grell Moss
  [72068] = {98736, 53283, 1}, --Guardian Cub
  [48116] = {67415, 35400, 1}, --Gundrak Hatchling
  [72045] = {101989, 54541, 1}, --Horde Balloon
  [8494] = {10682, 7391, 1}, --Parrot Cage (Hyacinth Macaw)
  [70140] = {99663, 53658, 1}, --Hyjal Bear Cub
  [19450] = {23811, 14878, 1}, --A Jubling's Tiny Home
  [44738] = {61472, 32643, 1}, --Kirin Tor Familiar
  [68840] = {96817, 52343, 1}, --Landro's Lichling
  [67128] = {93624, 50468, 1}, --Landro's Lil' XT
  [69251] = {97779, 52894, 1}, --Lashtail Hatchling
  [48118] = {67416, 35387, 1}, --Leaping Hatchling
  [15996] = {19772, 12419, 1}, --Lifelike Mechanical Toad
  [62540] = {87344, 46896, 1}, --Lil' Deathwing
  [68385] = {95787, 51600, 1}, --Lil' Ragnaros
  [71033] = {100576, 54027, 1}, --Lil' Tarecgosa
  [73797] = {103125, 55215, 1}, --Lump of Coal
  [74610] = {104047, 55571, 1}, --Lunar Lantern
  [67275] = {93837, 50545, 1}, --Magic Lamp
  [27445] = {33050, 18839, 1}, --Magical Crawdad Box
  [4401] = {4055, 2671, 1}, --Mechanical Squirrel Box
  [45002] = {62674, 33274, 1}, --Mechanopeep
  [68619] = {95909, 51649, 1}, --Moonkin Hatchling
  [68618] = {95786, 51601, 1}, --Moonkin Hatchling
  [66076] = {93739, 50586, 1}, --Mr. Grubbs
  [33818] = {43698, 24389, 1}, --Muckbreath's Bucket
  [44980] = {62542, 33219, 1}, --Mulgore Hatchling
  [65361] = {92395, 49586, 1}, --Guild Page Ally
  [65362] = {92396, 49588, 1}, --Guild Page Horde
  [65363] = {92397, 49587, 1}, --Guild Herald Ally
  [65364] = {92398, 49590, 1}, --Guild Herald Horde
  [71726] = {101606, 54438, 1}, --Murky's Little Soulstone
  [68841] = {96819, 52344, 1}, --Nightsaber Cub
  [71140] = {100970, 54227, 1}, --Nuts' Acorn
  [68833] = {96571, 52226, 1}, --Panther Cub
  [60869] = {84492, 45247, 1}, --Pebble
  [59597] = {81937, 43800, 1}, --Personal World Destroyer
  [11825] = {15048, 9656, 1}, --Pet Bombling
  [71624] = {101493, 54383, 1}, --Purple Puffer
  [48122] = {67418, 35397, 1}, --Ravasaur Hatchling
  [48126] = {67420, 35394, 1}, --Razzashi Hatchling
  [72153] = {102353, 54745, 1}, --Sand Scarab
  [73953] = {103588, 55386, 1}, --Sea Pony
  [45606] = {63712, 33810, 1}, --Sen'jin Fetish
  [46820] = {66096, 34724, 1}, --Shimmering Wyrmling
  [35349] = {46425, 26050, 1}, --Snarly's Bucket
  [78916] = {110029, 58163, 1}, --Soul of the Aspects
  [44983] = {62561, 33226, 1}, --Strand Crawler
  [44965] = {62491, 33188, 1}, --Teldrassil Sproutling
  [66080] = {93813, 51632, 1}, --Tiny Flamefly
  [64494] = {91343, 48982, 1}, --Tiny Shale Spider
  [68673] = {16450, 10598, 1}, --Smolderweb Egg
  [44971] = {62510, 33197, 1}, --Tirisfal Batling
  [33816] = {43697, 24388, 1}, --Toothy's Bucket
  [21277] = {26010, 15699, 1}, --Tranquil Mechanical Yeti
  [11110] = {13548, 30379, 1}, --Chicken Egg
  [69239] = {97638, 52831, 1}, --Winterspring Cub
  [46325] = {65046, 34278, 1}, --Withers
  [5656] = {458, 284, 2}, --Brown Horse Bridle
  [1134] = {459, 4268, 2}, --Horn of the Gray Wolf
  [2415] = {468, 305, 2}, --White Stallion
  [2411] = {470, 308, 2}, --Black Stallion Bridle
  [2414] = {472, 307, 2}, --Pinto Bridle
  [1041] = {578, 356, 2}, --Horn of the Black Wolf
  [5663] = {579, 4270, 2}, --Horn of the Red Wolf
  [1132] = {580, 358, 2}, --Horn of the Timber Wolf
  [1133] = {581, 359, 2}, --Horn of the Winter Wolf
  [5655] = {6648, 4269, 2}, --Chestnut Mare Bridle
  [5665] = {6653, 4271, 2}, --Horn of the Dire Wolf
  [5668] = {6654, 4272, 2}, --Horn of the Brown Wolf
  [5864] = {6777, 4710, 2}, --Gray Ram
  [5874] = {6896, 4780, 2}, --Harness: Black Ram
  [5873] = {6898, 4777, 2}, --White Ram
  [5872] = {6899, 4779, 2}, --Brown Ram
  [8631] = {8394, 6074, 2}, --Reins of the Striped Frostsaber
  [8588] = {8395, 6075, 2}, --Whistle of the Emerald Raptor
  [8583] = {8980, 6486, 2}, --Horn of the Skeletal Mount
  [8632] = {10789, 7687, 2}, --Reins of the Spotted Frostsaber
  [8629] = {10793, 7690, 2}, --Reins of the Striped Nightsaber
  [8589] = {10795, 7706, 2}, --Old Whistle of the Ivory Raptor
  [8591] = {10796, 7707, 2}, --Whistle of the Turquoise Raptor
  [8592] = {10799, 7708, 2}, --Whistle of the Violet Raptor
  [8563] = {10873, 7739, 2}, --Red Mechanostrider
  [8595] = {10969, 7749, 2}, --Blue Mechanostrider
  [13326] = {15779, 10179, 2}, --White Mechanostrider Mod B
  [12303] = {16055, 7322, 2}, --Reins of the Nightsaber
  [12302] = {16056, 10322, 2}, --Reins of the Ancient Frostsaber
  [12330] = {16080, 4270, 2}, --Horn of the Red Wolf
  [12351] = {16081, 359, 2}, --Horn of the Arctic Wolf
  [12354] = {16082, 306, 2}, --Palomino Bridle
  [12353] = {16083, 305, 2}, --White Stallion Bridle
  [8586] = {16084, 7704, 2}, --Whistle of the Mottled Red Raptor
  [13086] = {17229, 11021, 2}, --Reins of the Winterspring Frostsaber
  [13317] = {17450, 7706, 2}, --Whistle of the Ivory Raptor
  [13321] = {17453, 11147, 2}, --Green Mechanostrider
  [13322] = {17454, 10180, 2}, --Unpainted Mechanostrider
  [13327] = {17459, 11150, 2}, --Icy Blue Mechanostrider Mod A
  [13329] = {17460, 4778, 2}, --Frost Ram
  [13328] = {17461, 4780, 2}, --Black Ram
  [13331] = {17462, 11153, 2}, --Red Skeletal Horse
  [13332] = {17463, 11154, 2}, --Blue Skeletal Horse
  [13333] = {17464, 11155, 2}, --Brown Skeletal Horse
  [13334] = {17465, 11156, 2}, --Green Skeletal Warhorse
  [13335] = {17481, 30542, 2}, --Deathcharger's Reins
  [14062] = {18363, 11689, 2}, --Kodo Mount
  [15277] = {18989, 12149, 2}, --Gray Kodo
  [15290] = {18990, 11689, 2}, --Brown Kodo
  [15292] = {18991, 12151, 2}, --Green Kodo
  [15293] = {18992, 12148, 2}, --Teal Kodo
  [29468] = {22717, 14332, 2}, --Black War Steed Bridle
  [29466] = {22718, 14333, 2}, --Black War Kodo
  [29465] = {22719, 14334, 2}, --Black Battlestrider
  [29467] = {22720, 14335, 2}, --Black War Ram
  [29472] = {22721, 14330, 2}, --Whistle of the Black War Raptor
  [29470] = {22722, 14331, 2}, --Red Skeletal Warhorse
  [29471] = {22723, 14336, 2}, --Reins of the Black War Tiger
  [29469] = {22724, 14329, 2}, --Horn of the Black War Wolf
  [18767] = {23219, 14555, 2}, --Reins of the Swift Mistsaber
  [18766] = {23221, 14556, 2}, --Reins of the Swift Frostsaber
  [18774] = {23222, 14551, 2}, --Swift Yellow Mechanostrider
  [18773] = {23223, 14552, 2}, --Swift White Mechanostrider
  [18772] = {23225, 14553, 2}, --Swift Green Mechanostrider
  [18776] = {23227, 14559, 2}, --Swift Palomino
  [18778] = {23228, 14560, 2}, --Swift White Steed
  [18777] = {23229, 14561, 2}, --Swift Brown Steed
  [18786] = {23238, 14546, 2}, --Swift Brown Ram
  [18787] = {23239, 14548, 2}, --Swift Gray Ram
  [18785] = {23240, 14547, 2}, --Swift White Ram
  [18788] = {23241, 14545, 2}, --Swift Blue Raptor
  [18789] = {23242, 14543, 2}, --Swift Olive Raptor
  [18790] = {23243, 14544, 2}, --Swift Orange Raptor
  [18791] = {23246, 14558, 2}, --Purple Skeletal Warhorse
  [18793] = {23247, 14542, 2}, --Great White Kodo
  [18795] = {23248, 14550, 2}, --Great Gray Kodo
  [18794] = {23249, 14549, 2}, --Great Brown Kodo
  [18796] = {23250, 14540, 2}, --Horn of the Swift Brown Wolf
  [18797] = {23251, 14539, 2}, --Horn of the Swift Timber Wolf
  [18798] = {23252, 14541, 2}, --Horn of the Swift Gray Wolf
  [18902] = {23338, 14602, 2}, --Reins of the Swift Stormsaber
  [19029] = {23509, 14744, 2}, --Horn of the Frostwolf Howler
  [19030] = {23510, 14745, 2}, --Stormpike Battle Charger
  [19872] = {24242, 15090, 2}, --Swift Razzashi Raptor
  [19902] = {24252, 15104, 2}, --Swift Zulian Tiger
  [21218] = {25953, 15666, 2}, --Blue Qiraji Resonating Crystal
  [21321] = {26054, 15716, 2}, --Red Qiraji Resonating Crystal
  [21324] = {26055, 15714, 2}, --Yellow Qiraji Resonating Crystal
  [21323] = {26056, 15715, 2}, --Green Qiraji Resonating Crystal
  [21176] = {26656, 15711, 2}, --Black Qiraji Resonating Crystal
  [25470] = {32235, 18360, 2}, --Golden Gryphon
  [25471] = {32239, 18357, 2}, --Ebon Gryphon
  [25472] = {32240, 18359, 2}, --Snowy Gryphon
  [25473] = {32242, 18406, 2}, --Swift Blue Gryphon
  [25474] = {32243, 18363, 2}, --Tawny Wind Rider
  [25475] = {32244, 18364, 2}, --Blue Wind Rider
  [25476] = {32245, 18365, 2}, --Green Wind Rider
  [25477] = {32246, 18377, 2}, --Swift Red Wind Rider
  [25527] = {32289, 18376, 2}, --Swift Red Gryphon
  [25528] = {32290, 18375, 2}, --Swift Green Gryphon
  [25529] = {32292, 18362, 2}, --Swift Purple Gryphon
  [25531] = {32295, 18378, 2}, --Swift Green Wind Rider
  [25532] = {32296, 18380, 2}, --Swift Yellow Wind Rider
  [25533] = {32297, 18379, 2}, --Swift Purple Wind Rider
  [28936] = {33660, 19281, 2}, --Swift Pink Hawkstrider
  [28481] = {34406, 19658, 2}, --Brown Elekk
  [29228] = {34790, 20149, 2}, --Reins of the Dark War Talbuk
  [28927] = {34795, 19280, 2}, --Red Hawkstrider
  [29227] = {34896, 20072, 2}, --Reins of the Cobalt War Talbuk
  [29231] = {34897, 20151, 2}, --Reins of the White War Talbuk
  [29229] = {34898, 20152, 2}, --Reins of the Silver War Talbuk
  [29230] = {34899, 20150, 2}, --Reins of the Tan War Talbuk
  [29222] = {35018, 20217, 2}, --Purple Hawkstrider
  [29220] = {35020, 20220, 2}, --Blue Hawkstrider
  [29221] = {35022, 20222, 2}, --Black Hawkstrider
  [29223] = {35025, 20224, 2}, --Swift Green Hawkstrider
  [29224] = {35027, 20223, 2}, --Swift Purple Hawkstrider
  [34129] = {35028, 20225, 2}, --Swift Warstrider
  [29744] = {35710, 20846, 2}, --Gray Elekk
  [29743] = {35711, 20847, 2}, --Purple Elekk
  [29746] = {35712, 20849, 2}, --Great Green Elekk
  [29745] = {35713, 20848, 2}, --Great Blue Elekk
  [29747] = {35714, 20850, 2}, --Great Purple Elekk
  [30480] = {36702, 21354, 2}, --Fiery Warhorse's Reins
  [30609] = {37015, 21510, 2}, --Swift Nether Drake
  [31830] = {39315, 22510, 2}, --Reins of the Cobalt Riding Talbuk
  [28915] = {39316, 22511, 2}, --Reins of the Dark Riding Talbuk
  [31832] = {39317, 22512, 2}, --Reins of the Silver Riding Talbuk
  [31834] = {39318, 22513, 2}, --Reins of the Tan Riding Talbuk
  [31836] = {39319, 22514, 2}, --Reins of the White Riding Talbuk
  [32314] = {39798, 22958, 2}, --Green Riding Nether Ray
  [32317] = {39800, 22976, 2}, --Red Riding Nether Ray
  [32316] = {39801, 22975, 2}, --Purple Riding Nether Ray
  [32318] = {39802, 22977, 2}, --Silver Riding Nether Ray
  [32319] = {39803, 22978, 2}, --Blue Riding Nether Ray
  [32458] = {40192, 18545, 2}, --Ashes of Al'ar
  [32768] = {41252, 23408, 2}, --Reins of the Raven Lord
  [32857] = {41513, 23455, 2}, --Reins of the Onyx Netherwing Drake
  [32858] = {41514, 23456, 2}, --Reins of the Azure Netherwing Drake
  [32859] = {41515, 23460, 2}, --Reins of the Cobalt Netherwing Drake
  [32860] = {41516, 23458, 2}, --Reins of the Purple Netherwing Drake
  [32861] = {41517, 23457, 2}, --Reins of the Veridian Netherwing Drake
  [32862] = {41518, 23459, 2}, --Reins of the Violet Netherwing Drake
  [33224] = {42776, 24003, 2}, --Reins of the Spectral Tiger
  [33225] = {42777, 24004, 2}, --Reins of the Swift Spectral Tiger
  [33809] = {43688, 24379, 2}, --Amani War Bear
  [33976] = {43899, 23588, 2}, --Brewfest Ram
  [33977] = {43900, 24368, 2}, --Swift Brewfest Ram
  [33999] = {43927, 24488, 2}, --Cenarion War Hippogryph
  [34061] = {44151, 24654, 2}, --Turbo-Charged Flying Machine
  [34060] = {44153, 24653, 2}, --Flying Machine
  [34092] = {44744, 24743, 2}, --Merciless Nether Drake
  [35225] = {46197, 26192, 2}, --X-51 Nether-Rocket
  [35226] = {46199, 26164, 2}, --X-51 Nether-Rocket X-TREME
  [35513] = {46628, 26131, 2}, --Swift White Hawkstrider
  [37012] = {48025, 27152, 2}, --The Horseman's Reins
  [35906] = {48027, 26439, 2}, --Reins of the Black War Elekk
  [37676] = {49193, 27637, 2}, --Vengeful Nether Drake
  [37827] = {49378, 27706, 2}, --Brewfest Kodo
  [37828] = {49379, 27707, 2}, --Great Brewfest Kodo
  [38576] = {51412, 28363, 2}, --Big Battle Bear
  [40775] = {54729, 29582, 2}, --Winged Steed of the Ebon Blade
  [43962] = {54753, 29596, 2}, --Reins of the White Polar Bear
  [41508] = {55531, 29929, 2}, --Mechano-Hog
  [43516] = {58615, 31124, 2}, --Brutal Nether Drake
  [43599] = {58983, 31319, 2}, --Big Blizzard Bear
  [43952] = {59567, 31694, 2}, --Reins of the Azure Drake
  [43953] = {59568, 31695, 2}, --Reins of the Blue Drake
  [43951] = {59569, 31717, 2}, --Reins of the Bronze Drake
  [43955] = {59570, 31697, 2}, --Reins of the Red Drake
  [43954] = {59571, 31698, 2}, --Reins of the Twilight Drake
  [43964] = {59572, 31699, 2}, --Reins of the Black Polar Bear
  [43986] = {59650, 31778, 2}, --Reins of the Black Drake
  [43956] = {59785, 31849, 2}, --Reins of the Black War Mammoth
  [44077] = {59788, 31850, 2}, --Reins of the Black War Mammoth
  [44230] = {59791, 31851, 2}, --Reins of the Wooly Mammoth
  [44231] = {59793, 31852, 2}, --Reins of the Wooly Mammoth
  [44080] = {59797, 31854, 2}, --Reins of the Ice Mammoth
  [43958] = {59799, 31855, 2}, --Reins of the Ice Mammoth
  [44160] = {59961, 31902, 2}, --Reins of the Red Proto-Drake
  [44164] = {59976, 31912, 2}, --Reins of the Black Proto-Drake
  [44151] = {59996, 32151, 2}, --Reins of the Blue Proto-Drake
  [44168] = {60002, 32153, 2}, --Reins of the Time-Lost Proto-Drake
  [44175] = {60021, 32156, 2}, --Reins of the Plagued Proto-Drake
  [44177] = {60024, 32157, 2}, --Reins of the Violet Proto-Drake
  [44178] = {60025, 32158, 2}, --Reins of the Albino Drake
  [44225] = {60114, 32206, 2}, --Reins of the Armored Brown Bear
  [44226] = {60116, 32207, 2}, --Reins of the Armored Brown Bear
  [44223] = {60118, 32203, 2}, --Reins of the Black War Bear
  [44224] = {60119, 32205, 2}, --Reins of the Black War Bear
  [44413] = {60424, 32286, 2}, --Mekgineer's Chopper
  [44689] = {61229, 32335, 2}, --Armored Snowy Gryphon
  [44690] = {61230, 32336, 2}, --Armored Blue Wind Rider
  [44707] = {61294, 32562, 2}, --Reins of the Green Proto-Drake
  [44558] = {61309, 33030, 2}, --Magnificent Flying Carpet
  [44235] = {61425, 32633, 2}, --Reins of the Traveler's Tundra Mammoth
  [44234] = {61447, 32640, 2}, --Reins of the Traveler's Tundra Mammoth
  [44554] = {61451, 33029, 2}, --Flying Carpet
  [43959] = {61465, 31862, 2}, --Reins of the Grand Black War Mammoth
  [44083] = {61467, 31861, 2}, --Reins of the Grand Black War Mammoth
  [44086] = {61469, 31857, 2}, --Reins of the Grand Ice Mammoth
  [43961] = {61470, 31858, 2}, --Reins of the Grand Ice Mammoth
  [44843] = {61996, 31239, 2}, --Blue Dragonhawk
  [44842] = {61997, 32944, 2}, --Red Dragonhawk
  [45125] = {63232, 33297, 2}, --Stormwind Steed
  [45593] = {63635, 33299, 2}, --Darkspear Raptor
  [45586] = {63636, 33408, 2}, --Ironforge Ram
  [45591] = {63637, 33298, 2}, --Darnassian Nightsaber
  [45589] = {63638, 33301, 2}, --Gnomeregan Mechanostrider
  [45590] = {63639, 33416, 2}, --Exodar Elekk
  [45595] = {63640, 33409, 2}, --Orgrimmar Wolf
  [45592] = {63641, 33300, 2}, --Thunder Bluff Kodo
  [45596] = {63642, 33418, 2}, --Silvermoon Hawkstrider
  [45597] = {63643, 33414, 2}, --Forsaken Warhorse
  [45693] = {63796, 33848, 2}, --Mimiron's Head
  [45725] = {63844, 33857, 2}, --Argent Hippogryph
  [45801] = {63956, 33892, 2}, --Reins of the Ironbound Proto-Drake
  [45802] = {63963, 33904, 2}, --Reins of the Rusted Proto-Drake
  [46101] = {64656, 34154, 2}, --Blue Skeletal Warhorse
  [46100] = {64657, 34155, 2}, --White Kodo
  [46099] = {64658, 356, 2}, --Horn of the Black Wolf
  [46102] = {64659, 34156, 2}, --Whistle of the Venomhide Ravasaur
  [46109] = {64731, 34187, 2}, --Sea Turtle
  [46708] = {64927, 34225, 2}, --Deadly Gladiator's Frost Wyrm
  [46308] = {64977, 34238, 2}, --Black Skeletal Horse
  [46171] = {65439, 34425, 2}, --Furious Gladiator's Frost Wyrm
  [46745] = {65637, 34551, 2}, --Great Red Elekk
  [46744] = {65638, 34550, 2}, --Swift Moonsaber
  [46751] = {65639, 34556, 2}, --Swift Red Hawkstrider
  [46752] = {65640, 34557, 2}, --Swift Gray Steed
  [46750] = {65641, 34558, 2}, --Great Golden Kodo
  [46747] = {65642, 34553, 2}, --Turbostrider
  [46748] = {65643, 34554, 2}, --Swift Violet Ram
  [46743] = {65644, 34549, 2}, --Swift Purple Raptor
  [46746] = {65645, 34552, 2}, --White Skeletal Warhorse
  [46749] = {65646, 34555, 2}, --Swift Burgundy Wolf
  [46778] = {65917, 34655, 2}, --Magic Rooster Egg
  [46813] = {66087, 35147, 2}, --Silver Covenant Hippogryph
  [46814] = {66088, 35148, 2}, --Sunreaver Dragonhawk
  [46815] = {66090, 33840, 2}, --Quel'dorei Steed
  [46816] = {66091, 33841, 2}, --Sunreaver Hawkstrider
  [47101] = {66846, 35169, 2}, --Ochre Skeletal Warhorse
  [47100] = {66847, 35168, 2}, --Reins of the Striped Dawnsaber
  [47179] = {66906, 35179, 2}, --Argent Charger
  [47840] = {67336, 35362, 2}, --Relentless Gladiator's Frost Wyrm
  [47180] = {67466, 35445, 2}, --Argent Warhorse
  [49046] = {68056, 35809, 2}, --Swift Horde Wolf
  [49044] = {68057, 35808, 2}, --Swift Alliance Steed
  [49096] = {68187, 35876, 2}, --Crusader's White Warhorse
  [49098] = {68188, 35878, 2}, --Crusader's Black Warhorse
  [49636] = {69395, 36837, 2}, --Reins of the Onyxian Drake
  [50250] = {71342, 38207, 2}, --X-45 Heartbreaker
  [50435] = {71810, 38361, 2}, --Wrathful Gladiator's Frost Wyrm
  [50818] = {72286, 38260, 2}, --Invincible's Reins
  [51955] = {72807, 38695, 2}, --Reins of the Icebound Frostbrood Vanquisher
  [51954] = {72808, 38778, 2}, --Reins of the Bloodbathed Frostbrood Vanquisher
  [52200] = {73313, 39046, 2}, --Reins of the Crimson Deathcharger
  [54069] = {74856, 40165, 2}, --Blazing Hippogryph
  [54068] = {74918, 40191, 2}, --Wooly White Rhino
  [54797] = {75596, 40533, 2}, --Frosty Flying Carpet
  [184865] = {348459, 176708, 2}, --Reawakened Phase-Hunter
  [192455] = {372677, 189739, 2}, --Kalu'ak Whalebone Glider
  [198631] = {387308, 34655, 2}, --Magic Rooster Egg
  [198628] = {387311, 26164, 2}, --X-51 Nether-Rocket X-TREME
  [198632] = {387319, 28363, 2}, --Big Battle Bear
  [198630] = {387320, 40165, 2}, --Blazing Hippogryph
  [198633] = {387321, 40191, 2}, --Wooly White Rhino
  [198629] = {387323, 26192, 2}, --X-51 Nether-Rocket
  [201699] = {394209, 198525, 2}, --Festering Emerald Drake
  [207097] = {416158, 208033, 2}, --Nightmarish Emerald Drake
  [8630] = {10790, 7686, 2}, --Reins of the Bengal Tiger
  [54465] = {75207, 40054, 2}, --Subdued Abyssal Seahorse
  [60954] = {84751, 45338, 2}, --Fossilized Raptor
  [62900] = {88331, 47352, 2}, --Reins of the Volcanic Stone Drake
  [62901] = {88335, 47353, 2}, --Reins of the Drake of the East Wind
  [63042] = {88718, 47631, 2}, --Reins of the Phosphorescent Stone Drake
  [63039] = {88741, 47647, 2}, --Reins of the Drake of the West Wind
  [63040] = {88742, 47648, 2}, --Reins of the Drake of the North Wind
  [63041] = {88744, 47646, 2}, --Reins of the Drake of the South Wind
  [63043] = {88746, 47651, 2}, --Reins of the Vitreous Stone Drake
  [63044] = {88748, 47652, 2}, --Reins of the Brown Riding Camel
  [63045] = {88749, 47653, 2}, --Reins of the Tan Riding Camel
  [63046] = {88750, 47654, 2}, --Reins of the Grey Riding Camel
  [63125] = {88990, 47841, 2}, --Reins of the Dark Phoenix
  [62298] = {90621, 48632, 2}, --Reins of the Golden King
  [64883] = {92155, 51152, 2}, --Scepter of Azj'Aqir
  [64998] = {92231, 49487, 2}, --Reins of the Spectral Steed
  [64999] = {92232, 49488, 2}, --Reins of the Spectral Wolf
  [65891] = {93326, 50269, 2}, --Vial of the Sands
  [68008] = {93623, 50467, 2}, --Mottled Drake
  [67107] = {93644, 51195, 2}, --Reins of the Kor'kron Annihilator
  [68823] = {96491, 52172, 2}, --Armored Razzashi Raptor
  [68824] = {96499, 52178, 2}, --Swift Zulian Panther
  [68825] = {96503, 52185, 2}, --Amani Dragonhawk
  [69213] = {97359, 52672, 2}, --Flameward Hippogryph
  [69224] = {97493, 52748, 2}, --Smoldering Egg of Millagazor
  [69226] = {97501, 52756, 2}, --Green Fire Hawk Mount
  [69230] = {97560, 52807, 2}, --Corrupted Egg of Millagazor
  [69228] = {97581, 52813, 2}, --Savage Raptor
  [69747] = {98204, 53276, 2}, --Amani Battle Bear
  [67151] = {98718, 53270, 2}, --Reins of Poseidus
  [69846] = {98727, 53273, 2}, --Winged Guardian
  [70909] = {100332, 53885, 2}, --Vicious War Steed
  [70910] = {100333, 53985, 2}, --Vicious War Wolf
  [71339] = {101282, 54335, 2}, --Vicious Gladiator's Twilight Drake
  [71665] = {101542, 54395, 2}, --Flametalon of Alysrazor
  [71718] = {101573, 54423, 2}, --Swift Shorestrider
  [71954] = {101821, 54498, 2}, --Ruthless Gladiator's Twilight Drake
  [72140] = {102346, 54740, 2}, --Swift Forest Strider
  [72145] = {102349, 54741, 2}, --Swift Springstrider
  [72146] = {102350, 54742, 2}, --Swift Lovebird
  [72575] = {102488, 54879, 2}, --White Riding Camel
  [72582] = {102514, 54903, 2}, --Corrupted Hippogryph
  [73766] = {103081, 55188, 2}, --Darkmoon Dancing Bear
  [76755] = {107203, 56921, 2}, --Tyrael's Charger
  [76889] = {107516, 57156, 2}, --Spectral Gryphon
  [76902] = {107517, 57157, 2}, --Spectral Wind Rider
  [77067] = {107842, 57226, 2}, --Reins of the Blazing Drake
  [77068] = {107844, 57227, 2}, --Reins of the Twilight Harbinger
  [77069] = {107845, 57228, 2}, --Life-Binder's Handmaiden
  [78919] = {110039, 58166, 2}, --Experiment 12-B
  [78924] = {110051, 58169, 2}, --Heart of the Aspects
  [79771] = {113120, 59072, 2}, --Feldrake
  [83086] = {121820, 62454, 2}, --Heart of the Nightwing
  [62461] = {87090, 46754, 2}, --Goblin Trike Key
  [62462] = {87091, 46755, 2}, --Goblin Turbo-Trike Key
  [73838] = {103195, 55272, 2}, --Mountain Horse
  [73839] = {103196, 55273, 2}, --Swift Mountain Horse
}

local COLLECTED_MOUNTS_SPELLIDS = {}
local COLLECTED_PETS_CREATUREIDS = {}

function Companion.IsCompanion(itemID)
    return COMPANION_DATA[itemID] and true or false
end

function Companion.GetCreatureID(itemID)
    return COMPANION_DATA[itemID] and COMPANION_DATA[itemID][2] or nil
end

function Companion.GetTypeID(itemID)
    return COMPANION_DATA[itemID] and COMPANION_DATA[itemID][3] or nil
end

function Companion.GetTypeName(itemID)
    if COMPANION_DATA[itemID] and COMPANION_DATA[itemID][3] then
        return COMPANION_TYPE[COMPANION_DATA[itemID][3]] and COMPANION_TYPE[COMPANION_DATA[itemID][3]][2] or nil
    end
end

function Companion.GetDescription(itemID, addCollected)
    if COMPANION_DATA[itemID] and COMPANION_DATA[itemID][3] and COMPANION_TYPE[COMPANION_DATA[itemID][3]] then
		local typeID = COMPANION_DATA[itemID][3]
        if addCollected and Companion.IsCollectedItem(itemID) then
            return COLLECTED_STRINGS[typeID].collected.text
		elseif addCollected then
			return COLLECTED_STRINGS[typeID].notCollected.text
        else
            return COMPANION_TYPE[typeID][2]
        end
    end
end

function Companion.GetBlizzardType(itemID)
    if COMPANION_DATA[itemID] and COMPANION_DATA[itemID][3] then
        return COMPANION_TYPE[COMPANION_DATA[itemID][3]] and COMPANION_TYPE[COMPANION_DATA[itemID][3]][1] or nil
    end
end

function Companion.GetCollectedString(itemID)
    if COMPANION_DATA[itemID] and COMPANION_DATA[itemID][3] and COMPANION_TYPE[COMPANION_DATA[itemID][3]] then
        if Companion.IsCollectedItem(itemID) then
            return COLLECTED_DESCRIPTION
		else
			return NOT_COLLECTED_DESCRIPTION
        end
    end
end

function Companion.IsCollectedItem(itemID)
  if COMPANION_DATA[itemID] then
    local spellID = COMPANION_DATA[itemID][1]
    local creatureID = COMPANION_DATA[itemID][2]
    local typeID = COMPANION_DATA[itemID][3]

    if typeID == 1 then
      return COLLECTED_PETS_CREATUREIDS[creatureID]
    else
      return COLLECTED_MOUNTS_SPELLIDS[spellID]
    end
  end
end

-- companions are learnd since wotlk
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end

local EventFrame = CreateFrame("FRAME")
EventFrame:RegisterEvent("COMPANION_LEARNED")
EventFrame:RegisterEvent("COMPANION_UNLEARNED")
EventFrame:RegisterEvent("COMPANION_UPDATE")

local function UpdateKnownCompanions(typ)
    if typ == "MOUNT" then
        local mountIDs = C_MountJournal.GetMountIDs()
        for i = 1, #mountIDs do
            local _, spellID, _, _, _, _, _, _, _, _, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountIDs[i])
            COLLECTED_MOUNTS_SPELLIDS[spellID] = isCollected
        end
    else
        local num = C_PetJournal.GetNumPets()
        for i=1, num do
          local _, _, isOwned, _, _, _, _, name, _, _, creatureID = C_PetJournal.GetPetInfoByIndex(i)
          COLLECTED_PETS_CREATUREIDS[creatureID] = isOwned
        end
    end
end

local function EventFrame_OnEvent(frame, event, arg1)
    if event == "COMPANION_UNLEARNED" then
        wipe(COLLECTED_MOUNTS_SPELLIDS)
        wipe(COLLECTED_PETS_CREATUREIDS)
    end
    for i = 1, #COMPANION_TYPE do
        UpdateKnownCompanions(COMPANION_TYPE[i][1])
    end
end
EventFrame:SetScript("OnEvent", EventFrame_OnEvent)

-- first companion scan
local function OnInit()
    EventFrame_OnEvent()
end

AtlasLoot:AddInitFunc(OnInit)