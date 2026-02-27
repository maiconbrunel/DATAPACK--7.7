-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (steel boots)
-- Notes: Cleaned & standardized

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10005 then
  return false
  end

  -- Validate first-time reward
  local storage = 10005
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    -- Give reward message
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a pair of steel boots.")

    -- Give reward
    player:addItem(2645, 1)

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
