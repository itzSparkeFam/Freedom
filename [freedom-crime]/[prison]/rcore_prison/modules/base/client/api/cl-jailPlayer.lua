RegisterNetEvent('rcore_prison:client:JailPlayer', function(target, jailTime)
    JailPlayer(target, jailTime)
end)

RegisterNetEvent('rcore_prison:client:JailByIdentifier', function(target, jailTime)
    JailByIdentifier(target, jailTime)
end)

function JailByIdentifier(target, jailTime)
    dbg.debugAPI('Getting request from resource: %s for prison event: %s\n Logic path: rcore_prison/modules/api/client/cl-jailPlayer.lua', GetInvokingResource(), 'rcore_prison:client:JailPlayer')

    if type(target) ~= 'string' then
        return
    end

    local jailTime, receivedTime, stateCode = isJailTimeValid(jailTime)

    if jailTime then
        dbg.debugAPI('[JAIL PLAYER] - Jailed target user: %s | received time: %s', target, receivedTime)
        TriggerServerEvent('rcore_prison:server:JailByIdentifier', target, jailTime)
    else
        Framework.sendNotification({
            description = _U('JAIL.PLAYER_CLOSEST_PLAYER_JAIL_FAIL'),
            type = 'error',
        })
        dbg.debugAPI('[JAIL PLAYER] - Failed to jailed target user since: %s | received time: %s', stateCode, receivedTime)
    end
end

function JailPlayer(target, jailTime)
    dbg.debugAPI('Getting request from resource: %s for prison event: %s\n Logic path: rcore_prison/modules/api/client/cl-jailPlayer.lua', GetInvokingResource(), 'rcore_prison:client:JailPlayer')

    if target and jailTime then
        JailPlayerCustom(target, jailTime)
    elseif not target or not jailTime then
        if not target then
            dbg.debugAPI('[JAIL PLAYER] - Enforce load JailClosestPlayer since not received: %s', 'TARGET_PLAYER_ID')
        elseif not jailTime then
            dbg.debugAPI('[JAIL PLAYER] - Enforce load JailClosestPlayer since not received: %s', 'JAIL_TIME')
        end

        JailClosestPlayer()
    else
        JailClosestPlayer()
    end
end

function isNumber(inputString)
    return inputString and inputString:match("^%d+$") ~= nil
end

--- @return any jailTime, any receivedTime, string stateCode
function isJailTimeValid(jailTime)
    if not jailTime then return end

    local retval = nil
    local stateCode = JAIL_TIME_VALIDATION_STATES.IS_INVALID

    if type(jailTime) == 'string' then
        if isNumber(jailTime) then
           retval = tonumber(jailTime)
           stateCode = JAIL_TIME_VALIDATION_STATES.IS_VALID
        end
    elseif type(jailTime) == 'number' then
        retval = jailTime
        stateCode = JAIL_TIME_VALIDATION_STATES.IS_VALID
    end

    return retval, jailTime, stateCode
end

--- @param target number playerId
--- @param time any jailTime: accept string/number
function JailPlayerCustom(target, time)
    assert(type(target) == "number" and GetPlayerFromServerId(target) > 0, ('Target needs to a number & online user!'):format(target))
    if not time then return dbg.critical('JAIL PLAYER - received empty time, failure.') end

    dbg.debugAPI('[JAIL PLAYER] - Loading custom hook, since found data from resource: %s', GetInvokingResource())

    local jailTime, receivedTime, stateCode = isJailTimeValid(time)

    if jailTime then
        dbg.debugAPI('[JAIL PLAYER] - Jailed target user: %s | received time: %s', target, receivedTime)
        TriggerServerEvent('rcore_prison:server:JailPlayer', target, jailTime)
    else
        Framework.sendNotification({
            description = _U('JAIL.PLAYER_CLOSEST_PLAYER_JAIL_FAIL'),
            type = 'error',
        })
        dbg.debugAPI('[JAIL PLAYER] - Failed to jailed target user since: %s | received time: %s', stateCode, receivedTime)
    end
end

-- Jail closest player
function JailClosestPlayer()
    dbg.debugAPI('[JAIL PLAYER] - Loading closest player jail type, since data not found from resource: %s', GetInvokingResource())

    local closestPlayer, distance = getClosestPlayers(Config.Jail.FetchClosestPlayer, true)

    if closestPlayer and closestPlayer ~= -1 and distance <= Config.Jail.FetchClosestPlayer then
        local jailTime = KeyboardInput(_U('JAIL.PLAYER_INPUT_LABEL') .. ' - [' .. closestPlayer .. ']', _U('JAIL.PLAYER_INPUT_DESC'), 32)

        if jailTime and #jailTime > 0 then
            if isNumber(jailTime) then
                TriggerServerEvent('rcore_prison:server:JailPlayer', closestPlayer, tonumber(jailTime))
            else
                Framework.sendNotification(_U('JAIL.PLAYER_JAIL_TIME_NOT_NUMBER'), 'error')
                dbg.debugAPI('[JAIL PLAYER] - Jail time is not a number.')
            end
        else
            Framework.sendNotification(_U('JAIL.PLAYER_JAIL_TIME_REQUIRED'), 'error')
            dbg.debugAPI('[JAIL PLAYER] - Jail time is required.')
        end
    else
        Framework.sendNotification(_U('JAIL.PLAYER_CLOSEST_PLAYER_NOT_FOUND'), 'error')
        dbg.debugAPI('[JAIL PLAYER] - No closest player found.')
    end
end