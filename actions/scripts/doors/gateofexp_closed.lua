-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Door/Window interaction (level & vocation doors)
-- Notes: Fully corrected and modernized

function onUse(player, item, fromPosition, target, toPosition)
local action = item.actionid

-- Identify door type
local isLevelDoor = (action >= 1001 and action <= 1999)
local isVocationDoor = (action >= 2001 and action <= 2008)

-- Not a special door → normal door behavior
if not (isLevelDoor or isVocationDoor) then
	item:transform(item.itemid + 1)
	return true
	end

	local canEnter = true

	----------------------------------------------------------------------
	-- Level Door
	----------------------------------------------------------------------
	if isLevelDoor then
		local reqLevel = action - 1000
		if player:getLevel() < reqLevel then
			canEnter = false
			end
			end

			----------------------------------------------------------------------
			-- Vocation Door
			----------------------------------------------------------------------
			if isVocationDoor then
				local reqVoc = action - 2000
				local voc = player:getVocation():getId()

				-- Valid vocs: 1-8 (Sorcerer/Druid/Paladin/Knight/MS/ED/RP/EK)
				if voc ~= reqVoc then
					canEnter = false
					end
					end

					----------------------------------------------------------------------
					-- Denied
					----------------------------------------------------------------------
					if not canEnter then
						player:sendTextMessage(MESSAGE_INFO_DESCR, "Only the worthy may pass.")
						return true
						end

						----------------------------------------------------------------------
						-- Open door and move player through
						----------------------------------------------------------------------
						item:transform(item.itemid + 1)

						local tile = fromPosition:getTile()
						if not tile then
							return false
							end

							-- Check if player can enter the tile
							if tile:queryAdd(player) ~= RETURNVALUE_NOERROR then
								return false
								end

								local dir = getDirectionTo(player:getPosition(), fromPosition)
								player:move(dir)
								return true
								end
