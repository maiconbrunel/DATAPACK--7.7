-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Step tiles toggling a wall
-- Notes: melhorias, atualizações da API, otimizações

local WALL_POS = Position(32225, 32283, 9)
local WALL_ID_A = 432 -- stone wall (closed)
local WALL_ID_B = 424 -- stone wall (open)

function onStepOut(creature, item, position, fromPosition)
if item.actionid == 4444 then
	local tile = Tile(WALL_POS)
	local wall = tile and tile:getItemById(WALL_ID_A)

	if wall then
		wall:remove()
		Game.createItem(WALL_ID_B, 1, WALL_POS)
		item:transform(item:getId() + 1)
		end
		end
		end

		function onStepIn(creature, item, position, fromPosition)
		if item.actionid == 4444 then
			local tile = Tile(WALL_POS)
			local wall = tile and tile:getItemById(WALL_ID_B)

			if wall then
				wall:remove()
				Game.createItem(WALL_ID_A, 1, WALL_POS)
				item:transform(item:getId() - 1)
				end
				end
				end
