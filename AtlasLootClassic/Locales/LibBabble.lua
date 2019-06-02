local AtlasLoot = _G.AtlasLoot
local LibBabble = {}
AtlasLoot.LibBabble = LibBabble

-- lua
local LibStub = LibStub
local setmetatable = setmetatable
local format = format
local FORMAT_STRING = "%s \"%s\" ERROR"

function LibBabble:Get(typ)
	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	return setmetatable({__LibName = typ}, {
		__index = function(t,k)
			return loctab[k] and loctab[k] or (rettab[k] or format(FORMAT_STRING, t.__LibName, k))
		end,
	})
end
