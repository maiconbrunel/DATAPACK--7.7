-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Step tiles with wall toggle + teleports
-- Notes: melhorias, atualizações da API, otimizações

local WALL_POS = Position(32225, 32283, 9)
local WALL_CLOSED = 432  -- closed wall
local WALL_OPEN = 424    -- open wall

local TP1_POS = Position(32225, 32275, 10)
local TP2_POS = Position(32232, 32276, 9)

function onStepOut(creature, item, position, fromPosition)
if item.actionid == 4444 then
	local tile = Tile(WALL_POS)
	local wall = tile and tile:getItemById(WALL_CLOSED)

	if wall then
		wall:remove()
		Game.createItem(WALL_OPEN, 1, WALL_POS)
		item:transform(item:getId() + 1)
		end
		end
		end

		function onStepIn(creature, item, position, fromPosition)
		if item.actionid == 4445 then
			creature:teleportTo(TP1_POS)
			TP1_POS:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			return true
			end

			if item.actionid == 4446 then
				creature:teleportTo(TP2_POS)
				TP2_POS:sendMagicEffect(CONST_ME_MAGIC_GREEN)
				return true
				end

				if item.actionid == 4444 then
					local tile = Tile(WALL_POS)
					local wall = tile and tile:getItemById(WALL_OPEN)

					if wall then
						wall:remove()
						Game.createItem(WALL_CLOSED, 1, WALL_POS)
						item:transform(item:getId() - 1)
						end
						end

						return true
						end
