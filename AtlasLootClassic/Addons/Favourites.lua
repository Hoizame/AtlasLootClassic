local ALName, ALPrivate = ...

local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local Addons = AtlasLoot.Addons
local AL = AtlasLoot.Locales
local ItemDB = AtlasLoot.ItemDB
local Favourites = Addons:RegisterNewAddon("Favourites")
local Tooltip = AtlasLoot.Tooltip
local Comm = LibStub:GetLibrary("AceComm-3.0")

-- lua
local type = _G.type
local next, pairs, tblconcat, tblsort = _G.next, _G.pairs, _G.table.concat, _G.table.sort
local format, strsub, strmatch, strgmatch, strsplit = _G.format, _G.strsub, _G.strmatch, _G.gmatch, _G.strsplit

-- WoW
local GetItemInfo = _G.GetItemInfo
local GetServerTime = _G.GetServerTime
local GetItemInfoInstant = _G.GetItemInfoInstant
local RETRIEVING_ITEM_INFO = _G["RETRIEVING_ITEM_INFO"]
local ItemExist = _G.C_Item.DoesItemExistByID

-- locals
local ICONS_PATH = ALPrivate.ICONS_PATH
local BASE_NAME_P, BASE_NAME_G, LIST_BASE_NAME = "ProfileBase", "GlobalBase", "List"
local NEW_LIST_ID_PATTERN = "%s%s"
local TEXT_WITH_TEXTURE = "|T%s:0|t %s"
local ATLAS_ICON_IDENTIFIER = "#"
local IMPORT_EXPORT_DELIMITER, IMPORT_PATTERN, EXPORT_PATTERN = ",", "(%w+):(%d+)(:?([^,]*))", "%s:%d:%s"
local STD_ICON, STD_ICON2
local KEY_WEAK_MT = {__mode="k"}

local ChatLinkPending = false
local ChatLinkData = false
local TooltipsHooked = false
local TooltipCache, TooltipTextCache = {}
local ListNameCache
local ListNoteCache
local ListBiSCache
local ItemCountCache
local PluginOutfitterLoading
setmetatable(TooltipCache, KEY_WEAK_MT)

Favourites.BASE_NAME_P, Favourites.BASE_NAME_G = BASE_NAME_P, BASE_NAME_G


-- Addon
Favourites.DbDefaults = {
    enabled = true,
    showIconInTT = false,
    showListInTT = true,
    activeList = { BASE_NAME_P, false }, -- name, isGlobal
    activeSubLists = {},
    lists = {
        [BASE_NAME_P] = {
            __name = AL["Profile base list"],
        },
    },
    GUI = {
        bgColor = {r = 0.45, g = 0.45, b = 0.45, a = 1},
        scale = 1,
        title = {
            bgColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
            textColor = {r = 1, g = 1, b = 1, a = 1},
            size = 12,
            font = "Friz Quadrata TT",
        },
        content = {
            bgColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
        },
    },
}

Favourites.GlobalDbDefaults = {
    activeSubLists = {},
    lists = {
        [BASE_NAME_G] = {
            __name = AL["Global base list"],
        },
    },
}

Favourites.PlaceHolderIcon = ICONS_PATH.."placeholder-icon"
Favourites.IconList = {
    ICONS_PATH.."VignetteKill",
    ICONS_PATH.."Gear",
    ICONS_PATH.."groupfinder-icon-class-druid",
    ICONS_PATH.."groupfinder-icon-class-hunter",
    ICONS_PATH.."groupfinder-icon-class-mage",
    ICONS_PATH.."groupfinder-icon-class-paladin",
    ICONS_PATH.."groupfinder-icon-class-priest",
    ICONS_PATH.."groupfinder-icon-class-rogue",
    ICONS_PATH.."groupfinder-icon-class-shaman",
    ICONS_PATH.."groupfinder-icon-class-warlock",
    ICONS_PATH.."groupfinder-icon-class-warrior",
    ICONS_PATH.."groupfinder-icon-role-large-dps",
    ICONS_PATH.."groupfinder-icon-role-large-heal",
    ICONS_PATH.."groupfinder-icon-role-large-tank",
    ICONS_PATH.."Vehicle-HammerGold",
    ICONS_PATH.."Vehicle-HammerGold-1",
    ICONS_PATH.."Vehicle-HammerGold-2",
    ICONS_PATH.."Vehicle-HammerGold-3",
    ICONS_PATH.."Vehicle-TempleofKotmogu-CyanBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-GreenBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-OrangeBall",
    ICONS_PATH.."Vehicle-TempleofKotmogu-PurpleBall",
    ICONS_PATH.."worldquest-tracker-questmarker",
}
STD_ICON, STD_ICON2 = Favourites.IconList[1], Favourites.IconList[2]

local EXTRA_ICONS = {
    "Interface\\Icons\\spell_deathknight_classicon", -- Death knight classIcon iconId = 135771;
    "Interface\\Icons\\spell_deathknight_bloodpresence", -- Death knight Blood tank iconId = 135770;
    "Interface\\Icons\\spell_deathknight_frostpresence", -- Death knight Frost iconId = 135773;
    "Interface\\Icons\\spell_deathknight_unholypresence", -- Death knight Unholy iconId = 135775;
    "Interface\\Icons\\classicon_druid", -- Druid classIcon iconId = 625999;
    "Interface\\Icons\\spell_nature_starfall", -- Druid Balance iconId = 136096;
    "Interface\\Icons\\ability_racial_bearform", -- Druid Feral tank iconId = 132276;
    "Interface\\Icons\\ability_druid_catform", -- Druid Feral dps iconId = 132115;
    "Interface\\Icons\\spell_nature_healingtouch", -- Druid Restoration iconId = 136041;
    "Interface\\Icons\\classicon_hunter", -- Hunter classIcon iconId = 626000;
    "Interface\\Icons\\ability_hunter_beasttaming", -- Hunter Beast mastery iconId = 132164;
    "Interface\\Icons\\ability_marksmanship", -- Hunter Marksmanship iconId = 132222;
    "Interface\\Icons\\ability_hunter_swiftstrike", -- Hunter Survival iconId = 132215;
    "Interface\\Icons\\classicon_mage", -- Mage classIcon iconId = 626001;
    "Interface\\Icons\\spell_holy_magicalsentry", -- Mage Arcane iconId = 135932;
    "Interface\\Icons\\spell_fire_firebolt02", -- Mage Fire iconId = 135810;
    "Interface\\Icons\\ability_mage_frostfirebolt", -- Mage Fire FFB iconId = 236217;
    "Interface\\Icons\\spell_frost_frostbolt02", -- Mage Frost iconId = 135846;
    "Interface\\Icons\\classicon_paladin", -- Paladin classIcon iconId = 626003;
    "Interface\\Icons\\spell_holy_holybolt", -- Paladin Holy iconId = 135920;
    "Interface\\Icons\\spell_holy_devotionaura", -- Paladin Protection iconId = 135893;
    "Interface\\Icons\\spell_holy_auraoflight", -- Paladin Retribution iconId = 135873;
    "Interface\\Icons\\classicon_priest", -- Priest classIcon iconId = 626004;
    "Interface\\Icons\\spell_holy_wordfortitude", -- Priest Discipline iconId = 135987;
    "Interface\\Icons\\spell_holy_renew", -- Priest Holy iconId = 135953;
    "Interface\\Icons\\spell_shadow_shadowwordpain", -- Priest Shadow iconId = 136207;
    "Interface\\Icons\\classicon_rogue", -- Rogue classIcon iconId = 626005;
    "Interface\\Icons\\ability_rogue_eviscerate", -- Rogue Assassination iconId = 132292;
    "Interface\\Icons\\ability_backstab", -- Rogue Combat iconId = 132090;
    "Interface\\Icons\\ability_stealth", -- Rogue Subtlety iconId = 132320;
    "Interface\\Icons\\classicon_shaman", -- Shaman classIcon iconId = 626006;
    "Interface\\Icons\\spell_nature_lightning", -- Shaman Elemental iconId = 136048;
    "Interface\\Icons\\spell_nature_lightningshield", -- Shaman Enhancement iconId = 136051;
    "Interface\\Icons\\spell_nature_magicimmunity", -- Shaman Restoration iconId = 136052;
    "Interface\\Icons\\classicon_warlock", -- Warlock classIcon iconId = 626007;
    "Interface\\Icons\\spell_shadow_deathcoil", -- Warlock Affliction iconId = 136145;
    "Interface\\Icons\\spell_shadow_metamorphosis", -- Warlock Demonology iconId = 136172;
    "Interface\\Icons\\spell_shadow_rainoffire", -- Warlock Destruction iconId = 136186;
    "Interface\\Icons\\spell_shadow_rainoffire", -- Warlock Destruction fire iconId = 136186;
    "Interface\\Icons\\classicon_warrior", -- Warrior classIcon iconId = 626008;
    "Interface\\Icons\\ability_rogue_eviscerate", -- Warrior Arms iconId = 132292;
    "Interface\\Icons\\ability_warrior_innerrage", -- Warrior Fury iconId = 132347;
    "Interface\\Icons\\inv_shield_06", -- Warrior Protection iconId = 134952;
}

-- Add an extra icons to IconList
for _, path in ipairs(EXTRA_ICONS) do
    table.insert(Favourites.IconList, path)
end

local function AddItemsInfoFavouritesSub(items, activeSub, isGlobal)
    if items and activeSub then
        local fav = Favourites.subItems
        for itemID in pairs(items) do
            if fav[itemID] then
                fav[itemID][#fav[itemID] + 1] = { activeSub, isGlobal }
            else
                fav[itemID] = {
                    { activeSub, isGlobal }
                }
            end
        end
    end
end

local function CheckSubSetDb(list, db, globalDb)
    if list then
        for activeSub, isGlobal in pairs(list) do
            if activeSub ~= Favourites.db.activeList[1] then
                if isGlobal and globalDb[activeSub] then
                    AddItemsInfoFavouritesSub(globalDb[activeSub] or db[activeSub], activeSub, isGlobal)
                elseif not isGlobal and db[activeSub] then
                    AddItemsInfoFavouritesSub(db[activeSub], activeSub, isGlobal)
                end
            end
        end
    end
end

local function PopulateSubLists(db, globalDb)
    local subDb, globalSubDb = db.activeSubLists, globalDb.activeSubLists
    db, globalDb = db.lists, globalDb.lists

    CheckSubSetDb(subDb, db, globalDb)
    CheckSubSetDb(globalSubDb, db, globalDb)
end

local function PopulateListNames(db, dest)
    for k,v in pairs(db) do
        dest[k] = format(TEXT_WITH_TEXTURE, tostring(v.__icon or STD_ICON), v.__name or LIST_BASE_NAME)
    end
end

local function PopulateListBiS(db, dest)
    local itemsEquipped = {}
    -- Equipped items
    for invSlot = 1, 19 do
        local equipItemId = GetInventoryItemID("player", invSlot);
        if equipItemId then
            itemsEquipped[equipItemId] = true
        end
    end
    -- Items contained within wow equipment sets
    local itemSetIds = C_EquipmentSet.GetEquipmentSetIDs()
    for itemSetIndex, itemSetId in ipairs(itemSetIds) do
        local itemSetItems = C_EquipmentSet.GetItemIDs(itemSetId)
        for invSlot = 1, 19 do
            local equipItemId = itemSetItems[invSlot]
            if equipItemId then
                itemsEquipped[equipItemId] = true
            end
        end
    end
    -- Outfitter sets
    local _, pluginOutfitter = GetAddOnInfo("Outfitter")
    if pluginOutfitter then
        if Outfitter and Outfitter.Settings and Outfitter.Settings.Outfits then
            -- Check outfitter equip sets
            local outfits = Outfitter.Settings.Outfits
            for outfitType, outfitList in pairs(outfits) do
                for outfitIndex, outfitData in ipairs(outfitList) do
                    local outfitItems = outfitData:GetItems()
                    for outfitterSlot, outfitterItem in pairs(outfitItems) do
                        if outfitterItem.Code then
                            itemsEquipped[outfitterItem.Code] = true
                        end
                    end
                end
            end
        else
            -- Outfitter not (yet) loaded, add callback to populate database again once Outfitter was loaded
            -- TODO: Find a better way to access outfitter data when ready
            if not PluginOutfitterLoading then
                PluginOutfitterLoading = true
            end
        end
    end
    for listId, listData in pairs(db) do
        if not dest[listId] then
            dest[listId] = {
                byId = {}, bySlot = {}, bestInSlot = {}, obsolete = {}, equipped = {}
            }
        end
        local destList = dest[listId]
        for itemId in pairs(listData) do
            if type(itemId) == "number" then
                local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
                    itemSubType, itemStackCount, itemEquipLoc = GetItemInfo(itemId)
                local itemData = { itemId, itemLink, itemLevel, 0, itemType, itemSubType }
                destList.byId[itemId] = itemData
                if itemEquipLoc and itemLevel then
                    if not destList.bySlot[itemEquipLoc] then
                        destList.bySlot[itemEquipLoc] = {}
                    end
                    if not tContains(destList.bySlot[itemEquipLoc], itemId) then
                        tinsert(destList.bySlot[itemEquipLoc], itemId)
                    end
                    if itemsEquipped[itemId] then
                        destList.equipped[itemId] = true
                        if destList.bestInSlot[itemEquipLoc] then
                            local curId, curLink, curLevel, prevLevel, curType, curSubType = unpack(destList.bestInSlot[itemEquipLoc])
                            if (curLevel < itemLevel) then
                                itemData[4] = curLevel
                                destList.bestInSlot[itemEquipLoc] = itemData
                            elseif (itemId ~= curId) then
                                destList.bestInSlot[itemEquipLoc][4] = max(prevLevel, itemLevel)
                            end
                        else
                            destList.bestInSlot[itemEquipLoc] = itemData
                        end
                    end
                end
            end
        end
        local mainItems = {}
        if listData.mainItems then
            for invSlot, itemId in pairs(listData.mainItems) do
                mainItems[itemId] = true
            end
        end
        -- Gather obsolete items
        for itemEquipLoc, itemIds in pairs(destList.bySlot) do
            for _, itemId in ipairs(itemIds) do
                if destList.bestInSlot[itemEquipLoc] then
                    local bestId, bestLink, bestLevel, secondBestLevel, bestType, bestSubType = unpack(destList.bestInSlot[itemEquipLoc])
                    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
                        itemSubType, itemStackCount, itemEquipLoc = GetItemInfo(itemId)
                    if (bestLevel > itemLevel) and not mainItems[itemId] then
                        destList.obsolete[itemId] = true
                    end
                end
            end
        end
    end
end

local function PopulateListNotes(db, dest)
    for k,v in pairs(db) do
        if v.notes then
            local cleanup = false
            for item, note in pairs(v.notes) do
                if (type(item) == "string") or not v[item] then
                    cleanup = true
                end
                dest[k.."-"..item] = "  "..format(TEXT_WITH_TEXTURE, "Interface/FriendsFrame/UI-FriendsFrame-Note:8:8:0:0:8:8", "|cffB0B0B0"..note.."|r")
            end
            if cleanup then
                -- Fix string item ids in db
                local notesFixed = {}
                for item, note in pairs(v.notes) do
                    if v[tonumber(item)] then
                        notesFixed[tonumber(item)] = note
                    end
                end
                v.notes = notesFixed
            end
        end
    end
end

local function GetActiveList(self)
    local name, isGlobal = self.db.activeList[1], ( self.db.activeList[2] == true )
    local db = isGlobal and self:GetGlobaleLists() or self:GetProfileLists()
    if db[name] then
        return db[name]
    else
        self.db.activeList[1] = db[BASE_NAME_P]
        return db[BASE_NAME_P]
    end
end

local function ClearActiveList(self)
    local name, isGlobal = self.db.activeList[1], ( self.db.activeList[2] == true )
    local db = isGlobal and self:GetGlobaleLists() or self:GetProfileLists()
    local new = {}

    for k,v in pairs(self.activeList) do
        if type(k) ~= "number" and k ~= "mainItems" then
            new[k] = v
        end
    end

    if db[name] then
        db[name] = new
    else
        db[BASE_NAME_P] = new
    end
    self:ClearCountCache()
end

local function CleanUpShownLists(db, globalDb, activeSubLists, isGlobalList)
    local new = {}
    db, globalDb = db.lists, globalDb.lists

    for listID, isGlobal in pairs(activeSubLists) do
        if ( isGlobal and globalDb[listID] ) then
            new[listID] = isGlobal
        elseif not isGlobal and not isGlobalList and db[listID] then
            new[listID] = isGlobal
        end
    end

    return new
end

local function OnTooltipSetItem_Hook(self)
    if self:IsForbidden() or not Favourites.db.enabled or (not Favourites.db.showIconInTT and not Favourites.db.showListInTT) then return end
    local _, item = self:GetItem()
    if not item then return end
    if not TooltipCache[item] then
        TooltipCache[item] = tonumber(strmatch(item, "item:(%d+)"))
    end

    item = TooltipCache[item]
    if Favourites:IsFavouriteItemID(item) then
        if Favourites.db.showIconInTT then
            local text = _G[self:GetName().."TextLeft1"]
            if not TooltipTextCache[item] and text:GetText() ~= RETRIEVING_ITEM_INFO then
                TooltipTextCache[item] = format(TEXT_WITH_TEXTURE, Favourites:GetIconForActiveItemID(item), text:GetText())
            end
            text:SetText( TooltipTextCache[item] or RETRIEVING_ITEM_INFO )
        end

        -- Add Listnames
        if Favourites.db.showListInTT then
            self:AddLine(" ")
            if Favourites.activeList[item] then
                self:AddLine(Favourites:GetFavouriteItemText(item, Favourites.activeListID))
            end
            if Favourites.subItems[item] then
                for i = 1, #Favourites.subItems[item] do
                    local entry = Favourites.subItems[item][i]
                    if entry[1] ~= Favourites.activeListID then
                        self:AddLine(Favourites:GetFavouriteItemText(item, entry[1]))
                    end
                end
            end
        end
    end
end

local function InitTooltips()
    if TooltipsHooked then return end
    Tooltip:AddHookFunction("OnTooltipSetItem", OnTooltipSetItem_Hook)
    TooltipsHooked = true
end

local function SlashCommand()
    Favourites.GUI:Toggle()
end
AtlasLoot.SlashCommands:Add("fav", SlashCommand, "/al fav - "..AL["Open Favourites"])

local function ChatFilterFunc(_, event, msg, player, l, cs, t, flag, channelId, ...)
    if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
        return
    end
    local newMsg = "";
    local remaining = msg;
    local done;
    repeat
        local start, finish, characterName, displayName = remaining:find("%[AtlasLootClassic: ([^%s]+) %- (.*)%]");
        if (characterName and displayName) then
            characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
            displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
            newMsg = newMsg .. remaining:sub(1, start - 1);
            newMsg = newMsg .. "|Hgarrmission:atlaslootclassic_fav|h|cFF8800FF[" .. characterName .. " |r|cFF8800FF- " .. displayName .. "]|h|r";
            remaining = remaining:sub(finish + 1);
        else
            done = true;
        end
    until (done)
    if newMsg ~= "" then
        local trimmedPlayer = Ambiguate(player, "none")
        if event == "CHAT_MSG_WHISPER" and not UnitInRaid(trimmedPlayer) and not UnitInParty(trimmedPlayer) then -- XXX: Need a guild check
            local _, num = BNGetNumFriends()
            for i = 1, num do
                if C_BattleNet then -- introduced in 8.2.5 PTR
                    local toon = C_BattleNet.GetFriendNumGameAccounts(i)
                    for j = 1, toon do
                        local gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(i, j);
                        if gameAccountInfo.characterName == trimmedPlayer and gameAccountInfo.clientProgram == "WoW" then
                            return false, newMsg, player, l, cs, t, flag, channelId, ...; -- Player is a real id friend, allow it
                        end
                    end
                else -- keep old method for 8.2 and Classic
                    local toon = BNGetNumFriendGameAccounts(i)
                    for j = 1, toon do
                        local _, rName, rGame = BNGetFriendGameAccountInfo(i, j)
                        if rName == trimmedPlayer and rGame == "WoW" then
                            return false, newMsg, player, l, cs, t, flag, channelId, ...; -- Player is a real id friend, allow it
                        end
                    end
                end
            end
            return true -- Filter strangers
        else
            return false, newMsg, player, l, cs, t, flag, channelId, ...;
        end
    end
end

local function ShowTooltip(lines)
    ItemRefTooltip:Show();
    if not ItemRefTooltip:IsVisible() then
        ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
    end
    ItemRefTooltip:ClearLines();
    for i, line in ipairs(lines) do
        local sides, a1, a2, a3, a4, a5, a6, a7, a8 = unpack(line);
        if (sides == 1) then
            ItemRefTooltip:AddLine(a1, a2, a3, a4, a5);
        elseif (sides == 2) then
            ItemRefTooltip:AddDoubleLine(a1, a2, a3, a4, a5, a6, a7, a8);
        end
    end
    ItemRefTooltip:Show()
end

function Favourites:UpdateDb()
    self.db = self:GetDb()
    self.globalDb = self:GetGlobalDb()
    self.activeList = GetActiveList(self)
    self.activeListID = self.db.activeList[1]
    TooltipTextCache = {}
    setmetatable(TooltipTextCache, KEY_WEAK_MT)

    -- populate sublists
    self.subItems = {}
    PopulateSubLists(self.db, self.globalDb)

    -- init item count
    local numItems = 0
    for k in pairs(self.activeList) do
        if type(k) == "number" then
            numItems = numItems + 1
        end
    end
    self.numItems = numItems

    -- name / icon mix
    ListNameCache = {
        active = format(TEXT_WITH_TEXTURE, tostring(self.activeList.__icon or STD_ICON), self.activeList.__name or LIST_BASE_NAME),
        global = {},
        profile = {},
    }
    PopulateListNames(self.db.lists, ListNameCache.profile)
    PopulateListNames(self.globalDb.lists, ListNameCache.global)

    ListNoteCache = {}
    PopulateListNotes(self.db.lists, ListNoteCache)
    PopulateListNotes(self.globalDb.lists, ListNoteCache)

    ListBiSCache = {}
    PopulateListBiS(self.db.lists, ListBiSCache)
    PopulateListBiS(self.globalDb.lists, ListBiSCache)

    -- tooltip hook
    if self:TooltipHookEnabled() and not TooltipsHooked then
        InitTooltips()
    end
    self.GUI:ItemListUpdate()

    -- number of favourite items by dungeon/boss/...
    ItemCountCache = {}
end

function Favourites.OnInitialize()
    Favourites:UpdateDb()
    Favourites.GUI.OnInitialize()
    -- Import via chat link
    hooksecurefunc("SetItemRef", function(link, text)
        if (link == "garrmission:atlaslootclassic_fav") then
            local _, _, characterName, displayName = text:find("|Hgarrmission:atlaslootclassic_fav|h|cFF8800FF%[([^%s]+) |r|cFF8800FF%- (.*)%]|h");
            if (characterName and displayName) then
                characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
                displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
                if (IsShiftKeyDown()) then
                    local editbox = GetCurrentKeyBoardFocus();
                    if (editbox) then
                        editbox:Insert("[AtlasLootClassic: " .. characterName .. " - " .. displayName .. "]");
                    end
                else
                    characterName = characterName:gsub("%.", "")
                    Favourites:RequestList(characterName, displayName)
                end
            else
                ShowTooltip({
                    { 1, "AtlasLootClassic", 0.5, 0, 1 },
                    { 1, AL["Malformed link"], 1, 0, 0 }
                });
            end
        end
    end)
    Comm:RegisterComm("AtlasLootClassic", function(prefix, text, channel, sender)
        -- Comm received
        local cmd, params = strsplit(":", text, 2)
        if (cmd == "requestList") then
            -- Player requested to receive a list
            local listName = params
            Favourites:SendList(sender, listName)
            return
        end
        if (cmd == "sendList") and ChatLinkPending then
            -- List received from a player
            if not strfind(sender, "-") then
                sender = sender.."-"..GetRealmName()
            end
            local listName, listData = strsplit(":", params, 2)
            local listIdent = sender..":"..listName
            if ChatLinkPending ~= listIdent then
                print(AL["Received unexpected favourite list '%s' (expected '%s')"]:format(listIdent, ChatLinkPending))
            else
                ChatLinkData = listData;
                ShowTooltip({
                    { 2, "AtlasLootClassic", listName, 0.5, 0, 1, 1, 1, 1 },
                    { 1, AL["List received. Click link again to import!"], 1, 0.82, 0 }
                });
            end
            return
        end
    end)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChatFilterFunc)
end

function Favourites:OnProfileChanged()
    self:UpdateDb()
    self.GUI:OnProfileChanged()
end

function Favourites:OnStatusChanged()
    self:UpdateDb()
    self.GUI:OnStatusChanged()
end

function Favourites:OnItemsChanged()
    self:ClearCountCache()
    -- TODO Update counts for subcategories/difficulties/bosses/extras
end

function Favourites:InsertChatLink()
    local editbox = GetCurrentKeyBoardFocus();
    if editbox and self.activeList then
        local characterName = UnitName("player").."-"..GetRealmName()
        local displayName = self.activeList.__name
        editbox:Insert("[AtlasLootClassic: "..characterName.." - "..displayName.."]");
    end
end

function Favourites:RequestList(characterName, listName)
    local listIdent = characterName..":"..listName
    if (ChatLinkPending == listIdent) and ChatLinkData then
        local listId = self:AddNewList()
        if listId then
            self.db.lists[listId].__name = listName
            self:ImportItemList(listId, false, ChatLinkData)
            self:UpdateDb()
            ChatLinkPending = false
            ChatLinkData = false
            ShowTooltip({
                { 2, "AtlasLootClassic", listName, 0.5, 0, 1, 1, 1, 1 },
                { 1, AL["Import done!"], 1, 0.82, 0 }
            });
        end
    else
        ChatLinkPending = listIdent
        ChatLinkData = false
        Comm:SendCommMessage("AtlasLootClassic", "requestList:"..listName, "WHISPER", characterName)
        ShowTooltip({
            { 2, "AtlasLootClassic", listName, 0.5, 0, 1, 1, 1, 1 },
            { 1, AL["Requesting favorite list from %s ..."]:format(characterName), 1, 0.82, 0 }
        });
    end
end

function Favourites:SendListData(characterName, listName, listId, listIsGlobal)
    local listContent = self:ExportItemList(listId, listIsGlobal)
    Comm:SendCommMessage("AtlasLootClassic", "sendList:"..listName..":"..listContent, "WHISPER", characterName)
end

function Favourites:SendList(characterName, listNameTarget)
    for l, listData in pairs(self.db.lists) do
        if (listData.__name == listNameTarget) then
            return self:SendListData(characterName, listNameTarget, l, false);
        end
    end
    for l, listData in pairs(self.globalDb.lists) do
        if (listData.__name == listNameTarget) then
            return self:SendListData(characterName, listNameTarget, l, true);
        end
    end
end

function Favourites:AddItemID(itemID)
    if itemID and ItemExist(itemID) and not self.activeList[itemID] then
        self.numItems = self.numItems + 1
        self.activeList[itemID] = true
        TooltipTextCache[itemID] = nil
        self:OnStatusChanged()
        self:OnItemsChanged()
        return true
    end
    return false
end

function Favourites:RemoveItemID(itemID)
    if itemID and self.activeList[itemID] then
        self.numItems = self.numItems - 1
        self.activeList[itemID] = nil
        TooltipTextCache[itemID] = nil
        self:CleanUpMainItems()
        self:OnItemsChanged()
        return true
    end
    return false
end

function Favourites:GetItemNote(itemID, list)
    if not list then
        return self:GetItemNote(itemID, self.activeList)
    end
    if not list.notes then
        return nil
    end
    return list.notes[tonumber(itemID)]
end

function Favourites:SetItemNote(itemID, note, list, listID)
    if not list then
        return self:SetItemNote(itemID, note, self.activeList, self.activeListID)
    end
    if not list.notes then
        list.notes = {}
    end

    --Remove note if its an empty string
    if note == "" then
        note = nil
    end

    list.notes[tonumber(itemID)] = note
    -- Refresh cache
    ListNoteCache = {}
    PopulateListNotes(self.db.lists, ListNoteCache)
    PopulateListNotes(self.globalDb.lists, ListNoteCache)
end

function Favourites:GetActiveList()
    return self.activeList
end

function Favourites:ClearList()
    if self.db and self.activeList then
        ClearActiveList(self)
        self:UpdateDb()
        return true
    end
    return false
end

function Favourites:GetNumItemsInList()
    return self.numItems or 0
end

function Favourites:CountCacheIdent(addonName, contentName, boss, dif, includeObsolete)
    local cacheIdent = addonName
    if includeObsolete then
        cacheIdent = cacheIdent.."_FULL"
    end
    if contentName ~= nil then
        cacheIdent = cacheIdent.."__"..contentName
    else
        cacheIdent = cacheIdent.."__nil"
    end
    if boss ~= nil then
        cacheIdent = cacheIdent.."__"..boss
    else
        cacheIdent = cacheIdent.."__nil"
    end
    if dif ~= nil then
        cacheIdent = cacheIdent.."__"..dif
    else
        cacheIdent = cacheIdent.."__nil"
    end
    return cacheIdent
end

function Favourites:CountFavouritesOverall(addonName, contentName, boss, dif, includeObsolete)
    local cacheIdent = self:CountCacheIdent(addonName, contentName, boss, dif, includeObsolete)
    local result = ItemCountCache[cacheIdent]
    if result == nil then
        -- No valid cache, calculate item count!
        result = 0
        -- TODO
    end
    return result
end

function Favourites:CountFavouritesByList(addonName, contentName, boss, dif, includeObsolete)
    local cacheIdent = self:CountCacheIdent(addonName, contentName, boss, dif, includeObsolete)
    if ItemCountCache[cacheIdent] then
        return ItemCountCache[cacheIdent]
    end
    -- No valid cache, calculate item count!
    local result = {}
    -- TODO
    local moduleItems = {}
    if contentName == nil then
        -- Get count per content section (e.g. dungeon/profession)
        local moduleList = AtlasLoot.ItemDB:GetModuleList(addonName)
        for i = 1, #moduleList do
            contentName = moduleList[i]
            local subResult = self:CountFavouritesByList(addonName, contentName, boss, dif, includeObsolete)
            for listName, itemCount in pairs(subResult) do
                result[listName] = (result[listName] or 0) + itemCount
            end
        end
        ItemCountCache[cacheIdent] = result
        return result
    end
    if boss == nil then
        -- Get count per content sub-section (e.g. boss/...)
        local moduleData = AtlasLoot.ItemDB:Get(addonName)
        local contentData = moduleData[contentName]
        if contentData == nil then
            return result
        end
        for i = 1, #contentData.items do
            local subResult = self:CountFavouritesByList(addonName, contentName, i, dif, includeObsolete)
            for listName, itemCount in pairs(subResult) do
                result[listName] = (result[listName] or 0) + itemCount
            end
        end
        ItemCountCache[cacheIdent] = result
        return result
    end
    if dif == nil then
        -- Get count per content difficulty (e.g. boss/...)
        local moduleData = AtlasLoot.ItemDB:Get(addonName)
        local contentData = moduleData[contentName]
        if contentData.items[boss] then
            for i in pairs(contentData.items[boss]) do
                if type(i) == "number" then
                    local subResult = self:CountFavouritesByList(addonName, contentName, boss, i, includeObsolete)
                    for listName, itemCount in pairs(subResult) do
                        result[listName] = (result[listName] or 0) + itemCount
                    end
                end
            end
        end
        ItemCountCache[cacheIdent] = result
        return result
    end

    -- Get count for all matching items
    local items, tableType, diffData = ItemDB:GetItemTable(addonName, contentName, boss, dif)
    -- Check if items is nil or empty
    if not items or next(items) == nil then
        return
    end
    for l, listData in pairs(self.db.lists) do
        local listName = listData.__name
        for i, item in ipairs(items) do
            if type(item[2]) == "number" then
                local itemID = item[2]
                if listData[itemID] and (includeObsolete or not self:IsItemEquippedOrObsolete(itemID, l)) then
                    result[listName] = (result[listName] or 0) + 1
                end
            end
        end
    end

    for l, listData in pairs(self.globalDb.lists) do
        local listName = listData.__name
        for i, item in ipairs(items) do
            if type(item[2]) == "number" then
                local itemID = item[2]
                if listData[itemID] and (includeObsolete or not self:IsItemEquippedOrObsolete(itemID, l)) then
                    result[listName] = (result[listName] or 0) + 1
                end
            end
        end
    end

    ItemCountCache[cacheIdent] = result
    return result
end

function Favourites:GetFavouriteCountText(itemCount, withoutIcon)
    if itemCount > 0 then
        if withoutIcon then
            return " |cffffff80*"..tostring(itemCount).."|r"
        else
            return " |cffffff80"..format(TEXT_WITH_TEXTURE, tostring(STD_ICON), tostring(itemCount)).."|r"
        end
    else
        return ""
    end
end

function Favourites:GetFavouriteListText(listName, itemCount)
    return listName..": "..itemCount
end

function Favourites:GetFavouriteItemText(itemId, listId)
    local listData = self.db.lists[listId] or self.globalDb.lists[listId]
    local obsolete = self:IsItemEquippedOrObsolete(itemId, listId)
    local text = ""
    if obsolete then
        text = format(TEXT_WITH_TEXTURE, tostring(listData.__icon or STD_ICON), "|cffB0B0B0"..(listData.__name or LIST_BASE_NAME).."|r")
    else
        text = format(TEXT_WITH_TEXTURE, tostring(listData.__icon or STD_ICON), (listData.__name or LIST_BASE_NAME))
    end
    if ListNoteCache[listId.."-"..itemId] then
        text = text..ListNoteCache[listId.."-"..itemId]
        if obsolete == "equipped" then
            text = text.." |cffB0B0B0"..AL["(owned)"].."|r"
        elseif obsolete == "obsolete" then
            text = text.." |cffB0B0B0"..AL["(obsolete)"].."|r"
        end
    end
    return text
end

function Favourites:IsItemEquippedOrObsolete(itemId, listId)
    if PluginOutfitterLoading then
        PluginOutfitterLoading = false
        self:UpdateDb()
    end
    if not listId then
        for listId, listData in pairs(self.db.lists) do
            local obsoleteType = self:IsItemEquippedOrObsolete(itemId, listId)
            if obsoleteType then
                return obsoleteType
            end
        end
        return false
    end
    if ListBiSCache[listId] then
        if ListBiSCache[listId].equipped[tonumber(itemId)] then
            return "equipped"
        end
        if ListBiSCache[listId].obsolete[tonumber(itemId)] then
            return "obsolete"
        end
    end
    return false
end

function Favourites:IsFavouriteItemID(itemID, onlyActiveList)
    if onlyActiveList then
        return self.activeList[itemID]
    else
        return self.activeList[itemID] or self.subItems[itemID]
    end
end

function Favourites:SetFavouriteIcon(itemID, texture, hideOnFail)
    if not texture then return end
    local listName = self:IsFavouriteItemID(itemID)
    if not listName then return hideOnFail and texture:Hide() or nil end
    local icon = Favourites:GetIconForActiveItemID(itemID)

    if icon then
        if type(icon) == "number" then
            texture:SetTexture(icon)
        elseif type(icon) == "string" then
            if strsub(icon, 1, 1) == ATLAS_ICON_IDENTIFIER then
                if icon and icon ~= texture:GetAtlas() then
                    texture:SetAtlas(strsub(icon, 2))
                end
            else
                texture:SetTexture(icon)
            end
        end
    end
end

function Favourites:GetIconForActiveItemID(itemID)
    local listName = self:IsFavouriteItemID(itemID)
    local icon

    if listName == true then
        icon = self.activeList.__icon or STD_ICON
    elseif #listName > 1 then
        icon = STD_ICON
    elseif listName[1][2] == true then
        icon = self.globalDb.lists[ listName[1][1] ].__icon or STD_ICON2
    elseif listName[1][2] == false then
        icon = self.db.lists[ listName[1][1] ].__icon or STD_ICON2
    elseif listName[1][2] then
        icon = listName[1][2]
    end

    return icon
end

local function SortedListFunc(a,b)
    return a.name:lower() < b.name:lower()
end

local function GetSortedList(list, isGlobal)
    local new = {}
    for k,v in pairs(list) do
        new[#new+1] = {
            id = k,
            name = Favourites:GetListName(k, isGlobal, false),
            nameIcon = Favourites:GetListName(k, isGlobal, true),
        }
    end
    tblsort(new, SortedListFunc)
    return new
end

function Favourites:GetProfileLists(sorted)
    if sorted then
        return GetSortedList(self.db.lists, false)
    else
        return self.db.lists
    end
end

function Favourites:GetGlobaleLists(sorted)
    if sorted then
        return GetSortedList(self.globalDb.lists, true)
    else
        return self.globalDb.lists
    end
end

function Favourites:GetListByID(listID, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    return list[listID]
end

function Favourites:GetListName(id, isGlobal, withIcon)
    --ListNameCache[isGlobal and "global" or "profile"]
    if withIcon then
        return ListNameCache[isGlobal and "global" or "profile"][id]
    else
        if isGlobal and self:GetGlobaleLists()[id] then
            return self:GetGlobaleLists()[id].__name or LIST_BASE_NAME
        elseif not isGlobal and self:GetProfileLists()[id] then
            return self:GetProfileLists()[id].__name or LIST_BASE_NAME
        end
        return id
    end
end

function Favourites:ListIsGlobalActive(listID)
    return ( self.globalDb.activeSubLists[listID] or self.globalDb.activeSubLists[listID] == false ) and true or false
end

function Favourites:ListIsProfileActive(listID)
    return ( self.db.activeSubLists[listID] or self.db.activeSubLists[listID] == false ) and true or false
end

function Favourites:CleanUpShownLists()
    self.db.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.db.activeSubLists)
    self.globalDb.activeSubLists = CleanUpShownLists(self.db, self.globalDb, self.globalDb.activeSubLists, true)
    self:ClearCountCache()
end

function Favourites:AddIntoShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if not listID or not list[listID] then return end
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = isGlobalList
end

function Favourites:RemoveFromShownList(listID, isGlobalList, globalShown)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local activeSubLists = ( isGlobalList and globalShown ) and self.globalDb.activeSubLists or self.db.activeSubLists

    activeSubLists[listID] = nil
end

function Favourites:SetIcon(icon)
    self.activeList.__icon = ( icon ~= STD_ICON and icon ~= STD_ICON2 ) and icon or nil
end

function Favourites:GetIcon()
    return self.activeList.__icon
end

function Favourites:HasIcon()
    return self.activeList.__icon and true or false
end

function Favourites:GetActiveListName()
    return self.activeList.__name or LIST_BASE_NAME
end

function Favourites:SetActiveListName(name)
    self.activeList.__name = name
end

function Favourites:AddNewList(isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    local id = format(NEW_LIST_ID_PATTERN, isGlobalList and "g" or "p", GetServerTime())

    if not list[id] then    -- should work as spam protect as GetServerTime returns sec
        list[id] = {}
        self:AddIntoShownList(id, isGlobalList, isGlobalList)
        return id
    end
    return false
end

function Favourites:RemoveList(listID, isGlobalList)
    local list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    if list[listID] then
        list[listID] = nil
        self:CleanUpShownLists()
        return true
    end
    return false
end
-- AtlasLoot.Addons.GetAddon(Addons, "Favourites"):ExportItemList("ProfileBase", false)
function Favourites:RemoveEntrysFromList(listID, isGlobalList)
    local list = self:GetListByID(listID, isGlobalList)
    if not list then return end
    local newList = {}
    for key, entry in pairs(list) do
        if strsub(key, 1, 2) == "__" then
            newList[key] = entry
        end
    end
    list = isGlobalList and self:GetGlobaleLists() or self:GetProfileLists()
    list[listID] = newList
    return newList
end

function Favourites:ExportItemList(listID, isGlobalList)
    local list = self:GetListByID(listID, isGlobalList)
    if not list then return end
    local ret = {}
    for entry in pairs(list) do
        if strsub(entry, 1, 2) ~= "__" then
            local exportString = format(EXPORT_PATTERN, "i", entry, list.notes and list.notes[entry] or "")
            if strsub(exportString, -1) == ":" then
                -- Remove tailing ":" if no note is supplied
                exportString = strsub(exportString, 1, -2)
            end
            ret[#ret + 1] = exportString
        end
    end
    return tblconcat(ret, IMPORT_EXPORT_DELIMITER)
end

function Favourites:ImportItemList(listID, isGlobalList, newList, replace)
    local list = replace and self:RemoveEntrysFromList(listID, isGlobalList) or self:GetListByID(listID, isGlobalList)
    if not list then return end
    if not list.notes then
        list.notes = {}
    end
    local numNewEntrys = 0
    if type(newList) == "string" then
        local stList = { strsplit(IMPORT_EXPORT_DELIMITER, newList) }
        list.mainItems = {}
        for i = 1, #stList do
            local eType, entry, _, note = strmatch(stList[i], IMPORT_PATTERN)
            if entry then
                entry = tonumber(entry)
                if eType == "i" and not list[entry] and ItemExist(entry) then
                    list[entry] = true
                    if note and note ~= "" then
                        local noteLC = strlower(note)
                        list.notes[tonumber(entry)] = note
                        if strmatch(noteLC, "bis") or strmatch(noteLC, "best") then
                            -- Set as main item
                            local slotId = nil
                            local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(entry)
                            if itemEquipLoc == "INVTYPE_HEAD" then
                                slotId = 1
                            elseif itemEquipLoc == "INVTYPE_NECK" then
                                slotId = 2
                            elseif itemEquipLoc == "INVTYPE_SHOULDER" then
                                slotId = 3
                            elseif itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" then
                                slotId = 5
                            elseif itemEquipLoc == "INVTYPE_WAIST" then
                                slotId = 6
                            elseif itemEquipLoc == "INVTYPE_LEGS" then
                                slotId = 7
                            elseif itemEquipLoc == "INVTYPE_FEET" then
                                slotId = 8
                            elseif itemEquipLoc == "INVTYPE_WRIST" then
                                slotId = 9
                            elseif itemEquipLoc == "INVTYPE_HAND" then
                                slotId = 10
                            elseif itemEquipLoc == "INVTYPE_FINGER" then
                                if not list.mainItems[11] then
                                    slotId = 11
                                else
                                    slotId = 12
                                end
                            elseif itemEquipLoc == "INVTYPE_TRINKET" then
                                if not list.mainItems[13] then
                                    slotId = 13
                                else
                                    slotId = 14
                                end
                            elseif itemEquipLoc == "INVTYPE_CLOAK" then
                                slotId = 15
                            elseif itemEquipLoc == "INVTYPE_WEAPON" then
                                if not list.mainItems[16] then
                                    slotId = 16
                                else
                                    slotId = 17
                                end
                            elseif itemEquipLoc == "INVTYPE_2HWEAPON" or itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
                                slotId = 16
                            elseif itemEquipLoc == "INVTYPE_WEAPONOFFHAND" or itemEquipLoc == "INVTYPE_HOLDABLE" or itemEquipLoc == "INVTYPE_SHIELD" then
                                slotId = 17
                            elseif itemEquipLoc == "INVTYPE_RANGED" or itemEquipLoc == "INVTYPE_THROWN" or itemEquipLoc == "INVTYPE_RANGEDRIGHT" or itemEquipLoc == "INVTYPE_RELIC" then
                                slotId = 18
                            end
                            if slotId ~= nil and not list.mainItems[slotId] then
                                list.mainItems[slotId] = entry
                            end
                        end
                    end
                    numNewEntrys = numNewEntrys + 1
                end
            end
        end
    elseif type(newList) == "table" then
        for i = 1, #newList do
            if not list[newList[i]] then
                list[newList[i]] = true
                numNewEntrys = numNewEntrys + 1
            end
        end
    end
    return numNewEntrys
end

function Favourites:TooltipHookEnabled()
    return self.db.enabled and ( self.db.showIconInTT or self.db.showListInTT ) or false
end

-- gui
function Favourites:SetAsMainItem(slotID, itemID)
    if not self.activeList then return end
    if not self.activeList.mainItems then self.activeList.mainItems = {} end
    self.activeList.mainItems[slotID] = itemID
    self:ClearCountCache()
end

function Favourites:SetMainItemEmpty(slotID)
    self:SetAsMainItem(slotID, true)
end

function Favourites:CleanUpMainItems()
    if self.activeList and self.activeList.mainItems then
        local newList = {}
        local count = 0
        for k,v in pairs(self.activeList.mainItems) do
            if v == true or self.activeList[v] then
                newList[k] = v
                count = count + 1
            end
        end
        if count > 0 then
            self.activeList.mainItems = newList
        else
            self.activeList.mainItems = nil
        end
    end
    self.GUI:ItemListUpdate()
end

function Favourites:ClearCountCache()
    ItemCountCache = {}
end

function Favourites:GetMainListItems()
    return self.activeList and self.activeList.mainItems or nil
end

Favourites:Finalize()
