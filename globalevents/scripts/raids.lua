-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Weekly and exact raid scheduler
-- Notes: Fixed last execution tracking and time checks

local raids = {
	[1] = {name = 'Thais', type = 'weekly', days = {'monday'}, hour = 8, minu = 0},
	[2] = {name = 'Orcs', type = 'weekly', days = {'wednesday'}, hour = 12, minu = 0},
	[3] = {name = 'Demodras', type = 'weekly', days = {'sunday'}, hour = 15, minu = 0},
	[4] = {name = 'Elf', type = 'weekly', days = {'tuesday'}, hour = 10, minu = 0},
	[5] = {name = 'Horned Fox', type = 'weekly', days = {'sunday'}, hour = 8, minu = 0},
	[6] = {name = 'Necropharus', type = 'weekly', days = {'thursday'}, hour = 20, minu = 0},
	[7] = {name = 'Orshabaal', type = 'weekly', days = {'sunday'}, hour = 18, minu = 0},
	[8] = {name = 'Scarabs', type = 'weekly', days = {'tuesday'}, hour = 5, minu = 0},
	[9] = {name = 'Old Widow', type = 'weekly', days = {'wednesday'}, hour = 19, minu = 0}
}

local last_executions = {}

function onThink(interval, lastExecution, thinkInterval)
	local current_time = os.time()
	local current_day_name = os.date("%A", current_time):lower()
	local current_hour = tonumber(os.date("%H", current_time))
	local current_minute = tonumber(os.date("%M", current_time))
	local current_day_number = tonumber(os.date("%d", current_time))
	local current_month = tonumber(os.date("%m", current_time))

	for k, raid in ipairs(raids) do
		if raid.type == 'weekly' then
			if isInArray(raid.days, current_day_name) then
				if raid.hour == current_hour and raid.minu == current_minute then
					if last_executions[k] ~= current_day_number then
						last_executions[k] = current_day_number
						doExecuteRaid(raid.name)
					end
				end
			end
		elseif raid.type == 'exact' and raid.date then
			if raid.date.month == current_month and raid.date.day == current_day_number then
				if raid.hour == current_hour and raid.minu == current_minute then
					if last_executions[k] ~= current_day_number then
						last_executions[k] = current_day_number
						doExecuteRaid(raid.name)
					end
				end
			end
		end
	end

	return true
end
