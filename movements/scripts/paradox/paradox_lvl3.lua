-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Spawn/remove ladder when a box is added/removed
-- Notes: melhorias, atualizações da API, otimizações

local BOX_ID = 1739      -- box
local LADDER_ID = 1386   -- ladder
local LADDER_POS = Position(32478, 31904, 5)

function onAddItem(item, tileItem, position)
if item:getId() == BOX_ID then
	Game.createItem(LADDER_ID, 1, LADDER_POS)
	end
	end

	function onRemoveItem(item, tileItem, position)
	if item:getId() == BOX_ID then
		local tile = Tile(LADDER_POS)
		local ladder = tile and tile:getItemById(LADDER_ID)
		if ladder then
			ladder:remove()
			end
			end
			end
