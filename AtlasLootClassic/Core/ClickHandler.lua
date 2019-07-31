--[[
	Allows presets with keybinds

	-- MouseButtons
	- LeftButton
	- RightButton
	- MiddleButton
	- Button4-x

	- MouseWheelUp
	- MouseWheelDown

]]
local _G = _G
local AtlasLoot = _G.AtlasLoot
local ClickHandler = {}
AtlasLoot.ClickHandler = ClickHandler
local Proto = {}
local AL = AtlasLoot.Locales
local DbDefaults = AtlasLoot.AtlasLootDBDefaults.profile.Button

-- lua
local setmetatable = _G.setmetatable

-- WoW
local IsModifierKeyDown = IsModifierKeyDown
local IsAltKeyDown, IsLeftAltKeyDown, IsRightAltKeyDown = _G.IsAltKeyDown, _G.IsLeftAltKeyDown, _G.IsRightAltKeyDown
local IsControlKeyDown, IsLeftControlKeyDown, IsRightControlKeyDown = _G.IsControlKeyDown, _G.IsLeftControlKeyDown, _G.IsRightControlKeyDown
local IsShiftKeyDown, IsLeftShiftKeyDown, IsRightShiftKeyDown = _G.IsShiftKeyDown, _G.IsLeftShiftKeyDown, _G.IsRightShiftKeyDown


local MOUSE_BUTTON_LOC = nil
local MODIFIER_LOC = {
	{ "Alt", 		_G["ALT_KEY_TEXT"] },
	{ "LeftAlt",	_G["LALT_KEY_TEXT"] },
	{ "RightAlt",	_G["RALT_KEY_TEXT"] },
	{ "Ctrl",		_G["CTRL_KEY_TEXT"] },
	{ "LeftCtrl",	_G["LCTRL_KEY_TEXT"] },
	{ "RightCtrl",	_G["RCTRL_KEY_TEXT"] },
	{ "Shift",		_G["SHIFT_KEY_TEXT"] },
	{ "LeftShift",	_G["LSHIFT_KEY_TEXT"] },
	{ "RightShift",	_G["RSHIFT_KEY_TEXT"] },
}
local HandlerRegister = {}

--[[ format
	-- db is only the table
	db = MySavedVariables.ClickHandler
	dbDefault = {
		ItemLink = { "LeftButton", "Shift" },
		types = {
			ItemLink = true,
		}
	}
	types = {
		-- { type, "ShortDesc", "LongDesc" },
		{ "ItemLink", AL["Chat Link"], AL["Link the item in chat"] },
	}
]]
function ClickHandler:Add(name, dbDefault, types)
	assert(not DbDefaults[name], "ClickHandler "..(name or "nil").." already exists.")

	DbDefaults[name] = dbDefault

	local handler = {
		name = name,
		types = types,
		defaults = dbDefault
	}

	setmetatable(handler, {__index = Proto})
	HandlerRegister[name] = handler

	return handler
end

function ClickHandler:GetHandler(name)
	return HandlerRegister[name]
end

function ClickHandler:Update(name)
	if not DbDefaults[name] then return end
	DbDefaults[name]:Update()
end

function ClickHandler:GetLocMouseButtons()
	if not MOUSE_BUTTON_LOC then
		local preSet = {
			["Button1"] = "LeftButton",
			["Button2"] = "RightButton",
			["Button3"] = "MiddleButton",
		}
		for i=1,100 do
			if _G["KEY_BUTTON"..i] then
				MOUSE_BUTTON_LOC[#MOUSE_BUTTON_LOC + 1] = { preSet["Button"..i] or "Button"..i, _G["KEY_BUTTON"..i] }
			else
				break
			end
		end
	end
	return MOUSE_BUTTON_LOC
end

function ClickHandler:OnProfileChanged()
	for k, v in pairs(HandlerRegister) do
		v.db = nil
	end
end

function ClickHandler:GetLocModifier()
	return MODIFIER_LOC
end

function Proto:Get(mouseButton)
	local db = self.db or self:SetDB(AtlasLoot.db.Button[self.name])
	local handler = self.handler
	if mouseButton and handler[mouseButton] then
		handler = handler[mouseButton]
		if IsModifierKeyDown() then
			if IsShiftKeyDown() then
				if IsLeftShiftKeyDown() and handler.LeftShift then
					return db.types[handler.LeftShift] and handler.LeftShift or nil
				elseif IsRightShiftKeyDown() and handler.RightShift then
					return db.types[handler.RightShift] and handler.RightShift or nil
				end
				if handler.Shift then
					return db.types[handler.Shift] and handler.Shift or nil
				end
			elseif IsAltKeyDown() then
				if IsLeftAltKeyDown() and handler.LeftAlt then
					return db.types[handler.LeftAlt] and handler.LeftAlt or nil
				elseif IsRightAltKeyDown() and handler.RightAlt then
					return db.types[handler.RightAlt] and handler.RightAlt or nil
				end
				if handler.Alt then
					return db.types[handler.Alt] and handler.Alt or nil
				end
			elseif IsControlKeyDown() then
				if IsLeftControlKeyDown() and handler.LeftCtrl then
					return db.types[handler.LeftCtrl] and handler.LeftCtrl or nil
				elseif IsRightControlKeyDown() and handler.RightCtrl then
					return db.types[handler.RightCtrl] and handler.RightCtrl or nil
				end
				if handler.Ctrl then
					return db.types[handler.Ctrl] and handler.Ctrl or nil
				end
			end
		end
		return handler.None
	end
end

function Proto:Update()
	local db = self.db or self:GetDB()

	local handler = {}

	for k,v in pairs(db) do
		if k ~= "types" then
			if v[1] and not handler[v[1]] then
				handler[v[1]] = {}
			end
			if v[2] and not handler[v[1]][v[2]] then
				handler[v[1]][v[2]] = k
			end
		end
	end

	self.handler = handler
end

function Proto:SetDB(dbTab)
	self.db = dbTab
	self:Update()
	return self.db
end

function Proto:GetDB(dbTab)
	return self.db or self:SetDB(AtlasLoot.db.Button[self.name])
end