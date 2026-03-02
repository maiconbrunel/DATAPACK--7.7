-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin check
-- Notes: Modern API, optimized logic

local COIN_POS = Position(33293, 32741, 13)
local TELEPORT_POS_1 = Position(33299, 32742, 13)
local TELEPORT_POS_2 = Position(33292, 32742, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- ActionID 50112 (requires coin)
	if item.actionid == 50112 then
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

				-- ActionID 50113
				if item.actionid == 50113 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
