if Config.Item.Inventory ~= 'custom' then
    return
end

function GetPlayerItems(source)
    return {}
end

if Config.Item.Enabled then
    function CreateItem(name, callback)
        -- implement your own inventory code
    end

    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-ems:client:openEMS', source)
    end)
end