-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: onAdvance handler with auto-heal and save
-- Notes: Heals player on level up and optionally saves player

local config = {
	savePlayer = true,
	healPlayerOnLevel = true
}

function onAdvance(cid, skill, oldLevel, newLevel)
	-- Ignore experience skill
	if skill == SKILL__EXPERIENCE then
		return true
	end

	-- Heal player on level up
	if skill == SKILL__LEVEL and config.healPlayerOnLevel then
		local hp = getCreatureMaxHealth(cid) - getCreatureHealth(cid)
		local mana = getCreatureMaxMana(cid) - getCreatureMana(cid)
		doCreatureAddHealth(cid, hp)
		doCreatureAddMana(cid, mana)
	end

	-- Save player if enabled
	if config.savePlayer then
		doPlayerSave(cid, true)
	end

	return true
end
