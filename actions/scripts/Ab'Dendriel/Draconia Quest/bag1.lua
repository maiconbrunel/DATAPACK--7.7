-- chest_bag.lua (TFS 1.5 - Downgrade 7.72)

function onUse(player, item, fromPosition, target, toPosition)
-- ActionID check
if item:getActionId() ~= 9509 then
  return false
  end

  -- Storage check
  local storage = 9509
  if player:getStorageValue(storage) > 0 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
    return true
    end

    -- Give reward
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

    local bag = player:addItem(1987, 1) -- Bag
    if bag then
      bag:addItem(2396, 1) -- Fire Sword
      bag:addItem(2409, 1) -- Serpent Sword
      end

      player:setStorageValue(storage, 1)
      return true
      end
