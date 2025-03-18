if Config.Phone ~= 'roadphone' then
    return
end

debugPrint('Phone script is set to: roadphone')

function Framework.GetPhoneNumberByIdentifier(identifier)
    local phone = exports['roadphone']:getNumberFromIdentifier(identifier)
    return phone
end

function Framework.GetPhoneNumber(source)
    local identifier = Framework.GetPlayerIdentifier(source)
    local phone = Framework.GetPhoneNumberByIdentifier(identifier)
    return phone
end