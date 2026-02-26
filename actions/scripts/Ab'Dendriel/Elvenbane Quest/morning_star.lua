function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9503 then
  return true
  end

  local storage = 9503
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a morning star.")
    player:addItem(2394, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
