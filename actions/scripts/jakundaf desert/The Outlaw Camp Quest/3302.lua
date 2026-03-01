-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Copper Key 3302 Chest
-- Notes: English msg, API update, storage logic modernized

function onUse(player, item, fromPosition, target, toPosition)
	if item.actionid ~= 3302 then
		return true
	end

	if player:getStorageValue(3302) < 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a copper key 3302.")
		local key = player:addItem(2089, 1)
		if key then
			key:setActionId(3302)
		end
		player:setStorageValue(3302, 1)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
	end

	return true
end
