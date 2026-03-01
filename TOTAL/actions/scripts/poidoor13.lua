-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pits of Inferno door 13
-- Notes: melhorias, atualizações da API, otimizações

function onUse(cid, item, frompos, item2, topos)

door = {x = 32828, y = 32242, z = 12}

if item.uid == 2125 then
queststatus = getPlayerStorageValue(cid, 2124)
if queststatus == 1 then

doTeleportThing(cid, door)
doSendMagicEffect(topos, 12)

else
doPlayerSendTextMessage(cid, 22, "You must finish the first room before entering this one.")
end
return 0
end
return 1
end

