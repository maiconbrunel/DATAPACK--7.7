-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Behemoth quest lever
-- Notes: Tile checks updated
-- Changes: English msg, API modern

function onUse(player, item, fromPosition, target, toPosition)
    local ids = {33295,33296,33297,33298,33299}
    local gates = {}

    for i,posX in ipairs(ids) do
        gates[i] = Tile(Position(posX,31677,15)):getItemById(1304)
    end

    local allClosed = true
    for _,g in ipairs(gates) do
        if not g then allClosed = false break end
    end

    if item.actionid == 10014 and item.itemid == 1945 and allClosed then
        for _,g in ipairs(gates) do g:remove() end
        item:transform(1946)

    elseif item.actionid == 10014 and item.itemid == 1946 then
        for _,posX in ipairs(ids) do
            Game.createItem(1304,1,Position(posX,31677,15))
        end
        item:transform(1945)

    else
        player:sendCancelMessage("It is not possible.")
    end

    return true
end

