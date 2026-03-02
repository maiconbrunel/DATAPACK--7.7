-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player's hometown when stepping on tile
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid > 30020 and item.actionid < 30100 then
		local townId = item.actionid - 30020
		player:setTown(townId)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You are the newest resident of " .. Town(townId):getName() .. ".")
		end

		return true
		end
