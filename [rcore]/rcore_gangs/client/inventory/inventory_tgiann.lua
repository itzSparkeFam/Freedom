Inventory = Inventory or {}

if not Config.Inventory or Config.Inventory == 0 then
    if GetResourceState('tgiann-inventory') == 'starting' or GetResourceState('tgiann-inventory') == 'started' then
        Config.Inventory = 10
    end
end

if Config.Inventory and Config.Inventory == 10 then
    Inventory.GetItems = function()
        local inventory = exports["tgiann-inventory"]:GetPlayerItems()
        for key, itemData in pairs(inventory) do
            inventory[key].label = exports["tgiann-inventory"]:GetItemLabel(itemData.name)
        end
        return inventory
    end

    Inventory.OpenStorage = function(storage)
        local other = {}

        other.slots = Config.GangOptions.storageSlots or 50
        other.maxweight = Config.GangOptions.storageWeight or 100000

        TriggerEvent('inventory:client:SetCurrentStash', storage)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', storage, other)
        TriggerServerEvent('rcore_gangs:tgiann-inventory:openInventory', 'stash', storage)
    end

    Inventory.OpenPlayerInventory = function(player)
        local serverId = GetPlayerServerId(player)
        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', serverId)
        TriggerServerEvent('rcore_gangs:tgiann-inventory:openInventory', 'otherplayer', serverId)
    end
end
