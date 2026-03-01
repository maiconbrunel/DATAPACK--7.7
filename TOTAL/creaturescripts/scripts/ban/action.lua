-- guild.lua / channel action handler (TFS 1.5 - Downgrade 7.72)

local ACCESS = {
	[1] = { 8 },
	[2] = { 1, 2, 4, 5, 7, 9 },
	[3] = { 1, 2, 3, 4, 5, 6, 7, 9 }
}

local function contains(list, value)
for i = 1, #list do
	if list[i] == value then
		return true
		end
		end
		return false
		end

		function onChannelRequest(player, channel, custom)
		if not player then
			return false
			end

			-- Safe group fetch
			local groupId = player:getGroup():getId()
			if not groupId then
				player:sendCancelMessage("Invalid access level.")
				return false
				end

				-- Remove previous event to avoid stacking
				player:unregisterEvent("Ban_Action")

				-- Sanitization
				if type(channel) ~= "number" then
					player:sendCancelMessage("Invalid channel.")
					return false
					end

					-- Validate access
					local allowed = ACCESS[groupId]
					if not allowed or not contains(allowed, channel) then
						player:sendCancelMessage("You cannot perform this action.")
						return false
						end

						-- Dialog content
						local output = "Name:\n\nComment:\n"
						if channel == 1 or channel == 5 then
							output = "Name:\n\n(Optional) Length:\n\nComment:\n"
							end

							-- Text dialog
							player:showTextDialog(2599, output)

							-- Store action mode
							player:setStorageValue(910501, string.format(
								"%d,%d",
								(channel > 4 and 2 or 1),
																		 channel
							))

							-- Register finalizing event
							player:registerEvent("Ban_Finish")

							return false
							end
