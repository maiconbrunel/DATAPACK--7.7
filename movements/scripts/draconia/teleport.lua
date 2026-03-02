-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Switch puzzle teleporter
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
if not player then
	return true
	end

	-- switch positions
	local s1 = Tile({x = 32802, y = 31584, z = 1})
	local s2 = Tile({x = 32803, y = 31584, z = 1})
	local s3 = Tile({x = 32804, y = 31584, z = 1})
	local s4 = Tile({x = 32805, y = 31584, z = 1})

	local telePos = Position(32701, 31639, 6)

	-- check switches (item ids: 1945/1946)
	local c1 = s1 and s1:getItemById(1945)
	local c2 = s2 and s2:getItemById(1946)
	local c3 = s3 and s3:getItemById(1945)
	local c4 = s4 and s4:getItemById(1946)

	if item.actionid == 9602 and c1 and c2 and c3 and c4 then
		player:teleportTo(telePos)
		telePos:sendMagicEffect(CONST_ME_TELEPORT)
		else
			local backPos = Position(position.x - 2, position.y, position.z)
			player:teleportTo(backPos)
			backPos:sendMagicEffect(CONST_ME_TELEPORT)
			end

			return true
			end
