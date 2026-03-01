-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Copper Key 3301 Chest
-- Notes: storage fix, English text, modern API

function onUse(player, item, fromPosition, target, toPosition)
	if item.actionid ~= 3301 then
		return true
	end

	if player:getStorageValue(3301) < 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a copper key 3301.")
		local key = player:addItem(2089, 1) -- Copper Key
		key:setActionId(3301)
		player:setStorageValue(3301, 1)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
	end

	return true
end
