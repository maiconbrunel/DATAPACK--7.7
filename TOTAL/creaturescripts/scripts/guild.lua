-- Guild channel join/leave handler (TFS 1.5 - 7.72 Downgrade)

function onChannelJoin(player, channelId, users)
if channelId ~= CHANNEL_GUILD then
	return true
	end

	local name = player:getName()

	-- Announce player entry to guild members in channel
	for _, uid in pairs(users) do
		local member = Player(uid)
		if member then
			member:sendChannelMessage(
				"",
				"Player " .. name .. " has entered the channel.",
				TALKTYPE_CHANNEL_HIGHLIGHT,
				CHANNEL_GUILD
			)
			end
			end

			-- Guild Message of the Day
			local guild = player:getGuild()
			if guild then
				local motd = guild:getMotd()
				if motd and motd ~= "" then
					player:sendChannelMessage(
						"",
						"Message of the Day: " .. motd,
						TALKTYPE_GAMEMASTER_CHANNEL,
						CHANNEL_GUILD
					)
					end
					end

					return true
					end

					function onChannelLeave(player, channelId, users)
					if channelId ~= CHANNEL_GUILD then
						return true
						end

						local name = player:getName()

						-- Announce player leaving to guild members in channel
						for _, uid in pairs(users) do
							local member = Player(uid)
							if member then
								member:sendChannelMessage(
									"",
								  "Player " .. name .. " has left the channel.",
								  TALKTYPE_CHANNEL_HIGHLIGHT,
								  CHANNEL_GUILD
								)
								end
								end

								return true
								end
