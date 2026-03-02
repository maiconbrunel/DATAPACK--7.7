-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Premium-only step-in restriction
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if not player:isPremium() then
		position:sendMagicEffect(CONST_ME_HITAREA)

		local newPos = Position(position.x + 2, position.y, position.z)
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		else
			player:sendCancelMessage("Only premium players can enter.")
			end

			return true
			end
