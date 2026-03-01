-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 16
-- Notes: melhorias, atualizações da API, otimizações

function onUse(cid, item, frompos, item2, topos)

door = {x = 32787, y = 32328, z = 6}

if item.uid ==2128 then
queststatus = getPlayerStorageValue(cid,2114)
if queststatus == 1 then

doTeleportThing(cid,door)
doSendMagicEffect(topos,12)

else
doPlayerSendTextMessage(cid,22,"To use this door you must finish the second stage of the POI.")
end
return 0
end
return 1
end

