-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Draconia wall switch
-- Notes: Tile API, cleanup
-- Changes: English messages, removed deprecated API

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(32792, 31581, 7)
    local gateItem = Tile(gatePos):getItemById(1037)

    if item.actionid == 9507 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)
    elseif item.actionid == 9507 and item.itemid == 1946 and not gateItem then
        Game.createItem(1037, 1, gatePos)
        item:transform(1945)
    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end

