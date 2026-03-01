-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Fire Axe reward chest
-- Notes: Cleaned structure and fixed indentation

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10008 then
  return false
  end

  -- Validate first-time reward
  local storage = 10008
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a fire axe.")

    -- Create bag
    local bag = player:addItem(1987, 1)
    if bag then
      bag:addItem(2214, 1)
      bag:addItem(2201, 1)
      bag:addItem(2145, 7)
      end

      -- Fire axe
      player:addItem(2432, 1)

      -- Mark quest as completed
      player:setStorageValue(storage, 1)
      else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The corpse is empty.")
        end

        return true
        end
