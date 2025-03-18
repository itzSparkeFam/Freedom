--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'esx' then
    return
end

ESX = nil

local legacyEsx = pcall(function()
    ESX = exports['es_extended']:getSharedObject()
end)
if not legacyEsx then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

identifierTable = 'identifier'
userColumn = 'users'
garageTable = 'owned_vehicles'
garageIdentifierColumn = 'owner'

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerFromIdentifier(identifier)
    identifier = string.gsub(identifier, ' ', '')
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetItem(player, item)
    return player.getInventoryItem(item)
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        print('ESX player not found. Source: ', source)
        return false
    end
    return player.identifier
end

function GetItems(player)
    if not player then return end
    if Config.Inventory == 'codem-inventory' then
        local inventory = player.getInventory()
        for k, v in pairs(inventory) do
            if tonumber(v.amount) <= 0 then
                inventory[k] = nil
            elseif not Config.UniquePhone and not v.info then
                inventory[k].info = {}
                inventory[k].metadata = {}
            end
        end
        return inventory
    elseif Config.Inventory == 'tgiann-inventory' then
        local inventory = exports['tgiann-inventory']:GetPlayerItems(player.source)
        for k, v in pairs(inventory) do
            if tonumber(v.amount) <= 0 then
                inventory[k] = nil
            elseif not Config.UniquePhone and not v.info then
                inventory[k].info = {}
                inventory[k].metadata = {}
            end
        end
        return inventory
    else
        local inventory = player.getInventory()
        for k, v in pairs(inventory) do
            if v.count <= 0 then
                inventory[k] = nil
            elseif not Config.UniquePhone and not v.info then
                inventory[k].info = {}
                inventory[k].metadata = {}
            end
        end
        return inventory
    end
end

function GetPlayerSource(player)
    return player.source
end

function SetPlayerBucket(source, bucket)
    SetPlayerRoutingBucket(source, bucket)
end

function SetMetaData(source, key, value)
    local player = GetPlayerFromId(source)
    if value == nil then
        return player.clearMeta(key)
    end
    player.setMeta(key, value)
end

function GetMetaData(source, key)
    local player = GetPlayerFromId(source)
    return player.getMeta(key)
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.addAccountMoney(account, amount)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.removeAccountMoney(account, amount)
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    return player.getAccount(account).money
end
