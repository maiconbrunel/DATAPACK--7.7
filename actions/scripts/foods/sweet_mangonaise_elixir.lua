-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

local config = {
	amount = 10
}
function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	local ring = getPlayerSlotItem(player, CONST_SLOT_RING)
	if(food == nil) then
		return false
	end

	if(ring.itemid == 0) then
		player:sendTextMessage, MESSAGE_STATUS_SMALL, "You may want to equip a ring before eating this.")
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		return true
	end

	if(getItemInfo(ring.itemid).showDuration) then
		local capRequired, pFreeCap = (getItemInfo(ring.itemid).weight * config.amount), getPlayerFreeCap(player)

		if(pFreeCap < capRequired) then
			player:sendTextMessage, MESSAGE_STATUS_SMALL, "You may want to free some capacity before doing this.")
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			return true
		end

		for i=1, config.amount do
			doPlayerAddItemEx(player, doCopyItem(ring).uid, true)
		end
	else
		player:sendTextMessage, MESSAGE_STATUS_SMALL, "You may want to equip the correct type of ring before eating this.")
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		return true
	end

	doRemoveItem(item.uid, 1)
	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
