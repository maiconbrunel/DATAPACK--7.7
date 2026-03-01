-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Shield chest
-- Notes: Fixed broken API calls, corrected message syntax, modernized storage

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10004 then
  return false
  end

  -- Validate first-time reward
  local storage = 10004
  if player:getStorageValue(storage) < 1 and player:getGroup():getAccess() == false then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a demon shield.")

    -- Give reward
    player:addItem(2520, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
