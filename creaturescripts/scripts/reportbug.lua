-- reportbug.lua (TFS 1.5 - Downgrade 7.72)
function onReportBug(player, comment)
if not player then
	return false
	end

	-- Comment sanitization
	if not comment or comment == "" then
		player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Your report cannot be empty.")
		return true
		end

		local cleanComment = db.escapeString(comment)

		-- Player GUID is the only safe identifier
		local guid = player:getGuid()
		if not guid or guid == 0 then
			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Invalid player identifier.")
			return true
			end

			local pos = player:getPosition()

			-- World ID from config (correct source for 7.7)
			local worldId = configManager.getNumber(configKeys.WORLD_ID) or 0

			-- Server name for messages
			local serverName = configManager.getString(configKeys.SERVER_NAME)

			-- Safe SQL INSERT (no LIMIT on INSERT in MySQL/MariaDB)
			local query = string.format(
				"INSERT INTO `server_reports` (`world_id`, `player_id`, `posx`, `posy`, `posz`, `timestamp`, `report`) " ..
				"VALUES (%d, %d, %d, %d, %d, %d, '%s');",
										worldId,
							   guid,
							   pos.x, pos.y, pos.z,
							   os.time(),
										cleanComment
			)

			local success = db:query(query)

			if success then
				player:sendTextMessage(
					MESSAGE_EVENT_DEFAULT,
					string.format("Your report has been sent to %s.", serverName)
				)
				else
					player:sendTextMessage(
						MESSAGE_EVENT_DEFAULT,
						string.format("%s could not save your report. Please contact a gamemaster.", serverName)
					)
					end

					return true
					end
