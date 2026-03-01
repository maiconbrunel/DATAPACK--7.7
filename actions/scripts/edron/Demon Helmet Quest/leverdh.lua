-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: DH stone wall lever
-- Notes: Tile checks updated
-- Changes: cleanup, English message

function onUse(player, item, fromPosition, target, toPosition)
    local gatePos = Position(33314, 31592, 15)
    local gateItem = Tile(gatePos):getItemById(1304)

    if item.actionid == 10822 and item.itemid == 1945 and gateItem then
        gateItem:remove()
        item:transform(1946)

    elseif item.actionid == 10822 and item.itemid == 1946 and not gateItem then
        Game.createItem(1304, 1, gatePos)
        item:transform(1945)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end
    return true
end

