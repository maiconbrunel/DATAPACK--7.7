-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 1
-- Notes: melhorias, atualizações da API, otimizações

local newtemple = Position(32820, 32242, 12)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

-- Tradução salva: todas mensagens ingame sempre em inglês.

if item.uid == 2113 then
    player:teleportTo(newtemple)
    newtemple:sendMagicEffect(10)
else
    player:sendCancelMessage("Wrong command.")
end

return true
end
