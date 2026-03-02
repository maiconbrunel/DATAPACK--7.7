-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player hometown when stepping on tile
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
if item.actionid == 50104 then
	local player = creature:getPlayer()
	if not player then
		return true
		end

		local newPos = Position(32649, 31925, 11)

		player:setTown(Town(2))
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Kazordoon.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
		end
