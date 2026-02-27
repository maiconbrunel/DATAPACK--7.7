-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door/Window interaction
-- Notes: Auto-converted (fix applied)

function onUse(player, item, fromPosition, target, toPosition)
if item.actionid == 0 then
	-- This is impossible to happen, but whatever.
	item:transform(item.itemid + 2)
	return true
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, "It is locked.")
	return true
	end
