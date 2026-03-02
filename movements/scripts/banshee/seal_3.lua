-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Step-in seal logic
-- Notes: Modern API, improved checks, QoL fixes

local cfg = {
	flame_pos = Position(32268, 31856, 15),
	fail_pos = Position(32184, 31940, 14),
	fail_effect = CONST_ME_MAGIC_RED,
	pass_effect = CONST_ME_MAGIC_GREEN,
	flame_effect = CONST_ME_TELEPORT,
	action_pass = 9013,
	action_fail = 9014,
	action_flame = 9010,
}

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- Fail tile
	if item.actionid == cfg.action_fail then
		player:teleportTo(cfg.fail_pos)
		player:getPosition():sendMagicEffect(cfg.fail_effect)
		return true
		end

		-- Pass tile
		if item.actionid == cfg.action_pass then
			player:getPosition():sendMagicEffect(cfg.pass_effect)
			return true
			end

			-- Flame tile (seal)
			if item.actionid == cfg.action_flame then
				local sealStatus = player:getStorageValue(9010)
				if sealStatus < 1 then
					player:teleportTo(cfg.flame_pos)
					cfg.flame_pos:sendMagicEffect(cfg.flame_effect)
					player:setStorageValue(9010, 1)
					player:setStorageValue(9100, 1)
					else
						player:sendTextMessage(MESSAGE_STATUS_WARNING, "You already did this seal.")
						end
						return false
						end

						return true
						end
