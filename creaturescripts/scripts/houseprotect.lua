-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Restrict moving items into houses
-- Notes: Checks house ownership and invited players

local function isInvited(houseId, playerName)
	local accessList0 = string.lower(getHouseAccessList(houseId, 0x100))
	local accessList1 = string.lower(getHouseAccessList(houseId, 0x101))
	playerName = string.lower(playerName)

	if string.find(accessList0, playerName) or string.find(accessList1, playerName) then
		return true
	end

	return false
end

function onMoveItem(moveItem, fromPos, position, cid)
	local playerGroup = getPlayerGroupId(cid)
	local tileHouse = getTileInfo(position).house
	local houseId = getHouseFromPos(position)
	local houseOwner = getHouseOwner(houseId)
	local playerName = getCreatureName(cid)

	if playerGroup < 6 and tileHouse and houseOwner ~= getPlayerGUID(cid) and not isInvited(houseId, playerName) then
		doPlayerSendCancel(cid, "You cannot throw there.")
		return false
	end

	return true
end
