if Config.Phone ~= 'okokPhone' then
    return
end

debugPrint('Phone script is set to: okokPhone')

function Framework.GetPhoneNumber(source)
    local phone = exports['okokPhone']:getPhoneNumberFromSource(source)
    return phone
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)
    local phone = Framework.GetPhoneNumber(source)
    return phone
end