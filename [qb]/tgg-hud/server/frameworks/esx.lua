if not GetResourceState('es_extended'):find('start') then return end

local ESX = exports.es_extended:getSharedObject()

local function checkForPoliceJob(playerId)
    local player = ESX.GetPlayerFromId(playerId)
    if not player then return false end

    if not player.job then return false end

    if not player.job.name then return false end

    for _, v in pairs(Config.PoliceJobs) do
        if player.job.name == v then return true end
    end

    return false
end

RegisterNetEvent('hud:server:GainStress', function(amount)
    if not Config.EnableStress then return end

    local src = source
    local player = ESX.GetPlayerFromId(src)
    if not player or (Config.DisableStressForPolice and checkForPoliceJob(src)) then return end

    amount *= 10000

    TriggerClientEvent('esx_status:add', src --[[@as number]], 'stress', amount)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if not Config.EnableStress then return end

    local src = source
    local player = ESX.GetPlayerFromId(src)
    if not player then return end

    amount *= 10000

    TriggerClientEvent('esx_status:remove', src --[[@as number]], 'stress', amount)
end)
