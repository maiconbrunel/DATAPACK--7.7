-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Auto-transform tile on step-in
-- Notes: melhorias, atualizações da API, otimizações

function onStepIn(creature, item, position, fromPosition)
item:transform(item:getId() + 1)
item:decay()
return true
end
