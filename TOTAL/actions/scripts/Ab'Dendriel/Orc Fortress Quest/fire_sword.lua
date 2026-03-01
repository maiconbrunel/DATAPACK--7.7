-- [PROJECT 7.7 TFS 1.5] Converted script
-- Changes: translated messages, cleaned condition block

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9504 then
  return true
end

local storage = 9504
if player:getStorageValue(storage) < 1 then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a fire sword.")
  player:addItem(2392, 1) -- fire sword
  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The box is empty.")
end

return true
end

