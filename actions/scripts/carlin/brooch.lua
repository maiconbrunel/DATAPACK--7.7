-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Carlin family brooch chest
-- Notes: Updated API, English message
-- Changes: modern storage logic

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 9025 then
        return true
    end

    if player:getStorageValue(9025) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a family brooch.")
        player:addItem(2318, 1)
        player:setStorageValue(9025, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end

