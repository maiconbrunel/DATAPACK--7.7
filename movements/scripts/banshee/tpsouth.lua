-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Level gate teleport restriction
-- Notes: Modern API, safe teleport handling, real tile fallback

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Level check
	if player:getLevel() < 20000 then
		-- Push player back (real Tibia behavior)
		player:teleportTo(fromPosition, true)
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		else
			-- Empty cancel replaced with proper message
			player:sendCancelMessage("You are not allowed to enter this area.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end

			return true
			end
