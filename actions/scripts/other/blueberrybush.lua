-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Blueberry bush drop
-- Notes: API modern
-- Changes: Game.createItem

function onUse(player, item, fromPosition, target, toPosition)
	Game.createItem(2677, 3, fromPosition)
	return false
end

