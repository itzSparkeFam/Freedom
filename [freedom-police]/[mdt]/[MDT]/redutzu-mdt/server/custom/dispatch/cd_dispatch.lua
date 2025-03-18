if Config.Dispatch.Script ~= 'cd_dispatch' then
    return
end

RegisterNetEvent('cd_dispatch:AddNotification', function(data)
    local isWhitelisted = isJobWhitelisted(data.job_table)

    if isWhitelisted then
        local code, title = data.title:match("^(%d+%-?%d*)%s%-%s(.+)$")
        
        TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
            code = code or '11-99',
            title = title or data.title,
            duration = Config.Dispatch.DefaultAlertDuration,
            coords = data.coords
        })
    end
end)