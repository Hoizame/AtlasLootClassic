local MAJOR, MINOR = "LibClassicItemSets-1.0", 1
assert(LibStub, MAJOR .. " requires LibStub")

local CIS, oldversion = LibStub:NewLibrary(MAJOR, MINOR)
if not CIS then return end

-- lua
local _G = _G
local assert = assert

-- WoW
local GetItemIcon = GetItemIcon

-- locales
local LOCALES, SETS, ITEMS = {}, {}, {}
local CUR_DATA_VERSION = 0

-- ##############################
-- local
-- ##############################
local CLASS_LIST = {
    [1]  = "WARRIOR",
    [2]  = "PALADIN",
    [3]  = "HUNTER",
    [4]  = "ROGUE",
    [5]  = "PRIEST",
    [7]  = "SHAMAN",
    [8]  = "MAGE",
    [9]  = "WARLOCK",
    [11] = "DRUID",
}

local function CopyTable(t)
    if not t or #t == 0 then return end
    local newT = {}
    for i = 1, #t do
        newT[i] = t[i]
    end
    return newT
end

-- ##############################
-- API
-- ##############################
--- Check if setID exist
function CIS:SetExist(setID)
    return SETS[setID] and true or false
end

--- Get the localized name of an item set
function CIS:GetSetName(setID)
    return LOCALES[setID]
end

--- Get itemtable
-- @return { itemID1, itemID2, itemID3, ... }
function CIS:GetItems(setID)
    assert(SETS[setID], "Unknown setID - "..setID)
    return CopyTable(SETS[setID][1])
end

--- Get the player class for an ItemSet
-- @return classID, className
function CIS:GetPlayerClass(setID)
    assert(SETS[setID], "Unknown setID - "..setID)
    if SETS[setID][3] then
        return SETS[setID][3], CLASS_LIST[ SETS[setID][3] ]
    else
        return
    end
end

--- Get the icon for the ItemSet
function CIS:GetSetIcon(setID)
    assert(SETS[setID], "Unknown setID - "..setID)
    return SETS[setID][2] and GetItemIcon(SETS[setID][2] or SETS[setID][1][1])
end

--- Get the setID for an itemID if its part of a Set
-- @return setID
function CIS:GetItemSetForItemID(itemID)
    return ITEMS[itemID]
end
-- ##############################
-- Lib intern use
-- ##############################
function CIS:IsNewData(version)
    return version > CUR_DATA_VERSION
end

function CIS:RegisterNewData(data, version)
    assert(data and type(data) == "table", "'data' must be a table.")
    assert(data and type(version) == "number", "'version' must be a number.")
    if not self:IsNewData(version) then return end
    assert(data.SETS, "'SETS' is missing from 'data'")
    assert(data.ITEMS, "'ITEMS' is missing from 'data'")
    LOCALES = data.LOC or {}
    SETS = data.SETS
    ITEMS = data.ITEMS
    CUR_DATA_VERSION = version
end