-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Elvenbane reward bag
-- Notes: melhorias, atualizações da API, otimizações
-- Changes: translated messages, added item comments, unified layout

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9500 then
  return true
end

local status = player:getStorageValue(9500)
if status == -1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")
    local bag = player:addItem(1987, 1) -- Bag (1987)
    if bag then
      bag:addItem(2175, 1) -- Spellbook (2175)
      bag:addItem(2145, 2) -- Small Diamonds (2145)
      bag:addItem(2148, 100) -- Gold Coins (2148)
    end
    player:setStorageValue(9500, 1)
else
    player:sendTextMessage(MESSAGE_INFO_DESCR, "The small drawer is empty.")
end

return true
end

