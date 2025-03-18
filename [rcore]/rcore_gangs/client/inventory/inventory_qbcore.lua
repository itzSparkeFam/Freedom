Inventory = Inventory or {}

if not Config.Inventory or Config.Inventory == 0 then
    if GetResourceState('qb-inventory') == 'starting' or GetResourceState('qb-inventory') == 'started' then
        Config.Inventory = 1
    end
end

if Config.Inventory and Config.Inventory == 1 then
    Inventory.GetItems = function()
        return QBCore.Functions.GetPlayerData().items
    end

    Inventory.OpenStorage = function(storage)
        local other = {}

        other.slots = Config.GangOptions.storageSlots or 50
        other.maxweight = Config.GangOptions.storageWeight or 100000

        TriggerEvent('inventory:client:SetCurrentStash', storage)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', storage, other)
        TriggerServerEvent('rcore_gangs:qb-inventory:openInventory', 'stash', storage)
    end

    Inventory.OpenPlayerInventory = function(player)
        local serverId =  GetPlayerServerId(player)
        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', serverId)
        TriggerServerEvent('rcore_gangs:qb-inventory:openInventory', 'otherplayer', serverId)
    end
end