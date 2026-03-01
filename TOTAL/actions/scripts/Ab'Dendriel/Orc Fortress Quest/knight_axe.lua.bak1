function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9506 then
  return true
  end

  local storage = 9506
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a knight axe.")
    player:addItem(2430, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The box is empty.")
      end

      return true
      end
