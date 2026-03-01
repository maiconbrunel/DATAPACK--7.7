function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9000 then
  return true
  end

  local storage = 9000
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found an obsidian lance.")
    player:addItem(2425, 1)
    player:setStorageValue(storage, 1)
    else
      player:sendTextMessage(MESSAGE_INFO_DESCR, "The dead human is empty.")
      end

      return true
      end
