Inventory = Inventory or {}

if not Config.Inventory or Config.Inventory == 9 then
    if GetResourceState('codem-inventory') == 'starting' or GetResourceState('codem-inventory') == 'started' then
        Config.Inventory = 9
    end
end

if Config.Inventory and Config.Inventory == 9 then
    Inventory.GetItems = function()
        local items = {}

        local inventory = exports['codem-inventory']:GetClientPlayerInventory()

        for index, item in pairs(inventory) do
            if (item.count and item.count > 0) or (item.amount and item.amount > 0) then
                table.insert(items, item)
            end
        end

        return items
    end

    Inventory.OpenStorage = function(storage)
        TriggerServerEvent('codem-inventory:server:openstash', storage, 50,150000, 'Gang storage')
    end

    Inventory.OpenPlayerInventory = function(player)
        TriggerServerEvent("rcore_gangs:server:codem_inventory", GetPlayerServerId(player))
    end
end
