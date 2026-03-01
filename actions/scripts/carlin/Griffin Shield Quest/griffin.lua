-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Griffin Shield chest
-- Notes: modern API
-- Changes: English messages, fixed storage check

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 9001 then
        return true
    end

    if player:getStorageValue(9001) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a griffin shield.")
        player:addItem(2533, 1)
        player:setStorageValue(9001, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end

