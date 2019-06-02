-- Set data is mostly loaded with "AtlasLoot_Collections"

local AtlasLoot = _G.AtlasLoot
local Sets = {}
AtlasLoot.Data.Sets = Sets
local AL = AtlasLoot.Locales
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
	hunter = "Interface\\Icons\\ClassIcon_Hunter",
	mage = "Interface\\Icons\\ClassIcon_Mage",
	rogue = "Interface\\Icons\\ClassIcon_Rogue",
	warlock = "Interface\\Icons\\ClassIcon_Warlock",
	monk = "Interface\\Icons\\ClassIcon_Monk",
	monkTank = "Interface\\Icons\\spell_monk_brewmaster_spec",
	monkHeal = "Interface\\Icons\\spell_monk_mistweaver_spec",
	monkDPS = "Interface\\Icons\\spell_monk_windwalker_spec",
	shaman = "Interface\\Icons\\ClassIcon_Shaman",
	shamanEle = "Interface\\Icons\\Spell_Nature_Lightning",
	shamanEnhanc = "Interface\\Icons\\spell_nature_lightningshield",
	shamanResto = "Interface\\Icons\\spell_nature_magicimmunity",
	dk = "Interface\\Icons\\ClassIcon_DeathKnight",
	dkDPS = "Interface\\Icons\\spell_deathknight_frostpresence",
	dkTank = "Interface\\Icons\\spell_deathknight_bloodpresence",
	dh = "Interface\\Icons\\ClassIcon_DemonHunter",
	dhHavoc = "Interface\\Icons\\Ability_DemonHunter_SpecDPS",
	dhVengeance = "Interface\\Icons\\Ability_DemonHunter_SpecTank",
	priest = "Interface\\Icons\\ClassIcon_Priest",
	priestHeal = "Interface\\Icons\\spell_holy_guardianspirit",
	priestShadow = "Interface\\Icons\\spell_shadow_shadowwordpain",
	druid = "Interface\\Icons\\ClassIcon_Druid",
	druidBalance = "Interface\\Icons\\spell_nature_starfall",
	druidDPS = "Interface\\Icons\\ability_druid_catform",
	druidTank = "Interface\\Icons\\ability_racial_bearform",
	druidResto = "Interface\\Icons\\spell_nature_healingtouch",
	pala = "Interface\\Icons\\ClassIcon_Paladin",
	palaHoly = "Interface\\Icons\\Spell_Holy_HolyBolt",
	palaProt = "Interface\\Icons\\spell_holy_devotionaura",
	palaRetri = "Interface\\Icons\\Spell_Holy_AuraOfLight",
	warri = "Interface\\Icons\\ClassIcon_Warrior",
	warriDPS = "Interface\\Icons\\ability_warrior_innerrage",
	warriProt = "Interface\\Icons\\ability_warrior_defensivestance",
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
	subSetName = self:GetDiffTable(subSetName, curDiff)
	return ( subSetName and subSetName.icon ) and subSetName.icon or (self.icon or NO_ICON)
end

-- name, desc, icon
local DIFF_FORMAT_NAME = "%s (%s)"
function SingleSet_Proto:GetInfo(subSetName, curDiff)
	subSetName = self:Get(subSetName)
	local name = ( subSetName and subSetName.name ) and subSetName.name or self.name
	local desc = ( subSetName and subSetName.name ) and self.name or ( subSetName and subSetName.name ) and subSetName.name or ""
	if curDiff then
		desc = format(DIFF_FORMAT_NAME, desc, self:GetDifficultyName(curDiff))
	end
	local icon = ( subSetName and subSetName.icon ) and (ICON_PATH_PRE[subSetName.icon] or subSetName.icon) or ((ICON_PATH_PRE[self.icon] or self.icon) or NO_ICON)
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
	return Loaded_Sets[addonName] and Loaded_Sets[addonName][setName] or nil
end

-- ################
-- global set
-- ################

local Global_Set = Sets:RegisterNewSets(GLOBAL_SETS)

local NORMAL_DIFF = Global_Set:AddDifficulty(AL["Normal"], "n")

local SOURCE_INFO = Global_Set:AddInfoList("DUMMY")

-- TestSet after loaidng looks like
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
	}
}
Global_Set:SetContentTable(globalSetTable)
