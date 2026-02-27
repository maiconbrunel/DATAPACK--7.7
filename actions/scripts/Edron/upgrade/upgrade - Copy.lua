-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Auto-converted
-- Notes: Minimal conversion

function onUse(player, item, fromPosition, target, toPosition)
if topos.x == 65535 or not (topos.x == 33314 and topos.y == 31683 and topos.z == 11)then
doPlayerSendCancel(player, 'Put the metal on the anvil first.')
return true
end



if item2.itemid == 2258 then
doTransformItem(item2.uid, 2157)
doSendMagicEffect(topos, 3)
end
if item2.itemid == 2123 then
if doPlayerRemoveMoney(player,100000) then
doTransformItem(item2.uid, 2357)
doSendMagicEffect(topos, 3)
else
doPlayerSendCancel(player, 'not enough cash.')
end
end
if item2.itemid == 2519 then
if getPlayerItemCount(player,2157) >= 100 then
doPlayerRemoveItem(player,2157,100)
doTransformItem(item2.uid, 2539)
doSendMagicEffect(topos, 3)
else
doPlayerSendCancel(player, 'Keep nuggets in your backpack.')
end
end


















return true
end

