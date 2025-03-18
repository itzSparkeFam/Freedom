CreateThread(function()
    if Config.Dispatches == Dispatches.NONE then
        Dispatch.Breakout = function(playerId)
            local retval, data = Framework.getOfficers()
            local text = _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE')
            local coords = vec3(SH.data.prisonYard.x, SH.data.prisonYard.y, SH.data.prisonYard.z)
    
            if isResourcePresentProvideless(THIRD_PARTY_RESOURCE.WASABI_POLICE) then
                if data and next(data) then
                    for _, playerId in pairs(data) do
                        if playerId then
                            Framework.sendNotification(playerId, _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE'), 'info') 
                        end
                    end
                end
            else
                if type(retval) ~= "table" then
                    return
                end
                
                if retval and next(retval) then
                    for _, playerId in pairs(retval) do
                        if playerId then
                            Framework.sendNotification(playerId, _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE'), 'info') 
                        end
                    end
                end
            end        

            if isResourceLoaded('sonorancad') and isResourceLoaded('sonoran_callcommands') then
                TriggerClientEvent('rcore_prison:client:setDispatch', playerId)
            end

            if isResourceLoaded(THIRD_PARTY_RESOURCE.REDUTZU) then
                TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
                    code = '10-64',
                    title = text,
                    duration = 12 * 1000,
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                })
            end

            dbg.info('Dispatch.Breakout: This will be shown to all players, adjust it to your needs.')
        end
    end
end, "sv-standalone code name: Phoenix")
