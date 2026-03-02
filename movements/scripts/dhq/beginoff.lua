-- [PROJECT 7.7 TFS 1.5] Converted script
-- melhorias, atualizações da API, otimizações

local WALL_ID = 1050 -- stone wall
local TILE_REQUIRED = 425 -- lava

local walls = {
	Position(33210, 31630, 13),
	Position(33211, 31630, 13),
	Position(33212, 31630, 13)
}

function onStepOut(creature, item, position, fromPosition)
if item.uid ~= 9025 then
	return true
	end

	-- Check if all walls are missing
	for _, pos in ipairs(walls) do
		if Tile(pos):getItemById(WALL_ID) then
			return true
			end
			end

			item:transform(item.itemid + 1)

			for _, pos in ipairs(walls) do
				Game.createItem(WALL_ID, 1, pos)
				end

				return true
				end

				function onStepIn(creature, item, position, fromPosition)
				if item.uid ~= 9025 then
					return true
					end

					local tileCheck = Tile(Position(33191, 31629, 13)):getItemById(TILE_REQUIRED)
					if not tileCheck then
						return true
						end

						-- Check if all walls are present
						for _, pos in ipairs(walls) do
							if not Tile(pos):getItemById(WALL_ID) then
								return true
								end
								end

								item:transform(item.itemid - 1)

								for _, pos in ipairs(walls) do
									local wall = Tile(pos):getItemById(WALL_ID)
									if wall then
										wall:remove()
										end
										end

										return true
										end
