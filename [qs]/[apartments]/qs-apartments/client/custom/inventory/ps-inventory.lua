if Config.Inventory ~= 'ps-inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment

    uniq = uniq or house
    uniq = uniq:gsub('-', '_')

    TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', uniq, data)

    TriggerEvent('ps-inventory:client:SetCurrentStash', uniq)
end

RegisterNetEvent('ps-inventory:client:SetCurrentStash', function(stash)
    CurrentStash = stash
end)
