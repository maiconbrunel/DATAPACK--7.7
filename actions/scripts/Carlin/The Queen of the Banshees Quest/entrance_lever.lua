-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever toggle (MW / stair / black square)
-- Notes: Uses Tile(), create/remove, transform

local MW_POS = Position(32266, 31860, 11)
local BLACK_POS = Position(32266, 31860, 11)
local STAIR_POS = Position(32266, 31860, 11)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate lever AID
if item.actionid ~= 9007 then
    return true
    end

    local tile = Tile(MW_POS)
    if not tile then
        return true
        end

        local mw = tile:getItemById(1497)
        local stair = tile:getItemById(410)

        -- Lever ON
        if item.itemid == 1945 and mw then
            -- Remove MW and create stair
            mw:remove()
            Game.createItem(410, 1, STAIR_POS)
            item:transform(1946)
            return true
            end

            -- Lever OFF
            if item.itemid == 1946 and not mw then
                -- Remove stair, recreate black tile + MW
                if stair then
                    stair:remove()
                    end
                    Game.createItem(407, 1, BLACK_POS)
                    Game.createItem(1497, 1, MW_POS)
                    item:transform(1945)
                    return true
                    end

                    return true
                    end
