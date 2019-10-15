local AtlasLoot = _G.AtlasLoot
local Mount = {}
AtlasLoot.Data.Mount = Mount
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

-- lua
local format = string.format

-- WoW


local MOUNT_LIST = {
    -- [itemID] = displayID,
    [903] = 2409, -- Pinto
    [1041] = 207, -- Black Wolf
    [1042] = 1166, -- Winter Wolf
    [1043] = 247, -- Timber Wolf
    [1044] = 2326, -- Red Wolf
    [842] = 2320, -- Gray Wolf
    [875] = 2404, -- Brown Horse
    [1122] = 2410, -- White Stallion
    [1123] = 2409, -- Pinto
    [823] = 2404, -- Brown Horse
    [1132] = 247, -- Timber Wolf
    [1133] = 1166, -- Winter Wolf
    [1134] = 2320, -- Gray Wolf
    [2411] = 2402, -- Black Stallion
    [2414] = 2409, -- Pinto
    [5872] = 2785, -- Brown Ram
    [5873] = 2786, -- White Ram
    [5874] = 2784, -- Black Ram
    [5655] = 2405, -- Chestnut Mare
    [5668] = 2328, -- Brown Wolf
    [8588] = 4806, -- Emerald Raptor
    [8589] = 6471, -- Ivory Raptor
    [8591] = 6472, -- Turquoise Raptor
    [8592] = 6473, -- Violet Raptor
    [5656] = 2404, -- Brown Horse
    [5665] = 2327, -- Dire Wolf
    [8632] = 6444, -- Spotted Frostsaber
    [8583] = 5228, -- Skeletal Horse
    [8563] = 9473, -- Red Mechanostrider
    [5663] = 2326, -- Red Wolf
    [8629] = 6448, -- Striped Nightsaber
    [12353] = 2410, -- White Stallion
    [8595] = 6569, -- Blue Mechanostrider
    [5864] = 2736, -- Gray Ram
    [2415] = 2410, -- White Stallion
    [12351] = 1166, -- Arctic Wolf
    [12354] = 2408, -- Palomino
    [8631] = 6080, -- Striped Frostsaber
    [12302] = 9695, -- Ancient Frostsaber
    [12303] = 9991, -- Black Nightsaber
    [12330] = 2326, -- Red Wolf
    [13326] = 9474, -- White Mechanostrider Mod B
    [13322] = 9476, -- Unpainted Mechanostrider
    [13332] = 10671, -- Blue Skeletal Horse
    [13335] = 10718, -- Rivendare's Deathcharger
    [13327] = 10666, -- Icy Blue Mechanostrider Mod A
    [13329] = 2787, -- Frost Ram
    [13331] = 10670, -- Red Skeletal Horse
    [13086] = 10426, -- Winterspring Frostsaber
    [13333] = 10672, -- Brown Skeletal Horse
    [15290] = 11641, -- Brown Kodo
    [13334] = 10720, -- Green Skeletal Warhorse
    [13317] = 6471, -- Ivory Raptor
    [13321] = 10661, -- Green Mechanostrider
    [14062] = 11641, -- Riding Kodo
    [15277] = 12246, -- Gray Kodo
    [16344] = 1166, -- Arctic Wolf
    [15292] = 12245, -- Green Kodo
    [15293] = 12242, -- Teal Kodo
    [18243] = 14372, -- Black Battlestrider
    [18248] = 10719, -- Red Skeletal Warhorse
    [16339] = 2408, -- Palomino
    [16338] = 2404, -- Brown Horse
    [18063] = 10718, -- Rivendare's Deathcharger
    [18242] = 14330, -- Black War Tiger
    [18245] = 14334, -- Black War Wolf
    [18247] = 14348, -- Black War Kodo
    [18244] = 14577, -- Black War Ram
    [18778] = 14338, -- Swift White Steed
    [18791] = 10721, -- Purple Skeletal Warhorse
    [18797] = 14575, -- Swift Timber Wolf
    [18766] = 14331, -- Swift Frostsaber
    [18777] = 14583, -- Swift Brown Steed
    [18774] = 14377, -- Swift Yellow Mechanostrider
    [13328] = 2784, -- Black Ram
    [18776] = 14582, -- Swift Palomino
    [16343] = 2328, -- Brown Wolf
    [18767] = 14332, -- Swift Mistsaber
    [18772] = 14374, -- Swift Green Mechanostrider
    [18785] = 14346, -- Swift White Ram
    [18787] = 14576, -- Swift Gray Ram
    [18788] = 14339, -- Swift Blue Raptor
    [8586] = 6469, -- Mottled Red Raptor
    [18773] = 14376, -- Swift White Mechanostrider
    [18241] = 14337, -- Black War Steed
    [19030] = 14777, -- Stormpike Battle Charger
    [18795] = 14579, -- Great Gray Kodo
    [18796] = 14573, -- Swift Brown Wolf
    [18798] = 14574, -- Swift Gray Wolf
    [18246] = 14388, -- Black War Raptor
    [18790] = 14342, -- Swift Orange Raptor
    [18793] = 14349, -- Great White Kodo
    [18794] = 14578, -- Great Brown Kodo
    [901] = 2410, -- White Stallion
    [18789] = 14344, -- Swift Olive Raptor
    [19902] = 15290, -- Swift Zulian Tiger
    [19029] = 14776, -- Frostwolf Howler
    [18902] = 14632, -- Swift Stormsaber
    [18786] = 14347, -- Swift Brown Ram
    [19872] = 15289, -- Swift Razzashi Raptor
    [21321] = 15681, -- Red Qiraji Battle Tank
    [21323] = 15679, -- Green Qiraji Battle Tank
    [21324] = 15680, -- Yellow Qiraji Battle Tank
    [21218] = 15678, -- Blue Qiraji Battle Tank
    [23720] = 17158, -- Riding Turtle
    [21176] = 15677, -- Black Qiraji Resonating Crystal
    [20221] = 15293, -- Foror's Fabled Steed
}

function Mount.IsMount(itemID)
    return MOUNT_LIST[itemID] and true or false
end

function Mount.GetMountNpcID(itemID)
    return MOUNT_LIST[itemID]
end