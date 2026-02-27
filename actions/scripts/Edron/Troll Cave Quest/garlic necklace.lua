-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Garlic Necklace chest
-- Notes: Fixed syntax errors + modern API

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10020 then
  return false
  end

  -- Validate first-time reward check
  local storage = 10020
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a garlic necklace.")
    player:addItem(2199, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
