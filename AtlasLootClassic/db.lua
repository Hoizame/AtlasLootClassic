AtlasLoot.AtlasLootDBDefaults = {
	Tooltip = {	-- Core\Tooltip.lua
		tooltip = "AtlasLootTooltip",
	},
	GUI = {		-- GUI\GUI.lua
		point = {"CENTER"},
		DefaultFrameLocked = false,
		selected = {"AtlasLootClassic_DungeonsAndRaids", "Deadmines", 1, 0},
		classFilter = false,
		autoselect = true,
		ExpansionIcon = true,

		mainFrame = {
			bgColor = {0.45, 0.45, 0.45, 1},
			scale = 1,
			title = {
				bgColor = { 0.05, 0.05, 0.05, 1 },
				textColor = {1, 1, 1, 1},
				size = 12,
				font = "Friz Quadrata TT",
			},
		},
		contentTopBar = {
			bgColor = {0.05, 0.05, 0.05, 0.7},
			useContentColor = true,
			font = {
				color = {1, 1, 1, 1},
				size = 16,
				font = "Friz Quadrata TT",
			},
		},
		content = {
			showBgImage = false,
			bgColor = {0, 0, 0, 0.9},
		},
		contentBottomBar = {
			bgColor = {0.05, 0.05, 0.05, 0.5},
			useContentColor = false,
		},
	},
	OptionsFrame = {
		point = { "CENTER", nil, "CENTER", 0, 0 },
	},
	Map = {		-- Map\
		point = {"CENTER"},
		locked = false,
	},
	WorldMap = {
		showbutton = true,
		buttonOnTitleBar = true,
	},
	QuickLootFrame = {
		point = {"CENTER"},
		mainFrame = {
			scale = 1,
			bgColor = {0, 0, 0, 1},
			title = {
				bgColor = { 0, 0.86, 1, 1 },
				textColor = {1, 1, 1, 1},
				size = 12,
				font = "Friz Quadrata TT",
			},
			subTitle = {
				bgColor = { 0, 1, 1, 1 },
				textColor = {1, 1, 1, 1},
				size = 12,
				font = "Friz Quadrata TT",
			},
			content = {
				bgColor = { 1, 1, 1, 1 },
			},
		},
	},
--[[
	MiniMapButton = {
		point = false,
		shown = true,
		locked = false,
		lockedAroundMiniMap = true,
	},
]]
	minimap = {
		shown = true,
		locked = false,
		minimapPos = 218,
	},
	Button = {	-- Button
		["*"] = {
			ClickHandler = {},
		},
		Item = {
			showDropRate = true,
			alwaysShowCompareTT = false,
			alwaysShowPreviewTT = false,
			showCompletedHook = false,
			ClickHandler = {}
		},
	},
	Addons = {
		Search = {
			point = {"CENTER"},
		},
	},
}
