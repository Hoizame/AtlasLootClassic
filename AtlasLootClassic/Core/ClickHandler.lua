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
function ClickHandler:Add(name, dbDefault, db, types)
	local handler = {}
	
	local dbDefaultNEW = {types = {}}
	for i = 1, #types do
		local typ = types[i][1]
		if not db.types then db.types = {} end
		dbDefaultNEW.types[typ] = dbDefault.types[typ]
		if db.types[typ] == nil then
			db.types[typ] = dbDefault.types[typ] or false
			-- set default keybind if aviable and free
			if dbDefault[typ] and dbDefault[typ][1] ~= "None" then
				local info = dbDefault[typ]
				if not db[info[1]] then db[info[1]] = {} end
				if db[info[1]][info[2]] == nil then
					db[info[1]][info[2]] = typ
				end
			end
		end
		if not dbDefaultNEW[dbDefault[typ][1]] then dbDefaultNEW[dbDefault[typ][1]] = {} end
		dbDefaultNEW[dbDefault[typ][1]][dbDefault[typ][2]] = typ
	end
	db.__defaults = dbDefaultNEW 
	
	handler.db = db
	handler.dbDefault = dbDefault
	handler.types = types
	
	setmetatable(handler, {__index = Proto})
	
	return handler
	
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
	if mouseButton and self.db[mouseButton] then
		if IsModifierKeyDown() then
			if IsShiftKeyDown() then
				if IsLeftShiftKeyDown() and self.db[mouseButton].LeftShift then
					return self.db[mouseButton].LeftShift
				elseif IsRightShiftKeyDown() and self.db[mouseButton].RightShift then
					return self.db[mouseButton].RightShift
				end
				if self.db[mouseButton].Shift then
					return self.db[mouseButton].Shift
				end
			elseif IsAltKeyDown() then
				if IsLeftAltKeyDown() and self.db[mouseButton].LeftAlt then
					return self.db[mouseButton].LeftAlt
				elseif IsRightAltKeyDown() and self.db[mouseButton].RightAlt then
					return self.db[mouseButton].RightAlt
				end
				if self.db[mouseButton].Alt then
					return self.db[mouseButton].Alt
				end
			elseif IsControlKeyDown() then
				if IsLeftControlKeyDown() and self.db[mouseButton].LeftCtrl then
					return self.db[mouseButton].LeftCtrl
				elseif IsRightControlKeyDown() and self.db[mouseButton].RightCtrl then
					return self.db[mouseButton].RightCtrl
				end
				if self.db[mouseButton].Ctrl then
					return self.db[mouseButton].Ctrl
				end
			end
		end	
		return self.db[mouseButton].None
	end
end
