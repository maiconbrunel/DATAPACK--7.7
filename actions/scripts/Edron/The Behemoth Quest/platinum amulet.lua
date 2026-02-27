-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (bag with items)
-- Notes: Fully fixed and modernized

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10018 then
  return false
  end

  -- Validate first-time reward
  local storage = 10018
  if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

    -- Give bag
    local bag = player:addItem(1987, 1)
    if not bag then
      return true
      end

      -- Give items inside the bag
      bag:addItem(2171, 1)
      bag:addItem(2168, 1)
      bag:addItem(2124, 1)
      bag:addItem(2145, 3)
      bag:addItem(2146, 4)

      -- Mark quest as completed
      player:setStorageValue(storage, 1)
      else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
        end

        return true
        end
