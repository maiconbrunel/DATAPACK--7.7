-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Skull timer update
-- Notes: Fixed condition checks and skull expiration

function onThink(cid, interval)
	if not isCreature(cid) then
		return
	end

	local skull = getCreatureSkull(cid)
	local skullEnd = getPlayerSkullEnd(cid)

	if skullEnd > 0 and skull > SKULL_WHITE and os.time() > skullEnd and not getCreatureCondition(cid, CONDITION_INFIGHT) then
		doPlayerSetSkullEnd(cid, 0, skull)
	end
end
