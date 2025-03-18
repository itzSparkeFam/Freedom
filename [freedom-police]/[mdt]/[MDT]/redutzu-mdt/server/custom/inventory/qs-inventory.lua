if Config.Item.Inventory ~= 'qs-inventory' then
    return
end

debugPrint('Inventory script is set to: qs-inventory')

function GetPlayerItems(source)
    return exports['qs-inventory']:GetInventory(source)
end

if Config.Framework == 'esx' then
    function Framework.GetWeapons()
        local weapons = exports['qs-inventory']:GetWeaponList() 
        local list = {}

        for key, value in pairs(weapons) do
            list[#list + 1] = { name = value.name, label = value.label }
        end

        return list
    end  
end

function CreateItem(name, callback)
    exports['qs-inventory']:CreateUsableItem(name, callback)
end

if Config.Item.Enabled then
    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-mdt:client:openMDT', source)
    end)
end