if not Config.Dispatch or Config.Dispatch == 0 then
    if GetResourceState('origen_police') == 'starting' or GetResourceState('origen_police') == 'started' then
        Config.Dispatch = 7
    end
end

if Config.Dispatch and Config.Dispatch == 7 then
    Dispatch = function(source, drug)
        local coords = GetEntityCoords(GetPlayerPed(source))
        exports['origen_police']:SendAlert({
            coords = coords,
            title = "10-50 - Drug Possession",
            type = 'GENERAL',
            message = 'Drugs being sold',
            job = 'police',
        })

        TriggerClientEvent('rcore_gangs:client:origen_police', source, drug)
    end
end