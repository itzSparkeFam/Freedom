if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    PlayerData = GetPlayerData()
    Debug('init playerData')
end)

RegisterNetEvent('esx:setJob', function(jobData)
    PlayerData.job = jobData
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    PlayerData = playerData
    IsLoggedIn = true
    Wait(2500)
    TriggerServerCallback('qb-houses:GetInside', function(currentHouse)
        Debug('qb-houses:GetInside', currentHouse)
        if currentHouse and currentHouse ~= 'nil' and currentHouse ~= '' then
            Wait(100)
            TriggerEvent('qb-houses:client:LastLocationHouse', currentHouse)
        end
    end)
end)

RegisterNetEvent('esx:playerLogout')
AddEventHandler('esx:playerLogout', function()
    IsLoggedIn = false
    CurrentHouseData = {}
    DeleteBlips()
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerData()
    return ESX.GetPlayerData()
end

function GetIdentifier()
    return GetPlayerData().identifier
end

function GetJobName()
    return PlayerData?.job?.name or 'unemployed'
end

function GetPlayers()
    return ESX.Game.GetPlayers()
end

function GetVehicleProperties(vehicle)
    return ESX.Game.GetVehicleProperties(vehicle)
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
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

function DrawTextBoard(x, y, z, text)
    SetTextScale(0.45, 0.45)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(0, 0, 0, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function DrawGenericText(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(0.40, 0.00)
end

function Notification(msg, type)
    if GetResourceState('qs-interface') == 'started' then
        if type == 'inform' then
            exports['qs-interface']:AddNotify(msg, 'Inform', 2500, 'fa-solid fa-file')
        elseif type == 'error' then
            exports['qs-interface']:AddNotify(msg, 'Error', 2500, 'fas fa-bug')
        elseif type == 'success' then
            exports['qs-interface']:AddNotify(msg, 'Success', 2500, 'fas fa-thumbs-up')
        end
        return
    end

    if type == 'inform' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'inform'
        })
    elseif type == 'error' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'error'
        })
    elseif type == 'success' then
        lib.notify({
            title = 'Housing',
            description = msg,
            type = 'success'
        })
    end
end

function ToggleHud(bool)
    if bool then
        Debug('Event to show the hud [client/custom/framework/esx.lua line 177]')
        -- DisplayRadar(false) -- You can enable or disable mini-map here
        if GetResourceState('qs-interface') == 'started' then
            exports['qs-interface']:ToggleHud(false)
        end
    else
        Debug('Event to hide the hud [client/custom/framework/esx.lua line 177]')
        -- DisplayRadar(true) -- You can enable or disable mini-map here
        if GetResourceState('qs-interface') == 'started' then
            exports['qs-interface']:ToggleHud(true)
        end
    end
end
