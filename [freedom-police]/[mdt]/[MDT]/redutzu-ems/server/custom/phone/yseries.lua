if Config.Phone ~= 'yseries' then
    return
end

debugPrint('Phone script is set to: yseries')

function Framework.GetPhoneNumber(source)
    return exports['yseries']:GetPhoneNumberBySourceId(source)
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    return exports['yseries']:GetPhoneNumberByIdentifier(identifier)
end