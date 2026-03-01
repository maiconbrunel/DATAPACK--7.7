-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Carrot cake +distance skill
-- Notes: migrated to Condition API
-- Changes: modern player: APIs

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 10)

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

