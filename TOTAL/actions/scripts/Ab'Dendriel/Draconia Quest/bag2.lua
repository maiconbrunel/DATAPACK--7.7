-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (bag)
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, ID comments, structure cleanup

local STORAGE = 9510

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() ~= STORAGE then
        return false
    end

    if player:getStorageValue(STORAGE) <= 0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

        local bag = player:addItem(1987, 1) -- Bag (1987)
        if bag then
            bag:addItem(2197, 1) -- Stone Skin Amulet (2197)
            bag:addItem(2167, 1) -- Energy Ring (2167)
        end

        player:setStorageValue(STORAGE, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
    end

    return true
end

