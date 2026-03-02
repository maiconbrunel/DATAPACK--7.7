-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Tile relocation cleanup + transform
-- Notes: melhorias, atualizações da API, otimizações

local function cleanTile(position, ignoreUid)
local tile = Tile(position)
if not tile then
	return
	end

	for _, item in ipairs(tile:getItems() or {}) do
		if item.uid ~= ignoreUid and not item:isMovable() then
			item:remove()
			end
			end
			end

			function onStepOut(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
				end

				-- Se ainda houver criaturas no tile, não faz nada
				local tile = Tile(position)
				if tile and #tile:getCreatures() > 0 then
					return true
					end

					-- Tenta posição para a direita
					local newPosition = Position(position.x + 1, position.y, position.z)
					if not Tile(newPosition) or Tile(newPosition):hasFlag(TILESTATE_BLOCKSOLID) then
						-- Tenta posição abaixo
						newPosition = Position(position.x, position.y + 1, position.z)
						end

						-- Se posição válida, relocação
						if Tile(newPosition) and not Tile(newPosition):hasFlag(TILESTATE_BLOCKSOLID) then
							position = Position(position)
							Game.relocate(position, newPosition)
							end

							-- Limpeza do tile após relocação
							cleanTile(position, item.uid)

							-- Transformação final
							local itemType = ItemType(item:getId())
							if itemType and itemType:hasTransformUseTo() then
								item:transform(itemType:getTransformUseTo())
								end

								return true
								end

								function onStepIn(creature, item, position, fromPosition)
								-- Script duplicado no original → mantido apenas transformação simples
								local itemType = ItemType(item:getId())
								if itemType and itemType:hasTransformUseTo() then
									item:transform(itemType:getTransformUseTo())
									end
									return true
									end
