if not Config.Dispatch or Config.Dispatch == 0 then
    if GetResourceState('codem-dispatch') == 'starting' or GetResourceState('codem-dispatch') == 'started' then
        Config.Dispatch = 6
    end
end

if Config.Dispatch and Config.Dispatch == 6 then
    Dispatch = function(source, drug)
        TriggerClientEvent('rcore_gangs:client:codem_dispatch', source, drug)
    end
end