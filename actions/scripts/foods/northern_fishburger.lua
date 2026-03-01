-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Northern fishburger
-- Notes: Fishing skill boost
-- Changes: migrated to Condition() API

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_FISHING, 50)

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

