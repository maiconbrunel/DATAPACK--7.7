-- [PROJECT 7.7 TFS 1.5] Converted script
-- Changes: translated messages, storage normalization

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9505 then
  return true
end

local storage = 9505
if player:getStorageValue(storage) < 1 then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a knight armor.")
  player:addItem(2476, 1) -- knight armor
  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The box is empty.")
end

return true
end

