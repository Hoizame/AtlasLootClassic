local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local Favourites = AtlasLoot.Addons:GetAddon("Favourites")
if not Favourites then return end
local GUI = {}
Favourites.GUI = GUI

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-- lua


-- WoW

-- locale
local function UpdateItemFrame()
    AtlasLoot.Addons:UpdateStatus(Favourites:GetName())
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
    end
end

local function ShowFavOptions()
    --AtlasLoot.Loader:LoadModule("AtlasLootClassic_Options", ShowFavOptions)
    AtlasLoot.Options:ShowAddon("favourite")
end

local function FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		--if not db.DefaultFrameLocked then
			self:StartMoving()
		--end
	end
end

local function FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	--db.point = { a, nil, c, d, e }
end

local function FrameOnShow(self)
	--if FIRST_SHOW then
	--	self.moduleSelect:SetSelected(db.selected[1])
	--end
	--FIRST_SHOW = false
	--if (AtlasLoot.db.GUI.autoselect) then
		--AtlasLoot:AutoSelect()
	--end
end

local function GlobalCheckOnClick(self, value)
    local db = Favourites:GetDb()
    db.activeList[1] = value and Favourites.BASE_NAME_G or Favourites.BASE_NAME_P
    db.activeList[2] = value
    UpdateItemFrame()
end

local function ShowOptionsOnClick()
    AtlasLoot.Loader:LoadModule("AtlasLootClassic_Options", ShowFavOptions)
end

local function UpdateGUI(self)
    if self.frame then
        self.frame.content.isGlobal:SetChecked(Favourites:GetDb().activeList[2])
    end
    if AtlasLoot.Options then
        AtlasLoot.Options:NotifyChange()
    end

    GUI:UpdateStyle()
    GUI:UpdateDropDown()
end

local function ListDropDownOnSelect(self, id, arg)
    print(id)
end

-- global
function GUI.OnInitialize()
    GUI:Create()
end

function GUI:OnProfileChanged()
    UpdateGUI(GUI)
end

function GUI:OnStatusChanged()
    UpdateGUI(GUI)
end

function GUI:UpdateDropDown()
    if not self.frame then return end

    local data = {
        [1] = {
            info = {
                name = AL["Lists"],
                bgColor = {0, 0, 0, 1},		-- Background color
            }
        }
    }
    local dataEntrys = data[1]
    local listDb
    local db = Favourites:GetDb()
    if db.activeList[2] == true then
        listDb = Favourites:GetGlobaleLists()
    else
        listDb = Favourites:GetProfileLists()
    end
    for k,v in pairs(listDb) do
        dataEntrys[ #dataEntrys + 1 ] = {
            id = k,
            name = Favourites:GetListName(k, db.activeList[2] == true, true),
            --coinTexture = tabVal.CoinTexture,
            tt_title = Favourites:GetListName(k, db.activeList[2] == true, true),
        }

        Favourites:GetListName(k, db.activeList[2] == true, true)
    end

    self.dropDownData = data

    self.frame.content.listSelect:SetData(data, db.activeList[1])
end

function GUI:Create()
    if not self.frame then
        local frameName = "AtlasLoot_GUI-FavouritesFrame"
        local frame = CreateFrame("Frame", frameName)
        frame:ClearAllPoints()
        frame:SetParent(UIParent)
        --frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
        frame:SetPoint("CENTER")
        frame:SetWidth(920)
        frame:SetHeight(600)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:RegisterForDrag("LeftButton", "RightButton")
        frame:SetScript("OnMouseDown", FrameOnDragStart)
        frame:SetScript("OnMouseUp", FrameOnDragStop)
        frame:SetScript("OnShow", FrameOnShow)
        frame:SetToplevel(true)
        frame:SetClampedToScreen(true)
        frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
        frame:Hide()
        --tinsert(UISpecialFrames, frameName)	-- allow ESC close

        frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
        frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 2)

        frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0)
        frame.titleFrame:SetPoint("TOPLEFT", frame, 5, -5)
        frame.titleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -27, -23)
        frame.titleFrame.text:SetText(AL["AtlasLoot"].." - "..AL["Favourites"])

        frame.content = CreateFrame("Frame", nil, frame)
        frame.content:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0, -3)
        frame.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)
        frame.content:SetBackdrop(ALPrivate.BOX_BACKDROP)

        frame.content.listSelect = AtlasLoot.GUI:CreateDropDown()
        frame.content.listSelect:SetParPoint("TOPLEFT", frame.content, "TOPLEFT", 2, -2)
        frame.content.listSelect:SetWidth(270)
        frame.content.listSelect:SetTitle("")
        frame.content.listSelect:SetText(AL["Active list"])
        frame.content.listSelect:SetButtonOnClick(ListDropDownOnSelect)

        frame.content.isGlobal = AtlasLoot.GUI.CreateCheckBox()
        frame.content.isGlobal:SetParPoint("LEFT", frame.content.listSelect.frame, "RIGHT", 5, 0)
        frame.content.isGlobal:SetText(AL["Global lists"])
        frame.content.isGlobal:SetOnClickFunc(GlobalCheckOnClick)
        frame.content.isGlobal:SetChecked(Favourites:GetDb().activeList[2])

        frame.content.optionsButton = AtlasLoot.GUI.CreateButton()
        frame.content.optionsButton:SetPoint("LEFT", frame.content.isGlobal.frame.text, "RIGHT", 5, 0)
        frame.content.optionsButton:SetText(ALIL["Settings"])
        frame.content.optionsButton:SetScript("OnClick", ShowOptionsOnClick)

        self.frame = frame

        GUI:UpdateStyle()
        GUI:UpdateDropDown()
    end
    self.frame:Show()
end

function GUI:UpdateStyle()
    if not self.frame then return end
    local frame = self.frame
    local db = Favourites.db.GUI

    -- main
    frame:SetBackdropColor(db.bgColor.r, db.bgColor.b, db.bgColor.g, db.bgColor.a)
    frame:SetScale(db.scale)

    -- title
    frame.titleFrame:SetBackdropColor(db.title.bgColor.r, db.title.bgColor.g, db.title.bgColor.b, db.title.bgColor.a)
    frame.titleFrame:SetFont(LibSharedMedia:Fetch("font", db.title.font), db.title.size)
    frame.titleFrame.text:SetTextColor(db.title.textColor.r, db.title.textColor.g, db.title.textColor.b, db.title.textColor.a)

    -- content
    frame.content:SetBackdropColor(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
end