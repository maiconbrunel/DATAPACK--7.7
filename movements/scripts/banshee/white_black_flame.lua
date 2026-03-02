-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport player and set quest storages on step-in
-- Notes: Modern API, storage validation, safe player check

local TELEPORT_POS = Position(32273, 31849, 15)
local STORAGE_MAIN = 9017
local STORAGE_SECOND = 9170

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Validate actionid
	if item.actionid == 9017 then
		player:teleportTo(TELEPORT_POS)
		TELEPORT_POS:sendMagicEffect(CONST_ME_POFF)

		-- Set quest storages
		player:setStorageValue(STORAGE_MAIN, 1)
		player:setStorageValue(STORAGE_SECOND, 1)
		end

		return true
		end
