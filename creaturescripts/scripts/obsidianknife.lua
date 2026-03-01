-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Creature event handling (login, kill, death)
-- Notes: Fixed master checks and corpse attribute handling

local CORPSE_AID = 91347 -- defined attribute id for corpses

function onLogin(cid)
	-- Register summon kill event
	registerCreatureEvent(cid, "SummonKill")
	return true
end

function onKill(cid, target)
	-- If a summoned monster is killed, register ObMonsterCheck on its master
	if isMonster(target) then
		local master = getCreatureMaster(target)
		if master and isPlayer(master) then
			registerCreatureEvent(target, "ObMonsterCheck")
		end
	end
	return true
end

function onDeath(cid, corpse)
	if corpse then
		doItemSetAttribute(corpse.uid, "aid", CORPSE_AID)
	end
	return true
end
