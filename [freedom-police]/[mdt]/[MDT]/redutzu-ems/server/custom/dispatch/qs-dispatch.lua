if Config.Dispatch.Script ~= 'qs-dispatch' then
    return
end

RegisterNetEvent('qs-dispatch:server:CreateDispatchCall', function(data)
    local isWhitelisted = isJobWhitelisted(data.job)

    if isWhitelisted then
        TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
            code = data.callCode.snippet,
            title = data.callCode.code,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = {
                x = data.callLocation.x,
                y = data.callLocation.y,
                z = data.callLocation.z
            }
        })
    end
end)