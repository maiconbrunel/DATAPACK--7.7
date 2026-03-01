-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Bridge lever / movable bridge system
-- Notes: Fixed item transforms, relocation, and cleanup

local bridgeID = 1284
local back = {x = 32102, y = 32205, z = 8}

local bridgePos = {
	[1] = {x = 32099, y = 32205, z = 8}, 
	[2] = {x = 32100, y = 32205, z = 8}, 
	[3] = {x = 32101, y = 32205, z = 8}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.itemid == 1945 then
		-- Transform levers
		for i = 3009, 3010 do
			doTransformItem(i, 1946)
		end

		-- Create bridge middle
		doCreateItem(bridgeID, bridgePos[2])

		-- Transform side tiles if matching IDs exist
		local tile1 = getTileItemById(bridgePos[1], 4645)
		if tile1 and tile1.itemid > 0 then
			doTransformItem(tile1.uid, bridgeID)
		end

		local tile3 = getTileItemById(bridgePos[3], 4647)
		if tile3 and tile3.itemid > 0 then
			doTransformItem(tile3.uid, bridgeID)
		end

	elseif item.itemid == 1946 then
		-- Reset levers
		for i = 3009, 3010 do
			doTransformItem(i, 1945)
		end

		-- Relocate bridge tiles back
		for p = 1, #bridgePos do
			doRelocate(bridgePos[p], back)
		end

		-- Remove leftover items on bridge positions
		for z = 1, #bridgePos do
			bridgePos[z].stackpos = 254
			local topItem = getThingFromPos(bridgePos[z])
			if topItem.itemid > 1000 then
				doRemoveItem(topItem.uid)
			end

			bridgePos[z].stackpos = 1
			topItem = getThingFromPos(bridgePos[z])
			if topItem.itemid > 1000 then
				doRemoveItem(topItem.uid)
			end
		end

		-- Restore original bridge tiles
		doCreateItem(4616, bridgePos[2])
		doCreateItem(351, bridgePos[1])
		doCreateItem(351, bridgePos[3])
		doCreateItem(4645, bridgePos[1])
		doCreateItem(4647, bridgePos[3])
	end

	return true
end
