if not Config.Dispatch or Config.Dispatch == 0 then
    if GetResourceState('origen_police') == 'starting' or GetResourceState('origen_police') == 'started' then
        Config.Dispatch = 7
    end
end

if Config.Dispatch and Config.Dispatch == 7 then
    RegisterNetEvent('rcore_gangs:client:origen_police')
    AddEventHandler('rcore_gangs:client:origen_police', function(drug)

    end)
end