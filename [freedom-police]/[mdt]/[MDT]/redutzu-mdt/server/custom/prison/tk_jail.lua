if Config.Prison ~= 'tk_jail' then
    return
end

function JailOfflinePlayer(identifier, amount)
    local items = GetOfflinePlayerItems(identifier)

    MySQL.Async.execute('UPDATE ' .. citizens.table .. ' SET jail_time = :time, jail_type = :type, jail_items = :items WHERE ' .. citizens.identifier .. ' = :identifier', {
        identifier = identifier,
        time = amount,
        type = 'jail',
        items = json.encode(items)
    })
end

function JailPlayer(identifier, amount)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if not source then
        JailOfflinePlayer(identifier, amount)
        return
    end

    exports['tk_jail']:jail(source, amount) 
end