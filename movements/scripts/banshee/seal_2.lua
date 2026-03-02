-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Switch combination teleport quest
-- Notes: Modern API, storage fix, tile checks, safe logic

local TARGET_POS = Position(32261, 31856, 15)
local SWITCH_POS = {
	Position(32310, 31975, 13),
	Position(32310, 31976, 13),
	Position(32312, 31975, 13),
	Position(32312, 31975, 13),
	Position(32314, 31975, 13),
	Position(32314, 31975, 13)
}

local SWITCH_PATTERN = {
	1946, 1946, 1946, 1946, 1945, 1945
}

local STORAGE_MAIN = 9009
local STORAGE_SECOND = 9900

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9009 then
		return true
		end

		-- Validate switch combination
		for i = 1, 6 do
			local tile = Tile(SWITCH_POS[i])
			if not tile then
				return true
				end
				if not tile:getItemById(SWITCH_PATTERN[i]) then
					return true
					end
					end

					-- Storage check
					if player:getStorageValue(STORAGE_MAIN) <= 0 then
						position:sendMagicEffect(CONST_ME_TELEPORT)
						player:teleportTo(TARGET_POS)
						TARGET_POS:sendMagicEffect(CONST_ME_TELEPORT)
						player:setStorageValue(STORAGE_MAIN, 1)
						player:setStorageValue(STORAGE_SECOND, 1)
						else
							player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did this seal.")
							end

							return true
							end
