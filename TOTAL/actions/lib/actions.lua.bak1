-- tools.lua - Converted to TFS 1.5 Downgrade 7.72 (Wirless)
-- Behavior preserved exactly as original script

local SPOTS = {384, 418}
local ROPABLE = {294, 369, 370, 383, 392, 408, 409, 427, 428, 430, 462, 469, 470, 482, 484, 485, 489, 924, 3135, 3136, 3137}

local HOLES = {468, 481, 483}
local SAND = {231}

local JUNGLE_GRASS = {2782, 3985}
local SPIDER_WEB = {7538, 7539}
local BAMBOO_FENCE = {3798, 3799}
local WILD_GROWTH = {1499}

local PUMPKIN = 2683
local PUMPKIN_HEAD = 2096
local POOL = 2016

local DOORS = {
	[1209] = 1211, [1212] = 1214, [1231] = 1233, [1234] = 1236,
	[1249] = 1251, [1252] = 1254, [3535] = 3537, [3544] = 3546,
	[4913] = 4915, [4916] = 4918
}

local function destroyItem(player, itemEx, pos)
if itemEx:getUniqueId() > 0 or itemEx:getActionId() > 0 then
	return false
	end

	local itemId = itemEx:getId()

	-- Spider web
	if table.contains(SPIDER_WEB, itemId) then
		if math.random(3) == 1 then
			itemEx:transform(itemId + 6)
			itemEx:decay()
			end
			pos:sendMagicEffect(CONST_ME_POFF)
			return true
			end

			-- Bamboo fence
			if table.contains(BAMBOO_FENCE, itemId) then
				if math.random(3) == 1 then
					if itemId == BAMBOO_FENCE[1] then
						itemEx:transform(itemId + 161)
						else
							itemEx:transform(itemId + 159)
							end
							itemEx:decay()
							end
							pos:sendMagicEffect(CONST_ME_POFF)
							return true
							end

							-- Destroyable furniture list check
							local canDestroy =
							(table.contains({1770, 2098, 1774, 1775, 2064, 2094, 2095, 1619, 2602, 3805, 3806}, itemId)) or
							(itemId >= 1724 and itemId <= 1741) or
							(itemId >= 2581 and itemId <= 2588) or
							(itemId >= 1747 and itemId <= 1753) or
							(itemId >= 1714 and itemId <= 1717) or
							(itemId >= 1650 and itemId <= 1653) or
							(itemId >= 1666 and itemId <= 1677) or
							(itemId >= 1614 and itemId <= 1616) or
							(itemId >= 3813 and itemId <= 3820) or
							(itemId >= 3807 and itemId <= 3810) or
							(itemId >= 2080 and itemId <= 2085) or
							(itemId >= 2116 and itemId <= 2119)

							if not canDestroy then
								return false
								end

								if math.random(7) == 1 then
									-- drop logic preserved EXACTLY
									local dropId

									if table.contains({1738, 1739, 1770, 2098, 1774, 1775, 2064}, itemId) or
										(itemId >= 2581 and itemId <= 2588) then
										dropId = 2250
										elseif (itemId >= 1747 and itemId <= 1749) or itemId == 1740 then
											dropId = 2251
											elseif (itemId >= 1714 and itemId <= 1717) then
												dropId = 2252
												elseif (itemId >= 1650 and itemId <= 1653) or
													(itemId >= 1666 and itemId <= 1677) or
													(itemId >= 1614 and itemId <= 1616) or
													(itemId >= 3813 and itemId <= 3820) or
													(itemId >= 3807 and itemId <= 3810) then
													dropId = 2253
													elseif (itemId >= 1724 and itemId <= 1737) or
														(itemId >= 2080 and itemId <= 2085) or
														(itemId >= 2116 and itemId <= 2119) or
														table.contains({2094, 2095}, itemId) then
														dropId = 2254
														elseif (itemId >= 1750 and itemId <= 1753) or table.contains({1619, 1741}, itemId) then
															dropId = 2255
															elseif itemId == 2602 then
																dropId = 2257
																elseif itemId == 3805 or itemId == 3806 then
																	dropId = 2259
																	end

																	if dropId then
																		Game.createItem(dropId, 1, pos)
																		end

																		itemEx:remove()
																		end

																		pos:sendMagicEffect(CONST_ME_POFF)
																		return true
																		end

																		TOOLS = {}

																		--------------------------------------------------------
																		-- ROPE
																		--------------------------------------------------------
																		TOOLS.ROPE = function(player, item, fromPos, itemEx, toPos)
																		local tile = Tile(toPos)
																		if not tile then
																			player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
																			return true
																			end

																			-- Rope from rope spots
																			if table.contains(SPOTS, tile:getGround():getId()) then
																				local dest = Position(toPos.x, toPos.y + 1, toPos.z - 1)
																				player:teleportTo(dest, false)
																				return true
																				end

																				-- Rope from holes & ropes
																				if table.contains(ROPABLE, itemEx:getId()) then
																					local downTile = Tile(Position(toPos.x, toPos.y, toPos.z + 1))
																					local target = downTile and downTile:getTopCreature()
																					if target then
																						target:teleportTo(Position(toPos.x, toPos.y + 1, toPos.z), false)
																						else
																							player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
																							end
																							return true
																							end

																							return false
																							end

																							--------------------------------------------------------
																							-- PICK
																							--------------------------------------------------------
																							TOOLS.PICK = function(player, item, fromPos, itemEx, toPos)
																							local tile = Tile(Position(toPos.x, toPos.y, toPos.z))
																							if not tile then return false end

																								if table.contains(SPOTS, tile:getGround():getId()) and table.contains({354, 355}, itemEx:getId()) then
																									itemEx:transform(392)
																									itemEx:decay()
																									toPos:sendMagicEffect(CONST_ME_POFF)
																									return true
																									end

																									return false
																									end

																									--------------------------------------------------------
																									-- MACHETE
																									--------------------------------------------------------
																									TOOLS.MACHETE = function(player, item, fromPos, itemEx, toPos, destroy)
																									local id = itemEx:getId()

																									if table.contains(JUNGLE_GRASS, id) then
																										itemEx:transform(id - 1)
																										itemEx:decay()
																										return true
																										end

																										if table.contains(SPIDER_WEB, id) then
																											if math.random(3) == 1 then
																												itemEx:transform(id + 6)
																												itemEx:decay()
																												end
																												toPos:sendMagicEffect(CONST_ME_POFF)
																												return true
																												end

																												if table.contains(BAMBOO_FENCE, id) then
																													if math.random(3) == 1 then
																														if id == BAMBOO_FENCE[1] then
																															itemEx:transform(id + 161)
																															else
																																itemEx:transform(id + 159)
																																end
																																itemEx:decay()
																																end
																																toPos:sendMagicEffect(CONST_ME_POFF)
																																return true
																																end

																																if id == WILD_GROWTH then
																																	toPos:sendMagicEffect(CONST_ME_POFF)
																																	itemEx:remove()
																																	return true
																																	end

																																	return destroy and destroyItem(player, itemEx, toPos) or false
																																	end

																																	--------------------------------------------------------
																																	-- SHOVEL
																																	--------------------------------------------------------
																																	TOOLS.SHOVEL = function(player, item, fromPos, itemEx, toPos)
																																	local id = itemEx:getId()

																																	-- holes
																																	if table.contains(HOLES, id) then
																																		local newId = id + 1
																																		if id == 8579 then newId = 8585 end
																																			itemEx:transform(newId)
																																			itemEx:decay()
																																			return true
																																			end

																																			-- sand
																																			if table.contains(SAND, id) then
																																				local r = math.random(1, 100)
																																				local tile = Tile(Position(toPos.x, toPos.y, toPos.z))
																																				if tile then
																																					local ground = tile:getGround()
																																					if ground and table.contains(SPOTS, ground:getId()) and r <= 20 then
																																						itemEx:transform(489)
																																						itemEx:decay()
																																						elseif r <= 5 then
																																							Game.createItem(2159, 1, toPos)
																																							elseif r >= 85 then
																																								Game.createMonster("Scarab", toPos, false)
																																								end
																																								end
																																								toPos:sendMagicEffect(CONST_ME_POFF)
																																								end

																																								return true
																																								end

																																								--------------------------------------------------------
																																								-- SCYTHE
																																								--------------------------------------------------------
																																								TOOLS.SCYTHE = function(player, item, fromPos, itemEx, toPos, destroy)
																																								if itemEx:getId() == 2739 then
																																									itemEx:transform(2737)
																																									Game.createItem(2694, 1, toPos)
																																									itemEx:decay()
																																									return true
																																									end

																																									return destroy and destroyItem(player, itemEx, toPos) or false
																																									end

																																									--------------------------------------------------------
																																									-- KNIFE
																																									--------------------------------------------------------
																																									TOOLS.KNIFE = function(player, item, fromPos, itemEx, toPos)
																																									if itemEx:getId() ~= PUMPKIN then
																																										return false
																																										end

																																										itemEx:transform(PUMPKIN_HEAD)
																																										return true
																																										end
