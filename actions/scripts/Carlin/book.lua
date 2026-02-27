-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: One-time backpack reward with book text
-- Notes: Modern APIs, storage check fix, safety guards

local UNIQUE_ID = 9026
local STORAGE = 9026

function onUse(player, item, fromPosition, target, toPosition)
if item.uid ~= UNIQUE_ID then
  return true
  end

  -- Validate storage
  if player:getStorageValue(STORAGE) ~= 1 then
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a backpack.")

    -- Give reward
    local bp = player:addItem(1988, 1)
    if bp then
      local book = bp:addItem(1955, 1)
      if book then
        book:setText([[
          ... abbot still clueless abour my ... ...After all those perils and puzzels I have located the throne of darkness at last. I will lead ......... crypts and monsters ... found one of the caged demons that seem to be leached as a powersupply of some sort ......... switches on the end of the scorpion path and the lair of the wicked web ...... died but I could make it to the throne. My wards are holding the howling ghosts and spectres at bay for now and I prepare to unleash the powers of the throne ......... still impossible! My wards are fading and the ancient spirits feel that they will soon claim another victory. I failed the brotherhood and will soon join the howling hords in their eternal torment and madness. ......has stoped. I KNOW they are coming after me now. I can see the flickering of the shadows as they aproach. THEY ARE COMING
        ]])

        book:setActionId(UNIQUE_ID)
        end
        end

        -- Mark quest as completed
        player:setStorageValue(STORAGE, 1)
        else
          player:sendTextMessage(MESSAGE_INFO_DESCR, "The dead human is empty.")
          end

          return true
          end
