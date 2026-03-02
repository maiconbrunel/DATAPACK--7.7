-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Equip check for underwater helmet charge
-- Notes: melhorias, atualizações da API, otimizações

function onEquip(player, item, slot, isCheck)
-- only trigger when duration actually starts
if isCheck then
	return true
	end

	if player:isUnderWater() then
		-- item 5461 = helmet (original)
		if item:getId() ~= 5461 or not item:getAttribute(ITEM_ATTRIBUTE_DURATION) then
			callFunction(player, item, slot, false)
			else
				item:transform(12541) -- transformed charged helmet
				end
				end

				return true
				end
