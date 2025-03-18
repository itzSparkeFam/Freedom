if Config.Dispatch.Script ~= 'default' then
    return
end

function onShooting(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local weapon = GetWeaponName()
    local gender = Framework.GetPlayerGender()

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'shooting',
        coords = coords,
        street = street,
        weapon = weapon,
        gender = gender
    })
end

function onDriveBy(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local weapon = GetWeaponName()
    local gender = Framework.GetPlayerGender()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local data = GetVehicleInfo(vehicle)

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'driveby',
        coords = coords,
        street = street,
        weapon = weapon,
        gender = gender,
        vehicle = data
    })
end

function onCarJack(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local gender = Framework.GetPlayerGender()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        vehicle = GetVehiclePedIsEntering(ped)
    end

    local data = GetVehicleInfo(vehicle)

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'car_jack',
        coords = coords,
        street = street,
        gender = gender,
        vehicle = data
    })
end

function onDeath(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local gender = Framework.GetPlayerGender()

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'player_dead',
        coords = coords,
        street = street,
        gender = gender,
        duration = 10000
    })
end

function onCombat(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local gender = Framework.GetPlayerGender()

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'combat',
        coords = coords,
        street = street,
        gender = gender
    })
end

function onExplosion(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local gender = Framework.GetPlayerGender()
    
    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'explosion',
        coords = coords,
        street = street,
        gender = gender
    })
end

function onSpeeding(ped)
    local coords = GetEntityCoords(ped)
    local street = GetStreetNameFromCoords(coords)
    local gender = Framework.GetPlayerGender()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local data = GetVehicleInfo(vehicle)

    TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
        code = 'speeding',
        coords = coords,
        street = street,
        gender = gender,
        vehicle = data
    })
end