if Config.Phone ~= 'qs-smartphone-pro' then
    return
end

debugPrint('Phone script is set to: qs-smartphone-pro')

function Framework.GetPhoneNumberByIdentifier(identifier)
    return exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false)
end

function Framework.GetPhoneNumber(source)
    local identifier = Framework.GetPlayerIdentifier(source)
    local phone = Framework.GetPhoneNumberByIdentifier(identifier)
    return phone
end