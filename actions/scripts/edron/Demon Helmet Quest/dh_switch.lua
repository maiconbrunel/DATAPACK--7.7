-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Helmet teleport lever
-- Notes: Tile():getItemById, teleport create fix
-- Changes: fixed deprecated API, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(33314, 31592, 15)
    local telePos = Position(33316, 31591, 15)
    local goPos = Position(33321, 31591, 14)

    local gateItem = Tile(gatePos):getItemById(1355)
    local teleItem = Tile(telePos):getItemById(1387)

    if item.actionid == 10002 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)
        Game.createTeleport(1387, goPos, telePos)

    elseif item.actionid == 10002 and item.itemid == 1946 and not gateItem then
        Game.createItem(1355, 1, gatePos)
        item:transform(1945)
        if teleItem then teleItem:remove() end

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end

