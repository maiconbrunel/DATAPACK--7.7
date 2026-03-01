-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Paradox Tower Key
-- Notes:
-- Changes:

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 8001 then
        return true
    end

    if player:getStorageValue(8001) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a key.")
        local key = player:addItem(2089, 1) -- key
        key:setActionId(3899)
        player:setStorageValue(8001, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end
