function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9001 then
  return true
  end

  local storage = 9001
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a griffin shield.")
    player:addItem(2533, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The dead skeleton is empty.")
      end

      return true
      end
