-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player residence on step-in tile
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 50108 then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		local newPos = Position(33195, 32853, 8)

		player:setTown(6) -- Ankrahmun
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Ankrahmun.")
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
