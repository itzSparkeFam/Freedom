if Config.Item.Inventory ~= 'qs-inventory' then
    return
end

debugPrint('Inventory script is set to: qs-inventory')

function GetPlayerItems(source)
    return exports['qs-inventory']:GetInventory(source)
end

if Config.Item.Enabled then
    function CreateItem(name, callback)
        exports['qs-inventory']:CreateUsableItem(name, callback)
    end

    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-ems:client:openEMS', source)
    end)
end