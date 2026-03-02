-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Snow tiles turning into footprints
-- Notes: melhorias, atualizações da API, otimizações

local TILE_SNOW = 670                -- snow
local TILE_FOOTPRINT_I = 6594        -- first footprint
local TILE_FOOTPRINT_II = 6598       -- second footprint

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player or player:isGhost() then
	return true
	end

	local id = item:getId()

	if id == TILE_SNOW then
		item:transform(TILE_FOOTPRINT_I)
		item:decay()
		elseif id == TILE_FOOTPRINT_I then
			item:transform(TILE_FOOTPRINT_II)
			item:decay()
			else
				item:transform(TILE_FOOTPRINT_I)
				end

				return true
				end
