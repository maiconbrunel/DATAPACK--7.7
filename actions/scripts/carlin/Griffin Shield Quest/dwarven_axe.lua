-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Griffin Shield dwarven axe chest
-- Notes: storage fix, English messages
-- Changes: API modernized

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 9002 then
        return true
    end

    if player:getStorageValue(9002) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a dwarven axe.")
        player:addItem(2435, 1)
        player:setStorageValue(9002, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end

