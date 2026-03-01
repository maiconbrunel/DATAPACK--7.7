-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Quest item – Crown Shield
-- Notes: Fixed storage check and reward delivery

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 4503 then
		local questStatus = getPlayerStorageValue(cid, 4503)
		if questStatus == -1 then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found a crown shield.")
			doPlayerAddItem(cid, 2519, 1)
			setPlayerStorageValue(cid, 4503, 1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
		end
	end

	return true
end
