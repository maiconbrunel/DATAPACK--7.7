-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Gem enchanting system
-- Notes: API modernized, logic corrected, safety checks added
-- Changes: Player methods, Tile checks, transform fixes, mana/soul cost logic

local config = {
	hardcoreManaSpent = configManager.getBoolean("addManaSpentInPvPZone"),
	manaCost = 300,
	soulCost = 2
}

function onUse(player, item, fromPosition, target, toPosition)
	-- Basic rubies → small enchanted item
	if item:getId() == 2147 and target:getId() == 2342 then
		target:transform(2343)
		target:decay()
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		return true
	end

	-- Ancient stone → change to special form
	if item:getId() == 7760 and table.contains({9934, 10022}, target:getId()) then
		target:transform(9933)
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		return true
	end

	-- Green gem variants
	if item:getId() == 7761 and table.contains({9949, 9954}, target:getId()) then
		target:transform(target:getId() - 1)
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		return true
	end

	-- Enchantable gems (stage 1)
	if table.contains(enchantableGems, item:getId()) then
		local subtype = item:getSubType()
		if subtype == 0 then
			subtype = 1
		end

		local mana = config.manaCost * subtype
		if player:getMana() < mana then
			player:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
			return true
		end

		local soul = config.soulCost * subtype
		if player:getSoul() < soul then
			player:sendCancelMessage(RETURNVALUE_NOTENOUGHSOUL)
			return true
		end

		local index = table.find(enchantableGems, item:getId())
		if not index or not table.contains(enchantingAltars[index], target:getId()) then
			return false
		end

		player:addMana(-mana)
		player:addSoul(-soul)

		item:transform(enchantedGems[index])

		local pos = player:getPosition()
		if (not player:hasFlag(PlayerFlag_NotGainMana)) then
			local tile = Tile(pos)
			if tile and (not tile:hasFlag(TILESTATE_HARDCOREZONE) or config.hardcoreManaSpent) then
				player:addManaSpent(mana)
			end
		end

		fromPosition:sendMagicEffect(CONST_ME_HOLYDAMAGE)
		return true
	end

	-- Enchanted gems (stage 2)
	if table.contains(enchantedGems, item:getId()) then
		if not table.contains(enchantableItems, target:getId()) then
			fromPosition:sendMagicEffect(CONST_ME_POFF)
			return false
		end

		local index = table.find(enchantedGems, item:getId())
		if not index then
			return false
		end

		local subtype = target:getSubType()
		if not table.contains({2544, 8905}, target:getId()) then
			subtype = 1000
		end

		local newItemId = enchantedItems[target:getId()][index]
		target:transform(newItemId, subtype)

		local targetPos = target:getPosition()
		targetPos:sendMagicEffect(CONST_ME_HOLYDAMAGE)

		target:decay()
		item:remove(1)

		return true
	end

	return false
end

