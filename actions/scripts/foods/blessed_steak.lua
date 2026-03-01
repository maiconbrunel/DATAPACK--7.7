-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Blessed steak full mana restore
-- Notes: SPECIAL_FOODS preserved
-- Changes: player API, English messages, remove deprecated

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if food == nil then
        return false
    end

    player:addMana(player:getMaxMana() - player:getMana())
    item:remove(1)

    player:say(food, TALKTYPE_MONSTER)
    return true
end

