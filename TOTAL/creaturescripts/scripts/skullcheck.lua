-- skullcheck.lua (TFS 1.5 - Downgrade 7.72)
function onThink(creature, interval)
-- Ensure it's a player
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Ignore if ghost (avoid unnecessary calls)
	if player:isGhost() then
		return true
		end

		local skull = player:getSkull()
		local skullTime = player:getSkullTime()

		-- No skull time stored
		if skullTime <= 0 then
			return true
			end

			-- White skull never expires
			if skull == SKULL_WHITE then
				return true
				end

				-- Save current time
				local now = os.time()

				-- Check expiration + no fight condition
				if now >= skullTime and not player:hasCondition(CONDITION_INFIGHT) then
					player:setSkullTime(0)
					-- Engine will remove skull automatically next process loop
					end

					return true
					end
