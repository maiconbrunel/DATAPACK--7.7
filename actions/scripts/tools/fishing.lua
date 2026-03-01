-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Fishing system
-- Notes: Fixed bait logic, skill checks, summons, and container handling

local config = {
	waters = {4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825},
	fishable = {4608, 4609, 4610, 4611, 4612, 4613},
	spawning = {4614, 4615, 4616, 4617, 4618, 4619},
	holes = {7236},

	corpses = {},
	rateLoot = getConfigValue("rateLoot"),
	summons = {},
	rateSpawn = getConfigValue("rateSpawn"),
	baitFailRemoveChance = 10,
	allowFromPz = false,
	useBait = true,
	baitCount = 1,
	fishes = 1
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if isInArray(config.waters, itemEx.itemid) then
		if isInArray(config.spawning, itemEx.itemid) then
			doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		end
		doSendMagicEffect(toPosition, CONST_ME_LOSEENERGY)
		return true
	end

	local corpseData = config.corpses[itemEx.itemid]
	if corpseData then
		corpseData = corpseData[itemEx.actionid]
		if corpseData then
			local chance, items, default, maxRate = math.random() * 100000 / config.rateLoot, {}, {}, 0
			for _, data in ipairs(corpseData) do
				if data[3] >= chance then
					table.insert(items, {data[1], math.random(1, data[2])})
				end
				if data[3] > maxRate then
					default, maxRate = data, data[3]
				end
			end

			if #items > 0 then
				local loot = items[math.random(1, #items)]
				doPlayerAddItem(cid, loot[1], loot[2])
			else
				doPlayerAddItem(cid, default[1], default[2])
			end

			doTransformItem(itemEx.uid, getItemInfo(itemEx.itemid).decayTo)
			doSendMagicEffect(toPosition, CONST_ME_WATERSPLASH)
			doDecayItem(itemEx.uid)
			return true
		end
	end

	if not isInArray(config.fishable, itemEx.itemid) then
		return false
	end

	local pos, formula, tries = getThingPosition(cid), getPlayerSkill(cid, SKILL_FISHING) / 200 + 0.85 * math.random(), 0
	config.allowFromPz = config.allowFromPz or not getTileInfo(pos).protection

	-- Normal fishing rod
	if item.itemid ~= ITEM_MECHANICAL_FISHING_ROD then
		if config.allowFromPz and (not config.useBait or getPlayerItemCount(cid, ITEM_WORM) >= config.baitCount) then
			tries = 1
			if isInArray(config.holes, itemEx.itemid) then
				if doPlayerRemoveItem(cid, ITEM_WORM, config.baitCount) then
					tries = 2
					if formula > 0.83 then
						doPlayerAddItem(cid, ITEM_RAINBOW_TROUT, config.fishes)
					elseif formula > 0.7 then
						doPlayerAddItem(cid, ITEM_NORTHERN_PIKE, config.fishes)
					elseif formula > 0.5 then
						doPlayerAddItem(cid, ITEM_GREEN_PERCH, config.fishes)
					else
						doPlayerAddItem(cid, ITEM_FISH, config.fishes)
					end
				end
			elseif formula > 0.7 and doPlayerRemoveItem(cid, ITEM_WORM, config.baitCount) then
				tries = 2
				if #config.summons > 0 and getDistanceBetween(pos, toPosition) < 2 then
					local skill, summon = getPlayerSkill(cid, SKILL_FISHING), {name = "", chance = 0, bossName = "", bossChance = 0}
					for _, data in pairs(config.summons) do
						if skill >= data[1] then
							summon.name, summon.chance, summon.bossName, summon.bossChance = data[2], data[3], data[4], data[5]
						end
					end

					local randomChance = math.random() * 100000 / config.rateSpawn
					if summon.bossName ~= "" and summon.bossChance >= randomChance then
						doCreateMonster(summon.bossName, pos)
						tries = 4
					elseif summon.name ~= "" and summon.chance >= randomChance then
						doCreateMonster(summon.name, pos)
						tries = 3
					else
						doPlayerAddItem(cid, ITEM_FISH, config.fishes)
					end
				else
					doPlayerAddItem(cid, ITEM_FISH, config.fishes)
				end
			end
		end

	-- Mechanical fishing rod
	elseif config.allowFromPz and (not config.useBait or getPlayerItemCount(cid, ITEM_NAIL) >= config.baitCount) then
		if formula > 0.7 and doPlayerRemoveItem(cid, ITEM_NAIL, config.baitCount) then
			doPlayerAddItem(cid, ITEM_MECHANICAL_FISH, config.fishes)
			tries = 2
		else
			tries = 1
		end
	end

	-- Apply fishing skill tries and decay
	if tries > 1 then
		doPlayerAddSkillTry(cid, SKILL_FISHING, tries)
		if not isInArray(config.holes, itemEx.itemid) then
			doTransformItem(itemEx.uid, itemEx.itemid + 6)
		else
			doTransformItem(itemEx.uid, itemEx.itemid + 1)
		end
		doDecayItem(itemEx.uid)
	elseif tries > 0 then
		doPlayerAddSkillTry(cid, SKILL_FISHING, 1)
		if config.baitFailRemoveChance >= math.random(1, 100) then
			if item.itemid == ITEM_MECHANICAL_FISHING_ROD then
				doPlayerRemoveItem(cid, ITEM_NAIL, config.baitCount)
			else
				doPlayerRemoveItem(cid, ITEM_WORM, config.baitCount)
			end
		end
	end

	doSendMagicEffect(toPosition, CONST_ME_LOSEENERGY)
	return true
end
