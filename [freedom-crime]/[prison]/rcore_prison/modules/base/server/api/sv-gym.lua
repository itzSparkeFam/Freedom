RegisterNetEvent('rcore_prison:server:UpdateExerciseStats', function(exerciseName, zoneId)
    local playerId = source

    if not playerId then
        return
    end
    
    if not zoneId then
        return
    end

    if not IsAtZone(zoneId, playerId) then
        return
    end

    dbg.debug('Updating exercise stats for playerId: %s | exerciseName: %s', playerId, exerciseName)

    local statValue = 2.0
    
    if isResourceLoaded(GYM_RESOURCES.RTX) then
        dbg.debug('Successfully increased stats using RTX GYM resource for user %s (%s) with value', GetPlayerName(playerId), playerId, statValue)
        exports[GYM_RESOURCES.RTX]:AddStats(playerId, "energy", statValue)	
    end
end)