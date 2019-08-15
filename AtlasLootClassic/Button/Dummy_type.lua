local _G = _G
local AtlasLoot = _G.AtlasLoot
local TYPE, ID_INV, ID_ICON, ID_ABILITY = "Dummy", "INV_", "ICON_", "ABILITY_"
local Dummy = AtlasLoot.Button:AddType(TYPE, ID_INV)
local Dummy_ID_ICON = AtlasLoot.Button:AddIdentifier(TYPE, ID_ICON)
local Ability_ID_ICON = AtlasLoot.Button:AddIdentifier(TYPE, ID_ABILITY)

-- lua
local str_match = _G.string.match

-- WoW


local DUMMY_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local INTERFACE_PATH = "Interface\\Icons\\"

function Dummy.OnSet(button, second)
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.Texture = button.__atlaslootinfo.secType[2]
		button.secButton.Name = button.__atlaslootinfo.Name
		button.secButton.Description = button.__atlaslootinfo.Description
		Dummy.Refresh(button.secButton)
	else
		button.Texture = button.__atlaslootinfo.type[2]
		button.Name = button.__atlaslootinfo.Name
		button.Description = button.__atlaslootinfo.Description
		Dummy.Refresh(button)
	end
end

function Dummy.OnClear(button)
	button.Texture = nil
	button.Name = nil
	button.Description = nil
	button.secButton.Texture = nil
	button.secButton.Name = nil
	button.secButton.Description = nil
end

function Dummy.Refresh(button)
	if button.type == "secButton" then

	else
		button.name:SetText(button.Name)
		button.extra:SetText(button.Description)
	end
	button.overlay:Hide()
	button.icon:SetTexture(button.Texture and INTERFACE_PATH..button.Texture or DUMMY_ICON)
end

function Dummy.GetStringContent(str)
	return ID_INV..str
end

function Dummy_ID_ICON.GetStringContent(str)
	return str
end
