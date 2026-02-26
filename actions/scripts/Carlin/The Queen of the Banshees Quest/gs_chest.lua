-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Reward chest (giant sword)
-- Notes: Uses modern API, storage check, actionid lock

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate chest AID
if item.actionid ~= 9021 then
  return true
  end

  local storage = 9021

  -- First-time reward check
  if player:getStorageValue(storage) < 1 then
    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a giant sword.")
    player:addItem(2393, 1)
    player:setStorageValue(storage, 1)
    else
      -- Already taken
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
