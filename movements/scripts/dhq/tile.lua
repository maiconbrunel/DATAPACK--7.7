-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: StepIn wall toggle
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Wall positions
	local wallPos  = Position(33210, 31630, 13)
	local wallPos1 = Position(33211, 31630, 13)
	local wallPos2 = Position(33212, 31630, 13)

	-- Tile positions
	local tilePos  = Position(33190, 31629, 13)
	local tilePos2 = Position(33191, 31629, 13)

	-- Get items (real Tibia 7.7 method)
	local tileItem  = Tile(tilePos):getItemById(425)  -- 425 = lever/tile?
	local tileItem2 = Tile(tilePos2):getItemById(425)

	local tileItemAlt  = Tile(tilePos):getItemById(426)
	local tileItemAlt2 = Tile(tilePos2):getItemById(426)

	local wall   = Tile(wallPos):getItemById(1050)   -- 1050 = stone wall?
	local wall1  = Tile(wallPos1):getItemById(1050)
	local wall2  = Tile(wallPos2):getItemById(1050)

	-- Remove walls condition
	if tileItem and tileItem2 then
		if wall then wall:remove() end
			if wall1 then wall1:remove() end
				if wall2 then wall2:remove() end
					player:sendTextMessage(MESSAGE_STATUS_WARNING, "You moved the wall.")
					return true
					end

					-- Create walls condition
					if tileItemAlt and tileItemAlt2 and not wall and not wall1 and not wall2 then
						Game.createItem(1050, 1, wallPos)
						Game.createItem(1050, 1, wallPos1)
						Game.createItem(1050, 1, wallPos2)
						return true
						end

						player:sendCancelMessage("Sorry, not possible.")
						return true
						end
