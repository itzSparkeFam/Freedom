function CitizenAttackedGuard(playerId)
    if not Config.Guards.EnableJailAllCitizensWhenAttackedGuard then
        dbg.debug('Player %s attacked a prison guard, but jailing all citizens is disabled', GetPlayerName(playerId))
        return
    end

    dbg.debug('Player %s attacked a prison guard, jailing...', GetPlayerName(playerId))

    exports['rcore_prison']:Jail(playerId, Config.Guards.JailTime, 'Attacked a guard')
end