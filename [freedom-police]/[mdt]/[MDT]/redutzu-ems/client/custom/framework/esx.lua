if Config.Framework ~= 'esx' then
    return
end

Framework = {}

success, ESX = pcall(function()
    return exports['es_extended']:getSharedObject()
end)

if not success then
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(object)
            ESX = object
        end)
    
        Wait(500)
    end
end

RegisterNetEvent('esx:playerLoaded',function()
    TriggerServerEvent('redutzu-ems:server:onPlayerLoaded')
    TriggerEvent('redutzu-ems:client:onPlayerLoaded')
end)

function Framework.GetPlayerGender()
    local PlayerData = ESX.GetPlayerData()
    return PlayerData.sex == 'f' and Locales['gender:female'] or Locales['gender:male']
end

function Framework.GetPlayerJob()
    local PlayerData = ESX.GetPlayerData()
    return PlayerData?.job?.name
end

function Framework.Notify(message, type)
    TriggerEvent('esx:showNotification', message, type, 5000)
end

function Framework.TriggerCallback(name, callback, ...)
    ESX.TriggerServerCallback('ems-' .. name, callback, ...)
end

-- Older ESX compatibility

function Framework.RegisterClientCallback(name, callback)
    if not ESX.RegisterClientCallback then
        RegisterNetEvent('redutzu-ems:server-client-callback:' .. name, function(...)
            callback(function(...)
                TriggerServerEvent('redutzu-ems:client-server-callback:' .. name, ...)            
            end, ...)
        end)
    else
        ESX.RegisterClientCallback('ems-' .. name, callback)
    end
end