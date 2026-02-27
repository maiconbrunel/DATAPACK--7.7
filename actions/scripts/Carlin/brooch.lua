-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Quest chest - family brooch
-- Notes: Storage check, reward, message

local UNIQUE_ID = 9025
local STORAGE = 9025
local REWARD_ITEM = 2318 -- family brooch

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= UNIQUE_ID then
  return true
  end

  -- Validate storage
  if player:getStorageValue(STORAGE) <= 0 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a family brooch.")
    player:addItem(REWARD_ITEM, 1) -- Give reward
    player:setStorageValue(STORAGE, 1) -- Mark quest as completed
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The coffin is empty.")
      end

      return true
      end
