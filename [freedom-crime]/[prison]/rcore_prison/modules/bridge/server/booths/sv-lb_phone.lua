CreateThread(function()
    if Config.Phones == Phones.LB then

        -- THIS EVENT IS NOT USED - MIGHT COME IN FUTURE

        RegisterNetEvent('phone:phone:call', function(data)
            if not data then
                return
            end
            local playerId = source
            local targetNumber = tonumber(data.number)
        
            if not targetNumber then
                return
            end
        
            local booth = BoothService.GetBooth(targetNumber)
        
            if not booth then
                return
            end
        
            local state, statusCode, boothPlayerId = BoothService.CanCall(targetNumber)
        
            if state then
                local number = exports[Phones.LB]:GetEquippedPhoneNumber(playerId)
                local callId = exports[Phones.LB]:CreateCall({
                    phoneNumber = tostring(targetNumber),
                    source = boothPlayerId
                }, number, {
                    requirePhone = false,
                    hideNumber = true
                })
        
                booth.state = CALL_ENUMS.IN_CALL
                booth.callData = {
                    callId = callId,
                    targetPlayerId = boothPlayerId,
                    initiatorPlayerId = playerId
                }
        
                StartClient(boothPlayerId, 'startCall')
        
                dbg.debug('%s: %s (%s) called from %s to prisoner at booth %s (%s)', 'phone:phone:call', playerId, GetPlayerName(playerId), number, boothPlayerId, GetPlayerName(boothPlayerId))
            else
                dbg.debug('%s: Call to booth state failed: %s', 'phone:phone:call', statusCode)
            end
        end)
        
        AddEventHandler('rcore_prison:server:booth:HeartBeat', function(action, data, cb)
            local playerId = nil
            local targetPlayerId = nil
            local targetNumber = nil
            local boothNumber = nil
        
            if data then
                playerId = data.initiatorPlayerId
                targetPlayerId = data.targetPlayerId
                targetNumber = data.targetNumber
                boothNumber = data.boothNumber
            end 
        
            if action == 'BOOTH_LEAVE' then
                local inCall = exports[Phones.LB]:IsInCall(playerId)
        
                if inCall then
                    exports[Phones.LB]:EndCall(playerId)
                    dbg.debug('%s | %s: %s (%s) ended call with %s (%s)', 'rcore_prison:server:booth:HeartBeat', 'BOOTH_LEAVE', playerId, GetPlayerName(playerId), targetPlayerId, GetPlayerName(targetPlayerId))
                end

                StartClient(playerId, "EndCallAtBooth")
        
                cb(true)
            elseif action == 'BOOTH_START_CALL' then
                local booth = BoothService.GetBooth(boothNumber)

                if not booth then
                    return cb(false)
                end
        
                local targetPlayerId = exports[Phones.LB]:GetSourceFromNumber(targetNumber)
                local inCall = exports[Phones.LB]:IsInCall(playerId)
        
                if inCall then
                    exports[Phones.LB]:EndCall(playerId)
                end
        
                Wait(0)
        
                local number = exports[Phones.LB]:GetEquippedPhoneNumber(targetPlayerId)
                
                if not number or not targetPlayerId then
                    cb(false)
                    return
                end

                local callId = exports[Phones.LB]:CreateCall({
                    phoneNumber = tostring(targetNumber),
                    source = playerId
                }, number, {
                    requirePhone = false,
                    hideNumber = true
                })
        
                booth.state = CALL_ENUMS.IN_CALL
                booth.callData = {
                    callId = callId,
                    targetPlayerId = targetPlayerId,
                    initiatorPlayerId = playerId
                }
        
                dbg.debug('%s | %s: %s (%s) started call from prisoner at booth to (%s) number', 'rcore_prison:server:booth:HeartBeat', 'BOOTH_START_CALL', playerId, GetPlayerName(playerId), number)
        
                cb(true)
            else
                cb(true)
            end
        end)
    end
end, "sv-lb_phone code name: Phoenix")
