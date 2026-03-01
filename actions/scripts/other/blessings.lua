-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: List player blessings
-- Notes: Modern Player API, clean logic
-- Changes: Player methods, safer loops

local BLESSINGS = {
	"Wisdom of Solitude",
	"Spark of the Phoenix",
	"Fire of the Suns",
	"Spiritual Shielding",
	"Embrace of Tibia",
	"Twist of Fate"
}

function onUse(player, item, fromPosition, target, toPosition)
	local result = {}

	for i = 1, 5 do
		if player:hasBlessing(i) then
			table.insert(result, BLESSINGS[i])
		end
	end

	if player:hasPvpBlessing() then
		table.insert(result, BLESSINGS[6])
	end

	local text = (#result > 0)
		and "Currently you have the following blessings: " .. table.concat(result, ", ") .. "."
		or "You do not have any blessing."

	player:sendTextMessage(MESSAGE_INFO_DESCR, text)
	return true
end

