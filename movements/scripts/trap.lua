-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Trap tile damage + transform
-- Notes: melhorias, atualizações da API, otimizações

local TRAP_ID = 2579 -- spike trap

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()

if item.itemid == TRAP_ID then
	if not player then
		doTargetCombatHealth(0, creature, COMBAT_PHYSICALDAMAGE, -15, -30, CONST_ME_NONE)
		item:transform(item:getId() - 1)
		end
		else
			if player then
				doTargetCombatHealth(0, creature, COMBAT_PHYSICALDAMAGE, -50, -100, CONST_ME_NONE)
				item:transform(item:getId() + 1)
				end
				end

				return true
				end

				function onStepOut(creature, item, position, fromPosition)
				item:transform(item:getId() - 1)
				return true
				end

				function onRemoveItem(item, tile, position)
				local thingPos = item:getPosition()
				if thingPos:getDistance(position) > 0 then
					item:transform(item:getId() - 1)
					thingPos:sendMagicEffect(CONST_ME_POFF)
					end
					return true
					end
