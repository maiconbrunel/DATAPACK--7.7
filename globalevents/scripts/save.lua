-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Automatic server save with broadcast
-- Notes: Fixed table length check and event scheduling

local config = {
	broadcast = {120, 30}, -- broadcast intervals in seconds
	flags = 13,            -- save flags
	delay = 120,           -- initial delay in seconds
	events = 30            -- event interval in seconds
}

local function executeSave(seconds)
	if seconds > 0 then
		addEvent(executeSave, config.events * 1000, seconds - config.events)
	else
		doSaveServer(config.flags)
	end
end

function onThink(interval)
	if #config.broadcast == 0 then
		doSaveServer(config.flags)
	else
		executeSave(config.delay)
	end
	return true
end
