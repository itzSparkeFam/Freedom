if Config.Phone ~= 'qs-smartphone-pro' then
    return
end

function GetPlayerPhone(source)
    local identifier = GetIdentifier(source)
    return exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier)
end
