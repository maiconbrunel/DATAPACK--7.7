-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Underwater food – Helmet of the Deep
-- Notes: underwater & helmet checks fixed
-- Changes: Player API, speed handling

local HOTD = {5461, 12541}

function onUse(player, item, fromPosition, target, toPosition)
    local food = SPECIAL_FOODS[item.itemid]
    if food == nil then
        return false
    end

    local helmet = player:getSlotItem(CONST_SLOT_HEAD)
    if not helmet or (not table.contains(HOTD, helmet.itemid)) or not player:isUnderWater() then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You should only eat this dish when wearing a helmet of the deep and walking underwater.")
        return true
    end

    local deepHelmetInfo = ItemType(HOTD[2])

    if helmet.itemid ~= HOTD[2] then
        helmet:transform(HOTD[2])
        player:changeSpeed(deepHelmetInfo:getAbilities().speed)
    end

    helmet:setAttribute("duration", deepHelmetInfo:getDecayTime() * 1000)
    item:remove(1)

    player:say(food, TALKTYPE_MONSTER)
    return true
end

