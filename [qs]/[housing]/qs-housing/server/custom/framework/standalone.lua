if Config.Framework ~= 'standalone' then return end

-- ESX Callbacks
local serverCallbacks = {}

local clientRequests = {}
local RequestId = 0

---@param eventName string
---@param callback function
RegisterServerCallback = function(eventName, callback)
    serverCallbacks[eventName] = callback
end

exports('RegisterServerCallback', RegisterServerCallback)

RegisterNetEvent('houses:triggerServerCallback', function(eventName, requestId, invoker, ...)
    if not serverCallbacks[eventName] then
        return print(('[^1ERROR^7] Server Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
    end

    local source = source

    serverCallbacks[eventName](source, function(...)
        TriggerClientEvent('houses:serverCallback', source, requestId, invoker, ...)
    end, ...)
end)

---@param player number playerId
---@param eventName string
---@param callback function
---@param ... any
TriggerClientCallback = function(player, eventName, callback, ...)
    clientRequests[RequestId] = callback

    TriggerClientEvent('houses:triggerClientCallback', player, eventName, RequestId, GetInvokingResource() or 'unknown', ...)

    RequestId = RequestId + 1
end

RegisterNetEvent('houses:clientCallback', function(requestId, invoker, ...)
    if not clientRequests[requestId] then
        return print(('[^1ERROR^7] Client Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
    end

    clientRequests[requestId](...)
    clientRequests[requestId] = nil
end)

function RegisterUsableItem(name, cb)
    ImplementError('RegisterUsableItem is not supported with standalone')
    return false
end

function GetIdentifier(source)
    ImplementError('Get Identifier : You need to implement this function for your framework.')
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len('license:')) == 'license:' then
            return v:gsub('license:', '')
        end
    end
    return nil
end

function GetPlayerFromId(source)
    return {
        source = source,
        identifier = GetIdentifier(source)
    }
end

function GetPlayerSource(player)
    return player.source
end

function GetPlayerFromIdentifier(identifier)
    identifier = string.gsub(identifier, ' ', '')
    local players = GetPlayers()
    for k, v in pairs(players) do
        if GetIdentifier(v) == identifier then
            return {
                source = v,
                identifier = identifier
            }
        end
    end
    return nil
end

function GetPlayerSourceFromIdentifier(identifier)
    local player = GetPlayerFromIdentifier(identifier)
    if player then
        return player.source
    end
    return nil
end

function AddMoneyToAccount(account, amount, isNotRent)
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        AddAccountMoney(source, 'bank', amount)
        if isNotRent then return end
        TriggerClientEvent('qb-houses:sendTextMessage', source, Lang('HOUSING_NOTIFICATION_RENT_PAYMENT') .. amount, 'error')
    else
        ImplementError('Add Money Account : You need to implement this function for your framework.')
    end
end

function GetCharacterName(source)
    ImplementError('Get Character Name : You need to implement this function for your framework.')
    return 'Unknown', 'Unknown'
end

function GetAccountMoney(source, account)
    ImplementError('Get Account Money : You need to implement this function for your framework.')
    return 999999999999 -- for provide error
end

function AddAccountMoney(source, account, amount)
    ImplementError('Add Account Money : You need to implement this function for your framework.')
end

function RemoveAccountMoney(source, account, amount)
    ImplementError('Remove Account Money : You need to implement this function for your framework.')
end

function RemoveItem(source, item, count)
    ImplementError('Remove Item : You need to implement this function for your framework.')
end

function GetPlayerSourceFromIdentifier(identifier)
    local player = GetPlayerFromIdentifier(identifier)
    if not player then
        return false
    end
    return player.source
end

function GetPlayerSourceFromSource(source)
    local player = GetPlayerFromId(source)
    if not player then
        return false
    end
    return player.source
end

function GetCharacterFromIdentifier(identifier)
    ImplementError('Get Character From Identifier : You need to implement this function for your framework.')
    return 'unknown', 'unknown'
end

function GetJobName(source)
    ImplementError('Get Job Name : You need to implement this function for your framework.')
    return Config.CreatorJobs
end

function RemoveMoneyFromAccount(account, amount, dontCheck)
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        RemoveAccountMoney(source, 'bank', amount)
        return true
    else
        ImplementError('Remove Money From Account : You need to implement this function for your framework.')
    end
    return false
end

function GetPlayerSQLDataFromIdentifier(identifier)
    ImplementError('Check Player Is Exist : You need to implement this function for your framework.')
    return true
end

function UpdateInside(src, insideId, bool)
    ImplementError('Update Inside : You need to implement this function for your framework.')
end

RegisterServerCallback('qb-phone:server:MeosGetPlayerHouses', function(source, cb, input)
    ImplementError('qb-phone:server:MeosGetPlayerHouses : You need to implement this function for your framework.')
    cb(nil)
end)

RegisterServerCallback('houses:GetIdentifier', function(source, cb)
    local identifier = GetIdentifier(source)
    cb(identifier)
end)

RegisterServerCallback('houses:GetPlayers', function(source, cb)
    cb(GetPlayers())
end)
