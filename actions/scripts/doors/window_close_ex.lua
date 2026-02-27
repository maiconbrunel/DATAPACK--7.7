-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Window close (house check)
-- Notes: Fixed syntax, API, and fromPosition usage

function onUse(player, item, fromPosition, target, toPosition)
-- Validate house position
local house = House.getHouseByPos(fromPosition)
if not house then
	return false
	end

	-- Transform window to closed state
	item:transform(item.itemid - 1145)

	return true
	end
