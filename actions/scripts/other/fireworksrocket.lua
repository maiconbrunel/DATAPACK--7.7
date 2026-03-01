-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Fireworks rocket behavior
-- Notes: Updated API, fixed remove bug, corrected damage call
-- Changes: OO API, say fix, sendMagicEffect, proper hit effect

function onUse(player, item, fromPosition, target, toPosition)
	-- Rocket used on ground
	if fromPosition.x ~= CONTAINER_POSITION then
		fromPosition:sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
	else
		-- Rocket used inside backpack
		player:say("Ouch! Rather place it on the ground next time.", TALKTYPE_MONSTER)
		doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_EXPLOSIONHIT)
	end

	-- Remove only the rocket item itself
	item:remove(1)
	return true
end

