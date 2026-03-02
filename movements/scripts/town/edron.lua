-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player residence on step-in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
if item.actionid == 50106 then
	local player = creature:getPlayer()
	if not player then
		return true
		end

		local newPos = Position(33217, 31814, 8)
		player:setTown(Town(9))
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Edron.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)
		return true
		end
		end
