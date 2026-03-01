-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Present explosion effect
-- Notes: Updated to modern API, behavior preserved
-- Changes: say fix, effect fix, remove fix

function onUse(player, item, fromPosition, target, toPosition)
	-- Explosion visual
	fromPosition:sendMagicEffect(CONST_ME_EXPLOSIONAREA)

	-- Message
	player:say("KABOOOOOOOOOOM!", TALKTYPE_MONSTER)

	-- Remove gift
	item:remove(1)
	return true
end

