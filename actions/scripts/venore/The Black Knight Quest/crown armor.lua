-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Single item quest reward
-- Notes: Fixed storage check and item delivery

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 4502 then
		local questStatus = getPlayerStorageValue(cid, 4502)
		if questStatus == -1 then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found a crown armor.")
			doPlayerAddItem(cid, 2487, 1)
			setPlayerStorageValue(cid, 4502, 1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
		end
	end

	return true
end
