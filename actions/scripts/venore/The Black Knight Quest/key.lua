-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Silver Key quest reward
-- Notes: Fixed storage check and reward logic

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 4501 then
		local queststatus = getPlayerStorageValue(cid, 4501)
		if queststatus == -1 then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found a silver key.")
			doPlayerAddItem(cid, 2088, 1) -- silver key
			setPlayerStorageValue(cid, 4501, 1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
		end
	end

	return true
end
