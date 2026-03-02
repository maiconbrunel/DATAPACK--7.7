-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Skull puzzle entrance trigger
-- Notes: melhorias, atualizações da API, otimizações

local SKULL_IDS = {2229} -- skull
local NEW_SKULL_ID = 1496 -- bone pile
local EFFECT = CONST_ME_POFF
local ENTRANCE_POS = Position(32481, 31926, 7)

local SKULL_POSITIONS = {
	Position(32563, 31957, 1),
	Position(32565, 31957, 1),
	Position(32567, 31957, 1),
	Position(32569, 31957, 1),
}

function onStepIn(creature, item, position, fromPosition)
if item.actionid ~= 8006 then
	return true
	end

	-- Check skulls
	for _, pos in ipairs(SKULL_POSITIONS) do
		local tile = Tile(pos)
		if not tile or not tile:getItemById(SKULL_IDS[1]) then
			return true
			end
			end

			-- Replace skulls
			for _, pos in ipairs(SKULL_POSITIONS) do
				local tile = Tile(pos)
				local skull = tile:getItemById(SKULL_IDS[1])
				if skull then skull:remove() end
					Game.createItem(NEW_SKULL_ID, 1, pos)
					pos:sendMagicEffect(EFFECT)
					end

					-- Teleport player
					creature:teleportTo(ENTRANCE_POS)
					ENTRANCE_POS:sendMagicEffect(EFFECT)
					return true
					end
