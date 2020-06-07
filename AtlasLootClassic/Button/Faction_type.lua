local _G = getfenv(0)
-- lua
local tonumber, type = tonumber, type
local str_match, str_format = string.match, string.format
-- WoW
local UnitSex, GetFactionInfoByID, GetFriendshipReputation = UnitSex, GetFactionInfoByID, GetFriendshipReputation

local AtlasLoot = _G.AtlasLoot
local Faction = AtlasLoot.Button:AddType("Faction", "f")
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler

--[[
	-- rep info ("f1435rep3" = Unfriendly rep @ Shado-Pan Assault)
	1. Hated
	2. Hostile
	3. Unfriendly
	4. Neutral
	5. Friendly
	6. Honored
	7. Revered
	8. Exalted
	-- if rep index is in between 11 and 16, means it has friendship reputation
]]

local FactionClickHandler
local PlayerSex

local TT_YES = "|cff00ff00"..YES
local TT_NO = "|cffff0000"..NO
local TT_YES_REV = "|cffff0000"..YES
local TT_NO_REV = "|cff00ff00"..NO

local FACTION_REP_COLORS
local FACTION_IMAGES = {
	[0] = "Interface\\Icons\\Achievement_Reputation_08",			-- dummy

	-- AV
	[729] = "Interface\\Icons\\INV_BannerPVP_01", -- Frostwolf Clan
	[730] = "Interface\\Icons\\INV_BannerPVP_02", -- Stormpike Guard
	-- AB
	[510] = "Interface\\Icons\\INV_BannerPVP_01", -- The Defilers
	[509] = "Interface\\Icons\\INV_BannerPVP_02", -- The League of Arathor
	-- WS
	[889] = "Interface\\Icons\\INV_BannerPVP_01", -- Warsong Outriders
	[890] = "Interface\\Icons\\INV_BannerPVP_02", -- Silverwing Sentinels

	-- Classic
	[47] = "Interface\\Icons\\inv_misc_tournaments_symbol_dwarf",			--Ironforge
	[54] = "Interface\\Icons\\inv_misc_tournaments_symbol_gnome",			--Gnomeregan
	[59] = "Interface\\Icons\\INV_Ingot_Mithril",					--Thorium Brotherhood
	[68] = "Interface\\Icons\\inv_misc_tournaments_symbol_scourge",			--Undercity
	[69] = "Interface\\Icons\\inv_misc_tournaments_banner_nightelf",		--Darnassus
	[72] = "Interface\\Icons\\inv_misc_tournaments_symbol_human",			--Stormwind
	[76] = "Interface\\Icons\\inv_misc_tournaments_symbol_orc",			--Orgrimmar
	[81] = "Interface\\Icons\\inv_misc_tournaments_symbol_tauren",			--Thunder Bluff
	[87] = "Interface\\Icons\\INV_Helmet_66",					--Bloodsail Buccaneers
	[270] = "Interface\\Icons\\inv_jewelry_ring_46",					--Bloodsail Buccaneers
	[529] = "Interface\\Icons\\inv_jewelry_talisman_07",				--Argent Dawn
	[530] = "Interface\\Icons\\inv_misc_tournaments_symbol_troll",			--Darkspear Trolls
	[576] = "Interface\\Icons\\inv_misc_horn_01",			--Timbermaw Hold
	[589] = "Interface\\Icons\\ability_mount_pinktiger",			--Wintersaber Trainers
	[609] = "Interface\\Icons\\ability_racial_ultravision",				--Cenarion Circle
	[749] = "Interface\\Icons\\spell_shadow_demonbreath",				--Hydraxian Waterlords
	[910] = "Interface\\Icons\\inv_misc_head_dragon_bronze",			--Brood of Nozdormu
}

local FACTION_KEY = {
	-- Classic
	[47] = "Ironforge",
	[54] = "Gnomeregan",
	[59] = "Thorium Brotherhood",
	[68] = "Undercity",
	[69] = "Darnassus",
	[72] = "Stormwind",
	[76] = "Orgrimmar",
	[81] = "Thunder Bluff",
	[87] = "Bloodsail Buccaneers",
	[270] = "Zandalar Tribe",
	[529] = "Argent Dawn",
	[530] = "Darkspear Trolls",
	[576] = "Timbermaw Hold",
	[589] = AL["Wintersaber Trainers"], -- Alliance only, Horde gets no info :/
	[609] = "Cenarion Circle",
	[719] = "Hydraxian Waterlords",
	[910] = "Brood of Nozdormu",
}

ClickHandler:Add(
	"Faction",
	{
		WoWHeadLink = { "RightButton", "Shift" },
		--ChatLink = { "LeftButton", "Shift" },
		types = {
			--ChatLink = true,
			WoWHeadLink = true,
		},
	},
	{
		--{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		{ "WoWHeadLink", 	AL["Show WowHead link"], 	AL["Shows a copyable link for WoWHead"] },
	}
)

local function GetLocRepStanding(id)
	if (id > 10) then
		return FACTION_STANDING_LABEL4_FEMALE
	else
		return PlayerSex==3 and _G["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or _G["FACTION_STANDING_LABEL"..(id or 4)]
	end
end

local function RGBToHex(t)
	local r,g,b = t.r*255,t.g*255,t.b*255
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return str_format("%02x%02x%02x", r, g, b)
end

-- TODO: Create faction data module?
function AtlasLoot:Faction_GetFactionName(factionID)
	local name = GetFactionInfoByID(factionID)
	return name or FACTION_KEY[factionID] or FACTION.." "..factionID
end

function Faction.OnSet(button, second)
	if not FactionClickHandler then
		FactionClickHandler = ClickHandler:GetHandler("Faction")

		PlayerSex = UnitSex("player")

		FACTION_REP_COLORS = {}
		for i = 1, #FACTION_BAR_COLORS do
			FACTION_REP_COLORS[i] = RGBToHex(FACTION_BAR_COLORS[i])
		end
		RGBToHex = nil
	end
	if not button then return end

	if second and button.__atlaslootinfo.secType then
		if type(button.__atlaslootinfo.secType[2]) == "table" then
			button.secButton.FactionID = button.__atlaslootinfo.secType[2][1]
			button.secButton.RepID = button.__atlaslootinfo.secType[2][2]
		else
			button.secButton.FactionID = button.__atlaslootinfo.secType[2]
		end
		Faction.Refresh(button.secButton)
	else
		if type(button.__atlaslootinfo.type[2]) == "table" then
			button.FactionID = button.__atlaslootinfo.type[2][1]
			button.RepID = button.__atlaslootinfo.type[2][2]
		else
			button.FactionID = button.__atlaslootinfo.type[2]
		end
		Faction.Refresh(button)
	end
end

function Faction.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = FactionClickHandler:Get(mouseButton)
	if mouseButton == "WoWHeadLink" then
		AtlasLoot.Button:OpenWoWHeadLink(button, "faction", button.FactionID)
	end
end

function Faction.OnEnter(button, owner)
	if not button.FactionID then return end
	--[[
	local tooltip = AtlasLoot.Tooltip:GetTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(unpack(owner))
	else
		tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	end
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar = GetFactionInfoByID(button.FactionID)
	tooltip:AddLine(name)
	tooltip:AddLine(description, 1, 1, 1, 1)
	tooltip:AddLine(" ")
	tooltip:AddLine(UnitName("player")..":")
	tooltip:AddDoubleLine(COMBAT_FACTION_CHANGE, string.format("|cFF%s%s ( %d / %d )", FACTION_REP_COLORS[standingID], GetLocRepStanding(standingID), barValue-barMin, barMax-barMin) )
	if canToggleAtWar then
		tooltip:AddDoubleLine(AT_WAR, atWarWith and TT_YES_REV or TT_NO_REV)
	end
	tooltip:Show()
	]]--
	Faction.ShowToolTipFrame(button)
end

function Faction.OnLeave(button)
	if Faction.tooltipFrame then
		Faction.tooltipFrame:Hide()
	end
end

function Faction.OnClear(button)
	button.FactionID = nil
	button.secButton.FactionID = nil
	button.RepID = nil
	button.secButton.RepID = nil

	if button.icon then
		button.icon:SetDesaturated(false)
	end
	button.secButton.icon:SetDesaturated(false)
end

function Faction.GetStringContent(str)
	if tonumber(str) then
		return tonumber(str)
	else
		return {
			tonumber(str_match(str, "(%d+)")),
			tonumber(str_match(str, "rep(%d+)")),	-- required rep (1-8)
		}
	end
end

function Faction.Refresh(button)
	if not button.FactionID then return end
	--friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
	-- name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfoByID(factionID)
	local name, _, standingID = GetFactionInfoByID(button.FactionID)

	local color = "|cFF"..FACTION_REP_COLORS[button.RepID or standingID]

	if button.type == "secButton" then
		button:SetNormalTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	else
		-- ##################
		-- name
		-- ##################
		name = name or FACTION_KEY[button.FactionID] or FACTION.." "..button.FactionID
		button.name:SetText(color..name)

		--button.extra:SetText("|cFF"..FACTION_REP_COLORS[button.RepID or standingID]..GetLocRepStanding(button.RepID or standingID))

		-- ##################
		-- icon
		-- ##################
		button.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])

		local reqRepText = GetLocRepStanding(button.RepID or standingID) or ""

		if button.RepID and standingID and button.RepID > standingID then
			button.icon:SetDesaturated(true)
			button.extra:SetText("|cffff0000"..reqRepText)
		elseif not standingID then
			button.extra:SetText("|cffff0000"..reqRepText)
		else
			button.extra:SetText(color..reqRepText)
		end
	end

	return true
end

function Faction.ShowToolTipFrame(button)
	if not GetFactionInfoByID(button.FactionID) then return end
	if not Faction.tooltipFrame then
		local WIDTH = 200
		local name = "AtlasLoot-FactionToolTip"
		local frame = CreateFrame("Frame", name)
		frame:SetClampedToScreen(true)
		frame:SetWidth(WIDTH)
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
							tile = true, tileSize = 16, edgeSize = 16,
							insets = { left = 4, right = 4, top = 4, bottom = 4 }})
		frame:SetBackdropColor(0,0,0,1)

		frame.icon = frame:CreateTexture(name.."-icon", frame)
		frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
		frame.icon:SetHeight(15)
		frame.icon:SetWidth(15)
		frame.icon:SetTexture(FACTION_IMAGES[0])

		frame.name = frame:CreateFontString(name.."-name", "ARTWORK", "GameFontNormal")
		frame.name:SetPoint("TOPLEFT", frame.icon, "TOPRIGHT", 3, 0)
		frame.name:SetPoint("RIGHT", frame, -3, 0)
		frame.name:SetNonSpaceWrap(false)
		frame.name:SetJustifyH("LEFT")
		frame.name:SetWidth(WIDTH-25)
		frame.name:SetHeight(15)
		--frame.name:SetTextColor(1, 1, 1, 1)

		frame.standing = CreateFrame("FRAME", name.."-standing", frame)
		frame.standing:SetWidth(WIDTH-10)
		frame.standing:SetHeight(20)
		frame.standing:SetPoint("TOPLEFT", frame.icon, "BOTTOMLEFT", 0, -1)
		frame.standing:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
							tile = true, tileSize = 16, edgeSize = 12,
							insets = { left = 3, right = 3, top = 3, bottom = 3 }})
		frame.standing:SetBackdropColor(0, 0, 0, 1)

		frame.standing.bar = CreateFrame("StatusBar", name.."-standingBar", frame.standing)
		frame.standing.bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
		frame.standing.bar:SetPoint("TOPLEFT", 3, -3)
		frame.standing.bar:SetPoint("BOTTOMRIGHT", -4, 3)
		frame.standing.bar:GetStatusBarTexture():SetHorizTile(false)
		frame.standing.bar:GetStatusBarTexture():SetVertTile(false)

		frame.standing.text = frame.standing.bar:CreateFontString(name.."-standingText", "ARTWORK", "GameFontNormalSmall")
		frame.standing.text:SetPoint("TOPLEFT", 3, -3)
		frame.standing.text:SetPoint("BOTTOMRIGHT", -4, 3)
		frame.standing.text:SetJustifyH("CENTER")
		frame.standing.text:SetJustifyV("CENTER")
		frame.standing.text:SetTextColor(1, 1, 1, 1)

		frame.desc = frame:CreateFontString(name.."-desc", "ARTWORK", "GameFontNormalSmall")
		frame.desc:SetPoint("TOPLEFT", frame.standing, "BOTTOMLEFT", 0, -1)
		frame.desc:SetJustifyH("LEFT")
		frame.desc:SetJustifyV("TOP")
		frame.desc:SetWidth(WIDTH-10)
		frame.desc:SetTextColor(1, 1, 1, 1)

		Faction.tooltipFrame = frame
	end
	local frame = Faction.tooltipFrame
	local name, description, standingID, barMin, barMax, barValue = GetFactionInfoByID(button.FactionID)
	standingID = standingID or 1
	local colorIndex = standingID
	local factionStandingtext
	barMin, barMax, barValue = barMin or 0, barMax or 1, barValue or 0
	factionStandingtext = GetLocRepStanding(standingID)
	name = name or "Faction "..button.FactionID
	if button.RepID and name then
		name = format("%s (%s)", name, GetLocRepStanding(button.RepID))
	end

	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPLEFT", (button:GetWidth() * 0.5), 5)

	frame.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	frame.name:SetText(name)
	frame.desc:SetText(description)

	frame.standing.bar:SetMinMaxValues(barMin, barMax)
	frame.standing.bar:SetValue(barValue)
	local color = FACTION_BAR_COLORS[colorIndex]
	frame.standing.bar:SetStatusBarColor(color.r, color.g, color.b)
	frame.standing.text:SetText(str_format("%s ( %d / %d )", factionStandingtext, barValue - barMin, barMax - barMin))

	local newWidth = 30 + frame.name:GetUnboundedStringWidth()
	frame:SetWidth(newWidth > 200 and newWidth or 200)
	frame:SetHeight(20+21+frame.desc:GetHeight()+5)
	frame:Show()
end

