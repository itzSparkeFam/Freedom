if Config.Dispatch.Script ~= 'ps-dispatch' then
    return
end

RegisterNetEvent('ps-dispatch:server:notify', function(data)
    if table.includes(data.jobs, 'ems') then
        TriggerEvent('redutzu-ems:server:addDispatchToEMS', {
            code = data.code,
            title = data.message,
            duration = Config.Dispatch.DefaultAlertDuration,
            street = data.street,
            weapon = data.weapon,
            gender = data.gender,
            coords = { x = data.coords.x, y = data.coords.y, z = data.coords.z },
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