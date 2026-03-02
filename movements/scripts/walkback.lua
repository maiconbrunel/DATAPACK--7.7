-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Prevent stepping into containers & unsafe tiles
-- Notes: melhorias, atualizações da API, otimizações

local SPECIAL_QUESTS = {2001}

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	local isContainerItem = Item(item.uid):isContainer()
	local tileFrom = Tile(fromPosition)
	local tileTo = Tile(position)

	if (
		(isContainerItem and not table.contains(SPECIAL_QUESTS, item.actionid) and item.uid > 65535)
		or (fromPosition.x ~= 0 and tileFrom and tileFrom:hasFlag(TILESTATE_FLOORCHANGE_DOWN))
		or (not isContainerItem and tileTo and tileTo:getCreatureCount() <= 1)
	) then
	return true
	end

	-- player just logged in
	if fromPosition.x == 0 then
		fromPosition = Town(player:getTown()):getTemplePosition()
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end

		player:teleportTo(fromPosition, true)
		return true
		end
