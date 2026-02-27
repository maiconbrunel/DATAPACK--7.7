-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Dragon Lance chest
-- Notes: Cleaned and fixed logic

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10021 then
  return false
  end

  -- Validate first-time reward
  local storage = 10021
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a dragon lance.")

    -- Give reward
    player:addItem(2414, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
