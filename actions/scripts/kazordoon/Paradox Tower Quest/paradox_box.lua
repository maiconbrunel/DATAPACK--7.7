-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Paradox Box
-- Notes:
-- Changes:

function onUse(player, item, fromPosition, target, toPosition)
    local cratePos = Position(32479, 31900, 5)

    if item.actionid == 8003 and item.itemid == 1945 then -- lever
        Game.createItem(1739, 1, cratePos) -- crate
        item:transform(1946)
    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end
