CreateThread(function()
    if Config.Dispatches == Dispatches.PS then
        RegisterNetEvent('rcore_prison:client:setDispatch', function(payload)
            if not payload then
                return
            end

            TriggerServerEvent('ps-dispatch:server:notify', payload) -- Official ps-dispatch event.
        end)
    end
end, "cl-ps-dispatch code name: Phoenix")



