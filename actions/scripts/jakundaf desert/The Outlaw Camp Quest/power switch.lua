-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Power redirection switch
-- Notes: fixed event bug, Tile API
-- Changes: removed deprecated calls, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local sourcePos = Position(32594, 32214, 9)
    local targetPos = Position(32613, 32220, 10)
    local wallPos = Position(32604, 32216, 9)

    local source = Tile(sourcePos):getItemById(2166)
    local wall = Tile(wallPos):getItemById(1026)

    if item.actionid == 3401 and item.itemid == 1945 and source and wall then
        source:remove()
        wall:remove()

        Game.createItem(2166, 1, targetPos)
        item:transform(1946)

        addEvent(function()
            Game.createItem(1026, 1, wallPos)
        end, 600000)

        sourcePos:sendMagicEffect(CONST_ME_ENERGYHIT)

    elseif item.actionid == 3401 and item.itemid == 1946 and source and wall then
        source:remove()
        wall:remove()

        Game.createItem(2166, 1, targetPos)
        item:transform(1945)

        addEvent(function()
            Game.createItem(1026, 1, wallPos)
        end, 600000)

        sourcePos:sendMagicEffect(CONST_ME_ENERGYHIT)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end
