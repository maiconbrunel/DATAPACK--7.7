--
function onUse(cid, item, frompos, item2, topos)
 
door = {x = 32787, y = 32328, z = 6}

if item.uid ==2128 then
queststatus = getPlayerStorageValue(cid,2114)
if queststatus == 1 then

doTeleportThing(cid,door)
doSendMagicEffect(topos,12)

else
doPlayerSendTextMessage(cid,22,"Para utilizar esta porta voce tem que terminar o segundo stagio da POI.")
end
return 0
end
return 1
end
