-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Simple teleport
-- Notes: Teleports player to predefined position when using a specific UID

function onUse(cid, item, frompos, item2, topos)
	if item.uid == 4015 then
		local newpos = {x = 32172, y = 32439, z = 8}
		doTeleportThing(cid, newpos)
		return true
	end
	return false
end
