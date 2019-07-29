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
local setmetatable = setmetatable

-- WoW
local IsModifierKeyDown = IsModifierKeyDown
local IsAltKeyDown, IsLeftAltKeyDown, IsRightAltKeyDown = IsAltKeyDown, IsLeftAltKeyDown, IsRightAltKeyDown
local IsControlKeyDown, IsLeftControlKeyDown, IsRightControlKeyDown = IsControlKeyDown, IsLeftControlKeyDown, IsRightControlKeyDown
local IsShiftKeyDown, IsLeftShiftKeyDown, IsRightShiftKeyDown = IsShiftKeyDown, IsLeftShiftKeyDown, IsRightShiftKeyDown


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


function ClickHandler:GetLocModifier()
	return MODIFIER_LOC
end

function Proto:Get(mouseButton)
	local db = self.db or self:SetDB(AtlasLoot.db.Button[self.name])
	local handler = self.handler
	if mouseButton and handler[mouseButton] then
		if IsModifierKeyDown() then
			if IsShiftKeyDown() then
				if IsLeftShiftKeyDown() and handler[mouseButton].LeftShift then
					return db[handler[mouseButton].LeftShift]
				elseif IsRightShiftKeyDown() and handler[mouseButton].RightShift then
					return db[handler[mouseButton].RightShift]
				end
				if handler[mouseButton].Shift then
					return db[handler[mouseButton].Shift]
				end
			elseif IsAltKeyDown() then
				if IsLeftAltKeyDown() and handler[mouseButton].LeftAlt then
					return db[handler[mouseButton].LeftAlt]
				elseif IsRightAltKeyDown() and handler[mouseButton].RightAlt then
					return db[handler[mouseButton].RightAlt]
				end
				if handler[mouseButton].Alt then
					return db[handler[mouseButton].Alt]
				end
			elseif IsControlKeyDown() then
				if IsLeftControlKeyDown() and handler[mouseButton].LeftCtrl then
					return db[handler[mouseButton].LeftCtrl]
				elseif IsRightControlKeyDown() and handler[mouseButton].RightCtrl then
					return db[handler[mouseButton].RightCtrl]
				end
				if handler[mouseButton].Ctrl then
					return db[handler[mouseButton].Ctrl]
				end
			end
		end
		return handler[mouseButton].None
	end
end

function Proto:Update()
	local db = self.db or self:GetDB() or self.defaults

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