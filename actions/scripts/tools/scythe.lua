-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Scythe tool usage
-- Notes: Calls TOOLS.SCYTHE with all parameters and automatic harvesting

function onUse(cid, item, fromPosition, itemEx, toPosition)
	return TOOLS.SCYTHE(cid, item, fromPosition, itemEx, toPosition, true)
end
