-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Piggy bank item rewards
-- Notes: API modernized, transform fix, item remove fix
-- Changes: addItem fix, effect fix, random logic clean

function onUse(player, item, fromPosition, target, toPosition)
	-- 1/6 chance
	if math.random(1, 6) == 1 then
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(ITEM_GOLD_COIN, 1)
		item:transform(2115)
	else
		fromPosition:sendMagicEffect(CONST_ME_SOUND_YELLOW)
		player:addItem(ITEM_PLATINUM_COIN, 1)
	end

	return true
end

