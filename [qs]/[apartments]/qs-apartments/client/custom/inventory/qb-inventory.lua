if Config.Inventory ~= 'qb-inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    -- if you use old qb-inventory version, uncomment here and remove 'housing:OpenStash' trigger.
    -- TriggerServerEvent('inventory:server:OpenInventory', 'stash', uniq, data)
    -- TriggerEvent('inventory:client:SetCurrentStash', uniq)
    TriggerServerEvent('housing:OpenStash', uniq, data)
end
