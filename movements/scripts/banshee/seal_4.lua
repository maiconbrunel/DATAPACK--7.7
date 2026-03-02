-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Seal teleport with splash check
-- Notes: Modern API, fixed storage logic, safe tile checks

local SPLASH_POS = Position(32243, 31892, 14)
local TELEPORT_POS = Position(32261, 31849, 15)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Check Seal AID 9011
	if item.actionid == 9011 then
		local tile = Tile(SPLASH_POS)
		if tile then
			local splashItem = tile:getItemById(2025) -- splash vials
			if splashItem then
				local questStatus = player:getStorageValue(9009)

				-- First time doing the seal
				if questStatus <= 0 then
					player:teleportTo(TELEPORT_POS)
					player:setStorageValue(9011, 1)
					player:setStorageValue(9110, 1)
					splashItem:remove(1)
					SPLASH_POS:sendMagicEffect(CONST_ME_MAGIC_RED)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					else
						-- Already completed
						local backPos = Position(position.x - 2, position.y, position.z)
						player:teleportTo(backPos)
						backPos:sendMagicEffect(CONST_ME_POFF)
						player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did this seal.")
						end

						return false
						end
						end
						end

						return true
						end
