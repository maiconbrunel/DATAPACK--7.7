-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Default item interaction
-- Notes: melhorias, atualizações da API, otimizações

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local it = ItemType(item.itemid)
    -- Validate weapon types
    if it:getWeaponType() == WEAPON_SWORD or it:getWeaponType() == WEAPON_CLUB or it:getWeaponType() == WEAPON_AXE then
        return player:destroyItem(target, toPosition)
    end
    return false
end
