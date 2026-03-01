-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Banshee quest entrance lever
-- Notes: fixed logic & tile checks
-- Changes: removed deprecated API, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local pos = Position(32266, 31860, 11)

    local mw = Tile(pos):getItemById(1497)
    local stair = Tile(pos):getItemById(410)

    if item.actionid == 9007 and item.itemid == 1945 and mw then
        mw:remove()
        Game.createItem(410, 1, pos)
        item:transform(1946)

    elseif item.actionid == 9007 and item.itemid == 1946 and not mw then
        if stair then stair:remove() end
        Game.createItem(407, 1, pos)
        Game.createItem(1497, 1, pos)
        item:transform(1945)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end

