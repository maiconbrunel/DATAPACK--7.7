--
function onUse(cid, item, frompos, item2, topos)
 
door = {x = 32820, y = 32240, z = 12}

if item.uid ==2115 then
queststatus = getPlayerStorageValue(cid,2114)
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
