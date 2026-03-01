-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Blood herb collection
-- Notes: Fixed storage check and item reward

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 4500 then
		local questStatus = getPlayerStorageValue(cid, 4500)
		if questStatus == -1 then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found a blood herb.")
			doPlayerAddItem(cid, 2798, 10)
			setPlayerStorageValue(cid, 4500, 1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
		end
	end

	return true
end
