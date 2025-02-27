if not Config.Dispatch or Config.Dispatch == 0 then
    if GetResourceState('codem-dispatch') == 'starting' or GetResourceState('codem-dispatch') == 'started' then
        Config.Dispatch = 6
    end
end

if Config.Dispatch and Config.Dispatch == 6 then
    RegisterNetEvent('rcore_gangs:client:codem_dispatch', function(drugName)
        local data = {
            type = 'Drug',
            header = 'Drug sale in progress',
            text = drugName .. ' being sold',
            code = "10-52",
            message = "Drugs being sold!"
        }

        exports['codem-dispatch']:CustomDispatch(data)
    end)
end
