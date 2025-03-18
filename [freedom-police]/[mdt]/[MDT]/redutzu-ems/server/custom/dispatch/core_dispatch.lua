if Config.Dispatch.Script ~= 'core_dispatch' then
    return
end

RegisterNetEvent('core_dispatch:server:sendAlert', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
            code = data.code,
            title = data.message,
            duration = data.time,
            coords = { x = data.coords[1], y = data.coords[2], z = data.coords[3] }
        })
    end
end)