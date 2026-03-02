-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin check
-- Notes: Modern API, optimizations, safe checks

local COIN_POS = Position(33072, 32589, 13)
local TELEPORT_POS_1 = Position(33080, 32589, 13)
local TELEPORT_POS_2 = Position(33071, 32590, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- AID 50116: requires a crystal coin on the tile
	if item.actionid == 50116 then
		local tile = Tile(COIN_POS)
		if tile then
			local coinItem = tile:getItemById(2159) -- Crystal Coin
			if coinItem then
				player:teleportTo(TELEPORT_POS_1)
				COIN_POS:sendMagicEffect(CONST_ME_MAGIC_RED)
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				coinItem:remove(1)
				end
				end
				return true
				end

				-- AID 50117: simple teleport
				if item.actionid == 50117 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
