local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

-- AtlasLoot
Options.orderNumber = Options.orderNumber + 1
Options.config.args.atlasloot = {
	type = "group",
	name = AL["AtlasLoot"],
	order = Options.orderNumber,
	args = {
		ignoreScalePopup = {
			order = 1,
			type = "toggle",
			width = "full",
			name = AL["Use GameTooltip"],
			desc = AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"],
			get = function(info) return AtlasLoot.db.Tooltip.useGameTooltip end,
			set = function(info, value) AtlasLoot.db.Tooltip.useGameTooltip = value AtlasLoot.Tooltip.Refresh() end
		},
		showIDsInTT = {
			order = 2,
			type = "toggle",
			width = "full",
			name = AL["Show ID's in tooltip."],
			get = function(info) return AtlasLoot.db.showIDsInTT end,
			set = function(info, value) AtlasLoot.db.showIDsInTT = value end
		},
	},
}
