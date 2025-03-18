if Config.Prison ~= 'rcore_prison' then
    return
end

-- We collaborated with the RCore Team and made an export for offline jailing (in a future update, we will keep this until they release the export)
function JailOfflinePlayer(identifier, amount)
    local jail_time = os.date('%Y-%m-%d %H:%M:%S', os.time() + (amount * 60))

    MySQL.Async.insert('INSERT INTO rcore_prison(owner, jail_time, data) VALUES(:owner, :jail_time, :data)', {
        owner = identifier,
        jail_time = jail_time,
        data = json.encode({
            jail_reason = 'Charge issued using the MDT',
            jail_time = amount * 60,
            state = 'jailed'
        })
    })
end

function JailPlayer(identifier, amount)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if not source then
        JailOfflinePlayer(identifier, amount)
        return
    end

    exports['rcore_prison']:Jail(source, amount, 'Charge issued using the MDT')
end