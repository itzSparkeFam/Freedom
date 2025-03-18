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
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)

        RegisterNetEvent('esx:onPlayerLogout', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)

    elseif GetResourceState('qbx_core') == 'started' then
        Framework = 'qbx'

        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)

        RegisterNetEvent('qbx_core:client:playerLoggedOut', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)
    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        Framework = 'qb'

        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)

        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)
    elseif GetResourceState('ox_core') == 'started' then
        Ox = require '@ox_core.lib.init'
        Framework = 'ox'

        AddEventHandler('ox:playerLoaded', function()
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
        end)

        AddEventHandler('ox:playerLogout', function()
            table.wipe(PlayerData)
            PlayerLoaded = false
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() ~= resourceName then return end
            PlayerData = GetPlayerData()
            PlayerLoaded = true
            TriggerEvent('lation_coke:onPlayerLoaded')
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
    elseif GetResourceState('core_inventory') == 'started' then
        Inventory = 'core_inventory'
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

-- Returns players current inventory
--- @return any
function GetInventory()
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
            return exports[Inventory]:GetClientPlayerInventory()
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
function GetJob()
    local player = GetPlayerData()
    if not player then return end
    if Framework == 'esx' then
        return player?.job?.name
    elseif Framework == 'qb' then
        return player.job.name
    elseif Framework == 'qbx' then
        return player.job.name
    elseif Framework == 'ox' then
        return player.getGroupByType('job')
    else
        -- Add custom framework here
    end
end

-- Return data for item
--- @param item string
function GetItemData(item)
    if not item then return end
    if Inventory then
        if Inventory == 'ox_inventory' then
            return exports[Inventory]:Items(item)
        elseif Inventory == 'qb-inventory' or Inventory == 'ps-inventory' then
            return QBCore.Shared.Items[item]
        elseif Inventory == 'qs-inventory' then
            local items = exports[Inventory]:GetItemList()
            if not items then return end
            return items[item]
        elseif Inventory == 'origen_inventory' then
            local items = exports[Inventory]:GetItems()
            if not items then return end
            return items[item]
        elseif Inventory == 'codem-inventory' then
            local items = exports[Inventory]:GetItemList()
            if not items then return end
            return items[item]
        elseif Inventory == 'core_inventory' then
            -- No client-side export available to get item list
            if Framework == 'qb' then
                return QBCore.Shared.Items[item]
            end
        else
            -- Add custom inventory here
        end
    else
        if Framework == 'esx' then
            -- Unlikely to need anything here but.. just in case..
            print('An error has occured with lation_meth - please contact support')
        elseif Framework == 'qb' then
            return QBCore.Shared.Items[item]
        elseif Framework == 'qbx' then
            -- Unlikely to need anything here but.. just in case..
            print('Are you really not using ox_inventory? Contact support please lul.')
        end
    end
end

-- Returns boolean if player has specified amount of item
--- @param item string
--- @param amount number
--- @return boolean
function HasItem(item, amount)
    if not item or not amount then return false end
    if Inventory then
        if Inventory == 'ox_inventory' then
            return exports[Inventory]:Search('count', item) >= amount
        elseif Inventory == 'core_inventory' then
            return exports[Inventory]:hasItem(item, amount)
        else
            return exports[Inventory]:HasItem(item, amount)
        end
    else
        local playerData = GetPlayerData()
        if not playerData then return false end
        local inventory = Framework == 'esx' and playerData.inventory or playerData.items
        if not inventory then return false end
        for _, itemData in pairs(inventory) do
            if itemData and itemData.name == item then
                local count = itemData.amount or itemData.count or 0
                if count >= amount then
                    return true
                end
            end
        end
        return false
    end
end

-- Disables access to open/view inventory
function DisableInventory()
    if Inventory == 'ox_inventory' then
        LocalPlayer.state.invBusy = true
    elseif Inventory == 'qb-inventory' then
        LocalPlayer.state.inv_busy = true
    elseif Inventory == 'qs-inventory' then
        exports[Inventory]:setInventoryDisabled(true)
    elseif Inventory == 'core_inventory' then
        exports[Inventory]:lockInventory()
    else
        -- Add custom inventory here
    end
end

-- Enables access to open/view inventory
function EnableInventory()
    if Inventory == 'ox_inventory' then
        LocalPlayer.state.invBusy = false
    elseif Inventory == 'qb-inventory' then
        LocalPlayer.state.inv_busy = false
    elseif Inventory == 'qs-inventory' then
        exports[Inventory]:setInventoryDisabled(false)
    elseif Inventory == 'core_inventory' then
        exports[Inventory]:unlockInventory()
    else
        -- Add custom inventory here
    end
end

-- Initialize defaults
InitializeFramework()
InitializeInventory()