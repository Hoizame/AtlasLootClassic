local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales
local SoundData = {}
AtlasLoot.ItemDB.SoundData = SoundData

local assert, type = assert, type
local pairs = pairs
local str_format = string.format

-- Saves all the sounds ;)
local Storage = {
	["sounddata"] = {},
	["npcdata"] = {},
	["pathdata"] = {},
}

local abc_alph = { "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
local AppendPreSets = {
	[1] = function(num)
		return tostring(num)
	end,
	[2] = function(num)
		return num > 9 and tostring(num) or "0"..num
	end,
	[3] = function(num)
		return abc_alph[num] or "a"
	end,
}

function SoundData.Init()
	-- needed?
end
--AtlasLoot:AddInitFunc(SoundData.Init)

-- /dump AtlasLoot.ItemDB.SoundData:GetSoundIdPath(11466)
-- /run AtlasLoot.ItemDB.SoundData:PlaySound(11466)
function SoundData:AddPathData(tab)
	if not tab then return end
	assert(type(tab) == "table", "tab must be a table")
	local retTab = {}
		for i = 1,#tab do
		Storage["pathdata"][#Storage["pathdata"] + 1] = tab[i]
		retTab[i] = #Storage["pathdata"]
	end
	return retTab
end

function SoundData:AddSoundNpcData(sounddata, npcdata)
	if sounddata and type(sounddata) == "table" then
		for k,v in pairs(sounddata) do
			Storage["sounddata"][k] = v
		end
	end
	if npcdata and type(npcdata) == "table" then
		for k,v in pairs(npcdata) do
			Storage["npcdata"][k] = v
		end
	end
end

function SoundData:GetNpcSoundList(npcId)
	return ( npcId and Storage["npcdata"][npcId] ) and Storage["npcdata"][npcId] or nil
end

function SoundData:GetSoundIdPath(soundId, num)
	if not soundId or not Storage["sounddata"][soundId] then return end
	soundId = Storage["sounddata"][soundId]
	local path
	if not soundId[3] then
		num = nil
		path = str_format("sound\\%s%s.ogg", Storage["pathdata"][ soundId[2] ], soundId[1]) -- path, filename, number
	elseif not num or num > soundId[3] then
		path = str_format("sound\\%s%s%s.ogg", Storage["pathdata"][ soundId[2] ], soundId[1], AppendPreSets[soundId[4] or 1](1)) -- path, filename, number
	else
		path = str_format("sound\\%s%s%s.ogg", Storage["pathdata"][ soundId[2] ], soundId[1], AppendPreSets[soundId[4] or 1](num)) -- path, filename, number
	end
	return path
end

function SoundData:PlaySound(soundId, soundNum, channel)
	local _
	if type(soundId) == "string" then
		_, soundId = PlaySoundFile(soundId, channel or "master")
	elseif Storage["sounddata"][soundId] then
		_, soundId = PlaySoundFile(SoundData:GetSoundIdPath(soundId, soundNum), channel or "master")
	end
	return soundId	-- StopSound(soundId)
end

function SoundData:GetNpcData(npcId)
	if not Storage["npcdata"][npcId] then return end
	local data = {}
	for kitIndex = 1, #Storage["npcdata"][npcId] do
		local kitId = Storage["npcdata"][npcId][kitIndex]
		data[kitIndex] = {
			kitId = kitId,
			numFiles = Storage["sounddata"][kitId][3] or 1,
			name = Storage["sounddata"][kitId][1],
			--collapsed = true,
			sounds = {},
		}
		if not Storage["sounddata"][kitId][3] then
			data[kitIndex].sounds[1] = SoundData:GetSoundIdPath(kitId)
		else
			for i=1,Storage["sounddata"][kitId][3] do
				data[kitIndex].sounds[i] = SoundData:GetSoundIdPath(kitId, i)
			end
		end
	end
	return data
end
