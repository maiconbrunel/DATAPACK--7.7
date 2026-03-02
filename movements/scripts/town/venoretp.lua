-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Level-based teleport on step-in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
    return true
    end

    if player:getLevel() < 20000 then
        local newPos = Position(position.x, position.y, position.z + 1)
        player:teleportTo(newPos)
        newPos:sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:sendCancelMessage("")
            end

            return true
            end
