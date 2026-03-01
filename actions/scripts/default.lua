-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Default item destruction
-- Notes: Ensures only weapons are destroyed safely
-- Changes: Validates target and weapon types

function onUse(player, item, fromPosition, target, toPosition)
    if not target then
        return false
    end

    local it = ItemType(item.itemid)
    local weaponType = it:getWeaponType()

    if weaponType == WEAPON_SWORD or weaponType == WEAPON_CLUB or weaponType == WEAPON_AXE then
        return player:destroyItem(target, toPosition)
    end

    return false
end
