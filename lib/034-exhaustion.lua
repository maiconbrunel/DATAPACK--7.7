-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Exhaustion helper system
-- Notes: Standardized exhaustion checks, get, set, and make functions for TFS 1.5/7.7

exhaustion = {
	check = function(cid, storage)
		if getPlayerFlagValue(cid, PLAYERFLAG_HASNOEXHAUSTION) then
			return false
		end

		return getPlayerStorageValue(cid, storage) >= os.time()
	end,

	get = function(cid, storage)
		if getPlayerFlagValue(cid, PLAYERFLAG_HASNOEXHAUSTION) then
			return false
		end

		local exhaust = getPlayerStorageValue(cid, storage)
		if exhaust > 0 then
			local left = exhaust - os.time()
			if left >= 0 then
				return left
			end
		end

		return false
	end,

	set = function(cid, storage, time)
		setPlayerStorageValue(cid, storage, os.time() + time)
	end,

	make = function(cid, storage, time)
		local exhaust = exhaustion.get(cid, storage)
		if not exhaust then
			exhaustion.set(cid, storage, time)
			return true
		end

		return false
	end
}
