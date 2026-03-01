-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Idle warning and kick system
-- Notes: Fixed idle time calculation and warning messages

local config = {
	idleWarning = getConfigValue('idleWarningTime'),
	idleKick = getConfigValue('idleKickTime')
}

function onThink(cid, interval)
	-- Check if logout is allowed or player has idle exemption
	if getTileInfo(getCreaturePosition(cid)).noLogout or
	   getCreatureNoMove(cid) or
	   getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_ALLOWIDLE) then
		return true
	end

	-- Update idle time
	local idleTime = getPlayerIdleTime(cid) + interval
	doPlayerSetIdleTime(cid, idleTime)

	-- Kick if exceeded maximum idle time
	if config.idleKick > 0 and idleTime > config.idleKick then
		doRemoveCreature(cid)

	-- Send warning if idle reaches warning threshold
	elseif config.idleWarning > 0 and idleTime == config.idleWarning then
		local minutes = math.ceil(config.idleWarning / 60000)
		local message = "There was no variation in your behaviour for " .. minutes .. " minutes"

		if config.idleKick > 0 then
			message = message .. ". You will be disconnected in "
			local diff = math.ceil((config.idleKick - config.idleWarning) / 60000)
			if diff > 1 then
				message = message .. diff .. " minutes"
			else
				message = message .. "one minute"
			end
			message = message .. " if there is no change in your actions until then."
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, message .. ".")
	end

	return true
end
