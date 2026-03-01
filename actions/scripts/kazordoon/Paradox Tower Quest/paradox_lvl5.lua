-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Paradox Tower – Level 5 puzzle
-- Notes: Updated tile API, addEvent fix, safe removals
-- Changes: Rewritten logic

local LADDER_POS = Position(32479, 31904, 3)

local function changeBack()
	local tile = Tile(LADDER_POS)
	local ladder = tile and tile:getItemById(1386)
	if ladder then
		ladder:remove()
	end
end

local FOODS = {
	{pos = Position(32478, 31903, 3), id = 2628},
	{pos = Position(32479, 31903, 3), id = 2634}
}

function onUse(player, item, fromPosition, target, toPosition)
	if item.actionid ~= 8005 then
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
				f.pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			end
		end

		addEvent(changeBack, 45000)
		item:transform(1946)
		return true
	end

	if item.itemid == 1946 then
		item:transform(1945)
	end

	return true
end

