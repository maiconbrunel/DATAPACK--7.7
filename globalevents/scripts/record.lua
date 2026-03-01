-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Record current server players and broadcast new record
-- Notes: Fixed DB query and broadcast timing

function onRecord(current, old, cid)
	-- Insert new record into database
	db.executeQuery(string.format(
		"INSERT INTO `server_record` (`record`, `world_id`, `timestamp`) VALUES (%d, %d, %d);",
		current, getConfigValue("worldId"), os.time()
	))

	-- Broadcast message after 150ms
	addEvent(function()
		doBroadcastMessage("New record: " .. current .. " players are logged in.", MESSAGE_STATUS_DEFAULT)
	end, 150)
end
