local ALName, ALPrivate = ...
local AL = {}
_G.AtlasLoot.Locales = AL

--lua
local rawset = rawset

-- save
local localeSave = {}

function _G.AtlasLoot.GetLocales(locale)
	return ALPrivate.ACCOUNT_LOCALE == locale and AL or nil
end

setmetatable(AL, {
	__index = function(self, key)
		--self[key] = key or ""
		return localeSave[key] or key--error(format("%s LOCALE NOT FOUND", key or "nil"))
	end,
	__newindex = function(self, key, value)
		rawset(localeSave, key, value == true and key or value)
	end,
	}
)
