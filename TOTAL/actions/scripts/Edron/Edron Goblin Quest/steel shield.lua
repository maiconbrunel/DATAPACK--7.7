-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Chest reward (steel shield)
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, storage fix, syntax cleanup

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10006 then
  return false
end

local storage = 10006
if player:getStorageValue(storage) < 1 and not player:getGroup():getAccess() then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a steel shield.")
  player:addItem(2509, 1)
  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
end

return true
end
