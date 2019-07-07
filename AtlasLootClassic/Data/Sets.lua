local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local Sets = {}
AtlasLoot.Data.Sets = Sets
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local IMAGE_PATH = ALPrivate.IMAGE_PATH
local ItemStringCreate = AtlasLoot.ItemString.AddBonus

local Sets_Proto = {}
local SingleSet_Proto = {}

-- lua
local assert, type = assert, type
local rawset = rawset

local format = string.format

local GLOBAL_SETS = "global"
local NO_ICON = "Interface\\Icons\\inv_helmet_08"
local ICON_PATH_PRE = {
	-- class icons
	WARRIOR 	= 	IMAGE_PATH.."classicon_warrior",
	PALADIN 	= 	IMAGE_PATH.."classicon_paladin",
	HUNTER 		= 	IMAGE_PATH.."classicon_hunter",
	ROGUE 		= 	IMAGE_PATH.."classicon_rogue",
	PRIEST 		= 	IMAGE_PATH.."classicon_priest",
	SHAMAN 		= 	IMAGE_PATH.."classicon_shaman",
	MAGE 		= 	IMAGE_PATH.."classicon_mage",
	WARLOCK 	= 	IMAGE_PATH.."classicon_warlock",
	DRUID 		= 	IMAGE_PATH.."classicon_druid",
}

-- contains all sets
local Storage = {}
local Loaded_Sets = {}

-- PROTOS
local difficultys = {}
local infoListData = {}

local DIFF_LIST_START = 200
local INFO_LIST_START = 300

-- ################
-- :Set functions for set creation
-- ################
function Sets_Proto:SetContentTable(setTab)
	Storage[self.__key] = setTab
end

function Sets_Proto:AddDifficulty(diffName, shortName, preset)
	if not difficultys[self.__key] then
		difficultys[self.__key] = {
			counter = 0,
			names = {},
			shortNames = {},
			data = {}
		}
	end
	if not diffName then return end
	local diffTab = difficultys[self.__key]

	if not diffTab.shortNames[shortName] or not diffTab.names[diffName] then
		diffTab.counter = diffTab.counter + 1
		diffTab.names[diffName] = diffTab.counter
		if shortName then
			diffTab.shortNames[shortName] = diffTab.counter
		end
		diffTab.data[diffTab.counter] = {
			name = diffName,
			preset = preset,
			shortName = shortName,
		}
	end
	return diffTab.shortNames[shortName]+DIFF_LIST_START or diffTab.names[diffName]+DIFF_LIST_START
end

function Sets_Proto:AddInfoList(name, emptyEntry)
	if not infoListData[self.__key] then
		infoListData[self.__key] = {
			counter = 0,
			names = {},
			data = {}
		}
	end
	if not name then return end
	local infoTab = infoListData[self.__key]

	if not infoTab.names[name] then
		infoTab.counter = infoTab.counter + 1
		infoTab.names[name] = infoTab.counter
		infoTab.data[infoTab.counter] = {
			name = name,
			emptyEntry = emptyEntry or "",
		}
	end
	return infoTab.names[name]+INFO_LIST_START
end

-- ################
-- :Set functions for existing and loaded sets
-- ################
function SingleSet_Proto:Get(subSetName, diff, info)
	subSetName = (subSetName and self[subSetName]) and subSetName or self:GetNextPrevPage(subSetName)
	if not subSetName then return end
	diff = (diff and self[subSetName][diff]) and diff or self:GetNextPrevDifficulty(subSetName, diff)
	if not diff then return end
	info = (info and (self[subSetName][info] or self[subSetName][diff][info])) and info or SingleSet_Proto:GetNextPrevInfo(subSetName, diff, info)

	return self[subSetName], subSetName, diff, info
end

function SingleSet_Proto:GetDifficultyList()
	return difficultys[self.__addonName].data
end

function SingleSet_Proto:GetDifficultyName(diff)
	diff = ( diff and difficultys[self.__addonName].shortNames[diff] ) and difficultys[self.__addonName].shortNames[diff] or diff
	diff = difficultys[self.__addonName].data[diff] and diff or diff-DIFF_LIST_START
	return difficultys[self.__addonName].data[diff] and difficultys[self.__addonName].data[diff].name or nil
end

function SingleSet_Proto:GetInfoName(info)
	info = infoListData[self.__addonName].data[info] and info or info-INFO_LIST_START
	return infoListData[self.__addonName].data[info] and infoListData[self.__addonName].data[info].name or nil
end

function SingleSet_Proto:GetInfoList()
	return infoListData[self.__addonName].data
end

function SingleSet_Proto:GetNextPrevPage(subSetName)
	subSetName = (subSetName and self[subSetName]) and subSetName or (( subSetName and self.subSetNames and self.subSetNames[subSetName] ) and self.subSetNames[subSetName].__id or 1)
	return subSetName, self[subSetName+1] and subSetName+1 or nil, self[subSetName-1] and subSetName-1 or nil
end

function SingleSet_Proto:GetNextPrevDifficulty(subSetName, curDiff)
	local subSet = (subSetName and self[subSetName]) and self[subSetName] or (( subSetName and self.subSetNames and self.subSetNames[subSetName] ) and self.subSetNames[subSetName] or self[1])
	curDiff = not curDiff and nil or (type(curDiff) == "number" and ((curDiff>DIFF_LIST_START) and curDiff-DIFF_LIST_START or curDiff) or ( difficultys[self.__addonName].shortNames[curDiff] and difficultys[self.__addonName].shortNames[curDiff] or difficultys[self.__addonName].names[curDiff]))
	if subSet then
		curDiff = ( curDiff and subSet[curDiff+DIFF_LIST_START] ) and curDiff or nil
		local nex, prev, last
		for i = DIFF_LIST_START+1, difficultys[self.__addonName].counter+DIFF_LIST_START do
			if subSet[i] then
				if not curDiff then
					curDiff = i-DIFF_LIST_START
				elseif last and i-DIFF_LIST_START == curDiff then
					prev = last
				elseif last == curDiff then
					nex = i-DIFF_LIST_START
					break
				end
				last = i-DIFF_LIST_START
			end
		end
		return curDiff, nex, prev
	end
end

function SingleSet_Proto:GetNextPrevInfo(subSetName, curDiff, curInfo)
	local subSet = (subSetName and self[subSetName]) and self[subSetName] or (( subSetName and self.subSetNames and self.subSetNames[subSetName] ) and self.subSetNames[subSetName] or self[1])
	curDiff = curDiff and ((curDiff<DIFF_LIST_START) and curDiff+DIFF_LIST_START or curDiff) or self:GetNextPrevDifficulty(subSetName, curDiff)
	if subSet and subSet[curDiff] then
		local nex, prev, last
		for i = INFO_LIST_START+1, infoListData[self.__addonName].counter+INFO_LIST_START do
			if subSet[curDiff][i] or subSet[i] then
				if not curInfo or curInfo == "stats" then
					nex = i-INFO_LIST_START
					curInfo = "stats"
					break
				elseif i-INFO_LIST_START == curInfo then
					prev = last
					last = i-INFO_LIST_START
				elseif last == curInfo then
					nex = i-INFO_LIST_START
					break
				end

			end
		end
		return curInfo, nex, prev
	end
end

function SingleSet_Proto:GetDiffTable(subSetName, curDiff)
	subSetName = (subSetName and self[subSetName]) and self[subSetName] or (( subSetName and self.subSetNames and self.subSetNames[subSetName] ) and self.subSetNames[subSetName] or self[1])
	curDiff = not curDiff and nil or (type(curDiff) == "number" and ((curDiff>DIFF_LIST_START) and curDiff-DIFF_LIST_START or curDiff) or ( difficultys[self.__addonName].shortNames[curDiff] and difficultys[self.__addonName].shortNames[curDiff] or difficultys[self.__addonName].names[curDiff]))
	return subSetName[curDiff] and subSetName[curDiff] or ( subSetName[curDiff+DIFF_LIST_START] and subSetName[curDiff+DIFF_LIST_START] or nil )
end

function SingleSet_Proto:GetInfoTable(subSetName, curDiff, currInfo)
	local set = curDiff and self:GetDiffTable(subSetName, curDiff) or self[subSetName]
	currInfo = currInfo and (currInfo<INFO_LIST_START and currInfo+INFO_LIST_START or currInfo) or nil
	return set[currInfo] and set[currInfo] or ( set[currInfo+INFO_LIST_START] and set[currInfo+INFO_LIST_START] or curDiff and self:GetInfoTable(subSetName, nil, currInfo) or nil )
end

function SingleSet_Proto:GetItemTable(subSetName, curDiff)
	subSetName = self:GetDiffTable(subSetName, curDiff)
	return subSetName and subSetName.itemTable or nil
end

function SingleSet_Proto:GetIcon(subSetName, curDiff)
	subSetName = type(subSetName) == "table" and subSetName or self:Get(subSetName, curDiff)

	if subSetName and subSetName.icon then
		if ICON_PATH_PRE[subSetName.icon] then
			return ICON_PATH_PRE[subSetName.icon]
		elseif type(subSetName.icon) == "number" then
			return  GetItemIcon(subSetName.icon)
		else
			return subSetName.icon
		end
	else
		return GetItemIcon(subSetName[curDiff].itemTable[1]) or NO_ICON
	end
end

-- name, desc, icon
local DIFF_FORMAT_NAME = "%s (%s)"
function SingleSet_Proto:GetInfo(subSetName, curDiff)
	subSetName = self:Get(subSetName)
	local name = ( subSetName and subSetName.name ) and subSetName.name or self.name
	local desc = ( subSetName and subSetName.desc ) and subSetName.desc or ""

	local icon = self:GetIcon(subSetName, curDiff)
	return name, desc, icon
end
-- ################
-- :Set functions
-- ################
local Single_Set_mt = { __index = SingleSet_Proto }

local Loaded_Sets_MT = {
	__index = function(self, key)
		if key and Sets_Proto[key] then
			return Sets_Proto[key]
		elseif key and Storage[self.__key] and Storage[self.__key][key] then
			local tab = Storage[self.__key][key]
			tab.__addonName = self.__key
			local subSet, diff, item
			for i = 1, #tab do
				subSet = tab[i]
				subSet.__id = i
				if subSet.subSetName then
					if not tab.subSetNames then tab.subSetNames = {} end
					tab.subSetNames[subSet.subSetName] = subSet
				end
				for ib = INFO_LIST_START+1, infoListData[self.__key].counter+INFO_LIST_START do
					if subSet[ib] and tab[ subSet[ib] ] then
						subSet[ib] = tab[ subSet[ib] ]
					end
				end
				for ia = DIFF_LIST_START+1, difficultys[self.__key].counter+DIFF_LIST_START do
					if subSet[ia] then
						if type(subSet[ia]) == "number" then
							diff = subSet[ia]
							while true do
								diff = subSet[diff]
								if type(diff) == "table" then
									subSet[ia] = {}
									for k, v in pairs(diff) do
										subSet[ia][k] = v
									end
									break
								end
							end
						end
						diff = subSet[ia].itemTable or subSet[ia]
						if not subSet[ia].itemTable then
							subSet[ia].itemTable = {}
						end
						-- check for info templates
						for ib = INFO_LIST_START+1, infoListData[self.__key].counter+INFO_LIST_START do
							if subSet[ia][ib] and tab[ subSet[ia][ib] ] then
								subSet[ia][ib] = tab[ subSet[ia][ib] ]
							end
						end
						-- set info templates for single items..
						for ib = 1, #diff do
							for ic = INFO_LIST_START+1, infoListData[self.__key].counter+INFO_LIST_START do
								if subSet[ib] and subSet[ib][ic] and tab[ subSet[ib][ic] ] then
									subSet[ib][ic] = tab[ subSet[ib][ic] ]
								end
							end
							item = diff[ib]
							if type(item) == "table" then
								subSet[ia].itemTable[ib] = item[1]
								for ic = INFO_LIST_START+1, infoListData[self.__key].counter+INFO_LIST_START do
									if item[ic] then
										if not subSet[ia][ic] then
											if subSet[ic] then
												subSet[ia][ic] = setmetatable({}, {__index = subSet[ic]})
											else
												subSet[ia][ic] = {}
											end

										elseif subSet[ia][ic] and type(subSet[ia][ic]) == "string" then
											--print(subSet[ia][ic], tab[ subSet[ia][ic] ], tab[ subSet[ia][ic] ][1])
											if tab[ subSet[ia][ic] ] then
												subSet[ia][ic] = setmetatable({}, {__index = tab[ subSet[ia][ic] ]})
											else
												subSet[ia][ic] = {}
											end
										end

										subSet[ia][ic][ ib ] = item[ic]
									end
								end
								subSet[ia][ib] = item[1]
							else
								subSet[ia].itemTable[ib] = item
							end
							-- Create the item strings if there ar bonus ids
							if difficultys[self.__key].data[ia-DIFF_LIST_START].preset then
								subSet[ia][ib] = ItemStringCreate(item, difficultys[self.__key].data[ia-DIFF_LIST_START].preset[1])
							end
						end
					end
				end
			end
			rawset(self, key, tab)
			setmetatable(self[key], Single_Set_mt)
		end

		return self[key]
	end,
}

function Sets:RegisterNewSets(addonName)
	assert(not Storage[addonName], addonName.." already exists.")
	Loaded_Sets[addonName] = setmetatable({__key = addonName}, Loaded_Sets_MT)
	-- Init empty diffs/infos
	Loaded_Sets[addonName]:AddDifficulty()
	Loaded_Sets[addonName]:AddInfoList()
	return Loaded_Sets[addonName]
end

function Sets:GetSetTable(addonName)
	return Loaded_Sets[addonName]
end

function Sets:GetSet(setName, addonName)
	addonName = addonName or GLOBAL_SETS
	if Loaded_Sets[addonName] then
		return Loaded_Sets[addonName][setName]
	elseif Loaded_Sets[GLOBAL_SETS][setName] then
		return Loaded_Sets[GLOBAL_SETS][setName]
	end
end

-- ################
-- global set
-- ################

local Global_Set = Sets:RegisterNewSets(GLOBAL_SETS)

local NORMAL_DIFF = Global_Set:AddDifficulty(AL["Normal"], "n")

local SOURCE_INFO = Global_Set:AddInfoList("DUMMY")

-- TestSet after loading looks like
--[[
["GMTESTSET"] = {
	["name"] = "GM",
	["__addonName"] = "global",
	{
		["subSetName"] = "gm",
		["name"] = "GM",
		["__id"] = 1,
		[201] = {		-- 201 is the intern diff number
			12064, -- [1]
			2586, -- [2]
			11508, -- [3]
			33475, -- [4]
			["itemTable"] = {
				12064, -- [1]
				2586, -- [2]
				11508, -- [3]
				33475, -- [4]
			},
		},
	}, -- [1]
	["subSetNames"] = {
		["gm"] = {
			["subSetName"] = "gm",
			["name"] = "GM",
			["__id"] = 1,
			[201] = {		-- 201 is the intern diff number
				12064, -- [1]
				2586, -- [2]
				11508, -- [3]
				33475, -- [4]
				["itemTable"] = {
					12064, -- [1]
					2586, -- [2]
					11508, -- [3]
					33475, -- [4]
				},
			},

		},
	},
},
]]--

local globalSetTable = {
	["GMTESTSET"] = {	-- T17 Sets
		name = "GM",
		{	-- Deathknight
			name = "GM",
			subSetName = "gm",
			[NORMAL_DIFF] = {
				12064,
				2586,
				11508,
				33475,	-- Frostmourne
			},
		},
	},
	-- TODO: Add better description and the class icons with fallback to Head->Robe->FirstItem(?) slot icon
	["SetID"] = {
		name = AL["Sets"],
		{
			name = AL["The Gladiator"],
			subSetName = "1",
			[NORMAL_DIFF] = { 11729, 11726, 11728, 11731, 11730},
			icon = 11729,
		},
		{
			name = AL["Dal'Rend's Arms"],
			subSetName = "41",
			[NORMAL_DIFF] = { 12940, 12939 }
		},
		{
			name = AL["Spider's Kiss"],
			subSetName = "65",
			[NORMAL_DIFF] = { 13218, 13183 }
		},
		{
			name = AL["The Postmaster"],
			subSetName = "81",
			[NORMAL_DIFF] = { 13390, 13388, 13391, 13392, 13389},
			icon = 13390,
		},
		{
			name = AL["Cadaverous Garb"],
			subSetName = "121",
			[NORMAL_DIFF] = { 14637, 14636, 14640, 14638, 14641},
			icon = 14637,
		},
		{
			name = AL["Necropile Raiment"],
			subSetName = "122",
			[NORMAL_DIFF] = { 14631, 14629, 14632, 14633, 14626 }
		},
		{
			name = AL["Bloodmail Regalia"],
			subSetName = "123",
			[NORMAL_DIFF] = { 14614, 14616, 14615, 14611, 14612},
			icon = 14611,
		},
		{
			name = AL["Deathbone Guardian"],
			subSetName = "124",
			[NORMAL_DIFF] = { 14624, 14622, 14620, 14623, 14621},
			icon = 14624,
		},
		{
			name = AL["Volcanic Armor"],
			subSetName = "141",
			[NORMAL_DIFF] = { 15053, 15054, 15055},
			icon = 15053,
		},
		{
			name = AL["Stormshroud Armor"],
			subSetName = "142",
			[NORMAL_DIFF] = { 15056, 15057, 15058, 21278},
			icon = 15056,
		},
		{
			name = AL["Devilsaur Armor"],
			subSetName = "143",
			[NORMAL_DIFF] = { 15062, 15063 }
		},
		{
			name = AL["Ironfeather Armor"],
			subSetName = "144",
			[NORMAL_DIFF] = { 15066, 15067},
			icon = 15066,
		},
		{
			name = AL["Defias Leather"],
			subSetName = "161",
			[NORMAL_DIFF] = { 10399, 10403, 10402, 10401, 10400},
			icon = 10399,
		},
		{
			name = AL["Embrace of the Viper"],
			subSetName = "162",
			[NORMAL_DIFF] = { 10412, 10411, 10413, 10410, 6473},
			icon = 6473,
		},
		{
			name = AL["Chain of the Scarlet Crusade"],
			subSetName = "163",
			[NORMAL_DIFF] = { 10329, 10332, 10328, 10331, 10330, 10333},
			icon = 10328,
		},
		{
			name = AL["Magister's Regalia"],
			subSetName = "181",
			[NORMAL_DIFF] = { 16685, 16683, 16686, 16684, 16687, 16689, 16688, 16682},
			icon = 16686,
		},
		{
			name = AL["Vestments of the Devout"],
			subSetName = "182",
			[NORMAL_DIFF] = { 16696, 16691, 16697, 16693, 16692, 16695, 16694, 16690},
			icon = 16693,
		},
		{
			name = AL["Dreadmist Raiment"],
			subSetName = "183",
			[NORMAL_DIFF] = { 16702, 16703, 16699, 16701, 16700, 16704, 16698, 16705},
			icon = 16698,
		},
		{
			name = AL["Shadowcraft Armor"],
			subSetName = "184",
			[NORMAL_DIFF] = { 16713, 16711, 16710, 16721, 16708, 16709, 16712, 16707},
			icon = 16707,
		},
		{
			name = AL["Wildheart Raiment"],
			subSetName = "185",
			[NORMAL_DIFF] = { 16716, 16715, 16714, 16720, 16706, 16718, 16719, 16717},
			icon = 16720,
		},
		{
			name = AL["Beaststalker Armor"],
			subSetName = "186",
			[NORMAL_DIFF] = { 16680, 16675, 16681, 16677, 16674, 16678, 16679, 16676},
			icon = 16677,
		},
		{
			name = AL["The Elements"],
			subSetName = "187",
			[NORMAL_DIFF] = { 16673, 16670, 16671, 16667, 16672, 16668, 16669, 16666},
			icon = 16667,
		},
		{
			name = AL["Lightforge Armor"],
			subSetName = "188",
			[NORMAL_DIFF] = { 16723, 16725, 16722, 16726, 16724, 16728, 16729, 16727},
			icon = 16727,
		},
		{
			name = AL["Battlegear of Valor"],
			subSetName = "189",
			[NORMAL_DIFF] = { 16736, 16734, 16735, 16730, 16737, 16731, 16732, 16733},
			icon = 16731,
		},
		{
			name = AL["Arcanist Regalia"],
			subSetName = "201",
			[NORMAL_DIFF] = { 16802, 16799, 16795, 16800, 16801, 16796, 16797, 16798},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Vestments of Prophecy"],
			subSetName = "202",
			[NORMAL_DIFF] = { 16811, 16813, 16817, 16812, 16814, 16816, 16815, 16819},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Felheart Raiment"],
			subSetName = "203",
			[NORMAL_DIFF] = { 16806, 16804, 16805, 16810, 16809, 16807, 16808, 16803},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Nightslayer Armor"],
			subSetName = "204",
			[NORMAL_DIFF] = { 16827, 16824, 16825, 16820, 16821, 16826, 16822, 16823},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Cenarion Raiment"],
			subSetName = "205",
			[NORMAL_DIFF] = { 16828, 16829, 16830, 16833, 16831, 16834, 16835, 16836},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Giantstalker Armor"],
			subSetName = "206",
			[NORMAL_DIFF] = { 16851, 16849, 16850, 16845, 16848, 16852, 16846, 16847},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["The Earthfury"],
			subSetName = "207",
			[NORMAL_DIFF] = { 16838, 16837, 16840, 16841, 16844, 16839, 16842, 16843},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Lawbringer Armor"],
			subSetName = "208",
			[NORMAL_DIFF] = { 16858, 16859, 16857, 16853, 16860, 16854, 16855, 16856},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Battlegear of Might"],
			subSetName = "209",
			[NORMAL_DIFF] = { 16864, 16861, 16865, 16863, 16866, 16867, 16868, 16862},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Netherwind Regalia"],
			subSetName = "210",
			[NORMAL_DIFF] = { 16818, 16918, 16912, 16914, 16917, 16913, 16915, 16916},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Vestments of Transcendence"],
			subSetName = "211",
			[NORMAL_DIFF] = { 16925, 16926, 16919, 16921, 16920, 16922, 16924, 16923},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Nemesis Raiment"],
			subSetName = "212",
			[NORMAL_DIFF] = { 16933, 16927, 16934, 16928, 16930, 16931, 16929, 16932},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Bloodfang Armor"],
			subSetName = "213",
			[NORMAL_DIFF] = { 16910, 16906, 16911, 16905, 16907, 16908, 16909, 16832},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Stormrage Raiment"],
			subSetName = "214",
			[NORMAL_DIFF] = { 16903, 16898, 16904, 16897, 16900, 16899, 16901, 16902},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Dragonstalker Armor"],
			subSetName = "215",
			[NORMAL_DIFF] = { 16936, 16935, 16942, 16940, 16941, 16939, 16938, 16937},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["The Ten Storms"],
			subSetName = "216",
			[NORMAL_DIFF] = { 16944, 16943, 16950, 16945, 16948, 16949, 16947, 16946},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Judgement Armor"],
			subSetName = "217",
			[NORMAL_DIFF] = { 16952, 16951, 16958, 16955, 16956, 16954, 16957, 16953},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Battlegear of Wrath"],
			subSetName = "218",
			[NORMAL_DIFF] = { 16959, 16966, 16964, 16963, 16962, 16961, 16965, 16960},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Garb of Thero-shan"],
			subSetName = "221",
			[NORMAL_DIFF] = { 7950, 7948, 7952, 7951, 7953, 7949},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Shard of the Gods"],
			subSetName = "241",
			[NORMAL_DIFF] = { 17082, 17064 }
		},
		{
			name = AL["Spirit of Eskhandar"],
			subSetName = "261",
			[NORMAL_DIFF] = { 18203, 18202, 18204, 18205 }
		},
		{
			name = AL["Champion's Battlegear"],
			subSetName = "281",
			[NORMAL_DIFF] = { 16509, 16510, 16513, 16515, 16514, 16516},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Lieutenant Commander's Battlegear"],
			subSetName = "282",
			[NORMAL_DIFF] = { 16405, 16406, 16430, 16431, 16429, 16432},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Champion's Earthshaker"],
			subSetName = "301",
			[NORMAL_DIFF] = { 16519, 16518, 16522, 16523, 16521, 16524},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Imperial Plate"],
			subSetName = "321",
			[NORMAL_DIFF] = { 12424, 12426, 12425, 12422, 12427, 12429, 12428},
			icon = 12427,
		},
		{
			name = AL["Champion's Regalia"],
			subSetName = "341",
			[NORMAL_DIFF] = { 16485, 16487, 16491, 16490, 16489, 16492},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Champion's Raiment"],
			subSetName = "342",
			[NORMAL_DIFF] = { 17616, 17617, 17612, 17611, 17613, 17610},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Lieutenant Commander's Regalia"],
			subSetName = "343",
			[NORMAL_DIFF] = { 16369, 16391, 16413, 16414, 16416, 16415},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Lieutenant Commander's Raiment"],
			subSetName = "344",
			[NORMAL_DIFF] = { 17594, 17596, 17600, 17599, 17598, 17601},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Champion's Threads"],
			subSetName = "345",
			[NORMAL_DIFF] = { 17576, 17577, 17572, 17571, 17570, 17573},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Lieutenant Commander's Threads"],
			subSetName = "346",
			[NORMAL_DIFF] = { 17562, 17564, 17568, 17567, 17569, 17566},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Champion's Vestments"],
			subSetName = "347",
			[NORMAL_DIFF] = { 16498, 16499, 16505, 16508, 16506, 16507},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Lieutenant Commander's Vestments"],
			subSetName = "348",
			[NORMAL_DIFF] = { 16392, 16396, 16417, 16419, 16420, 16418},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Champion's Pursuit"],
			subSetName = "361",
			[NORMAL_DIFF] = { 16531, 16530, 16525, 16527, 16526, 16528},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Lieutenant Commander's Pursuit"],
			subSetName = "362",
			[NORMAL_DIFF] = { 16425, 16426, 16401, 16403, 16428, 16427},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Lieutenant Commander's Sanctuary"],
			subSetName = "381",
			[NORMAL_DIFF] = { 16423, 16424, 16422, 16421, 16393, 16397},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Champion's Sanctuary"],
			subSetName = "382",
			[NORMAL_DIFF] = { 16494, 16496, 16504, 16502, 16503, 16501},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Warlord's Battlegear"],
			subSetName = "383",
			[NORMAL_DIFF] = { 16541, 16542, 16544, 16545, 16548, 16543},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Field Marshal's Battlegear"],
			subSetName = "384",
			[NORMAL_DIFF] = { 16477, 16478, 16480, 16483, 16484, 16479},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Warlord's Earthshaker"],
			subSetName = "386",
			[NORMAL_DIFF] = { 16577, 16578, 16580, 16573, 16574, 16579},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Warlord's Regalia"],
			subSetName = "387",
			[NORMAL_DIFF] = { 16536, 16533, 16535, 16539, 16540, 16534},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Field Marshal's Regalia"],
			subSetName = "388",
			[NORMAL_DIFF] = { 16441, 16444, 16443, 16437, 16440, 16442},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Field Marshal's Raiment"],
			subSetName = "389",
			[NORMAL_DIFF] = { 17604, 17603, 17605, 17608, 17607, 17602},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Warlord's Raiment"],
			subSetName = "390",
			[NORMAL_DIFF] = { 17623, 17625, 17622, 17624, 17618, 17620},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Warlord's Threads"],
			subSetName = "391",
			[NORMAL_DIFF] = { 17586, 17588, 17593, 17591, 17590, 17592},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Field Marshal's Threads"],
			subSetName = "392",
			[NORMAL_DIFF] = { 17581, 17580, 17583, 17584, 17579, 17578},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Warlord's Vestments"],
			subSetName = "393",
			[NORMAL_DIFF] = { 16563, 16561, 16562, 16564, 16560, 16558},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Field Marshal's Vestments"],
			subSetName = "394",
			[NORMAL_DIFF] = { 16453, 16457, 16455, 16446, 16454, 16456},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Field Marshal's Pursuit"],
			subSetName = "395",
			[NORMAL_DIFF] = { 16466, 16465, 16468, 16462, 16463, 16467},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Warlord's Pursuit"],
			subSetName = "396",
			[NORMAL_DIFF] = { 16569, 16571, 16567, 16565, 16566, 16568},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Field Marshal's Sanctuary"],
			subSetName = "397",
			[NORMAL_DIFF] = { 16452, 16451, 16449, 16459, 16448, 16450},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Warlord's Sanctuary"],
			subSetName = "398",
			[NORMAL_DIFF] = { 16554, 16555, 16552, 16551, 16549, 16550},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Lieutenant Commander's Aegis"],
			subSetName = "401",
			[NORMAL_DIFF] = { 16410, 16409, 16433, 16435, 16434, 16436},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Field Marshal's Aegis"],
			subSetName = "402",
			[NORMAL_DIFF] = { 16473, 16474, 16476, 16472, 16471, 16475},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Bloodvine Garb"],
			subSetName = "421",
			[NORMAL_DIFF] = { 19682, 19683, 19684},
			icon = 19682,
		},
		{
			name = AL["Primal Batskin"],
			subSetName = "441",
			[NORMAL_DIFF] = { 19685, 19687, 19686},
			icon = 19685,
		},
		{
			name = AL["Blood Tiger Harness"],
			subSetName = "442",
			[NORMAL_DIFF] = { 19688, 19689},
			icon = 19688,
		},
		{
			name = AL["Bloodsoul Embrace"],
			subSetName = "443",
			[NORMAL_DIFF] = { 19690, 19691, 19692},
			icon = 19690,
		},
		{
			name = AL["The Darksoul"],
			subSetName = "444",
			[NORMAL_DIFF] = { 19693, 19694, 19695},
			icon = 19693,
		},
		{
			name = AL["The Twin Blades of Hakkari"],
			subSetName = "461",
			[NORMAL_DIFF] = { 19865, 19866 }
		},
		{
			name = AL["Zanzil's Concentration"],
			subSetName = "462",
			[NORMAL_DIFF] = { 19905, 19893 }
		},
		{
			name = AL["Primal Blessing"],
			subSetName = "463",
			[NORMAL_DIFF] = { 19896, 19910 }
		},
		{
			name = AL["Overlord's Resolution"],
			subSetName = "464",
			[NORMAL_DIFF] = { 19873, 19912 }
		},
		{
			name = AL["Prayer of the Primal"],
			subSetName = "465",
			[NORMAL_DIFF] = { 19863, 19920 }
		},
		{
			name = AL["Major Mojo Infusion"],
			subSetName = "466",
			[NORMAL_DIFF] = { 19898, 19925 }
		},
		{
			name = AL["The Highlander's Resolution"],
			subSetName = "467",
			[NORMAL_DIFF] = { 20041, 20048, 20057 }
		},
		{
			name = AL["The Highlander's Resolve"],
			subSetName = "468",
			[NORMAL_DIFF] = { 20042, 20049, 20058},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["The Highlander's Determination"],
			subSetName = "469",
			[NORMAL_DIFF] = { 20043, 20050, 20055},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["The Highlander's Fortitude"],
			subSetName = "470",
			[NORMAL_DIFF] = { 20044, 20051, 20056},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["The Highlander's Purpose"],
			subSetName = "471",
			[NORMAL_DIFF] = { 20052, 20045, 20059 }
		},
		{
			name = AL["The Highlander's Will"],
			subSetName = "472",
			[NORMAL_DIFF] = { 20053, 20046, 20060 }
		},
		{
			name = AL["The Highlander's Intent"],
			subSetName = "473",
			[NORMAL_DIFF] = { 20054, 20047, 20061 }
		},
		{
			name = AL["Vindicator's Battlegear"],
			subSetName = "474",
			[NORMAL_DIFF] = { 19951, 19577, 19824, 19823, 19822},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Freethinker's Armor"],
			subSetName = "475",
			[NORMAL_DIFF] = { 19952, 19588, 19827, 19826, 19825},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Augur's Regalia"],
			subSetName = "476",
			[NORMAL_DIFF] = { 19609, 19956, 19830, 19829, 19828},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Predator's Armor"],
			subSetName = "477",
			[NORMAL_DIFF] = { 19621, 19953, 19833, 19832, 19831},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Madcap's Outfit"],
			subSetName = "478",
			[NORMAL_DIFF] = { 19617, 19954, 19836, 19835, 19834},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Haruspex's Garb"],
			subSetName = "479",
			[NORMAL_DIFF] = { 19613, 19955, 19840, 19839, 19838},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Confessor's Raiment"],
			subSetName = "480",
			[NORMAL_DIFF] = { 19594, 19958, 19843, 19842, 19841},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Demoniac's Threads"],
			subSetName = "481",
			[NORMAL_DIFF] = { 19605, 19957, 19848, 19849, 20033},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Illusionist's Attire"],
			subSetName = "482",
			[NORMAL_DIFF] = { 19601, 19959, 19846, 19845, 20034},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["The Defiler's Determination"],
			subSetName = "483",
			[NORMAL_DIFF] = { 20158, 20154, 20150 }
		},
		{
			name = AL["The Defiler's Fortitude"],
			subSetName = "484",
			[NORMAL_DIFF] = { 20195, 20199, 20203 }
		},
		{
			name = AL["The Defiler's Intent"],
			subSetName = "485",
			[NORMAL_DIFF] = { 20176, 20159, 20163 }
		},
		{
			name = AL["The Defiler's Purpose"],
			subSetName = "486",
			[NORMAL_DIFF] = { 20186, 20190, 20194 }
		},
		{
			name = AL["The Defiler's Resolution"],
			subSetName = "487",
			[NORMAL_DIFF] = { 20204, 20208, 20212},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["The Defiler's Will"],
			subSetName = "488",
			[NORMAL_DIFF] = { 20167, 20171, 20175 }
		},
		{
			name = AL["Black Dragon Mail"],
			subSetName = "489",
			[NORMAL_DIFF] = { 16984, 15050, 15052, 15051},
			icon = 15050,
		},
		{
			name = AL["Green Dragon Mail"],
			subSetName = "490",
			[NORMAL_DIFF] = { 15045, 15046, 20296},
			icon = 15045,
		},
		{
			name = AL["Blue Dragon Mail"],
			subSetName = "491",
			[NORMAL_DIFF] = { 15048, 20295, 15049},
			icon = 15048,
		},
		{
			name = AL["Twilight Trappings"],
			subSetName = "492",
			[NORMAL_DIFF] = { 20406, 20408, 20407},
			icon = 20408,
		},
		{
			name = AL["Genesis Raiment"],
			subSetName = "493",
			[NORMAL_DIFF] = { 21355, 21353, 21354, 21356, 21357},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Symbols of Unending Life"],
			subSetName = "494",
			[NORMAL_DIFF] = { 21408, 21409, 21407},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Battlegear of Unyielding Strength"],
			subSetName = "495",
			[NORMAL_DIFF] = { 21394, 21392, 21393},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Conqueror's Battlegear"],
			subSetName = "496",
			[NORMAL_DIFF] = { 21331, 21329, 21333, 21332},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Deathdealer's Embrace"],
			subSetName = "497",
			[NORMAL_DIFF] = {  }
		},
		{
			name = AL["Emblems of Veiled Shadows"],
			subSetName = "498",
			[NORMAL_DIFF] = { 21405, 21406, 21404},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Doomcaller's Attire"],
			subSetName = "499",
			[NORMAL_DIFF] = { 21337, 21338, 21335, 21334, 21336},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Implements of Unspoken Names"],
			subSetName = "500",
			[NORMAL_DIFF] = { 21416, 21417, 21418},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Stormcaller's Garb"],
			subSetName = "501",
			[NORMAL_DIFF] = { 21372, 21373, 21374, 21375, 21376},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Gift of the Gathering Storm"],
			subSetName = "502",
			[NORMAL_DIFF] = { 21400, 21398, 21399},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Enigma Vestments"],
			subSetName = "503",
			[NORMAL_DIFF] = { 21344, 21347, 21346, 21343, 21345},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Trappings of Vaulted Secrets"],
			subSetName = "504",
			[NORMAL_DIFF] = { 21414, 21413, 21415},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Avenger's Battlegear"],
			subSetName = "505",
			[NORMAL_DIFF] = { 21389, 21387, 21388, 21390, 21391},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Battlegear of Eternal Justice"],
			subSetName = "506",
			[NORMAL_DIFF] = { 21397, 21395, 21396},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Garments of the Oracle"],
			subSetName = "507",
			[NORMAL_DIFF] = { 21349, 21350, 21348, 21352, 21351},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Finery of Infinite Wisdom"],
			subSetName = "508",
			[NORMAL_DIFF] = { 21410, 21411, 21412},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Striker's Garb"],
			subSetName = "509",
			[NORMAL_DIFF] = { 21366, 21365, 21370, 21368, 21367},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Trappings of the Unseen Path"],
			subSetName = "510",
			[NORMAL_DIFF] = { 21403, 21401, 21402},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Battlegear of Heroism"],
			subSetName = "511",
			[NORMAL_DIFF] = { 21994, 21995, 21996, 21997, 21998, 21999, 22000, 22001},
			icon = 21999,
		},
		{
			name = AL["Darkmantle Armor"],
			subSetName = "512",
			[NORMAL_DIFF] = { 22002, 22003, 22004, 22005, 22006, 22007, 22008, 22009},
			icon = 22005,
		},
		{
			name = AL["Feralheart Raiment"],
			subSetName = "513",
			[NORMAL_DIFF] = { 22106, 22107, 22108, 22109, 22110, 22111, 22112, 22113},
			icon = 22109,
		},
		{
			name = AL["Vestments of the Virtuous"],
			subSetName = "514",
			[NORMAL_DIFF] = { 22078, 22079, 22080, 22081, 22082, 22083, 22084, 22085},
			icon = 22080,
		},
		{
			name = AL["Beastmaster Armor"],
			subSetName = "515",
			[NORMAL_DIFF] = { 22010, 22011, 22061, 22013, 22015, 22016, 22017, 22060},
			icon = 22013,
		},
		{
			name = AL["Soulforge Armor"],
			subSetName = "516",
			[NORMAL_DIFF] = { 22086, 22087, 22088, 22089, 22090, 22091, 22092, 22093},
			icon = 22091,
		},
		{
			name = AL["Sorcerer's Regalia"],
			subSetName = "517",
			[NORMAL_DIFF] = { 22062, 22063, 22064, 22065, 22066, 22067, 22068, 22069},
			icon = 22065,
		},
		{
			name = AL["Deathmist Raiment"],
			subSetName = "518",
			[NORMAL_DIFF] = { 22070, 22071, 22072, 22073, 22074, 22075, 22076, 22077},
			icon = 22074,
		},
		{
			name = AL["The Five Thunders"],
			subSetName = "519",
			[NORMAL_DIFF] = { 22095, 22096, 22097, 22098, 22099, 22100, 22101, 22102},
			icon = 22097,
		},
		{
			name = AL["Ironweave Battlesuit"],
			subSetName = "520",
			[NORMAL_DIFF] = { 22306, 22311, 22313, 22302, 22304, 22305, 22303, 22301},
			icon = 22302,
		},
		{
			name = AL["Dreamwalker Raiment"],
			subSetName = "521",
			[NORMAL_DIFF] = { 22492, 22494, 22493, 22490, 22489, 22491, 22488, 22495, 23064},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Champion's Guard"],
			subSetName = "522",
			[NORMAL_DIFF] = { 22864, 22856, 22879, 22880, 23257, 23258},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Dreadnaught's Battlegear"],
			subSetName = "523",
			[NORMAL_DIFF] = { 22423, 22416, 22421, 22422, 22418, 22417, 22419, 22420},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Bonescythe Armor"],
			subSetName = "524",
			[NORMAL_DIFF] = { 22483, 22476, 22481, 22478, 22477, 22479, 22480, 22482, 23060},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Vestments of Faith"],
			subSetName = "525",
			[NORMAL_DIFF] = { 22518, 22519, 22514, 22517, 22513, 22512, 22516, 22515, 23061},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Frostfire Regalia"],
			subSetName = "526",
			[NORMAL_DIFF] = { 22502, 22503, 22498, 22501, 22497, 22496, 22500, 22499, 23062},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["The Earthshatterer"],
			subSetName = "527",
			[NORMAL_DIFF] = { 22468, 22470, 22469, 22466, 22465, 22467, 22464, 22471, 23065},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Redemption Armor"],
			subSetName = "528",
			[NORMAL_DIFF] = { 22430, 22431, 22426, 22428, 22427, 22429, 22425, 22424, 23066},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Plagueheart Raiment"],
			subSetName = "529",
			[NORMAL_DIFF] = { 22510, 22511, 22506, 22509, 22505, 22504, 22508, 22507, 23063},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Cryptstalker Armor"],
			subSetName = "530",
			[NORMAL_DIFF] = { 22440, 22442, 22441, 22438, 22437, 22439, 22436, 22443, 23067},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Battlegear of Undead Slaying"],
			subSetName = "533",
			[NORMAL_DIFF] = { 23090, 23087, 23078},
			icon = 23087,
		},
		{
			name = AL["Undead Slayer's Armor"],
			subSetName = "534",
			[NORMAL_DIFF] = { 23081, 23089, 23093},
			icon = 23089,
		},
		{
			name = AL["Garb of the Undead Slayer"],
			subSetName = "535",
			[NORMAL_DIFF] = { 23088, 23082, 23092},
			icon = 23088,
		},
		{
			name = AL["Regalia of Undead Cleansing"],
			subSetName = "536",
			[NORMAL_DIFF] = { 23091, 23084, 23085 }
		},
		{
			name = AL["Champion's Battlearmor"],
			subSetName = "537",
			[NORMAL_DIFF] = { 22868, 22858, 22872, 22873, 23244, 23243},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Champion's Stormcaller"],
			subSetName = "538",
			[NORMAL_DIFF] = { 22857, 22867, 22876, 22887, 23259, 23260},
			desc = ALIL["SHAMAN"],
			icon = "SHAMAN",
		},
		{
			name = AL["Champion's Refuge"],
			subSetName = "539",
			[NORMAL_DIFF] = { 22863, 22852, 22877, 22878, 23253, 23254},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
		{
			name = AL["Champion's Investiture"],
			subSetName = "540",
			[NORMAL_DIFF] = { 22869, 22859, 22882, 22885, 23261, 23262},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Champion's Dreadgear"],
			subSetName = "541",
			[NORMAL_DIFF] = { 22865, 22855, 23255, 23256, 22881, 22884},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Champion's Arcanum"],
			subSetName = "542",
			[NORMAL_DIFF] = { 22870, 22860, 23263, 23264, 22883, 22886},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Champion's Pursuance"],
			subSetName = "543",
			[NORMAL_DIFF] = { 22843, 22862, 23251, 23252, 22874, 22875},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Lieutenant Commander's Redoubt"],
			subSetName = "544",
			[NORMAL_DIFF] = { 23272, 23273, 23274, 23275, 23276, 23277},
			desc = ALIL["PALADIN"],
			icon = "PALADIN",
		},
		{
			name = AL["Lieutenant Commander's Battlearmor"],
			subSetName = "545",
			[NORMAL_DIFF] = { 23300, 23301, 23286, 23287, 23314, 23315},
			desc = ALIL["WARRIOR"],
			icon = "WARRIOR",
		},
		{
			name = AL["Lieutenant Commander's Arcanum"],
			subSetName = "546",
			[NORMAL_DIFF] = { 23304, 23305, 23290, 23291, 23318, 23319},
			desc = ALIL["MAGE"],
			icon = "MAGE",
		},
		{
			name = AL["Lieutenant Commander's Dreadgear"],
			subSetName = "547",
			[NORMAL_DIFF] = { 23296, 23297, 23282, 23283, 23310, 23311},
			desc = ALIL["WARLOCK"],
			icon = "WARLOCK",
		},
		{
			name = AL["Lieutenant Commander's Guard"],
			subSetName = "548",
			[NORMAL_DIFF] = { 23298, 23299, 23284, 23285, 23312, 23313},
			desc = ALIL["ROGUE"],
			icon = "ROGUE",
		},
		{
			name = AL["Lieutenant Commander's Investiture"],
			subSetName = "549",
			[NORMAL_DIFF] = { 23302, 23303, 23288, 23289, 23316, 23317},
			desc = ALIL["PRIEST"],
			icon = "PRIEST",
		},
		{
			name = AL["Lieutenant Commander's Pursuance"],
			subSetName = "550",
			[NORMAL_DIFF] = { 23292, 23293, 23278, 23279, 23306, 23307},
			desc = ALIL["HUNTER"],
			icon = "HUNTER",
		},
		{
			name = AL["Lieutenant Commander's Refuge"],
			subSetName = "551",
			[NORMAL_DIFF] = { 23294, 23295, 23280, 23281, 23308, 23309},
			desc = ALIL["DRUID"],
			icon = "DRUID",
		},
	}

}
Global_Set:SetContentTable(globalSetTable)
