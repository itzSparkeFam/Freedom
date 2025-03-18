if Config.Phone ~= 'high-phone' then
    return
end

debugPrint('Phone script is set to: high-phone')

function Framework.GetPhoneNumber(source)
    local phone = exports['high-phone']:getPlayerPhoneNumber(source)
    return phone
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)
    local phone = Framework.GetPhoneNumber(source)
    return phone
end