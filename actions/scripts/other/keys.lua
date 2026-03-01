-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door unlocking via keys
-- Notes: API modernized, PZ fix, transform fix, safe lookup
-- Changes: ItemType, Player API, DOORS lookup, Tile protection check

local REVERSE_DOORS, CHILD_DOORS = {}, {}

for doorId, baseId in pairs(DOORS) do
	REVERSE_DOORS[baseId] = doorId

	local it = ItemType(baseId)
	if it and it:getTransformUseTo() ~= 0 then
		CHILD_DOORS[it:getTransformUseTo()] = doorId
	end
end

function onUse(player, item, fromPosition, target, toPosition)
	-- Both must have an action id (real Tibia)
	if item:getActionId() > 0 and target:getActionId() > 0 then
		-- PZ lock protection
		if player:isPzLocked() then
			local tile = Tile(toPosition)
			if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
				player:sendCancelMessage(RETURNVALUE_ACTIONNOTPERMITTEDINPROTECTIONZONE)
				return true
			end
		end

		-- Identify the target door
		local doorId = DOORS[target:getId()]
		if not doorId then
			doorId = REVERSE_DOORS[target:getId()]
		end
		if not doorId then
			doorId = CHILD_DOORS[target:getId()]
		end

		if doorId then
			-- Key mismatch
			if item:getActionId() ~= target:getActionId() then
				player:sendCancelMessage("The key does not match.")
			else
				-- Proper transform
				target:transform(doorId)
			end
			return true
		end
	end

	return false
end

