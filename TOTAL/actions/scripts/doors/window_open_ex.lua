-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Window interaction (house check)
-- Notes: Auto-converted & fixed

function onUse(player, item, fromPosition, target, toPosition)
-- Validate house tile
if not House.getHouseByPos(fromPosition) then
	return false
	end

	-- Transform window
	item:transform(item.itemid + 1145)

	return true
	end
