local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = {}
local AL = AtlasLoot.Locales

AtlasLoot.Options = Options
local db = AtlasLoot.db

local function ShowTestSet()
	AtlasLoot.GUI.SetViewFrame:SetAtlasLootItemSet("GMTESTSET", "global")
end

-- atlasloot
local function atlasloot(gui, content)
	local last

	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Always show item comparison."])
		:DB(db.Button.Item, "alwaysShowCompareTT")

	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Auto select current instance's loot tables."])
		:DB(db.GUI, "autoselect")

	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Always show quick preview."])
		:DB(db.Button.Item, "alwaysShowPreviewTT")

	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Use GameTooltip"])
		:Tooltip("text", AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"])
		:DB(db.Tooltip, "useGameTooltip", AtlasLoot.Tooltip.Refresh)
end

-- windows
local function windows(gui, content)

end

-- windows -> atlasloot
local function windows_atlasloot(gui, content)
	local last

	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Main Window"])

	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(0.5, 1.5, 0.01)
		:Text(AL["Scale"])
		:DB(db.GUI.mainFrame, "scale", AtlasLoot.GUI.RefreshMainFrame)

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.mainFrame, "bgColor", AtlasLoot.GUI.RefreshMainFrame)

	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Title"])

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.mainFrame.title, "bgColor", AtlasLoot.GUI.RefreshMainFrame)

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.GUI.mainFrame.title, "textColor", AtlasLoot.GUI.RefreshMainFrame)

	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 20, 1)
		:Text(AL["Font size"])
		:DB(db.GUI.mainFrame.title, "size", AtlasLoot.GUI.RefreshMainFrame)

	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset frame position"])
		:Click(AtlasLoot.GUI.ResetFrames)
		:Confirm(format(AL["Reset position of the |cff33ff99\"%s\"|r window."], AL["AtlasLoot"]))
end

local function windows_atlasloot_contenttopbar(gui, content)
	local last

	-- background
	last = gui:Add("Line")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Background"])

	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Use content color if available."])
		:DB(db.GUI.contentTopBar, "useContentColor", AtlasLoot.GUI.RefreshContentBackGround)

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.contentTopBar, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)

	-- font
	last = gui:Add("Line")
		:Point("TOP", last, "BOTTOM", 0, -15)
		:Size("full")
		:Text(AL["Font"])

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Font color/alpha"])
		:DB(db.GUI.contentTopBar.font, "color", AtlasLoot.GUI.RefreshFonts)

	last = gui:Add("Slider")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:MinMaxStep(10, 30, 1)
		:Text(AL["Font size"])
		:DB(db.GUI.contentTopBar.font, "size", AtlasLoot.GUI.RefreshFonts)
end

local function windows_atlasloot_content(gui, content)
	local last

	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Show background image if available."])
		:DB(db.GUI.content, "showBgImage", AtlasLoot.GUI.RefreshContentBackGround)

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.content, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)
end

local function windows_atlasloot_contentbottombar(gui, content)
	local last

	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Use content color if available."])
		:DB(db.GUI.contentBottomBar, "useContentColor", AtlasLoot.GUI.RefreshContentBackGround)

	last = gui:Add("ColorPicker")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Background color/alpha"])
		:DB(db.GUI.contentBottomBar, "bgColor", AtlasLoot.GUI.RefreshContentBackGround)
end

-- minimap Button
local function minimapbutton(gui, content)
	local last
	last = gui:Add("CheckBox")
		:Point("TOP", 0, -5)
		:Size("full")
		:Text(AL["Show minimap button."])
		:DB(db.minimap, "shown", AtlasLoot.MiniMapButton.Options_Toggle)

	last = gui:Add("CheckBox")
		:Point("TOP", last, "BOTTOM")
		:Size("full")
		:Text(AL["Lock minimap button."])
		:DB(db.minimap, "locked", AtlasLoot.MiniMapButton.Lock_Toggle)

	last = gui:Add("Button")
		:Point("BOTTOMRIGHT", nil, "BOTTOMRIGHT", -2, 2)
		:Text(AL["Reset position of minimap button"])
		:Click(AtlasLoot.MiniMapButton.ResetFrames)
		:Confirm(AL["Reset position of the |cff33ff99\"Minimap button\"|r."])
end

local ALOptions = LibStub("ALOptions-1.0"):Register(AL["AtlasLoot"], AL["AtlasLoot Options"], AtlasLoot.__addonrevision, AtlasLoot.db.profile, {
	{
		title = AL["AtlasLoot"],
		--desc = "",
		quickSelect = "start",
		clickFunc = atlasloot,
	},
	{
		title = AL["Windows"],
		--desc = "",
		quickSelect = "windows",
		clickFunc = windows,
		content = {
			{
				title = AL["AtlasLoot"],
				--desc = "",
				clickFunc = windows_atlasloot,
				content = {
					{
						title = AL["Content top bar"],
						--desc = "",
						clickFunc = windows_atlasloot_contenttopbar,
					},
					{
						title = AL["Content"],
						--desc = "",
						clickFunc = windows_atlasloot_content,
					},
					{
						title = AL["Content bottom bar"],
						--desc = "",
						clickFunc = windows_atlasloot_contentbottombar,
					},
				},
			},
		},
	},
	{
		title = AL["Minimap Button"],
		--desc = "Test 2 description",
		clickFunc = minimapbutton,
	},
	{
		title = ADDONS,
		--desc = "Test 2 description",
		--clickFunc = test2,
		content = {

		},
	},

})

local fistShown = true
function Options:Show()
	ALOptions:Show(fistShown and "start" or nil)
	fistShown = nil
end
--[[
function Options.Init()

end
AtlasLoot:AddInitFunc(Options.Init, "AtlasLoot_Options")
]]--
