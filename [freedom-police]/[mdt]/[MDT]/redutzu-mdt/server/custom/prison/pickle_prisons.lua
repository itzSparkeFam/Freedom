if Config.Prison ~= 'pickle_prisons' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    Config.Prison = 'default'
    debugPrint('This prison script is only available on QBCore and ESX')
else
    debugPrint('Prison script is set to: pickle_prisons')
end

function JailOfflinePlayer(identifier, amount)
    local inventory = GetOfflinePlayerItems(identifier)

    MySQL.Async.execute('INSERT INTO pickle_prisons (identifier, prison, time, inventory, sentence_date) VALUES (:identifier, :prison, :time, :inventory, :sentence_date)', {
        identifier = identifier,
        prison = 'default',
        time = amount,
        inventory = json.encode(inventory),
        sentence_date = os.time()
    })
end

function JailPlayer(identifier, amount)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if not source then
        JailOfflinePlayer(identifier, amount)
        return
    end

    exports['pickle_prisons']:JailPlayer(source, amount, 'default') -- There is no export?
end