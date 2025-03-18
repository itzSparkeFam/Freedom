CreateThread(function()
    if Config.Dispatches == Dispatches.ORIGEN then
        Dispatch.Breakout = function(playerId)
            local text = _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE')
            local coords = vec3(SH.data.prisonYard.x, SH.data.prisonYard.y, SH.data.prisonYard.z)

            if isResourceLoaded(THIRD_PARTY_RESOURCE.REDUTZU) then
                TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
                    code = '10-64',
                    title = text,
                    duration = 12 * 1000,
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                })
            end

            if Config.Escape.NotifyJobs and type(Config.Escape.NotifyJobs) == "table" and next(Config.Escape.NotifyJobs) then
                for jobName, _ in pairs(Config.Escape.NotifyJobs) do
                    exports['origen_police']:SendAlert({
                        coords = coords,
                        title = 'Prison break',
                        type = 'GENERAL',
                        message = text,
                        job = jobName,
                    })
                end
            end
        end
    end
end, "sv-origen-dispatch code name: Phoenix")


