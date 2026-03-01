-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Barbarian Axe Quest switch
-- Notes: Tile API fix
-- Changes: English msg, cleanup

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(33171, 31897, 8)
    local gateItem = Tile(gatePos):getItemById(1355)

    if item.actionid == 10001 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)

    elseif item.actionid == 10001 and item.itemid == 1946 and not gateItem then
        Game.createItem(1355, 1, gatePos)
        item:transform(1945)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end

