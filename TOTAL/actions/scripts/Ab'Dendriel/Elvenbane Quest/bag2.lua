-- [PROJECT 7.7 TFS 1.5] Converted script
-- Changes: translated messages, standardized storage check, minor cleanup

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.actionid ~= 9501 then
  return true
end

local value = player:getStorageValue(9501)
if value <= 0 and player:getGroup():getAccess() == false then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

  local bag = player:addItem(1987, 1) -- bag
  if bag then
    bag:addItem(2006, 7) -- vial
    bag:addItem(2260, 1) -- blank rune
  end

  player:setStorageValue(9501, 1)
else
  player:sendTextMessage(MESSAGE_INFO_DESCR, "The small drawer is empty.")
end

return true
end

