
  
  local function appear(pos)

if getThingFromPos(pos).itemid ~= 1304 then --item k se removera, pon la stone
doCreateItem(1304,1,pos) --lo mismo de arriva
doSendMagicEffect(pos,56) --efecto
end

end

function onUse(cid, item, fromPosition, itemEx, toPosition)
local posiciones = {
{x = 32854, y = 32322, z = 9, stackpos = 1} --posision que esta la estone, si agregas mas posiciones pon "," comas.
}


doPlayerSendTextMessage(cid,22, "Wall Removida por 2 minutos!")
local seg = 120 -- SEGUNDOS PARA VOLVER A APARECER

for i = 1,#posiciones do
if getThingFromPos(posiciones[i]).itemid == 1304 then -- el item k se pondra despues de los segundos
doSendMagicEffect(posiciones[i],55) -- efecto k tendra al aparecer
doRemoveItem(getThingFromPos(posiciones[i]).uid)
addEvent(appear,seg * 1000,posiciones[i])
end
end

return TRUE
end