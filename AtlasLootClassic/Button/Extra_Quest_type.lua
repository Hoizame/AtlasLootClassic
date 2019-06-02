local AtlasLoot = _G.AtlasLoot
local Quest = AtlasLoot.Button:AddExtraType("Quest")
local AL = AtlasLoot.Locales

local GetQuestName = AtlasLoot.TooltipScan.GetQuestName--(questID, onGetFunc, arg1)

-- lua
local type, tonumber = type, tonumber
local split = string.split

local QUEST_ICONS = {
	[0] = "Interface\\GossipFrame\\AvailableQuestIcon",					-- normal
	[1] = "Interface\\GossipFrame\\DailyQuestIcon",						-- daily
	[2] = "Interface\\GossipFrame\\AvailableLegendaryQuestIcon",		-- legendary
}
local SPLIT_A = ":"

local Cache = {}
setmetatable(Cache, {__mode = "kv"})

local function SetQuest(name, typ, frame)
	frame:AddIcon(QUEST_ICONS[typ or 0])
	frame:AddText(name)
end

local function SetQuestQuery(name, frame, remover)
	if not frame.info or ( remover ~= nil and frame.removerInfo and frame.removerInfo[2] ~= remover ) then return end
	Cache[frame.cacheTyp] = { name, tonumber(frame.typ) or 0 }
	SetQuest(name, Cache[frame.cacheTyp][2], frame)
	--frame.info = nil
	frame.typ = nil
	frame.cacheTyp = nil
	frame.removerInfo = nil
end

function Quest.OnSet(mainButton, descFrame)
	local typeVal = mainButton.__atlaslootinfo.extraType[2]
	if Cache[typeVal] then
		SetQuest(Cache[typeVal][1], Cache[typeVal][2], descFrame)
		descFrame.info = typeVal
	else
		descFrame.cacheTyp = typeVal
		if type(typeVal) == "string" then
			descFrame.typ, typeVal = split(SPLIT_A, typeVal)
			typeVal = tonumber(typeVal)
		end
		descFrame.info = typeVal
		local remover = GetQuestName(typeVal, SetQuestQuery, descFrame)
		if remover then
			descFrame.removerInfo = {AtlasLoot.TooltipScan.Remove, remover}
		end
		return
	end
end


function Quest.OnEnter(descFrame, tooltip)
	if not descFrame.info then return end
	tooltip:SetHyperlink("quest:"..descFrame.info)
end
