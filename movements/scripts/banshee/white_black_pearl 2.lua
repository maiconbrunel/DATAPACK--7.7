-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Dual item tile check teleport
-- Notes: Modern API, safe tile checks, real Tibia behavior

local WHITE_POS = Position(32173, 31871, 15)
local BLACK_POS = Position(32180, 31871, 15)
local TELEPORT_POS = Position(32177, 31863, 15)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if item.actionid ~= 9016 then
		return true
		end

		local whiteTile = Tile(WHITE_POS)
		local blackTile = Tile(BLACK_POS)

		local whiteItem = whiteTile and whiteTile:getItemById(2143) -- White Pearl
		local blackItem = blackTile and blackTile:getItemById(2144) -- Black Pearl

		if whiteItem and blackItem then
			whiteItem:remove(1)
			blackItem:remove(1)

			WHITE_POS:sendMagicEffect(CONST_ME_POFF)
			BLACK_POS:sendMagicEffect(CONST_ME_POFF)

			player:teleportTo(TELEPORT_POS)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			else
				local fallbackPos = Position(position.x, position.y + 2, position.z)
				player:teleportTo(fallbackPos)
				fallbackPos:sendMagicEffect(CONST_ME_POFF)
				end

				return true
				end
