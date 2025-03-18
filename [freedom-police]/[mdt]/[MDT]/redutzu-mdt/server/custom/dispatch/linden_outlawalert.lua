if Config.Dispatch.Script ~= 'linden_outlawalert' then
    return
end

RegisterNetEvent('wf-alerts:svNotify', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
            code = data.code,
            title = data.dispatchMessage,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = data.coords
        })
    end
end)