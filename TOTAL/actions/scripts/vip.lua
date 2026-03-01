-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: VIP activation
-- Notes: translated message, modernized API, added summary comments

function onUse(cid, item, frompos, item2, topos)
	if item2.itemid == 2345 then
		-- Grant VIP
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Congratulations, you are now a VIP member!")
		setPlayerStorageValue(cid, 30009, 1)

		-- Add premium days
		doPlayerAddPremiumDays(cid, 7)

		-- Remove used item
		doRemoveItem(item.uid, 1)
	end

	return true
end
