-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Party hat visual effect when used on head slot
-- Notes: Updated to Player/Item OO API
-- Changes: Slot check fix, effect fix

function onUse(player, item, fromPosition, target, toPosition)
	-- Must be equipped in the head slot
	local head = player:getSlotItem(CONST_SLOT_HEAD)
	if not head or head:getUniqueId() ~= item:getUniqueId() then
		return false
	end

	-- Effect
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	return true
end

