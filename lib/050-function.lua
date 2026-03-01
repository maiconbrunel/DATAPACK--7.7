-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Player/item utility functions
-- Notes: Standardized item, money, experience, vocation, container, and broadcast helpers for TFS 1.5/7.7

function isInArray(array, value, caseSensitive)
	if(caseSensitive == nil or caseSensitive == false) and type(value) == "string" then
		local lowerValue = value:lower()
		for _, _value in ipairs(array) do
			if type(_value) == "string" and lowerValue == _value:lower() then
				return true
			end
		end
	else
		for _, _value in ipairs(array) do
			if value == _value then return true end
		end
	end
	return false
end

function doPlayerGiveItem(cid, itemid, amount, subType)
	local item = 0
	if isItemStackable(itemid) then
		item = doCreateItemEx(itemid, amount)
		if doPlayerAddItemEx(cid, item, true) ~= RETURNVALUE_NOERROR then return false end
	else
		for i = 1, amount do
			item = doCreateItemEx(itemid, subType)
			if doPlayerAddItemEx(cid, item, true) ~= RETURNVALUE_NOERROR then return false end
		end
	end
	return true
end

function doPlayerGiveItemContainer(cid, containerid, itemid, amount, subType)
	for i = 1, amount do
		local container = doCreateItemEx(containerid, 1)
		for x = 1, getContainerCapById(containerid) do
			doAddContainerItem(container, itemid, subType)
		end
		if doPlayerAddItemEx(cid, container, true) ~= RETURNVALUE_NOERROR then return false end
	end
	return true
end

function doPlayerTakeItem(cid, itemid, amount)
	return getPlayerItemCount(cid, itemid) >= amount and doPlayerRemoveItem(cid, itemid, amount)
end

function doPlayerSellItem(cid, itemid, count, cost)
	if not doPlayerTakeItem(cid, itemid, count) then return false end
	if not doPlayerAddMoney(cid, cost) then
		error('[doPlayerSellItem] Could not add money to: ' .. getPlayerName(cid) .. ' (' .. cost .. 'gp).')
	end
	return true
end

function doPlayerWithdrawMoney(cid, amount)
	if not getBooleanFromString(getConfigInfo('bankSystem')) then return false end
	local balance = getPlayerBalance(cid)
	if amount > balance or not doPlayerAddMoney(cid, amount) then return false end
	doPlayerSetBalance(cid, balance - amount)
	return true
end

function doPlayerDepositMoney(cid, amount)
	if not getBooleanFromString(getConfigInfo('bankSystem')) then return false end
	if not doPlayerRemoveMoney(cid, amount) then return false end
	doPlayerSetBalance(cid, getPlayerBalance(cid) + amount)
	return true
end

function doPlayerAddStamina(cid, minutes)
	return doPlayerSetStamina(cid, getPlayerStamina(cid) + minutes)
end

function isPremium(cid)
	return isPlayer(cid) and (getPlayerPremiumDays(cid) > 0 or getBooleanFromString(getConfigValue('freePremium')))
end

function getMonthDayEnding(day)
	if day == "01" or day == "21" or day == "31" then return "st"
	elseif day == "02" or day == "22" then return "nd"
	elseif day == "03" or day == "23" then return "rd"
	end
	return "th"
end

function getMonthString(m)
	return os.date("%B", os.time{year = 1970, month = m, day = 1})
end

function getArticle(str)
	return str:find("[AaEeIiOoUuYy]") == 1 and "an" or "a"
end

function doNumberFormat(i)
	local str, found = string.gsub(i, "(%d)(%d%d%d)$", "%1,%2", 1)
	repeat
		str, found = string.gsub(str, "(%d)(%d%d%d),", "%1,%2,", 1)
	until found == 0
	return str
end

function doPlayerAddAddons(cid, addon)
	for i = 0, table.maxn(maleOutfits) do
		doPlayerAddOutfit(cid, maleOutfits[i], addon)
	end
	for i = 0, table.maxn(femaleOutfits) do
		doPlayerAddOutfit(cid, femaleOutfits[i], addon)
	end
end

function getTibiaTime(num)
	local minutes, hours = getWorldTime(), 0
	while minutes > 60 do
		hours = hours + 1
		minutes = minutes - 60
	end
	if num then
		return {hours = hours, minutes = minutes}
	end
	return {hours = hours < 10 and '0'..hours or ''..hours, minutes = minutes < 10 and '0'..minutes or ''..minutes}
end

function doWriteLogFile(file, text)
	local f = io.open(file, "a+")
	if not f then return false end
	f:write("[" .. os.date("%d/%m/%Y %H:%M:%S") .. "] " .. text .. "\n")
	f:close()
	return true
end

function getExperienceForLevel(lv)
	lv = lv - 1
	return ((50*lv*lv*lv)-(150*lv*lv)+(400*lv))/3
end

function doMutePlayer(cid, time)
	local condition = createConditionObject(CONDITION_MUTED, (time == -1 and time or time * 1000))
	return doAddCondition(cid, condition, false)
end

function doSummonCreature(name, pos)
	local cid = doCreateMonster(name, pos, false, false)
	if not cid then cid = doCreateNpc(name, pos) end
	return cid
end

function getPlayersOnlineEx()
	local players = {}
	for i, cid in ipairs(getPlayersOnline()) do
		table.insert(players, getCreatureName(cid))
	end
	return players
end

function getPlayerByName(name)
	local cid = getCreatureByName(name)
	return isPlayer(cid) and cid or nil
end

function isPlayer(cid)
	return isCreature(cid) and cid >= AUTOID_PLAYERS and cid < AUTOID_MONSTERS
end

function isPlayerGhost(cid)
	return isPlayer(cid) and (getCreatureCondition(cid, CONDITION_GAMEMASTER, GAMEMASTER_INVISIBLE, CONDITIONID_DEFAULT) or getPlayerFlagValue(cid, PLAYERFLAG_CANNOTBESEEN))
end

function isMonster(cid)
	return isCreature(cid) and cid >= AUTOID_MONSTERS and cid < AUTOID_NPCS
end

function isNpc(cid)
	return isCreature(cid) and (cid < 0 or cid >= AUTOID_NPCS)
end

function isUnderWater(cid)
	return isInArray(underWater, getTileInfo(getCreaturePosition(cid)).itemid)
end
