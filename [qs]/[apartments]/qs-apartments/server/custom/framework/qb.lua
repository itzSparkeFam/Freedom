--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'qb' then
    return
end

ESX = exports['qb-core']:GetCoreObject()

identifierTable = 'citizenid'
userColumn = 'players'
garageTable = 'owned_vehicles'
garageIdentifierColumn = 'owner'

function RegisterUsableItem(name, cb)
    ESX.Functions.CreateUseableItem(name, cb)
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
end)

function GetPlayerFromId(source)
    source = tonumber(source)
    return ESX.Functions.GetPlayer(source)
end

function GetPlayerFromIdentifier(identifier)
    identifier = string.gsub(identifier, ' ', '')
    return ESX.Functions.GetPlayerByCitizenId(identifier)
end

function GetItem(player, item)
    local data = player.Functions.GetItemByName(item)
    data.count = data.amount
    return data
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        print('QB player not found. Source: ', source)
        return false
    end
    return player.PlayerData.citizenid
end

function GetItems(player)
    if not player then return false end
    return player.PlayerData.items
end

function GetPlayerSource(player)
    return player.PlayerData.source
end

function SetPlayerBucket(source, bucket)
    ESX.Functions.SetPlayerBucket(source, tonumber(bucket))
end

function SetMetaData(source, key, value)
    local player = GetPlayerFromId(source)
    player.Functions.SetMetaData(key, value)
end

function GetMetaData(source, key)
    local player = GetPlayerFromId(source)
    return player.PlayerData.metadata[key]
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    if account == 'black_money' then
        Debug('Black money setted to crypto')
        account = 'crypto'
    end
    player.Functions.AddMoney(account, amount)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    if account == 'black_money' then account = 'crypto' end
    return player.PlayerData.money[account]
end
