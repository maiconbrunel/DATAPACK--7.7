-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pumpkin head → lighted pumpkin / knife tool handler
-- Notes: API modernized, fix transform/remove/decay
-- Changes: ItemType fix, TOOL handler fix

local PUMPKIN_HEAD_LIGHT = 2097
local CANDLE = 2048
local KNIFE = 2566

function onUse(player, item, fromPosition, target, toPosition)
	-- Pumpkin + candle → lighted pumpkin
	if item:getId() == PUMPKIN_HEAD and target:getId() == CANDLE then
		item:transform(PUMPKIN_HEAD_LIGHT)
		target:remove(1)
		item:decay()
		return true
	end

	-- Knife tool fallback (TOOLS.KNIFE)
	if item:getId() == KNIFE then
		return TOOLS.KNIFE(player, item, fromPosition, target, toPosition)
	end

	return false
end

