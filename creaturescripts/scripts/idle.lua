local config = {
	idleWarning = configManager.getNumber(configKeys.IDLE_WARNING_TIME),
	idleKick = configManager.getNumber(configKeys.IDLE_KICK_TIME)
}

function onThink(player, interval)
local pos = player:getPosition()
local tile = Tile(pos)

-- Área que impede logout ou idle-kick
if (tile and tile:hasFlag(TILESTATE_NOLOGOUT))
	or player:hasCondition(CONDITION_PACIFIED)
	or player:getStorageValue(StorageCompat.AllowIdle) == 1
	then
	return true
	end

	-- Idle time fornecido pelo TFS (não somar interval manualmente)
	local idleTime = player:getIdleTime()

	-- Aviso
	if config.idleWarning > 0 and idleTime >= config.idleWarning
		and idleTime < (config.idleWarning + interval) then

		local minutes = math.ceil(config.idleWarning / 60000)
		local msg = "There was no variation in your behaviour for " .. minutes .. " minutes"

		if config.idleKick > 0 then
			local diff = math.ceil((config.idleKick - config.idleWarning) / 60000)
			if diff > 1 then
				msg = msg .. ". You will be disconnected in " .. diff .. " minutes"
				else
					msg = msg .. ". You will be disconnected in one minute"
					end
					msg = msg .. " if there is no change in your actions until then."
					end

					player:sendTextMessage(MESSAGE_STATUS_WARNING, msg .. ".")
					end

					-- Kick por AFK
					if config.idleKick > 0 and idleTime >= config.idleKick then
						player:kick()
						return true
						end

						return true
						end
