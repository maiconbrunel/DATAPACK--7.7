-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Vampire Shield chest
-- Notes: Fixed syntax + modern API

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10022 then
  return false
  end

  local storage = 10022

  -- Validate first-time reward
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a vampire shield.")

    -- Give reward
    player:addItem(2534, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
