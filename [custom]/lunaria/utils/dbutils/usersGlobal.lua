local function generateUuid()
    local template ='xxxxxx'
    return string.gsub(template, '[x]', function ()
        local v = math.random(1,9)
        return string.format('%s', v)
    end)
end

local function uuid()
    local generatedUUid = generateUuid()
    local stringToReplace = {"%[", "%]", "%\"", "uuid:", "{", "}"}
    local result = MySQL.Sync.fetchAll('SELECT uuid FROM users')
    local r = json.encode(result)
    for k,v in pairs(stringToReplace) do
        r = string.gsub(r, v, "")
    end
    local r = string.gsub(r, ",", ", ")
    local r = "{"..r.."}"
    local rm = json.decode(r)

    for k,v in pairs(rm) do
        if generatedUUid == rm[k] then 
            uuid()
            break
        end
    end
    return generatedUUid
end

-- Enregistrement Player Lors de la connexion c'est tout !
function RegisterPlayerGlobal(source)

    -- Variables
    local uuid = uuid()
    local playerName = GetPlayerName(source)
    local startMoney = "10000"
    local bankMoney = "0"
    local posX, posY, posZ = -1037.919, -2738.155, 20.16927
    local lastPos = '{'..posX..', '..posY..', '..posZ..'}'
    local firstConnection = false
    local fivemId = GetPlayerIdentifier(source, identifier)
    local createdAccount = os.date("%Y/%d/%m %X")
    local firstSpawn = true

    -- Requête SQL
    MySQL.Async.execute("INSERT INTO users (uuid, playerName, money, bankMoney, lastPos, firstConnection, idFivem, createdAccount, firstSpawn) VALUES(@uuid, @playerName, @money, @bankMoney, @lastPos, @firstConnection, @idFivem, @createdAccount, @firstSpawn)",
    {["@uuid"] = uuid, ["@playerName"] = playerName, ["@money"] = startMoney, ["@bankMoney"] = bankMoney, ["@lastPos"] = lastPos, ["@firstConnection"] = firstConnection, ["@idFivem"] = fivemId, ["@createdAccount"] = createdAccount, ["@firstSpawn"] = firstSpawn, ["@id"] = id},
    function(result)
        -- Client Event
        TriggerClientEvent("output", source)
    end)
end

-- Get UUID avec la Source
function GetUUIDWithSource(source)
    local result = MySQL.Sync.fetchScalar('SELECT uuid FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

-- Get UUID avec l'id Fivem
function GetUUIDWithFivemID(arg1)
    local result = MySQL.Sync.fetchScalar('SELECT uuid FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = arg1})
    return result
end

-- Get PlayerName avec la Source
function GetPlayerNameWithSource(source)
    local result = MySQL.Sync.fetchScalar('SELECT playerName FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

-- Get Money avec la Source
function GetMoney(source)
    local result = MySQL.Sync.fetchScalar('SELECT money FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

-- Ajouter de la money avec la Source et un int
function addMoney(source, int)
    MySQL.Async.fetchScalar('SELECT money FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)}, function(result)
        initialMoney = tonumber(json.encode(result))
    end)
    Citizen.Wait(10)
    MySQL.Async.execute("UPDATE users SET money = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = tonumber(initialMoney) + tonumber(int), ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

-- Retirer de la money avec la Source et un int
function removeMoney(source, int)
    MySQL.Async.fetchScalar('SELECT money FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)}, function(result)
        initialMoney = tonumber(json.encode(result))
    end)
    Citizen.Wait(10)
    MySQL.Async.execute("UPDATE users SET money = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = tonumber(initialMoney) - tonumber(int), ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

-- Remettre à zero son argent avec la Source
function clearMoney(source)
    MySQL.Async.execute("UPDATE users SET money = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = 0, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

-- Get Money en banque avec la Source
function GetBankMoney(source)
    local result = MySQL.Sync.fetchScalar('SELECT bankMoney FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

-- Ajouter de la money en banque avec la Source et un int
function addBankMoney(source, int)
    MySQL.Async.fetchScalar('SELECT bankMoney FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)}, function(result)
        initialMoney = tonumber(json.encode(result))
    end)
    Citizen.Wait(10)
    MySQL.Async.execute("UPDATE users SET bankMoney = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = tonumber(initialMoney) + tonumber(int), ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

-- Retirer de la money en banque avec la Source et un int
function removeBankMoney(source, int)
    MySQL.Async.fetchScalar('SELECT bankMoney FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)}, function(result)
        initialMoney = tonumber(json.encode(result))
    end)
    Citizen.Wait(10)
    MySQL.Async.execute("UPDATE users SET bankMoney = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = tonumber(initialMoney) - tonumber(int), ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

-- Remettre à zero son argent en banque avec la Source
function clearBankMoney(source)
    MySQL.Async.execute("UPDATE users SET bankMoney = @modifiedMoney WHERE idFivem = @idFivem", {['@modifiedMoney'] = 0, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function saveUser(source)
    local playerName = GetPlayerName(source)
    local posX, posY, posZ = table.unpack(GetEntityCoords(GetPlayerPed(source), true))
    local lastPos = '{'..posX..', '..posY..', '..posZ..'}'
    local id = source
    
    MySQL.Async.execute("UPDATE users SET playerName = @playerName, lastPos = @lastPos, id = @id WHERE idFivem = @idFivem", {['@playerName'] = playerName, ['@lastPos'] = lastPos, ['@id'] = id, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function setFirstSpawn(source, boolean)
    MySQL.Async.execute("UPDATE users SET firstSpawn = @firstSpawn WHERE idFivem = @idFivem", {['@firstSpawn'] = boolean, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function getFirstSpawn(source)
    local result = MySQL.Sync.fetchScalar('SELECT firstSpawn FROM users WHERE idFivem = @idFivem', { ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
    return result
end

function setId(source)
    MySQL.Async.execute("UPDATE users SET id = @id WHERE idFivem = @idFivem", {['@id'] = source, ['@idFivem'] = GetPlayerIdentifier(source, identifier)})
end

function getIdWithUuid(int)
    local result = MySQL.Sync.fetchScalar('SELECT id FROM users WHERE uuid = @uuid', { ['@uuid'] = int})
    return result
end

function getUuidWithId(int)
    local result = MySQL.Sync.fetchScalar('SELECT uuid FROM users WHERE id = @id', { ['@id'] = int})
    return result
end