-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Candy ball random buff
-- Notes: modern Conditions, random attributes
-- Changes: player API

local condition = {}

local conditions = {
    CONDITION_ATTRIBUTES,
    CONDITION_HASTE,
    CONDITION_LIGHT,
    CONDITION_INVISIBLE
}

local attributes = {
    CONDITION_PARAM_SKILL_SHIELD,
    CONDITION_PARAM_SKILL_DISTANCE,
    CONDITION_PARAM_SKILL_MELEE,
    CONDITION_PARAM_STAT_MAGICLEVEL
}

condition[CONDITION_HASTE] = Condition(CONDITION_HASTE)
condition[CONDITION_HASTE]:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
condition[CONDITION_HASTE]:setParameter(CONDITION_PARAM_SUBID, 2)
condition[CONDITION_HASTE]:setParameter(CONDITION_PARAM_SPEED, 60)

condition[CONDITION_ATTRIBUTES] = Condition(CONDITION_ATTRIBUTES)
condition[CONDITION_ATTRIBUTES]:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)

condition[CONDITION_LIGHT] = Condition(CONDITION_LIGHT)
condition[CONDITION_LIGHT]:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 9)
condition[CONDITION_LIGHT]:setParameter(CONDITION_PARAM_LIGHT_COLOR, 215)
condition[CONDITION_LIGHT]:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)

condition[CONDITION_INVISIBLE] = Condition(CONDITION_INVISIBLE)
condition[CONDITION_INVISIBLE]:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if food == nil then
        return false
    end

    local randomCondition = conditions[math.random(#conditions)]

    if randomCondition == CONDITION_ATTRIBUTES then
        condition[CONDITION_ATTRIBUTES]:setParameter(
            attributes[math.random(#attributes)],
            math.random(3, 15)
        )
    end

    if not player:addCondition(condition[randomCondition]) then
        return true
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER)
    return true
end

