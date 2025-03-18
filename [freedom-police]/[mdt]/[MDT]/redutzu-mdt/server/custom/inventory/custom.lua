if Config.Item.Inventory ~= 'custom' then
    return
end

function GetPlayerItems(source)
    return {}
end

function CreateItem(name, callback)
    -- implement your own inventory code
end

if Config.Item.Enabled then
    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-mdt:client:openMDT', source)
    end)
end