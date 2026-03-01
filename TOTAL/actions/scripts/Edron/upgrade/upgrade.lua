-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Tiered reward platform based on crystal coins
-- Notes: Heavy optimization + API modernization

local newPos = Position(33223, 31807, 8)
local oldPos = Position(33223, 31809, 8)
local plats  = Position(33223, 31804, 8)

local effects = {
	Position(33222, 31807, 8),
	Position(33224, 31807, 8),
	Position(33222, 31806, 8),
	Position(33224, 31806, 8),
	Position(33222, 31805, 8),
	Position(33224, 31805, 8),
	Position(33223, 31804, 8)
}

-- reward table (minCoins = {itemId})
local rewards = {
	{1000, 2431},
	{900, 2432},
	{800, 2433},
	{700, 2432},
	{600, 2432},
	{500, 2432},
	{400, 2432},
	{350, 2432},
	{300, 2432},
	{250, 2415},
	{200, 2432},
	{150, 2432},
	{100, 2432},
	{70, 2432},
	{60, 2432},
	{50, 2418},
	{40, 2406},
	{30, 2407},
	{20, 2408},
	{10, 2409},
	{1, 2411},
}

local function sendEffects()
for _, pos in ipairs(effects) do
	pos:sendMagicEffect(15)
	end
	end

	function onUse(player, item, fromPosition, target, toPosition)
	if item.uid ~= 10024 then
		return false
		end

		local coins = player:getItemCount(2157)
		if coins < 1 then
			player:teleportTo(oldPos)
			oldPos:sendMagicEffect(2)
			return true
			end

			for _, data in ipairs(rewards) do
				local requiredCoins = data[1]
				local rewardItem = data[2]

				if coins >= requiredCoins then
					player:removeItem(2157, requiredCoins)

					player:teleportTo(newPos)
					newPos:sendMagicEffect(CONST_ME_TELEPORT)

					Game.createItem(rewardItem, 1, plats)
					sendEffects()

					return true
					end
					end

					return true
					end
