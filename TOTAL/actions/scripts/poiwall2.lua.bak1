function onUse(cid, item, frompos, item2, topos)

itempos = {x=32852, y=32333, z=12, stackpos=1} -------> posiciond  ela piedra{x = 32852, y = 32333, z = 12}
itemid = 3401
item3 = getThingfromPos(itempos)
item2pos = {x=32850, y=32334, z=12, stackpos=1} -------> posicion de la statua{x = 32850, y = 32334, z = 12}
item2id = 3698
item2 = getThingfromPos(item2pos)
alavancapos = { x=32874, y=32334, z=12, stackpos=1 }  ---------posicion de la palanca {x = 32874, y = 32334, z = 12}

if item.itemid == 1945 then
doTransformItem(item.uid,1946)
doRemoveItem(item3.uid,1)
doPlayerSendTextMessage(cid,22, "START POI!")
doSendMagicEffect(itempos,15)
elseif item.itemid == 1946 then
doPlayerSendTextMessage(cid,22,"Go POI!")
end

return 1
end