-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Simple quest reward (stone coffin)
-- Notes: Storage check, reward grant, message, safe API

function onUse(player, item, fromPosition, target, toPosition)
-- Validate quest
local storage = 10101
if item.uid ~= storage then
  return false
  end

  -- First-time reward check
  if player:getStorageValue(storage) < 1 and player:getGroup():getAccess() == false then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a reward.")

    -- Give reward
    player:addItem(2536, 1) -- tower shield
    player:addItem(2436, 1) -- skull staff
    player:addItem(2656, 1) -- blue robe

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The stone coffin is empty.")
      end

      return true
      end
