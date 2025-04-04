--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= 'qb' then
    return
end

ESX = nil

Citizen.CreateThread(function()
    ESX = exports['qb-core']:GetCoreObject()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('qb-crypto:server:FetchWorth')
    TriggerServerEvent('qb-crypto:server:GetRebootState')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)

end)

---@param msg string
---@param type 'info' | 'error' | 'success'
function Notification(msg, type)
    lib.notify({
        title = msg,
        type = type
    })
end

RegisterNetEvent('apartments:notification', Notification)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Logout()
end)

function GetPlayerData()
    return ESX.Functions.GetPlayerData()
end

function GetIdentifier()
    return GetPlayerData().citizenid
end

function GetInventory()
    return GetPlayerData().items
end

function Notification(message, type)
    if type == 'success' then
        TriggerEvent('QBCore:Notify', message, 'success', 5000)
    elseif type == 'error' then
        TriggerEvent('QBCore:Notify', message, 'error', 5000)
    elseif type == 'inform' then
        TriggerEvent('QBCore:Notify', message, 'error', 5000)
    end
end

local texts = {}
if GetResourceState('qs-textui') == 'started' then
    function DrawText3D(x, y, z, text, id, key)
        local _id = id
        if not texts[_id] then
            CreateThread(function()
                texts[_id] = 5
                while texts[_id] > 0 do
                    texts[_id] = texts[_id] - 1
                    Wait(0)
                end
                texts[_id] = nil
                exports['qs-textui']:DeleteDrawText3D(id)
                Debug('Deleted text', id)
            end)
            TriggerEvent('textui:DrawText3D', x, y, z, text, id, key)
        end
        texts[_id] = 5
    end
else
    function DrawText3D(x, y, z, text)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry('STRING')
        SetTextCentre(true)
        AddTextComponentString(text)
        SetDrawOrigin(x, y, z, 0)
        DrawText(0.0, 0.0)
        local factor = text:len() / 370
        DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
        ClearDrawOrigin()
    end
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = text:len() / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawGenericText(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.65, 0.65)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(0.725, 0.90)
end
