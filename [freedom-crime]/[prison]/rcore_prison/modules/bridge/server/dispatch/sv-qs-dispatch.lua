CreateThread(function()
    if Config.Dispatches == Dispatches.QS then
        Dispatch.Breakout = function(playerId)
            local text = _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE')
            local coords = vec3(SH.data.prisonYard.x,SH.data.prisonYard.y, SH.data.prisonYard.z)
            local data = {
                job = Config.Escape.NotifyJobs,
                callLocation = coords,
                callCode = { code = '<10-64>', snippet = '<10-64>' },
                message = text,
                flashes = true, -- You can set to true if you need call flashing sirens...
                image = "https://rco.re/product/prison/rcore_dispatch_preview.png",
                blip = {
                    sprite = 488, --blip sprite
                    scale = 1.5, -- blip scale
                    colour = 1, -- blip colour
                    flashes = true, -- blip flashes
                    text = _U('DISPATCH.BREAKOUT_BLIP_TEXT'),
                    time = (20 * 1000), --blip fadeout time (1 * 60000) = 1 minute
                },
            }

            if isResourceLoaded(THIRD_PARTY_RESOURCE.REDUTZU) then
                TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
                    code = '10-64',
                    title = text,
                    duration = 12 * 1000,
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                })
            end

            TriggerEvent('qs-dispatch:server:CreateDispatchCall', data)

            dbg.info('Dispatch.Breakout: Prison break started!')
        end
    end
end, "sv-qs-dispatch code name: Phoenix")