function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9500 then
  return true
  end

  local status = player:getStorageValue(9500)
  if status == -1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")
    local bag = player:addItem(1987, 1)
    if bag then
      bag:addItem(2175, 1)
      bag:addItem(2145, 2)
      bag:addItem(2148, 100)
      end
      player:setStorageValue(9500, 1)
      else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The small drawer is empty.")
        end

        return true
        end
