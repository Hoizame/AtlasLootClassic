local ALName, ALPrivate = ...

local _G = _G
local AtlasLoot = _G.AtlasLoot
local AL, ALIL = AtlasLoot.Locales, AtlasLoot.IngameLocales
local ClickHandler = AtlasLoot.ClickHandler
local Token = AtlasLoot.Data.Token

local TYPE, ID_INV, ID_ICON, ID_ABILITY, ID_ADDON, ID_CLASS, ID_SLOT, ID_SPECIAL = "Dummy", "INV_", "ICON_", "ABILITY_", "ADDON_", "CLASS_", "SLOT_", "SPECIAL_"
local Dummy = AtlasLoot.Button:AddType(TYPE, ID_INV)
AtlasLoot.Button:DisableDescriptionReplaceForce(TYPE, true)
local Dummy_ID_ICON = AtlasLoot.Button:AddIdentifier(TYPE, ID_ICON)
local Ability_ID_ICON = AtlasLoot.Button:AddIdentifier(TYPE, ID_ABILITY)
local Dummy_ID_ADDON = AtlasLoot.Button:AddIdentifier(TYPE, ID_ADDON)
local Dummy_ID_CLASS = AtlasLoot.Button:AddIdentifier(TYPE, ID_CLASS)
local Dummy_ID_SLOT = AtlasLoot.Button:AddIdentifier(TYPE, ID_SLOT)
local Dummy_ID_SPECIAL = AtlasLoot.Button:AddIdentifier(TYPE, ID_SPECIAL)

-- lua
local tonumber = tonumber
local format, str_match, str_find = string.format, _G.string.match, string.find

-- WoW


local ITEM_DESC_EXTRA_SEP = "%s | %s"
local DUMMY_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local INTERFACE_PATH = "Interface\\Icons\\"

local SLOT_ICONS = {
	CLOTH = 132889,
	LEATHER = 134251,
	MAIL = 132624,
	PLATE = 134518,

	HEAD = 133131,
	SHOULDERS = 135040,
	CHEST = 132664,
	WRIST = 132606,
	HANDS = 132961,
	WAIST = 132493,
	LEGS = 134582,
	FEET = 132539,

	NECK = 133295,
	BACK = 133753,
	FINGER = 133345,
	TRINKET = 133441,

	WEAPON = 135274,
	OFFHAND = 134249,

	TABARD = 135026,
	SHIRT = 135009,
}

local ACHIEVEMENT_SEARCH_STRING = "ac(%d+)"
local SPECIAL_ICONS = {
	ACHIEVEMENT = function(button)	-- gold ac icon
		button.icon:SetTexture(235410)
		local isCompleted = true
		if button.Extra then
			local tokenData = Token.GetTokenData(button.Extra)
			if tokenData then
				-- check if all ac's are completed
				for i, entry in ipairs(tokenData) do
					if type(entry) == "string" and str_find(entry, ACHIEVEMENT_SEARCH_STRING) then
						local _, name, _, completed = GetAchievementInfo(tonumber(str_match(entry, ACHIEVEMENT_SEARCH_STRING)))
						if not completed then
							isCompleted = false
							break
						end
					end
				end
			end
		end
		if isCompleted then
			button.icon:SetTexCoord(0,0.5,0,1)
		else
			button.icon:SetTexCoord(0.5,1,0,1)
		end
	end,
}


local ItemClickHandler = nil
ClickHandler:Add(
	"Dummy",
	{
		ShowExtraItems = { "LeftButton", "None" },
		types = {
			ShowExtraItems = true,
		},
	},
	{
		{ "ShowExtraItems", AL["Show extra items"], 	AL["Shows extra items (tokens,mats)"] },
	}
)

local function OnInit()
	if not ItemClickHandler then
		ItemClickHandler = ClickHandler:GetHandler("Dummy")
	end
	Dummy.ItemClickHandler = ItemClickHandler
end
AtlasLoot:AddInitFunc(OnInit)

function Dummy.OnSet(button, second)
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.Texture = button.__atlaslootinfo.secType[2]
		button.secButton.Name = button.__atlaslootinfo.Name
		button.secButton.Description = button.__atlaslootinfo.Description
		button.secButton.Extra = button.__atlaslootinfo.Extra
		Dummy.Refresh(button.secButton)
	else
		button.Texture = button.__atlaslootinfo.type[2]
		button.Name = button.__atlaslootinfo.Name
		button.Description = button.__atlaslootinfo.Description
		button.Extra = button.__atlaslootinfo.Extra
		Dummy.Refresh(button)
	end
end

function Dummy.OnClear(button)
	button.Texture = nil
	button.Name = nil
	button.Description = nil
	button.Extra = nil
	if button.icon then
		button.icon:SetTexCoord(0,1,0,1)
	end
	button.secButton.Texture = nil
	button.secButton.Name = nil
	button.secButton.Description = nil
	button.secButton.Extra = nil
	button.secButton.icon:SetTexCoord(0,1,0,1)

	if button.ExtraFrameShown then
		AtlasLoot.Button:ExtraItemFrame_ClearFrame()
		button.ExtraFrameShown = false
	end
end

function Dummy.Refresh(button)
	if button.type == "secButton" then

	else
		button.name:SetText(button.Name)
		local desc
		if button.Extra and Token.IsToken(button.Extra) then
			local tokenDesc = Token.GetTokenDescription(button.Extra)
			if button.Description and Token.TokenTypeAddDescription(button.Extra) then
				desc = format(ITEM_DESC_EXTRA_SEP, button.Description, tokenDesc)
			else
				desc = tokenDesc
			end
		else
			desc = button.Description
		end
		button.extra:SetText(desc)
	end
	button.overlay:Hide()
	if type(button.Texture) == "function" then
		button.Texture(button)
	else
		button.icon:SetTexture(tonumber(button.Texture) or (button.Texture and button.Texture or DUMMY_ICON))
	end
end

function Dummy.OnMouseAction(button, mouseButton)
	if not mouseButton then return end

	mouseButton = ItemClickHandler:Get(mouseButton) or mouseButton
	if mouseButton == "ShowExtraItems" then
		if button.Extra and Token.IsToken(button.Extra) then
			button.ExtraFrameShown = true
			AtlasLoot.Button:ExtraItemFrame_GetFrame(button, Token.GetTokenData(button.Extra))
		end
	end

end

function Dummy.GetStringContent(str)
	return INTERFACE_PATH..ID_INV..str
end

function Dummy_ID_ICON.GetStringContent(str)
	return INTERFACE_PATH..str
end

function Dummy_ID_ADDON.GetStringContent(str)
	return ALPrivate.ICONS_PATH..str
end

function Dummy_ID_CLASS.GetStringContent(str)
	return ALPrivate.CLASS_ICON_PATH[str]
end

function Dummy_ID_SLOT.GetStringContent(str)
	return SLOT_ICONS[str]
end

function Dummy_ID_SPECIAL.GetStringContent(str)
	return SPECIAL_ICONS[str]
end