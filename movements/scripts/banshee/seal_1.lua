-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: First seal teleport + spawns
-- Notes: Modern API, storages fixed, safe player checks

local TELEPORT_POS = Position(32266, 31849, 15)
local SPAWN_1 = Position(32274, 31902, 13)
local SPAWN_2 = Position(32274, 31904, 13)
local SPAWN_3 = Position(32276, 31902, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9008 then
		return true
		end

		local questStatus = player:getStorageValue(9008)
		if questStatus == -1 then
			position:sendMagicEffect(CONST_ME_BLOCKHIT)
			player:teleportTo(TELEPORT_POS)
			TELEPORT_POS:sendMagicEffect(CONST_ME_POFF)

			player:setStorageValue(9008, 1)
			player:setStorageValue(9800, 1)

			Game.createMonster("Ghost", SPAWN_1)
			Game.createMonster("Ghost", SPAWN_2)
			Game.createMonster("Demon Skeleton", SPAWN_3)

			return true
			end

			player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did the first seal.")
			return true
			end
