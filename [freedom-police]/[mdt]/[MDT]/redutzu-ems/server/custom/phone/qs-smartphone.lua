if Config.Phone ~= 'qs-smartphone' then
    return
end

debugPrint('Phone script is set to: qs-smartphone')

function Framework.GetPhoneNumber(source)
    local phone = exports['qs-base']:GetPlayerPhone(source)
    return phone
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)
    local phone = Framework.GetPhoneNumber(source)
    return phone
end