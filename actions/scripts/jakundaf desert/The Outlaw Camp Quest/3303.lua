-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Copper Key 3303 Chest
-- Notes: English text, API fix
-- Changes: storage logic modernized

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 3303 then
        return true
    end

    if player:getStorageValue(3303) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a copper key 3303.")
        local key = player:addItem(2089, 1)
        if key then
            key:setActionId(3303)
        end
        player:setStorageValue(3303, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end
