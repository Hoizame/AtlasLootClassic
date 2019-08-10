--[[
This little script get all Locales from the given files.
Used mostly for AtlasLoot
]]--
-- ################################
-- Settings
-- ################################
-- Output Path / Folder must exist
local OUTPUT_PATH = ""

-- Identifier for Locales
local IDENTIFIER = "AL"

-- Parse XML-Files for embeded lua scripts?
local PARSE_XML = true

-- Create a log file
local LOG = false

-- Set log lvl 0: info,warning,error - 1:warning,error - 2:error
local LOG_LVL = 1

-- Base namespace, globales that are found in base are removed from other namespaces
local BASE_NAMESPACE = "Global"

-- Move translations that are used in multiple namespaces into base namespace?
local REBASE_LOCALES = true

-- FileList, supports toc, xml and lua
local FILE_LIST = {
	-- optional: { "path", <bool>ParseXML } -- disable/enable xml parsing for single files
	Global = {
		"AtlasLootClassic/AtlasLootClassic.toc",
	},
	Collections = {
		"AtlasLootClassic_Collections/AtlasLootClassic_Collections.toc",
	},
	Crafting = {
		"AtlasLootClassic_Crafting/AtlasLootClassic_Crafting.toc",
	},
	DungeonsAndRaids = {
		"AtlasLootClassic_DungeonsAndRaids/AtlasLootClassic_DungeonsAndRaids.toc",
	},
	PvP = {
		"AtlasLootClassic_PvP/AtlasLootClassic_PvP.toc",
	},
	Options = {
		"AtlasLootClassic_Options/AtlasLootClassic_Options.toc",
	},
}

-- Ignore Files / Pathes
local IGNORE_LIST = {
	["AtlasLootClassic/Locales/"] = true,
	["AtlasLootClassic/Libs"] = true,
	["AtlasLootClassic_Options/Libs"] = true,
}
-- ################################
-- Script part, no changes here
-- ################################
local gmatch, sub, format, lower, gsub, match, byte = string.gmatch, string.sub, string.format, string.lower, string.gsub, string.match, string.byte
local unpack = table.unpack or unpack
local io_lines = io.lines

assert(not BASE_NAMESPACE or (type(BASE_NAMESPACE) == "string"), "BASE_NAMESPACE must be a string")
assert(not BASE_NAMESPACE or (FILE_LIST[BASE_NAMESPACE]), "BASE_NAMESPACE not found in FILE_LIST")
assert(not BASE_NAMESPACE or (#FILE_LIST[BASE_NAMESPACE] > 0), "BASE_NAMESPACE must contain at least one entry in FILE_LIST")

local FILE_IDENTIFIERS = {
	["lua"] = true,
	["xml"] = true,
	["toc"] = true,
}
local FILE_CONTAINS_LOCALE = {
	["lua"] = true,
}
local FILE_IDENTIFIERS_MAX_SIZE = 0
for k,v in pairs(FILE_IDENTIFIERS) do
	if FILE_IDENTIFIERS_MAX_SIZE < #k then FILE_IDENTIFIERS_MAX_SIZE = #k end
end
local IDENTIFIER_SIZE = #IDENTIFIER

local LogTable = {}
local DuplicateProtection = {}

local LogTypes = {
	[0] = "Info",
	[1] = "Warning",
	[2] = "Error",
	[99] = "Result",
}
local function AddLog(type, msg)
	if not LOG or type < LOG_LVL then return end
	LogTable[#LogTable+1] = "["..os.date('%Y-%m-%d %H:%M:%S').."] "..LogTypes[type]..": "..msg
end

local function FileExists(fileName)
	local f = io.open(fileName, "rb")
	if f then f:close() end
	return f ~= nil
end

local function AddIntoITable(d, s)
	if not s or not d then return end
	DuplicateProtection[d] = DuplicateProtection[d] or {}
	if type(s) == "table" then
		for k,v in ipairs(s) do
			if not DuplicateProtection[d][v] then
				d[#d+1] = v
				DuplicateProtection[d][v] = #d
			end
		end
	else
		if not DuplicateProtection[d][s] then
			d[#d+1] = s
			DuplicateProtection[d][s] = #d
		end
	end
end

-- path, file, fileType
local SplitCache = {}
local function SplitPathAndFileName(fileName)
	assert(fileName, "fileName not found: "..(fileName or "nil"))
	if SplitCache[fileName] then
		return unpack(SplitCache[fileName])
	end
	local path, file, fileType = ""

	local tmp, lastC = "", ""
	local count = 0
	for c in gmatch(fileName, ".") do
		count = count + 1
		if count >= (#fileName-FILE_IDENTIFIERS_MAX_SIZE-1) and c == "." then
			if not file then
				file, tmp, c = tmp, "", ""
			end
		elseif c == "\\" or c == "/" then
			if lastC ~= "/" and lastC ~= "" then
				c = "/"
			else
				c = ""
			end
		elseif lastC == "/" or lastC == "" then
			path, tmp = path..tmp, ""
		end
		tmp = tmp..c
		lastC = c
	end
	if FILE_IDENTIFIERS[lower(tmp)] then
		fileType = tmp
	else
		for i = 1, #tmp do
			local s = sub(path, i, #tmp)
			if FILE_IDENTIFIERS[lower(s)] then
				fileType = s
				break
			end
		end
	end
	if not fileType then
		if file then
			file = file..tmp
		else
			path = path..tmp
		end
	end
	SplitCache[fileName] = { path, file, fileType, true }
	if path and file and fileType then SplitCache[fileName][4] = format("%s%s.%s", path, file, fileType)
	elseif path and file then SplitCache[fileName][4] = format("%s%s", path, file)
	elseif path then SplitCache[fileName][4] = path end
	return unpack(SplitCache[fileName])
end

local function IsOnIgnoreList(fileName)
	if not fileName then return end
	local path, file, fileType, fileNameNew = SplitPathAndFileName(fileName)
	if IGNORE_LIST[fileNameNew] then return true end
	for k,v in pairs(IGNORE_LIST) do
		local p, f, fT, fN = SplitPathAndFileName(k)
		if match(fileNameNew, fN) then
			return true
		end
	end
end

local function ParseLuaFile(fileName)
	if not FileExists(fileName) then return end
	local _
	_, _, _, fileName = SplitPathAndFileName(fileName)
	if IsOnIgnoreList(fileName) then return end
	local t = {}

	local isComment, commentCount = false, 0
	local oneLineCom, multiComment, multiComReg = false, false, nil
	local tmp, loc, start, lastC = ""
	for line in io_lines(fileName) do
		for c in gmatch(line, ".") do
			if oneLineCom or multiComment then
				if oneLineCom and not tmp and lastC == "-" and c=="[" then
					oneLineCom = c
				elseif type(oneLineCom) == "string" and not tmp and (lastC=="=" or lastC=="[") and (c=="=" or c=="[") then
					oneLineCom = oneLineCom..c
				elseif multiComment and not tmp and lastC == "]" and ( c == "]" or c == "=" ) then
					tmp = "]"..c
				elseif multiComment and tmp and (c=="=" or c=="]") then
					tmp = tmp..c
				else
					--tmp = nil
				end
				if type(oneLineCom) == "string" and #oneLineCom > 1 and not tmp and lastC=="[" and (c~="=" or c~="[") then
					multiComReg = gsub(oneLineCom, "%[", "]")
					multiComment, oneLineCom = true, false
				elseif multiComment and tmp and multiComReg == tmp then
					multiComment, multiComReg, tmp = false, nil, ""
				end
			end
			if not oneLineCom and not multiComment then
				if tmp == IDENTIFIER and c == "[" then
					start = true
				elseif start and c == "\"" and not loc then --start
					loc = ""
				elseif loc and start and c == "\"" and lastC ~= "\\" then
					AddIntoITable(t, loc)
					loc, start, tmp = nil, false, ""
				elseif loc and start then
					loc = loc..c
				elseif c == "-" and lastC == "-" then
					oneLineCom, tmp = true, nil
				end
				if oneLineCom then

				elseif #tmp == IDENTIFIER_SIZE then
					tmp = sub(tmp..c, 2, IDENTIFIER_SIZE+1)
				else
					tmp = tmp..c
				end
			end
			lastC = c
		end
		if oneLineCom then
			oneLineCom, tmp = false, ""
		end
	end
	if #t < 1 then AddLog(0, "No match inside "..fileName) end
	return t
end

local function ParseXMLFile(fileName, overrideParseXML)
	if not FileExists(fileName) then return end
	local oriPath, _
	oriPath, _, _, fileName = SplitPathAndFileName(fileName)
	local t = {}

	local isComment, commentCount, waiteForFile, start = false, 0, false, false
	local tmp, lastC = ""
	for line in io_lines(fileName) do
		for c in gmatch(line, ".") do
			if tmp == "!--" then
				isComment, commentCount, tmp = true, commentCount+1, ""
			end
			if isComment then
				if c == "-" and lastC ~= "-" then
					tmp = "-"
				elseif c == "-" and lastC == "-" and #tmp<2 then
					tmp = tmp..c
				elseif c == ">" and tmp == "--" then
					commentCount = commentCount - 1
					isComment = commentCount > 0 and true or false
				elseif c ~= "-" and lastC ~= "-" then
					tmp = ""
				end
			else
				local lTmp = lower(tmp)
				if start then
					if c == "\"" and lastC ~= "\\" then
						start = false
						tmp = oriPath..tmp
						local path, file, fileType, tmp = SplitPathAndFileName(tmp)
						if path and file and fileType and FILE_CONTAINS_LOCALE[fileType] then
							AddIntoITable(t, tmp)
						elseif fileType and lower(fileType) == "xml" and ( overrideParseXML or PARSE_XML ) then
							AddIntoITable(t, ParseXMLFile(tmp))
						end
					end
				elseif lastC == "<" then
					tmp = ""
				elseif c == ">" then
					tmp, waiteForFile = "", false
				elseif lower(lTmp) == "script" or lower(lTmp) == "include" then
					waiteForFile = true
				elseif lower(lTmp) == "scripts" then
					waiteForFile = false
				elseif waiteForFile and ( lTmp == "file" or lTmp == "file=") and c == " " then
					c = ""
				elseif waiteForFile and lTmp == "file=" and c == "\"" then
					start, tmp, c = true, "", ""
				elseif lower(c) == "f" and waiteForFile then
					tmp = ""
				end
				if c ~= "<" then tmp=tmp..c end
			end

			lastC = c
		end
	end
	if #t < 1 then AddLog(1, "No file or file with record loaded inside "..fileName) end
	return t
end

local function ParseTocFile(fileName, overrideParseXML)
	assert(FileExists(fileName), "Toc File not found: "..(fileName or "nil"))
	local oriPath, _
	oriPath, _, _, fileName = SplitPathAndFileName(fileName)
	local t = {}

	for line in io_lines(fileName) do
		local s = ""
		for c in gmatch(line, ".") do
			if c == "#" then break end
			s = s..c
		end
		if #s > 0 then
			s = oriPath..s
			local path, file, fileType, s = SplitPathAndFileName(s)
			if path and file and fileType and FILE_CONTAINS_LOCALE[fileType] then
				AddIntoITable(t, s)
			elseif fileType and lower(fileType) == "xml" and ( overrideParseXML or PARSE_XML ) then
				AddIntoITable(t, ParseXMLFile(s))
			end
		end
	end
	if #t < 1 then AddLog(1, "No file or file with record loaded inside "..fileName) end
	return t
end

local function ParseNamespace(namespace)
	if not namespace or not FILE_LIST[namespace] then return end
	local t = {}
	for _, pathG in ipairs(FILE_LIST[namespace]) do
		local overrideParseXML
		if type(pathG) == "table" then
			overrideParseXML = pathG[2]
			pathG = pathG[1]
		end
		local path, file, fileType, fullPath = SplitPathAndFileName(pathG)
		if not IsOnIgnoreList(fullPath) then
			if path and file and fileType and FILE_CONTAINS_LOCALE[fileType] then
				AddIntoITable(t, fullPath)
			elseif fileType and lower(fileType) == "toc" then
				AddIntoITable(t, ParseTocFile(fullPath, overrideParseXML))
			elseif fileType and lower(fileType) == "xml" and ( overrideParseXML or PARSE_XML ) then
				AddIntoITable(t, ParseXMLFile(fullPath))
			end
		end
	end
	return t
end

local function Finalize_Rebase(t)
	if not REBASE_LOCALES or not BASE_NAMESPACE then return end
	local usage = {}
	for namespace, nsT in pairs(t) do
		if namespace ~= BASE_NAMESPACE then
			for _, loc in ipairs(nsT) do
				if not usage[loc] then usage[loc] = {} end
				usage[loc][#usage[loc]+1] = { namespace }
			end
		end
	end
	for loc,locT in pairs(usage) do
		if #locT > 1 then
			AddIntoITable(t[BASE_NAMESPACE], loc)
		end
	end
end

local function Finalize_Build(t1, t2)
	if not t1 then return end
	if t2 and t1 ~= t2 then
		local tR = {}
		for k,v in ipairs(t1) do
			if DuplicateProtection[t2][v] then
				AddLog(1, IDENTIFIER.."[\""..v.."\"] found dublicate.")
				tR[#tR+1] = k
			end
		end
		for i = #tR, 1, -1 do table.remove(t1, tR[i]) end
	end
	table.sort(t1)
end

local function BuildFileList()
	local t = {}
	if BASE_NAMESPACE then
		t[BASE_NAMESPACE] = ParseNamespace(BASE_NAMESPACE)
	end
	for namespace, nt in pairs(FILE_LIST) do
		if namespace ~= BASE_NAMESPACE then
			t[namespace] = ParseNamespace(namespace)
		end
	end
	return t
end

local function BuildLocaleList(fileList)
	if not fileList then return end
	local t = {}
	for ns,nst in pairs(fileList) do
		t[ns] = {}
		for k,v in ipairs(nst) do
			AddIntoITable(t[ns], ParseLuaFile(v))
		end
	end
	return t
end

local function getJsonFormattedString(s)
    s = string.gsub(s, "<", "\\f<\\f")
    s = string.gsub(s, ">", "\\f>\\f")
    return s
end

local function Finalize(t)
	Finalize_Rebase(t)
	local base = BASE_NAMESPACE and t[BASE_NAMESPACE] or nil
	local c = 0
	for namespace, nsT in pairs(t) do
		Finalize_Build(nsT, base)
		if #nsT > 0 then
			local nsFfile = io.open(OUTPUT_PATH..namespace..".lua", "w+")
			for _,loc in ipairs(nsT) do
				nsFfile:write(format(IDENTIFIER.."[\"%s\"] = true\n", getJsonFormattedString(loc)))
				c = c + 1
			end
			AddLog(99,"Created namespace:"..namespace.." <"..#nsT..">")
			nsFfile:close()
		end
	end
	return c
end



-- ################################
-- Build
-- ################################
local FileList = BuildFileList()
local Locales = BuildLocaleList(FileList)
local LocCount = Finalize(Locales)

if LOG then
	local logFile = io.open(OUTPUT_PATH.."log.txt" , "w+")
	io.output(logFile)
	io.write(table.concat(LogTable, "\n"))
	io.close(logFile)
end

print("--- FINISHED <"..LocCount.." locales> ---")