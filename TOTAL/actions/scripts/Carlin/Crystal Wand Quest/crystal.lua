function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9003 then
  return true
  end

  local storage = 9003
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a crystal wand.")
    player:addItem(2184, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
