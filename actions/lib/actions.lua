-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Tools and tile interaction system
-- Notes: Fixed item transforms, decay, teleport, and effects for TFS 1.5

local SPOTS = {384, 418}
local ROPABLE = {294, 369, 370, 383, 392, 408, 409, 427, 428, 430, 462, 469, 470, 482, 484, 485, 489, 924, 3135, 3136, 3137}
local HOLES = {468, 481, 483}
local SAND = {231}
local JUNGLE_GRASS = {2782, 3985}
local SPIDER_WEB = {7538, 7539}
local BAMBOO_FENCE = {3798, 3799}
local WILD_GROWTH = {1499}
local PUMPKIN = 2683
local PUMPKIN_HEAD = 2096
local POOL = 2016
local DOORS = {
	[1209] = 1211, [1212] = 1214, [1231] = 1233, [1234] = 1236,
	[1249] = 1251, [1252] = 1254, [3535] = 3537, [3544] = 3546,
	[4913] = 4915, [4916] = 4918
}

local function destroyItem(cid, itemEx, toPosition)
	if itemEx.uid <= 65535 or itemEx.actionid > 0 then
		return false
	end

	if isInArray(SPIDER_WEB, itemEx.itemid) then
		if math.random(3) == 1 then
			doTransformItem(itemEx.uid, itemEx.itemid + 6)
			doDecayItem(itemEx.uid)
		end
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	end

	if isInArray(BAMBOO_FENCE, itemEx.itemid) then
		if math.random(3) == 1 then
			if itemEx.itemid == BAMBOO_FENCE[1] then
				doTransformItem(itemEx.uid, itemEx.itemid + 161)
			elseif itemEx.itemid == BAMBOO_FENCE[2] then
				doTransformItem(itemEx.uid, itemEx.itemid + 159)
			end
			doDecayItem(itemEx.uid)
		end
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	end

	if not(isInArray({1770, 2098, 1774, 1775, 2064, 2094, 2095, 1619, 2602, 3805, 3806}, itemEx.itemid) or
		(itemEx.itemid >= 1724 and itemEx.itemid <= 1741) or
		(itemEx.itemid >= 2581 and itemEx.itemid <= 2588) or
		(itemEx.itemid >= 1747 and itemEx.itemid <= 1753) or
		(itemEx.itemid >= 1714 and itemEx.itemid <= 1717) or
		(itemEx.itemid >= 1650 and itemEx.itemid <= 1653) or
		(itemEx.itemid >= 1666 and itemEx.itemid <= 1677) or
		(itemEx.itemid >= 1614 and itemEx.itemid <= 1616) or
		(itemEx.itemid >= 3813 and itemEx.itemid <= 3820) or
		(itemEx.itemid >= 3807 and itemEx.itemid <= 3810) or
		(itemEx.itemid >= 2080 and itemEx.itemid <= 2085) or
		(itemEx.itemid >= 2116 and itemEx.itemid <= 2119)) then
		return false
	end

	if math.random(1, 7) == 1 then
		local toCreate
		if isInArray({1738, 1739, 1770, 2098, 1774, 1775, 2064}, itemEx.itemid) or (itemEx.itemid >= 2581 and itemEx.itemid <= 2588) then
			toCreate = 2250
		elseif (itemEx.itemid >= 1747 and itemEx.itemid <= 1749) or itemEx.itemid == 1740 then
			toCreate = 2251
		elseif itemEx.itemid >= 1714 and itemEx.itemid <= 1717 then
			toCreate = 2252
		elseif (itemEx.itemid >= 1650 and itemEx.itemid <= 1653) or
		       (itemEx.itemid >= 1666 and itemEx.itemid <= 1677) or
		       (itemEx.itemid >= 1614 and itemEx.itemid <= 1616) or
		       (itemEx.itemid >= 3813 and itemEx.itemid <= 3820) or
		       (itemEx.itemid >= 3807 and itemEx.itemid <= 3810) then
			toCreate = 2253
		elseif (itemEx.itemid >= 1724 and itemEx.itemid <= 1737) or
		       (itemEx.itemid >= 2080 and itemEx.itemid <= 2085) or
		       (itemEx.itemid >= 2116 and itemEx.itemid <= 2119) or
		       isInArray({2094, 2095}, itemEx.itemid) then
			toCreate = 2254
		elseif (itemEx.itemid >= 1750 and itemEx.itemid <= 1753) or isInArray({1619, 1741}, itemEx.itemid) then
			toCreate = 2255
		elseif itemEx.itemid == 2602 then
			toCreate = 2257
		elseif itemEx.itemid == 3805 or itemEx.itemid == 3806 then
			toCreate = 2259
		end

		if toCreate then
			doCreateItem(toCreate, 1, toPosition)
		end
		doRemoveItem(itemEx.uid, 1)
	end

	doSendMagicEffect(toPosition, CONST_ME_POFF)
	return true
end

local TOOLS = {}

-- Rope logic
TOOLS.ROPE = function(cid, item, fromPosition, itemEx, toPosition)
	if toPosition.x == CONTAINER_POSITION then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	toPosition.stackpos = STACKPOS_GROUND
	local ground = getThingFromPos(toPosition)
	if isInArray(SPOTS, ground.itemid) then
		doTeleportThing(cid, {x = toPosition.x, y = toPosition.y + 1, z = toPosition.z - 1}, false)
		return true
	elseif isInArray(ROPABLE, itemEx.itemid) then
		local canOnlyRopePlayers = getBooleanFromString(getConfigValue('canOnlyRopePlayers'))
		local hole = getThingFromPos({x = toPosition.x, y = toPosition.y, z = toPosition.z + 1, stackpos = STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE})
		if canOnlyRopePlayers then
			if isPlayer(hole.uid) and (not isPlayerGhost(hole.uid) or getPlayerGhostAccess(cid) >= getPlayerGhostAccess(hole.uid)) then
				doTeleportThing(hole.uid, {x = toPosition.x, y = toPosition.y + 1, z = toPosition.z}, false)
			else
				doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
			end
		else
			if hole.itemid > 0 then
				doTeleportThing(hole.uid, {x = toPosition.x, y = toPosition.y + 1, z = toPosition.z}, false)
			else
				doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
			end
		end
		return true
	end
	return false
end

-- Pick logic
TOOLS.PICK = function(cid, item, fromPosition, itemEx, toPosition)
	local ground = getThingFromPos({x = toPosition.x, y = toPosition.y, z = toPosition.z + 1, stackpos = STACKPOS_GROUND})
	if isInArray(SPOTS, ground.itemid) and isInArray({354, 355}, itemEx.itemid) then
		doTransformItem(itemEx.uid, 392)
		doDecayItem(itemEx.uid)
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	end
	return false
end

-- Machete logic
TOOLS.MACHETE = function(cid, item, fromPosition, itemEx, toPosition, destroy)
	if isInArray(JUNGLE_GRASS, itemEx.itemid) then
		doTransformItem(itemEx.uid, itemEx.itemid - 1)
		doDecayItem(itemEx.uid)
		return true
	elseif isInArray(SPIDER_WEB, itemEx.itemid) then
		if math.random(3) == 1 then
			doTransformItem(itemEx.uid, itemEx.itemid + 6)
			doDecayItem(itemEx.uid)
		end
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	elseif isInArray(BAMBOO_FENCE, itemEx.itemid) then
		if math.random(3) == 1 then
			if itemEx.itemid == BAMBOO_FENCE[1] then
				doTransformItem(itemEx.uid, itemEx.itemid + 161)
			elseif itemEx.itemid == BAMBOO_FENCE[2] then
				doTransformItem(itemEx.uid, itemEx.itemid + 159)
			end
			doDecayItem(itemEx.uid)
		end
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return true
	elseif isInArray(WILD_GROWTH, itemEx.itemid) then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		doRemoveItem(itemEx.uid)
		return true
	end
	return destroy and destroyItem(cid, itemEx, toPosition) or false
end

-- Shovel logic
TOOLS.SHOVEL = function(cid, item, fromPosition, itemEx, toPosition)
	if isInArray(HOLES, itemEx.itemid) then
		local newId = itemEx.itemid + 1
		if itemEx.itemid == 8579 then
			newId = 8585
		end
		doTransformItem(itemEx.uid, newId)
		doDecayItem(itemEx.uid)
	elseif isInArray(SAND, itemEx.itemid) then
		local rand = math.random(1, 100)
		local ground = getThingFromPos({x = toPosition.x, y = toPosition.y, z = toPosition.z + 1, stackpos = STACKPOS_GROUND})
		if isInArray(SPOTS, ground.itemid) and rand <= 20 then
			doTransformItem(itemEx.uid, 489)
			doDecayItem(itemEx.uid)
		elseif rand <= 5 then
			doCreateItem(2159, 1, toPosition)
		elseif rand > 85 then
			doCreateMonster("Scarab", toPosition, false)
		end
		doSendMagicEffect(toPosition, CONST_ME_POFF)
	end
	return true
end

-- Scythe logic
TOOLS.SCYTHE = function(cid, item, fromPosition, itemEx, toPosition, destroy)
	if itemEx.itemid == 2739 then
		doTransformItem(itemEx.uid, 2737)
		doCreateItem(2694, 1, toPosition)
		doDecayItem(itemEx.uid)
		return true
	end
	return destroy and destroyItem(cid, itemEx, toPosition) or false
end

-- Knife logic
TOOLS.KNIFE = function(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.itemid ~= PUMPKIN then
		return false
	end
	doTransformItem(itemEx.uid, PUMPKIN_HEAD)
	return true
end
