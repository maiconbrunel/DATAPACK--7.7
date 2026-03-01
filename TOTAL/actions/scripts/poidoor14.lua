-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 14
-- Notes: melhorias, atualizações da API, otimizações

function onUse(cid, item, frompos, item2, topos)

telepos = {x = 939, y = 1503, z = 13, stackpos=1}

if item.uid == 2126 then
queststatus = getPlayerStorageValue(cid, 2126)
if queststatus == 1 then
doTeleportThing(cid, telepos)

else
doPlayerSendTextMessage(cid, 22, "Sit on the throne to complete this room.")
doSendMagicEffect(topos, 12)
setPlayerStorageValue(cid, 2126, 1)
doTeleportThing(cid, telepos)
end
return 0
end
return 1
end

