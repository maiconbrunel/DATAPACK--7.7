-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Pot of blackjack
-- Notes: ActionId progression fix
-- Changes: replaced all cid/do functions with modern API

local config = {
    MSG_EAT = "You take a gulp from the large bowl, but there's still some blackjack in it.",
    MSG_GONE = "You take the last gulp from the large bowl. No leftovers!"
}

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if not food then
        return false
    end

    local addHealth = player:getMaxHealth() - player:getHealth()

    if item.actionid < 3500 then
        item:setActionId(3500)
        if addHealth > 0 then player:addHealth(addHealth) end
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, config.MSG_EAT)

    elseif item.actionid >= 3500 and item.actionid <= 3501 then
        item:setActionId(item.actionid + 1)
        if addHealth > 0 then player:addHealth(addHealth) end
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, config.MSG_EAT)

    elseif item.actionid == 3502 then
        item:setActionId(3503)
        if addHealth > 0 then player:addHealth(addHealth) end
        player:sendTextMessage(MESSAGE_STATUS_DEFAULT, config.MSG_GONE)
        item:remove(1)
    end

    player:say(food, TALKTYPE_MONSTER)
    return true
end

