-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Desert Dungeon Multi-player Quest
-- Notes: Tile():getItemById, vocation & level checks fixed

function onUse(player, item, fromPosition, target, toPosition)
	local switchUniqueID = 10102
	local switchID = 1945
	local switch2ID = 1946

	local swordID = 2376
	local crossbowID = 2455
	local appleID = 2674
	local spellbookID = 2175

	local questlevel = 20

	-- Check required items on tiles
	local piece1 = Tile(Position(32673, 32094, 8)):getItemById(swordID)
	local piece2 = Tile(Position(32673, 32083, 8)):getItemById(crossbowID)
	local piece3 = Tile(Position(32667, 32089, 8)):getItemById(appleID)
	local piece4 = Tile(Position(32679, 32089, 8)):getItemById(spellbookID)

	-- Check players on positions
	local p1 = Tile(Position(32673, 32093, 8)):getTopCreature()
	local p2 = Tile(Position(32673, 32085, 8)):getTopCreature()
	local p3 = Tile(Position(32669, 32089, 8)):getTopCreature()
	local p4 = Tile(Position(32677, 32089, 8)):getTopCreature()

	if not p1 or not p2 or not p3 or not p4 then
		player:sendCancelMessage("Sorry, all 4 players must be on the right positions.")
		return true
	end

	local function voc(creature) return creature:getVocation():getId() end

	if not (
		(voc(p1) == 4 or voc(p1) == 8) and
		(voc(p2) == 3 or voc(p2) == 7) and
		(voc(p3) == 2 or voc(p3) == 6) and
		(voc(p4) == 1 or voc(p4) == 5)
	) then
		player:sendCancelMessage("Sorry, all players must have the correct vocation.")
		return true
	end

	if p1:getLevel() < questlevel or p2:getLevel() < questlevel or p3:getLevel() < questlevel or p4:getLevel() < questlevel then
		player:sendCancelMessage("Sorry, all players must be level " .. questlevel .. ".")
		return true
	end

	if item.actionid == switchUniqueID and item.itemid == switchID then
		if piece1 and piece2 and piece3 and piece4 then
			local new1 = Position(32672, 32070, 8)
			local new2 = Position(32671, 32070, 8)
			local new3 = Position(32672, 32069, 8)
			local new4 = Position(32671, 32069, 8)

			p1:getPosition():sendMagicEffect(CONST_ME_POFF)
			p1:teleportTo(new1)
			new1:sendMagicEffect(CONST_ME_TELEPORT)
			piece1:remove()

			p2:getPosition():sendMagicEffect(CONST_ME_POFF)
			p2:teleportTo(new2)
			new2:sendMagicEffect(CONST_ME_TELEPORT)
			piece2:remove()

			p3:getPosition():sendMagicEffect(CONST_ME_POFF)
			p3:teleportTo(new3)
			new3:sendMagicEffect(CONST_ME_TELEPORT)
			piece3:remove()

			p4:getPosition():sendMagicEffect(CONST_ME_POFF)
			p4:teleportTo(new4)
			new4:sendMagicEffect(CONST_ME_TELEPORT)
			piece4:remove()

			item:transform(switch2ID)
			return true
		else
			player:sendCancelMessage("Sorry, you need to put the correct items in the correct basins.")
			return true
		end
	elseif item.actionid == switchUniqueID and item.itemid == switch2ID then
		item:transform(switchID)
		return true
	end

	return true
end
