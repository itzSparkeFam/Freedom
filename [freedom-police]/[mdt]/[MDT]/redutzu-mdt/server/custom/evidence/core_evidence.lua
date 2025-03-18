if Config.Evidence ~= 'core_evidence' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    Config.Evidence = 'default'
    debugPrint('This evidence script (core_evidence) is only available on QBCore and ESX')
else
    debugPrint('Evidence script is set to: core_evidence')
end

function SearchArchiveEvidence(query)
    local results = MySQL.Sync.fetchAll('SELECT id FROM evidence_storage WHERE id LIKE ?', { '%' .. query .. '%' })
    return results
end

-- We collaborated with the C8re Team and made an event for opening the evidence, make sure
-- you have the latest version of core_evidence
RegisterNetEvent('redutzu-mdt:server:openArchiveEvidence', function(id)
    TriggerClientEvent('core_evidence:client:showReport', source, id)
end)