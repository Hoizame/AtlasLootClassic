local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local ContentPhase = {}
AtlasLoot.Data.ContentPhase = ContentPhase
local AL = AtlasLoot.Locales
local IMAGE_PATH = ALPrivate.IMAGE_PATH
local ACTIVE_PASE_LIST = {
    [0] = 99, -- dummy
    [1] = 6, -- classic
    [2] = 1, -- bc
}
local ACTIVE_PHASE = ACTIVE_PASE_LIST[AtlasLoot:GetGameVersion()] or ACTIVE_PASE_LIST[1]

--##START-DATA##
local PHASE_ITEMS = {}
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
    return gameVersion and ACTIVE_PASE_LIST[gameVersion] or ACTIVE_PHASE
end

function ContentPhase:IsActive(phase, gameVersion)
    return (phase or 0) <= (gameVersion and ACTIVE_PASE_LIST[gameVersion] or ACTIVE_PHASE)
end
