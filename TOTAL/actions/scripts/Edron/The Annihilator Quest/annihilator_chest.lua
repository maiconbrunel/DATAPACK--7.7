-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Multi reward chest
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: English messages, standardized checks, cleaned structure

function onUse(player, item, fromPosition, target, toPosition)
local storage = 10010

if player:getGroup():getAccess() then
  return true
end

local msg = ""
local rewardId = nil
local extraItem = nil

if item.uid == 10010 then
  msg = "You have found a Demon Armor."
  rewardId = 2494
elseif item.uid == 10011 then
  msg = "You have found a Sword of Valor."
  rewardId = 2400
elseif item.uid == 10012 then
  msg = "You have found a Stonecutter's Axe."
  rewardId = 2431
elseif item.uid == 10013 then
  msg = "You have found a Present."
  rewardId = 1990
  extraItem = 2326
else
  return false
end

if player:getStorageValue(storage) < 1 then
  player:sendTextMessage(MESSAGE_INFO_DESCR, msg)

  local reward = player:addItem(rewardId, 1)
  if extraItem then reward:addItem(extraItem, 1) end

  player:setStorageValue(storage, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
end

return true
end
