if Config.Phone ~= 'lb-phone' then
    return
end

debugPrint('Phone script is set to: lb-phone')

function Framework.GetPhoneNumberByIdentifier(identifier)
    return exports['lb-phone']:GetEquippedPhoneNumber(identifier)
end

function Framework.GetPhoneNumber(source)
    local identifier = Framework.GetPlayerIdentifier(source)
    local phone = Framework.GetPhoneNumberByIdentifier(identifier)
    return phone
end