CreateThread(function()
    if Config.Dispatches == Dispatches.LOVE_SCRIPTS then
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

            TriggerEvent('emergencydispatch:emergencycall:new', "police", text, coords, true)
        end
    end
end, "sv-emergency-dispatch code name: Phoenix")
