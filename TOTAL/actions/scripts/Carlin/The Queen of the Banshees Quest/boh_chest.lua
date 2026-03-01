-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Reward chest (boots of haste)
-- Notes: Uses modern API (player, actionid, storage)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Validate chest AID
if item.actionid ~= 9024 then
  return true
  end

  local storage = 9024

  -- First-time reward check
  if player:getStorageValue(storage) < 1 then
    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found boots of haste.")
    player:addItem(2195, 1)
    player:setStorageValue(storage, 1)
    else
      -- Already taken
      player:sendTextMessage(MESSAGE_INFO_DESCR, "It's empty.")
      end

      return true
      end
