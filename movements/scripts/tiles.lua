-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Protection tiles, vocations, groups, skulls, level doors, premium, depot info
-- Notes: melhorias, atualizações da API, otimizações

local config = {
	increasing = {
		[416] = 417, [426] = 425, [446] = 447,
		[3216] = 3217, [3202] = 3215
	},
	decreasing = {
		[417] = 416, [425] = 426, [447] = 446,
		[3217] = 3216, [3215] = 3202
	},
	maxLevel = configManager.getNumber("maximumDoorLevel")
}

local checkCreature = {
	function(c) return Creature(c):isPlayer() end,
	function(c) return Creature(c):isMonster() end,
	function(c) return Creature(c):isNpc() end
}

local function pushBack(creature, position, fromPosition, displayMessage)
creature:teleportTo(fromPosition, false)
position:sendMagicEffect(CONST_ME_MAGIC_BLUE)

if displayMessage then
	creature:sendTextMessage(MESSAGE_INFO_DESCR, "The tile seems to be protected against unwanted intruders.")
	end
	end

	function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	local inc = config.increasing[item:getId()]
	if not inc then
		return false
		end

		if not creature:isGhost() then
			item:transform(inc)
			end

			-- Creature filters (Player / Monster / NPC only)
			if item.actionid >= 194 and item.actionid <= 196 then
				local f = checkCreature[item.actionid - 193]
				if f(creature) then
					pushBack(creature, position, fromPosition, false)
					end
					return true
					end

					if item.actionid >= 191 and item.actionid <= 193 then
						local f = checkCreature[item.actionid - 190]
						if not f(creature) then
							pushBack(creature, position, fromPosition, false)
							end
							return true
							end

							if not player then
								return true
								end

								-- Premium door
								if item.actionid == 189 and not player:isPremium() then
									pushBack(player, position, fromPosition, true)
									return true
									end

									-- Gender door
									local gender = item.actionid - 186
									if gender == PLAYERSEX_FEMALE or gender == PLAYERSEX_MALE or gender == PLAYERSEX_GAMEMASTER then
										if gender ~= player:getSex() then
											pushBack(player, position, fromPosition, true)
											end
											return true
											end

											-- Skull restriction
											local skull = item.actionid - 180
											if skull >= SKULL_NONE and skull <= SKULL_BLACK then
												if skull ~= creature:getSkull() then
													pushBack(player, position, fromPosition, true)
													end
													return true
													end

													-- Group ID restriction
													local group = item.actionid - 150
													if group >= 0 and group < 30 then
														if group > player:getGroup():getId() then
															pushBack(player, position, fromPosition, true)
															end
															return true
															end

															-- Vocation door
															local vocation = item.actionid - 100
															if vocation >= 0 and vocation < 50 then
																local voc = player:getVocation()
																if voc:getId() ~= vocation and voc:getFromVocation() ~= vocation then
																	pushBack(player, position, fromPosition, true)
																	end
																	return true
																	end

																	-- Level door
																	if item.actionid >= 1000 and item.actionid - 1000 <= config.maxLevel then
																		if player:getLevel() < (item.actionid - 1000) then
																			pushBack(player, position, fromPosition, true)
																			end
																			return true
																			end

																			-- Storage restriction
																			if item.actionid ~= 0 and player:getStorageValue(item.actionid) <= 0 then
																				pushBack(player, position, fromPosition, true)
																				return true
																				end

																				-- Depot count message in protection zone
																				local tile = Tile(position)
																				if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
																					local lookPos = player:getPosition():getNextPosition(player:getDirection())
																					local depot = Tile(lookPos):getItemByType(ITEM_TYPE_DEPOT)

																					if depot then
																						local depotItems = player:getDepotItems(player:getDepotId(depot))
																						player:sendTextMessage(
																							MESSAGE_STATUS_DEFAULT,
											 string.format("Your depot contains %d item%s.", depotItems, depotItems ~= 1 and "s" or "")
																						)
																						return true
																						end
																						end

																						return false
																						end

																						function onStepOut(creature, item, position, fromPosition)
																						local dec = config.decreasing[item:getId()]
																						if not dec then
																							return false
																							end

																							if not creature:isGhost() then
																								item:transform(dec)
																								return true
																								end

																								return false
																								end
