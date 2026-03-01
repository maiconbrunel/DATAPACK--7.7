-- partyAndGuildProtection.lua
function onCombat(creature, target)
-- Ensure both are players
local player = creature and creature:getPlayer()
if not player then
	return RETURNVALUE_NOERROR
	end

	local enemy = target and target:getPlayer()
	if not enemy then
		return RETURNVALUE_NOERROR
		end

		----------------------------------------------------------------
		-- Guild Protection
		----------------------------------------------------------------
		if configManager.getBoolean(configKeys.NO_DAMAGE_TO_GUILD_MATES) then
			local guildA = player:getGuildId()
			if guildA > 0 and guildA == enemy:getGuildId() then
				return RETURNVALUE_NOTPOSSIBLE
				end
				end

				----------------------------------------------------------------
				-- Party Protection
				----------------------------------------------------------------
				if configManager.getBoolean(configKeys.NO_DAMAGE_TO_PARTY_MEMBERS) then
					local partyA = player:getParty()
					local partyB = enemy:getParty()
					if partyA and partyB and partyA == partyB then
						return RETURNVALUE_NOTPOSSIBLE
						end
						end

						return RETURNVALUE_NOERROR
						end
