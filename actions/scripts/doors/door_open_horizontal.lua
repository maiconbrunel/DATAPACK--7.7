-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Horizontal door (open)
-- Notes: Fixed API, variables and logic

function onUse(player, item, fromPosition, target, toPosition)
-- Validate PZ
local isPz = fromPosition:getTile():hasFlag(TILESTATE_PROTECTIONZONE)

-- Next tile calculation
local nextTile = Position(fromPosition.x + 1, fromPosition.y, fromPosition.z)
if isPz and not nextTile:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
	nextTile = Position(fromPosition.x - 1, fromPosition.y, fromPosition.z)
	end

	-- Move all creatures/items on the tile
	fromPosition:relocateTo(nextTile)

	-- Transform door
	item:transform(item.itemid - 1)

	return true
	end
