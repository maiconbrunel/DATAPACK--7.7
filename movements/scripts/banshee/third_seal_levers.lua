-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Seal step-in teleport with switch validation
-- Notes: Modern API, safe tile checks, real Tibia behavior

local SWITCH_POSITIONS = {
	Position(32220, 31842, 15),
	Position(32220, 31843, 15),
	Position(32220, 31844, 15),
	Position(32220, 31845, 15),
	Position(32220, 31846, 15)
}

local FLAME_POS = Position(32273, 31856, 15)

local SEAL_STORAGE = 9018
local ACCESS_STORAGE = 9180

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9018 then
		return true
		end

		-- Validate all switches (1946 = lever ON)
		for i = 1, #SWITCH_POSITIONS do
			local tile = Tile(SWITCH_POSITIONS[i])
			if not tile then
				return true
				end

				local lever = tile:getItemById(1946) -- Lever (ON state)
				if not lever then
					return true
					end
					end

					-- First-time reward check
					if player:getStorageValue(SEAL_STORAGE) < 1 then
						player:teleportTo(FLAME_POS)
						player:setStorageValue(SEAL_STORAGE, 1)
						player:setStorageValue(ACCESS_STORAGE, 1)
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
						return false
						end

						-- Already completed
						local backPosition = Position(position.x, position.y - 2, position.z)
						player:teleportTo(backPosition)
						backPosition:sendMagicEffect(CONST_ME_POFF)
						player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did this seal.")
						return false
						end
