-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Machete tool usage
-- Notes: Calls TOOLS.MACHETE with safety parameter true

function onUse(cid, item, fromPosition, itemEx, toPosition)
	return TOOLS.MACHETE(cid, item, fromPosition, itemEx, toPosition, true)
end
