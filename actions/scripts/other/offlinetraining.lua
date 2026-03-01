-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Offline training statue interaction
-- Notes: API modernized, safety checks added, storage fix
-- Changes: Player methods, training assignment, remove creature fix

local statue = {
	[1444] = SKILL_SWORD,
	[1449] = SKILL_AXE,
	[3705] = SKILL_CLUB,
	[3739] = SKILL_DISTANCE,
	[1448] = SKILL_MAGLEVEL
}

function onUse(player, item, fromPosition, target, toPosition)
	-- If player is PZ locked, can't use the statue
	if player:isPzLocked() then
		return false
	end

	-- Premium-only offline training statues
	if item:getActionId() == 1000 and player:getPremiumDays() > 0 then
		local skill = statue[item:getId()]
		if skill then
			player:setOfflineTrainingSkill(skill)
			player:remove() -- logs out instantly
		end
	else
		player:sendCancelMessage(RETURNVALUE_YOUNEEDPREMIUMACCOUNT)
	end

	return true
end

