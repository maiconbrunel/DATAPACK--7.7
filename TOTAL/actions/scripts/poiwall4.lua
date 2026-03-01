-- [PROJECT 7.7 TFS 1.5] Converted script
-- Changes: English messages, API cleanup, event logic preserved

local function appear(pos)
if getThingFromPos(pos).itemid ~= 1304 then
doCreateItem(1304,1,pos)
doSendMagicEffect(pos,56)
end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
local posiciones = {
{x = 32854, y = 32322, z = 9, stackpos = 1}
}

doPlayerSendTextMessage(cid,22, "Wall removed for 2 minutes!")
local seg = 120

for i = 1,#posiciones do
if getThingFromPos(posiciones[i]).itemid == 1304 then
doSendMagicEffect(posiciones[i],55)
doRemoveItem(getThingFromPos(posiciones[i]).uid)
addEvent(appear,seg * 1000,posiciones[i])
end
end

return TRUE
end
