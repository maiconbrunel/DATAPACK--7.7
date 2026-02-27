-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (silver amulet)
-- Notes: Minimal conversion + syntax fixes

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10007 then
  return false
  end

  -- Validate first-time reward
  local storage = 10007
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    -- Give reward message
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a silver amulet.")

    -- Give reward
    player:addItem(2170, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
