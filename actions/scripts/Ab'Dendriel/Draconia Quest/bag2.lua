-- Chest Quest - Converted to TFS 1.5 (Downgrade 7.72)

local STORAGE = 9510

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- Ensure correct chest UID
if item.uid ~= STORAGE then
  return false
  end

  -- Quest not completed yet
  if player:getStorageValue(STORAGE) <= 0 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

    -- Create bag (1987)
    local bag = player:addItem(1987, 1)
    if bag then
      bag:addItem(2197, 1) -- SSA
      bag:addItem(2167, 1) -- Energy ring (unactivated)
      end

      player:setStorageValue(STORAGE, 1)
      else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
        end

        return true
        end
