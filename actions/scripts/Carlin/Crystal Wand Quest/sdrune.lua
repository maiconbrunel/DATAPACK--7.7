function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9004 then
  return true
  end

  local storage = 9004
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a sudden death rune.")
    player:addItem(2263, 6)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
