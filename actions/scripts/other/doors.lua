-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door logic (level, vocation, group, skull, gender, premium, storage)
-- Notes: Modern API, tile checks, teleport fixes, safe behavior
-- Changes: TeleportLever logic, Tile-based checks, Position safety, updated constants

local function doorEnter(player, item, newId, dest)
	-- Transform door
	item:transform(newId)

	-- Teleport player using 7.7-safe tile evaluation
	local tile = Tile(dest)
	if not tile then
		return false
	end

	player:teleportTo(dest, true)
	return true
end

function onUse(player, item, fromPosition, target, toPosition)
	-- PZ lock check (classic 7.7 behavior)
	if fromPosition.x ~= CONTAINER_POSITION and player:isPzLocked() then
		local tile = Tile(fromPosition)
		if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
			player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return true
		end
	end

	local doorInfo = DOORS[item.itemid]
	if doorInfo then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It is locked.")
		return true
	end

	local info = ItemType(item.itemid)
	-- Level door section
	if info.levelDoor > 0 then
		-- Premium-only doors (aid 189)
		if item.actionid == 189 then
			if not player:isPremium() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
				return true
			end
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		-- Gender doors
		local genderReq = item.actionid - 186
		if genderReq == PLAYERSEX_FEMALE or genderReq == PLAYERSEX_MALE then
			if player:getSex() ~= genderReq then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
				return true
			end
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		-- Vocation doors
		local vocationReq = item.actionid - 100
		if vocationReq >= 0 and vocationReq < 50 then
			local voc = player:getVocation()
			if voc and voc:getId() ~= vocationReq and voc:getFromVocation() ~= vocationReq then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
				return true
			end
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		-- Level-restricted doors (aid 190 or aid >= level requirement)
		if item.actionid == 190 or (item.actionid ~= 0 and player:getLevel() >= item.actionid - info.levelDoor) then
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
		return true
	end

	-- Special doors (quest/storage)
	if info.specialDoor then
		if item.actionid == 100 or (item.actionid ~= 0 and player:getStorageValue(item.actionid) > 0) then
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		return true
	end

	-- Field / movable item check before door push
	local tile = Tile(fromPosition)
	if tile then
		local fields = tile:getItemsByType(ITEM_TYPE_MAGICFIELD)
		local top = Tile(toPosition):getTopDownItem()
		-- Prevent pushing into magic fields or blocked squares
		if top and top:getId() >= 100 and #fields > 0 then
			return true
		end
	end

	-- Handle creatures in front of door
	local destTile = Tile(toPosition)
	if destTile then
		local thing = destTile:getTopCreature()
		if thing then
			-- Try alternative positions (classic diagonal fallback)
			local alt1 = Position(toPosition.x + 1, toPosition.y, toPosition.z)
			local alt2 = Position(toPosition.x, toPosition.y + 1, toPosition.z)

			local function tryMove(creature, pos)
				local t = Tile(pos)
				if t and t:queryAdd(creature, 20) == RETURNVALUE_NOERROR then
					creature:teleportTo(pos, true)
					return true
				end
				return false
			end

			if not tryMove(thing, alt1) then
				if not tryMove(thing, alt2) then
					player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
					return true
				end
			end

			-- Close door unless it’s a closing door (classic)
			if not info.closingDoor then
				item:transform(info.transformUseTo)
			end

			return true
		end
	end

	return false
end

		-- Skull doors
		local skullReq = item.actionid - 180
		if skullReq >= SKULL_NONE and skullReq <= SKULL_BLACK then
			if player:getSkull() ~= skullReq then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
				return true
			end
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

		-- Group doors
		local groupReq = item.actionid - 150
		if groupReq >= 0 and groupReq < 30 then
			if player:getGroup():getId() < groupReq then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only the worthy may pass.")
				return true
			end
			return doorEnter(player, item, info.transformUseTo, toPosition)
		end

