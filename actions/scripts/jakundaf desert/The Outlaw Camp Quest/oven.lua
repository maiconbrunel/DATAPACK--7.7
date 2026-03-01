-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Oven switch mechanic
-- Notes: Tile API, removed deprecated functions
-- Changes: fixed gettele bug, transformed to modern API, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local pos1 = Position(32623, 32188, 9)
    local pos2 = Position(32623, 32189, 9)

    local oven1 = Tile(pos1):getItemById(1787)
    local oven2 = Tile(pos2):getItemById(1787)

    if item.actionid == 3400 and item.itemid == 1945 and oven1 then
        oven1:remove()
        Game.createItem(1787, 1, pos2)
        item:transform(1946)

    elseif item.actionid == 3400 and item.itemid == 1946 and oven2 then
        oven2:remove()
        Game.createItem(1787, 1, pos1)
        item:transform(1945)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end
