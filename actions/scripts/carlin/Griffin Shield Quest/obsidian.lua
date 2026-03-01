-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Obsidian lance chest
-- Notes: storage cleanup
-- Changes: English messages, modern API

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 9000 then
        return true
    end

    if player:getStorageValue(9000) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found an obsidian lance.")
        player:addItem(2425, 1)
        player:setStorageValue(9000, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
    end

    return true
end

