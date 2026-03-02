-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Level restriction on step-in tile
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if player:getLevel() < 2 then
		player:sendCancelMessage("Only players with level 2 or higher may pass.")

		local backPos = Position(position.x, position.y + 2, position.z)
		player:teleportTo(backPos)
		backPos:sendMagicEffect(CONST_ME_POFF)
		else
			player:sendCancelMessage("")
			end

			return true
			end
