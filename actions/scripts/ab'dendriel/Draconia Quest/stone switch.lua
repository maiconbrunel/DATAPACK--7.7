-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Draconia stone switch
-- Notes: API update, Tile checks, bugfix
-- Changes: fixed missing variable, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(32790, 31594, 7)
    local gateItem = Tile(gatePos):getItemById(1285)

    if item.actionid == 9508 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)
    elseif item.actionid == 9508 and item.itemid == 1946 and not gateItem then
        Game.createItem(1285, 1, gatePos)
        item:transform(1945)
    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end

