-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Simple fart message on step-in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	player:say("Faaart!", TALKTYPE_MONSTER)
	position:sendMagicEffect(CONST_ME_POFF)
	return true
	end
