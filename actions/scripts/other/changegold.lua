-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Coin conversion system
-- Notes: Fixed stack handling, effect display, and player flags with individual coin animations

local coins = {
	[ITEM_GOLD_COIN] = {
		to = ITEM_PLATINUM_COIN, effect = COLOR_YELLOW
	},
	[ITEM_PLATINUM_COIN] = {
		from = ITEM_GOLD_COIN, to = ITEM_CRYSTAL_COIN, effectUp = COLOR_LIGHTBLUE, effectDown = COLOR_YELLOW
	},
	[ITEM_CRYSTAL_COIN] = {
		from = ITEM_PLATINUM_COIN, effect = COLOR_TEAL
	}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if getPlayerFlagValue(cid, PLAYERFLAG_CANNOTPICKUPITEM) then
		return false
	end

	local coin = coins[item.itemid]
	if not coin then
		return false
	end

	local itemStack = item.type
	local player = cid

	-- Convert up if full stack
	if coin.to and itemStack == ITEMCOUNT_MAX then
		doRemoveItem(item.uid, ITEMCOUNT_MAX)
		doPlayerAddItem(player, coin.to, 1)
		local effect = coin.effectUp or coin.effect
		doSendAnimatedText(fromPosition, "$$$", effect)

	-- Convert down if not full stack (break stack)
	elseif coin.from then
		doRemoveItem(item.uid, 1)
		doPlayerAddItem(player, coin.from, ITEMCOUNT_MAX)
		local effect = coin.effectDown or coin.effect
		doSendAnimatedText(fromPosition, "$$$", effect)
	end

	return true
end
