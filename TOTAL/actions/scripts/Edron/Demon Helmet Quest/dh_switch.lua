-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Gate + teleport lever
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, standardized checks, logic cleanup

function onUse(player, item, fromPosition, target, toPosition)
local gatePos = Position(33314, 31592, 15)
local telePos = Position(33316, 31591, 15)
local goPos   = Position(33321, 31591, 14)

local gateItem = Tile(gatePos):getItemById(1355)
local teleportItem = Tile(telePos):getItemById(1387)

if item.uid == 10002 and item.itemid == 1945 then
    if gateItem then gateItem:remove() end
    item:transform(1946)
    Game.createTeleport(1387, goPos, telePos)
    return true
end

if item.uid == 10002 and item.itemid == 1946 then
    if not gateItem then
        Game.createItem(1355, 1, gatePos)
    end
    item:transform(1945)

    if teleportItem then
        teleportItem:remove()
    end
    return true
end

player:sendCancelMessage("Sorry, not possible.")
return true
end
