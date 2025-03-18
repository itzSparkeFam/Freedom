if Config.Dispatch.Script ~= 'qs-dispatch' then
    return
end

RegisterNetEvent('qs-dispatch:server:CreateDispatchCall', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
            code = data.callCode.snippet,
            title = data.callCode.code,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = data.callLocation
        })
    end
end)