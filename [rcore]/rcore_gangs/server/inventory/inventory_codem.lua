Inventory = Inventory or {}

if not Config.Inventory or Config.Inventory == 0 then
    if GetResourceState('codem-inventory') == 'starting' or GetResourceState('codem-inventory') == 'started' then
        Config.Inventory = 9
    end
end

if Config.Inventory and Config.Inventory == 9 then
    Inventory.GetPlayerItem = function(source, item)
        return exports['codem-inventory']:GetItemByName(source, item)
    end

    Inventory.AddPlayerItem = function(source, item, amount, slot, info)
        return exports['codem-inventory']:AddItem(source, item, amount, slot, info)
    end

    Inventory.RemovePlayerItem = function(source, item, amount, slot)
        return exports['codem-inventory']:RemoveItem(source, item, amount, slot)
    end

    Inventory.IsStorageEmpty = function(storage)
        local items = exports['codem-inventory']:GetStashItems(storage)
        
        if type(items) == 'table' then
            return next(items) == nil
        else
            return false
        end
    end

    RegisterNetEvent("rcore_gangs:server:codem_inventory", function(playerSrc)
        local source = source
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)

        local playerBeingSearched = GetPlayerPed(playerSrc)
        local playerBeingSearchedCoords = GetEntityCoords(playerBeingSearched)

        if #(playerCoords - playerBeingSearchedCoords) >= 7.5 then
            return
        end
        TriggerClientEvent('codem-inventory:client:openplayerinventory', source, tonumber(playerSrc))
    end)
end