local ALName, ALPrivate = ...

local AtlasLoot = _G.AtlasLoot
local AutoSelect = {}
AtlasLoot.Data.AutoSelect = AutoSelect
local AL = AtlasLoot.Locales

-- lua
local unpack = unpack

-- WoW
local UnitPosition = UnitPosition
local GetSubZoneText = GetSubZoneText

local LOCALE, SUB_L = GetLocale()
-- Locales data
--##START-DATA##
if LOCALE == "deDE" then
	SUB_L = {
		[21379] = "Kammer der Buße",
		[23805] = "Ehrengrabmal",
		[24000] = "Unglückseliger Kreuzgang",
	}
elseif LOCALE == "zhCN" then
	SUB_L = {
		[21379] = "忏悔室",
		[23805] = "荣耀之墓",
		[24000] = "遗忘回廊",
	}
elseif LOCALE == "esES" then
	SUB_L = {
		[21379] = "Cámara Expiatoria",
		[23805] = "Tumba del Honor",
		[24000] = "Claustro Inhóspito",
	}
elseif LOCALE == "frFR" then
	SUB_L = {
		[21379] = "Chambre de l'expiation",
		[23805] = "Tombe de l'honneur",
		[24000] = "Cloître solitaire",
	}
elseif LOCALE == "itIT" then
	SUB_L = {
		[21379] = "Chambre de l'expiation",
		[23805] = "Tombe de l'honneur",
		[24000] = "Cloître solitaire",
	}
elseif LOCALE == "koKR" then
	SUB_L = {
		[21379] = "속죄의 방",
		[23805] = "명예의 무덤",
		[24000] = "쓸쓸한 회랑",
	}
elseif LOCALE == "esMX" then
	SUB_L = {
		[21379] = "Cámara Expiatoria",
		[23805] = "Tumba del Honor",
		[24000] = "Claustro Abandonado",
	}
elseif LOCALE == "ptBR" then
	SUB_L = {
		[21379] = "Câmara da Redenção",
		[23805] = "Tumba de Honra",
		[24000] = "Claustro Esquecido",
	}
elseif LOCALE == "ruRU" then
	SUB_L = {
		[21379] = "Чертог Искупления",
		[23805] = "Гробница Доблести",
		[24000] = "Покинутый двор",
	}
elseif LOCALE == "zhTW" then
	SUB_L = {
		[21379] = "懺悔室",
		[23805] = "榮耀之墓",
		[24000] = "遺忘回廊",
	}
else
	SUB_L = {
		[21379] = "Chamber of Atonement",
		[23805] = "Honor's Tomb",
		[24000] = "Forlorn Cloister",
	}
end
--##END-DATA##

-- AutoSelect
local AutoSelectSave = {}
local LastBase

function AutoSelect:RefreshOptions()
	if AtlasLoot.db.enableAutoSelect and not AtlasLoot.Loader:IsModuleLoaded("AtlasLootClassic_DungeonsAndRaids") then
		AtlasLoot.Loader:LoadModule("AtlasLootClassic_DungeonsAndRaids")
	end
end

function AutoSelect:AddInstanceTable(module, instanceAlID, iniTab)
    if not iniTab then return end
    local instanceID = iniTab.InstanceID
    if not module or not instanceAlID or not instanceID then return end
    if not AutoSelectSave[instanceID] then
        AutoSelectSave[instanceID] = {
            base = { module, instanceAlID }
        }
    end
    local content = AutoSelectSave[instanceID]

    if iniTab.SubAreaIDs then
        if not content.sub then
            content.sub = {}
            content.subList = {}
        end

        for i = 1, #iniTab.SubAreaIDs do
            content.sub[iniTab.SubAreaIDs[i]] = { module, instanceAlID }
            content.subList[#content.subList + 1] = iniTab.SubAreaIDs[i]
        end
        -- SubAreaIDs / SubAreaID
        for i = 1, #iniTab.items do
            local id = iniTab.items[i].SubAreaID
            if id and content.sub[id] and not content.sub[id][3] then
                content.sub[id][3] = i
            end
        end

    end
end

function AutoSelect:GetCurrrentPlayerData()
    local posY, posX, posZ, instanceID = UnitPosition("player")
    local ini = instanceID and AutoSelectSave[instanceID] or nil
    if ini then
        if ini.sub then
            local subZoneName = GetSubZoneText()
            for i = 1, #ini.subList do
                local locName = SUB_L[ini.subList[i]]
                if locName and locName == subZoneName then
                    return ini.sub[ini.subList[i]][1], ini.sub[ini.subList[i]][2], ini.sub[ini.subList[i]][3]
                end
            end
        end
        return unpack(ini.base)
	end
end
