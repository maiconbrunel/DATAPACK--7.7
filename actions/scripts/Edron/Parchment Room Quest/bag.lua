-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Summon Chest
-- Notes: Clean rewrite + API modernizada + correção de bugs críticos

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= 10023 then
  return false
  end

  -- Validate first-time reward
  local storage = 10023
  if player:getStorageValue(storage) < 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag.")

    -- Give reward
    local bag = player:addItem(1987, 1)
    if bag then
      bag:addItem(2165, 1)
      bag:addItem(2151, 2)
      bag:addItem(2230, 1)
      bag:addItem(2229, 1)
      bag:addItem(1948, 1)

      local key = bag:addItem(2091, 1)
      if key then
        key:setActionId(1505)
        end
        end

        -- Mark quest completed
        player:setStorageValue(storage, 1)

        -- Summon demons
        Game.createMonster("Demon", Position(33061, 31622, 15))
        Game.createMonster("Demon", Position(33065, 31622, 15))
        Game.createMonster("Demon", Position(33061, 31628, 15))
        Game.createMonster("Demon", Position(33065, 31628, 15))
        else
          player:sendTextMessage(MESSAGE_INFO_DESCR, "The wooden coffin is empty.")
          end

          return true
          end
