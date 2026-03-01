-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Lever that opens/closes a gate
-- Notes: Fixed syntax + modern API + safety

function onUse(player, item, fromPosition, target, toPosition)
-- Gate position
local gatePos = Position(33171, 31897, 8)
local gateItem = Tile(gatePos):getItemById(1355)

-- Opening the gate
if item.uid == 10001 and item.itemid == 1945 then
  if gateItem then
    gateItem:remove()
    end
    -- Switch to 1946
    item:transform(1946)
    return true
    end

    -- Closing the gate
    if item.uid == 10001 and item.itemid == 1946 then
      if not gateItem then
        Game.createItem(1355, 1, gatePos)
        end
        -- Switch back to 1945
        item:transform(1945)
        return true
        end

        -- Default fallback
        player:sendCancelMessage("Sorry, not possible.")
        return true
        end
