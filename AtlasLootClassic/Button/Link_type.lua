local AtlasLoot = _G.AtlasLoot
local Link = AtlasLoot.Button:AddType("Link", "l")

local str_match = string.match

function Link.OnSet(button, second)
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.Link = button.__atlaslootinfo.secType[2]
		button.secButton.Name = button.__atlaslootinfo.Name
		button.secButton.Description = button.__atlaslootinfo.Description
	else
		button.Link = button.__atlaslootinfo.type[2]
		button.Name = button.__atlaslootinfo.Name
		button.Description = button.__atlaslootinfo.Description
	end
end

function Link.OnClear(button)
	button.Link = nil
	button.Name = nil
	button.Description = nil
	button.secButton.Link = nil
	button.secButton.Name = nil
	button.secButton.Description = nil
end

function Link.OnMouseAction(button, mouseAction)
	AtlasLoot.ItemDB:Open(button.Link[1], button.Link[2], button.Link[3], button.Link[4])
end

function Link.GetStringContent(str)
	return {str_match(str, "([%w_-]+):(%w+):(%d+)")}
end
