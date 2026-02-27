-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (steel shield)
-- Notes: Fixed message API, reward, storage, logic and syntax

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10006 then
  return false
  end

  -- Validate first-time reward
  local storage = 10006
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a steel shield.")

    -- Give reward
    player:addItem(2509, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
