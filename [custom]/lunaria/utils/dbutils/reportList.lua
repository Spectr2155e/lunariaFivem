function createReport(source, reason)

    local uuid = MySQL.Sync.fetchScalar('SELECT uuid FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    local playerName = GetPlayerName(source)
    local idFivem = GetPlayerIdentifier(source, identifier)
    local date = os.date("%Y/%d/%m %X")
    local claimedBy = nil

    MySQL.Async.execute("INSERT INTO reportList (uuid, playerName, idFivem, reason, date, claimedBy) VALUES(@uuid, @playerName, @idFivem, @reason, @date, @claimedBy)",
    {["@uuid"] = uuid, ["@playerName"] = playerName, ["@idFivem"] = idFivem, ["@reason"] = reason, ["@date"] = date, ["@claimedBy"] = claimedBy},
    function(result)
        -- Client Event
        TriggerClientEvent("output", source)
    end)

end

function getReport(uuid)
    local bool = MySQL.Sync.fetchScalar('SELECT reason FROM reportList WHERE uuid = @uuid', { ['@uuid'] = uuid})
    if bool ~= nil then
        local uuid = uuid
        local playerName = MySQL.Sync.fetchScalar('SELECT playerName FROM reportList WHERE uuid = @uuid', { ['@uuid'] = uuid})
        local reason = MySQL.Sync.fetchScalar('SELECT reason FROM reportList WHERE uuid = @uuid', { ['@uuid'] = uuid})
        local date = MySQL.Sync.fetchScalar('SELECT date FROM reportList WHERE uuid = @uuid', { ['@uuid'] = uuid})

        local result = "{"..uuid..", "..playerName..", "..reason..", "..date.."}"
        return result
    else
        return nil
    end
end

function claimReport(source, uuid)
    MySQL.Async.execute("UPDATE reportList SET claimedBy = @claimedBy WHERE uuid = @uuid", {['@claimedBy'] = GetPlayerName(source), ['@uuid'] = uuid})
end

function getClaim(source)
    local result = MySQL.Sync.fetchScalar('SELECT reportClaim FROM usersAdmin WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end