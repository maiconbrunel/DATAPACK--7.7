-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Rotworm stew
-- Notes: heals full health
-- Changes: migrated all cid/do functions

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if not food then
        return false
    end

    player:addHealth(player:getMaxHealth() - player:getHealth())
    item:remove(1)
    player:say(food, TALKTYPE_MONSTER)
    return true
end

