-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Paradox Tower – Level 2 switch puzzle
-- Notes:
-- Changes:

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 8002 and item.actionid ~= 125 then
        return false
    end

    local positions = {
        Position(32476, 31900, 6),
        Position(32477, 31900, 6),
        Position(32478, 31900, 6),
        Position(32479, 31900, 6),
        Position(32480, 31900, 6),
        Position(32481, 31900, 6),
    }

    local ladderPos = Position(32477, 31905, 6)

    -- Fetch switch items
    local s = {}
    for i = 1, 6 do
        local tile = Tile(positions[i])
        if not tile then return false end
        local itm = tile:getItemById(1945) or tile:getItemById(1946)
        if not itm then return false end
        s[i] = itm
    end

    -- First activation
    if item.actionid == 8002 and item.itemid == 1945 then
        if s[1].itemid == 1946 and
           s[2].itemid == 1946 and
           s[3].itemid == 1945 and
           s[4].itemid == 1945 and
           s[5].itemid == 1946 and
           s[6].itemid == 1945 then

            Game.createItem(1386, 1, ladderPos) -- ladder
            item:transform(1946)
            return true
        end

        return false
    end

    -- Reset
    if item.actionid == 125 and item.itemid == 1946 then
        local tile = Tile(ladderPos)
        if tile then
            local ladder = tile:getItemById(1386)
            if ladder then
                ladder:remove()
            end
        end
        item:transform(1945)
        return true
    end

    return false
end
