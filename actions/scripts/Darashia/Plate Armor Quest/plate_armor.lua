-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Simple chest reward (plate armor)
-- Notes: Uses modern API and safe reward handling

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10100 then
  return false
  end

  -- Validate first-time reward
  local storage = 10100
  if player:getStorageValue(storage) < 1 and player:getGroup():getAccess() == false then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a plate armor.")

    -- Give reward
    player:addItem(2463, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The wooden coffin is empty.")
      end

      return true
      end
