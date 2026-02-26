-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Reward chest (stealth ring)
-- Notes: Modern API, storage-based reward

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate chest AID
if item.actionid ~= 9022 then
  return true
  end

  local storage = 9022

  -- First-time reward check
  if player:getStorageValue(storage) < 1 then
    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a stealth ring.")
    player:addItem(2165, 1)
    player:setStorageValue(storage, 1)
    else
      -- Already taken
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
