-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (silver amulet)
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, standardized checks, cleaned structure

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10007 then
  return false
end

local storage = 10007
if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a silver amulet.")
  player:addItem(2170, 1)
  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
end

return true
end
