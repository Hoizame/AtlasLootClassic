local AtlasLoot = _G.AtlasLoot
local Prof = AtlasLoot.Button:AddType("Profession", "prof")
local Item_ButtonType = AtlasLoot.Button:GetType("Item")
local ItemQuery = Item_ButtonType.Query
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

AtlasLoot.ClickHandler:Add(
	"Profession",
	{
		ChatLink = { "LeftButton", "Shift" },
		ShowExtraItems = { "LeftButton", "None" },
		DressUp = { "LeftButton", "Ctrl" },
		WoWHeadLink = { "RightButton", "Shift" },
		types = {
			ChatLink = true,
			ShowExtraItems = true,
			DressUp = true,
			WoWHeadLink = true,
		},
	},
	{
		{ "ChatLink", 		AL["Chat Link"], 			AL["Add profession link into chat"] },
		{ "DressUp", 		AL["Dress up"], 			AL["Shows the item in the Dressing room"] },
		{ "ShowExtraItems", AL["Show extra items"], 	AL["Shows extra items (tokens,mats)"] },
		{ "WoWHeadLink", 	AL["Show WowHead link"], 	AL["Shows a copyable link for WoWHead"] },
	}
)

function Prof.OnSet(button, second)
	if not ProfClickHandler then
		ProfClickHandler = AtlasLoot.ClickHandler:GetHandler("Profession")

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
	tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 5)
	tooltip:SetSpellByID(button.SpellID)
	if AtlasLoot.db.showIDsInTT then
		tooltip:AddDoubleLine("SpellID:", button.SpellID)
	end
	tooltip:Show()
end

function Prof.OnLeave(button)
	GetAlTooltip():Hide()
end

local PROF_STRING = "|cffffffff|Henchant:%d|h[%s]|h|r"
function Prof.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = ProfClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		if button.ItemID then
			local itemInfo, itemLink = GetItemInfo(button.ItemID)
			AtlasLoot.Button:AddChatLink(itemLink)
		elseif button.SpellID then
			local spellName = GetSpellInfo(button.SpellID)
			AtlasLoot.Button:AddChatLink(string.format(PROF_STRING, button.SpellID, spellName))
		end
	elseif mouseButton == "WoWHeadLink" then
		AtlasLoot.Button:OpenWoWHeadLink(button, "spell", button.SpellID)
	elseif mouseButton == "DressUp" then
		if button.ItemID then
			local itemInfo, itemLink = GetItemInfo(button.ItemID)
			if itemLink then
				DressUpItemLink(itemLink)
			end
		end
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

		button.overlay:Show()
		-- enchanting border
		if not button.ItemID then
			itemQuality = "gold"
		end
		button.overlay:SetQualityBorder(itemQuality)

		if button.type == "secButton" then

		else
			if itemName then
				button.name:SetText("|c"..ITEM_COLORS[itemQuality or 0]..(spellName or itemName))
			else
				button.name:SetText(PROF_COLOR..spellName)
			end
			button.extra:SetText(Profession.GetSpellDescriptionWithRank(button.SpellID))
		end
		if itemCount and itemCount > 1 then
			button.count:SetText(itemCount)
			button.count:Show()
		end
		if AtlasLoot.db.ContentPhase.enableOnCrafting then
			local phaseT = Profession.GetPhaseTextureForSpellID(button.SpellID)
			if phaseT then
				button.phaseIndicator:SetTexture(phaseT)
				button.phaseIndicator:Show()
			end
		end

		--Profession.GetPhaseTextureForSpellID(spellID)
		button.icon:SetTexture(itemTexture or Profession.GetIcon(button.SpellID) or spellTexture)
	end

end

--[[
function Prof.GetStringContent(str)
	return {str_match(str, "(%w+):(%d+)")}
end
]]--
