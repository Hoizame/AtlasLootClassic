-- WoW: Forever (Camelot) compatibility shims.
-- Loaded only by AtlasLootClassic_Camelot.toc, before libraries and Init.lua.

local _G = _G
local type, pairs = type, pairs

local function callable(value)
	return type(value) == "function"
end

if C_AddOns then
	local aliases = {
		GetAddOnMetadata = "GetAddOnMetadata",
		GetNumAddOns = "GetNumAddOns",
		GetAddOnInfo = "GetAddOnInfo",
		IsAddOnLoaded = "IsAddOnLoaded",
		LoadAddOn = "LoadAddOn",
	}
	for oldName, newName in pairs(aliases) do
		if _G[oldName] == nil and callable(C_AddOns[newName]) then
			_G[oldName] = C_AddOns[newName]
		end
	end
	if _G.GetAddOnEnableState == nil and callable(C_AddOns.GetAddOnEnableState) then
		_G.GetAddOnEnableState = function(character, addon)
			return C_AddOns.GetAddOnEnableState(addon, character)
		end
	end
end

if C_Spell then
	if _G.GetSpellInfo == nil and callable(C_Spell.GetSpellInfo) then
		_G.GetSpellInfo = function(spell)
			local info = C_Spell.GetSpellInfo(spell)
			if not info then return nil end
			return info.name, nil, info.iconID, info.castTime,
				info.minRange, info.maxRange, info.spellID, info.originalIconID
		end
	end
	if _G.GetSpellTexture == nil and callable(C_Spell.GetSpellTexture) then _G.GetSpellTexture = C_Spell.GetSpellTexture end
	if _G.GetSpellDescription == nil and callable(C_Spell.GetSpellDescription) then _G.GetSpellDescription = C_Spell.GetSpellDescription end
	if _G.GetSpellLink == nil and callable(C_Spell.GetSpellLink) then _G.GetSpellLink = C_Spell.GetSpellLink end
end

if C_Item then
	local aliases = {
		GetItemInfo = "GetItemInfo",
		GetItemInfoInstant = "GetItemInfoInstant",
		GetItemCount = "GetItemCount",
		GetItemQualityColor = "GetItemQualityColor",
		GetItemClassInfo = "GetItemClassInfo",
		GetItemSubClassInfo = "GetItemSubClassInfo",
		IsEquippableItem = "IsEquippableItem",
	}
	for oldName, newName in pairs(aliases) do
		if _G[oldName] == nil and callable(C_Item[newName]) then _G[oldName] = C_Item[newName] end
	end
	if _G.GetItemIcon == nil then
		if callable(C_Item.GetItemIconByID) then
			_G.GetItemIcon = C_Item.GetItemIconByID
		elseif callable(C_Item.GetItemInfoInstant) then
			_G.GetItemIcon = function(item)
				local _, _, _, _, icon = C_Item.GetItemInfoInstant(item)
				return icon
			end
		end
	end
	if _G.GetItemStats == nil then
		if callable(C_Item.GetItemStats) then
			_G.GetItemStats = function(item, statTable)
				local stats = C_Item.GetItemStats(item)
				if not stats then return statTable or {} end
				if statTable then
					for k in pairs(statTable) do statTable[k] = nil end
					for k, v in pairs(stats) do statTable[k] = v end
					return statTable
				end
				return stats
			end
		else
			_G.GetItemStats = function(item, statTable) return statTable or {} end
		end
	end
end

if _G.GetCurrencyInfo == nil and C_CurrencyInfo and callable(C_CurrencyInfo.GetCurrencyInfo) then
	_G.GetCurrencyInfo = function(currency)
		local info
		if type(currency) == "string" and callable(C_CurrencyInfo.GetCurrencyInfoFromLink) then
			info = C_CurrencyInfo.GetCurrencyInfoFromLink(currency)
		else
			info = C_CurrencyInfo.GetCurrencyInfo(currency)
		end
		if not info then return nil end
		return info.name, info.quantity, info.iconFileID, info.quantityEarnedThisWeek,
			info.maxWeeklyQuantity, info.maxQuantity, info.discovered, info.quality
	end
end

if _G.GetFactionInfoByID == nil and C_Reputation and callable(C_Reputation.GetFactionDataByID) then
	_G.GetFactionInfoByID = function(factionID)
		local data = C_Reputation.GetFactionDataByID(factionID)
		if not data then return nil end
		return data.name, data.description, data.reaction,
			data.currentReactionThreshold, data.nextReactionThreshold, data.currentStanding,
			data.atWarWith, data.canToggleAtWar, data.isHeader, data.isCollapsed,
			data.hasRep, data.isWatched, data.isChild, data.factionID,
			data.hasBonusRepGain, data.canSetInactive
	end
end

if _G.GetFriendshipReputation == nil and C_GossipInfo and callable(C_GossipInfo.GetFriendshipReputation) then
	_G.GetFriendshipReputation = function(factionID)
		local data = C_GossipInfo.GetFriendshipReputation(factionID)
		if not data then return nil end
		return data.friendshipFactionID, data.standing, data.maxRep, data.name,
			data.text, data.texture, data.reaction, data.reactionThreshold, data.nextThreshold
	end
end

if C_ChatInfo then
	if _G.SendAddonMessage == nil and callable(C_ChatInfo.SendAddonMessage) then _G.SendAddonMessage = C_ChatInfo.SendAddonMessage end
	if _G.RegisterAddonMessagePrefix == nil and callable(C_ChatInfo.RegisterAddonMessagePrefix) then _G.RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix end
end

if _G.FillLocalizedClassList == nil then
	if callable(_G.LocalizedClassList) then
		_G.FillLocalizedClassList = function(target, isFemale)
			local classes = _G.LocalizedClassList(isFemale)
			if target and classes then
				for classFile, className in pairs(classes) do target[classFile] = className end
			end
			return target
		end
	elseif C_CreatureInfo and callable(C_CreatureInfo.GetClassInfo) then
		_G.FillLocalizedClassList = function(target)
			if not target then return target end
			for classID = 1, 13 do
				local info = C_CreatureInfo.GetClassInfo(classID)
				if info and info.classFile and info.className then target[info.classFile] = info.className end
			end
			return target
		end
	end
end

_G.AtlasLootCanAccessValue = _G.AtlasLootCanAccessValue or function(value)
	if callable(_G.issecretvalue) then
		local ok, isSecret = pcall(_G.issecretvalue, value)
		if ok and isSecret then return false end
	end
	if callable(_G.canaccessvalue) then
		local ok, canAccess = pcall(_G.canaccessvalue, value)
		if ok and canAccess == false then return false end
	end
	return true
end

if type(_G.RAID_CLASS_COLORS) ~= "table" then _G.RAID_CLASS_COLORS = {} end
local fallbackClassColors = {
	WARRIOR={0.78,0.61,0.43}, PALADIN={0.96,0.55,0.73}, HUNTER={0.67,0.83,0.45},
	ROGUE={1.00,0.96,0.41}, PRIEST={1,1,1}, SHAMAN={0,0.44,0.87},
	MAGE={0.25,0.78,0.92}, WARLOCK={0.53,0.53,0.93}, DRUID={1,0.49,0.04},
	DEATHKNIGHT={0.77,0.12,0.23},
}
for classFile, rgb in pairs(fallbackClassColors) do
	if not _G.RAID_CLASS_COLORS[classFile] then
		local r,g,b = rgb[1],rgb[2],rgb[3]
		_G.RAID_CLASS_COLORS[classFile] = {
			r=r,g=g,b=b,a=1,
			colorStr=string.format("ff%02x%02x%02x",
				math.floor(r*255+0.5), math.floor(g*255+0.5), math.floor(b*255+0.5)),
		}
	end
end
