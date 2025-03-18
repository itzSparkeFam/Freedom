if Config.Item.Inventory ~= 'default' then
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('Inventory script is set to: qb-inventory')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('Inventory script is set to: esx default')
end

-- Add this in @qb-core/shared/items.lua
-- ['ems'] = {
--     ['name'] = 'ems', 			                
--     ['label'] = 'Emergency Services Tablet', 	
--     ['weight'] = 500, 		
--     ['type'] = 'item', 		
--     ['image'] = 'redutzu_ems.png', 		    
--     ['unique'] = false, 	
--     ['useable'] = true, 	
--     ['shouldClose'] = true,	   
--     ['combinable'] = nil,   
--     ['description'] = 'Take roleplay to another level with the most advanced EMS-MDT on FiveM'
-- }

function GetPlayerItems(source)
    if Config.Framework == 'qb-core' then
        local Player = Framework.GetPlayerData(source)
        return Player?.PlayerData?.items
    elseif Config.Framework == 'esx' then
        local Player = ESX.GetPlayerFromId(source)
        return Player?.inventory
    end
end

if Config.Item.Enabled then
    function CreateItem(name, callback)
        if Config.Framework == 'qb-core' then
            QBCore.Functions.CreateUseableItem(name, callback)
        elseif Config.Framework == 'esx' then
            ESX.RegisterUsableItem(name, callback)
        end
    end

    CreateItem(Config.Item.Name, function(source)
        TriggerClientEvent('redutzu-ems:client:openEMS', source)
    end)
end