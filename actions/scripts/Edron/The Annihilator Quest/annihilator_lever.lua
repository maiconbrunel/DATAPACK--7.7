-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Annihilator Switch (full party check + summon + teleport)
-- Notes: Fully fixed, rewritten for TFS 1.5

local room = {
        fromX = 33219, fromY = 31657, fromZ = 13,
        toX   = 33222, toY   = 31661, toZ   = 13
}

local monsterPositions = {
        {pos = Position(33219,31657,13), monster = "Demon"},
        {pos = Position(33221,31657,13), monster = "Demon"},
        {pos = Position(33220,31661,13), monster = "Demon"},
        {pos = Position(33222,31661,13), monster = "Demon"},
        {pos = Position(33223,31659,13), monster = "Demon"},
        {pos = Position(33224,31659,13), monster = "Demon"}
}

local playersPositions = {
        Position(33222,31671,13),
        Position(33223,31671,13),
        Position(33224,31671,13),
        Position(33225,31671,13)
}

local newPositions = {
        Position(33219,31659,13),
        Position(33220,31659,13),
        Position(33221,31659,13),
        Position(33222,31659,13)
}

local requiredLevel = 100

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10009 then
        return true
        end

        ---------------------------------------------------------------------
        -- LEVER FORWARD (1945) → START QUEST
        ---------------------------------------------------------------------
        if item.itemid == 1945 then
                local party = {}

                -- Check players on tiles
                for i = 1, #playersPositions do
                        local tile = Tile(playersPositions[i])
                        local creature = tile and tile:getTopCreature()
                        if creature and creature:isPlayer() then
                                table.insert(party, creature)
                                end
                                end

                                if #party < #playersPositions then
                                        player:sendCancelMessage("You need 4 players to start the quest.")
                                        return true
                                        end

                                        -- Check levels
                                        for _, p in ipairs(party) do
                                                if p:getLevel() < requiredLevel then
                                                        player:sendCancelMessage("All players must be level " .. requiredLevel .. " or higher.")
                                                        return true
                                                        end
                                                        end

                                                        -- Summon demons
                                                        for _, entry in ipairs(monsterPositions) do
                                                                Game.createMonster(entry.monster, entry.pos)
                                                                end

                                                                -- Teleport players
                                                                for i = 1, #party do
                                                                        party[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
                                                                        party[i]:teleportTo(newPositions[i], true)
                                                                        newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
                                                                        end

                                                                        item:transform(1946)
                                                                        return true
                                                                        end

                                                                        ---------------------------------------------------------------------
                                                                        -- LEVER BACKWARD (1946) → RESET ROOM
                                                                        ---------------------------------------------------------------------
                                                                        if item.itemid == 1946 then
                                                                                local hasPlayersInside = false

                                                                                -- Scan room
                                                                                for x = room.fromX, room.toX do
                                                                                        for y = room.fromY, room.toY do
                                                                                                for z = room.fromZ, room.toZ do
                                                                                                        local tile = Tile(Position(x,y,z))
                                                                                                        if tile then
                                                                                                                local creature = tile:getTopCreature()
                                                                                                                if creature and creature:isPlayer() then
                                                                                                                        hasPlayersInside = true
                                                                                                                        break
                                                                                                                        end
                                                                                                                        end
                                                                                                                        end
                                                                                                                        if hasPlayersInside then break end
                                                                                                                                end
                                                                                                                                if hasPlayersInside then break end
                                                                                                                                        end

                                                                                                                                        if hasPlayersInside then
                                                                                                                                                player:sendTextMessage(MESSAGE_INFO_DESCR, "There is already a team in the quest room.")
                                                                                                                                                return true
                                                                                                                                                end

                                                                                                                                                -- Clean room (monsters only)
                                                                                                                                                for x = room.fromX, room.toX do
                                                                                                                                                        for y = room.fromY, room.toY do
                                                                                                                                                                for z = room.fromZ, room.toZ do
                                                                                                                                                                        local tile = Tile(Position(x,y,z))
                                                                                                                                                                        if tile then
                                                                                                                                                                                local creature = tile:getTopCreature()
                                                                                                                                                                                if creature and creature:isMonster() then
                                                                                                                                                                                        creature:remove()
                                                                                                                                                                                        end
                                                                                                                                                                                        end
                                                                                                                                                                                        end
                                                                                                                                                                                        end
                                                                                                                                                                                        end

                                                                                                                                                                                        item:transform(1945)
                                                                                                                                                                                        return true
                                                                                                                                                                                        end

                                                                                                                                                                                        return true
                                                                                                                                                                                        end
