local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local ContentPhase = {}
AtlasLoot.Data.ContentPhase = ContentPhase
local AL = AtlasLoot.Locales
local IMAGE_PATH = ALPrivate.IMAGE_PATH
local ACTIVE_PHASE_LIST = {
    [0] = 99, -- dummy
    [AtlasLoot.CLASSIC_VERSION_NUM] = 6, -- classic
    [AtlasLoot.BC_VERSION_NUM]      = 6, -- bc
    [AtlasLoot.WRATH_VERSION_NUM]   = 6, -- wrath
    [AtlasLoot.CATA_VERSION_NUM]    = 1, -- cata
}
local ACTIVE_PHASE = ACTIVE_PHASE_LIST[AtlasLoot:GetGameVersion()] or ACTIVE_PHASE_LIST[1]

--##START-DATA##
local PHASE_ITEMS = {}
if AtlasLoot:GameVersion_EQ(AtlasLoot.CLASSIC_VERSION_NUM) then
    PHASE_ITEMS = {

    }
end

if AtlasLoot:GameVersion_EQ(AtlasLoot.BC_VERSION_NUM) then
    PHASE_ITEMS = {

    }
end

if AtlasLoot:GameVersion_EQ(AtlasLoot.WRATH_VERSION_NUM) then
    PHASE_ITEMS = {
	}
end

    -- TODO: cata phase items
if AtlasLoot:GameVersion_EQ(AtlasLoot.CATA_VERSION_NUM) then
    PHASE_ITEMS = {
    }
end

--##END-DATA##
PHASE_ITEMS[0] = 0

local PHASE_TEXTURE_PATH = {
	[2] = IMAGE_PATH.."P2",
	[2.5] = IMAGE_PATH.."P2-5",
    [3] = IMAGE_PATH.."P3",
    [4] = IMAGE_PATH.."P4",
    [5] = IMAGE_PATH.."P5",
    [6] = IMAGE_PATH.."P6",
}

function ContentPhase:GetForItemID(itemID)
    return PHASE_ITEMS[itemID or 0], self:IsActive(PHASE_ITEMS[itemID or 0])
end

function ContentPhase:GetPhaseTexture(phase)
    return PHASE_TEXTURE_PATH[phase], self:IsActive(phase)
end

function ContentPhase:GetPhaseTextureForItemID(itemID)
    return PHASE_TEXTURE_PATH[PHASE_ITEMS[itemID or 0] or 0], self:IsActive(PHASE_ITEMS[itemID or 0])
end

function ContentPhase:GetActivePhase(gameVersion)
    return gameVersion and ACTIVE_PHASE_LIST[gameVersion] or ACTIVE_PHASE
end

function ContentPhase:IsActive(phase, gameVersion)
    return (phase or 0) <= (gameVersion and ACTIVE_PHASE_LIST[gameVersion] or ACTIVE_PHASE)
end

function ContentPhase:GetActivePhaseTexture()
    if ACTIVE_PHASE == 1 then
        return PHASE_TEXTURE_PATH[2]
    elseif PHASE_TEXTURE_PATH[ACTIVE_PHASE] then
        return PHASE_TEXTURE_PATH[ACTIVE_PHASE]
    else
        return PHASE_TEXTURE_PATH[6]
    end
end
