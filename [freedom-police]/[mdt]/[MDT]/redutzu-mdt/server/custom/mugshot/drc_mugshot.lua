if Config.Mugshot ~= 'drc_mugshot' then
    return
end

RegisterNetEvent('drc_mugshot:upload', function(image)
    local identifier = Framework.GetPlayerIdentifier(source)

    if image then
        exports['redutzu-mdt']:UpdateCitizen(identifier, {
            image = image    
        })
    end
end)