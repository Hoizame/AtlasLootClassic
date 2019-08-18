local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = {}
local AL = AtlasLoot.Locales

AtlasLoot.Options = Options
local db = AtlasLoot.db
local globalDb = AtlasLoot.dbGlobal

local AceGUI = LibStub("AceGUI-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

Options.orderNumber = 0

function Options:Show()
	AceConfigDialog:Open("AtlasLoot")
end

function Options:Close()
	AceConfigDialog:Close("AtlasLoot")
end

function Options:NotifyChange()
	AceConfigRegistry:NotifyChange("AtlasLoot")
end

function Options:ShowAddon(addonName)
	AceConfigDialog:Open("AtlasLoot", nil, "addons", addonName)
end

-- https://www.wowace.com/projects/ace3/pages/ace-gui-3-0-widgets
-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables
Options.config = {
	type = "group",
	name = AL["AtlasLoot"],
	args = {
	},
}

AceConfig:RegisterOptionsTable("AtlasLoot", Options.config)
AceConfigDialog:SetDefaultSize("AtlasLoot", 810, 550)

-- Add profile on last position
Options.config.args.profiles = AceDBOptions:GetOptionsTable(AtlasLoot.dbRaw)
Options.config.args.profiles.order = -30