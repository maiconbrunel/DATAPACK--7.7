-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Mastermind Potion
-- Notes: TFS 1.5 Conditions, updated vocations, messages
-- Changes: Rewritten using Player API

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICLEVEL, 3)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
condition:setParameter(CONDITION_PARAM_SUBID, 99)

function onUse(player, item, fromPosition, target, toPosition)
	if not player:isSorcerer() and not player:isDruid() then
		player:say("Only sorcerers and druids may drink this fluid.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if player:addCondition(condition) then
		fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		item:remove(1)
		player:say("You feel smarter.", TALKTYPE_MONSTER_SAY)
	end

	return true
end

