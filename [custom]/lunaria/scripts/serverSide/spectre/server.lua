-- Spectre
AddEventHandler("playerConnecting", function()
    s = source
    setFirstSpawn(s, true)
    MySQL.Async.fetchScalar('SELECT firstConnection FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(s, identifier)}, function(result)
        r = result
        if r == nil then
            RegisterPlayerGlobal(s)
            Citizen.Wait(100)
            RegisterPlayerAdmin(s)
        end
    end)
end)

RegisterServerEvent("Lunaria:saveUser")
AddEventHandler("Lunaria:saveUser", function()
    saveUser(source)
end)

RegisterServerEvent("Lunaria:SpawnPlayer")
AddEventHandler("Lunaria:SpawnPlayer", function()
    s = source
    setId(s)
    if getFirstSpawn(source) then
        MySQL.Async.fetchScalar('SELECT lastPos FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(s, identifier)}, function(result)
            local r = json.decode(result)
            TriggerClientEvent("teleportLastPos", s, r[1], r[2], r[3])
            TriggerClientEvent("sendNotification", s, "~c~Bon jeu à toi ~g~"..GetPlayerName(s).." ~c~!", 10000)
            setFirstSpawn(s, false)
        end)
    else
        TriggerClientEvent("teleportLastPos", s, 295.7367, -585.9496, 43.13942)
    end
end)

AddEventHandler('playerDropped', function (reason)
    saveUser(source)
end)

RegisterCommand("unwanted", function(source)
    ClearPlayerWantedLevel(source)
end)

RegisterCommand("allweapons", function(source)
    TriggerClientEvent("giveAllWeapons", source)
end)

