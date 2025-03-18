CreateThread(function()
    if Config.Dispatches == Dispatches.CODEM then
        RegisterNetEvent('rcore_prison:client:setDispatch', function(payload)
            if not payload then
                return
            end

            exports['codem-dispatch']:CustomDispatch(payload)
        end)
    end
end)



