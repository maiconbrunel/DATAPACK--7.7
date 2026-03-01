-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Notify player of new mail
-- Notes: Simple mail notification system

function onMailReceive(cid, target, item, openBox)
	if openBox then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "New mail has arrived.")
	end

	return true
end
