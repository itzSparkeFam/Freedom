if Config.Evidence ~= 'wasabi_evidence' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    Config.Evidence = 'default'
    debugPrint('This evidence script (wasabi_evidence) is only available on QBCore and ESX')
else
    debugPrint('Evidence script is set to: wasabi_evidence')
end

function SearchArchiveEvidence(query)
    -- You can remove the last condition if you don't want to search for evidences by citizen
    local results = MySQL.Sync.fetchAll("SELECT id FROM wasabi_evidence WHERE id LIKE :query OR JSON_VALUE(data, '$.owner') LIKE :query", {
        query = '%' .. query .. '%'
    })

    return results
end

RegisterNetEvent('redutzu-mdt:server:openArchiveEvidence', function(id)
    -- TriggerClientEvent('open-evidence', source, id)
end)