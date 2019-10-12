-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local type = type
local abs, sqrt = math.abs, math.sqrt

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AtlasLoot = _G.AtlasLoot
local LibStub = _G.LibStub
local MiniMapButton = {}
AtlasLoot.MiniMapButton = MiniMapButton
local SlashCommands = AtlasLoot.SlashCommands
local AL = AtlasLoot.Locales
local ALButton = LibStub("LibDBIcon-1.0")

local TT_H_1, TT_H_2 = "|cff00FF00"..AL["AtlasLoot"].."|r", string.format("|cffFFFFFF%s|r", AtlasLoot.__addonversion)
local TT_ENTRY = "|cFFCFCFCF%s:|r %s" --|cffFFFFFF%s|r"


-- LDB
if not LibStub:GetLibrary("LibDataBroker-1.1", true) then return end

--Make an LDB object
local MiniMapLDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AtlasLoot", {
	type = "launcher",
	text = AL["AtlasLoot"],
	icon = "Interface\\Icons\\INV_Box_01",
	OnTooltipShow = function(tooltip)
		tooltip:AddDoubleLine(TT_H_1, TT_H_2);
		tooltip:AddLine(format(TT_ENTRY, AL["Left Click"], AL["Open AtlasLoot"]))
		if AtlasLoot.db.enableAutoSelect then
			tooltip:AddLine(format(TT_ENTRY, AL["Middle Click"], AL["Open AtlasLoot without auto select"]))
		end
		tooltip:AddLine(format(TT_ENTRY, AL["Shift + Left Click"], AL["Open Options"]))
		tooltip:AddLine(format(TT_ENTRY, AL["Right Click"], AL["Open Favourites"]))
	end,
	OnClick = function(self, button)
		if button == "RightButton" then
			AtlasLoot.Addons:GetAddon("Favourites").GUI:Toggle()
		elseif button == "MiddleButton" and AtlasLoot.db.enableAutoSelect then
			AtlasLoot.db.enableAutoSelect = false
			SlashCommands:Run("")
			AtlasLoot.db.enableAutoSelect = true
		else
			if IsShiftKeyDown() then
				SlashCommands:Run("options")
			else
				SlashCommands:Run("")
			end
		end
	end,
})

function MiniMapButton.Init()
	SlashCommands:Add("mmb", MiniMapButton.Toggle, AL["/al mmb - Toggle MiniMapButton"])
	SlashCommands:AddResetFunction(MiniMapButton.ResetFrames, "frames", "mmb")

	ALButton:Register("AtlasLoot", MiniMapLDB, AtlasLoot.db.minimap);
end
AtlasLoot:AddInitFunc(MiniMapButton.Init)

function MiniMapButton.ResetFrames()
	AtlasLoot.db.minimap.minimapPos = 218;
	ALButton:Refresh("AtlasLoot");
end

function MiniMapButton.Toggle()
	AtlasLoot.db.minimap.shown = not AtlasLoot.db.minimap.shown
	AtlasLoot.db.minimap.hide = not AtlasLoot.db.minimap.hide
	if not AtlasLoot.db.minimap.hide then
		ALButton:Show("AtlasLoot")
	else
		ALButton:Hide("AtlasLoot")
	end
end

function MiniMapButton.Options_Toggle()
	if AtlasLoot.db.minimap.shown then
		ALButton:Show("AtlasLoot")
		AtlasLoot.db.minimap.hide = nil
	else
		ALButton:Hide("AtlasLoot")
		AtlasLoot.db.minimap.hide = true
	end
end

function MiniMapButton.Lock_Toggle()
	if AtlasLoot.db.minimap.locked then
		ALButton:Lock("AtlasLoot");
	else
		ALButton:Unlock("AtlasLoot");
	end
end
