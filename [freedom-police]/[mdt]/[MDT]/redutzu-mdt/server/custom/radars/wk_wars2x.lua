if Config.Radar ~= 'wk_wars2x' then
    return
end

local function parseTimestamp(formatString)
    local pattern = '(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)'
    local year, month, day, hour, min, sec = formatString:match(pattern)
    return os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec),
    })
end

local function isBoloActive(activeUntil)
    local boloDateParsed = parseTimestamp(activeUntil)
    return os.time() < boloDateParsed
end

RegisterNetEvent('wk:onPlateScanned', function(camera, plate)
    local playerSource = source
    local vehicle = exports['redutzu-mdt']:SearchVehicle(plate)

    if not vehicle then
        return
    end
    
    for _, bolo in ipairs(vehicle.bolos) do
        local boloData = exports['redutzu-mdt']:SearchBolo(bolo.id)

        if boloData and isBoloActive(boloData.date) then
            Framework.Notify(playerSource, ('Vehicle with plate number %s has an active bolo'):format(plate), 'info')
            break
        end
    end
end)