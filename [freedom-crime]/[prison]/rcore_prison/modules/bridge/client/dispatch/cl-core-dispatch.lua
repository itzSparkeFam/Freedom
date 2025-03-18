CreateThread(function()
    if Config.Dispatches == Dispatches.CORE then
        RegisterNetEvent('rcore_prison:client:setDispatch', function(payload)
            if not payload then
                return 
            end

            exports['core_dispatch']:addMessage(
                payload.message, --- @message string message in the notification
                payload.coords, --- @coords number,number,number coords where the notification is trigger
                payload.job or 'police',
                payload.cooldown or 5000,
                payload.sprite or 488,
                payload.color or 1,
                payload.priority or false
            )            
        end)
    end
end)
