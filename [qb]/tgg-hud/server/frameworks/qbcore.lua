if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

local function checkForPoliceJob(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
    if not player then return false end

    if not player.PlayerData.job then return false end

    if not player.PlayerData.job.name then return false end

    for _, v in pairs(Config.PoliceJobs) do
        if player.PlayerData.job.name == v then return true end
    end

    return false
end

RegisterNetEvent('hud:server:GainStress', function(amount)
    if not Config.EnableStress then return end

    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player or (Config.DisableStressForPolice and checkForPoliceJob(src)) then return end

    local newStress

    if not player.PlayerData.metadata.stress then
        player.PlayerData.metadata.stress = 0
    end

    newStress = player.PlayerData.metadata.stress + amount
    if newStress <= 0 then newStress = 0 end

    if newStress > 100 then
        newStress = 100
    end

    player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if not Config.EnableStress then return end

    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not player then return end

    if not player.PlayerData.metadata.stress then
        player.PlayerData.metadata.stress = 0
    end

    newStress = player.PlayerData.metadata.stress - amount

    if newStress <= 0 then newStress = 0 end

    if newStress > 100 then
        newStress = 100
    end

    player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
end)
