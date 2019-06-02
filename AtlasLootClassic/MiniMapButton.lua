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
local profile
local ALButton = LibStub("LibDBIcon-1.0")


-- LDB
if not LibStub:GetLibrary("LibDataBroker-1.1", true) then return end

--Make an LDB object
local MiniMapLDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AtlasLoot", {
	type = "launcher",
	text = AL["AtlasLoot"],
	icon = "Interface\\Icons\\INV_Box_01",
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("|cff00FF00"..AL["AtlasLoot"].."|r");
		tooltip:AddLine(AL["AtlasLoot_Minimap_Clicks"]);
	end,
	OnClick = function(self, button)
		if button == "RightButton" then return end
		if IsShiftKeyDown() then
			SlashCommands:Run("options")
		else
			SlashCommands:Run("")
		end
	end,
})

function MiniMapButton.Init()
	SlashCommands:Add("mmb", MiniMapButton.Toggle, AL["/al mmb - Toggle MiniMapButton"])
	SlashCommands:AddResetFunction(MiniMapButton.ResetFrames, "frames", "mmb")

	profile = AtlasLoot.db

	ALButton:Register("AtlasLoot", MiniMapLDB, profile.minimap);
end
AtlasLoot:AddInitFunc(MiniMapButton.Init)

function MiniMapButton.ResetFrames()
	profile.minimap.minimapPos = 218;
	ALButton:Refresh("AtlasLoot");
end

function MiniMapButton.Toggle()
	profile.minimap.shown = not profile.minimap.shown
	profile.minimap.hide = not profile.minimap.hide
	if not profile.minimap.hide then
		ALButton:Show("AtlasLoot")
	else
		ALButton:Hide("AtlasLoot")
	end
end

function MiniMapButton.Options_Toggle()
	if profile.minimap.shown then
		ALButton:Show("AtlasLoot")
		profile.minimap.hide = nil
	else
		ALButton:Hide("AtlasLoot")
		profile.minimap.hide = true
	end
end

function MiniMapButton.Lock_Toggle()
	if profile.minimap.locked then
		ALButton:Lock("AtlasLoot");
	else
		ALButton:Unlock("AtlasLoot");
	end
end
