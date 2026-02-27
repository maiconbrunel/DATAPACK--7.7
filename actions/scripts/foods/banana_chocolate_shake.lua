-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Food script
-- Notes: Auto

function onUse(player, item, fromPosition, target, toPosition)
	doRemoveItem(item.uid, 1)
	doCreatureSay(player, "You don't really know what this did to you, but suddenly you feel very happy.", TALKTYPE_MONSTER)
	doSendMagicEffect(getThingPos(player), CONST_ME_HEARTS)
	return true
end
