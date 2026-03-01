-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	doCreatureAddMana(player, getCreatureMaxMana(player) - getCreatureMana(player))
	doRemoveItem(item.uid, 1)

	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
