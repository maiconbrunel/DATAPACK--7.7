-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport lever with temporary item creation
-- Notes: Fixed item creation/removal and lever transformation

function onUse(cid, item, fromPos, item2, toPos)
	local telePos = {x = 32233, y = 32276, z = 9, stackpos = 1}
	local goPos = {x = 32225, y = 32275, z = 10, stackpos = 1}
	local getTele = getThingfromPos(telePos)

	if item.actionid == 4017 then
		if item.itemid == 1945 then
			doTransformItem(item.uid, item.itemid + 1)
			local itemUid = doCreateItem(1387, 1, telePos)
			doSetItemActionId(itemUid, 4445)
		elseif item.itemid == 1946 then
			doTransformItem(item.uid, item.itemid - 1)
			if getTele.uid > 0 then
				doRemoveItem(getTele.uid, 1)
			end
		else
			doPlayerSendCancel(cid, "Sorry, not possible.")
		end
	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end

	return true
end
