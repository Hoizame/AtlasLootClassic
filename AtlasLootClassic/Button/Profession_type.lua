local AtlasLoot = _G.AtlasLoot
local Prof = AtlasLoot.Button:AddType("Profession", "prof")
local AL = AtlasLoot.Locales
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

--lua
local str_match = string.match
local GetSpellInfo, GetSpellTexture = GetSpellInfo, GetSpellTexture
local GetTradeskillLink = AtlasLoot.TooltipScan.GetTradeskillLink

local ProfClickHandler = nil

local PROF_COLOR = "|cffffff00"

local TRADESKILLS = {
	[GetSpellInfo(2259)] 	= GetSpellTexture(2259),	-- Alchemy
	[GetSpellInfo(2018)] 	= GetSpellTexture(2018),	-- Blacksmithing
	[GetSpellInfo(2550)] 	= GetSpellTexture(2550),	-- Cooking
	[GetSpellInfo(7411)] 	= GetSpellTexture(7411),	-- Enchanting
	[GetSpellInfo(4036)] 	= GetSpellTexture(4036),	-- Engineering
	[GetSpellInfo(3273)] 	= GetSpellTexture(3273),	-- First Aid
	[GetSpellInfo(2108)] 	= GetSpellTexture(2108),	-- Leatherworking
	[GetSpellInfo(3908)] 	= GetSpellTexture(3908),	-- Tailoring
	[GetSpellInfo(2575)] 	= GetSpellTexture(2575),	-- Mining
	--[GetSpellInfo(63275)]	= GetSpellTexture(63275),	-- Fishing
	[GetSpellInfo(2366)] 	= GetSpellTexture(2366),	-- Herbalism
	[GetSpellInfo(921)]		= GetSpellTexture(921),		-- Pick Pocket
}

function Prof.OnSet(button, second)
	if not ProfClickHandler then
		ProfClickHandler = AtlasLoot.ClickHandler:Add(
		"Profession",
		{
			ChatLink = { "LeftButton", "Shift" },
			types = {
				ChatLink = true,
			},
		},
		AtlasLoot.db.Button.Profession.ClickHandler,
		{
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add profession link into chat"] },
		})
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.Profession = button.__atlaslootinfo.secType[2]
		button.secButton.SpellID = button.__atlaslootinfo.secType[2]
		Prof.Refresh(button.secButton)
	else
		button.Profession = button.__atlaslootinfo.type[2]
		button.SpellID = button.__atlaslootinfo.type[2]
		Prof.Refresh(button)
	end
end

function Prof.OnClear(button)
	button.Profession = nil
	button.SpellID = nil
	button.tsLink, button.tsName = nil, nil
	button.secButton.Profession = nil
	button.secButton.SpellID = nil
	button.secButton.tsLink, button.secButton.tsName = nil, nil

end

function Prof.OnEnter(button)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	tooltip:SetHyperlink(button.tsLink)
	tooltip:Show()
end

function Prof.OnLeave(button)
	GetAlTooltip():Hide()
end

function Prof.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = ProfClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		AtlasLoot.Button:AddChatLink(button.tsLink or "spell:"..button.SpellID)
	end
end


function Prof.Refresh(button)
	local spellName, _, spellTexture = GetSpellInfo(button.SpellID)
	button.tsLink, button.tsName = GetTradeskillLink(button.SpellID)

	if button.type == "secButton" then

	else
		button.name:SetText(PROF_COLOR..spellName)
		button.extra:SetText(button.tsName)
	end

	button.icon:SetTexture(TRADESKILLS[button.tsName] or spellTexture)

end

--[[
function Prof.GetStringContent(str)
	return {str_match(str, "(%w+):(%d+)")}
end
]]--
