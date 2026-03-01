-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: PvP damage protection for guild and party members
-- Notes: Checks config values and prevents friendly fire

function onCombat(cid, target)
	if isPlayer(cid) and isPlayer(target) then
		-- No damage to guild mates
		if getConfigValue("noDamageToGuildMates") then
			if getPlayerGuildId(cid) == getPlayerGuildId(target) then
				return false
			end
		end

		-- No damage to party members
		if getConfigValue("noDamageToPartyMembers") then
			if getPlayerParty(cid) == getPlayerParty(target) then
				return false
			end
		end
	end

	return true
end
