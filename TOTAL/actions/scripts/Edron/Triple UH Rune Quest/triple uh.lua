-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (Triple UH)
-- Notes: Fixed broken syntax and modernized

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 1015 then
  return false
  end

  -- Validate first-time reward
  local storage = 1015
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a triple ultimate healing rune.")

    -- Give reward
    player:addItem(2273, 3)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
