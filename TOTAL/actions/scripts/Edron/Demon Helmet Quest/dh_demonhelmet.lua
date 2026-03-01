-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Helmet chest
-- Notes: Fixed broken syntax, modern API, safe reward

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10003 then
  return false
  end

  -- Validate first-time reward
  local storage = 10003
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a demon helmet.")

    -- Give reward
    player:addItem(2493, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
