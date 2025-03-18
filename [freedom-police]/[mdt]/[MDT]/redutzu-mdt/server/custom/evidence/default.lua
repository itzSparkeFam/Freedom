if Config.Evidence ~= 'default' then
    return
end

function SearchArchiveEvidence(query)
    if #query < 1 then
        return {}
    end

    if Config.Item.Inventory == 'ox_inventory' then
        local inventory = exports['ox_inventory']:GetInventory(('evidence-%s'):format(query), false)

        return {
            { id = (inventory.id):gsub('evidence%-', '') }
        }
    end
end

RegisterNetEvent('redutzu-mdt:server:openArchiveEvidence', function(id)
    if Config.Item.Inventory == 'ox_inventory' then
        exports['ox_inventory']:forceOpenInventory(source, 'stash', ('evidence-%s'):format(id))
    end
end)