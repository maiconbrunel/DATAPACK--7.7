local GATE_POS = Position(32790, 31594, 7)
local GATE_ITEMID = 1285

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9508 then
    return true
    end

    local tile = Tile(GATE_POS)
    if not tile then
        return true
        end

        local gateItem = tile:getItemById(GATE_ITEMID)

        if item.itemid == 1945 then
            if gateItem then
                gateItem:remove()
                item:transform(1946)
                end
                return true
                end

                if item.itemid == 1946 then
                    if not gateItem then
                        Game.createItem(GATE_ITEMID, 1, GATE_POS)
                        item:transform(1945)
                        end
                        return true
                        end

                        return true
                        end
