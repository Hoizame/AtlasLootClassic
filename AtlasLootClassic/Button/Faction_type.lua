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

--[[
	1 => 11 - Stranger
	2 => 12 - Acquaintance
	3 => 13 - Buddy
	4 => 14 - Friend
	5 => 15 - Good Friend
	6 => 16 - Best Friend
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
	[529] = "Interface\\Icons\\inv_jewelry_talisman_07",				--Argent Dawn
	[530] = "Interface\\Icons\\inv_misc_tournaments_symbol_troll",			--Darkspear Trolls
	[576] = "Interface\\Icons\\achievement_reputation_timbermaw",			--Timbermaw Hold
	[589] = "Interface\\Icons\\Achievement_Zone_Winterspring",			--Wintersaber Trainers
	[609] = "Interface\\Icons\\ability_racial_ultravision",				--Cenarion Circle
	[910] = "Interface\\Icons\\inv_misc_head_dragon_bronze",			--Brood of Nozdormu

	-- BC
	[911] = "Interface\\Icons\\inv_misc_tournaments_symbol_bloodelf",		--Silvermoon City
	[922] = "Interface\\Icons\\INV_Misc_Bandana_03",				--Tranquillien
	[930] = "Interface\\Icons\\inv_misc_tournaments_symbol_draenei",		--Exodar
	[932] = "Interface\\Icons\\spell_arcane_portalshattrath",			--The Aldor
	[933] = "Interface\\Icons\\inv_enchant_shardprismaticlarge",			--The Consortium
	[934] = "Interface\\Icons\\spell_arcane_portalshattrath",			--The Scryers
	[935] = "Interface\\Icons\\Spell_Nature_LightningOverload",			--The Sha'tar
	[941] = "Interface\\Icons\\inv_misc_foot_centaur",				--The Mag'har
	[942] = "Interface\\Icons\\ability_racial_ultravision",				--Cenarion Expedition
	[946] = "Interface\\Icons\\INV_BannerPVP_02",					--Honor Hold
	[947] = "Interface\\Icons\\INV_BannerPVP_01",					--Thrallmar
	[967] = "Interface\\Icons\\spell_holy_mindsooth",				--The Violet Eye
	[970] = "Interface\\Icons\\inv_mushroom_11",					--Sporeggar
	[978] = "Interface\\Icons\\inv_misc_foot_centaur",				--Kurenai
	[989] = "Interface\\Icons\\Ability_Warrior_VictoryRush",			--Keepers of Time
	[990] = "Interface\\Icons\\inv_enchant_dustillusion",				--The Scale of the Sands
	[1011] = "Interface\\Icons\\Ability_Rogue_MasterOfSubtlety",			--Lower City
	[1012] = "Interface\\Icons\\achievement_reputation_ashtonguedeathsworn",	--Ashtongue Deathsworn
	[1015] = "Interface\\Icons\\ability_mount_netherdrakepurple",			--Netherwing
	[1031] = "Interface\\Icons\\ability_hunter_pet_netherray",			--Sha'tari Skyguard
	[1038] = "Interface\\Icons\\inv_misc_apexis_crystal",				--Ogri'la
	[1077] = "Interface\\Icons\\inv_shield_48",					--Shattered Sun Offensive

	-- WotLK
	[1037] = "Interface\\Icons\\spell_misc_hellifrepvphonorholdfavor",		--Alliance Vanguard
	[1052] = "Interface\\Icons\\spell_misc_hellifrepvpthrallmarfavor",		--Horde Expedition
	[1073] = "Interface\\Icons\\achievement_reputation_tuskarr",			--The Kalu'ak
	[1090] = "Interface\\Icons\\achievement_reputation_kirintor",			--Kirin Tor
	[1091] = "Interface\\Icons\\achievement_reputation_wyrmresttemple",		--The Wyrmrest Accord
	[1094] = "Interface\\Icons\\inv_elemental_primal_mana",				--The Silver Covenant
	[1098] = "Interface\\Icons\\achievement_reputation_knightsoftheebonblade",	--Knights of the Ebon Blade
	[1104] = "Interface\\Icons\\ability_mount_whitedirewolf",			--Frenzyheart Tribe
	[1105] = "Interface\\Icons\\inv_misc_head_murloc_01",				--The Oracles
	[1106] = "Interface\\Icons\\inv_jewelry_talisman_08",				--Argent Crusade
	[1119] = "Interface\\Icons\\spell_frost_wizardmark",				--The Sons of Hodir
	[1124] = "Interface\\Icons\\inv_elemental_primal_nether",			--The Sunreavers
	[1156] = "Interface\\Icons\\inv_jewelry_talisman_08",				--The Ashen Verdict

	-- Cata
	[1133] = "Interface\\Icons\\inv_misc_tabard_kezan",			--Bilgewater Cartel
	[1134] = "Interface\\Icons\\inv_misc_tabard_gilneas",			--Gilneas
	[1135] = "Interface\\Icons\\inv_misc_tabard_earthenring",		--The Earthen Ring
	[1158] = "Interface\\Icons\\inv_misc_tabard_guardiansofhyjal",		--Guardians of Hyjal
	[1171] = "Interface\\Icons\\inv_misc_tabard_therazane",			--Therazane
	[1172] = "Interface\\Icons\\inv_misc_tabard_dragonmawclan",		--Dragonmaw Clan
	[1173] = "Interface\\Icons\\inv_misc_tabard_tolvir",			--Ramkahen
	[1174] = "Interface\\Icons\\inv_misc_tabard_wildhammerclan",		--Wildhammer Clan
	[1177] = "Interface\\Icons\\inv_misc_tabard_baradinwardens",		--Baradin's Wardens
	[1178] = "Interface\\Icons\\inv_misc_tabard_hellscream",		--Hellscream's Reach
	[1204] = "Interface\\Icons\\inv_neck_hyjaldaily_04",			--Avengers of Hyjal

	-- MoP
	[1269] = "Interface\\Icons\\achievement_faction_goldenlotus",		--Golden Lotus
	[1270] = "Interface\\Icons\\achievement_faction_shadopan",		--Shado Pan
	[1271] = "Interface\\Icons\\achievement_faction_serpentriders",		--Order of the Cloud Serpent
	[1272] = "Interface\\Icons\\achievement_faction_tillers",		--The Tillers
	[1302] = "Interface\\Icons\\achievement_faction_anglers",		--The Anglers
	[1337] = "Interface\\Icons\\achievement_faction_klaxxi",		--The Klaxxi
	[1341] = "Interface\\Icons\\achievement_faction_celestials",		--The August Celestials
	[1345] = "Interface\\Icons\\achievement_faction_lorewalkers",		--The Lorewalkers
	[1352] = "Interface\\Icons\\inv_misc_tournaments_symbol_orc",		--Huojin Pandaren
	[1353] = "Interface\\Icons\\inv_misc_tournaments_symbol_human",		--Tushui Pandaren
	[1358] = "Interface\\Icons\\INV_Misc_Fishing_Raft",			--Nat Pagle
	[1375] = "Interface\\Icons\\achievement_general_hordeslayer",		--Dominance Offensive
	[1376] = "Interface\\Icons\\achievement_general_allianceslayer",	--Operation: Shieldwall
	[1387] = "Interface\\Icons\\achievement_reputation_kirintor_offensive",	--Kirin Tor Offensive
	[1388] = "Interface\\Icons\\achievement_faction_sunreaveronslaught",	--Sunreaver Onslaught
	[1435] = "Interface\\Icons\\achievement_faction_shadopan",		--Shado-Pan Assault
	[1492] = "Interface\\Icons\\ability_monk_quipunch",			--Emperor Shaohao

	-- WoD
	[1445] = "Interface\\Icons\\inv_tabard_a_01frostwolfclan",		--Frostwolf Orcs
	[1515] = "Interface\\Icons\\inv_tabard_a_76arakkoaoutcast",		--Arakkoa Outcasts
	[1681] = "Interface\\Icons\\inv_tabard_a_77voljinsspear",		--Vol'jin's Spear
	[1682] = "Interface\\Icons\\inv_tabard_a_78wrynnvanguard",		--Wrynn's Vanguard
	[1708] = "Interface\\Icons\\inv_tabard_a_80laughingskull",		--Laughing Skull Orcs
	[1710] = "Interface\\Icons\\inv_tabard_a_shataridefense",		--Sha'tari Defense
	[1711] = "Interface\\Icons\\achievement_goblinhead",			--Steamwheedle Perservation Society
	[1731] = "Interface\\Icons\\inv_tabard_a_81exarchs",			--Council of Exarchs
	[1847] = "Interface\\Icons\\Achievement_Leader_Prophet_Velen", 		-- Hand of the Prophet
	[1848] = "Interface\\Icons\\INV_Misc_VoljinsShatteredTusk", 		-- Vol'jin's Headhunters
	[1849] = "Interface\\Icons\\INV_Tabard_A_82AwakenedOrder", 		-- Order of the Awakened
	[1850] = "Interface\\Icons\\INV_Tabard_A_83SaberStalkers", 		-- The Saberstalkers
	
	-- Legion
	[1828] = "Interface\\Icons\\INV_Legion_Faction_HightmountainTribes", 	-- Highmountain Tribe
	[1859] = "Interface\\Icons\\INV_Legion_Faction_NightFallen", 		-- The Nightfallen
	[1883] = "Interface\\Icons\\INV_Legion_Faction_DreamWeavers", 		-- Dreamweavers
	[1894] = "Interface\\Icons\\INV_Legion_Faction_Warden", 		-- The Wardens
	[1900] = "Interface\\Icons\\INV_Legion_Faction_CourtofFarnodis", 	-- Court Of Farondis
	[1948] = "Interface\\Icons\\INV_Legion_Faction_Valarjar", 		-- Valarjar
	[2045] = "Interface\\Icons\\INV_Legion_Faction_LegionFall", 		-- Armies of Legionfall
	[2165] = "Interface\\Icons\\INV_Legion_Faction_ArmyoftheLight", 	-- Army of the Light
	[2170] = "Interface\\Icons\\INV_legion_Faction_ArgussianReach", 	-- Argussian Reach
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
	[529] = "Argent Dawn",
	[530] = "Darkspear Trolls",
	[576] = "Timbermaw Hold",
	[589] = "Wintersaber Trainers",
	[609] = "Cenarion Circle",
	[910] = "Brood of Nozdormu",
	-- BC
	[911] = "Silvermoon City",
	[922] = "Tranquillien",
	[930] = "Exodar",
	[932] = "The Aldor",
	[933] = "The Consortium",
	[934] = "The Scryers",
	[935] = "The Sha'tar",
	[941] = "The Mag'har",
	[942] = "Cenarion Expedition",
	[946] = "Honor Hold",
	[947] = "Thrallmar",
	[967] = "The Violet Eye",
	[970] = "Sporeggar",
	[978] = "Kurenai",
	[989] = "Keepers of Time",
	[990] = "The Scale of the Sands",
	[1011] = "Lower City",
	[1012] = "Ashtongue Deathsworn",
	[1015] = "Netherwing",
	[1031] = "Sha'tari Skyguard",
	[1038] = "Ogri'la",
	[1077] = "Shattered Sun Offensive",
	-- WotLK
	[1037] = "Alliance Vanguard",
	[1052] = "Horde Expedition",
	[1073] = "The Kalu'ak",
	[1090] = "Kirin Tor",
	[1091] = "The Wyrmrest Accord",
	[1094] = "The Silver Covenant",
	[1098] = "Knights of the Ebon Blade",
	[1104] = "Frenzyheart Tribe",
	[1105] = "The Oracles",
	[1106] = "Argent Crusade",
	[1119] = "The Sons of Hodir",
	[1124] = "The Sunreavers",
	[1156] = "The Ashen Verdict",
	-- Cata
	[1133] = "Bilgewater Cartel",
	[1134] = "Gilneas",
	[1135] = "The Earthen Ring",
	[1158] = "Guardians of Hyjal",
	[1171] = "Therazane",
	[1172] = "Dragonmaw Clan",
	[1173] = "Ramkahen",
	[1174] = "Wildhammer Clan",
	[1177] = "Baradin's Wardens",
	[1178] = "Hellscream's Reach",
	[1204] = "Avengers of Hyjal",
	-- MoP
	[1269] = "Golden Lotus",
	[1270] = "Shado-Pan",
	[1271] = "Order of the Cloud Serpent",
	[1272] = "The Tillers",
	[1302] = "The Anglers",
	[1337] = "The Klaxxi",
	[1341] = "The August Celestials",
	[1345] = "The Lorewalkers",
	[1352] = "Huojin Pandaren",
	[1353] = "Tushui Pandaren",
	[1358] = "Nat Pagle",
	[1375] = "Dominance Offensive",
	[1376] = "Operation: Shieldwall",
	[1387] = "Kirin Tor Offensive",
	[1388] = "Sunreaver Onslaught",
	[1435] = "Shado-Pan Assault",
	[1492] = "Emperor Shaohao",
	-- WoD
	[1445] = "Frostwolf Orcs",
	[1515] = "Arakkoa Outcasts",
	[1681] = "Vol'jin's Spear",
	[1682] = "Wrynn's Vanguard",
	[1708] = "Laughing Skull Orcs",
	[1710] = "Sha'tari Defense",
	[1711] = "Steamwheedle Preservation Society",
	[1731] = "Council of Exarchs",
	[1847] = "Hand of the Prophet",
	[1848] = "Vol'jin's Headhunters",
	[1849] = "Order of the Awakened",
	[1850] = "The Saberstalkers",
	-- Legion
	[1828] = "Highmountain Tribe",
	[1859] = "The Nightfallen",
	[1883] = "Dreamweavers",
	[1894] = "The Wardens",
	[1900] = "Court of Farondis",
	[1948] = "Valarjar",
	[2045] = "Armies of Legionfall",
	[2165] = "Army of the Light",
	[2170] = "Argussian Reach",
	-- Bfa
	--- Alliance
	[2159] = "7th Legion",
	[2160] = "Proudmoore Admiralty",
	[2161] = "Order of Embers",
	[2162] = "Storm's Wake",
	--- Horde
	[2157] = "The Honorbound",
	[2103] = "Zandalari Empire",
	[2156] = "Talanji's Expedition",
	[2158] = "Voldunai",
	--- All
	[2163] = "Tortollan Seekers",
	[2164] = "Champions of Azeroth",
	
}

local function GetLocRepStanding(id)
	if (id > 10) then
		return FRIEND_REP_TEXT[id] or FACTION_STANDING_LABEL4_FEMALE
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

function Faction.OnSet(button, second)
	if not FactionClickHandler then
		FactionClickHandler = ClickHandler:Add(
		"Faction",
		{
			--ChatLink = { "LeftButton", "Shift" },
			types = {
				--ChatLink = true,
			},
		},
		AtlasLoot.db.Button.Faction.ClickHandler, 
		{
			--{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		}
		)

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
	--if mouseButton == "ChatLink" then
		
	--end
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
	
	button.icon:SetDesaturated(false)
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
	local friendID = GetFriendshipReputation(button.FactionID)

	-- name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfoByID(factionID)
	local name, _, standingID = GetFactionInfoByID(button.FactionID)
	
	local color

	if friendID and button.RepID then
		color = "|cFF"..FACTION_REP_COLORS[button.RepID > 12 and 5 or 4]
	else
		color = "|cFF"..FACTION_REP_COLORS[button.RepID or standingID]
	end

	if button.type == "secButton" then
		button:SetNormalTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	else	
		-- ##################
		-- name
		-- ##################
		name = name or BF[FACTION_KEY[button.FactionID]] or FACTION.." "..button.FactionID
		button.name:SetText(color..name)
		
		--button.extra:SetText("|cFF"..FACTION_REP_COLORS[button.RepID or standingID]..GetLocRepStanding(button.RepID or standingID))

		-- ##################
		-- icon
		-- ##################
		button.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
		
		local reqRepText = friendID and FRIEND_REP_TEXT[button.RepID] or GetLocRepStanding(button.RepID or standingID) or ""
		
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

	local friendID, friendRep, _, _, _, _, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(button.FactionID)
	if friendID then
		factionStandingtext = friendTextLevel
		if ( nextFriendThreshold ) then
			barMin, barMax, barValue = friendThreshold, nextFriendThreshold, friendRep
		else
			-- max rank, make it look like a full bar
			barMin, barMax, barValue = 0, 1, 1;
		end
		colorIndex = 5
	else
		barMin, barMax, barValue = barMin or 0, barMax or 1, barValue or 0
		factionStandingtext = GetLocRepStanding(standingID)
	end

	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT")
	
	frame.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	frame.name:SetText(name or "Faction "..button.FactionID)
	frame.desc:SetText(description)
	
	frame.standing.bar:SetMinMaxValues(barMin, barMax)
	frame.standing.bar:SetValue(barValue)
	local color = FACTION_BAR_COLORS[colorIndex]
	frame.standing.bar:SetStatusBarColor(color.r, color.g, color.b)
	frame.standing.text:SetText(str_format("%s ( %d / %d )", factionStandingtext, barValue - barMin, barMax - barMin))
	 
	frame:SetHeight(20+21+frame.desc:GetHeight()+5)
	frame:Show()
end

