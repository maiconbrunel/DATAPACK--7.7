-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Mana/Life fluids, alcohol, poison, lava drinking
-- Notes: Full modernization of API, safe Item/Position/Condition
-- Changes: Complete rewrite

local TYPE_EMPTY = 0
local TYPE_WATER = 1
local TYPE_BLOOD = 2
local TYPE_BEER = 3
local TYPE_SLIME = 4
local TYPE_LEMONADE = 5
local TYPE_MILK = 6
local TYPE_MANA_FLUID = 7
local TYPE_LIFE_FLUID = 10
local TYPE_OIL = 11
local TYPE_URINE = 13
local TYPE_COCONUT_MILK = 14
local TYPE_WINE = 15
local TYPE_MUD = 19
local TYPE_FRUIT_JUICE = 21
local TYPE_LAVA = 26
local TYPE_RUM = 27
local TYPE_SWAMP = 28
local TYPE_TEA = 35

local casks = {[1771] = TYPE_WATER, [1772] = TYPE_BEER, [1773] = TYPE_WINE}
local oilLamps = {[2046] = 2044}
local alcoholDrinks = {TYPE_BEER, TYPE_WINE, TYPE_RUM}
local poisonDrinks = {TYPE_SLIME, TYPE_SWAMP}

local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 60000)

local poison = Condition(CONDITION_POISON)
poison:setParameter(CONDITION_PARAM_DELAYED, true)
poison:setParameter(CONDITION_PARAM_MINVALUE, -50)
poison:setParameter(CONDITION_PARAM_MAXVALUE, -120)
poison:setParameter(CONDITION_PARAM_STARTVALUE, -5)
poison:setParameter(CONDITION_PARAM_TICKINTERVAL, 4000)
poison:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

local burn = Condition(CONDITION_FIRE)
burn:setParameter(CONDITION_PARAM_DELAYED, true)
burn:setParameter(CONDITION_PARAM_MINVALUE, -70)
burn:setParameter(CONDITION_PARAM_MAXVALUE, -150)
burn:setParameter(CONDITION_PARAM_STARTVALUE, -10)
burn:setParameter(CONDITION_PARAM_TICKINTERVAL, 10000)
burn:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

function onUse(player, item, fromPosition, target, toPosition)
	local targetPlayer = target and target:isPlayer() and target or nil

	if targetPlayer == player then
		if item.type == TYPE_EMPTY then
			player:sendCancelMessage("It is empty.")
			return true
		end

		if item.type == TYPE_MANA_FLUID then
			targetPlayer:addMana(math.random(40, 80))
			targetPlayer:say("Aaaah...", TALKTYPE_MONSTER_SAY)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

		elseif item.type == TYPE_LIFE_FLUID then
			targetPlayer:addHealth(math.random(40, 80))
			targetPlayer:say("Aaaah...", TALKTYPE_MONSTER_SAY)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

		elseif table.contains(alcoholDrinks, item.type) then
			targetPlayer:addCondition(drunk)
			targetPlayer:say("Aaah...", TALKTYPE_MONSTER_SAY)

		elseif table.contains(poisonDrinks, item.type) then
			targetPlayer:addCondition(poison)
			targetPlayer:say("Urgh!", TALKTYPE_MONSTER_SAY)

		elseif item.type == TYPE_LAVA then
			targetPlayer:addCondition(burn)
			targetPlayer:say("Urgh!", TALKTYPE_MONSTER_SAY)

		else
			targetPlayer:say("Gulp.", TALKTYPE_MONSTER_SAY)
		end

		item:transform(TYPE_EMPTY)
		return true
	end

	if not target or not target:isCreature() then
		if item.type == TYPE_EMPTY then
			local tItem = Item(target.uid)

			if tItem then
				local itemType = ItemType(tItem:getId())

				if itemType:isFluidContainer() and tItem.type ~= TYPE_EMPTY then
					item:transform(tItem.type)
					tItem:transform(TYPE_EMPTY)
					return true
				end

				local source = casks[tItem:getId()] or itemType:getFluidSource()
				if source then
					item:transform(source)
					return true
				end
			end

			player:sendCancelMessage("It is empty.")
			return true
		end

		local tLamp = oilLamps[target.itemid]
		if item.type == TYPE_OIL and tLamp then
			Item(target.uid):transform(tLamp)
			item:transform(TYPE_EMPTY)
			return true
		end

		local tType = ItemType(target.itemid)
		if tType:isFluidContainer() and target.type == TYPE_EMPTY then
			Item(target.uid):transform(item.type)
			item:transform(TYPE_EMPTY)
			return true
		end

		if Item(target.uid):hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end
	end

	Game.createItem(POOL, item.type, toPosition):decay()
	item:transform(TYPE_EMPTY)
	return true
end

