-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Banshee quest magic wall 1
-- Notes: Removed deprecated API, Tile() check
-- Changes: English message, API modernized

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(32259, 31891, 10)
    local gateItem = Tile(gatePos):getItemById(1497)

    if item.actionid == 9005 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)

    elseif item.actionid == 9005 and item.itemid == 1946 and not gateItem then
        Game.createItem(1497, 1, gatePos)
        item:transform(1945)

    else
        player:sendCancelMessage("Not possible.")
    end

    return true
end

