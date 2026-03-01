-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: House bed customization system
-- Notes: Fully rewritten to modern API, tile checks, safe transforms
-- Changes: Transform fix, Tile API, Position fix, remove fix

local BEDS = {
	[7904] = {{1754, 1755}, {1760, 1761}}, -- blue kit
	[7905] = {{7811, 7812}, {7813, 7814}}, -- green kit
	[7906] = {{7815, 7816}, {7817, 7818}}, -- red kit
	[7907] = {{7819, 7820}, {7821, 7822}}  -- yellow kit
}

local function internalBedTransform(kit, bedPiece, toPos, ids)
	-- Transform first bed part
	bedPiece:transform(ids[1])

	-- Transform second bed part
	local tile = Tile(toPos)
	if tile then
		local second = tile:getTopDownItem()
		if second then
			second:transform(ids[2])
		end
	end

	-- Effects
	bedPiece:getPosition():sendMagicEffect(CONST_ME_POFF)
	toPos:sendMagicEffect(CONST_ME_POFF)

	-- Remove kit
	kit:remove(1)
end

function onUse(player, item, fromPosition, target, toPosition)
	-- Verify this is a valid kit & inside a house
	local newBed = BEDS[item:getId()]
	if not newBed then
		return false
	end

	local h = House.getHouseByOwner(player)
	if not h then
		return false
	end

	-- Player must be inside the house
	local tile = Tile(player:getPosition())
	if not tile or not tile:getHouse() then
		return false
	end

	-- Already the same modification?
	if table.contains({newBed[1][1], newBed[2][1]}, target:getId()) then
		player:sendCancelMessage("You already have this bed modification.")
		return true
	end

	-- Bed orientation detection
	for kitId, bed in pairs(BEDS) do
		-- Vertical beds
		if bed[1][1] == target:getId() or target:getId() == 1758 then
			local pos = Position(toPosition.x, toPosition.y + 1, toPosition.z)
			internalBedTransform(item, target, pos, newBed[1])
			return true

		-- Horizontal beds
		elseif bed[2][1] == target:getId() or target:getId() == 1756 then
			local pos = Position(toPosition.x + 1, toPosition.y, toPosition.z)
			internalBedTransform(item, target, pos, newBed[2])
			return true
		end
	end

	return true
end

