-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Display current time to player
-- Notes: Supports Tibia time, 24h or 12h format

local config = {
	tibianTime = true,
	twentyFour = true -- only if tibianTime = false
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local timeStr = ""

	if config.tibianTime then
		local tibiaTime = getTibiaTime()
		timeStr = string.format("%02d:%02d", tibiaTime.hours, tibiaTime.minutes)
	elseif config.twentyFour then
		timeStr = os.date("%H:%M")
	else
		timeStr = os.date("%I:%M %p")
	end

	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The time is " .. timeStr .. ".")
	return true
end
