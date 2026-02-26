--
function onUse(cid, item, frompos, item2, topos)
 
door = {x = 32824, y = 32236, z = 12}

if item.uid ==2119 then
queststatus = getPlayerStorageValue(cid,2118)
if queststatus == 1 then

doTeleportThing(cid,door)
doSendMagicEffect(topos,12)

else
doPlayerSendTextMessage(cid,22,"Voce deve terminar a primeira sala antes de entrar nessa.")
end
return 0
end
return 1
end
