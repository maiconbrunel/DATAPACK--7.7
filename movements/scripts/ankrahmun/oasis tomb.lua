-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin check
-- Notes: Modern API, safe checks, optimizations

local COIN_POS = Position(33135, 32682, 13)
local TELEPORT_POS_1 = Position(33130, 32683, 13)
local TELEPORT_POS_2 = Position(33136, 32683, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- ActionID 50118 (requires Crystal Coin)
	if item.actionid == 50118 then
		local tile = Tile(COIN_POS)
		if tile then
			local coin = tile:getItemById(2159) -- Crystal Coin
			if coin then
				player:teleportTo(TELEPORT_POS_1)
				COIN_POS:sendMagicEffect(CONST_ME_MAGIC_RED)
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				coin:remove(1)
				end
				end
				return true
				end

				-- ActionID 50119 (simple teleport)
				if item.actionid == 50119 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
