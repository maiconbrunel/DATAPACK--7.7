-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Special quest reward system
-- Notes: Fixed container handling, stack/rune display, GM protection, and experience reward

local specialQuests = {
	[2001] = 30015 -- Annihilator
}

local questsExperience = {
	[30015] = 10000
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	-- GM protection check
	if getBooleanFromString(getConfigValue('enableProtectionQuestForGM')) then
		if getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_GAMEMASTERPRIVILEGES) then
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF, cid)
			return true
		end
	end

	local storage = specialQuests[item.actionid] or item.uid
	if storage > 65535 then
		return false
	end

	-- Check if quest already completed
	if getPlayerStorageValue(cid, storage) > 0 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
		return true
	end

	local items, reward = {}, 0
	local size = isContainer(item.uid) and getContainerSize(item.uid) or 0

	-- Copy items from container if exists
	if size == 0 then
		reward = doCopyItem(item, false)
	else
		for i = 0, size - 1 do
			local tmp = getContainerItem(item.uid, i)
			if tmp.itemid > 0 then
				table.insert(items, tmp)
			end
		end
	end

	-- Single item in container
	size = #items
	if size == 1 then
		reward = doCopyItem(items[1], true)
	end

	local result = ""
	if reward ~= 0 then
		local desc = getItemDescriptions(reward.uid)
		if reward.type > 0 and isItemRune(reward.itemid) then
			result = reward.type .. " charges " .. desc.name
		elseif reward.type > 0 and isItemStackable(reward.itemid) then
			result = reward.type .. " " .. desc.plural
		else
			result = desc.article .. " " .. desc.name
		end
	else
		-- Fallback reward container
		if size > 20 then
			reward = doCopyItem(item, false)
		elseif size > 8 then
			reward = getThing(doCreateItemEx(1988, 1))
		else
			reward = getThing(doCreateItemEx(1987, 1))
		end

		-- Add items into reward container
		for i = 1, size do
			local tmp = doCopyItem(items[i], true)
			if doAddContainerItemEx(reward.uid, tmp.uid) ~= RETURNVALUE_NOERROR then
				print("[Warning] QuestSystem: Could not add quest reward")
			else
				local sep = ", "
				if i == 1 then sep = "" elseif i == 2 then sep = " and " end

				local desc = getItemDescriptions(tmp.uid)
				if tmp.type > 0 and isItemRune(tmp.itemid) then
					result = result .. sep .. tmp.type .. " charges " .. desc.name
				elseif tmp.type > 0 and isItemStackable(tmp.itemid) then
					result = result .. sep .. tmp.type .. " " .. desc.plural
				else
					result = result .. sep .. desc.article .. " " .. desc.name
				end
			end
		end
	end

	-- Try to give reward
	if doPlayerAddItemEx(cid, reward.uid, false) ~= RETURNVALUE_NOERROR then
		result = "You have found a reward weighing " .. getItemWeight(reward.uid) .. " oz. It is too heavy or you have not enough space."
	else
		result = "You have found " .. result .. "."
		setPlayerStorageValue(cid, storage, 1)

		-- Give quest experience if defined
		if questsExperience[storage] then
			doPlayerAddExp(cid, questsExperience[storage])
			doSendAnimatedText(getCreaturePosition(cid), questsExperience[storage], TEXTCOLOR_WHITE)
		end
	end

	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, result)
	return true
end
