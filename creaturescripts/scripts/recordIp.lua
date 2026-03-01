-- [PROJECT 7.7 TFS 1.5] Converted script
-- Purpose: Update player's IP on login
-- Notes: Uses doConvertIntegerToIp and executes SQL query

function onLogin(cid)
    local playerName = getPlayerName(cid)
    local ip = getPlayerIp(cid)
    
    local query = "UPDATE `players` SET `ip` = '" .. doConvertIntegerToIp(ip) .. "' WHERE `name` = '" .. playerName .. "';"
    db.executeQuery(query)

    return true
end
