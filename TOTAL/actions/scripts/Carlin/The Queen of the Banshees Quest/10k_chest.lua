function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9023 then
  return true
  end

  local storage = 9023
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found 100 platinum coins.")
    player:addItem(2152, 100)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
      end

      return true
      end
