-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

local HOTD = {5461, 12541}

function onUse(player, item, fromPosition, target, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	local helmet = getPlayerSlotItem(player, CONST_SLOT_HEAD)
	if(not isInArray(HOTD, helmet.itemid) or not isUnderWater(player)) then
		player:sendTextMessage, MESSAGE_STATUS_SMALL, "You should only eat this dish when wearing a helmet of the deep and walking underwater.")
		return true
	end

	local itemInfo = getItemInfo(HOTD[2])
	if(helmet.itemid ~= HOTD[2]) then
		doTransformItem(helmet.uid, HOTD[2])
		doChangeSpeed(player, itemInfo.abilities.speed)
	end

	doItemSetAttribute(helmet.uid, "duration", itemInfo.decayTime * 1000)
	doRemoveItem(item.uid, 1)

	doCreatureSay(player, food, TALKTYPE_MONSTER)
	return true
end
