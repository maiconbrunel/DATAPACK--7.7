-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Shield chest
-- Notes: Minimal conversion and logic fix

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10015 then
  return false
  end

  local storage = 10015

  -- First-time reward check
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    -- Give reward message
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
