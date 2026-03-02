-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Seal teleport with splash check and storage validation
-- Notes: Modern API, bug fixes, duplicate removal, real Tibia behavior

local SPLASH_POS = Position(32243, 31892, 14)
local TELEPORT_POS = Position(32261, 31849, 15)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9011 then
		return true
		end

		local tile = Tile(SPLASH_POS)
		if not tile then
			return true
			end

			local splashItem = tile:getItemById(2025) -- Fluid Splash
			if not splashItem then
				return true
				end

				-- Validate quest storage
				if player:getStorageValue(9009) == -1 then
					player:teleportTo(TELEPORT_POS)
					TELEPORT_POS:sendMagicEffect(CONST_ME_TELEPORT)
					SPLASH_POS:sendMagicEffect(CONST_ME_MAGIC_RED)

					splashItem:remove(1)

					player:setStorageValue(9011, 1)
					player:setStorageValue(9110, 1)
					else
						local kickPos = Position(position.x - 2, position.y, position.z)
						player:teleportTo(kickPos)
						kickPos:sendMagicEffect(CONST_ME_POFF)
						player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did this seal.")
						end

						return true
						end
