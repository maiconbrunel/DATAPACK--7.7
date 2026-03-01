-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (brass legs)
-- Notes: Fixed broken syntax and modernized

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10019 then
  return false
  end

  -- Validate first-time reward
  local storage = 10019
  if player:getStorageValue(storage) < 1 and player:getGroup():getAccess() == false then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found brass legs.")

    -- Give reward
    player:addItem(2478, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
