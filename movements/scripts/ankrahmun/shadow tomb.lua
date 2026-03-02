-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin check
-- Notes: Modern API, optimized, safe checks

local COIN_POS = Position(33240, 32855, 13)
local TELEPORT_POS_1 = Position(33246, 32850, 13)
local TELEPORT_POS_2 = Position(33239, 32856, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- actionid 50114: requires crystal coin
	if item.actionid == 50114 then
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

				-- actionid 50115: teleport back
				if item.actionid == 50115 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
