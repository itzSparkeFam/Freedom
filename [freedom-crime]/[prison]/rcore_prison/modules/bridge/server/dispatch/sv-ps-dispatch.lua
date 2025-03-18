CreateThread(function()
    if Config.Dispatches == Dispatches.PS then
        Dispatch.Breakout = function(playerId)
            local text = _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE')
            local coords = vec3(SH.data.prisonYard.x, SH.data.prisonYard.y, SH.data.prisonYard.z)
            local data = {
                message = text,
                codeName = 'NONE',
                code = '10-64',
                displayCode = '10-64',
                icon = 'fas fa-question',
                priority = 1,
                coords = coords,
                origin = coords,
                job = 'police',
                jobList = Config.Escape.NotifyJobs,
                recipientList = Config.Escape.NotifyJobs,
                jobs = Config.Escape.NotifyJobs,
                description = text,
                alert = {
                    jobList = Config.Escape.NotifyJobs,
                    recipientList = Config.Escape.NotifyJobs,
                    jobs = Config.Escape.NotifyJobs,
                    description = text,
                    displayCode = '10-64',
                    sprite = 488, 
                    colour = 1, 
                    scale = 1.5,
                    text = _U('DISPATCH.BREAKOUT_BLIP_TEXT'),
                    radius = 0,
                    length = 2,
                    sound = "Lose_1st",
                    sound2 = "GTAO_FM_Events_Soundset",
                    offset = "false",
                    blipLength = 10,
                    flash = true, 
                    alert = {
                        sprite = 488, 
                        colour = 1, 
                        scale = 1.5,
                    }
                }
            }

            if isResourceLoaded(THIRD_PARTY_RESOURCE.QF_MDT) then
                TriggerEvent('ps-dispatch:server:notify', data)
            end
            
            dbg.info('Dispatch.Breakout: Prison break started!')


            if doesExportExistInResource(Dispatches.PS, "CreateDispatchCall") then
                exports[Dispatches.PS]:CreateDispatchCall(data, playerId)
            else
                dbg.info('Dispatch.Breakout: Loading dispatch.')
                TriggerClientEvent('rcore_prison:client:setDispatch', playerId, data)
            end

            if isResourceLoaded(THIRD_PARTY_RESOURCE.REDUTZU) then
                TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
                    code = '10-64',
                    title = text,
                    duration = 12 * 1000,
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                })
            end
        end
    end
end, "sv-ps-dispatch code name: Phoenix")
