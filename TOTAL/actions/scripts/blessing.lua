-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Blessing info
-- Notes: melhorias, atualizações da API, otimizações

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerBlessings = {}
    for i = 1, 5 do
        -- Validate blessing
        if player:hasBlessing(i) then
            table.insert(playerBlessings, player:getBlessingName(i))
        end
    end

    local message = "You have no blessings."
    if #playerBlessings > 0 then
        message = "You have the following blessings: " .. table.concat(playerBlessings, ", ", " and ") .. "."
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, message)
    return true
end
