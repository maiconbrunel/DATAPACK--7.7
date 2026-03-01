-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

local conditions = {
	CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY,
	CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN,
	CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED
}

function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	for _, condition in ipairs(conditions) do
		if(getCreatureCondition(player, condition)) then
			doRemoveCondition(player, condition)
		end
	end

	doRemoveItem(item.uid, 1)
	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
