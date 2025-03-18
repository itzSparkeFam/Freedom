local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_qb-houses_%s'):format(exportName), function(setCB)
        if not warned then
            Warning('Please update your exports to qs-housing. Do not use qb-houses exports anymore.')
            Warning('Please update your exports to qs-housing. Do not use qb-houses exports anymore.')
            Warning('Please update your exports to qs-housing. Do not use qb-houses exports anymore.')
            warned = true
        end
        setCB(func)
    end)
end

exportHandler('hasKey', function(identifier, cid, house)
    return CheckHasKey(identifier, cid, house)
end)
