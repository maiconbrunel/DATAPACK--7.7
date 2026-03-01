-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Window interaction
-- Notes: Fixed transform call + modern API

function onUse(player, item, fromPosition, target, toPosition)
-- Validate house tile
local house = House.getHouseByPos(fromPosition)
if not house then
	return false
	end

	-- Transform window
	item:transform(item.itemid + 2)

	return true
	end
