-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 4
-- Notes: melhorias, atualizações da API, otimizações

function onUse(cid, item, frompos, item2, topos)

telepos = {x = 1004, y = 1505, z = 13, stackpos=1}

if item.uid ==2116 then
queststatus = getPlayerStorageValue(cid,2116)
if queststatus == 1 then
doTeleportThing(cid,telepos)

else
doPlayerSendTextMessage(cid,22,"Sit on the throne to complete this room.")
doSendMagicEffect(topos,12)
setPlayerStorageValue(cid,2116,1)
doTeleportThing(cid,telepos)
end
return 0
end
return 1
end

