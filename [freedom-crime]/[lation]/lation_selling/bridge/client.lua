-- Initialize global variables to store framework & inventory
Framework, Inventory = nil, nil

-- Initialize global player variables
PlayerLoaded, PlayerData = nil, {}

-- Get framework
local function InitializeFramework()
    if GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        Framework = 'esx'

        RegisterNetEvent('esx:playerLoaded', function(xPlayer)
            PlayerData = xPlayer
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)

        RegisterNetEvent('esx:onPlayerLogout', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)

    elseif GetResourceState('qbx_core') == 'started' then
        Framework = 'qbx'

        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)

        RegisterNetEvent('qbx_core:client:playerLoggedOut', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)
    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        Framework = 'qb'

        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)

        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)
    elseif GetResourceState('ox_core') == 'started' then
        Ox = require '@ox_core.lib.init'
        Framework = 'ox'

        AddEventHandler('ox:playerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)

        AddEventHandler('ox:playerLogout', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_selling:onPlayerLoaded')
        end)
    else
        -- Add custom framework here
    end
end

-- Get inventory
local function InitializeInventory()
    if GetResourceState('ox_inventory') == 'started' then
        Inventory = 'ox_inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        Inventory = 'qb-inventory'
    elseif GetResourceState('qs-inventory') == 'started' then
        Inventory = 'qs-inventory'
    elseif GetResourceState('ps-inventory') == 'started' then
        Inventory = 'ps-inventory'
    elseif GetResourceState('origen_inventory') == 'started' then
        Inventory = 'origen_inventory'
    elseif GetResourceState('codem-inventory') == 'started' then
        Inventory = 'codem-inventory'
    else
        -- Add custom inventory here
    end
end

-- Returns player data
function GetPlayerData()
    if Framework == 'esx' then
        return ESX.GetPlayerData()
    elseif Framework == 'qb' then
        return QBCore.Functions.GetPlayerData()
    elseif Framework == 'qbx' then
        return exports.qbx_core:GetPlayerData()
    elseif Framework == 'ox' then
        return Ox.GetPlayer()
    else
        -- Add custom framework here
    end
end

-- Returns players current inventory data
--- @return any
function GetPlayerInventory()
    if Inventory then
        if Inventory == 'ox_inventory' then
            return exports[Inventory]:GetPlayerItems()
        elseif Inventory == 'qb-inventory' then
            return GetPlayerData().items
        elseif Inventory == 'qs-inventory' then
            return exports[Inventory]:getUserInventory()
        elseif Inventory == 'ps-inventory' then
            return GetPlayerData().items
        elseif Inventory == 'origen_inventory' then
            return exports[Inventory]:GetInventory()
        elseif Inventory == 'codem-inventory' then
            return exports[Inventory]:getUserInventory()
        end
    else
        if Framework == 'esx' then
            return GetPlayerData().inventory
        elseif Framework == 'qb' then
            return GetPlayerData().items
        elseif Framework == 'qbx' then
            return print('Are you really not using ox_inventory? Contact support and say: "I\'m special"')
        elseif Framework == 'ox' then
            return print('It is confirmed your insane. Please contact support for mental health evaluation.')
        end
    end
end

-- Returns player job
function GetPlayerJob()
    local player = GetPlayerData()
    if not player then return end
    if Framework == 'esx' then
        return player?.job?.name
    elseif Framework == 'qb' then
        return player.job.name
    elseif Framework == 'qbx' then
        return player.job.name
    elseif Framework == 'ox' then
        -- TODO
    else
        -- Add custom framework here
    end
end

-- Initialize defaults
InitializeFramework()
InitializeInventory()