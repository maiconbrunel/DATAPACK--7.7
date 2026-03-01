-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door/Window interaction
-- Notes: Auto-converted and fixed

function onUse(player, item, fromPosition, target, toPosition)
-- Make it a normal door if actionid is 0
if item.actionid == 0 then
	-- Transform to the next door state
	item:transform(item.itemid + 1)
	return true
	end

	-- Validate player storage
	local storageValue = player:getStorageValue(item.actionid)
	local canEnter = (storageValue == 1)

	if not canEnter then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The door is sealed against unwanted intruders.")
		return true
		end

		-- Open door
		item:transform(item.itemid + 1)

		-- Validate if player can move to door tile
		local tile = Tile(fromPosition)
		if not tile then
			return false
			end

			-- Validate walkability
			if tile:queryAdd(player) ~= RETURNVALUE_NOERROR then
				return false
				end

				-- Move player
				local dir = player:getPosition():getDirectionTo(fromPosition)
				player:move(dir)

				return true
				end
