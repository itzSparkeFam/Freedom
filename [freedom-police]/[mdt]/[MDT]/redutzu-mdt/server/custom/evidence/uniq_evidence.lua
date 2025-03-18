if Config.Evidence ~= 'uniq_evidence' then
    return
end

function SearchArchiveEvidence(query)
    local results = MySQL.Sync.fetchAll('SELECT caseId AS id FROM uniq_evidence WHERE caseId LIKE ?', { '%' .. query .. '%' })
    return results
end

RegisterNetEvent('redutzu-mdt:server:openArchiveEvidence', function(id)
    exports['uniq_evidence']:OpenCaseByID(id)
end)