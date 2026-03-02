-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Town change + teleport on step-in tile
-- Notes: melhorias, atualizações da API, otimizações

local NEW_POS = Position(32732, 31634, 7)
local TOWN_ID = 1 -- Ab'Dendriel

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 50103 then
	return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
		end

		player:setTown(TOWN_ID)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your residence to Ab'Dendriel.")

		player:teleportTo(NEW_POS)
		NEW_POS:sendMagicEffect(CONST_ME_TELEPORT)

		return true
		end
