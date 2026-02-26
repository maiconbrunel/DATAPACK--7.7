-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever gate toggle
-- Notes: Modern API + safe tile/item handling

local GATE_POS = Position(32259, 31890, 10)
local GATE_ITEMID = 1497

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate lever AID
if item.actionid ~= 9006 then
    return true
    end

    -- Gate tile
    local tile = Tile(GATE_POS)
    if not tile then
        return true
        end

        local gate = tile:getItemById(GATE_ITEMID)

        -- Lever ON
        if item.itemid == 1945 then
            if gate then
                gate:remove()
                item:transform(1946)
                end
                return true
                end

                -- Lever OFF
                if item.itemid == 1946 then
                    if not gate then
                        Game.createItem(GATE_ITEMID, 1, GATE_POS)
                        item:transform(1945)
                        end
                        return true
                        end

                        return true
                        end
