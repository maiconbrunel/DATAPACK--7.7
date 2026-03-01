-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: banana chocolate shake consumable
-- Notes: English text, modern API
-- Changes: replaced deprecated calls

function onUse(player, item, fromPosition, target, toPosition)
    item:remove(1)
    player:say("You don't really know what this did to you, but suddenly you feel very happy.", TALKTYPE_MONSTER)
    player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
    return true
end

