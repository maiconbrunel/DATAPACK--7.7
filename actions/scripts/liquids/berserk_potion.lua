-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Berserk potion
-- Notes: Updated API, proper say + effects
-- Changes: TFS 1.5 condition, player methods

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
condition:setParameter(CONDITION_PARAM_SUBID, 99)

function onUse(player, item, fromPosition, target, toPosition)
	if not player:isKnight() then
		player:say("Only knights may drink this fluid.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if player:addCondition(condition) then
		fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		item:remove(1)
	end

	return true
end

