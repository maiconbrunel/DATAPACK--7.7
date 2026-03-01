-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Bug reporting system
-- Notes: Secure DB insertion, player messages in English

function onReportBug(cid, comment)
	local pos = getCreaturePosition(cid)
	local query = string.format([[
		INSERT INTO `server_reports` 
		(`id`, `world_id`, `player_id`, `posx`, `posy`, `posz`, `timestamp`, `report`) 
		VALUES (NULL, %d, %d, %d, %d, %d, %d, %s)
	]], 
		getConfigValue('worldId'),
		getPlayerGUID(cid),
		pos.x, pos.y, pos.z,
		os.time(),
		db.escapeString(comment)
	)

	if db.executeQuery(query) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, 
			"Your report has been sent to " .. getConfigValue('serverName') .. ".")
	else
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, 
			getConfigValue('serverName') .. " couldn't save your report, please contact a gamemaster.")
	end

	return true
end
