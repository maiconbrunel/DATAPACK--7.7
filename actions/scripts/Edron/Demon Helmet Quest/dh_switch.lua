-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Gate + teleport lever
-- Notes: Cleaned structure, fixed nesting, corrected logic

function onUse(player, item, fromPosition, target, toPosition)
-- Gate / teleport positions
local gatePos = Position(33314, 31592, 15)
local telePos = Position(33316, 31591, 15)
local goPos   = Position(33321, 31591, 14)

-- Fetch items
local gateItem = Tile(gatePos):getItemById(1355)
local teleportItem = Tile(telePos):getItemById(1387)

-- Lever ON (open gate + create teleport)
if item.uid == 10002 and item.itemid == 1945 then
    if gateItem then
        gateItem:remove(1)
        end
        item:transform(1946)
        Game.createTeleport(1387, goPos, telePos)
        return true
        end

        -- Lever OFF (restore gate + remove teleport)
        if item.uid == 10002 and item.itemid == 1946 then
            if not gateItem then
                Game.createItem(1355, 1, gatePos)
                end
                item:transform(1945)

                if teleportItem then
                    teleportItem:remove()
                    end
                    return true
                    end

                    -- Invalid state
                    player:sendCancelMessage("Sorry, not possible.")
                    return true
                    end
