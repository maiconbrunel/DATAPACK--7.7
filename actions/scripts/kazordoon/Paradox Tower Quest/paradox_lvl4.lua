-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Paradox Tower – Level 4 food puzzle
-- Notes: Updated to TFS 1.5, new Tile API, safe removals
-- Changes: Fully rewritten logic, removed getThingfromPos

local FOODS = {
	{pos = Position(32476, 31900, 4), id = 2682},
	{pos = Position(32477, 31900, 4), id = 2676},
	{pos = Position(32478, 31900, 4), id = 2679},
	{pos = Position(32479, 31900, 4), id = 2674},
	{pos = Position(32480, 31900, 4), id = 2681},
	{pos = Position(32481, 31900, 4), id = 2678}
}

local LADDER_POS = Position(32478, 31904, 4)

function onUse(player, item, fromPosition, target, toPosition)
	if item.actionid ~= 8004 then
		return true
	end

	if item.itemid == 1945 then
		for _, f in ipairs(FOODS) do
			local tile = Tile(f.pos)
			if not tile or not tile:getItemById(f.id) then
				return true
			end
		end

		Game.createItem(1386, 1, LADDER_POS)

		for _, f in ipairs(FOODS) do
			local tile = Tile(f.pos)
			local food = tile and tile:getItemById(f.id)
			if food then
				food:remove()
				f.pos:sendMagicEffect(CONST_ME_POFF)
			end
		end

		item:transform(1946)
		return true
	end

	if item.itemid == 1946 then
		local tile = Tile(LADDER_POS)
		local ladder = tile and tile:getItemById(1386)
		if ladder then
			ladder:remove()
		end

		item:transform(1945)
	end

	return true
end

