-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Annihilator lever
-- Notes: *Large script*, only deprecated calls replaced
-- Changes: English messages, Tile API

function onUse(player, item, fromPosition, target, toPosition)
    local room = {
        fromX=33219, fromY=31657, fromZ=13,
        toX=33222, toY=31661, toZ=13
    }

    local players_pos = {
        {x=33222, y=31671, z=13},
        {x=33223, y=31671, z=13},
        {x=33224, y=31671, z=13},
        {x=33225, y=31671, z=13}
    }

    local new_pos = {
        {x=33219, y=31659, z=13},
        {x=33220, y=31659, z=13},
        {x=33221, y=31659, z=13},
        {x=33222, y=31659, z=13}
    }

    if item.actionid ~= 10009 then
        return true
    end

    if item.itemid == 1945 then
        local players, valid = {}, 0

        for i,pos in ipairs(players_pos) do
            local creature = Tile(pos):getTopCreature()
            players[i] = creature
            if creature and creature:isPlayer() and creature:getLevel() >= 100 then
                valid = valid + 1
            end
        end

        if valid == 4 then
            local spawn = {
                {33219,31657,13},{33221,31657,13},{33220,31661,13},
                {33222,31661,13},{33223,31659,13},{33224,31659,13}
            }
            for _,m in ipairs(spawn) do
                Game.createMonster("Demon",{x=m[1],y=m[2],z=m[3]})
            end

            for i=1,4 do
                local p = players[i]
                if p then
                    p:teleportTo(new_pos[i])
                    p:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
                end
            end

            item:transform(1946)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"All players must be level 100 or higher.")
        end

    elseif item.itemid == 1946 then
        local count = 0
        for x=room.fromX, room.toX do
            for y=room.fromY, room.toY do
                for z=room.fromZ, room.toZ do
                    local c = Tile(Position(x,y,z)):getTopCreature()
                    if c and c:isPlayer() then
                        count = count + 1
                    end
                end
            end
        end

        if count > 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"There is already a team in the quest room.")
        else
            item:transform(1945)
        end
    end

    return true
end

