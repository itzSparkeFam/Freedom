if Config.Dispatch ~= 'qs-dispatch' then
    return
end

function AlarmDispatch()
    local house = CurrentHouse
    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    exports['qs-dispatch']:getSSURL(function(image)
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police', 'sheriff', 'security' },
            callLocation = playerData.coords,
            callCode = { code = 'Alarm triggered', snippet = 'House Alarm' },
            message = " House: " .. house .. " street_1: " .. playerData.street_1 .. " street_2: " .. playerData.street_2 .. " Occupant: " .. playerData.name .. " Alarm Type: House Alarm",
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 488,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'House Alarm Triggered',
                time = (20 * 1000), --20 secs
            },
            otherData = {
                {
                    text = 'Alarm triggered in residence', -- texto del dato adicional (puede haber más de uno)
                    icon = 'fas fa-home', -- ícono de Font Awesome https://fontawesome.com/icons/
                }
              }
        })
    end)
end

function SensorDispatch()
    local house = CurrentHouse
    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    exports['qs-dispatch']:getSSURL(function(image)
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police', 'sheriff', 'security' },
            callLocation = playerData.coords,
            callCode = { code = 'Sensor Activated', snippet = 'House Sensor' },
            message = " House: " .. house .. " street_1: " .. playerData.street_1 .. " street_2: " .. playerData.street_2 .. " Occupant: " .. playerData.name .. " Sensor Type: Motion Sensor Activated",
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 488,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'Motion Sensor Activated',
                time = (20 * 1000), --20 secs
            },
            otherData = {
                {
                    text = 'Motion detected in residence', -- texto del dato adicional (puede haber más de uno)
                    icon = 'fas fa-eye', -- ícono de Font Awesome https://fontawesome.com/icons/
                }
              }
        })
    end)
end
