-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever opens/closes 5 gates
-- Notes: Rewritten for full compatibility

function onUse(player, item, fromPosition, target, toPosition)
-- Gate positions
local gatePositions = {
    Position(33295, 31677, 15),
    Position(33296, 31677, 15),
    Position(33297, 31677, 15),
    Position(33298, 31677, 15),
    Position(33299, 31677, 15)
}

-- Retrieve gate items
local gates = {}
for i = 1, #gatePositions do
    gates[i] = Tile(gatePositions[i]):getItemById(1304)
    end

    -- OPEN GATES
    if item.uid == 10014 and item.itemid == 1945 then
        local allPresent = true
        for i = 1, #gates do
            if not gates[i] then
                allPresent = false
                break
                end
                end

                if allPresent then
                    -- Remove gates
                    for i = 1, #gates do
                        gates[i]:remove()
                        end

                        -- Switch lever
                        item:transform(1946)
                        return true
                        end
                        end

                        -- CLOSE GATES
                        if item.uid == 10014 and item.itemid == 1946 then
                            local allEmpty = true
                            for i = 1, #gatePositions do
                                if Tile(gatePositions[i]):getItemById(1304) then
                                    allEmpty = false
                                    break
                                    end
                                    end

                                    if allEmpty then
                                        for i = 1, #gatePositions do
                                            Game.createItem(1304, 1, gatePositions[i])
                                            end

                                            item:transform(1945)
                                            return true
                                            end
                                            end

                                            -- Default
                                            player:sendCancelMessage("It is not possible.")
                                            return true
                                            end
