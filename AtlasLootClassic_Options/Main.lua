local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

local format = format

local function UpdateItemFrame()
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
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
		useGameTooltip = {
			order = 1,
			type = "toggle",
			width = "full",
			name = AL["Use GameTooltip"],
			desc = AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"],
			get = function(info) return AtlasLoot.db.Tooltip.useGameTooltip end,
			set = function(info, value) AtlasLoot.db.Tooltip.useGameTooltip = value end,
		},
		showIDsInTT = {
			order = 2,
			type = "toggle",
			width = "full",
			name = AL["Show ID's in tooltip."],
		},
		showLvlRange = {
			order = 3,
			type = "toggle",
			width = "full",
			name = AL["Show level range if aviable."],
			get = function(info) return AtlasLoot.db.showLvlRange end,
			set = function(info, value) AtlasLoot.db.showLvlRange = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		showMinEnterLvl = {
			order = 4,
			type = "toggle",
			width = "full",
			name = AL["Show minimum level for entry."],
			disabled = function() return not AtlasLoot.db.showLvlRange end,
			get = function(info) return AtlasLoot.db.showMinEnterLvl end,
			set = function(info, value) AtlasLoot.db.showMinEnterLvl = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableWoWHeadIntegration = {
			order = 5,
			type = "toggle",
			name = AL["Enable WoWHead links."],
			desc = format("|cFFCFCFCF%s:|r %s", AL["Shift + Right Click"], AL["Shows a copyable link for WoWHead"])
		},
		useEnglishWoWHead = {
			order = 6,
			type = "toggle",
			hidden = AtlasLoot.Button:GetWoWHeadLocale() and false or true,
			name = AL["Use english WoWHead."],
		},
		enableAutoSelect = {
			order = 7,
			type = "toggle",
			width = "full",
			name = AL["Enable auto selection of instances if available."],
			desc = AL["Select instance loottable on open."],
			set = function(info, value) AtlasLoot.db.enableAutoSelect = value AtlasLoot.Data.AutoSelect:RefreshOptions() end,
		},
		enableAutoSelectBoss = {
			order = 8,
			type = "toggle",
			width = "full",
			disabled = function() return not AtlasLoot.db.enableAutoSelect end,
			name = AL["Enable auto selection of bosses if available."],
		},
		headerSetting = {
			order = 10,
			type = "header",
			name = AL["Content phase settings"],
		},
		showContentPhaseInTT = {
			order = 11,
			type = "toggle",
			width = "full",
			name = AL["Show content phase in tooltip."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableTT end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableTT = value end,
		},
		enableContentPhaseOnLootTable = {
			order = 12,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for loottables."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnLootTable end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnLootTable = value AtlasLoot.GUI.OnLevelRangeRefresh() end,
		},
		enableContentPhaseOnItems = {
			order = 13,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for items."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnItems end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnItems = value UpdateItemFrame() end,
		},
		enableContentPhaseOnCrafting = {
			order = 14,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for crafting."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnCrafting end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnCrafting = value UpdateItemFrame() end,
		},
		enableContentPhaseOnSets = {
			order = 15,
			type = "toggle",
			width = "full",
			name = AL["Show content phase indicator for sets."],
			get = function(info) return AtlasLoot.db.ContentPhase.enableOnSets end,
			set = function(info, value) AtlasLoot.db.ContentPhase.enableOnSets = value UpdateItemFrame() end,
		},
	},
}
