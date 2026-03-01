-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Toggle gate open/close
-- Notes: Fixed item and position checks, safe create/remove

function onUse(cid, item, fromPosition, item2, toPosition)
	local gatePos = {x = 32145, y = 32101, z = 11, stackpos = 1}
	local gate = getThingfromPos(gatePos)

	-- Open gate
	if item.uid == 3003 and item.itemid == 1945 and gate.itemid == 1304 then
		doRemoveItem(gate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)

	-- Close gate
	elseif item.uid == 3003 and item.itemid == 1946 and gate.itemid == 0 then
		doCreateItem(1304, 1, gatePos)
		doTransformItem(item.uid, item.itemid - 1)

	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end

	return true
end
