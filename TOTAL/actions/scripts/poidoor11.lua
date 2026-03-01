-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 11
-- Notes: melhorias, atualizações da API, otimizações

local doorPos = Position(32828, 32240, 12)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

if item.uid == 2123 then
    local queststatus = player:getStorageValue(2122)

    if queststatus == 1 then
        player:teleportTo(doorPos)
        toPosition:sendMagicEffect(12)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must finish the first room before entering this one.")
    end
    return true
end

return true
end
