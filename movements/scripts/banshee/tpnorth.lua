-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Level gate tile
-- Notes: Modern API, safe player validation, proper position handling

local REQUIRED_LEVEL = 20000

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Validate level requirement
	if player:getLevel() < REQUIRED_LEVEL then
		local backPosition = Position(position.x, position.y - 1, position.z)
		player:teleportTo(backPosition)
		backPosition:sendMagicEffect(CONST_ME_POFF)
		else
			player:sendCancelMessage("You need to be below level 20000 to enter.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end

			return true
			end
