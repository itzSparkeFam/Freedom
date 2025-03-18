if Config.Framework ~= 'qb-core' then
    return
end

Framework = {}

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded',function()
    TriggerServerEvent('redutzu-ems:server:onPlayerLoaded')
    TriggerEvent('redutzu-ems:client:onPlayerLoaded')
end)

function Framework.GetPlayerGender()
    if LocalPlayer.state.isLoggedIn then    
        local PlayerData = QBCore.Functions.GetPlayerData()
        return PlayerData.charinfo.gender == 1 and Locales['gender:female'] or Locales['gender:male']
    end
end

function Framework.GetPlayerJob()
    if LocalPlayer.state.isLoggedIn then
        local PlayerData = QBCore.Functions.GetPlayerData()
        return PlayerData.job.name
    end
end

function Framework.Notify(message, type)
    TriggerEvent('QBCore:Notify', message, type, 5000)
end

function Framework.TriggerCallback(name, callback, ...)
    QBCore.Functions.TriggerCallback('ems-' .. name, callback, ...)
end

function Framework.RegisterClientCallback(name, callback)
    QBCore.Functions.CreateClientCallback('ems' .. name, callback)
end