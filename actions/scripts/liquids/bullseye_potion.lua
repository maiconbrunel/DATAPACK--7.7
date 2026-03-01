-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Bullseye potion
-- Notes: Updated conditions, proper effects
-- Changes: Player API modernization

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
condition:setParameter(CONDITION_PARAM_SUBID, 99)

function onUse(player, item, fromPosition, target, toPosition)
	if not player:isPaladin() then
		player:say("Only paladins may drink this fluid.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if player:addCondition(condition) then
		fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		item:remove(1)
	end

	return true
end

