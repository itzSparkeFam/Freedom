if Config.Dispatch.Script ~= 'ps-dispatch' then
    return
end

RegisterNetEvent('ps-dispatch:server:notify', function(data)
    if table.includes(data.jobs, 'leo') then
        TriggerEvent('redutzu-mdt:server:addDispatchToMDT', {
            code = data.code,
            title = data.message,
            duration = Config.Dispatch.DefaultAlertDuration,
            street = data.street,
            weapon = data.weapon,
            gender = data.gender,
            coords = data.coords,
            vehicle = data.vehicle and {
                name = data.vehicle,
                plate = data.plate,
                color = data.color,
                class = data.class,
                doors = data.doors
            } or nil
        })
    end
end)