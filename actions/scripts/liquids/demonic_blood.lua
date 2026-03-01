-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demonic Blood → Random potion
-- Notes: API modernization, safe transform
-- Changes: Updated to Item:transform, Position API

local POTIONS = {7588, 7589}

function onUse(player, item, fromPosition, target, toPosition)
	item:transform(POTIONS[math.random(#POTIONS)])
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
end

