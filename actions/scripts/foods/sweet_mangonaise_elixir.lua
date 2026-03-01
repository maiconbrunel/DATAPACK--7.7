-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Sweet Mangonaise Elixir
-- Notes: modern Food API, ring duplication check, English messages
-- Changes: removed SPECIAL_FOODS, migrated API, fixed weight logic

local config = { amount = 10 }

function onUse(player, item, fromPosition, target, toPosition)
    local food = Food.getFood(item.itemid)
    if not food then
        return false
    end

    local ring = player:getSlotItem(CONST_SLOT_RING)
    if not ring then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You may want to equip a ring before eating this.")
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local info = ItemType(ring.itemid)
    if info:showDuration() then
        local capRequired = info:getWeight() * config.amount
        local freeCap = player:getFreeCapacity()

        if freeCap < capRequired then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "You may want to free some capacity before doing this.")
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end

        for i = 1, config.amount do
            player:addItem(ring.itemid, 1)
        end
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You may want to equip the correct type of ring before eating this.")
        fromPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    item:remove(1)
    player:say(food, TALKTYPE_MONSTER_SAY)
    return true
end

