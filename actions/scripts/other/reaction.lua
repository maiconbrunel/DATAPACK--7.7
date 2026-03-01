-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Doll random message system
-- Notes: Corrected position handling and random selection

local DOLLS = {
	[5080] = {"Hug me."}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local doll = DOLLS[item.itemid]
	if not doll then
		return false
	end

	-- Correct position if used from container
	if fromPosition.x == CONTAINER_POSITION then
		fromPosition = getThingPosition(cid)
	end

	-- Randomly say one of the doll's phrases
	local message = doll[math.random(1, #doll)]
	doCreatureSay(cid, message, TALKTYPE_MONSTER, false, 0, fromPosition)

	return true
end
