-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door/Window interaction
-- Notes: Auto-converted

-- By Ricky Mesny
-- http://otfans.net/showthread.php?t=96955

function onUse(player, item, fromPosition, target, toPosition)
-- Validate house tile
local house = House.getHouseByPosition(fromPosition)
if not house then
	return false
	end

	-- Transform window
	item:transform(item.itemid - 2)
	return true
	end
