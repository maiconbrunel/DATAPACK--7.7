-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player residence when stepping in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 50109 then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		local newPos = Position(32595, 32745, 7)
		player:setTown(8)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Port Hope.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
