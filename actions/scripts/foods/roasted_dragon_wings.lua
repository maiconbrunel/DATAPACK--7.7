-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Roasted dragon wings
-- Notes: Shielding boost
-- Changes: doAddCondition → player:addCondition

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 10)

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if not food then
        return false
    end

    if not player:addCondition(condition) then
        return true
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER)
    return true
end

