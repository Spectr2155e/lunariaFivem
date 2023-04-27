function RegisterPlayerAdmin(source)

    local uuid = MySQL.Sync.fetchScalar('SELECT uuid FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    local playerName = GetPlayerName(source)
    local idFivem = GetPlayerIdentifier(source, identifier)
    local permissionLevel = 0
    local lastPosBring = nil
    local freezeState = false
    local reportState = false

    MySQL.Async.execute("INSERT INTO usersAdmin (uuid, playerName, idFivem, permissionLevel, lastPosBring, freezeState, reportState) VALUES (@uuid, @playerName, @idFivem, @permissionLevel, @lastPosBring, @freezeState, @reportState)",
    {["@uuid"] = uuid, ["@playerName"] = playerName, ["@idFivem"] = idFivem, ["@permissionLevel"] = permissionLevel, ["@lastPosBring"] = lastPosBring, ["@freezeState"] = freezeState, ["@reportState"] = reportState},
    function(result)
        print("Registered Player Admin")
    end)
end

function setBringBack(source, position)
    if position ~= nil then
        local posX, posY, posZ = table.unpack(position)
        local lastPosBring = '{'..posX..', '..posY..', '..posZ..'}'
        MySQL.Async.execute("UPDATE usersAdmin SET lastPosBring = @lastPosBring WHERE idFivem = @idFivem", {['@lastPosBring'] = lastPosBring, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    else
        MySQL.Async.execute("UPDATE usersAdmin SET lastPosBring = @lastPosBring WHERE idFivem = @idFivem", {['@lastPosBring'] = nil, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    end
end

function getBringBack(source)
    local result = MySQL.Sync.fetchScalar("SELECT lastPosBring FROM usersAdmin WHERE idFivem = @idFivem", { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    local resultDecoded = json.decode(result)
    return resultDecoded
end

function getPermissionLevel(source)
    local result = MySQL.Sync.fetchScalar("SELECT permissionLevel FROM usersAdmin WHERE idFivem = @idFivem", { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

function setPermissionLevel(source, int)
    MySQL.Async.execute("UPDATE usersAdmin SET permissionLevel = @permissionLevel WHERE idFivem = @idFivem", {['@permissionLevel'] = int, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function setReportState(source, boolean)
    MySQL.Async.execute("UPDATE usersAdmin SET reportState = @reportState WHERE idFivem = @idFivem", {['@reportState'] = boolean, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function getReportState(source)
    local result = MySQL.Sync.fetchScalar("SELECT reportState FROM usersAdmin WHERE idFivem = @idFivem", { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end