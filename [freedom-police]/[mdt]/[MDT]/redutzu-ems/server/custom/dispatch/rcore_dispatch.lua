if Config.Dispatch.Script ~= 'rcore_dispatch' then
    return
end

RegisterNetEvent('rcore_dispatch:server:sendAlert', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
            code = data.code,
            title = data.text,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = { x = data.coords.x, y = data.coords.y, z = data.coords.z }
        })
    end
end)