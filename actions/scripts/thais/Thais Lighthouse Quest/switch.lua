-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever switch to change items on tile
-- Notes: Fixed tile handling and item transformations

function onUse(cid, item, frompos, item2, topos)
	local tilePos = {x = 32225, y = 32276, z = 8, stackpos = 0}
	local tileItem = getThingfromPos(tilePos)

	if item.actionid == 4016 then
		if item.itemid == 1945 then
			doRemoveItem(tileItem.uid, 1)
			doCreateItem(427, 1, tilePos)
			doTransformItem(item.uid, item.itemid + 1)

		elseif item.itemid == 1946 then
			doRemoveItem(tileItem.uid, 1)
			doCreateItem(351, 1, tilePos)
			doTransformItem(item.uid, item.itemid - 1)
		else
			doPlayerSendCancel(cid, "Sorry, not possible.")
		end
	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end

	return true
end
