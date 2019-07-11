local AtlasLoot = _G.AtlasLoot
local Prof = AtlasLoot.Button:AddType("Profession", "prof")
local ItemQuery = AtlasLoot.Button:GetType("Item").Query
local AL = AtlasLoot.Locales
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local Profession = AtlasLoot.Data.Profession

--lua
local str_match = string.match
local GetSpellInfo, GetSpellTexture = GetSpellInfo, GetSpellTexture
local GetTradeskillLink = AtlasLoot.TooltipScan.GetTradeskillLink

local ProfClickHandler = nil

local PROF_COLOR = "|cffffff00"
local ITEM_COLORS = {}
local WHITE_ICON_FRAME = "Interface\\Common\\WhiteIconFrame"

function Prof.OnSet(button, second)
	if not ProfClickHandler then
		ProfClickHandler = AtlasLoot.ClickHandler:Add(
		"Profession",
		{
			ChatLink = { "LeftButton", "Shift" },
			ShowExtraItems = { "LeftButton", "None" },
			types = {
				ChatLink = true,
				ShowExtraItems = true,
			},
		},
		AtlasLoot.db.Button.Profession.ClickHandler,
		{
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add profession link into chat"] },
			{ "ShowExtraItems", AL["Show extra items"], 	AL["Shows extra items (tokens,mats)"] },
		})
		-- create item colors
		for i=0,7 do
			local _, _, _, itemQuality = GetItemQualityColor(i)
			ITEM_COLORS[i] = itemQuality
		end
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
	ItemQuery:Remove(button)
	ItemQuery:Remove(button.secButton)
	button.Profession = nil
	button.SpellID = nil
	button.ItemID = nil
	button.secButton.Profession = nil
	button.secButton.SpellID = nil
	button.secButton.ItemID = nil
	if button.ExtraFrameShown then
		AtlasLoot.Button:ExtraItemFrame_ClearFrame()
		button.ExtraFrameShown = false
	end
end

function Prof.OnEnter(button)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	tooltip:SetSpellByID(button.SpellID)
	tooltip:Show()
end

function Prof.OnLeave(button)
	GetAlTooltip():Hide()
end

function Prof.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = ProfClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		--AtlasLoot.Button:AddChatLink(button.tsLink or "spell:"..button.SpellID)
	elseif mouseButton == "ShowExtraItems" then
		if Profession.IsProfessionSpell(button.SpellID) then
			button.ExtraFrameShown = true
			AtlasLoot.Button:ExtraItemFrame_GetFrame(button, Profession.GetDataForExtraFrame(button.SpellID))
		end
	end
end

-- TODO: Add Query?
function Prof.Refresh(button)
	local spellName, _, spellTexture = GetSpellInfo(button.SpellID)

	if Profession.IsProfessionSpell(button.SpellID) then
		local _, itemName, itemQuality, itemTexture, itemCount
		button.ItemID = Profession.GetCreatedItemID(button.SpellID)
		if button.ItemID then
			itemName, _, itemQuality, _, _, _, _, _, _, itemTexture = GetItemInfo(button.ItemID)
			if not itemName then
				ItemQuery:Add(button)
				return false
			end
			itemCount = Profession.GetNumCreatedItems(button.SpellID)
		end
		itemQuality = itemQuality or 0
		--ItemQuery
		button.overlay:Show()
		button.overlay:SetTexture(WHITE_ICON_FRAME)
		button.overlay:SetAtlas(LOOT_BORDER_BY_QUALITY[itemQuality] or LOOT_BORDER_BY_QUALITY[LE_ITEM_QUALITY_UNCOMMON])
		if not LOOT_BORDER_BY_QUALITY[itemQuality] then
			button.overlay:SetDesaturated(true)
		end

		if button.type == "secButton" then

		else
			if itemName then
				button.name:SetText("|c"..ITEM_COLORS[itemQuality or 0]..(spellName or itemName))
			else
				button.name:SetText(PROF_COLOR..spellName)
			end
			button.extra:SetText(Profession.GetSpellDescription(button.SpellID).." ( "..Profession.GetColorSkillRank(button.SpellID).." )")
		end
		if itemCount > 1 then
			button.count:SetText(itemCount)
			button.count:Show()
		end
		button.icon:SetTexture(itemTexture or Profession.GetIcon(button.SpellID) or spellTexture)
	end

end

--[[
function Prof.GetStringContent(str)
	return {str_match(str, "(%w+):(%d+)")}
end
]]--
