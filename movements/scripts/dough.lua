-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Auto-transform bread dough into bread when placed on tile
-- Notes: melhorias, atualizações da API, otimizações

function onAddItem(item, tileItem, position, creature)
if item:getId() == 2693 then -- bread dough
	item:transform(2689) -- bread
	position:sendMagicEffect(CONST_ME_HITBYFIRE)
	end
	return true
	end
