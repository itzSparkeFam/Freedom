if Config.Evidence ~= 'custom' then
    return
end

---Searches for evidences from the archive
---@param query string
---@return [{ id: number }, ...]
function SearchArchiveEvidence(query)
    return {}
end

RegisterNetEvent('redutzu-mdt:server:openArchiveEvidence', function(id)
    -- TriggerClientEvent('open-evidence', source, id)
end)