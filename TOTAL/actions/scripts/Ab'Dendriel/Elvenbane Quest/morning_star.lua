-- [PROJECT 7.7 TFS 1.5] Converted script
-- Changes: translated messages, standardized item reward

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9503 then
  return true
end

local storage = 9503
if player:getStorageValue(storage) < 1 then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a morning star.")
  player:addItem(2394, 1) -- morning star
  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
end

return true
end

