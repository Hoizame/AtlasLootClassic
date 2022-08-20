local ALName, ALPrivate = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end

local AC = AtlasLoot.Button:AddType("Achievement", "ac")
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler

local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

-- lua
local format, str_match = string.format, _G.string.match

-- WoW
local GetAchievementLink = GetAchievementLink

-- AC
local AC_COLOR = "|cffffff00"


local ACClickHandler = ClickHandler:Add(
	"Achievement",
	{
		WoWHeadLink = { "RightButton", "Shift" },
		ChatLink = { "LeftButton", "Shift" },
		GoTo = { "LeftButton", "None" },
		types = {
			ChatLink = true,
			WoWHeadLink = true,
		},
	},
	{
		{ "ChatLink", 	    AL["Chat Link"], 	        	AL["Add achievement into chat"] },
		{ "WoWHeadLink", 	AL["Show WowHead link"], 		AL["Shows a copyable link for WoWHead"] },
		{ "GoTo",			AL["Open Achievement frame"],	AL["Open Achievement frame"] },
	}
)

function AC.OnSet(button, second)
	if not button then return end

	if second and button.__atlaslootinfo.secType then
        button.secButton.AcID = button.__atlaslootinfo.secType[2]
		AC.Refresh(button.secButton)
	else
        button.AcID = button.__atlaslootinfo.type[2]
		AC.Refresh(button)
	end
end

function AC.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = ACClickHandler:Get(mouseButton)
	if mouseButton == "WoWHeadLink" then
		AtlasLoot.Button:OpenWoWHeadLink(button, "achievement", button.AcID)
    elseif mouseButton == "ChatLink" then
        AtlasLoot.Button:AddChatLink(GetAchievementLink(button.AcID) or "achievement:"..button.AcID)
	elseif mouseButton == "GoTo" then
		if not IsAddOnLoaded("Blizzard_AchievementUI") then
			LoadAddOn("Blizzard_AchievementUI")
		end
		ShowUIPanel(_G.AchievementFrame)
		_G.AchievementFrame_SelectAchievement(button.AcID)
	end
end

function AC.OnEnter(button, owner)
	if not button.AcID then return end
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 5)
	end
	tooltip:SetHyperlink(GetAchievementLink(button.AcID))
	tooltip:Show()
end

function AC.OnLeave(button)
	GetAlTooltip():Hide()
end

function AC.OnClear(button)
	button.AcID = nil
	if button.overlay then
		button.overlay:SetAchievementBorder(false)
	end

	button.secButton.AcID = nil
	button.secButton.overlay:SetAchievementBorder(false)

	if button.icon then
		button.icon:SetDesaturated(false)
	end
	button.secButton.icon:SetDesaturated(false)
end

function AC.GetStringContent(str)
    return tonumber(str)
end

-- UI-Achievement-IconFrame


function AC.Refresh(button)
	if not button.AcID then return end

	local _, name, _, completed, _, _, _, _, _, icon, rewardText, isGuild = GetAchievementInfo(button.AcID)

	if button.type == "secButton" then

	else
		button.name:SetText(AC_COLOR..name)
		button.extra:SetText(rewardText)
	end

	if not completed then
		button.icon:SetDesaturated(true)
		button.overlay:SetDesaturated(true)
	end

	button.icon:SetTexture(icon)
	button.overlay:SetAchievementBorder(true, isGuild)

	return true
end

function AC.ShowToolTipFrame(button)

end

