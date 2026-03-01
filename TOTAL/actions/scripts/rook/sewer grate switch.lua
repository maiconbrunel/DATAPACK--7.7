function onUse(cid, item, frompos, item2, topos)
    tile1 = {x = 32100, y = 32205, z = 8, stackpos = 1}
    tile2 = {x = 32101, y = 32205, z = 8, stackpos = 1}
    local playerTile = {x = 32100, y = 32205, z = 8}
    local playerTile1 = {x = 32101, y = 32205, z = 8}
    gettile1 = getThingfromPos(tile1)
    gettile2 = getThingfromPos(tile2)
	
	if item.itemid == 1945 then
		for i = 1133, 1134 do
			doTransformItem(item.uid, 1946)
		end
		doCreateItem(493,1,tile1)
		doCreateItem(493,1,tile2)
		doCreateItem(4799,1,tile1)
		doCreateItem(4797,1,tile2)
		
		if isCreature(getTopCreature(playerTile).uid) then
			doTeleportThing(getTopCreature(playerTile).uid, {x = 32102, y = 32205, z = 8})
		end
		
		if isCreature(getTopCreature(playerTile1).uid) then
			doTeleportThing(getTopCreature(playerTile1).uid, {x = 32102, y = 32205, z = 8})
		end
		
	elseif item.itemid == 1946 then
		for i = 1133, 1134 do
			doTransformItem(item.uid, 1945)
		end
		doCreateItem(1284,1, tile1)
		doCreateItem(1284,1, tile2)
		doRemoveItem(gettile1.uid, 1)		
		doRemoveItem(gettile2.uid, 1)
	else
		doPlayerSendCancel(cid,"Sorry, not possible.")
	end
return doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)
end