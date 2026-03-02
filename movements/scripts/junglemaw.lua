-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Poison tile + transform on add item
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if player then
	doTargetCombatHealth(0, player, COMBAT_POISONDAMAGE, -30, -30, CONST_ME_POFF)
	end

	item:transform(item:getId() + 1)
	item:decay()
	return true
	end

	function onAddItem(moveItem, tileItem, position)
	tileItem:transform(tileItem:getId() + 1)
	position:sendMagicEffect(CONST_ME_POFF)
	return true
	end
