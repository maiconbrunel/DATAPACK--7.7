local config = {
	savePlayer = true,
	healPlayerOnLevel = true
}

function onAdvance(player, skill, oldLevel, newLevel)
-- Ignore experience advance (XP does not trigger this logic)
if skill == SKILL_EXPERIENCE then
	return true
	end

	-- Full heal on level up (classic 7.7 behavior)
	if skill == SKILL_LEVEL and config.healPlayerOnLevel then
		local maxHealth = player:getMaxHealth()
		local maxMana = player:getMaxMana()

		-- Heal player completely
		player:addHealth(maxHealth)
		player:addMana(maxMana)
		end

		-- Auto save player (safe in TFS 1.5)
		if config.savePlayer then
			player:save()
			end

			return true
			end
