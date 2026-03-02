-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Town change on step-in tile
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 50107 then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		local newPos = Position(33213, 32454, 1)

		player:setTown(Town(7))
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Darashia.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
