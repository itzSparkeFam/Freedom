if Config.Dispatch.Script ~= 'redutzu-mdt' then
    return
end

RegisterNetEvent('redutzu-mdt:client:addDispatchCall', function(data)
    TriggerEvent('redutzu-ems:client:addDispatchToEMS', data)
end)