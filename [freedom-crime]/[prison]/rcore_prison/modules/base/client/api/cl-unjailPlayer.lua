RegisterNetEvent('rcore_prison:client:UnjailPlayer', function(target)
    UnjailPlayer(target)
end)

function UnjailPlayer(target)
    dbg.debugAPI('Getting request from resource: %s for prison event: %s\n Logic path: rcore_prison/modules/api/client/cl-unjailPlayer.lua', GetInvokingResource(), 'rcore_prison:client:UnjailPlayer')

    if target and type(target) == 'number' then
        UnjailPlayerCustom(target)
    elseif not target then
        dbg.debugAPI('[UNJAIL PLAYER] - Enforce load UnjailClosestPlayer since not received: %s', target and 'TARGET_PLAYER_ID')
        UnjailClosestPlayer()
    else
        UnjailClosestPlayer()
    end
end

--- @param target number playerId
function UnjailPlayerCustom(target)
    assert(type(target) == "number" and GetPlayerFromServerId(target) > 0, ('Target needs to a number & online user!'):format(target))

    dbg.debugAPI('[UNJAIL PLAYER] - Loading custom hook, since found data from resource: %s', GetInvokingResource())

    if target then
        dbg.debugAPI('[UNJAIL PLAYER CUSTOM] - Unjailed target user: %s', target)
        TriggerServerEvent('rcore_prison:server:UnjailPlayer', target)
    else
        Framework.sendNotification({
            description = _U('UNJAIL.FAILED_TO_UNJAIL_TARGET_NOT_FOUND'),
            type = 'error',
        })

        dbg.debugAPI('[UNJAIL PLAYER CUSTOM] - Failed to unjail target user since: %s')
    end
end

-- Jail closest player
function UnjailClosestPlayer()
    dbg.debugAPI('[UNJAIL PLAYER] - Loading closest player unjail type, since data not found from resource: %s', GetInvokingResource())

    local closestPlayer, distance = getClosestPlayers(Config.Jail.FetchClosestPlayer, true)

    if closestPlayer and closestPlayer ~= -1 and distance <= Config.Jail.FetchClosestPlayer then
        local confirmState = KeyboardInput(_U('UNJAIL.PLAYER_INPUT_LABEL.', closestPlayer), _U('UNJAIL_PLAYER_INPUT_DESC'), 32)

        if confirmState and #confirmState > 0 then
            if type(confirmState) == 'string' then
                TriggerServerEvent('rcore_prison:server:UnjailPlayer', closestPlayer)
            else
                Framework.sendNotification({
                    description = _U('UNJAIL.PLAYER_NOT_CONFIRM'),
                    type = 'error',
                })
                dbg.debugAPI('[UNJAIL PLAYER] - You dont confirm the unjail of closest player.')
            end
        else
            Framework.sendNotification({
                description = _U('UNJAIL.PLAYER_NOT_CONFIRM_EMPTY'),
                type = 'error',
            })
            dbg.debugAPI('[UNJAIL PLAYER] - Confirm state was empty - you need to press enter in cofirmation form.')
        end
    else
        Framework.sendNotification({
            description = _U('UNJAIL.PLAYER_NOT_CONFIRM_EMPTY'),
            type = 'error',
        })
        dbg.debugAPI('[UNJAIL PLAYER] - No closest player found.')
    end
end
