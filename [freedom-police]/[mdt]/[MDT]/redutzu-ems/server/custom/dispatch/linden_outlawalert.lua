if Config.Dispatch.Script ~= 'linden_outlawalert' then
    return
end

RegisterNetEvent('wf-alerts:svNotify', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
            code = data.code,
            title = data.dispatchMessage,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = { x = data.coords.x, y = data.coords.y, z = data.coords.z }
        })
    end
end)