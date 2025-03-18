if Config.Phone ~= 'gksphone' then
    return
end

debugPrint('Phone script is set to: gksphone')

function Framework.GetPhoneNumber(source)
    local phone = exports['gksphone']:GetPhoneBySource(source)
    return phone
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)
    local phone = Framework.GetPhoneNumber(source)
    return phone
end