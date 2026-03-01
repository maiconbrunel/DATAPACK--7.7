-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Dice roll action
-- Notes: API updated, logic cleaned up
-- Changes: Modern callbacks, spectators fix, say per player, effect fix

local DICE_MIN = 5792   -- item id: dice face 1
local DICE_MAX = 5797   -- item id: dice face 6

function onUse(player, item, fromPosition, target, toPosition)
	-- Show effect only when used on ground
	if fromPosition.x ~= CONTAINER_POSITION then
		fromPosition:sendMagicEffect(CONST_ME_CRAPS)
	end

	-- Roll 1..6
	local newId = math.random(DICE_MIN, DICE_MAX)
	local roll = newId - 5791

	-- Spectators system (range 3x3)
	local spectators = Game.getSpectators(item:getPosition(), false, true, 3, 3, 3, 3)
	for _, spectator in ipairs(spectators) do
		spectator:say(player:getName() .. " rolled a " .. roll .. ".", TALKTYPE_MONSTER, false, spectator)
	end

	-- Transform dice to new face
	item:transform(newId)
	return true
end

