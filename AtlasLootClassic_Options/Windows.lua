local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = AtlasLoot.Options
local AL = AtlasLoot.Locales

-- Windows
local function ColorPicker_Get(db)
	return db.r, db.g, db.b, db.a
end

local function ColorPicker_Set(db, r, g, b, a)
	db.r, db.g, db.b, db.a = r, g, b, a
end

Options.orderNumber = Options.orderNumber + 1
Options.config.args.windows = {
	type = "group",
	name = AL["Windows"],
	order = Options.orderNumber,
	args = {
		resetFrames = {
			order = 1,
			type = 'execute',
			name = AL["Reset frame position"],
			desc = format(AL["Reset position of the |cff33ff99\"%s\"|r window."], _G.ALL),
			confirm = true,
			func = function()
				AtlasLoot.SlashCommands:Reset("all")
			end,
		},
	},
}
local orderNum = 0

-- Windows / AtlasLoot
orderNum = orderNum + 1
Options.config.args.windows.args.main = {
	type = "group",
	name = AL["AtlasLoot"],
	childGroups = "tab",
	order = orderNum,
	args = {
		resetFrames = {
			order = 1,
			type = 'execute',
			name = AL["Reset frame position"],
			desc = format(AL["Reset position of the |cff33ff99\"%s\"|r window."], AL["AtlasLoot"]),
			confirm = true,
			func = AtlasLoot.GUI.ResetFrames,
		},
		main = {
			order = 2,
			type = "group",
			name = AL["Main"],
			get = function(info) return AtlasLoot.db.GUI.mainFrame[info[#info]] end,
			set = function(info, value) AtlasLoot.db.GUI.mainFrame[info[#info]] = value end,
			args = {
				scale = {
					order = 1,
					type = "range",
					name = AL["Scale"],
					min = 0.1, max = 1.25, step = 0.00001,
					softMin = 0.40, softMax = 1.15, bigStep = 0.01,
					set = function(info, value)
						AtlasLoot.db.GUI.mainFrame[info[#info]] = value
						AtlasLoot.GUI.RefreshMainFrame()
					end
				},
				bgColor = {
					type = "color",
					order = 2,
					name = AL["Background color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.mainFrame[info[#info]])
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.mainFrame[info[#info]], r, g, b, a)
						AtlasLoot.GUI.RefreshMainFrame()
					end,
				},
				title = {
					order = 3,
					type = "header",
					name = AL["Text"],
				},
				titleBgColor = {
					type = "color",
					order = 4,
					name = AL["Background color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.mainFrame.title.bgColor)
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.mainFrame.title.bgColor, r, g, b, a)
						AtlasLoot.GUI.RefreshMainFrame()
					end,
				},
				titleFontColor = {
					type = "color",
					order = 5,
					name = AL["Font color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.mainFrame.title.textColor)
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.mainFrame.title.textColor, r, g, b, a)
						AtlasLoot.GUI.RefreshFonts("title")
					end,
				},
				titleSize = {
					order = 6,
					type = "range",
					name = AL["Font size"],
					min = 10, max = 20, step = 1,
					get = function(info) return AtlasLoot.db.GUI.mainFrame.title.size end,
					set = function(info, value)
						AtlasLoot.db.GUI.mainFrame.title.size = value
						AtlasLoot.GUI.RefreshFonts("title")
					end
				},
				font = {
					type = "select",
					dialogControl = 'LSM30_Font',
					order = 7,
					name = AL["Font"],
					values = AceGUIWidgetLSMlists.font,
					get = function(info) return AtlasLoot.db.GUI.mainFrame.title.font end,
					set = function(info, value)
						AtlasLoot.db.GUI.mainFrame.title.font = value
						AtlasLoot.GUI.RefreshFonts("title")
					end,
				},
			},
		},
		contentTopBar = {
			order = 3,
			type = "group",
			name = AL["Content top bar"],
			get = function(info) return AtlasLoot.db.GUI.contentTopBar[info[#info]] end,
			set = function(info, value) AtlasLoot.db.GUI.contentTopBar[info[#info]] = value end,
			args = {
				backgroundH = {
					order = 1,
					type = "header",
					name = AL["Background"],
				},
				useContentColor = {
					order = 2,
					type = "toggle",
					width = "full",
					name = AL["Use content color if available."],
					set = function(info, value) AtlasLoot.db.GUI.contentTopBar.useContentColor = value AtlasLoot.GUI.RefreshContentBackGround() end
				},
				bgColor = {
					type = "color",
					order = 3,
					name = AL["Background color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.contentTopBar[info[#info]])
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.contentTopBar[info[#info]], r, g, b, a)
						AtlasLoot.GUI.RefreshContentBackGround()
					end,
				},
				text = {
					order = 4,
					type = "header",
					name = AL["Text"],
				},
				textFontColor = {
					type = "color",
					order = 5,
					name = AL["Font color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.contentTopBar.font.color)
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.contentTopBar.font.color, r, g, b, a)
						AtlasLoot.GUI.RefreshFonts("contentFrame")
					end,
				},
				textSize = {
					order = 6,
					type = "range",
					name = AL["Font size"],
					min = 10, max = 30, step = 1,
					get = function(info) return AtlasLoot.db.GUI.contentTopBar.font.size end,
					set = function(info, value)
						AtlasLoot.db.GUI.contentTopBar.font.size = value
						AtlasLoot.GUI.RefreshFonts("contentFrame")
					end
				},
				font = {
					type = "select",
					dialogControl = 'LSM30_Font',
					order = 7,
					name = AL["Font"],
					values = AceGUIWidgetLSMlists.font,
					get = function(info) return AtlasLoot.db.GUI.contentTopBar.font.font end,
					set = function(info, value)
						AtlasLoot.db.GUI.contentTopBar.font.font = value
						AtlasLoot.GUI.RefreshFonts("contentFrame")
					end,
				},
			},
		},
		content = {
			order = 4,
			type = "group",
			name = AL["Content"],
			get = function(info) return AtlasLoot.db.GUI.content[info[#info]] end,
			set = function(info, value) AtlasLoot.db.GUI.content[info[#info]] = value end,
			args = {
				showBgImage = {
					order = 1,
					type = "toggle",
					width = "full",
					name = AL["Show background image if available."],
					set = function(info, value) AtlasLoot.db.GUI.content.showBgImage = value AtlasLoot.GUI.RefreshContentBackGround() end
				},
				bgColor = {
					type = "color",
					order = 2,
					name = AL["Background color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.content[info[#info]])
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.content[info[#info]], r, g, b, a)
						AtlasLoot.GUI.RefreshContentBackGround()
					end,
				},
			},
		},
		contentBottomBar = {
			order = 5,
			type = "group",
			name = AL["Content bottom bar"],
			get = function(info) return AtlasLoot.db.GUI.contentBottomBar[info[#info]] end,
			set = function(info, value) AtlasLoot.db.GUI.contentBottomBar[info[#info]] = value end,
			args = {
				useContentColor = {
					order = 1,
					type = "toggle",
					width = "full",
					name = AL["Use content color if available."],
					set = function(info, value) AtlasLoot.db.GUI.contentBottomBar.useContentColor = value AtlasLoot.GUI.RefreshContentBackGround() end
				},
				bgColor = {
					type = "color",
					order = 2,
					name = AL["Background color/alpha"],
					width = "full",
					hasAlpha = true,
					get = function(info)
						return ColorPicker_Get(AtlasLoot.db.GUI.contentBottomBar[info[#info]])
					end,
					set = function(info, r, g, b, a)
						ColorPicker_Set(AtlasLoot.db.GUI.contentBottomBar[info[#info]], r, g, b, a)
						AtlasLoot.GUI.RefreshContentBackGround()
					end,
				},
			},
		},
	},
}