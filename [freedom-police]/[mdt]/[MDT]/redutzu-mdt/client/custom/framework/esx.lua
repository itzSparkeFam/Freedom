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
    TriggerServerEvent('redutzu-mdt:server:onPlayerLoaded')
    TriggerEvent('redutzu-mdt:client:onPlayerLoaded')
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
    ESX.TriggerServerCallback(name, callback, ...)
end

-- Older ESX compatibility

function Framework.RegisterClientCallback(name, callback)
    if not ESX.RegisterClientCallback then
        RegisterNetEvent('redutzu-mdt:server-client-callback:' .. name, function(...)
            callback(function(...)
                TriggerServerEvent('redutzu-mdt:client-server-callback:' .. name, ...)            
            end, ...)
        end)
    else
        ESX.RegisterClientCallback(name, callback)
    end
end