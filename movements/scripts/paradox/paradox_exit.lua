-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Teleport on step-in
-- Notes: melhorias, atualizações da API, otimizações

local EXIT_POS = Position(32566, 31963, 1)

function onStepIn(creature, item, position, fromPosition)
if item.actionid == 8015 then
	creature:teleportTo(EXIT_POS)
	EXIT_POS:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
	end
