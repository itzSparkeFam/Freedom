RegisterNetEvent('rcore_prison:server:UnjailPlayer', function(target)
    UnjailPlayer(source, target)
end)

function UnjailPlayer(source, target, resourceName)
    local playerId = source

    if not Framework.canPerformJobCommand(playerId) then
        Framework.sendNotification(playerId, _U('GENERAL.YOU_NEED_TO_BE_IN_JOB'), 'error')
        dbg.info("Cannot perform this command - you are not job member!", playerId)
        return
    end

    if target and GetPlayerPed(target) then
        local player = Framework.getPlayer(target)

        if player then
            local isPrisoner = PrisonService.CheckForAnySentence(playerId)

            if isPrisoner then
                if resourceName then
                    provideDebugEmulator('UNJAIL PLAYER', resourceName, source, 'unjail')
                end

                PrisonService.UnjailCitizen(playerId, true)
            else
                Framework.sendNotification(playerId, _U('GENERAL.TARGET_PLAYER_NOT_PRISONER'), 'error')
            end
        end
    else
        Framework.sendNotification(source, _U('GENERAL.TARGET_PLAYER_IS_OFFLINE'), 'error')
    end 
end