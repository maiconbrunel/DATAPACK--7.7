-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Parchment Room bag chest
-- Notes: container API updated
-- Changes: summons updated, English messages

function onUse(player, item, fromPosition, target, toPosition)
    if item.actionid ~= 10023 then
        return true
    end

    local pos = {
        {x=33061, y=31622, z=15},
        {x=33065, y=31622, z=15},
        {x=33061, y=31628, z=15},
        {x=33065, y=31628, z=15}
    }

    if player:getStorageValue(10023) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")
        local bag = player:addItem(1987, 1)

        bag:addItem(2165, 1)
        bag:addItem(2151, 2)
        bag:addItem(2230, 1)
        bag:addItem(2229, 1)
        bag:addItem(1948, 1)

        local key = bag:addItem(2091, 1)
        key:setActionId(1505)

        player:setStorageValue(10023, 1)

        for _, p in ipairs(pos) do
            Game.createMonster("Demon", p)
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The wooden coffin is empty.")
    end

    return true
end

