-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Barbarian Axe + Scimitar chest
-- Notes: Cleaned, validated and aligned with TFS 1.5 API

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10000 then
  return false
  end

  local storage = 10000

  -- Validate first-time reward
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a barbarian axe and a scimitar.")

    -- Give reward
    player:addItem(2429, 1) -- barbarian axe
    player:addItem(2419, 1) -- scimitar

    -- Mark quest as completed
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
