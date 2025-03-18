if Config.Phone ~= 'npwd' then
    return
end

debugPrint('Phone script is set to: NPWD')

function Framework.GetPhoneNumber(source)
    local identifier = Framework.GetPlayerIdentifier(source)
    return Framework.GetPhoneNumberByIdentifier(identifier)
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    local playerData = exports['npwd']:getPlayerData({
        identifier = identifier
    })

    return playerData?.phoneNumber
end