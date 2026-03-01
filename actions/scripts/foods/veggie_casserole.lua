-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Veggie Casserole
-- Notes: modern Food API, condition updated
-- Changes: removed SPECIAL_FOODS, migrated condition system

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 150)

function onUse(player, item, fromPosition, target, toPosition)
    local food = Food.getFood(item.itemid)
    if not food then
        return false
    end

    if not player:addCondition(condition) then
        return true
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER_SAY)
    return true
end

