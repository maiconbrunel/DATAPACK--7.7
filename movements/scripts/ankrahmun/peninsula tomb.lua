-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in with coin check
-- Notes: Modern API, safe checks, English messages

local COIN_POS = Position(33098, 32816, 13)
local TELEPORT_POS_1 = Position(33093, 32824, 13)
local TELEPORT_POS_2 = Position(33097, 32815, 13)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Check actionid 50110
	if item.actionid == 50110 then
		local tile = Tile(COIN_POS)
		if tile then
			local coinItem = tile:getItemById(2159)
			if coinItem then
				player:teleportTo(TELEPORT_POS_1)
				COIN_POS:sendMagicEffect(CONST_ME_MAGIC_RED)
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				coinItem:remove(1)
				end
				end
				return true
				end

				-- Check actionid 50111
				if item.actionid == 50111 then
					player:teleportTo(TELEPORT_POS_2)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					return true
					end

					return true
					end
