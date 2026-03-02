-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Trap tile dealing damage
-- Notes: melhorias, atualizações da API, otimizações

local TRAP_POS = Position(32497, 31888, 7)

function onStepIn(creature, item, position, fromPosition)
if item.actionid == 8007 then
	creature:addHealth(-200)
	TRAP_POS:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
	TRAP_POS:sendAnimatedText("200", TEXTCOLOR_RED)
	end
	return true
	end
