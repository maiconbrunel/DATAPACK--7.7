-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Guardian Halberd chest
-- Notes: Minimal conversion

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10017 then
  return false
  end

  -- First-time reward check
  local storage = 10017
  if player:getStorageValue(storage) < 1 and player:getGroup():getAccess() == false then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a guardian halberd.")

    -- Give reward
    player:addItem(2427, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
