if Config.Inventory ~= 'qs-inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    Debug('uniq', uniq)
    uniq = uniq:gsub('-', '_')
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', uniq, data)
    TriggerEvent('inventory:client:SetCurrentStash', uniq)
end
