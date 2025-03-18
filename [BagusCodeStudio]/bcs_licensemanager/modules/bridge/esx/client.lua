ESX = exports['es_extended']:getSharedObject()

while ESX.GetPlayerData().job == nil do
    Wait(100)
end

PlayerData = ESX.GetPlayerData()

function TriggerServerCallback(func, ...)
    ESX.TriggerServerCallback(func, ...)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)
