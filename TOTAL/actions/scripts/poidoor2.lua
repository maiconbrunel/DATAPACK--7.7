-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 2
-- Notes: melhorias, atualizações da API, otimizações

function onUse(cid, item, frompos, item2, topos)

telepos = {x = 1089, y = 1550, z = 13,stackpos=1}

if item.uid ==2114 then
queststatus = getPlayerStorageValue(cid,2114)
if queststatus == 1 then
doTeleportThing(cid,telepos)

else
doPlayerSendTextMessage(cid,22,"Sit on the throne to complete this room.")
doSendMagicEffect(topos,12)
setPlayerStorageValue(cid,2114,1)
doTeleportThing(cid,telepos)
end
return 0
end
return 1
end

