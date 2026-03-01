-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Jalapeño haste food
-- Notes: modern Condition API
-- Changes: English msgs, cleaned logic

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SPEED, 40)

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if food == nil then
        return false
    end

    if not player:addCondition(condition) then
        return true
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER)
    return true
end

