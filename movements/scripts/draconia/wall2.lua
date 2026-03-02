-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Step tiles toggling a wall
-- Notes: melhorias, atualizações da API, otimizações

local WALL_POS = Position(32796, 31576, 5)
local WALL_ID = 1025 -- stone wall

function onStepOut(creature, item, position, fromPosition)
if item.actionid == 9601 then
	local tile = Tile(WALL_POS)
	local wall = tile and tile:getItemById(WALL_ID)

	if not wall then
		item:transform(item:getId() + 1)
		Game.createItem(WALL_ID, 1, WALL_POS)
		end
		end
		end

		function onStepIn(creature, item, position, fromPosition)
		if item.actionid == 9601 then
			local tile = Tile(WALL_POS)
			local wall = tile and tile:getItemById(WALL_ID)

			if wall then
				item:transform(item:getId() - 1)
				wall:remove()
				end
				end
				end
