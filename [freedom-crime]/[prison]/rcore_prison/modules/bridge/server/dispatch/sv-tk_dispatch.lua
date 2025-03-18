CreateThread(function()
    if Config.Dispatches == Dispatches.TK then
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

            exports.tk_dispatch:addCall({
                title = 'Prison break',
                code = '10-64',
                coords = coords,
                message = text,
                flash = true,
                jobs = Config.Escape.NotifyJobs,
                blip = {
                    sprite = 488, 
                    colour = 1, 
                    scale = 1.5,
                    display = true, 
                    shortRange = false,
                    radius = 0,
                }
            })
        end
    end
end, "sv-tk_dispatch code name: Phoenix")


