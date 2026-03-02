-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Trash holder outfit trigger
-- Notes: melhorias, atualizações da API, otimizações

local outfit = {
	lookType = 267,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookTypeEx = 0,
	lookAddons = 0
}

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if player:hasCondition(CONDITION_OUTFIT) and player:getOutfit().lookType == outfit.lookType then
		player:removeCondition(CONDITION_OUTFIT)
		position:sendMagicEffect(CONST_ME_POFF)
		end
		return true
		end

		function onStepOut(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return true
			end

			local tile = Tile(fromPosition)
			if not tile then
				return true
				end

				local info = tile:getInfo()
				if info and info.trashHolder then
					if Tile(fromPosition):queryAdd(player) ~= RETURNVALUE_NOERROR then
						return false
						end

						fromPosition:sendMagicEffect(CONST_ME_POFF)
						fromPosition:sendMagicEffect(CONST_ME_WATERSPLASH)

						player:removeConditions(true)
						player:setOutfit(outfit)
						end

						return true
						end
