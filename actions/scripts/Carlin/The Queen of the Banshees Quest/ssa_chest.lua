-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Reward chest (stone skin amulet x5)
-- Notes: Modern API + storage check

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate chest AID
if item.actionid ~= 9019 then
  return true
  end

  local storage = 9019

  -- First-time reward check
  if player:getStorageValue(storage) < 1 then
    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a stone skin amulet.")
    player:addItem(2197, 5)
    player:setStorageValue(storage, 1)
    else
      -- Already taken
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
