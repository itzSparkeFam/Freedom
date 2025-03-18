if Config.Framework ~= 'qbox' then
    return
end

Framework = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded',function()
    TriggerServerEvent('redutzu-mdt:server:onPlayerLoaded')
    TriggerEvent('redutzu-mdt:client:onPlayerLoaded')
end)

function Framework.GetPlayerGender()
    if LocalPlayer.state.isLoggedIn then    
        return QBX.PlayerData.charinfo.gender == 1 and Locales['gender:female'] or Locales['gender:male']
    end
end

function Framework.GetPlayerJob()
    if LocalPlayer.state.isLoggedIn then
        return QBX.PlayerData.job.name
    end
end

function Framework.Notify(message, type)
    exports['qbx_core']:Notify(message, type, 5000)
end

local function Callback(name, callback, ...)
    TriggerServerEvent('redutzu-mdt:server-callback:' .. name, ...)

    return RegisterNetEvent('redutzu-mdt:client-callback:' .. name, function(...)
        callback(...)
    end)
end       

function Framework.TriggerCallback(name, callback, ...)
    local event = false

    local cb = function(...)
        if event ~= false then
            RemoveEventHandler(event)
        end

        callback(...)
    end

    event = Callback(name, cb, ...)

    return event
end

function Framework.RegisterClientCallback(name, callback)
    RegisterNetEvent('redutzu-mdt:server-client-callback:' .. name, function(...)
        callback(function(...)
            TriggerServerEvent('redutzu-mdt:client-server-callback:' .. name, ...)            
        end, ...)
    end)
end