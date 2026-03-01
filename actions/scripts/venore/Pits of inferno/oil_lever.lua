-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever with oil and creature movement
-- Notes: Fixed tile transformations, lever states, and creature movement

function onUse(cid, item, fromPos, item2, toPos)
	local oil = getTileItemById(fromPos, 2025)
	local square = {x = 32801, y = 32336, z = 11, stackpos = 0}
	local playerTile = {x = 32801, y = 32336, z = 11, stackpos = 255}

	local present_player = getThingfromPos(playerTile)
	local present_square = getThingfromPos(square)

	-- Check for oil on tile
	if oil.uid > 0 and oil.type == 11 then
		if item.itemid == 1945 then
			if present_square.itemid == 493 then
				doTransformItem(present_square.uid, 1284)
			else
				doTransformItem(present_square.uid, 493)
			end
			doTransformItem(item.uid, item.itemid + 1)

		elseif item.itemid == 1946 then
			if present_square.itemid == 493 then
				doTransformItem(present_square.uid, 1284)
			else
				doTransformItem(present_square.uid, 493)
			end

			doSendMagicEffect(square, CONST_ME_MAGIC_BLUE)
			doTransformItem(item.uid, item.itemid - 1)

			if isCreature(present_player.uid) then
				doMoveCreature(present_player.uid, WEST)
			else
				return false
			end
		else
			doPlayerSay(cid, "The lever is creaking and rusty.", TALKTYPE_MONSTER)
			doTransformItem(item.uid, 1945)
			return false
		end
	else
		doPlayerSay(cid, "The lever is creaking and rusty.", TALKTYPE_MONSTER)
		doTransformItem(item.uid, 1946)
		return false
	end

	return true
end
