local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

-- Minimap
Options.orderNumber = Options.orderNumber + 1
Options.config.args.minimap = {
	type = "group",
	name = AL["Minimap Button"],
	order = Options.orderNumber,
	get = function(info) return AtlasLoot.db.minimap[info[#info]] end,
	set = function(info, value) AtlasLoot.db.minimap[info[#info]] = value end,
	args = {
		resetFrame = {
			order = 1,
			type = "execute",
			name = AL["Reset position of minimap button"],
			desc = AL["Reset position of the |cff33ff99\"Minimap button\"|r."],
			confirm = true,
			func = function()
				AtlasLoot.SlashCommands:Reset("mmb")
			end,
		},
		shown = {
			order = 2,
			type = "toggle",
			width = "full",
			name = AL["Show minimap button."],
			set = function(info, value)
				AtlasLoot.db.minimap[info[#info]] = value
				AtlasLoot.MiniMapButton.Options_Toggle()
			end,
		},
		locked = {
			order = 3,
			type = "toggle",
			width = "full",
			name = AL["Lock minimap button."],
			set = function(info, value)
				AtlasLoot.db.minimap[info[#info]] = value
				AtlasLoot.MiniMapButton.Lock_Toggle()
			end,
		},
	},
}