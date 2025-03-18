CreateThread(function()
    if Config.Dispatches == Dispatches.NONE then
        if isResourceLoaded('sonorancad') and isResourceLoaded('sonoran_callcommands') then
            RegisterNetEvent('rcore_prison:client:setDispatch', function(payload)
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                local street1 = GetStreetNameFromHashKey(s1)
                local street2 = GetStreetNameFromHashKey(s2)
                local streetLabel = street1

                if street2 ~= nil then
                    streetLabel = streetLabel .. ' ' .. street2
                end
        
                TriggerServerEvent('SonoranCAD::callcommands:SendCallApi', true, 'Prison Guard', streetLabel, _U('DISPATCH.BREAKOUT_ACTIVE_MESSAGE'), GetPlayerServerId(PlayerId()), nil, nil, '911')
            end) 
        end
    end
end, "cl-sonoran-cad code name: Phoenix")



