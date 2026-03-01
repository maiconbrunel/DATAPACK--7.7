local rewards = {
	[10044] = {itemId = 2337, text = "You have found a right horn."},
	[10045] = {itemId = 2338, text = "You have found a left horn."},
	[10046] = {itemId = 2335, text = "You have found a helmet ornament."},
	[10047] = {itemId = 2336, text = "You have found a gem holder."},
	[10048] = {itemId = 2339, text = "You have found a damaged helmet."},
	[10049] = {itemId = 2340, text = "You have found a helmet piece."},
	[10050] = {itemId = 2341, text = "You have found a helmet adornment."}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local reward = rewards[item.actionid]
if not reward then
	return true
	end

	if player:getStorageValue(item.actionid) < 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, reward.text)
		player:addItem(reward.itemId, 1)
		player:setStorageValue(item.actionid, 1)
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "The sarcophagus is empty.")
			end

			return true
			end
