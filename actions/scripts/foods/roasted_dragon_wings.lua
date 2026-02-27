-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60 * 60 * 1000)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, 10)

function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	if(not doAddCondition(player, condition)) then
		return true
	end

	doRemoveItem(item.uid, 1)
	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
