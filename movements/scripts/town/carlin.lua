-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Change player's residence on step-in tile
-- Notes: melhorias, atualizações da API, otimizações

local NEW_TOWN_ID = 5 -- Carlin
local NEW_POS = Position(32360, 31782, 7)

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 50102 then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		player:setTown(NEW_TOWN_ID)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Carlin")
		player:teleportTo(NEW_POS)
		NEW_POS:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
