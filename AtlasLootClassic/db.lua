AtlasLoot.AtlasLootDBDefaults = {
	profile = {
		showIDsInTT = false,
		showLvlRange = true,
		enableBossLevel = false,
		showMinEnterLvl = false,
		enableWoWHeadIntegration = true,
		useEnglishWoWHead = false,
		enableAutoSelect = true,
		enableAutoSelectBoss = true,
		showDropRate = true,
		ContentPhase = {
			enableOnLootTable = true,
			enableOnItems = true,
			enableOnCrafting = true,
			enableOnSets = true,
			enableTT = false,
		},
		Tooltip = {	-- Core\Tooltip.lua
			tooltip = "AtlasLootTooltip",
			useGameTooltip = true,
		},
		GUI = {		-- GUI\GUI.lua
			point = {"CENTER"},
			DefaultFrameLocked = false,
			selected = {"AtlasLootClassic_DungeonsAndRaids", "Deadmines", 1, 0},
			classFilter = false,
			autoselect = true,
			ExpansionIcon = true,
			mainFrame = {
				bgColor = {r = 0.45, g = 0.45, b = 0.45, a = 1},
				scale = 1,
				title = {
					bgColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
					textColor = {r = 1, g = 1, b = 1, a = 1},
					size = 12,
					font = "Friz Quadrata TT",
				},
			},
			contentTopBar = {
				bgColor = {r = 0.05, g = 0.05, b = 0.05, a = 0.7},
				useContentColor = true,
				font = {
					color = {r = 1, g = 1, b = 1, a = 1},
					size = 16,
					font = "Friz Quadrata TT",
				},
			},
			content = {
				showBgImage = false,
				bgColor = {r = 0, g = 0, b = 0, a = 0.9},
			},
			contentBottomBar = {
				bgColor = {r = 0.05, g = 0.05, b = 0.05, a = 0.5},
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
		minimap = {
			shown = true,
			locked = false,
			minimapPos = 218,
		},
		Button = {	-- Button / ClickHandler
			["*"] = {
				types = {
					["*"] = false
				}
			}
		},
		Addons = {},
	},
	global = {
		Addons = {},
	}
}
