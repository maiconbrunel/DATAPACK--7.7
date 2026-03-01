-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: POH gate switch
-- Notes: Updated API, English messages
-- Changes: Tile API, removed deprecated calls

function onUse(player, item, fromPosition, target, toPosition)
	local gatePos = Position(32780, 32231, 8)
	local gate = Tile(gatePos):getItemById(387)

	if item.actionid == 10105 then
		if item.itemid == 1945 and gate then
			gate:remove()
			item:transform(1946)
		elseif item.itemid == 1946 and not gate then
			Game.createItem(387, 1, gatePos)
			item:transform(1945)
		else
			player:sendCancelMessage("Sorry, not possible.")
		end
	else
		player:sendCancelMessage("Sorry, not possible.")
	end

	return true
end
