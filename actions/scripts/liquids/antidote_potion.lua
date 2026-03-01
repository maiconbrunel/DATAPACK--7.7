-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Antidote potion
-- Notes: Updated APIs, safe item handling, modern combat
-- Changes: Fully rewritten, tile/position fixes, message fixes

local config = {
	removeOnUse = false,
	usableOnTarget = true,
	range = -1,
	realAnimation = false,
	flask = 7636,
	splash = 41
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)

function onUse(player, item, fromPosition, target, toPosition)
	local targetPlayer = target and target:isPlayer() and target or nil

	-- Using on ground → splash
	if not targetPlayer or (not config.usableOnTarget and player ~= targetPlayer) then
		if config.splash > 0 then
			local pos = toPosition
			if pos.x == CONTAINER_POSITION then
				pos = player:getPosition()
			end
			local splashItem = Game.createItem(POOL, config.splash, pos)
			if splashItem then
				splashItem:decay()
			end
		end

		item:remove(1)
		if config.flask and not config.removeOnUse then
			if fromPosition.x ~= CONTAINER_POSITION then
				Game.createItem(config.flask, 1, fromPosition)
			else
				player:addItem(config.flask, 1)
			end
		end
		return true
	end

	-- Range check
	if config.range > 0 and player ~= targetPlayer then
		if player:getPosition():getDistance(targetPlayer:getPosition()) > config.range then
			return true
		end
	end

	-- Cure poison
	if not combat:execute(player, Variant(targetPlayer)) then
		return true
	end

	targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

	if not config.realAnimation then
		targetPlayer:say("Aaaah...", TALKTYPE_MONSTER_SAY)
	else
		local spectators = Game.getSpectators(targetPlayer:getPosition(), false, true, 1, 1, 1, 1)
		for _, pid in ipairs(spectators) do
			pid:say("Aaaah...", TALKTYPE_MONSTER_SAY, false, pid)
		end
	end

	item:remove(1)
	if config.flask and not config.removeOnUse then
		if fromPosition.x ~= CONTAINER_POSITION then
			Game.createItem(config.flask, 1, fromPosition)
		else
			player:addItem(config.flask, 1)
		end
	end

	return true
end

