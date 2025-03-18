if Config.Item.Inventory ~= 'ps-inventory' then
    return
end

if Config.Framework ~= 'qb-core' then
    debugPrint('This inventory script works only on QBCore')
    return
end

debugPrint('Inventory script is set to: ps-inventory')

function GetPlayerItems(source)
    local Player = Framework.GetPlayerData(source)
    return Player?.PlayerData.items
end

function CreateItem(name, callback)
    exports['ps-inventory']:CreateUsableItem(name, callback)
end

if Config.Item.Enabled then
    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-mdt:client:openMDT', source)
    end)
end