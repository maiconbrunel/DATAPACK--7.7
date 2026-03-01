local AID_MONSTER_TAG = 91347

-- Player Login (registers needed events)
function onLogin(player)
if not player then
	return true
	end

	player:registerEvent("SummonKill")
	return true
	end

	-- Monster Kill Event
	function onKill(creature, target)
	-- Safety checks
	if not creature or not target then
		return true
		end

		if not target:isMonster() then
			return true
			end

			-- If monster is a summon of a player, track it
			local master = target:getMaster()
			if master and master:isPlayer() then
				-- Register custom event for tracking summoned monster behavior
				target:registerEvent("ObMonsterCheck")
				end

				return true
				end

				-- Monster Death Event
				function onDeath(creature, corpse, killer, mostDamageKiller)
				if not corpse or not corpse:isItem() then
					return true
					end

					-- Mark corpse with ActionID for later processing
					corpse:setAttribute(ITEM_ATTRIBUTE_ACTIONID, AID_MONSTER_TAG)
					return true
					end
