-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door/Window interaction
-- Notes: Auto-corrected and fixed

function onUse(player, item, fromPosition, target, toPosition)
-- Validate tile
local tile = fromPosition:getTile()
if not tile then
	return true
	end

	-- Are we on PZ?
	local isPz = tile:hasFlag(TILESTATE_PROTECTIONZONE)

	-- Compute next tile
	local nextTile = Position(fromPosition.x, fromPosition.y + 1, fromPosition.z)

	-- Check PZ for movement direction
	if isPz and not nextTile:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
		nextTile = Position(fromPosition.x, fromPosition.y - 1, fromPosition.z)
		end

		-- Move all movable things
		fromPosition:relocateTo(nextTile)

		-- Transform the door
		item:transform(item.itemid - 1)

		return true
		end
