local _G = getfenv(0)
local AtlasLoot = _G.AtlasLoot
local SlashCommands = {}
AtlasLoot.SlashCommands = SlashCommands
local AL = AtlasLoot.Locales

-- lua
local assert, type, select, print = _G.assert, _G.type, _G.select, _G.print
local str_lower, str_format, str_split = _G.string.lower, _G.string.format, _G.string.split
local tbl_remove, unpack, pairs = _G.table.remove, _G.unpack, _G.pairs

local resetFunctions = {}

local function showOptions()
	AtlasLoot.Options:Show()
end

local CommandList = {
	[""] = function()
		AtlasLoot.GUI:Toggle()
	end,
	["options"] = function()
		AtlasLoot.Loader:LoadModule("AtlasLootClassic_Options", showOptions)
	end,
	["slash"] = function()
		SlashCommands:PrintSlash()
	end,
	["reset"] = function(typ)
		SlashCommands:Reset(typ or "all")
	end,
}

local HelpList = {
	[""] = AL["/al - Open the AtlasLoot window."],
	["slash"] = AL["/al slash - Prints a list of all slash commands."],
	["options"] = AL["/al options - Open AtlasLoot Options window."],

	--["reset"] = AL["/al reset - ???."],
}

function SlashCommands.Init()
	SLASH_ATLASLOOT1 = "/atlasloot"
	SLASH_ATLASLOOT2 = "/al"
	SlashCmdList["ATLASLOOT"] = function(msg)
		msg = str_lower(msg)
		msg = { str_split(" ", msg) or msg }
		if #msg >= 1 then
			local exec = tbl_remove(msg, 1)
			SlashCommands:Run(exec, unpack(msg))
		end
	end
end
AtlasLoot:AddInitFunc(SlashCommands.Init)

function SlashCommands:Run(exec, ...)
	if exec and type(exec) == "string" then
		if CommandList[exec] and type(CommandList[exec]) == "function" then
			CommandList[exec](...)
		elseif SlashCommands[exec] then
			SlashCommands[exec](...)
		else
			AtlasLoot:Print(str_format(AL["Command %s not found. Use '/al slash' for a full list of commands"], exec))
		end
	end
end

-- Adds a new slash command
function SlashCommands:Add(exec, func, helpText)
	assert(type(exec) == "string", "'exec' must be a string")
	assert(type(func) == "function", "'func' must be a function")
	assert(type(helpText) == "string", "'helpText' must be a string")
	assert(not CommandList[exec], str_format("%s already exists", exec))
	CommandList[exec] = func
	HelpList[exec] = helpText
end

function SlashCommands:PrintSlash()
	AtlasLoot:Print(AL["Slash commands:"])
	for k in pairs(CommandList) do
		if k == "reset" then
			local resetCommands = "all, frames"
			for k,v in pairs(resetFunctions) do
				if k ~= "frames" then
					resetCommands = resetCommands..", "..k
				end
			end
			resetCommands = "|cff33ff99<"..resetCommands..">|r"
			print(str_format("/al %s %s%s", k, resetCommands, HelpList[k] or ""))
		elseif HelpList[k] then
			print(HelpList[k])
		else
			print(str_format("/al %s", k))
		end
	end
end

function SlashCommands:FixAtlasLoot()
	-- reset frame positions
	SlashCommands:Reset("frames")
end

-- ###############################
-- Reset functions
-- ###############################

function SlashCommands:Reset(name)
	for tabName,funcTab in pairs(resetFunctions) do
		if not name or name == "all" or name == tabName then
			for func in pairs(funcTab) do
				func()
			end
		end
	end
end

function SlashCommands:AddResetFunction(func, ...)
	assert(type(func) == "function", "'func' must be a function")
	local name
	for i=1,select("#",...) do
		name = select(i,...)
		if not resetFunctions[name] then resetFunctions[name] = {} end
		resetFunctions[name][func] = true
	end
end
