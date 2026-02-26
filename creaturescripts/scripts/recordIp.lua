-- recordIp.lua (TFS 1.5 - Downgrade 7.72 + LuaJIT 2.1)
function onLogin(player)
if not player then
	return false
	end

	-- Raw IP (may be 0 or negative depending on OS/network state)
	local rawIp = player:getIp()
	if not rawIp or rawIp == 0 then
		return true
		end

		-- Handle possible negative values (CachyOS / Arch bug)
		if rawIp < 0 then
			rawIp = rawIp + 4294967296 -- convert to unsigned 32-bit
			end

			-- Convert to readable x.x.x.x format
			local ipString = Game.convertIpToString(rawIp)
			if not ipString or ipString == "" then
				return true
				end

				-- GUID (safer than name for DB updates)
				local guid = player:getGuid()
				if not guid or guid == 0 then
					return true
					end

					-- Safe SQL update
					local query = string.format(
						"UPDATE `players` SET `ip` = '%s' WHERE `id` = %d;",
						ipString,
						guid
					)

					-- Correct DB API: always use db:query()
					if not db:query(query) then
						-- Optional debug (remove if you want 0 noise)
						-- logger.error(string.format("[RecordIP] SQL update failed for GUID %d", guid))
						end

						return true
						end
