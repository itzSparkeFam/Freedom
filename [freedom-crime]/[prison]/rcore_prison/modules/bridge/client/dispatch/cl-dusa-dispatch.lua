CreateThread(function()
    if Config.Dispatches == Dispatches.DUSA then
        RegisterNetEvent('rcore_prison:client:setDispatch', function(payload)
            if not payload then
                return
            end
    
            TriggerServerEvent('dusa_dispatch:sendDispatch', payload)
        end)
    end
end, "cl-dusa-dispatch code name: Phoenix")



