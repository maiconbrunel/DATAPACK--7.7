-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Burn lever event
-- Notes: Tile API, effect fix
-- Changes: removed deprecated functions, English messages

function onUse(player, item, fromPosition, target, toPosition)
    local powerPos = Position(32613, 32220, 10)
    local barrelPos = Position(32614, 32209, 10)
    local wallPos = Position(32614, 32205, 10)
    local stonePos = Position(32614, 32206, 10)

    local power = Tile(powerPos):getItemById(2166)
    local barrel = Tile(barrelPos):getItemById(1774)
    local wall = Tile(wallPos):getItemById(1025)
    local stone = Tile(stonePos):getItemById(1304)

    if item.actionid == 3402 and item.itemid == 1945
       and power and wall and stone and barrel then

        power:remove()
        wall:remove()
        stone:remove()

        Game.createItem(1025, 1, stonePos)
        item:transform(1946)

        Position(32613, 32220, 10):sendMagicEffect(CONST_ME_FIREATTACK)
        Position(32615, 32221, 10):sendMagicEffect(CONST_ME_FIREATTACK)

    elseif item.actionid == 3402 and item.itemid == 1946 then
        item:transform(1945)

    else
        player:sendCancelMessage("Sorry, not possible.")
    end

    return true
end
