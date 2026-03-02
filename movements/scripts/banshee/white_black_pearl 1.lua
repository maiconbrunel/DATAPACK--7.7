-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Dual item tile check teleport
-- Notes: Modern API, safe validation, real Tibia behavior

local WHITE_POS = Position(32173, 31871, 15)
local BLACK_POS = Position(32180, 31871, 15)
local SUCCESS_POS = Position(32176, 31863, 15)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9015 then
		return true
		end

		local whiteTile = Tile(WHITE_POS)
		local blackTile = Tile(BLACK_POS)

		if not whiteTile or not blackTile then
			return true
			end

			local whiteItem = whiteTile:getItemById(2143) -- white pearl
			local blackItem = blackTile:getItemById(2144) -- black pearl

			if whiteItem and blackItem then
				player:teleportTo(SUCCESS_POS)

				whiteItem:remove(1)
				blackItem:remove(1)

				WHITE_POS:sendMagicEffect(CONST_ME_POFF)
				BLACK_POS:sendMagicEffect(CONST_ME_POFF)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				else
					local failPos = Position(position.x, position.y + 2, position.z)
					player:teleportTo(failPos)
					failPos:sendMagicEffect(CONST_ME_TELEPORT)
					end

					return true
					end
