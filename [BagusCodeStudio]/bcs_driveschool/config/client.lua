return {
    ---@type function
    ---@param title string
    ---@param message string
    ---@param type string
    ---@param duration number
    notify = function(title, message, type, duration)
        lib.notify({
            title = title,
            description = message,
            type = type,
            duration = duration,
            position = 'top'
        })
    end,

    ---@type Location
    location = {
        coords = vec4(838.0568, -1395.9075, 26.3134, 358.0418)
    },

    ---@type TrackSetting
    track = {
        model = 'prop_mp_cone_02',
        disableCollision = false
    },

    ---@type BlipSettings
    blipPoint = {
        enable = true, -- Enable/Disable blips
        show = 3,      -- Blip showing on the map
        settings = {
            sprite = 1,
            scale = 1.0,
            colour = 3
        }
    },

    blipSchool = {
        enable = true,
        settings = {
            sprite = 408,
            scale = 1.0,
            colour = 4
        }
    },

    ---@type boolean
    backLastPoint = false, -- Return to last point when error point is reached

    ---@type number
    waitDistance = 10.0, -- Wait distance between waiting list

    ---@type number
    waitNotify = 5, -- how many times to notify

    ---@type number
    waitNotifyInterval = 5000, -- Wait notification interval

    giveKey = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        if GetResourceState('qb-vehiclekeys') == 'started' then
            TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
        elseif GetResourceState('Renewed-Vehiclekeys') == 'started' then
            exports['Renewed-Vehiclekeys']:addKey(plate)
        elseif GetResourceState('dusa_vehiclekeys') == 'started' then
            exports['dusa_vehiclekeys']:AddKey(plate)
        elseif GetResourceState('MrNewbVehicleKeys') == 'started' then
            exports.MrNewbVehicleKeys:GiveKeys(vehicle)
        end
    end,

    setFuel = function(vehicle)
        if GetResourceState('ox_fuel') == 'started' then
            Entity(vehicle).state.fuel = 100
        elseif GetResourceState('LegacyFuel') == 'started' then
            exports["LegacyFuel"]:SetFuel(vehicle, 100)
        elseif GetResourceState('TAM_Fuel') == 'started' then
            Entity(vehicleId).state.fuelLevel = 100
        end
    end
}
