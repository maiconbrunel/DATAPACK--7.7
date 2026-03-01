-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Kazordoon Elevator Level 2
-- Notes: TFS API migration, tile checks
-- Changes: Logic fix, safe teleport, messages updated

local SWITCH_POS = Position(32637, 31881, 7)
local TELEPORT_POS = Position(32636, 31881, 2)
local TILE_POS = Position(32636, 31881, 7)

function onUse(player, item, fromPosition, target, toPosition)
	if player:hasCondition(CONDITION_EXHAUST) then
		player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
		return true
	end

	local switchTile = Tile(SWITCH_POS)
	local mainTile = Tile(TILE_POS)

	if item.actionid == 8024 and switchTile and switchTile:getItemById(1945) and mainTile and mainTile:getItemById(425) then
		player:addCondition(exhaust)
		player:teleportTo(TELEPORT_POS)
		TELEPORT_POS:sendMagicEffect(CONST_ME_TELEPORT)
	else
		local back = Position(player:getPosition().x - 2, player:getPosition().y, player:getPosition().z)
		player:teleportTo(back)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You are not standing on the tile!")
	end

	return true
end

