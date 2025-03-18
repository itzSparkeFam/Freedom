if Config.Phone ~= 'default' then
    return
end

function GetPlayerPhone(source)
    local player = GetPlayerFromId(source)

    if Config.Framework == 'qb' then
        return player.PlayerData.charinfo.phone
    end

    local identifier = player.identifier
    local result = MySQL.Sync.fetchAll('SELECT phone_number FROM users WHERE identifier = ?', {
        identifier
    })

    if not result[1] then
        print('Your phone is nil')
        return ''
    end
    return result[1].phone_number
end
