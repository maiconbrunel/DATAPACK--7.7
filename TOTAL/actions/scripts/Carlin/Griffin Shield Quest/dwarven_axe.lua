function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9002 then
  return true
  end

  local storage = 9002
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a dwarven axe.")
    player:addItem(2435, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The dead skeleton is empty.")
      end

      return true
      end
