-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (bag)
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, added item IDs, standardized checks

function onUse(player, item, fromPosition, target, toPosition)
    if item:getActionId() ~= 9509 then
        return false
    end

    local storage = 9509
    if player:getStorageValue(storage) > 0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
        return true
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

    local bag = player:addItem(1987, 1) -- Bag (1987)
    if bag then
        bag:addItem(2396, 1) -- Fire Sword (2396)
        bag:addItem(2409, 1) -- Serpent Sword (2409)
    end

    player:setStorageValue(storage, 1)
    return true
end

