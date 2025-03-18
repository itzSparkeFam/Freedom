local stateCommands = Config.StateCommands
local enforce = false

if not stateCommands or (type(stateCommands) == "table" and not next(stateCommands)) then
    enforce = true
    dbg.critical("Failed to load Config.StateCommands, seems not defined enforcing all commands be useable!")
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.JailCP] or enforce then
    RegisterCommand(Config.Commands.JailCP, function(source, args, rawCommand)
        local playerId = source
    
        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.JailCP)
    
        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
    
        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, 'Resource being loaded, please wait 10sec!', 'error')
            return
        end

        local state = CheckRestrictionZone(playerId, Config.Commands.JailCP)
    
        if state then
            StartClient(playerId, 'openMDW', true)
        end
    end, false)        
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.StopAlarm] or enforce then
    RegisterCommand(Config.Commands.StopAlarm, function(source, args, rawCommand)
        local playerId = source


        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.StopAlarm)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        StartClient(-1, 'setAlarm', false)
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.Startcs] or enforce then
    RegisterCommand(Config.Commands.Startcs, function(source, args, rawCommand)
        local playerId = source

        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.Startcs)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end

        
        local targetPlayerId = GetPlayerByIdOrName(args[1])
        local perolAmount = tonumber(args[2])
        local reason = args[3] and tostring(args[3]) or 'none'

        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end

        if not perolAmount then
            dbg.info("Cannot parse peroll time %s", args[2])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME'), 'error')
            return
        end

        if PrisonService.CheckForAnySentence(targetPlayerId) then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.PLAYER_ALREADY_HAS_SENTENCE'), 'error')
            return
        end

        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        if perolAmount <= 0 then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME_VALUE'), 'error')
            return
        end

        if Config.RestrictCommandsForDistance then
            local mePed = GetPlayerPed(playerId)
            local targetPed = GetPlayerPed(targetPlayerId)

            local meCoords = GetEntityCoords(mePed)
            local targetCoords = GetEntityCoords(targetPed)

            local distance = #(meCoords - targetCoords)

            if distance > Config.RestrictDistance then
                Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.TOO_FAR_AWAY'), 'error')
                return
            end
        end


        COMSService.StartPerollForCitizen(playerId, targetPlayerId, perolAmount, reason)
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.Jail] or enforce then

    RegisterCommand(Config.Commands.Jail, function(source, args, rawCommand)
        local playerId = source

        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.Jail)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        local targetPlayerId = GetPlayerByIdOrName(args[1])
        local jailTime = tonumber(args[2])
        local reason = args[3] and tostring(args[3]) or 'none'

        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end

        if not jailTime then
            dbg.info("Cannot parse jail time %s", args[2])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME'), 'error')
            return
        end
        
        if COMSService.CheckForAnySentence(targetPlayerId) then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.PLAYER_ALREADY_HAS_SENTENCE'), 'error')
            return
        end

        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        if jailTime <= 0 then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME_VALUE'), 'error')
            return
        end

        if Config.RestrictCommandsForDistance then
            local mePed = GetPlayerPed(playerId)
            local targetPed = GetPlayerPed(targetPlayerId)

            local meCoords = GetEntityCoords(mePed)
            local targetCoords = GetEntityCoords(targetPed)

            local distance = #(meCoords - targetCoords)

            if distance > Config.RestrictDistance then
                Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.TOO_FAR_AWAY'), 'error')
                return
            end
        end
        
        local state = CheckRestrictionZone(playerId, Config.Commands.Jail)
    
        if state then
            PrisonService.JailCitizen(playerId, targetPlayerId, jailTime, reason)
        end
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.Unjail] or enforce then
    RegisterCommand(Config.Commands.Unjail, function(source, args, rawCommand)
        local playerId = source

        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.Unjail)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        local targetPlayerId = GetPlayerByIdOrName(args[1])

        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end

        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        if Config.RestrictCommandsForDistance then
            local mePed = GetPlayerPed(playerId)
            local targetPed = GetPlayerPed(targetPlayerId)

            local meCoords = GetEntityCoords(mePed)
            local targetCoords = GetEntityCoords(targetPed)

            local distance = #(meCoords - targetCoords)

            if distance > Config.RestrictDistance then
                Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.TOO_FAR_AWAY'), 'error')
                return
            end
        end

        local state = CheckRestrictionZone(playerId, Config.Commands.Unjail)
    
        if state then
            PrisonService.UnjailCitizen(targetPlayerId, true)
        end
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.Solitary] or enforce then
    RegisterCommand(Config.Commands.Solitary, function(source, args, rawCommand)
        local playerId = source

        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.Solitary)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        local targetPlayerId = GetPlayerByIdOrName(args[1])
        local jailTime = tonumber(args[2])

        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end

        if not jailTime then
            dbg.info("Cannot parse jail time %s", args[2])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME'), 'error')
            return
        end

        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        if jailTime <= 0 then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_JAIL_TIME_VALUE'), 'error')
            return
        end

        SolitaryService.SetPrisonerSentence(targetPlayerId, jailTime, '-', playerId)
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.RemoveSolitary] or enforce then
    RegisterCommand(Config.Commands.RemoveSolitary, function(source, args, rawCommand)
        local playerId = source

        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.RemoveSolitary)

        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        local targetPlayerId = GetPlayerByIdOrName(args[1])

        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end

        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end

        SolitaryService.ReleasePrisoner(targetPlayerId)
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.Removecs] or enforce then
    RegisterCommand(Config.Commands.Removecs, function(source, args, rawCommand)
        local playerId = source
    
        local state, reason = Framework.canPerformJobCommand(playerId, Config.Commands.Removecs)
    
        if not state then
            Framework.sendNotification(playerId, _U('PERMISSION.GENERAL_MESSAGE', reason), 'error')
            dbg.info("Cannot perform this command - you are not job member!", playerId)
            return
        end
        
        local targetPlayerId = GetPlayerByIdOrName(args[1])
    
        if not targetPlayerId then
            dbg.info("Cannot find player from value %s", args[1])
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.INVALID_PLAYER_ID'), 'error')
            return
        end
    
        if not IS_DATABASE_READY then
            Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.RESOURCE_LOADING'), 'error')
            return
        end
    
        if Config.RestrictCommandsForDistance then
            local mePed = GetPlayerPed(playerId)
            local targetPed = GetPlayerPed(targetPlayerId)
    
            local meCoords = GetEntityCoords(mePed)
            local targetCoords = GetEntityCoords(targetPed)
    
            local distance = #(meCoords - targetCoords)
    
            if distance > Config.RestrictDistance then
                Framework.sendNotification(playerId, _U('COMMANDS_MESSAGES.TOO_FAR_AWAY'), 'error')
                return
            end
        end
    
        COMSService.ReleaseUser(targetPlayerId, playerId)
    end, false)
end

if stateCommands and next(stateCommands) and stateCommands[Config.Commands.ResetPrisonBreak] or enforce then
    RegisterCommand(Config.Commands.ResetPrisonBreak, function(source, args, rawCommand)
        local playerId = source
        local isAdmin = Framework.isAdmin(playerId)
    
        if not isAdmin then
            Framework.sendNotification(playerId, _U('GENERAL.YOU_NEED_TO_BE_ADMIN'), 'error')
            dbg.info("Cannot perform this command - you are not admin!", playerId)
            return
        end
        
        PrisonBreakReset(playerId)
    end, false)    
end

function GetPlayerByIdOrName(targetPlayer)
    local targetPlayer = targetPlayer

    if isNumber(targetPlayer) and GetPlayerPed(targetPlayer) > 0 then
        return tonumber(targetPlayer)
    elseif type(targetPlayer) == 'string' then
        for _, playerId in pairs(GetPlayers()) do
            local playerName = Framework.getCharacterShortName(playerId)

            if playerName == targetPlayer then
                return playerId
            end
        end
    end
end

function GetPlayerByCharacterId(targetCharId)
    if not targetCharId then
        return
    end

    for _, playerId in pairs(GetPlayers()) do
        local playerId = tonumber(playerId)
        local charId = Framework.getIdentifier(playerId)
  
        if charId == targetCharId then
            return playerId
        end
    end
end
