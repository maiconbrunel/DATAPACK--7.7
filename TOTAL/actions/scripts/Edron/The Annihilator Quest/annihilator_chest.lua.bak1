-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Multi-chest reward (Demon Armor / Sword of Valor / Stonecutter's Axe / Present)
-- Notes: Fixed syntax, modern API, safe rewards

function onUse(player, item, fromPosition, target, toPosition)
local storage = 10010

-- Validate
if player:getGroup():getAccess() then
	return true
	end

	local rewardMsg = ""
	local rewardId = nil
	local extraContainerItem = nil

	-- Demon Armor
	if item.uid == 10010 then
		rewardMsg = "You have found a Demon Armor."
		rewardId = 2494

		-- Sword of Valor
		elseif item.uid == 10011 then
			rewardMsg = "You have found a Sword of Valor."
			rewardId = 2400

			-- Stonecutter's Axe
			elseif item.uid == 10012 then
				rewardMsg = "You have found a Stonecutter's Axe."
				rewardId = 2431

				-- Present (contains another item)
				elseif item.uid == 10013 then
					rewardMsg = "You have found a Present."
					rewardId = 1990
					extraContainerItem = 2326

					else
						return false
						end

						-- First-time reward check
						if player:getStorageValue(storage) < 1 then
							player:sendTextMessage(MESSAGE_INFO_DESCR, rewardMsg)

							-- Give reward
							local reward = player:addItem(rewardId, 1)

							-- Add item inside the present
							if extraContainerItem then
								reward:addItem(extraContainerItem, 1)
								end

								-- Mark quest as completed
								player:setStorageValue(storage, 1)
								else
									player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
									end

									return true
									end
