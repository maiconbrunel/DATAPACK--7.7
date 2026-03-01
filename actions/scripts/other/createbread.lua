-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Flour + water → dough and bread logic
-- Notes: Modern transform API
-- Changes: Replace doChangeTypeItem, doPlayerAddItem

local LIQUID_CONTAINERS = {
	1775, 2005, 2006, 2007, 2008, 2009, 2011,
	2012, 2013, 2014, 2015, 2023, 2031, 2032, 2033
}

function onUse(player, item, fromPosition, target, toPosition)
	local tItem = Item(target.uid)

	-- Flour + water → dough
	if item.itemid == 2692 and table.contains(LIQUID_CONTAINERS, target.itemid) and target.type == 1 then
		item:transform(item.itemid, item.type - 1)
		player:addItem(2693, 1)

		target:transform(target.itemid, 0)
		return true
	end

	-- Dough + oven → bread
	if target.itemid == 1381 then
		item:transform(item.itemid, item.type - 1)
		player:addItem(2692, 1)
		return true
	end

	return false
end

