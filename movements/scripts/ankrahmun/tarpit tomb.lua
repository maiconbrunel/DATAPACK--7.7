-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin consumption
-- Notes: Modern API, safety checks, optimized logic

local COIN_POS = Position(33234, 32692, 13)
local TELEPORT_POS_1 = Position(33234, 32687, 13)
local TELEPORT_POS_2 = Position(33234, 32693, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Action 50122: Requires crystal coin (2159)
	if item.actionid == 50122 then
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

				-- Action 50123: Simple teleport back
				if item.actionid == 50123 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
