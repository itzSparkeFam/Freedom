if Config.Framework ~= 'qb-core' and Config.Framework ~= 'qbox' and Config.Framework ~= 'esx' then
    return
end

function GetOfflinePlayerItems(identifier)
    local inventory = MySQL.Sync.fetchScalar((
        'SELECT inventory FROM %s WHERE %s = ?'
    ):format(citizens.table, citizens.identifier), { identifier })

    return json.decode(inventory)
end