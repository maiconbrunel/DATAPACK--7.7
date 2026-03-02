-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Drowning damage on underwater tiles
-- Notes: melhorias, atualizações da API, otimizações

local conditionDrown = Condition(CONDITION_DROWN)
conditionDrown:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -20)
conditionDrown:setParameter(CONDITION_PARAM_TICKS, -1)
conditionDrown:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	if player:isGhost() then
		return true
		end

		if math.random(1, 10) == 1 then
			position:sendMagicEffect(CONST_ME_BUBBLES)
			end

			player:addCondition(conditionDrown)
			return true
			end

			function onStepOut(creature, item, position, lastPosition, fromPosition, toPosition, actor)
			local player = creature:getPlayer()
			if not player then
				return true
				end

				local slotItem = player:getSlotItem(CONST_SLOT_HEAD)
				if slotItem and slotItem.itemid == 12541 then -- diving helmet
					local groundTile = Tile(toPosition)
					if groundTile then
						local ground = groundTile:getGround()
						if ground and not table.contains(underWater, ground:getId()) then
							slotItem:transform(5461) -- helmet transforms when leaving water
							end
							end
							end

							player:removeCondition(CONDITION_DROWN)
							return true
							end
