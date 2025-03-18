
local recentPedSesssions = {}

provideExport('sendToJail', 'esx_jail', PrisonService.Jail)

RegisterNetEvent('rcore_prison:server:JailByIdentifier', function(target, jailTime)
    JailPlayer(source, target, jailTime, 'identifier')
end)

RegisterNetEvent('rcore_prison:server:JailPlayer', function(target, jailTime)
    JailPlayer(source, target, jailTime)
end)

RegisterNetEvent('rcore_prison:server:StartComs', function(target, jailTime)
    JailPlayer(source, target, jailTime, 'rcore', 'coms')
end)

RegisterNetEvent('rcore_prison:server:JailPlayerByNPC', function(target, netId)
    JailPlayerByNPC(target, netId)
end)

RegisterNetEvent('police:server:JailPlayer', function(target, jailTime)
    JailPlayer(source, target, jailTime, 'qbcore')
end)

RegisterNetEvent('esx-qalle-jail:jailPlayer', function(target, jailTime, jailReason)
    JailPlayer(source, target, jailTime, 'qalle')
end)

RegisterNetEvent('qb-communityservice:server:StartCommunityService', function(target, jailTime)
    JailPlayer(source, target, jailTime, 'qbcore', 'coms')
end)

RegisterNetEvent('qs-dispatch:server:addPenalListToPlayer', function(array)
    if isResourceLoaded('qs-dispatch') then
        local data = array
        local player = data.player
        
        if not player then return end
        
        local targetPlayerId = player and player.info and player.info.source
        local jailData = data[1] and data[1]
        local jailTime = jailData and jailData.jailTime or 0
            
        JailPlayer(source, targetPlayerId, jailTime, 'quasar')
    end
end)

function JailPlayerByNPC(target, netId)
    if not netId then
        return
    end

    if not target then
        return
    end

    if recentPedSesssions[netId] then
        return
    end

    local entity = NetworkGetEntityFromNetworkId(netId)

    if DoesEntityExist(entity) then
        local mePed = GetPlayerPed(target)
        local targetPed = GetPedIndexFromEntityIndex(entity)

        if mePed and targetPed then
            local meCoords = GetEntityCoords(mePed)
            local targetCoords = GetEntityCoords(targetPed)

            if #(meCoords - targetCoords) <= Config.JailByNPCSettings.JailDistance then
                dbg.debug('Jailing player %s (%s) by NPC with netId (%s)', GetPlayerName(target), target, netId)

                PrisonService.JailCitizen(target, target, Config.JailByNPCSettings.JailTime, _U('JAIL_REASONS.NPC_JAIL'))
                recentPedSesssions[netId] = true

                SetTimeout(1000 * 60 * Config.JailByNPCSettings.ResetPedPool, function()
                    recentPedSesssions[netId] = nil
                    dbg.debug('Resetting ped with netId (%s) - allowing to jail citizen via API', netId)
                end)
            end
        end
    else
        dbg.debug('Failed to jail target player %s (%s) by NPC - entity does not exist!', GetPlayerName(target), target)
    end
end


function JailPlayer(source, target, jailTime, resourceName, jailType)
    local playerId = source
    local emulatorName = 'JAIL PLAYER'

    if not Framework.canPerformJobCommand(playerId) then
        Framework.sendNotification(playerId, _U('GENERAL.YOU_NEED_TO_BE_IN_JOB'), 'error')
        dbg.info("Cannot perform this command - you are not job member!", playerId)
        return
    end

    if Config.RestrictCommandsForDistance and (resourceName ~= 'qbcore' and resourceName ~= 'identifier') then
        local mePed = GetPlayerPed(playerId)
        local targetPed = GetPlayerPed(target)

        local meCoords = GetEntityCoords(mePed)
        local targetCoords = GetEntityCoords(targetPed)

        local distance = #(meCoords - targetCoords)

        if distance > Config.RestrictDistance then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.TOO_FAR_AWAY'), 'error')
            dbg.debug('Failed to jail player since they are not closest to each other!')
            return
        end
    end

    if not jailType then
        jailType = 'jail'
    else
        jailType = 'coms'
        emulatorName = 'COMMUNITY SERVICE'
    end

    if resourceName == 'identifier' then
        if Config.Framework == Framework.ESX then
            local Player = Framework.object.GetPlayerFromIdentifier(target)

            if Player then
                target = Player.source
            end
        elseif Config.Framework == Framework.QBCore then
            local Player = Framework.object.Functions.GetPlayerByCitizenId(target)

            if Player then
                target = Player.PlayerData.source
            end
        end
    end

    if target and GetPlayerPed(target) then
        if jailTime and jailTime > 0 then
            if resourceName and resourceName ~= 'identifier' then
                provideDebugEmulator(emulatorName, resourceName, playerId, jailType)
            end

            if jailType == 'jail' then
                PrisonService.JailCitizen(playerId, target, jailTime, '')
            elseif jailType == 'coms' then
                COMSService.StartPerollForCitizen(playerId, target, jailTime)
            end
        end
    else
        Framework.sendNotification(source, _U('GENERAL.TARGET_PLAYER_IS_OFFLINE'), 'error')
    end
end
