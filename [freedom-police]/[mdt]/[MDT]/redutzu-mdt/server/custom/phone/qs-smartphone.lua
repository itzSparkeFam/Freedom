if Config.Phone ~= 'qs-smartphone' then
    return
end

debugPrint('Phone script is set to: qs-smartphone')

function Framework.GetPhoneNumber(source)
    if Config.Framework == 'qb' then
        local player = Framework.GetPlayerData(source)
        return player?.PlayerData?.charinfo?.phone
    end
    
    local phone = exports['qs-base']:GetPlayerPhone(source)
    return phone
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)
    local phone = Framework.GetPhoneNumber(source)
    return phone
end