-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player residence on step-in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid == 50105 then
		local newPos = Position(32957, 32076, 7)

		player:setTown(Town(4)) -- Venore
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Venore.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end

		return true
		end
