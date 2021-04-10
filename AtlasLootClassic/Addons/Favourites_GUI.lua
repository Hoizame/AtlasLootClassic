local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local Favourites = AtlasLoot.Addons:GetAddon("Favourites")
local ItemButtonType = AtlasLoot.Button:GetType("Item")
if not Favourites then return end
local GUI = {}
Favourites.GUI = GUI

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-- lua
local type = _G.type
local pairs = _G.pairs
local format = _G.format

-- WoW
local GetItemQuality, GetItemIcon, GetItemInfoInstant, ItemExist = _G.C_Item.GetItemQualityByID, _G.C_Item.GetItemIconByID, _G.GetItemInfoInstant, _G.C_Item.DoesItemExistByID
local GetItemCount = _G.GetItemCount

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

-- const
local TT_INFO_ENTRY = "|cFFCFCFCF%s:|r %s"
local EMPTY_SLOT_DUMMY = 136509 -- emptyslot
local EMPTY_SLOTS = {
    [INVSLOT_AMMO]      = 136510, -- ammo
    [INVSLOT_HEAD]      = 136516, -- head
    [INVSLOT_NECK]      = 136519, -- neck
    [INVSLOT_SHOULDER]  = 136526, -- shoulder
    [INVSLOT_BODY]      = 136525, -- shirt
    [INVSLOT_CHEST]     = 136512, -- chest
    [INVSLOT_WAIST]     = 136529, -- waist
    [INVSLOT_LEGS]      = 136517, -- legs
    [INVSLOT_FEET]      = 136513, -- feet
    [INVSLOT_WRIST]     = 136530, -- wrists
    [INVSLOT_HAND]      = 136515, -- hands
    [INVSLOT_FINGER1]   = 136514, -- finger
    [INVSLOT_FINGER2]   = 136514, -- finger
    [INVSLOT_TRINKET1]  = 136528, -- trinket
    [INVSLOT_TRINKET2]  = 136528, -- trinket
    [INVSLOT_BACK]      = 136512, -- chest ( back )
    [INVSLOT_MAINHAND]  = 136518, -- mainhand
    [INVSLOT_OFFHAND]   = 136524, -- secondaryhand
    [INVSLOT_RANGED]    = 136520, -- ranged
    [INVSLOT_TABARD]    = 136527, -- tabard
    --[0] = 136522, -- relic
    -- Bags
    [20] = 136511, -- bag
    [21] = 136511, -- bag
    [22] = 136511, -- bag
    [23] = 136511, -- bag
}
local SLOT_CHECK = {
    ["INVTYPE_AMMO"]        	= INVSLOT_AMMO,
    ["INVTYPE_HEAD"]        	= INVSLOT_HEAD,
    ["INVTYPE_NECK"]        	= INVSLOT_NECK,
    ["INVTYPE_SHOULDER"]    	= INVSLOT_SHOULDER,
    ["INVTYPE_BODY"]        	= INVSLOT_BODY,
    ["INVTYPE_CHEST"]       	= INVSLOT_CHEST,
    ["INVTYPE_ROBE"]        	= INVSLOT_CHEST,
    ["INVTYPE_WAIST"]       	= INVSLOT_WAIST,
    ["INVTYPE_LEGS"]        	= INVSLOT_LEGS,
    ["INVTYPE_FEET"]        	= INVSLOT_FEET,
    ["INVTYPE_WRIST"]       	= INVSLOT_WRIST,
    ["INVTYPE_HAND"]        	= INVSLOT_HAND,
    ["INVTYPE_FINGER"]      	= { [INVSLOT_FINGER1] = true, [INVSLOT_FINGER2] = true },
    ["INVTYPE_TRINKET"]     	= { [INVSLOT_TRINKET1] = true, [INVSLOT_TRINKET2] = true },
    ["INVTYPE_CLOAK"]       	= INVSLOT_BACK,
    ["INVTYPE_WEAPON"]      	= { [INVSLOT_MAINHAND] = true, [INVSLOT_OFFHAND] = true },
    ["INVTYPE_SHIELD"]      	= INVSLOT_OFFHAND,
    ["INVTYPE_2HWEAPON"]        = INVSLOT_MAINHAND,
    ["INVTYPE_WEAPONMAINHAND"]  = INVSLOT_MAINHAND,
    ["INVTYPE_WEAPONOFFHAND"]   = INVSLOT_OFFHAND,
    ["INVTYPE_HOLDABLE"]        = INVSLOT_OFFHAND,
    ["INVTYPE_RANGED"]          = INVSLOT_RANGED,
    ["INVTYPE_THROWN"]          = INVSLOT_RANGED,
    ["INVTYPE_RANGEDRIGHT"]     = INVSLOT_RANGED,
    ["INVTYPE_RELIC"]           = INVSLOT_RANGED,
    ["INVTYPE_TABARD"]          = INVSLOT_TABARD,
    ["INVTYPE_BAG"]             = { [20] = true, [21] = true, [22] = true, [23] = true },
    ["INVTYPE_QUIVER"]          = { [20] = true, [21] = true, [22] = true, [23] = true },
}
local SLOTID_ITYPE = {}
for k,v in pairs(SLOT_CHECK) do
    if type(v) == "table" then
        for x, y in pairs(v) do
            if not SLOTID_ITYPE[x] then SLOTID_ITYPE[x] = {} end
            SLOTID_ITYPE[x][#SLOTID_ITYPE[x] + 1] = k
            SLOTID_ITYPE[x][k] = true
        end
    else
        if not SLOTID_ITYPE[v] then SLOTID_ITYPE[v] = {} end
        SLOTID_ITYPE[v][#SLOTID_ITYPE[v] + 1] = k
        SLOTID_ITYPE[v][k] = true
    end
end
local SLOTS_ROWS = {
    left = { 1, 2, 3, 15, 5, 4, 19, 9 },
    right = { 10, 6, 7, 8, 11, 12, 13, 14 },
    bottom = { 16, 17, 18 },
}
local EQUIP_ITEM_SIZE, LIST_ITEM_SIZE = 35, 35

-- locale
local function UpdateItemFrame(notPushChange)
    if not notPushChange then
        if AtlasLoot.Options then
            AtlasLoot.Options:NotifyChange()
        end
        AtlasLoot.Addons:UpdateStatus(Favourites:GetName())
    end
    if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
        AtlasLoot.GUI.ItemFrame:Refresh(true)
    end
end

local function ShowFavOptions()
    AtlasLoot.Options:ShowAddon("favourite")
end

local function ShowOptionsOnClick()
    AtlasLoot.Loader:LoadModule("AtlasLootClassic_Options", ShowFavOptions)
end

local function ShowAllItemsOnClick()
    GUI:SelectSlot(nil)
end

local function UpdateGUI(self, noListUpdate)
    if not self.frame or not self.frame:IsShown() then return end
    if self.frame then
        self.frame.content.isGlobal:SetChecked(Favourites:GetDb().activeList[2])
    end

    GUI:UpdateStyle()
    GUI:UpdateDropDown()
    if not noListUpdate then
        GUI:ItemListUpdate()
    end
end

local function ShowItemList(slotID)
    if not GUI.frame then return end
    local itemList = GUI.frame.content.slotFrame.itemList
    if not itemList then return end
    if not slotID or not GUI.frame.content.slotFrame.slots[slotID] then
        GUI.frame.content.scrollFrame:SetItems(itemList.ALL, false)
        GUI.selectedButton = nil
    elseif itemList.ItemsBySlot[slotID] then
        GUI.frame.content.scrollFrame:SetItems(itemList.ItemsBySlot[slotID])
        GUI.selectedButton = GUI.frame.content.slotFrame.slots[slotID]
    else
        --SLOTID_ITYPE
        local slot = GUI.frame.content.slotFrame.slots[slotID]
        local newList = {}
        for i = 1, #itemList.ALL do
            local itemID = itemList.ALL[i]
            -- IDToEquipLoc
            if slot.equipLoc[itemList.IDToEquipLoc[itemID]] then
                newList[#newList+1] = itemID
            end
        end
        itemList.ItemsBySlot[slotID] = newList
        GUI.frame.content.scrollFrame:SetItems(newList)
        GUI.selectedButton = slot
    end
end

-- ###########################
-- GUI Frame functions
-- ###########################
local function GUI_FrameOnDragStart(self, arg1)
	if arg1 == "LeftButton" then
		--if not db.DefaultFrameLocked then
			self:StartMoving()
		--end
	end
end

local function GUI_FrameOnDragStop(self)
	self:StopMovingOrSizing()
	local a,b,c,d,e = self:GetPoint()
	--db.point = { a, nil, c, d, e }
end

local function GUI_FrameOnShow(self)
	UpdateGUI(GUI)
end

local function GUI_FrameOnHide(self)
    GUI.frame.content.slotFrame.itemList = nil
end

local function GUI_GlobalCheckOnClick(self, value)
    local db = Favourites:GetDb()
    db.activeList[1] = value and Favourites.BASE_NAME_G or Favourites.BASE_NAME_P
    db.activeList[2] = value
    UpdateItemFrame()
end

local function GUI_ListDropDownOnSelect(self, id, arg, userClick)
    if not userClick then return end
    Favourites:GetDb().activeList[1] = id
    UpdateItemFrame()
end

local function GUI_EditBoxOnTextChange(self)
    Favourites:AddItemID(self:GetNumber())
    self:SetText("")
end

local function GUI_EditBoxOnEnterPressed(self)
    GUI_EditBoxOnTextChange(self)
    self:ClearFocus()
end

local function GUI_InfoOnEnter(self)
    local tooltip = GetAlTooltip()
    tooltip:SetOwner(self, "ANCHOR_LEFT", (self:GetWidth() * 0.5), 5)
    tooltip:AddLine(AL["Favourites"], 0, 1, 0)
    tooltip:AddLine(format(TT_INFO_ENTRY, AL["Alt + Left Click"], AL["Remove item from list"]))
    tooltip:AddLine(ALIL["Dressing Room"]..":", 1, 1, 1)
    tooltip:AddLine(format(TT_INFO_ENTRY, AL["Right Click"], AL["Undress item"]))
    tooltip:Show()
end

local function GUI_InfoOnLeave(self)
    GetAlTooltip():Hide()
end


-- ###########################
-- Slot functions
-- ###########################
local function SlotButton_OnEnter(self, motion)
    if self.ItemID then
        ItemButtonType.OnEnter(self)
    end
end

local function SlotButton_OnLeave(self, motion)
    if self.ItemID then
        ItemButtonType.OnLeave(self)
    end
end

local function SlotButton_OnClick(self, button, down)
    if not IsModifierKeyDown() then
        if button == "LeftButton" then
            if self.slotFrameButton then
                GUI:SelectSlot(self.slotID)
            elseif self.listFrameButton then
                if GUI.selectedButton then
                    Favourites:SetAsMainItem(GUI.selectedButton.slotID, self.ItemID)
                    GUI.selectedButton:SetSlotItem(self.ItemID)
                end
            end
        elseif button == "RightButton" then
            -- clear slot
            if self.slotFrameButton then
                SlotButton_OnLeave(self)
                Favourites:SetMainItemEmpty(self.slotID)
                self:SetSlotItem()
            end
        end
    elseif self.ItemID then
        local b = ItemButtonType.ItemClickHandler:Get(button)
        ItemButtonType.OnMouseAction(self, button)
        if b == "SetFavourite" then
            UpdateItemFrame(true)
        end
    end
end

local function SlotButton_OnEvent(self, event, itemID, success)
    if event == "GET_ITEM_INFO_RECEIVED" and itemID == self.ItemID and success then
        self.overlay:SetQualityBorder(GetItemQuality(itemID))
        self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
    end
end

local function SlotButton_SetSlot(self, slotID)
    if slotID then
        self.slotID = slotID
        self.equipLoc = SLOTID_ITYPE[slotID]
        self.icon:SetTexture(EMPTY_SLOTS[slotID] or EMPTY_SLOT_DUMMY)
    else
        self.slotID = nil
        self.equipLoc = nil
        self.icon:SetTexture(EMPTY_SLOT_DUMMY)
    end
end

local function SlotButton_SetSlotItem(self, itemID)
    if itemID and itemID ~= true and ItemExist(itemID) then
        local _, _, _, itemEquipLoc, icon = GetItemInfoInstant(itemID)
        if not self.slotID or (self.equipLoc and self.equipLoc[itemEquipLoc]) then
            self.ItemID = itemID
            local quality = GetItemQuality(itemID)
            self.overlay:SetQualityBorder(quality)
            if not quality then
                self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
            else
                self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
            end
            self.overlay:Show()
            self.icon:SetTexture(icon)
            if self.modelFrame then
                self.modelFrame:TryOn("item:"..itemID)
            end
        end
        if GetItemCount(itemID, true) > 0 then
            self.ownedItem:Show()
        else
            self.ownedItem:Hide()
        end
    else
        self.icon:SetTexture(EMPTY_SLOTS[self.slotID] or EMPTY_SLOT_DUMMY)
        self.overlay:Hide()
        if self.modelFrame then
            self.modelFrame:UndressSlot(self.slotID)
        end
        self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
        self.ItemID = nil
        self.ownedItem:Hide()
    end
end

local function Slot_CreateSlotButton(parFrame, slotID, modelFrame)
	local frame = CreateFrame("BUTTON", nil, parFrame)
	frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	frame:SetScript("OnEnter", SlotButton_OnEnter)
	frame:SetScript("OnLeave", SlotButton_OnLeave)
    frame:SetScript("OnClick", SlotButton_OnClick)
    frame:SetScript("OnEvent", SlotButton_OnEvent)
    frame:RegisterForClicks("AnyDown")

	-- secButtonTexture <texture>
	frame.icon = frame:CreateTexture(nil, frame)
	frame.icon:SetAllPoints(frame)

	-- secButtonOverlay <texture>
	frame.overlay = frame:CreateTexture(nil, "OVERLAY")
	frame.overlay:SetAllPoints(frame.icon)
	frame.overlay:Hide()
    frame.overlay.SetQualityBorder = AtlasLoot.Button.Button_Overlay_SetQualityBorder

    -- count
    frame.count = frame:CreateFontString(nil, "ARTWORK", "AtlasLoot_ItemAmountFont")
	frame.count:SetPoint("BOTTOMRIGHT", frame.icon, "BOTTOMRIGHT", -3, 2)
	frame.count:SetJustifyH("RIGHT")
	frame.count:SetHeight(15)
    frame.count:SetText(0)

    frame.ownedItem = frame:CreateTexture(nil, "OVERLAY")
	frame.ownedItem:SetPoint("BOTTOMLEFT", frame.icon)
	frame.ownedItem:SetHeight(20)
	frame.ownedItem:SetWidth(20)
    frame.ownedItem:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    frame.ownedItem:SetDrawLayer(frame.overlay:GetDrawLayer(), 2)
	frame.ownedItem:Hide()

    --info
    frame.modelFrame = modelFrame

    -- function
    frame.SetSlotItem = SlotButton_SetSlotItem
    frame.SetSlot = SlotButton_SetSlot

    frame:SetSlot(slotID)

    return frame
end

local function Slot_CreateSlotRow(frame, slotList, frameSlots, size, startAnchor, startX, startY, direction, gap)
    local maxCount = #slotList
    gap = gap or 0
    size = size or 30
    local fullSize = ( size * maxCount ) + ( gap * maxCount ) - gap
    local rowFrame = CreateFrame("FRAME", nil, frame)
    rowFrame:SetPoint(startAnchor, startX or 0, startY or 0)
    if direction == "LEFT" or direction == "RIGHT" then
        rowFrame:SetWidth(fullSize)
        rowFrame:SetHeight(size)
    else
        rowFrame:SetWidth(size)
        rowFrame:SetHeight(fullSize)
    end

    for i = 1, maxCount do
        local slotNum = slotList[i]
        local slot = Slot_CreateSlotButton(rowFrame, slotNum, frame.modelFrame)
        slot:SetSize(size, size)
        slot.slotFrameButton = true
        if i == 1 then
            slot:SetPoint("TOPLEFT", 0, 0)
        elseif direction == "LEFT" then
            slot:SetPoint("RIGHT", frameSlots[ slotList[i - 1] ], "LEFT", -gap, 0)
        elseif direction == "RIGHT" then
            slot:SetPoint("LEFT", frameSlots[ slotList[i - 1] ], "RIGHT", gap, 0)
        elseif direction == "UP" then
            slot:SetPoint("BOTTOM", frameSlots[ slotList[i - 1] ], "TOP", 0, gap)
        elseif direction == "DOWN" then
            slot:SetPoint("TOP", frameSlots[ slotList[i - 1] ], "BOTTOM", 0, - gap)
        end
       slot:SetSlotItem() -- init with empty slot
        slot:Show()
        slot.rowFrame = rowFrame
        frameSlots[slotNum] = slot
    end

    return rowFrame
end

local function Slot_ResetSlots(self)
    for slotID, slot in pairs(self.slots) do
        slot:SetSlotItem(nil)
    end
end

-- update item list
local function Slot_Update(self)
    local list = Favourites:GetActiveList()
    local slotFrames = self.slots
    local mainItems = Favourites:GetMainListItems()
    local itemList = {
        ALL = {},
        EquipLoc = {},
        IDToEquipLoc = {},
        ItemsBySlot = {}, -- filled with ShowItemList(slotID) 'cache'
    }
    self.itemList = itemList

    for itemID, state in pairs(list) do
        local _, _, _, itemEquipLoc, icon = GetItemInfoInstant(itemID)
        if itemEquipLoc then
            if not itemList.EquipLoc[itemEquipLoc] then
                itemList.EquipLoc[itemEquipLoc] = {}
            end
            itemList.EquipLoc[itemEquipLoc][#itemList.EquipLoc[itemEquipLoc] + 1] = itemID
            itemList.ALL[#itemList.ALL + 1] = itemID
            itemList.IDToEquipLoc[itemID] = itemEquipLoc
        end
    end

    self:ResetSlots()
    self.modelFrame:Undress()

    local setn = {}
    for slotID, slot in pairs(slotFrames) do
        local counter, set = 0, false
        if slot.equipLoc then
            local elCount = #slot.equipLoc
            if mainItems and mainItems[slotID] then
                slot:SetSlotItem(mainItems[slotID])
                set = true
                setn[mainItems[slotID]] = true
            end
            for i = 1, elCount do
                local el = slot.equipLoc[i]
                local elTab = itemList.EquipLoc[el]
                if elTab then
                    counter = counter + #elTab
                    if not set and #elTab > 0 then
                        if not setn[elTab[1]] then
                            slot:SetSlotItem(elTab[1])
                            setn[elTab[1]] = true
                            set = true
                        elseif #elTab > 1 then
                            for j=1, #elTab do
                                if not setn[elTab[j]] then
                                    slot:SetSlotItem(elTab[j])
                                    setn[elTab[j]] = true
                                    set = true
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        slot.count:SetText(counter)
    end
    ShowItemList(itemList.ALL)
end

local function Slot_CreateSlotFrame(frame)
    frame.modelFrame = CreateFrame("DressUpModel", nil, frame, "ModelWithControlsTemplate")
    frame.slots = {}
    frame.rowFrame = {}
    frame.rowFrame.left = Slot_CreateSlotRow(frame, SLOTS_ROWS.left, frame.slots, EQUIP_ITEM_SIZE, "TOPLEFT", 0, 0, "DOWN", 2)
    frame.rowFrame.right = Slot_CreateSlotRow(frame, SLOTS_ROWS.right, frame.slots, EQUIP_ITEM_SIZE, "TOPRIGHT", 0, 0, "DOWN", 2)
    frame.rowFrame.bottom = Slot_CreateSlotRow(frame, SLOTS_ROWS.bottom, frame.slots, EQUIP_ITEM_SIZE, "TOP", 0, -(frame.rowFrame.left:GetHeight() - (EQUIP_ITEM_SIZE * 0.5)), "RIGHT", 2)

    frame.modelFrame:SetPoint("TOPLEFT", frame.rowFrame.left, "TOPRIGHT", 0, 0)
    frame.modelFrame:SetPoint("BOTTOMRIGHT", frame.rowFrame.right, "BOTTOMLEFT", 0, EQUIP_ITEM_SIZE * 0.5)
    frame.modelFrame.defaultRotation = MODELFRAME_DEFAULT_ROTATION
    frame.modelFrame:SetRotation(MODELFRAME_DEFAULT_ROTATION)
    frame.modelFrame:SetUnit("player")
    frame.modelFrame.minZoom = 0
    frame.modelFrame.maxZoom = 1.0
    frame.modelFrame.curRotation = MODELFRAME_DEFAULT_ROTATION
    frame.modelFrame.zoomLevel = frame.modelFrame.minZoom
    frame.modelFrame.zoomLevelNew = frame.modelFrame.zoomLevel
    frame.modelFrame:SetPortraitZoom(frame.modelFrame.zoomLevel)
    frame.modelFrame.Reset = _G.Model_Reset

    frame.UpdateSlots = Slot_Update
    frame.ResetSlots = Slot_ResetSlots
end

-- ###########################
-- Item Scrollframe
-- ###########################
local function ItemScroll_GetStartAndEndPos(self)
    if not self.scrollEnabled then
        return 1, self.maxItems
    end

    local startPos, endPos = 1,1

    startPos = ( (self.curPos-1) * self.maxItemsPerRow )
    startPos = startPos <= 0 and 1 or startPos+1
    endPos = startPos + self.maxItems - 1

    return startPos, endPos
end

local function ItemScroll_CreateItemButton(self)
    local button = Slot_CreateSlotButton(self)
    button.count:Hide()
    return button
end

local function ItemScroll_Update(self)
    if not self or not self.itemList then return end
    local startPos, endPos = ItemScroll_GetStartAndEndPos(self)
    local itemList = self.itemList
    local buttonCount = 0
    for i = 1, self.maxItems do
        local itemID = itemList[startPos + i - 1]
        if itemID then
            local item = self.itemButtons[i]
            if not item then
                item = ItemScroll_CreateItemButton(self)
                item.listFrameButton = true
                item:SetSize(LIST_ITEM_SIZE, LIST_ITEM_SIZE)
                if i == 1 then
                    item:SetPoint("TOPLEFT", 0, 0)
                elseif (i-1) % self.maxItemsPerRow == 0 then
                    item:SetPoint("TOP", self.itemButtons[i-self.maxItemsPerRow], "BOTTOM", 0, -(self.itemGapH))
                else
                    item:SetPoint("LEFT", self.itemButtons[i-1], "RIGHT", self.itemGapV, 0)
                end
                self.itemButtons[i] = item
            end
            item:SetSlotItem(itemID)
            item:Show()
        elseif self.itemButtons[i] then
            self.itemButtons[i]:Hide()
        else
            break
        end
    end
end

local function ItemScroll_ClearItems(self)
    if #self.itemButtons <= 0 then return end
    for i = 1, #self.itemButtons do
        self.itemButtons[i]:Hide()
    end
end

-- scrollFrame.SetItems
local function ItemScroll_SetItems(self, itemList, forceUpdate)
    if not forceUpdate and self.itemList == itemList then return end
    self.itemList = itemList
    local itemButtons = self.itemButtons

    ItemScroll_ClearItems(self)

    self.curPos = 1
    self.maxScroll = ( floor((#itemList / self.maxItemsPerRow)+0.5) - self.maxItemRows ) + 1
    if self.maxScroll > 0 then
        self.scrollEnabled = true
        self.scrollbar:SetValue(1)
        self.scrollbar:SetMinMaxValues(1, self.maxScroll)
    else
        self.scrollEnabled = false
        self.scrollbar:SetValue(1)
        self.scrollbar:SetMinMaxValues(1, 1)
    end

    ItemScroll_Update(self)
end

-- value: up +1, down -1
local function ItemScroll_OnMouseWheel(self, value)
    if not self.scrollEnabled then return end
	self.curPos = self.curPos - value
	if self.curPos >= self.maxScroll then self.curPos = self.maxScroll end
	if self.curPos <= 0 then self.curPos = 1 end
	self.scrollbar:SetValue(min(self.curPos, self.maxScroll))
end

local function ItemScroll_OnValueChanged(self, value)
    if not self.obj.scrollEnabled then return end
    self = self.obj
	self.curPos = floor(value)
    if self.curPos <= 0 then self.curPos = 1 end
	ItemScroll_Update(self)
end

-- ###########################
-- Base
-- ###########################
function GUI.OnInitialize()
end

function GUI:OnProfileChanged()
    UpdateGUI(GUI, true)
end

function GUI:OnStatusChanged()
    UpdateGUI(GUI, true)
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
        listDb = Favourites:GetGlobaleLists(true)
    else
        listDb = Favourites:GetProfileLists(true)
    end
    for i,v in ipairs(listDb) do
        dataEntrys[ #dataEntrys + 1 ] = {
            id = v.id,
            name = v.nameIcon,
            tt_title = v.nameIcon,
        }
    end

    self.dropDownData = data

    self.frame.content.listSelect:SetData(data, db.activeList[1])
end

function GUI:Toggle()
    if not self.frame then GUI:Create() end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

function GUI:Create()
    if not self.frame then
        local frameName = "AtlasLoot_GUI-FavouritesFrame"
        local frame = CreateFrame("Frame", frameName, nil, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame:ClearAllPoints()
        frame:SetParent(UIParent)
        --frame:SetPoint(db.point[1], db.point[2], db.point[3], db.point[4], db.point[5])
        frame:SetPoint("CENTER")
        frame:SetWidth(600)
        frame:SetHeight(380)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:RegisterForDrag("LeftButton", "RightButton")
        frame:SetScript("OnMouseDown", GUI_FrameOnDragStart)
        frame:SetScript("OnMouseUp", GUI_FrameOnDragStop)
        frame:SetScript("OnShow", GUI_FrameOnShow)
        frame:SetScript("OnHide", GUI_FrameOnHide)
        frame:SetToplevel(true)
        frame:SetClampedToScreen(true)
        frame:SetBackdrop(ALPrivate.BOX_BACKDROP)
        tinsert(UISpecialFrames, frameName)	-- allow ESC close

        frame.CloseButton = CreateFrame("Button", frameName.."-CloseButton", frame, "UIPanelCloseButton")
        frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 3, 2)

        frame.titleFrame = AtlasLoot.GUI.CreateTextWithBg(frame, 0, 0)
        frame.titleFrame:SetPoint("TOPLEFT", frame, 5, -5)
        frame.titleFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -27, -23)
        frame.titleFrame.text:SetText(AL["AtlasLoot"].." - "..AL["Favourites"])

        frame.infoButton = CreateFrame("Button", nil, frame, "UIPanelInfoButton")
        frame.infoButton:SetPoint("RIGHT", frame.titleFrame, "RIGHT", -1, 0)
        frame.infoButton:SetScript("OnEnter", GUI_InfoOnEnter)
        frame.infoButton:SetScript("OnLeave", GUI_InfoOnLeave)

        frame.content = CreateFrame("Frame", nil, frame)
        frame.content:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0, -3)
        frame.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)

        frame.content.slotBg = CreateFrame("Frame", nil, frame.content, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame.content.slotBg:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 0, 0)
        frame.content.slotBg:SetPoint("BOTTOMRIGHT", frame.content, "BOTTOMLEFT", 275, 0)
        frame.content.slotBg:SetBackdrop(ALPrivate.BOX_BACKDROP)

        frame.content.headerBg = CreateFrame("Frame", nil, frame.content, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame.content.headerBg:SetPoint("TOPLEFT", frame.content.slotBg, "TOPRIGHT", 0, 0)
        frame.content.headerBg:SetPoint("BOTTOMRIGHT", frame.content, "TOPRIGHT", 0, -27)
        frame.content.headerBg:SetBackdrop(ALPrivate.BOX_BACKDROP)

        frame.content.bottomBg = CreateFrame("Frame", nil, frame.content, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame.content.bottomBg:SetPoint("TOPLEFT", frame.content.slotBg, "BOTTOMRIGHT", 2, 27)
        frame.content.bottomBg:SetPoint("BOTTOMRIGHT", frame.content, "BOTTOMRIGHT", 0, 0)
        frame.content.bottomBg:SetBackdrop(ALPrivate.BOX_BACKDROP)

        frame.content.itemListBg = CreateFrame("Frame", nil, frame.content, _G.BackdropTemplateMixin and "BackdropTemplate" or nil)
        frame.content.itemListBg:SetPoint("TOPLEFT", frame.content.headerBg, "BOTTOMLEFT", 2, -2)
        frame.content.itemListBg:SetPoint("BOTTOMRIGHT", frame.content.bottomBg, "TOPRIGHT", 0, 2)
        frame.content.itemListBg:SetBackdrop(ALPrivate.BOX_BACKDROP)

        frame.content.listSelect = AtlasLoot.GUI:CreateDropDown()
        frame.content.listSelect:SetParPoint("TOPLEFT", frame.content, "TOPLEFT", 2, -2)
        frame.content.listSelect:SetWidth(frame.content.slotBg:GetWidth()-5)
        frame.content.listSelect:SetTitle("")
        frame.content.listSelect:SetText(AL["Active list"])
        frame.content.listSelect:SetButtonOnClick(GUI_ListDropDownOnSelect)

        frame.content.isGlobal = AtlasLoot.GUI.CreateCheckBox()
        frame.content.isGlobal:SetParPoint("LEFT", frame.content.listSelect.frame, "RIGHT", 5, 0)
        frame.content.isGlobal:SetText(AL["Global lists"])
        frame.content.isGlobal:SetOnClickFunc(GUI_GlobalCheckOnClick)
        frame.content.isGlobal:SetChecked(Favourites:GetDb().activeList[2])

        frame.content.optionsButton = AtlasLoot.GUI.CreateButton()
        frame.content.optionsButton:SetPoint("LEFT", frame.content.isGlobal.frame.text, "RIGHT", 5, 0)
        frame.content.optionsButton:SetText(AL["Settings"])
        frame.content.optionsButton:SetScript("OnClick", ShowOptionsOnClick)

        frame.content.showAllItems = AtlasLoot.GUI.CreateButton()
        frame.content.showAllItems:SetPoint("LEFT", frame.content.bottomBg, "LEFT", 2, 0)
        frame.content.showAllItems:SetText(AL["Show all items"])
        frame.content.showAllItems:SetScript("OnClick", ShowAllItemsOnClick)

        frame.content.editBox = CreateFrame("EditBox", nil, frame.content, "InputBoxTemplate")
        frame.content.editBox:SetWidth(60)
        frame.content.editBox:SetHeight(35)
        frame.content.editBox:SetPoint("RIGHT", frame.content.bottomBg, "RIGHT", -2, 0)
        frame.content.editBox:SetAutoFocus(false)
        frame.content.editBox:SetMaxLetters(6)
        frame.content.editBox:SetNumeric(true)
        frame.content.editBox:SetScript("OnEnterPressed", GUI_EditBoxOnEnterPressed)
        --frame.content.editBox:SetScript("OnTextChanged", GUI_EditBoxOnTextChange)

        frame.content.editBox.text = frame.content.bottomBg:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        frame.content.editBox.text:SetPoint("RIGHT", frame.content.editBox, "LEFT", -7, 0)
        frame.content.editBox.text:SetPoint("LEFT", frame.content.showAllItems, "RIGHT", 2, 0)
        frame.content.editBox.text:SetHeight(20) -- no new lines
        frame.content.editBox.text:SetJustifyH("RIGHT")
        frame.content.editBox.text:SetJustifyV("MIDDLE")
        frame.content.editBox.text:SetText(AL["Add ItemID"])

        frame.content.slotFrame = CreateFrame("Frame", nil, frame.content)
        frame.content.slotFrame:SetPoint("TOPLEFT", frame.content.listSelect.frame, "BOTTOMLEFT", 0, -5)
        frame.content.slotFrame:SetPoint("TOPRIGHT", frame.content.listSelect.frame, "BOTTOMRIGHT", 0, -5)
        frame.content.slotFrame:SetPoint("BOTTOMLEFT", frame.content, "BOTTOMLEFT", 0, 5)

        local scrollFrame = CreateFrame("ScrollFrame", frameName.."-scroll", frame.content)
        scrollFrame:EnableMouse(true)
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetPoint("TOPLEFT", frame.content.itemListBg, "TOPLEFT", 0, 0)
        scrollFrame:SetPoint("BOTTOMRIGHT", frame.content.itemListBg, "BOTTOMRIGHT", 0, 0)
        scrollFrame:SetScript("OnMouseWheel", ItemScroll_OnMouseWheel)
        scrollFrame.contentWidth = scrollFrame:GetWidth() - 22
        scrollFrame.maxItemsPerRow = math.floor(scrollFrame.contentWidth / LIST_ITEM_SIZE)
        scrollFrame.maxItemRows = math.floor(scrollFrame:GetHeight() / LIST_ITEM_SIZE)
        scrollFrame.maxItems = scrollFrame.maxItemsPerRow * scrollFrame.maxItemRows
        scrollFrame.itemGapV = (scrollFrame.contentWidth - ( scrollFrame.maxItemsPerRow * LIST_ITEM_SIZE )) / ( scrollFrame.maxItemsPerRow - 1 )
        scrollFrame.itemGapH = (scrollFrame:GetHeight() - ( scrollFrame.maxItemRows * LIST_ITEM_SIZE )) / ( scrollFrame.maxItemRows - 1 )

        scrollFrame.scrollbar = CreateFrame("Slider", frameName.."-scrollbar", scrollFrame, "UIPanelScrollBarTemplate")
        scrollFrame.scrollbar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -20, -20)
        scrollFrame.scrollbar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 20, 20)
        scrollFrame.scrollbar:SetValueStep(1)
        scrollFrame.scrollbar.scrollStep = 1
        scrollFrame.scrollbar:SetValue(0)
        scrollFrame.scrollbar:SetWidth(16)
        scrollFrame.scrollbar:SetScript("OnValueChanged", ItemScroll_OnValueChanged)
        scrollFrame.scrollbar.obj = scrollFrame

        scrollFrame.scrollbg = scrollFrame:CreateTexture(nil, "BACKGROUND")
        scrollFrame.scrollbg:SetAllPoints(scrollFrame.scrollbar)
        scrollFrame.scrollbg:SetColorTexture(0, 0, 0, 0.5)

        scrollFrame.SetItems = ItemScroll_SetItems
        scrollFrame.itemButtons = {}
        frame.content.scrollFrame = scrollFrame

        Slot_CreateSlotFrame(frame.content.slotFrame)

        self.frame = frame

        frame:Hide()
    end
end

function GUI:UpdateStyle()
    local db = Favourites.db.GUI
    if self.frame then
        local frame = self.frame

        -- main
        frame:SetBackdropColor(db.bgColor.r, db.bgColor.b, db.bgColor.g, db.bgColor.a)
        frame:SetScale(db.scale)

        -- title
        frame.titleFrame:SetBackdropColor(db.title.bgColor.r, db.title.bgColor.g, db.title.bgColor.b, db.title.bgColor.a)
        frame.titleFrame:SetFont(LibSharedMedia:Fetch("font", db.title.font), db.title.size)
        frame.titleFrame.text:SetTextColor(db.title.textColor.r, db.title.textColor.g, db.title.textColor.b, db.title.textColor.a)

        -- content
        frame.content.slotBg:SetBackdropColor(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
        frame.content.headerBg:SetBackdropColor(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
        frame.content.itemListBg:SetBackdropColor(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
        frame.content.bottomBg:SetBackdropColor(db.content.bgColor.r, db.content.bgColor.g, db.content.bgColor.b, db.content.bgColor.a)
    end
end

function GUI:ItemListUpdate()
    if self.frame and self.frame:IsShown() then
        self.frame.content.slotFrame:UpdateSlots()
    end
end

function GUI:SelectSlot(slotID)
    if not self.frame then return end
    if slotID and self.frame.content.slotFrame.slots[slotID] then
        GUI.selectedSlot = slotID
    else
        GUI.selectedSlot = nil
    end
    ShowItemList(slotID)
end