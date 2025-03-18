AddEventHandler('gameEventTriggered', function(event, data)
    if event == 'CEventNetworkEntityDamage' then
        local victim, victimDied = data[1], data[4]
        
        if IsEntityAPed(victim) and victimDied then
            local playerId = PlayerId()
            local ped = PlayerPedId()

            if NetworkGetPlayerIndexFromPed(victim) == playerId and IsEntityDead(ped) then
                TriggerEvent('redutzu-ems:client:closeEMS')
            end
        end
    end
end)