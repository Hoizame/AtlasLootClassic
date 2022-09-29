local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local format = format

local function UpdateItemFrame()
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
		AtlasLoot.GUI.RefreshButtons()
    end
end

-- AtlasLoot
Options.orderNumber = Options.orderNumber + 1
Options.config.args.atlasloot = {
	type = "group",
	name = AL["AtlasLoot"],
	order = Options.orderNumber,
	get = function(info) return AtlasLoot.db[info[#info]] end,
    set = function(info, value) AtlasLoot.db[info[#info]] = value end,
	args = {
		showDropRate = {
			order = 4,
			type = "toggle",
			width = "full",
			name = AL["Show drop rate if available."],
		},
		showLvlRange = {
			order = 5,
			type = "toggle",
			width = "full",
			name = AL["Show level range if available."],
			get = function(info) return AtlasLoot.db.showLvlRange end,
			set = function(info, value) AtlasLoot.db.showLvlRange = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableBossLevel = {
			order = 5.5,
			type = "toggle",
			width = "full",
			name = AL["Show boss level if available."],
			get = function(info) return AtlasLoot.db.enableBossLevel end,
			set = function(info, value) AtlasLoot.db.enableBossLevel = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		showMinEnterLvl = {
			order = 6,
			type = "toggle",
			width = "full",
			name = AL["Show minimum level for entry."],
			disabled = function() return not AtlasLoot.db.showLvlRange end,
			get = function(info) return AtlasLoot.db.showMinEnterLvl end,
			set = function(info, value) AtlasLoot.db.showMinEnterLvl = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableWoWHeadIntegration = {
			order = 7,
			type = "toggle",
			name = AL["Enable WoWHead links."],
			desc = format("|cFFCFCFCF%s:|r %s", AL["Shift + Right Click"], AL["Shows a copyable link for WoWHead"])
		},
		useEnglishWoWHead = {
			order = 8,
			type = "toggle",
			hidden = AtlasLoot.Button:GetWoWHeadLocale() and false or true,
			name = AL["Use english WoWHead."],
		},
		enableAutoSelect = {
			order = 9,
			type = "toggle",
			width = "full",
			name = AL["Enable auto selection of instances if available."],
			desc = AL["Select instance loottable on open."].."\n"..format(AL["This loads the |cff999999%s|r module."], "AtlasLootClassic_DungeonsAndRaids"),
			set = function(info, value) AtlasLoot.db.enableAutoSelect = value AtlasLoot.Data.AutoSelect:RefreshOptions() end,
		},
		enableAutoSelectBoss = {
			order = 10,
			type = "toggle",
			width = "full",
			disabled = function() return not AtlasLoot.db.enableAutoSelect end,
			name = AL["Enable auto selection of bosses if available."],
		},
		enableAtlasMapIntegration = {
			order = 11,
			type = "toggle",
			width = "full",
			name = AL["Enable Atlas map integration if available."],
			set = function(info, value) AtlasLoot.db.enableAtlasMapIntegration = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableColorsInNames = {
			order = 12,
			type = "toggle",
			width = "full",
			name = AL["Enable colored loot table names."],
		},
		headerSetting = {
			order = 20,
			type = "header",
			name = AL["Content phase settings"],
		},
		showContentPhaseInTT = {
			order = 21,
			type = "toggle",
			width = "full",
			name = AL["Show content phase in tooltip."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableTT end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableTT = value end,
		},
		enableContentPhaseOnLootTable = {
			order = 22,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for loottables."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnLootTable end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnLootTable = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableContentPhaseOnItems = {
			order = 23,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for items."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnItems end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnItems = value UpdateItemFrame() end,
		},
		enableContentPhaseOnCrafting = {
			order = 24,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for crafting."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnCrafting end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnCrafting = value UpdateItemFrame() end,
		},
		enableContentPhaseOnSets = {
			order = 25,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for sets."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnSets end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnSets = value UpdateItemFrame() end,
		},
	},
}

Options.orderNumber = Options.orderNumber + 1
Options.config.args.tooltip = {
	type = "group",
	name = AL["ToolTip"],
	childGroups = "select",
	order = Options.orderNumber,
	get = function(info) return AtlasLoot.db[info[#info]] end,
    set = function(info, value) AtlasLoot.db[info[#info]] = value end,
	args = {
		useGameTooltip = {
			order = 1,
			type = "toggle",
			width = "full",
			name = AL["Use GameTooltip"],
			desc = AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"],
			get = function(info) return AtlasLoot.db.Tooltip.useGameTooltip end,
			set = function(info, value) AtlasLoot.db.Tooltip.useGameTooltip = value end,
		},
		showTooltipInfoGlobal = {
			order = 11,
			type = "toggle",
			width = "double",
			name = AL["Show extra info in every tooltip."],
		},
		headerSetting = {
			order = 10,
			type = "header",
			name = AL["Extra tooltip info"],
		},
		showCompanionLearnedInfo = {
			order = 11,
			type = "toggle",
			width = "full",
			name = AL["Show learned info for companions."],
		},
		showIDsInTT = {
			order = 12,
			type = "toggle",
			width = "full",
			name = AL["Show ID's."],
		},
		showItemLvlInTT = {
			order = 13,
			type = "toggle",
			width = "full",
			name = AL["Show Item level."],
		},
	}
}

Options.orderNumber = Options.orderNumber + 1
Options.config.args.classfilter = {
	type = "group",
	name = AL["Class Filter"],
	childGroups = "select",
	order = Options.orderNumber,
	--get = function(info) return AtlasLoot.db[info[#info]] end,
	--set = function(info, value) AtlasLoot.db[info[#info]] = value end,
	args = {

	}
}

-- build class filter list
local ClassFilterStatList, SortedClassList, ClassFilterDB = AtlasLoot.Data.ClassFilter.GetStatListForOptions()
local classFilterTab = Options.config.args.classfilter.args
local CLASS_NAMES_WITH_COLORS = AtlasLoot:GetColoredClassNames()

-- build filterList
local OptionsFilterList = {}
for filterStatCatIndex, filterStatCat in ipairs(ClassFilterStatList) do
	OptionsFilterList[filterStatCatIndex..""] = {
		order = filterStatCatIndex,
		name = filterStatCat.name,
		type = "group",
		args = {}
	}
	local tab = OptionsFilterList[filterStatCatIndex..""].args
	for statIndex, stat in ipairs(filterStatCat) do
		if stat == "" then
			tab[statIndex..stat] = {
				order = statIndex,
				name = "",
				type = "header",
				width = "full"
			}
		elseif _G[stat] then
			tab[stat] = {
				order = statIndex,
				name = _G[stat],
				type = "toggle",
			}
		end
	end
end

for classIndex, className in ipairs(SortedClassList) do
	classFilterTab[className] = {
		order = classIndex,
		name = CLASS_NAMES_WITH_COLORS[className],
		type = "group",
		childGroups = "tab",
		get = function(info) return ClassFilterDB[className][info[#info]] end,
		set = function(info, value) ClassFilterDB[className][info[#info]] = value end,
		args = OptionsFilterList,
	}
end