-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Set text on readable items
-- Notes: Corrected text assignment for multiple parameters

local TEXTS = {
	[1957] = {"*You see a map of the surface of the Fields of Glory. There are many red lines and two golden points on it. You wonder what their meaning is.*"},
	[7722] = {"Fishing Master Certificate\n\nAwarded to Santiago Fuentes by the Tibian Fishing Association TFA."},
	[10122] = {
		"Set the sails to the carved tree\nthe head of a dragon south shall it be\n34 feet in the line to the west\nthe next one goes under arrest\nthe master's secret must be revealed\nto open the path that once were sealed",
		"A Pirate"
	}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local text = TEXTS[item.itemid]
	if not text then
		return false
	end

	local content = text[1] or ""
	local author = text[2] or ""
	local typeText = text[3] or ""

	doSetItemText(item.uid, content, author, typeText)
	return false
end
