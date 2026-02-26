--
function onUse(cid, item, frompos, item2, topos)

telepos = {x = 958, y = 1521, z = 13, stackpos=1} 
 
if item.uid ==2118 then
queststatus = getPlayerStorageValue(cid,2118)
if queststatus == 1 then
doTeleportThing(cid,telepos)
 
else
doPlayerSendTextMessage(cid,22,"Sente no trono para concluir esta sala.")
doSendMagicEffect(topos,12)
setPlayerStorageValue(cid,2118,1)
doTeleportThing(cid,telepos)
end
return 0
end
return 1
end
