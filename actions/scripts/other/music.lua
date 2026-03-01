-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Play musical item effects
-- Notes: API modernized, item usage corrected, safe random logic
-- Changes: say fix, effect fix, addItem modern, remove fix

local HORN = 2079
local EMPTY_BIRD_CAGE = 2094
local BIRD_CAGE = 2095
local DIDGERIDOO = 3952
local WAR_DRUM = 3953
local CORNUCOPIA = 2369

-- Final validated table of musical green notes (removing duplicates)
local GREEN_NOTES = {2070, 2071, 2073, 2075, 2076, 2078, 2367, 2374}

function onUse(player, item, fromPosition, target, toPosition)
	local rand = math.random(1, 5)

	-- Bird cage sound
	if item:getId() == BIRD_CAGE then
		fromPosition:sendMagicEffect(CONST_ME_SOUND_YELLOW)

	-- Didgeridoo special case (1/5 success)
	elseif item:getId() == DIDGERIDOO then
		if rand == 1 then
			fromPosition:sendMagicEffect(CONST_ME_SOUND_BLUE)
		end
		return true

	-- Cornucopia (drops apples)
	elseif item:getId() == CORNUCOPIA then
		for i = 1, 11 do
			player:addItem(2681, 1)
		end
		item:remove(1)
		fromPosition:sendMagicEffect(CONST_ME_SOUND_YELLOW)
		return true

	-- Other instruments
	else
		local effect = CONST_ME_SOUND_BLUE
		if item:getId() == HORN then
			effect = CONST_ME_SOUND_PURPLE
		elseif table.contains(GREEN_NOTES, item:getId()) then
			effect = CONST_ME_SOUND_GREEN
		end

		fromPosition:sendMagicEffect(effect)
	end

	return true
end

