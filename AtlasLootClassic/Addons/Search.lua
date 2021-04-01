local _G = getfenv(0)
local unpack = unpack

local AtlasLoot = _G.AtlasLoot
local Search = {}
AtlasLoot.Addons.Search = Search
local AL = AtlasLoot.Locales
local db

function Search.Init()
	db = AtlasLoot.db.Addons.Search
	AtlasLoot.SlashCommands:Add("search", Search.Open, "/al search - Search")
end
AtlasLoot:AddInitFunc(Search.Init)


--################################
-- GUI
--################################
local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		self:StartMoving()
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

local function FrameOnShow(self)

end

function Search:Open()
	if not Search.GUI then
		local frameName = "AtlasLoot_Search-Frame"

		local frame = CreateFrame("Frame", frameName, nil, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
		frame:ClearAllPoints()
		frame:SetParent(UIParent)
		frame:SetPoint(unpack(db.point))
		frame:SetWidth(500)
		frame:SetHeight(500)
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:RegisterForDrag("LeftButton")
		frame:RegisterForDrag("LeftButton", "RightButton")
		frame:SetScript("OnMouseDown", FrameOnDragStart)
		frame:SetScript("OnMouseUp", FrameOnDragStop)
		frame:SetScript("OnShow", FrameOnShow)
		frame:SetToplevel(true)
		frame:SetClampedToScreen(true)
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
							tile = true, tileSize = 16, edgeSize = 16,
							insets = { left = 4, right = 4, top = 4, bottom = 4 }})
		frame:SetBackdropColor(1,1,1,1)
		frame:Hide()
		tinsert(UISpecialFrames, frameName)	-- allow ESC close

		frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
		frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

		frame.Title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		frame.Title:SetPoint("TOP", frame, "TOP", 0, -10)
		frame.Title:SetText(AL["AtlasLoot Search"])

		frame.NameBox = CreateFrame("EditBox", frameName.."-NameBox", frame, "SearchBoxTemplate")
		frame.NameBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -20)
		frame.NameBox:SetWidth(250)
		frame.NameBox:SetHeight(35)
		frame.NameBox:SetAutoFocus(false)
		--frame.NameBox:SetTextInsets(0, 8, 0, 0)
		frame.NameBox:SetMaxLetters(100)
		frame.NameBox:SetScript("OnEnterPressed",function(self)
								print(frame.NameBox:GetText())
								frame.NameBox:ClearFocus()
							end)


		Search.GUI = frame
	elseif Search.GUI:IsShown() then
		Search.GUI:Hide()
		return
	end

	Search.GUI:Show()
end
