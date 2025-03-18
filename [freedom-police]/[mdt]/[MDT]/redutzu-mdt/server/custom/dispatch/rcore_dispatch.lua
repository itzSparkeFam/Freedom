if Config.Dispatch.Script ~= 'rcore_dispatch' then
    return
end

RegisterNetEvent('rcore_dispatch:server:sendAlert', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
            code = data.code,
            title = data.text,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = data.coords
        })
    end
end)