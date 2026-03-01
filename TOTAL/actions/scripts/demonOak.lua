-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Demon Oak quest
-- Notes: melhorias, atualizações da API, otimizações

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

local onePerQuest = true
local level = 80

local positions = {
    kick = {x = 32716, y = 32338, z = 7},
    summon = {
        {x = 32712, y = 32348, z = 7},
        {x = 32713, y = 32354, z = 7},
        {x = 32719, y = 32353, z = 7},
        {x = 32719, y = 32347, z = 7}
    }
}

local summons = {
    [1] = {"Demon","Elder Beholder", "Demon Skeleton"},
    [2] = {"Beholder", "Banshee", "Beholder", "Elder Beholder"}
}

local areaPosition = {
    {x = 32706, y = 32340, z = 7, stackpos = 255},
    {x = 32729, y = 32360, z = 7, stackpos = 255}
}

local demonOak = {8288, 8289, 8290, 8291}

local storages = {
    done = 35700,
    cutTree = 36901
}

local blockingTree = {
    [2709] = {32193, 3669}
}

-- Validate blocking tree
if blockingTree[target.itemid] and target.uid == blockingTree[target.itemid][1] then

    local tree = toPosition
    if isInRange(tree, areaPosition[1], areaPosition[2]) then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something is wrong, please contact a gamemaster.")
        return false
    end

    if player:getLevel() < level then
        player:sendCancel("You need level " .. level .. " or more to enter this quest.")
        return true
    end

    if player:getStorageValue(storages.done) > 0 then
        player:sendCancel("You already done this quest.")
        return true
    end

    if player:getStorageValue(storages.cutTree) > 0 then
        return false
    end

    -- One per quest validation
    if onePerQuest then
        for _, pid in ipairs(Game.getPlayers()) do
            if isInRange(pid:getPosition(), areaPosition[1], areaPosition[2]) then
                player:sendCancel("Wait until " .. pid:getName() .. " finish the quest.")
                return true
            end
        end
    end

    target:transform(blockingTree[target.itemid][2])
    toPosition:sendMagicEffect(CONST_ME_POFF)
    player:move(SOUTH)
    player:setStorageValue(storages.cutTree, 1)
    return true

-- Demon oak core logic
elseif isInArray(demonOak, target.itemid) then

    local get = player:getStorageValue(target.itemid)
    if get == -1 then
        player:setStorageValue(target.itemid, 1)
    end

    if player:getStorageValue(8288) == 12 and
       player:getStorageValue(8289) == 12 and
       player:getStorageValue(8290) == 12 and
       player:getStorageValue(8291) == 12 then
        player:teleportTo(positions.kick)
        player:setStorageValue(storages.done, 1)
        return true
    end

    if player:getStorageValue(target.itemid) > 11 then
        toPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    if math.random(100) <= 1 then
        player:setStorageValue(target.itemid, 12)
        return true
    end

    if summons[get] then
        for i = 1, #summons[get] do
            Game.createMonster(summons[get][i], positions.summon[i])
        end

        toPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
        player:setStorageValue(target.itemid, get + 1)

        if math.random(100) >= 50 then
            doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -270, -310, CONST_ME_BIGPLANTS)
        end
    end

    return false
end

end
