-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Hydra tongue salad
-- Notes: Clean conditions using new API
-- Changes: getCreatureCondition → player:hasCondition

local conditions = {
    CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY,
    CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN,
    CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED
}

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if not food then
        return false
    end

    for _, c in ipairs(conditions) do
        if player:hasCondition(c) then
            player:removeCondition(c)
        end
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER)
    return true
end

