CreateThread(function()
    if Config.Dispatches == Dispatches.CORE then
        Dispatch.Breakout = function(playerId)
            local text = _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE')
            local coords = vec3(SH.data.prisonYard.x,SH.data.prisonYard.y, SH.data.prisonYard.z)
            local data = {
                message = text,     
                coords = coords,
                job = Config.Escape.NotifyJobs[0],
                cooldown = 5000,
                sprite = 488, 
                color = 1,
                priority = true
            }

            if isResourceLoaded(THIRD_PARTY_RESOURCE.REDUTZU) then
                TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
                    code = '10-64',
                    title = text,
                    duration = 12 * 1000,
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                })
            end

            TriggerClientEvent('rcore_prison:client:setDispatch', playerId, data)

            dbg.info('Dispatch.Breakout: Prison break started!')
        end
    end
end, "sv-core code name: Phoenix")



