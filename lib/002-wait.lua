-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Coroutine/thread helper
-- Notes: Supports asynchronous execution via addEvent and wait

-- Alias for coroutine.yield
wait = coroutine.yield

-- Run a coroutine thread
function runThread(co)
	if coroutine.status(co) ~= 'dead' then
		local _, delay = coroutine.resume(co)
		if delay then
			addEvent(runThread, delay, co)
		end
	end
end

-- Create and start a thread from function or string
function createThread(data)
	local dataType, fn = type(data), nil

	if dataType == 'string' then
		fn = loadstring(data)
	elseif dataType == 'function' then
		fn = data
	end

	if fn ~= nil then
		local co = coroutine.create(fn)
		runThread(co)
	else
		print("[createThread]", "Invalid data specified.")
	end
end
