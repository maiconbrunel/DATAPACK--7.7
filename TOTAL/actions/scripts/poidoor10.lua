-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 10
-- Notes: melhorias, atualizações da API, otimizações

local telepos = Position(1023, 1422, 13)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

if item.uid == 2122 then
    local queststatus = player:getStorageValue(2122)

    if queststatus == 1 then
        player:teleportTo(telepos)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sit on the throne to complete this room.")
        toPosition:sendMagicEffect(12)
        player:setStorageValue(2122, 1)
        player:teleportTo(telepos)
    end
    return true
end

return true
end
