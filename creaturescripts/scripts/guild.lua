-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Guild channel join/leave notifications
-- Notes: Modernized loops, safe addEvent usage, English messages

function onChannelJoin(cid, channelId, users)
	if channelId ~= CHANNEL_GUILD then
		return true
	end

	-- Notify all users in the channel
	for _, pid in pairs(users) do
		doPlayerSendChannelMessage(pid, "", "Player " .. getCreatureName(cid) .. " has entered the channel.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
	end

	-- Send guild MOTD to the joining player
	local guildId = getPlayerGuildId(cid)
	if guildId and guildId ~= 0 then
		local guildMotd = getGuildMotd(guildId)
		if guildMotd and guildMotd ~= "" then
			addEvent(valid(doPlayerSendChannelMessage), 150, cid, "", "Message of the Day: " .. guildMotd, TALKTYPE_GAMEMASTER_CHANNEL, CHANNEL_GUILD)
		end
	end

	return true
end

function onChannelLeave(cid, channelId, users)
	if channelId ~= CHANNEL_GUILD then
		return true
	end

	-- Notify all users in the channel
	for _, pid in pairs(users) do
		doPlayerSendChannelMessage(pid, "", "Player " .. getCreatureName(cid) .. " has left the channel.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
	end

	return true
end
