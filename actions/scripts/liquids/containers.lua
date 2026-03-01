-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Liquid containers handling
-- Notes: Full modernization, safe handling, updated messages
-- Changes: Rebuilt entire logic, replaced old doX APIs

local ITEM_RUM_FLASK = 5553

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

local distillery = {[5513] = 5469, [5514] = 5470}
local oilLamps = {[2046] = 2044}
local casks = {[1771] = TYPE_WATER, [1772] = TYPE_BEER, [1773] = TYPE_WINE}
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
	-- Drinking usage
	local targetPlayer = target and target:isPlayer() and target or nil

	if targetPlayer then
		if item.type == TYPE_EMPTY then
			player:sendCancelMessage("It is empty.")
			return true
		end

		if item.type == TYPE_MANA_FLUID then
			targetPlayer:addMana(math.random(80, 160))
			targetPlayer:say("Aaaah...", TALKTYPE_MONSTER_SAY)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

		elseif item.type == TYPE_LIFE_FLUID then
			targetPlayer:addHealth(math.random(40, 75))
			targetPlayer:say("Aaaah...", TALKTYPE_MONSTER_SAY)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

		elseif targetPlayer == player then
			if table.contains(alcoholDrinks, item.type) then
				player:addCondition(drunk)
				player:say("Aaah...", TALKTYPE_MONSTER_SAY)

			elseif table.contains(poisonDrinks, item.type) then
				player:addCondition(poison)
				player:say("Urgh!", TALKTYPE_MONSTER_SAY)

			elseif item.type == TYPE_LAVA then
				player:addCondition(burn)
				player:say("Urgh!", TALKTYPE_MONSTER_SAY)

			else
				player:say("Gulp.", TALKTYPE_MONSTER_SAY)
			end

		else
			player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return true
		end

		item:transform(TYPE_EMPTY)
		return true
	end

	-- Interaction with ground/casks/containers
	if not target or not target:isCreature() then
		if item.type == TYPE_EMPTY then
			if item.itemid == ITEM_RUM_FLASK then
				local tmp = distillery[target.itemid]
				if tmp then
					target:transform(tmp)
					item:transform(TYPE_RUM)
				else
					player:sendCancelMessage("You have to process the bunch into the distillery to get rum.")
				end
				return true
			end

			if ItemType(target.itemid):isFluidContainer() and target.type ~= TYPE_EMPTY then
				item:transform(target.type)
				target:transform(TYPE_EMPTY)
				return true
			end

			local tmp = casks[target.itemid] or ItemType(target.itemid):getFluidSource()
			if tmp then
				item:transform(tmp)
				return true
			end

			player:sendCancelMessage("It is empty.")
			return true
		end

		local lamp = oilLamps[target.itemid]
		if item.type == TYPE_OIL and lamp then
			target:transform(lamp)
			item:transform(TYPE_EMPTY)
			return true
		end

		if ItemType(target.itemid):isFluidContainer() and target.type == TYPE_EMPTY then
			target:transform(item.type)
			item:transform(TYPE_EMPTY)
			return true
		end

		if target:hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end
	end

	Game.createItem(POOL, item.type, toPosition):decay()
	item:transform(TYPE_EMPTY)
	return true
end

