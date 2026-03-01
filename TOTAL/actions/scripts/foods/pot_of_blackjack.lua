-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

local config = {
	MSG_EAT = "You take a gulp from the large bowl, but there's still some blackjack in it.",
	MSG_GONE = "You take the last gulp from the large bowl. No leftovers!"
}

function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	local addHealth = getCreatureMaxHealth(player) - getCreatureHealth(player)

	if(item.actionid < 3500) then
		doSetItemActionId(item.uid, 3500)
		if(addHealth > 0) then
			doCreatureAddHealth(player, addHealth)
		end
		player:sendTextMessage, MESSAGE_STATUS_DEFAULT, config.MSG_EAT)

	elseif(item.actionid >= 3500 and item.actionid <= 3501) then
		doSetItemActionId(item.uid, item.actionid + 1)
		if(addHealth > 0) then
			doCreatureAddHealth(player, addHealth)
		end
		player:sendTextMessage, MESSAGE_STATUS_DEFAULT, config.MSG_EAT)

	elseif(item.actionid == 3502) then
		doSetItemActionId(item.uid, item.actionid + 1)
		if(addHealth > 0) then
			doCreatureAddHealth(player, addHealth)
		end
		player:sendTextMessage, MESSAGE_STATUS_DEFAULT, config.MSG_GONE)
		doRemoveItem(item.uid, 1)
	end

	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
